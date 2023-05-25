Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C4710A86
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbjEYLDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 07:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbjEYLDG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 07:03:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B44195
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685012582; x=1716548582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=QPdJHyx1PK8B2HXANHr7Sbe5jG2AIojihSp88iG9XNOosgiWyBXzJTWR
   /n5kHnYkLr/k+LjVK33JuP0WQgXHjuv9sJrrrRLKY1qz/GaHzgu+vsmum
   oc41iKyoylAaz1rBR0r7LQwxW6Szxn5ixZX9YCHHMDhZO15f8HABtsxZ2
   SQj81kxcECRupAstl2IobgpmvP0B71U96zbYFIwlCInljFyUoc+0KHeAb
   jjfgRvVCfUx/3NPsRnM8cctvcuk1XF8nrT5UyoD+zKNB2GtStBH6TN7TT
   2HAwCsBMAeYXahFaj+gZ2dFdczvopuhNfTdeXt7zj6X7LtnhKuNu61cHP
   w==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681142400"; 
   d="scan'208";a="231633937"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 19:03:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dibcc4pEQv6aoKjHdes2eFt8qcS5kendHvuJECh6ENGB0dZMpYpXW8Z4aNCrge9hU8DgnaSeCjT6595TbrO57DIH+LyYSFiGWj/Sbz0DU6BbtLWoZbnDuizs30XWVAZZhvasdF1G3cDFD6vbXtHQR2BAwAGnX/7Okpkek28VE/x4G59fose6WIgGQcq8UJGIjaY1s9ZEWIVqCASvx1bm6IOH6PQYbsg2XFvtImJQL8NXx898EY88PnNOs3jrrvyUqQDWWMyNUApEWHdJEcebdhVjtmbddMJv5O2qQbF3LPGwyGFgF/BmCk4dHUBIJ3DhfKmXBqILfpGxYjBDAXW9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HQeRAf7blodqXSMNGaH3xS9oqPs1+Y+jYrW2icPG1XOa+BSV3VGeY5S76KbGVS0CL89d8Lh1J379Qem9ksXUFCaoWLP3GDN2fB8X7YqCn5jQkgVTd1ZtgFYx6NstWsz0M0KaAmvFN/0BYnqRoUtysyYgTDb8S/hrqhTcw30/KTCnj+l5djOoJSl+7mDvHPWX8Pdl0MmjwO2gTa4FyuNGrt3q2bS4s5Q74MgO3ffmDbgBSrZLbikCgrzmoQPJljIV/BKzUbU/EwagmXP5LCRdpLPvisk3sG3QRYh9Ppdcm9N5Mp0DHPGnJi5fri1hxrudj5yys/FmoFRr94GLVhdsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XmaHMqBXpkvtXSoeuSN9bO2MraLh6Fs4NyBmII+jQj0SzV6XFbCBGSkUZX2iqKI0o3RdKhlu7pITfACpKAgnQv0m9/RjlX9ODP/UL/RNPYor0AcCZur9fX0F8OQG+7MSMvYF3JwNmGuZxCuQ+zg/0cSvSIzebrPzmq3WLPHo6U8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6614.namprd04.prod.outlook.com (2603:10b6:a03:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 11:02:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 11:02:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/14] btrfs: return void from btrfs_finish_ordered_io
Thread-Topic: [PATCH 09/14] btrfs: return void from btrfs_finish_ordered_io
Thread-Index: AQHZjlD5AHt40ZynwUORwIV7MV0B4a9q1EsA
Date:   Thu, 25 May 2023 11:02:58 +0000
Message-ID: <55f4e268-0319-d7c0-4ce1-cd1b423d8dcf@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
 <20230524150317.1767981-10-hch@lst.de>
In-Reply-To: <20230524150317.1767981-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6614:EE_
x-ms-office365-filtering-correlation-id: ef4c9317-fda7-4940-1cb1-08db5d0f996a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HTmbfmSJRBak6R70Q8TAXY0t7Oe4aTGMRzCbZ+vE/pwIRSunwLvKSPdxNk/WuMmfFJqFMww8tYe4UV5oQh/9tQFmtl/K/qNmxmztDfXcravH/l7hkqM3zdmMWvMuQKbDdfChpaH9Vi1hMVABB25xcIh3V6q8ZztlEMwOmGiOUkayqek+uCAV8yJA3VFTUFdKUiEb9Wrk9fpQmiMqn2hU6myKxSCRsVmXHQhU/O9Ldr+cvCZNVd1rMCo4H0TSgB9Y0sqhdkpZsbvdC8hOfpoPslR+f8Xuq4fkRW2QTOuYB9ew2hDBi8bLlEasNMzbCoOFqmFlQ9IihhfHHJ4KyJVGmUpUYQ5vjyf5xSPgQruz7KC0uUgqbdlFwM0W0N6dUihWUF+SXXhLfeB9kgBlukYiz3n8m1ZXRKH46daEOFNA0rUfp6+X1tq6AtXQopU/AOk2bCpyoRco+T2g//gVObuIYFwFdb05L6+K0P3AuruHSaoZDp9MmSYquXhfxLGpNi6PbumITq6+q+otPvw+sTEVAHDbdHDiYlg43VZ9baIsIKSOnuDEjkQi6UHAHQitfZjND85To17p0q5m4Ds2AsQgHFatgSjhdXLRgSMBgwf3ixEjWHHYYZJ3wd1/02k1pb9GkE/oZ/pjbPw5I1NdoDuP9fxKP/KGa9qVWQz7geQz7sbJqBO1kmERunzQ1Mm36j46
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199021)(86362001)(122000001)(82960400001)(558084003)(38100700002)(38070700005)(31696002)(36756003)(26005)(6512007)(6506007)(5660300002)(2906002)(2616005)(4270600006)(19618925003)(478600001)(91956017)(76116006)(66946007)(110136005)(54906003)(8676002)(8936002)(4326008)(66446008)(66476007)(66556008)(64756008)(6486002)(41300700001)(316002)(71200400001)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVI2UGlPdUJUSWZ5M2tvd0RJbXZsS0NaNnQxMlQ2QVpDR1pCM2g0b0NBZHQw?=
 =?utf-8?B?bmc0Um5Xdno3aXJ3cDRtVjZRVDRlSG8xbGNLMEhDSDM3T2NXcDdGNERDM0tq?=
 =?utf-8?B?ZHVJNytGRk5hRWJxeFhGVG0rTUFHUWNQK04xUmNUNUVuVVJQRUJPVkFuc2Zu?=
 =?utf-8?B?eGw4dVR3R3NOdGcwcHU0Qkt6dW1kcWdHS2M4MnpXdlRwSU91RnJycDVkcUxz?=
 =?utf-8?B?R3FRcjhzaVBhZkRpYU1IWjlHOG12blo2bTdQdXRNZHFQMVFFbDkyRmJEN3Zu?=
 =?utf-8?B?bHNrYW9rUjU5NzlLaFpBV0tOSjVldHo3dlp3YTZHS2tRTGFmeHJUamZaaE9a?=
 =?utf-8?B?UkI3eTFYR3JudHE4UFNJL2ZOMHkycXNQeUxHRkFFSlY2cmZ2TnpxSmxPVWRS?=
 =?utf-8?B?ei9CVFdUSlhCMWhoMGdzMnNKeWtTdGc1b2lhNi8zMDlFN0g1QzBGbXcxVEMy?=
 =?utf-8?B?WHBMYWpSc0p4YTY5aW11eXhuOC9iemVZQ1lWWkFwNVRiY21zWjhkM0M5Rmlp?=
 =?utf-8?B?K3AvNTNiQzRVdU5MVFZnOVF1OFVUYzVvWGZvYTk5QVBaU0VKOXYvSm9peURE?=
 =?utf-8?B?cC9DR2tHZDZ5M25sZzBLMkVRT1NpVGk3SHBCL3l1aXVqUGZWaHk5KzRZVm9O?=
 =?utf-8?B?cjIyLzZWcFI0bnlaSDdueUx5MWJaUk5PU2RzRHFxbjdyMWp2WmViSm45TXV4?=
 =?utf-8?B?Q3BjQzlCRkFpNVJKYkJyVnh4TDdpTWVxaEcyRlpRdEZqKzBXdFBqMUNYVUNh?=
 =?utf-8?B?dWkvaFZHTm5pdmxMSUc2eVJXRjhSdU1zWkJBM1puTkdWZy9ObjZMdVdZRXJY?=
 =?utf-8?B?dHBEb0J2cTZaNXc0ZmZubERYM2JuVWNHQzE5cWJESjZjQUxldjg3UlJFTm85?=
 =?utf-8?B?bkJtLzVHTENqTjNFMmtIN0lhZGRxVm9Lc01jTFlFVU5QRDlVaXE1UjZuUWQ2?=
 =?utf-8?B?Mm94U3BRa1hPMm8wbjE4WnlGQ1V4Qk9hQWtpclJDSk1lTVppNjdjQllReEtF?=
 =?utf-8?B?ZnVWeDl6QXBpYzNkRk5mb0YyOVY0N1hDUDNwMzB5aUJsQjNORWxBMEdkOERq?=
 =?utf-8?B?TW0yMFJWbStKTXlNMkpidW0zN1ZXK1lzSWZDbUI3NjJhUmtOcytIU2JDNFJM?=
 =?utf-8?B?VU41ekVSZHRIUVlIb0tId1pmOThHTVFNWFBBRVd3YUZDeHRub2FMbkt6ckpm?=
 =?utf-8?B?NEZUTkM1VGh1RHlOZVBOV2NQdUoweFJZdno5MmNHMXd4ZkpNbmtBTWFlNUZO?=
 =?utf-8?B?a0gvZmRHcjE3b0N4S1REa3JNOG1lN2cxeUdqSkJJYjdTb2w3UTYraVI4TC9B?=
 =?utf-8?B?ZUlSTWxvdC85N1NUN2t2czY0dkhLNmVZOERxTXFGK1Y4UWlRdlpiQ1VEMllE?=
 =?utf-8?B?OTRzeEFwUnJnZW1hdVpvcmxLNmZ5N1FlaDhMcFFCY1BKZUxNRDJmVDFBbVVU?=
 =?utf-8?B?U1h4cEtRRWlrUVZjZUlkRXVwZlZrYWs0T3dHWklzSWs2clMxdVJVTVRIbmhD?=
 =?utf-8?B?RU9yc2tZbDBNNkpPMU5FOWJxd2pPdzRKNEpRZHhMRm9ibjVtRUJ6QWNFRUV5?=
 =?utf-8?B?QnNjdE5xZSt1L0RMMmdsN0VmbXlyckkrekh3RFN6ZXVpY1FXSElvZkJQVkpL?=
 =?utf-8?B?c05WelEycTFDcTlZeGIxV25Sc2NBM1pNcUF3T0JOc1B3SW5pTjJXYnNSS0xZ?=
 =?utf-8?B?Y203cGVaSnUzK0dwL0UvN25LeEdBOEpGSGVJS01pUHBYZmljZmpINVlMUmJx?=
 =?utf-8?B?SlA1eUc5cUFHc3p0RHplUmxodnBSa2RreXBUN2hVckNCeGNkbjNPb0g3YkRr?=
 =?utf-8?B?UVFJeWo5Wk82dnFHR2RpQzRJLzFoMnpsdEhaMFpUNTR6TDVEYkZ4NHp5T1cz?=
 =?utf-8?B?ZmY3YUdsUW1jRHBKVVlRVkppbk9IY0gzWVdUbVVjYVpjdSsyRmZRMWovT3c0?=
 =?utf-8?B?K2NzZWoxOWlKRzg3TmZTTUNMT3JzT2o0SXJvRjBrajkvL01xNnJDZWtFVnZv?=
 =?utf-8?B?TTZrQWZJN2p6eG9ESmV3bU12c3FaekpWS3djM2FFWm1BWDM5WHBiRHlMdk9I?=
 =?utf-8?B?K3NZb1EyOCtWenJ0eFYrdisxRkZwcllBYXJEMFpXaVA0eEFSSnI1SnNraXp0?=
 =?utf-8?B?aS9qSjdhQ21td21lVmhER2ZGSGw0QWtRdmFJa3lwR2czWkJ6b3pacUJ5RGNH?=
 =?utf-8?Q?7pUpp4zUcZH6+7yYAvRTG7o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4B0870A9E81D4382D1EE8C757BA613@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1V6ec4vpOI7XGwg2bFRdwLBLAD9NqwZQIWi2yz/a+Sh0irB2deK2ZmSSSIsvSTEVfiiA6C954ZsgCGmzXtL139Gd0V7o7GG0GN4JSI7ShwmOBwNTLxUnzPTTgAPSwVMgULdCyv0xdVyZZyyEEJ9Nk1ga/d1kaoshy11zPIgTWX6g4sTpXhoA/NHLAV+NWuEwjwvPqGroTxlwa5Jycl3dwwWNKE3nxVqDmeUooNjpzVFuXK3UIKicOu8tWdDHDBTFu9QSfJfenObHRvt+S2q7Ac8ORtM9qDM6RFLCoGvdbN/ykx+iTwuGMfvx09qNMrxY6Ohzj8YY+9gTMFiAp55OU22M7FWveykiF0YmYhMqgSJW4a0tFYhw7kefCjr5X4+QOq/yE5TpSQEwCzYgSNP7Jaku1XcwpQSnip8W8VtCpWxP5qA5NZdBsXDlHU0XKrlkvR6jzOQ3mF5LD2NAGq7cGByGZKYIUHP+pEYNa0rrStbOat8d1iK/msZL3TQgwqiEPyNkZ9VZe2CqylD+KRySLzu8f7ztVbb0Ymlxw2xd9fxummE54rpGkJj5kR9Gmx476VsVQIYGSW/jqB6nN7KYD2zXXhxGNPOditn4uml/2WRqwZJEkBXgiLy37VNlqMnEBuKN84VA0EvfNa2ZW+CZ7ZZIneVvWpL9CEPoWqVfvrLatwCZUoRnosvHqe0SyVlQZ+8ALz3BaJrFr5l4UMxBSTTgtjoy7pipnj2WWqj5m5bWLbBqnPOX+yDkP/4kuoOeBU5ZLwpOHD7cnYtZEX8JwwktFlswFttyHg7x76ZMR4KeuT0hSRKhcR1kgkBhpjFUoUJdIeEE/3S7Mtz4Hd/HWibP5kENzt/wRwplKCinOVDeKjaLS2jiwi3tg03w00tR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4c9317-fda7-4940-1cb1-08db5d0f996a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 11:02:58.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: femTLI6DlazculuMGb/uVEj+rsowx2XB7RZp5r7rdFhLGs8nJHS2K0hP5U2r2mge3uy8trShtDcY5WItVKNTPFSlavZLEzxjmSAyx2GrT+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6614
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
