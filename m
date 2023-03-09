Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1554B6B225F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 12:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCILN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 06:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjCILNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 06:13:10 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3491837705
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678360072; x=1709896072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=rRXZnwYDG5zV3Hn4E31n7MOtiw5e2sF8xcmcU5yHiFVkG7QFXWecLDdR
   FCZikyGvMgd5NkYmP4UPdzUC8SjeF/qEA35bXGjV7S7sLmfR9P7zEVcOy
   evYbMwRBImeeSvGlURvDdyrxq/1nWvtuiHh5Qqv8CPCpAWVjso94xzEWY
   Ty5H3HRG+vnCs3z/ilSck92xB7FP6UU63uo9A26YNdO1ZfQlLhsbqwIeY
   s0wvRXe13by5c7aggD6vMGyAO63oopt/8uYWPhQjr9bif8QxBlvI54VG7
   uC91ZJ0Wg/Hd0zgQjv6PtwXoIOlzMbnQ5vB8pq0hS75alrWWXTb3ypLk0
   w==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="329574063"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 19:06:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6d2bTEQ6SeBf5rlmCP7YG2MjnRwxJ0ymayCHiDwjNaRyJrPOQgyBx7CsdHM5kUwG1fP0ZxH5yIY+EVJ+aFQif0WrNTx0osmTaquU6E0NOIjMPeZGBElPaQKTraoVA1WfJELt23dPHSoBMUza071HBc/bOVz0T4wovg/leKl+THRFpFKNg+5wXXRpEsqzLOKKaN+QZt1J6C+AJ1lVsQ3TpmO/+K60iNsjZI9xzt3c5zYeIX5yYIlNb0jHI6xc5Glbrj4mf/oSiS1y2Sohcznr68G5tqaF+RR08nBaH307Wtz7wlICIVqqzjJ6JhD3PA+YxfVsRqw9ZvpdNrvEvtgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EcQAvqrSh8i3goX1RH+HqzZ64sxx5oyZu0p2nlow0H1oZVBexofKjLthdjekUDmck4m5+dPj7oT9cjolvNKv9qrsHaF8QuY1vFQyWTNDrjC4sFpPTIWJ5Tj6ubrC8L7vFK+c0oPqptINWWygo95Id8kgFArnUkDaVRkqW8t3/QxTDr4vz+TnPdVNwaUxCC8JUHkkiunMGuGtW1iuQefzXH2GJd7MtV5h8xzdCV8m9yXDleZdFCXpzEhWZiBNtyO0ETqqsSF9ddxTM/UmFj1gU0/hhj1e35psckQf8Q3Yl0R6zvK9K+lwyyvL2hKsKzAH0JhpLFYSiKPkrVLhkTClkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Fzh/tk0Q8JzsKuk/CwNh4U267d3dBn/BB3hnheaBQnl8d56PozImYI1yMPTApdO8cZNieODyJuhDRkaaBl84OWemCMLhlqJE1zAeSMtWmpeSKi5EHHjaD5ctFIhezbTDvZBMESp02+WuMsV5qNXSzV/GdUjmq8DGUcbJ4llLBkk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0992.namprd04.prod.outlook.com (2603:10b6:301:46::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 11:06:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:06:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/20] btrfs: mark extent_buffer_under_io static
Thread-Topic: [PATCH 01/20] btrfs: mark extent_buffer_under_io static
Thread-Index: AQHZUmaFujd76lrmm0eCxTXIE7ss3a7ySaGA
Date:   Thu, 9 Mar 2023 11:06:38 +0000
Message-ID: <9cd9302d-b68d-9e69-3bb6-c6b0f2569fd8@wdc.com>
References: <20230309090526.332550-1-hch@lst.de>
 <20230309090526.332550-2-hch@lst.de>
In-Reply-To: <20230309090526.332550-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0992:EE_
x-ms-office365-filtering-correlation-id: 4817fffa-0baa-4664-f2b1-08db208e5ad3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: keSaaoRwmGRhGfiSqwXFPMcqSrr57lpJ4mBxKS0kDcj1zbY7lMnqW09iUYTRlLa2rIslefJBvo+gQ6jm0D9KTZ1+7ZKdOEp6jrMihDnZDbmvsotZRdGalA8HHpFzz/UVKND/2cKPhfSToC8hJWMbecbCx9UG1wWyzdof4BaYD5NKmsaYWrjX2fTDJuoHYieVtUeheWDJ2A9k0yyDiwputhucRSA582KQUZYkwLQc/1HfgL9unrecASLKJrfqipFY53K45BZzXMZ6VnSwtorkITiJRk0RZx9XhVrYOs6iTUQHMcwzmMGFDAui5eREUPhnoTp4NJtmN1DAL3DQaQl+35XP4s5VmLnVWtLtwQs7cXVJyHOSyxjGfACn+TbicbQTYs2s4/R8x12hX7OOh6WuDAa1mR7GbBABbaxVqhCh4/ccshkLspUVR7Yau//wQcoOyXbdhMqz/BPslfAlPnKx6dmdr5brAHVIkiWGBJcjElkot34mwwHJoL7TE0v049/qXKqmcyl8OcoB1tkxzy9KD8fDpE984WvDExyqXjYcH/5WEUNqpz2vGfnVqafplHGmM5LHNnhqRuYGAUsVCnenixkzApVT7ZwYZ2yQ30gl/426b24+tx9BH/MgSeH2eV8ScDbLLxjhJaaOq1HlppUPXF6aohiodtH6s+5PKigqq0HHQ7FIgspOflGie/IPSfEoIDqQy0QiLbz6HjkUP5jAfzx50cz+zIkMJJSZfkax6mXfy0l9ats5k5cJ0gvScNS+srheo368g3oE+vM48n+yzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(64756008)(31686004)(19618925003)(8936002)(5660300002)(66446008)(41300700001)(66946007)(66476007)(66556008)(76116006)(4326008)(8676002)(2906002)(316002)(478600001)(91956017)(71200400001)(110136005)(558084003)(36756003)(6506007)(26005)(6486002)(6512007)(2616005)(86362001)(82960400001)(186003)(31696002)(122000001)(38070700005)(4270600006)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDlkVDhZWUt0M3AwTHk2dXBzN2tQT1VPSFJJcmdsUWtySVJqR1FxZVErQ21Z?=
 =?utf-8?B?TDVoWis5eG1nYlVudHVnaFlVOG1vSzFrZ244aHpzeXBoV28yVThNQUNqUi9x?=
 =?utf-8?B?Q2N4c1dZb2lIQUM0ZGkyUE1JbjREUUQvUGpqWnc4c0ZaQnpBL3JjbmpSR1NI?=
 =?utf-8?B?VExkdU1rdmowVDhrWWZkZVpCSmo3UGJaazRFd0JodnUzS1dXeStmSUxZZmJW?=
 =?utf-8?B?QVV3VmUrWnUzdGZkeFEwcnFXRFpOc3pEOHhFRUhxRVRTOFdQQUJKVkpVYVRZ?=
 =?utf-8?B?U0dFazJoN1pob2g3VWZuU296V0ZnazNjL3NIUjRGdVJnVktaRXdMOTMxNlY5?=
 =?utf-8?B?TlR4VTJkeXh5TGVta1VqZE5GVUwzcmNyRTM1cGFGemQwUmgrU0YrRldrVG9Y?=
 =?utf-8?B?em1taWdBQlJ5cFZoczV4RlRWbGxyZExMZFBBV2E1SnJxWVYrR1gxWHhKRDJX?=
 =?utf-8?B?aWRrUU9XUnN3U3pFUklDK0hpZ25vL1NqaUlwa25VMFpnUElrNHE5LzR1b2JQ?=
 =?utf-8?B?bEdPN1Fhdk4rMlJ6ZHR4emh1Mno2OEc1ZWhNZTBaNGlockZiVVlqWHVLTHBI?=
 =?utf-8?B?MFhvaHZ2MVJKUzZ1YTdkS3BZZ284TGhyN0wraDdtNjRKZXR4VitHblpDS0dF?=
 =?utf-8?B?OVlzRFR3Q0h3amFjTWtIUHRseXJtOTAwQitqSUorWVFia20vTUdKczBuZW1v?=
 =?utf-8?B?cVRwMW1UcG9zYzB4ZmxjVGNFdmlJWDBPMklmcEFZR2V2bnFPSGhOOHZ2Y0l6?=
 =?utf-8?B?UWxTQ0o0anVDM1BKMmY1c3pNK3luWG5BZC82QlB1cHdJT2E5Qmp5dEhXODht?=
 =?utf-8?B?dVpLRFd5azZMYXZURTA5REw2QVNERHoreDgveVhVTkpqc0l4YzhEQnJxWWla?=
 =?utf-8?B?U1BWRVR3NDNCMFl1RnlPU080MTBjN0o5Y0RJQ0ZSYi9XWDU4RnVYU1F1eWJZ?=
 =?utf-8?B?ZlBoc3JoMXdqZVEydjkycXNCcGV3bzk5VVRSanI4MGo5dE94eXJiY1BUYmR6?=
 =?utf-8?B?dU5yb09iYU5jUnNBeVdVZ1pUeGVxS3V5L2dOUzlTVlJodGg5d1pLQ09qYnNW?=
 =?utf-8?B?c2NuR3Q4QUpjWFRvbzVsRlJLc2N6aUJZblFEaG5rTUxZS0U0NjFCcDRtd0hh?=
 =?utf-8?B?S0cwcUZ4Z1ZkeXB0UjM4clVtbnpLaVBTcXk2NU53QlU4ZXU5QUo5M1RrTlE0?=
 =?utf-8?B?RWlxSzVzbHlHbkdrcHdyUkZTMXdvdFVwaGk5MVFtQWk4UUs4RE9hb2dpNkNN?=
 =?utf-8?B?UXdwYXdQRHR4MURPOUJtRWVob3l3UFcxT0grSU91RzUySjNRNzd4V1pMTFY0?=
 =?utf-8?B?R3hMT0J5VDBUOFF0RnFwNWo5VjV2cmhZZlcxU3pRMW01VHdKelJ1cGxrUnFI?=
 =?utf-8?B?RkExa2QrQ2wySUMxcUlwRm0vZHB4UldwRGJKUGphUFFMcnFIdW80TnByWTBO?=
 =?utf-8?B?NVpjeG1OcXlCSDNTN1lqSjExK3N6L0J6a0dFWHV6dFkrOE1qRm1CemVHQ3JG?=
 =?utf-8?B?bWVoUVhld3lYTWNOR0xOR09ESVFidkxTWmVUWTlpdHFXNzh3UFVRZ1NuVWlQ?=
 =?utf-8?B?V0V3T25YWkt4c1E0UXF0WUc5UDZ5N3dMZzlyc1BnRUtkaWlvTG9lQnJqOEdZ?=
 =?utf-8?B?WmdpZERQK1JSRVdubWNkL0hkWFpnUG5VSk5xbjdYOW1CbzZhZW42QVF3TWpS?=
 =?utf-8?B?L0NIaGRtdU95L3pRWVYxbVhJNUlXL2ZibXVtNnJia3MvdlR3bDVBNUtIZHJ3?=
 =?utf-8?B?UUU4UXNFRDQwNjlwWDFZS3dpeVlBcXJsNy90RUVvUUlRdVh6SGRqTTc0d2s5?=
 =?utf-8?B?cnBPOEdYTjN6L1pFN2ZnK2huRzNoN09MMTdVdWR5MlFTV1NhejI4MzhOKzRI?=
 =?utf-8?B?UXNTMTNhTmpMMXIxYi8vZysxcVpSazBPcFZacHZUZDRIczZkRVpwUXJVUS8r?=
 =?utf-8?B?aXpGMlJUekY5bGl0a0dkakFwdVBuaFVKVXR5bjR0NGRXUlRZRStUbUQ2MlVZ?=
 =?utf-8?B?OTNRRUgzbkFEb1RDUzVJQkdCTE55aWRGRFpHREo3WDhRQWZyYVk1dkRTYlJn?=
 =?utf-8?B?UkJNY1ZDU2lwU0VFK1JrclNUZ3lkWWhpRVRScVUrbklCbEQ4NnYwcTNFMS9t?=
 =?utf-8?B?Nk8ycWJyK0xEcEh1Y2FPREozM3VLQm9Yc3FQSWNBSzFueEV1UnZtS3JNTGhX?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC883F15C791C743903DECB7594540F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lHPN26PQdCEFBZq/F6tMcfMYcwiL1zas8J+m3O09v6kWUAaKDl6CG8MJXmpOMKCioR+wV4AoBJYQ4IDz4bkM2nEV2pb4xeeCczpySDSAvyosf4mT8LmTuBM/FN4oHwIu49OtdThbCRNnv/g5tSFAiYjP1HTvCGZVW8mPw0VT97YcHwQpolKM/DGv6TVTw7rxabWWj2pWV+Zvy6RpEc1YbMj3EiqaP8uLi/dqOLzjXvozlguvIh/Hj3DILz7ZEKkDhk7FrayA3abQ405rP/0X9QzZyNrCmGMSkjgDAy0SAqg55+TPRfMlaWVQ6RBJ6l5bxPe517jpANJlGTADYLJsv8e/rUn079bkl+lF9OrCxoO3Iqy/s6d3WV6nAXq9arsVdKVE8dXEt4iBUYY1On4ZCVVWqvLm/cDHM2708UMqRg7nXw8CngcQiPstLDYjOa9jMJbio3BsAHqrxCFu5jk9iyycRHpVeSHmFjj+O/FSUQCPpt0TxsnV9gVjFnIcv+ByPeujJyzEHaHS3dOnJKqA6LFT22KxidMtVnqcdAW5fO3xzRnA79OvS8D5AkulLFiZg8Hxgyu0JizeY1a/v46hm31u9UJR9v50hren7AKLW54lOHkulGfHW2ymblHxn2xZkeczNV4124hjh/0w3yNf+3Hx3cQqJXTLVWIpE4hwKpf0BzgXNv5JR8rckPd6dX9pTcc5ISqGLmD0pW7YpVJ51QkNZJp0mIPtWG17U6E5z+BTF31caIJk/Bs+3+yuAgGy3TbwncxYad04c785hXZlz9PKhDgNwyO5fFGnFqyMzFqRynRNrXgYpNFprr3ou84zz2EtIhnWokcreFngxeVMZo4IodHBNXNqp2qNf5h2mp7PgWGq6oCr1p6sE/k/RLE/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4817fffa-0baa-4664-f2b1-08db208e5ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 11:06:38.3717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KbbmBNw/HZxaCbytCoTKYEazdggGZ7oznIwzHauOhS39SmgZ6XH4A7JJ0w6QC728jtuPtDEc5kRz5mxoB2rW/ZhAtmV+dhBh8lZleTk8ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0992
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
