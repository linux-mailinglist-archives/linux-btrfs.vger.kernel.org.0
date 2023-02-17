Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1ED69AAFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Feb 2023 13:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBQMFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 07:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQMFE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 07:05:04 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A65F66CF7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Feb 2023 04:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676635499; x=1708171499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=feIx1RCJX9p+XK9pr4JtVLgVAH0/3WRRs52Sgfo4p1k=;
  b=ELrlsbxoAo76sDSW6qkGK8AXIqhlINWbauQWIuM/7YTQQkOMI+wjgMSQ
   CX70Osbbs0E8lOQKBB1kFFksyXWEgZNCLLiX7GfQhutdX/HCdBJGBMSH/
   x1u/QyFIaMYjeXZxcAj74nf77Dmlb+0buHUzgh4mytUeA0ZfNIduK5pBy
   k462VyAEvIVXzgd6Nr9n20zdtL1haR1LxK7dTZHLeBeIkodVuAjfj8scd
   wr43ED61fz3ev3UqATeRF9L7ymzbxdpeYAf5iCLZ32ONSMJ2AKfsq4qoj
   Zenekn+CCsXafycP8czuMrpNLdCTvCoRFM4yVdwTBJ2qJGRHDSH4w+odO
   A==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669046400"; 
   d="scan'208";a="223358248"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2023 20:04:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdRoKFcpv0n+QmcL1bPWnkRizUOJTjSLH6Cql+y6uG4nZSRJjiCkU1tZ35mDJS3hSp3llteSvFcimLKJk60OxXqVhMXlSuUDE3cmuahb91wfpvfoWwWJUqUxT7pmLXPTBxpngHqBPq7Sf2o6VP2wX3b1ld4K+yF5YbpW+dbUwK41jXkFTDX5tGtwh/nzftO2IsvjlNbNxvCvql0PqAdXhwCwBRuZP/fvomgv1ODX4oX17u4QGIdOzbwrusFQu9nQDF2CefU3RvQZufpWDYv2xJdvPbxlFTS8EVOpHbmhpbeS0TsnL3u5Mg0QoS46gPR6a4FtMy8IEy2o5zyQfgr9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feIx1RCJX9p+XK9pr4JtVLgVAH0/3WRRs52Sgfo4p1k=;
 b=lUuK+EwSPvmaETyle6LApX21BIUuZBPXCKxE5JsGBfLfmGWcN4QcFojoo+IXpQ08kcNEVJR4djz40v/K0zR/NGHe6yviQFmzhzNMLRhX6+b6dpA3/HV2ptpeneikZq4vyI0yUjyxGQ4qoFgT82IeGT2MejGHWY5xWNf29BWbxWjI67+lAdM61S6oXfWK4Vkhvcm4b91aDQDEQRDGU/914xo1OxIWcUdo6dcVGtP2Z/1+/iQISsK598JZqrW2TSIa6wrTl6HMWgoihPbvR/ZaAVCmMW/1QU3tyRv7+Cco45IZOHEMggfDsGTlkKaPErVdtzAqAVMP1fcMtYGYw17/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feIx1RCJX9p+XK9pr4JtVLgVAH0/3WRRs52Sgfo4p1k=;
 b=GoO1ITmf35j8lDV2zhOUJQePsIN4P0h6fIlypWW2qZeByyNEHGvaApXpmyeZydYO5vI5lcnXpGw/G3UhY5+ZOxcpjJp3ANYCX7bU97C38BWqXwrvRmuZk71aTVKTxRfxTF/XGcmYVBfBoqfe6a+xZJo7Yr16YBxHoucTA1nB7Kw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA2PR04MB7497.namprd04.prod.outlook.com (2603:10b6:806:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17; Fri, 17 Feb
 2023 12:04:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 12:04:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Thread-Topic: [PATCH 06/12] btrfs: move the compress_type check out of
 btrfs_bio_add_page
Thread-Index: AQHZQiSqowNK/KIlVEKF2YLvkwLcZK7TC80A
Date:   Fri, 17 Feb 2023 12:04:55 +0000
Message-ID: <6c18a05c-fea3-8bdb-a51d-fa19f1fa151d@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-7-hch@lst.de>
In-Reply-To: <20230216163437.2370948-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA2PR04MB7497:EE_
x-ms-office365-filtering-correlation-id: e76a9678-b394-44fb-68b4-08db10df2ed1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kifO3//DlVEzElfkxqtDUtP7IVEujNn6jMX8pwL8Aup8szbN/zVyLERVNFtmZmABCuCA196Prwz/cdlS6WIgkRoDGSGwg/xFiRZFbojTn99u6n7SYOIABB8ciOp9LG2vkHW678fWFeRHY7GBgB1TNmiUsizYxAy4Fa0p3JxpDPnsltKrgsRTX+gdRFwxKB95Kg83n7Tu8aimikNcwEmIT8y16hxC6eXM9JJTGaHROHwL8dTp2CfbCNasSL81nxzTcrPrhqP76B8bwTtpCIChs/X59FALATFkjNR0Kywn1/C+dBS1JqsqKb/mETIx7/ulJeoLGdEUENnVfrM3jJJzM3bebwQSBsxnq0RAhcMfYKBMs+FDpSaX8eBI4SOuy9JUEWO9LyfKY9m0BwKcgNCh/4s2Z/oRryDVtAnhCi4Ch4+H66+5t5N/U5uVG4jaIv0S2sBPwdgPEnDNQAH0+b9ViOEA6NR0lOE6BzR1ZUnwbiWIjIQule1FAoZQkFfhvhH6Yxom4mTGxv1UHShUF+Jvu3vkErxM3NXnbWGrj1R2InTgg0Y2mI6FK5QY28+kcLK2Ysg0E2ctK1aCTzLixXen84mjWVAAut6YRPkjlAXfTzc8Z3kVmruOZgEJvZ5dt9QFvGnLpUrbAmHiH+b27ofkh/AmKycdJhti3QJ4FrThyMdB708NJF8rt5TkhmLZc/Kt/Sth9s6U+B2bCY5ZMhInLsH3uBaeztpyKK1F524W/ZkVIUv+SN5ZRNQQPT34v1rdwTCajg6ikI6rbSsmVS/Urg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(38070700005)(71200400001)(122000001)(2616005)(5660300002)(41300700001)(6486002)(36756003)(8676002)(64756008)(66446008)(66476007)(66946007)(66556008)(4326008)(86362001)(76116006)(31696002)(91956017)(110136005)(316002)(558084003)(478600001)(8936002)(2906002)(31686004)(38100700002)(186003)(53546011)(6512007)(6506007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K25PMll0RlY4VHE2QStwQitpTFJDajBoc0loSXhtNk54NU1kWkwzNmVLR0FK?=
 =?utf-8?B?R0lQNklhMklxMDdieW1FNXRxaElkamlKd21mbmFjZ2wyY3h2d2xreHJIOCsx?=
 =?utf-8?B?aE1jVEczSlVBNTl5eDN4ak4zdjFLVmZWQVR6N3BMc1FEa1RVUWxoSjhnTEI2?=
 =?utf-8?B?T204dGhaQTNtTFlscXpsWStPVTA4R0F4dko4QkdQajQySHlBZzk3UDZqb2tB?=
 =?utf-8?B?M0FXdXhINjd5blEwQllPSkRiOXRQdS93VmtPdkQ4b3pYakJBTms0d2xpcUl2?=
 =?utf-8?B?c1I2cXB1QWNnS2RoK3o5c2dEYWlMZUE1bmlxVGUxNE9IanpucDh0a25kemRj?=
 =?utf-8?B?NUZzdHl5R3lMUFNsUVorOE9hMlFTQlNCMWFkUXpDWkpLNG43QVdJejJKN3BB?=
 =?utf-8?B?NzBxZjExWWlXdHlORkJwZ1JCUmc0citSdEtWcTQ3N2txQWV2S3hoZisxeStP?=
 =?utf-8?B?emw2ME0zSWlkZ1lXWUlZeEhsSnpwS1dLbUUvdU55NTZHZ1gzSnJWZC9ycVJC?=
 =?utf-8?B?c0lJV0dIQVRUQklSUlo3N29XejJhV1V1YjFUWkJPaFpFSVBhYXFRbkkrSXBk?=
 =?utf-8?B?VTFDVE1oeDAvbkt6UjMyWkZJZWxtQ2xwdFg2M2w4aDVwRHBXdnZwclZMUitt?=
 =?utf-8?B?dndDekpST3VhV3VHRmZnR3gwdmFRSGZPblRlYzJXT29BdERuMjFzZzRndkJV?=
 =?utf-8?B?MDZqSEtONEkrZ3ViY3ZkZE9XSVdNcVZsZVFUNExMR3dvWmRaM0VmcnMrZ1ND?=
 =?utf-8?B?M1FYNUNkUG5oRGV0ZWJObk45b1BTQllzb0tWcjk1WmZ6dmM4Z1RtZm1JN0Jh?=
 =?utf-8?B?UlFXRXZ0YUxkYWJVa2NMeWJidm9OY1BlSSs3N0U0QUxwQytCd1QxNFpsVEV5?=
 =?utf-8?B?cklsL3VwSVloRTBlNU9ZUm1zTEFGTWI2cUdBQzJaeHgycXFldkxOcngrVmJR?=
 =?utf-8?B?VExTUS96bHRrRXlxT1l0aTJFcWlnaUxhVFRaRWZyZ2xVMlVxejRaQ096eGhV?=
 =?utf-8?B?UTNna0ppZm5FNGorSWRRQ2o4MVhaUVZmQ3p5YkhyWDh1ZmtSMno1Wk5ZTzQ1?=
 =?utf-8?B?ZW9kVXBFTlZVSlRTa1dCc1JhcTBybndXdkVxZDk3Q0lEb1lXb0t2Q1RmbGpX?=
 =?utf-8?B?ZXhLdEpseFhyMUJ5TytQQ21nRnM3U2hZTzZwZVduUVpPdmZsNE1PeTVaMTMy?=
 =?utf-8?B?SDRidXI2OFpGaks0UTFUWlNFb1MvdmR4YVFMa2tYNktmNm1FR3dzMWMvVnJH?=
 =?utf-8?B?VGdNOTZoN1gwVXMzWVRKd1ZQL0x2dUw4UkFyR0VhUDNUT0V2UUZhQmN6UHNZ?=
 =?utf-8?B?QmV0Qk9Zd3VEbWdTZWp5KzlFTEZEZEI2VUxaVC9ySnJEWFN2c3A4aDZEYkFv?=
 =?utf-8?B?Q0prbTZyVTZ5ajlwbFBCSlRQK1dUUEhCelkwdkdRN0dnYWFBKzBscWZHZCs4?=
 =?utf-8?B?MmhmRHFJYUpBUjYzSmY1RWhwRW05WmR1U090aDk3TVhNZXdlMkNaNWVrRUty?=
 =?utf-8?B?YnhkaFMvcDV2cHg4OExwbmtEK2MvbzN3N0hIUHRzaUZNbUFPRnNUcVNWUFIv?=
 =?utf-8?B?NlFUcmM2czNjSzZvdlNDemJ1MUFvTllaR3RBRmdzSUZuVFZqSTYydEttemd6?=
 =?utf-8?B?RVZzSWJ4TEtua1Jja1AyV1ZvaHNNK0ZraENQdEZ2bTZROHlWMjBXQUpvcktJ?=
 =?utf-8?B?Skh4bmFTUjhzaUIwT2M4VFJhLzN2QjZoRkUzZWp4cnppdmdUenZNckYzQ1Jx?=
 =?utf-8?B?Y0g1WkhuUkQvZys5OVoyeVRMK0htalNVTmtwUXhsK3A4Uk9LbDduWVQvTTUz?=
 =?utf-8?B?Tld5RjNDQzFNM0txSUhtb2NkSW9YVTliSmFRaTVGL2dKZFFXUy9ETmxQMmk2?=
 =?utf-8?B?UDE3K2t5L0R1bWZOMG95SStndXd5aW9UeEh0R3ZKb3pmQ01qRVdNMzMzQi9K?=
 =?utf-8?B?MlJiMXQzMkRCZkx0WjlMdlV3SlBLY3ByUVo3dEs3clRPRzNGc0pUTE9lZDkz?=
 =?utf-8?B?SzBkYjdqK3RIRFZUbFpRQ1VkY3FQZFhZM21IeVpGZGlOM3NyckdNV3ZaUmht?=
 =?utf-8?B?UXFTTkZNMFdBSGJmMHRGTzNUWEtabkU4WU1OV25OVjZJZmJqMzVJcUd1V2FL?=
 =?utf-8?B?L2dqOVFtVzdGZmJqaVBXSy94ZWNTeS9hcmxLRXNxekRqQU9XZ0NBdXNISzRm?=
 =?utf-8?B?bWxIcHlTSkcvUG51anYwNUtGLzBIdk8wUU9kTkFsdXh0RTg0THR4dXJqakxB?=
 =?utf-8?Q?pX2BNJDvrl41HKMnq8hSXHHGcXKtrRcnO/6+scNbW8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4482B3A00121404F9AC51D54E495ECF8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2vgncu3GQG4iGkW9HxJCT/vH9zSs/Grlt3clI0QJr3sVCpJu7t63INUjwNKvZVawzruBAFHIA7ZJgRDC51gyEEGht6RMty6LZKrTUr7Dnn0eFc5p/xPQhMfxwBGhaXoyrK1o80i1InN6mDoSro/FdMbCNkNJkvMCu6Nhwf97V6WvkNiNOgdB8XRvf7gD7H147vk+DRC9UL8nNEQV9WMWZPXVE7ITIayhFXHG8mMji2mvhjFu8noesccZuuQxxhhKY2dRBEABygWQQDpJFIqa+Zn7/a6QvXNlbkQrshgrnNfYKHhjndCXXVEv3gppSdvCmKYxUMZErTVAfa5e+zbDGSKLGWIEoKTQOpLcKaixSAKEFfEogiO/ZvjOo5/4y9kzid/i3p7Kc17oRSxxO2EPBH7geYZYDzsX6YNLT2pGFQuGooQ91T9KkxVPmYdZk1VHddloN1SG2y/KzC2wOzVxuzLIx+W170FcRAFZXYYmc4G58T06SVwhMs5VlTFSVPHPGfyJP5tLZByIn0jHLeMwjDq3CAWfW4HurhRvV9M8anA6nd9zBKCoGa11/1IWatmaHzwyQaI4V/7MLPFjiE+1E4rGO4t9iyoRqmnvoFYAFZafFPMqcyywXQUCC28Q/Uep6r6eqRitigypbbA9E/tZtXR7UEC0of8mgEoRt9b0/EXRt3tzgRvF/hUHZLSK9GRb757ZFyK9HGig/pzXSzJOVI2Oc1pfdJS4mq6haZoKA9tRzYKmPln+Tm3S21lCmD9WUUOPXbTghMIIiL/byUlvnef0vY3oxbdWi/SsEUdcwgdQzA5+6D9JBjBLpmHZ/VbVkQcQM0B8+g47HyAv4tpuSmED9m35SIhF9qyr0yh6OnlLfQ2WOZW/LZCkcP8JS5+p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76a9678-b394-44fb-68b4-08db10df2ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 12:04:55.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bx7EFfA3ZCvsMXVBrj76xJMo4NJ46kurfPzKo/qAlUOZJ9Ud/DeM2RYFvxNTtgFyoYFoYwE6Me1AqjqxiRfUNgSsCtXQ9+wIrqvtXEzFvkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7497
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTYuMDIuMjMgMTc6MzUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiArCQlpZiAoYmlv
X2N0cmwtPmNvbXByZXNzX3R5cGUgIT0gdGhpc19iaW9fZmxhZykNCj4gKwkJCXN1Ym1pdF9vbmVf
YmlvKGJpb19jdHJsKTsNCj4gKwkNCg0KRllJIE15IGdpdCBob29rcyBjb21wbGFpbiB0aGF0IHRo
ZSBhYm92ZSBsaW5lIGFkZHMgdHJhaWxpbmcgd2hpdGVzcGFjZS4gDQo=
