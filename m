Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE47171618D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjE3NVg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 09:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjE3NVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 09:21:32 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB178134
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685452879; x=1716988879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b8P5xkv9r+inSteTSpADbyOzIhsYC4/BE6Aa6XhEu80=;
  b=pn4t68Lb7CMstOGW3NSNhvaHIYzNONsZx0qE6tHxam8o9SWOJbGbEP/K
   QNgGyMYZuANn0Zc2mPjuUWSCAq8WOfHFpmeDMCDGV/69fBvO9tJoZjaEC
   4nxselnZn09n1SEUAsWTRzIAxw4SMsays6ZIyK6565f4RRtUeLgwOraQQ
   6LstmDMkjBMePGrVc8LI5Va5T41Z13XflE9Ls5s+f4GdCyknr52DZeFgL
   oF2lNO24yBANkYXBH6qQ3xMtOixtYmnZxdO2SQnSGxqVB3i827MbdoBYr
   05BCVsLhb/07H4TC9jqrL8yjp2ueORGkcteFdGntQvFH8X1znsnLfUMyq
   g==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="236910432"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 21:21:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5fMZL98cONiamkF9JzojMZJiy9LPqdI2dzz3ax5+pV3sWJBxdipy+IAvo4G/JIoJdhJt7FniZ/uJXqVcjS6jgpiDtuGaQf+d3epjDXjJ1JXMXIXkGPmJ8IWMLG0vI0nvvNU3Y1ssiyj3xCVT4HU2usQBSmt86/a3SUvuDhHj+Gz8DxGl2S/P31ttV1N3mZ6+yelk1AYInKVZjcrKtGscF40GRXTRMIsk++10cqnq/KmiYy8cAjq1gFAOc6Gw/ESsLBL8gbrZBU1N9cSYJWLJaSyvH2GYSHwpzRbjzpnurR3vMRay6TFlhg39XWy0HdMXtfP6GUzGFozxvfk1lGsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8P5xkv9r+inSteTSpADbyOzIhsYC4/BE6Aa6XhEu80=;
 b=hOy58XyWPdU3iwp0DiLaf0fhkP8KpEsFOETaAndmc2U++EaXHYNuEeDS6OBpAtJv0vqTwH1GAr08TePJmbtMeqgDotc9bLd5cD55/SxSmOeZntgRH3/TY+QTl+BdMemOaBTDnVgXggrk+DjMCf5pK6+z24OvbFzXdlrqfgPuF9/zRLpyywPPGaPaZ2fIN7LK3z7pm51IvICXgbdJDxNwoLGHI9cAZ2P10w9h5wVLKrNEGDsJjxlFMOhqrxFF/5PFLU68gyDe1ZZukFK34t4Bsp5RXwsn0GpWA/mv79VuY2QQizbdlHXPm2Z9BuiMMRaddmv57Ii97JN0WnGR1ataww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8P5xkv9r+inSteTSpADbyOzIhsYC4/BE6Aa6XhEu80=;
 b=XHxWyVqd4mt263wdTdFesR9eW8xRa8Ow332p3B2JoQyoN5CLR7Z0wRya4xJhTBbM0rvq01AzaT7CtBI5V25qdCYo/3pvwH9rnOcaX4AfbHQDyVAXNG5aoYm+vAli0wZsLt2l/brvc9md3cmWZCfrSvXzxGfzsFduL+v0mQjG8zc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7732.namprd04.prod.outlook.com (2603:10b6:303:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 13:21:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:21:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: don't split ordered_extents for zoned writes at I/O submission
 time
Thread-Topic: don't split ordered_extents for zoned writes at I/O submission
 time
Thread-Index: AQHZjlDrO6/mIwvcQUiF8lkezaD5oq9y1pUA
Date:   Tue, 30 May 2023 13:21:14 +0000
Message-ID: <45d88c8a-4eab-6fc2-8970-6224878940a1@wdc.com>
References: <20230524150317.1767981-1-hch@lst.de>
In-Reply-To: <20230524150317.1767981-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7732:EE_
x-ms-office365-filtering-correlation-id: 85e1c3d1-a680-4822-c281-08db6110beb8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eg7T+ts+P6E4TuXKdiUmQ+O0epSmpYAnlyh7uZL5D9Z36+ykpfjIY7TOG2KSx62CUhNQ7A57a0Esob7l2XzvStZFCFIj9MPAZB3EA5hCf6fRdRh7AJJmQ6DPWpGhIO23d/M3KBkNNBangjPIuUNWQisGGNqgxRce/83MPkO7rXeCwGcS2rVfFHtoPpVQU+IW7zYxqFgsjX57BFAtSFceGuyk8coWNTl3CJE2RDDbmTDuexhv8FHKoTeYx2fFNpkVLY87AZ6fulwgLoZPYVegX5x38fmfMI2KSoWbeLYXZXo/MZIXkT/wkNFd2xL7TcWUJD2JkOIdcdKPtMeEBatRQKS6/gGmJUDd5+vF6khEzs3CV58SbNIj1dNm835qpG5vkdNAZCpuwbm06tEPPINemtZUsae41QX10nooF7Z92siacNGpE66n3KOy7/bW3jZVv7G+TpMqwW/mK0KJlRYzPgAjcPrKEBbIuhUVr+rf9bPzJWn0H/74+OLtpw0dU2AgFWkeOc6ciC8bjay/dpsEZt3QLALd+lR1+dMVAG8ULuWoDHREGuqM4M8DKrLtcVhlT4yYzuPnCt5vZbmwFv3f9Ji5zJV07lFRH4Cl+iKmTLFmAZ8UyHfr/0buZgYce8/qRrDv4K0QYEzj0xC8D970NNnR4Ndk6R6YcKUDdnmEfX9hBkcIiYM/u1VP355GIIj2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(83380400001)(38100700002)(41300700001)(71200400001)(31686004)(6512007)(6506007)(186003)(2616005)(6486002)(26005)(53546011)(478600001)(110136005)(54906003)(82960400001)(91956017)(66446008)(66476007)(66556008)(66946007)(64756008)(4326008)(122000001)(76116006)(316002)(5660300002)(8676002)(8936002)(2906002)(86362001)(31696002)(38070700005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFl6OVFiekNiM0h1c3diNXhTbS85QnpBT29qZUdBOUhXR056b2xWQ3kxRS9q?=
 =?utf-8?B?ZW1pMm0vRkpyOEpybjVXSmRmenhaUUNXNllqNVljL2pabjJLYUQ5d1lNdTZH?=
 =?utf-8?B?dW1NV2dnandNSlB2SHd0UTFOMVJGaTkwaWhTTkZHMkNBeFJpUitZUy9OMWV0?=
 =?utf-8?B?YUVsbjRMS3FOZ2hUNEJ1M1AvamV2bDdORWY2NnFwUUM0YmthQmZGL2k0MUMz?=
 =?utf-8?B?YVFJQXgvak40RUxIVTdLRDFCdzJMR1dxVmVucnV4TG0yL0x5T2JpeElrRXRV?=
 =?utf-8?B?RUMwOUMvZEpoMFpSUGw5YmhMWkphS1JKT2k5Y2MzSGIwRGJCVkJQSjJCd2po?=
 =?utf-8?B?MDNZZytNejZ3aW1aWU93VE9hVnlMRk1FY2Fid1BZc3FqUUY0NGNTSEJ4eXgx?=
 =?utf-8?B?Y256UzV2b1didkNrbXJLVVd0Mm1PUEVMVmJETU50cG9XUXRaSG5yNmxGZzNp?=
 =?utf-8?B?NDRZMldsZGp3L1ArdXY4TnJXb2dDaE40THJKa2RETGo0U0YzWXVsNXliM1ZV?=
 =?utf-8?B?Zm8vT3hXTVpaMGtmbjByUXpjcHduZm9QcDZCSWYrZjREZHhNSm1jS1hhVmt4?=
 =?utf-8?B?MFo0SVEvOTdjeldQZzVyRFpvMU1RQ20vY0J5SmVIdk5EU0VTb3dlZkloTkMr?=
 =?utf-8?B?dmFCRVhoTjNqbGRGTlQ0dmhPTGRYSFQ3QkpRaGw4aUVWa25qR0NXeTI5SGFQ?=
 =?utf-8?B?RUkyUThSS1NtdXU2Q1RmeFk3dkpqdVJpcnd5TTRIZ2FPNDVud01WYXhJZXNn?=
 =?utf-8?B?aVQvRllFQjJxR0RZTElpSDZXYnJuVUZmRHZTZHhNOGJnTm92a1M1Vlk2V2J3?=
 =?utf-8?B?dDgvQ0k5VkFJcVY5SFlGS2p5Q3RZWEl5aEk4Nm4wYnVVT1UybVJUcXdZa0pO?=
 =?utf-8?B?MXBJYzJCSlg2YnhrS3IwQjV2Vm92bmhTSnNyaEVpcDdRYXlxbHNURll2MTJT?=
 =?utf-8?B?RExNWVY2NDY2ZjNwNEdtaUxhUmIwbVFVeXlqQ293NVNnR3ErcVhnVS8zZFlG?=
 =?utf-8?B?NzdKckZ4NHgxaUwycGFKU3hkM08za25FNTMyb3RKNmVCcDhrQzV0T1J6ZTU1?=
 =?utf-8?B?VXpPaXR5aUFOdTloSVhBUHRzM1RDZmJMcEdHbXFGVDNLZklITFFMaElqTUhh?=
 =?utf-8?B?cllIanptdFFhSWlXNVJ2cmNpR3JETmExd0o1V0ZQMkpGeUZCMFBnc2wxVDV1?=
 =?utf-8?B?OWF2UWFqdE0xK3VtdVY1d2xRK213bVFzNkFURi9NR2dmZG1RSUhwUzZ2aFFi?=
 =?utf-8?B?QlFnL3hpQUlkV0RnRHNsS2JKVURlWnM1Mytzc2h3WHQwUGlXMjFZLzhPUjZy?=
 =?utf-8?B?WXJiZ0UraDlIb2hNb2g2cTNIR3FkcU1KajZQQ0QzZVgzMHdsSEgweGwvaDFN?=
 =?utf-8?B?WVg3aTVFbVhKSERKV21SUU9YK1pQWVlCaFlKS0xMQzg3SEFoR1ArVC9hZzlB?=
 =?utf-8?B?K2puOWtwN0ZRSFJLOERsenpaakdQZWZJWUhDdEpkbGcwVG5zOWIrUDcxWm1h?=
 =?utf-8?B?VDJXTVNOTXdxZ0ZtOVhQekdJTDEzYjMwZEJHelpvQm5wbVNFVDNrcmJlRldl?=
 =?utf-8?B?VHdOdHE5clhhaWI5Qm1oKytNNWZjZ3FGeWRIUVFxbUNtQWZjSkpoa0Z3RWJE?=
 =?utf-8?B?OFVHYnhMdUNFSGE0N3BoaG1HRVZsTkdMMFBaMlRPbnlrUll2V0d0V0RZUGVK?=
 =?utf-8?B?Wko1VGhRNFA0QU5JMzB6VmJBSmM0OXZyN2MvQUhHcWowcy9vclVVZnhYeE1u?=
 =?utf-8?B?aEIxOFVYcVlHcVpURms4QklwWkpKakhnRG9LNVBMZ29sdnROa1VxWXI2enhX?=
 =?utf-8?B?OHppR1RmWXJYQW0veWpHR0JDeXdGM2daYW1HUnNaYUZCdWdhWWh1ZUFQMUZC?=
 =?utf-8?B?MW9nSVNkWGh0dEtMaG5KNmhpVkN6QmRuNTg2VEMrZEs3WW05U0hlbDJPa0VB?=
 =?utf-8?B?amVIUi94TlZVUWZhellFUVZ1ZE1yZDhoVlkxN3pKYUJHQ2JvSUFTd0J4dUZC?=
 =?utf-8?B?SlNkeHUvUmVQS2V2UWsxWjZLSUlreHg5WnlieU5DU3loeUxvWE1WZFNPUmZr?=
 =?utf-8?B?UUV2cG1aT21PeVJIam1sNUJ5K2J5eFdybUlmNlBjc3VOMVdYK0JTb2x5MFFE?=
 =?utf-8?B?NERrOG1PSE42aEs0b24vS1A5WlJ5ekY3aCtJTk84SHQrK0pnTHg4NEY4QnNT?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <794DF6E129B0C24B9823A9CA188869ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H6V0E/BSGely1ewB7A5cZambIE7+GTXmKmEzZ3nHHDHMYxSPbgMnOsCCbREQggFn/eMUJ17dCGn3B37kDsHS7UkzWC6Bbw56YvANEPk7c/PqzYH3JewDn7GzfNyX8M4xFaJN2CLnZxUv1sBx4I+cT+1PwoLV3EoVWYP1C6g1L1ei5wBPxmM0ZO6IhPoVEgcV2fXu67Uc6G23ycCKDt1enEGbBRfhpnOJo9kdKVU1hT6V4eAGSDl4rAwn6LSUuP+QDPNGmVIrfejy/fJAPukkAG63wHEptujCLs2w8wnjcS1314VLyixjH0hB4VtHCU9bGpR4i1ibi1qPnaJOsEZQHm6vY/ExCBthqEJu5gr5S083ZZ6FnARgoM7Hg4EbSeUN8Fiv334Ub0DaIAltw6wQ56QGaLdsVa+oDvam3CCUrNTl4+TW/YueBT4eM53s7B/kAunVPKe3FCaa3bbFPA5gtX4Te7ekyQPQBsh8P11xaOLdjT2+5CsGnpYvQJy9Od5NwziXDSsl5MYIhi2cWznMAXLdyh3KM+ktiUOAv1UdwTgmfkXO4WFLzNtvqt/lx0MJmz5yo8+4qQ0GEy/HX85KNOxz58s9Qb23RD+5zdqBVkaSV6w2T6H4UUeiokCCN3KAjO+I3GT96odXaE9v0UZcB4qSrRofHH3Wk9CQnfgtqPRIzXhikaWDyeZxzR9/V/PjvwjsHRtiNshhOcFlBytJOBrxxhMrxbTTj3l8YT4kkMfgl7l7/sERyLgDxgjl5P3Ar9CgNWIYZX8DZ+/ZvzKBhi9XuXJ3XgnRnnGMnFshnqrsRf2xN8sWa5uZ8xiv2vUQUplAzIF5cN+WNBkyRP9XLODvngV+qh1hWoCUwPu0s4S7rWiv6VTzwha02HUtgOth9mqYTl5dQw62V/Ld1+Ifl4oDrjMbOrC3+tlByfC04+Y=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e1c3d1-a680-4822-c281-08db6110beb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 13:21:14.9640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbBEJp4Z/748p6s9/QLb8SE5vTJz9OxcjUDSr9GEAlDi1LsGPBIs5xazLaOQVg6Dfc1RcCAZpTM81EemHR1KuqVrdnj8fwKw3CevgMpnP50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7732
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjQuMDUuMjMgMTc6MDMsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBhbGwsDQo+
IA0KPiB0aGlzIHNlcmllcyByZW1vdmVzIHRoZSB1bmNvbmRpdGlvbmFsIHNwbGl0dGluZyBvZiBv
cmRlcmVkIGV4dGVudHMgZm9yDQo+IHpvbmVkIHdyaXRlcyBhdCBJL08gc3VibWlzc2lvbiB0aW1l
LCBhbmQgaW5zdGVhZCBzcGxpdHMgdGhlbSBvbmx5IHdoZW4NCj4gYWN0dWFsbHkgbmVlZGVkIGlu
IHRoZSBJL08gY29tcGxldGlvbiBoYW5kbGVyLg0KPiANCj4gVGhpcyBzb21ldGhpbmcgSSd2ZSBi
ZWVuIHdhbnRpbmcgdG8gZG8gZm9yIGEgd2hpbGUgYXMgaXQgaXMgYSBsb3QgbW9yZQ0KPiBlZmZp
Y2llbnQsIGJ1dCBpdCBpcyBhbHNvIHJlYWxseSBuZWVkZWQgdG8gbWFrZSB0aGUgb3JkZXJlZF9l
eHRlbnQNCj4gcG9pbnRlciBpbiB0aGUgYnRyZnNfYmlvIHdvcmsgZm9yIHpvbmVkIGZpbGUgc3lz
dGVtcywgd2hpY2ggbWFkZSBpdCBhIGJpdA0KPiBtb3JlIHVyZ2VudC4gIFRoaXMgc2VyaWVzIGFs
c28gYm9ycm93IHR3byBwYXRjaGVzIGZyb20gdGhlIHNlcmllcyB0aGF0DQo+IGFkZHMgdGhlIG9y
ZGVyZWRfZXh0ZW50IHBvaW50ZXIgdG8gdGhlIGJ0cmZzX2Jpby4NCj4gDQo+IEN1cnJlbnRseSBk
dWUgdG8gdGhlIHN1Ym1pc3Npb24gdGltZSBzcGxpdHRpbmcsIHRoZXJlIGlzIG9uZSBleHRyYSBs
b29rdXANCj4gaW4gYm90aCB0aGUgb3JkZXJlZCBleHRlbnQgdHJlZSBhbmQgaW5vZGUgZXh0ZW50
IHRyZWUgZm9yIGVhY2ggYmlvDQo+IHN1Ym1pc3Npb24sIGFuZCBleHRyYSBvcmRlcmVkIGV4dGVu
dCBsb29rdXAgaW4gdGhlIGJpbyBjb21wbGV0aW9uDQo+IGhhbmRsZXIsIGFuZCB0d28gZXh0ZW50
IHRyZWUgbG9va3VwcyBwZXIgYmlvIC8gc3BsaXQgb3JkZXJlZCBleHRlbnQgaW4NCj4gdGhlIG9y
ZGVyZWQgZXh0ZW50IGNvbXBsZXRpb24gaGFuZGxlci4gIFdpdGggdGhpcyBzZXJpZXMgdGhpcyBp
cyByZWR1Y2VkDQo+IHRvIGEgc2luZ2xlIGlub2RlIGV4dGVudCB0cmVlIGxvb2t1cCBmb3IgdGhl
IGJlc3QgY2FzZSwgd2l0aCBhbiBleHRyYQ0KPiBpbm9kZSBleHRlbnQgdHJlZSBhbmQgb3JkZXJl
ZCBleHRlbnQgbG9va3VwIHdoZW4gYSBzcGxpdCBhY3R1YWxseSBuZWVkcw0KPiB0byBvY2N1ciBk
dWUgdG8gcmVvcmRlcmluZyBpbnNpZGUgYW4gb3JkZXJlZF9leHRlbnQuDQoNCkJ0dywgYXMgdGhp
cyBjYW1lIHVwIG11bHRpcGxlIHRpbWVzIHRvZGF5LCBzaG91bGQgd2UgYWxzbyBhZGQgYSBwYXRj
aCBvbiB0b3ANCm9mIHRoaXMgc2VyaWVzIG1lcmdpbmcgY29uc2VjdXRpdmUgb3JkZXJlZCBleHRl
bnRzIGlmIHRoZSBvbiBkaXNrIGV4dGVudHMgYXJlDQpjb25zZWN1dGl2ZSBhcyB3ZWxsPw0KDQpU
aGlzIHdvdWxkIHJlZHVjZSBmcmFnbWVudGF0aW9uIHRoYXQgdW5mb3J0dW5hdGVseSBpcyBhIGJ5
cHJvZHVjdCBvZiB0aGUNClpvbmUgQXBwZW5kIHdyaXRpbmcgc2NoZW1lLg0KDQpJIGNhbiB0YWtl
IGEgbG9vayBhdCB0aGlzIGlmIHlvdSB3YW50Pw0KDQpCeXRlLA0KCUpvaGFubmVzDQoNCg==
