Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E725B719B23
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjFALuP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFALuN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 07:50:13 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D629129
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685620212; x=1717156212;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=FdyUnYAS4UX/cdxHQoeC0kzyMilkJeM2qBUKe6OX3lMZK3J1kkXcuPAo
   jaeuhCDhZnuq5PKRA4lMLHayO3DPwWfTTzamwSLEmFR1IYjcYVMzh/Ucm
   mdCNp7TtambdfoDEnYETYmSXHVxRqtOePSFHbuXniGqOAKwJvlguiZwSM
   TMMx42nFNkwm3l6m4b663snFIDdSDzKZOKdefchZyqTsve88Lfg2mvA6n
   qOULnef0s2MelXWIzRMLTEkixr/IzhGdcffzPz4MJ/e+5jT+wWKtG/z5G
   i3weD11i2ZELMv0VsRRV+PwR97yOf/0LcO8mYniFUINLWj9HtJfveDunf
   w==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681142400"; 
   d="scan'208";a="230301499"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 19:50:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OssBWWXw3XQ/UhVjJLLr+e/fQaSeiRLV0w9VY3z/vEkrkrpscX4IDQBAw0QgBpuTbSpnl/2Vo90zEC33mIMydm/yXFj8ySiBExMQQp8f/cJuRDISa+0DdKJGwdHhOb5wDEv7K90IihyJCPnkrRXw9EAMMMSCEaxg2TdX7IbEJwWP9LIEVIbi/10L+xZrFL7dTYbLh8NO6uN+tw05mBY4Kr87Jtu35ii6NjpPOoIk3VW/cMnN4ZGnOudX2MJQKEm5AkpCmw5MUIHnqUrtNXa8s0WsspTU8Np333AxoR9PKgWYzW29wWU71pDYsjhgEOt7pFSA/JHS1uS568WdhBaWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fWQ+fQri9j6iMYAYIm/dHAwRyZoXXoBQZrp+oqiS9TdP3ZDjEpCabbe/yDc/Qal/Wa5PYENWdhvqrqDnt+tnsnM9ZiM0sv9CH/y4wT2Kaf/e+/20gXGou3YgndmZ3D3N7nZfE2pszpaMGFm4bov29Z4h0/fNhjUWtguacz9K/w9ktL+g2XyK/kDz4460/8J4+WManfT9KXITo8Lr6oaMXEErHO9UFHxJt7C7viediRJA5XcgUzmF3YJK4P5Rj7c/3QpOCCoS03UL9i3nNFkXPZKplXR7RMqTfBoNTBu6NFrHasRPqU6RscyN356o6Fe/56k69hNuRsC9qX9FVKcchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=JaDmjhio9nwvBNpaw8MgSz0HqEV5er8Y8/mTB154LRHv8mHhmKsnBUQuvFlnydHYJf6XqQjdx49t8hkqOamxdRa9e+6vrYblwR/+FKHu550fL+ybywDlKcymh4+hFvQo7sjBqPfCWsASHDKgJcODr4F+8nQseWeWHFFiuaybIiU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7931.namprd04.prod.outlook.com (2603:10b6:208:33a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 11:50:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 11:50:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/17] btrfs: add a is_data_bbio helper
Thread-Topic: [PATCH 07/17] btrfs: add a is_data_bbio helper
Thread-Index: AQHZk5VxRoVFmt/L60q6uyFpinx5M69110CA
Date:   Thu, 1 Jun 2023 11:50:08 +0000
Message-ID: <4fca7208-a12c-d525-fbf4-4c85cc90f5d5@wdc.com>
References: <20230531075410.480499-1-hch@lst.de>
 <20230531075410.480499-8-hch@lst.de>
In-Reply-To: <20230531075410.480499-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7931:EE_
x-ms-office365-filtering-correlation-id: d56a5d62-b560-4d60-6d8f-08db62965932
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2UcW8S+erGZsFngfhxIQHzr+cFzMfMzQykkUzNt7nuZyh5xsjxaLp8zBVtaXzSIkBuJjmqIhODsSc60NbNaxcKEWwN5fIT3VDB8dbqok6qutafPnwAVuJ9Q4PxFPKSy/snPk6JYl8V7NbM/9o3rrdXTlf0X//BrQVK9Rm18xMK+ZKHDdruSSX6JSJmj0FfIG3cubhQ3KTSqMk6pLEe/Zy8LAWqs2SnKUxd0GnP2kG32IqNEQ1Dirwix3Ln4leemuafKipe71QVtXuJtqo3T6ErGvD+V8t1aKpIGWUu4+JvDq70CqcGEiI0VkPPa0z8l/ZzElx2n1ynHrqo4JZXjzc+2OUfa+LiIpFKy4OAAheyZzJoddBhm12E07oUzN6EOZQDLV1lxA3+XrpvvrhOSPb0nzhWHPuOKoExM/CpnKg4GQbMDNL8DRy0Ae9+bbWyOhn/fJTDAb9AXycgfE2SFZKkD/qPLUQTcMYfi19zu/9YSz4QtNH0rIQzSewFFZN+inxlSK9IG9Ci05RDVVIPntpFRfD/qrwrueUcdb8cx1HX1NQ2CnJbfD9vEiv4hfcAaGi0VU+azYnxpN8YTbDH7f8huaqpjucAMd6hCJ91HJ5eoW4l06ziyB8D0sN7kHobZ2CjOXT0al+3ssvT0qEWsULN53GVVrCZmizoPsxTuC3INbmMahOyySg0lILAKivMpw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(110136005)(71200400001)(31686004)(5660300002)(66556008)(19618925003)(76116006)(316002)(64756008)(66446008)(4326008)(91956017)(66946007)(66476007)(478600001)(6506007)(6512007)(2616005)(4270600006)(2906002)(8936002)(41300700001)(8676002)(186003)(122000001)(82960400001)(38070700005)(38100700002)(36756003)(6486002)(31696002)(86362001)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0NXSWNCTHZqdnJlZnp6dzJnY1dERldMMFdaYThLdXJQbkxTSm1DbkQ2bzB2?=
 =?utf-8?B?YWttZkpoSWd2aFNEZ1hGNU9MWE95bzBCMkZYSmJzdXFzSEZlMGJxTHpKYlBW?=
 =?utf-8?B?Zjl2RFNrMEt3eHRMTUt1bmVKVzJNM0FaNlhoU2N0enBjNnNUL2g4UVNFNytr?=
 =?utf-8?B?L3I0S1JBRi8rWG51enBwSW0xZlBvWHp1ZERDZGpmK29RV0pMMWxrSzJwQSs0?=
 =?utf-8?B?dWJXQUV4QTJSNmVGOXZDWjVDeDBReWlzZEVTSnVGRGZtbGlIMkJ5ejdQT3hy?=
 =?utf-8?B?M3M2ekZiNzdGVEZIU2pkWExzaU9kdWIxYWtqdkVjTXRlNTF1U1duNWVVNHdO?=
 =?utf-8?B?aFBvZTlNcm5YNXRlakVNR3pyQTVZQ1lmMXhLMXRLdkhsRDQ0ODRkRHBZYVFW?=
 =?utf-8?B?aXpXeTlKc1Y1U2VmQWhrSnB3UFR1b1p6V0ZyQnlqQjFsaVdQVEdEbHJ6djYz?=
 =?utf-8?B?Z0tObnk3Sm90b1hERGdzTFZHYzBHeDlwNVdublQxVnAweGdXbkZxUWJ4emQr?=
 =?utf-8?B?amJnc2JUSnlwQnhkcFNlejhUM2gxam8waTdoMjY5RUZqU2F0TllMdnYzL2Nu?=
 =?utf-8?B?cEZFNlJIRWc4T0xRZW11czgyakdzWGxoZjdVOGpKR05OUWpyVzJveSt0OE43?=
 =?utf-8?B?S2VrYTI0VGtMQ0dLWjhrM2RIV1YxSTdnQUMwMUlVSmxYS2g4ZUd2eEJtL0N5?=
 =?utf-8?B?aCtQTmJrN2RPZGxNMEFDejdmM3V5bE45dExUMWEyLy90VkI4cVN5aTdtUEMv?=
 =?utf-8?B?YWFxNWtNd3hBdW5jTDZoRGl5b0NOb05sTDF5WktyWmQxanM4SThKSVFzUXVK?=
 =?utf-8?B?UWJEVFVOL2o0L2NZQnVmRUpDb3FDNk5kQ25sMGtyRlJiWnVKdCtodU9iVU5y?=
 =?utf-8?B?VzZnWkVpdVVlalhrSUorVjJHaDNQYVNaeTV5ZWZmTTVaZXNXTnNZUjVoY3pZ?=
 =?utf-8?B?ZFFWK2pJMGR0MGhNK0Qrb2s4RHJxb0M2T1JNTmNZZTlKSVRiOHlwNVZ2L1ZZ?=
 =?utf-8?B?dmxEL3E4MXE2YnN2blBBaFFpRk0zQ1JxWUJ5UjhHMzRHbU4vbVMvMGJIWlBj?=
 =?utf-8?B?VGdkZkxSaXp6M0orMnJkeFUyQVIyWGIrZ0JNdmlHTDk1Y3h2MHNid1VsRlZ4?=
 =?utf-8?B?MC91d01qcmx0eXJ1ZCtRaXNUS0lTZW43cStTR2FYMjd4V096a0M5S2xmWWFH?=
 =?utf-8?B?VU9UR09HaHFwVVFCbEd4WTFuSWcvY2x4VU5WZkdHVzkxYkJxMloxODFFOTI4?=
 =?utf-8?B?YmxpbklwUmtBSkdYMko3SUUrUEwzeVF0c2R2VXF2R243V01ROTFBcGh3TmdC?=
 =?utf-8?B?MU1mVjgrNTIxa0F0eGFGZlRUZjN1V1dac0RoY0N5VkE2c1lOTmlkRHdwektX?=
 =?utf-8?B?RjMraTNhQVBSeVYxK0V3UzJGTjBzSFBnVHFDUUl0UEVXWVpLR2FHRXJEWUIv?=
 =?utf-8?B?VFJNRzdYN1IwTTBDdm5xUW84RzJVMFF3WVB0WDNWWHIvQmZtQ2l4R3R3dHhM?=
 =?utf-8?B?K2MrcWpkTFR6WHU3YUxSRkZZSlBYR21Ya3d4NnRoa2ZsMmR5QWUrWmpzQTN6?=
 =?utf-8?B?OFRZV1JQTURxTk0zRDZEWG9uRHRtZS8wb2E3RnVLTGxXMktzUVpobWZKeTk0?=
 =?utf-8?B?SzJHMHF6bVZpRHlFWnRjNmFYSGVnbHBieWxoc1Z2MHVZSnkzRjNROGFZV0Ft?=
 =?utf-8?B?cEtYVnZTMjN1NlNGVDFYM09FTXFCaTE1eFJmN0VKbWQ5YUgrZHVMY2VmNm4w?=
 =?utf-8?B?S3NkclM0L0dnNHRJQnh4YjZJd2twMEtaekVxTVRrR2t5NWNqNU5XUVh4R096?=
 =?utf-8?B?cmJJVnNUbGN3MllhUjZ4cEViOFF6N0dkamRWU2Q1ZDZ0U2l3K2NFUVZtMDZ4?=
 =?utf-8?B?UkltRjlxLzM1cXhxOVU1dUxLcnAxQ1VrWUNHT2JNYlJEcVlIOUprMVZSWlJw?=
 =?utf-8?B?SitrNmlFNjZJdnZrMmhlWld5enFNV3dsYXRHZ3lUSVY3ZE94bVJIYlhob3lX?=
 =?utf-8?B?czRnUndPUkw2U2pxSTVWdUozc1pjRnRlUGxjenpYRTRXYUFHK096RDRXOXJL?=
 =?utf-8?B?OWY4WjRrdHhJcm5wT0cyMGlzRC9VbXBzeDFjR0UwS2VwcE5peVNlMis2NHRs?=
 =?utf-8?B?RmFCVDRidkRLVTgycDh1eTdjb2UycVRKTjVsU0FmTXRaQjhhNWFMRngwdW1m?=
 =?utf-8?B?L2tsVFZRL0IxelhBTEVpRDBtOGhhNGdNeHZVQ2tKV3IrbEdwVitueS9tUHhj?=
 =?utf-8?B?dktOZWM0REgzcTlzdFNXUkh6Sm53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <820E9FF2BC28D843A2E87BE03E1DF34A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jj6ZuTkaXI1qhiYmh7O0w5C6kAIxG6dqwjObSE30UWku9BlmsbQi+/1azmWk2K/sqc/Sbxb0UwdGmyLLoptoHIV92qjaP8AC5lSisQ+iXe3VinKq/cW9HLRFM0BAX8JnFEq6FIMrpAKwRHUhgBmQbbdEwt4cnu2HUZEX/5zraji4JdLCdDBb/oPtFkVN9vFZEcX7kmSfNp2Km/RuuL5STPOkRWJfLPYYxkCqjj+JO6yK47ACb+tTVZRPWIxS3GNh1+9uSXXg9MfLudAVU9bDqi2AlwoBnzaBpcpDZcAJIxIF0JSEt8ibOS9AJN4lxv3spC1XQinR6kUEQsmpX9KA+X1n5X13WxWsn5OO6PeZ/elov70tdqWo3TXxetG+2WqNwab5MfnyxSeTqRIUxr3p2n/DydsnjL9Q4cyGsJCIS07O/68n612Z4LRe3nR43uoXJT9+8ksRp5ratNVs5yVpPo6u52OGGPvnVaOBS3zRMDhANXEcPue4lh9dU3bO+3pPNMpc5rP6BUJi8HVLxRliJTCzPCIuwXnrt68ym+qRDRrU1rmxxQFyJU1VXh3m0nul3kPyYGIVDSU90xrHPyWb+5pqTXrepicVRNTq5j48i8Oj3mVBSZD6Ml7SvGPuGEN2o+lYG2PoTqHRPZaoXCckUGfYPkIt1/7wXc1wYbMnEwPcNt+RsYNQ+Us/ZVzyeZ0dOR5GjDgI0nVpT0JVWAJsFjc/rFI6GzIZ4EMNrFKKoPEqL4cJP+uRzKtcuSvRdt8J2LXOwXQEWD8NpYmEhNZkbinTb4QbqO2ZpWQoxOCdRu+8J0Wtp+NkzioJGCAapvridPC1Sbo/kcb3Rj7Owd+wtGSpodfUfVhQKEUqbS39sIokkjm6UOpko4q9RqNVi6Fh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56a5d62-b560-4d60-6d8f-08db62965932
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 11:50:08.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkmzSQ9i1kxwN9S/bWE482VbkWeP/Ucs70vQZ/DJ9jBuyQ9qTtsohWSC6jzqH9zWfUFdrG+aoGhz11qZbx8PNf8XgYAszPCl2a0tUMYKwAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7931
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
