Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2B71818C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbjEaNZi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbjEaNZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 09:25:27 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1575197
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685539518; x=1717075518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Z6mkPhTnhOwjfMWOq8jgoixoZmWg8wz1l1lZsM5GpQ=;
  b=kFiRgZnWedUIwRqGG1EaqlsSWNVfMYhkW/XAKf6Uq8CJAVWJAeG9zh/z
   qCYeJ1NHeAk/EUGSSMQQDEjqiAjob7zjWqZ3rIqyteZP+Vk30EzxUtJL6
   RNlKHynuRhWoOj0O9wMe+3Fq/Z4r2DXVT5WgVtIm/WUMa/ZOSjkGJCM6T
   kd0p9PCeBJjl9YhwaBhNKn9IABXoz3kA0DuDxEGD9+nih4FT1v0Idi0q1
   ascD59NxbtXhf9KEn4oPLh66+1udAWavuyBlmrrR9b7RYUlwUN7RwM9lO
   Cg6O7nG0G8znDRk9ylCNnQEk//C8W5zfpKLV5SQGnikyAzg2LNVFiZzss
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="232072140"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 21:25:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhOet1lUDhQ9wjXF56jPxLNWFiAODCtS4DJs40mvbIiLtQ13GMVSZ2AXR+eMvbmo7KguBIR8tB0OpIx0riA2JCLqtVrbixESA1gXP7h6RgXXSphf+Kf1Y5VLBixmIEHt5hhBU3karZL6oxZgxO3WqA+EhsDYh6jZTGk3uwUOFl73cIau1lL+r4uyNTWfVTusZ+TiJkBjmy4TuPqkPS97WzzKkVVUKRCn8xIbqJpIZBObWPHh+yauCpdRF6eVoskpmBp2rrb7q3ttIkjX5JeC7p4DwgP5YXq04Dnqujz06HRdLUYckXhZQumcNZU3iETyTtW5YKgnCtd0f02DpdQGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z6mkPhTnhOwjfMWOq8jgoixoZmWg8wz1l1lZsM5GpQ=;
 b=k+qFpS/+hCeBVNvrPeppyrck0IKUtQVfmPnmm2MXAkVVO2UWQUvJoeIxtOsgTWfpaNuYHseXaoofiQKoo7MTdQF6YP+UmcmIJiTGuPLZlk0AO4Dmv7pEimYmznUJsIz8dvoAr+AcZopIiHLgeez2nqK9tULIuXBCmZzhErSDVht0jCReO3d/vjCYH12OexikSSufz2Zd8c9n2NcBcropsfmrE4oXl2LMQQCNM72w50hOr792uOkqMx+JU8424rmU0yfkL8U84ls98OK8e27lr/AiFPIZ3WINdzdIznun3A22QUXhQrT/Caks31R416FpHfacNDdxLObe8zo/LRdG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z6mkPhTnhOwjfMWOq8jgoixoZmWg8wz1l1lZsM5GpQ=;
 b=cNirXCzHhkC4aR5OZpDvtjky8CmAJP+ZvsAgi/s1/mDxb9XplPvLhKQNJYozOki3rhEKGH8ndL8ysVBeMdwkfxKS1crJqUv6m9cMNRxMmfxptsq01TnrC6lkEwTsM5oTcXNsOOsLqDbcyDWiX4YSeD7F5HIoSAe5kBLvlZZkWoU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6877.namprd04.prod.outlook.com (2603:10b6:208:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 13:25:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 13:25:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Thread-Topic: new scrub code vs zoned file systems
Thread-Index: AQHZk77F6OZSPckrzkClECKtofmqo690WysAgAACsQCAAAFPgA==
Date:   Wed, 31 May 2023 13:25:14 +0000
Message-ID: <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
References: <20230531125224.GB27468@lst.de>
 <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
 <20230531132032.GA30016@lst.de>
In-Reply-To: <20230531132032.GA30016@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6877:EE_
x-ms-office365-filtering-correlation-id: f341dfb7-5b7d-40b6-b91c-08db61da77df
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEppUHOZkAtaYBh4BqQ1WAsoMS4D1F3D7x8Mu3h8OC/LBqmutFM8SUQWi75KwOenJsVJ7uBybgvQIZL2yijz4zpSEqp5zbqG1QLSnoUy+DU+aABkzGgNKiY5cDaezRjlDx1hwVvex4T7vSFFfcSrhW7MF56m2/+WAKSNlwa2X8PL2CHBDPxqNse+qsNLIr0EkvB+keZDpS5Rc+3RVvk1EwT+sWIS8FDZoRl2rxKvbIQqJ24tago0mVk0cfybeoiap+nX6ODqLu91MvkWi6isAMIQHexXM5bHYiB4rTeuZyaYHutUyOSdVIxYOrsSTiFQWbUN9D8qqdXgTDtZLdVNKZ+c/2X+TOr1DzBR6mgHZMqbPCN6ld5nqg3tF0gITuvkJTAdyCxu5IiD4ztldffrRD+SmWeCTQAczBYJjdTzJN7/2ABZPewZ09TRgna3Gb0gIeJaLQA4dI4xekPvm+fLpmohlZzROqW/myJ+M8QoaAXlV4M0t3L2ACL98u9r0BO4wbHpgRL7HbgiLVy5T/i0GRv4SExxQ9D7II14Ipc6vUBC0Anr5fTVydUKgP8BVyxD5A2MAt0NyJ7JTzDWqINpZwoQgnjsUa/rrYGhaGzLXed70GyuQzrYht64RzuMJ4Fg7Ug5pkBalog5HcBcRaQIjEchhiIIzSM+pHH2aBou0nD7ltMkN2PgHlx+yCZJ8e1E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(53546011)(186003)(2616005)(31686004)(6506007)(2906002)(54906003)(6512007)(478600001)(83380400001)(6486002)(122000001)(38100700002)(82960400001)(31696002)(8936002)(8676002)(41300700001)(316002)(66476007)(76116006)(66556008)(66446008)(66946007)(64756008)(5660300002)(36756003)(71200400001)(86362001)(38070700005)(91956017)(4326008)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wkova3BmK1RrcGFOVWNOV3YrNmlRZVJYQTg1clM1eHRxbE1Oa0xSK0hKRG04?=
 =?utf-8?B?Ni9UOFVzZ21mZzZzVlAyRmI2TkFUdndlakdoVGpvN1ZvYy9selNYVzdOcFNZ?=
 =?utf-8?B?UUVLUzRVVlhrMFlYY2VCWlR3QTRXc2lvNU1oSHpQOW45ZzR5bEZGS1Nsd3lO?=
 =?utf-8?B?WUVYMmhpemJuNHNRbDdnYTNxTUpxNk9LcFQzR0pwOGlJQys1RHpzbUlsalBv?=
 =?utf-8?B?QjNsNnZCNktEMXNNTWswOTQwZUxvdWRSc0lxTVBsdXRDeEozYWR2Y0hVQkEx?=
 =?utf-8?B?bkUvZjJIOTJGWWoreUdua242MDQzU1dZTTBsYUtxNUpQWWlWZmxoRFFKRDc5?=
 =?utf-8?B?bU00bUtlTG96bnAwdGRWekVHakxTUXBUOUl6azZYWXY5R1V2VFVmajlMcHlL?=
 =?utf-8?B?SjY0V21pODE1K3B6dkxnQks4MXY4dXE1TnFQNmZPUSs3WmdXSWYvWXk0aERR?=
 =?utf-8?B?cXNBUTU5ZWx1V3FlMGRsT0tyRGlTeTdXOWNzY2Ruek9HWGhEa3BuNjlMb0la?=
 =?utf-8?B?N1dDSk51U3l1cUtWcjFRK09JcXByc3puNHA5dmdQeU1kc3pZWmEwZHBJSHAx?=
 =?utf-8?B?Uk9aOWhaMHN6cWtSTzRXajFSTlZsc1BySDRCdi9ZQkVUS0lCSmRXQm51NkU1?=
 =?utf-8?B?clAzRU81V0d0VlRsb1Q3amtqNkR0ZmxBWXBVcHU0SjJ3Ni81aURYNk9LRmRy?=
 =?utf-8?B?MU0xbVRVSjkvTkFGL2x1NzFuUTVoWXIzczRuS2ZRUEhDdlRNQ2JmTlVWcVdR?=
 =?utf-8?B?MnJXbGZsTGhaLzZ5OVJ0VUJYc0N5emVEL3RNZS9SVExuTTR0d1lwOGVYdU9Y?=
 =?utf-8?B?NUd6WFNwT0szc0NpOU5Cc3k4TDA3bkNsNDdEMm9hZmxoaktvOERFZFo3VHVG?=
 =?utf-8?B?WVlramhZSGdQTnJ2K1dkRVFaNTlTY0tVdUdzelVWOUVZdUZld1RsS0JpRHJm?=
 =?utf-8?B?MDJ5Tno0Tm5tQVo4cTZHc0hra0pOY2tBNEVjaTdZU0h6MWs3aWJ2QmJlZ09o?=
 =?utf-8?B?RGVhWkhZNmlWMmVyYTA1MzMrZlcrOTdhaE5lTHovcUt5MEtqSm5SSGVSZzE1?=
 =?utf-8?B?WC83Z3kvTXAweVZZTnVWTEdLUmtZSVhqZlg1bEYrOFFjWDJ6Q3YreHUzcEdD?=
 =?utf-8?B?Q0ZWY0tXdzV5bEdpM3Y5VHM5MGRXV1Z3KzZnd1VMZW1VUGxVYVpLSFJra3dF?=
 =?utf-8?B?OFdLdlhYNVdtb3RJZjEybmhkdnVZOU5nMDRmd2ZZQ2R4bHFXNkg1NlV4bXZq?=
 =?utf-8?B?c2EyM2pVeXdmSEtDN2xIdUUyRFBKRVJhK05SL0xEU2JzUFdYUHF2WXhHSHlC?=
 =?utf-8?B?THQrK2RiSkFWNzJBWTdSUVdsbm5DbllXMGR4L3BleWJPeTFyWHIwRUtXK1Vr?=
 =?utf-8?B?QWc0Q1o0U3hJRGprN1I2Qk9xZE14bzRmTk13OWRUdkQvd3E2SmJ0cjVtRWQx?=
 =?utf-8?B?YmF4WXBCNlFDQVVpa0hEa3MwYitRckozNjVPZjUzSnV0TzZRbGxTV08rRXFN?=
 =?utf-8?B?YUFNODBFOGxGa3N4TXBjUkVWRFkyNlJUZ281U3VXdklHL1hlWXhBM3hVblEz?=
 =?utf-8?B?cDVIUyttZ2dNdkZ6a3ZTZnY1K2lXVUFDN1lPSFMxNkFtaENOUDAzV09ZSk92?=
 =?utf-8?B?SERKamNIbDRHMzJsdnpNam13N2kvWE1tNHVpcHBZWVo0SjNIOEFib1hjRXRo?=
 =?utf-8?B?SWdhbkR5MnNlMnlSZ0h1L214ak8ybGw3dXZpZExKdTFwV1ZDakk3Vm1rQ250?=
 =?utf-8?B?OUNNNTRHRG5XV3hrVUlua3YzSlVGQjZQdDl1YzhKdVMvRWVsQldyazVYRXEz?=
 =?utf-8?B?TFRPVCtRQVpMWnFaOGdnOS9RK0YxVnk2RTZMVldmbko3cFZqSWhyNFJxY3l0?=
 =?utf-8?B?MXVYdSs4UDlscGtqTFdITEhtZ1Q3WjUvNHRoTlRMME1aMGxPMkpHTWlzNnZZ?=
 =?utf-8?B?bCtYMVFWTUFYZmlaR0ozd2JUMVBZdlRHSUpHY1c3ZWwxK3FEalZJNGlIRk5w?=
 =?utf-8?B?eDc2WHJBVU9HS3ZvcDZLZ0ovU29yUUY0OXZGRW1IT2dGbktkQzFYZVdCUmY3?=
 =?utf-8?B?ZktFWDZ2TDRFYXJnVHpqTjEzVHJKeFd2T0IyUk1wTlhjNGMrRFZ0YjRNWWly?=
 =?utf-8?B?TVlPRnMxcG5EM1F4azc5OEl3RTU3cjBKUFF2dE4vMy9ZNms4L3RxZzA1aVR0?=
 =?utf-8?B?SUsyQ0hDaWlsMHpRWnkzNDh6ZmRWYzRUUjhza2MvMGJBSGpwMnBOUWY4RkZG?=
 =?utf-8?Q?Q7VPeNxxtUFwKctBPoz6kRMSz+0oj5jq4BPx4QanfE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D50178C809A99A4285A857074ECF34BD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AiJj6N763V7KA5PsoDBNcaB9YZcfhScbG8FBhtxUqftrEtCGK0I1P3k+rC5VcGObNzRhn6xdhjaiUjw1YnVty+WDC4xjiPQLTJWzBnxZ2zKybYW2YwuNhNV/O+PuULOjUAIJQIMqQZ46ZNXJ/rYlk+ZHZUNRIRil4gsNu4Wtq6nQef2dnKlZum44pTM+zwmebH8nxyb6PUonbC//bxXoAtunvHlZx4VO1KvqF4HgcmpepnI4dyZru7+2lYaLvgf25hAkIdJMEoIKPIqJB1E56ky75m7pLvD3e/6paUV4znQ0h+Pdzkfu0mWbUVG/YGIHExCCmKmtJwS7RrbpK3oEAEVWrnSZLlH9OzEnP7Xpq6tXxzyMBaFrLadhk8qyY31o8jTRjaR6KU2mjX/FVKrI7m3WchBykeMzorrQGPxVrpv9sw/z0NS9tZCpp4hUUzQcK2OBrxJ7AZH26agPXCeFY/WpWM0FuurpAc9PGjAjjn0EvAcWBH90U4M8aKeVsaKi8Qcs97vVKJY1Aio6Hm1MibH2rtz/FDQfvakl04bZGqy4+XhkFiYRExrFfkbUsPdqa+rBsIAurenPZ4i5EdIFym3F1gB+rwotBuh13dIgUxPrA4rmXr47w1Zs/Wp68NWrE69kNpOqOvYzLdYK4qRnPJAgxu0pedGmjfFfmAqtj/PwMHRpO4WDR4DaUR55b77XoMPvE6uCtOtO2Rc+RjbTX4VAzNnNsTyhAkG5J2KXULPY/20JVwF+2hvn4Cw1Rj11QPOcDr1eN7pNc5DpPYgdpzdZWAvws5OBy4fZVKgsI1LPwfkv18RfAMBYzRCiDC6M
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f341dfb7-5b7d-40b6-b91c-08db61da77df
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 13:25:14.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UPMo00BQ6lfNQy2fPbmZxf4vgYWnCLExiEt7S2bUtT2sMBOaRLqm6g0LUaL+Q3A7nXB3WQazJL41ZVCVoy9HAzUUaHhKG23lMuVFFaIbTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6877
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMzEuMDUuMjMgMTU6MjAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQsIE1h
eSAzMSwgMjAyMyBhdCAwMToxMDo1NVBNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBTbyBpdCBsb29rcyBsaWtlIHdlJ3JlIGNhbGxpbmcgYnRyZnNfbG9va3VwX29yZGVyZWRf
ZXh0ZW50KCkgd2l0aCBhIE5VTEwNCj4+IGlub2RlLg0KPj4NCj4+IFRoaXMgYWN0dWFsbHkgbWFr
ZXMgc2Vuc2UgYXMgdGhlIGN1cnJlbnQgc2NydWIgY29kZSBkb2VzIG5vdCBoYXZlIGFuIGlub2Rl
DQo+PiBpbiB0aGUgYmJpbyBzbzoNCj4+DQo+PiBidHJmc19zaW1wbGVfZW5kX2lvKGJpbykNCj4+
IGAtPiBidHJmc19yZWNvcmRfcGh5c2ljYWxfem9uZWQoYnRyZnNfYmlvKGJpbykpDQo+PiAgICAg
YC0+IGJ0cmZzX2xvb2t1cF9vcmRlcmVkX2V4dGVudChiYmlvLT5pbm9kZSwgLi4uKQ0KPj4gICAg
ICAgICBgLT4gdHJlZSA9ICZpbm9kZS0+b3JkZXJlZF90cmVlOw0KPj4gICAgICAgICAgICAgc3Bp
bl9sb2NrX2lycXNhdmUoJnRyZWUtPmxvY2ssIGZsYWdzKTsgPC0tLSBCT09NDQo+Pg0KPj4gV2Ug
ZG9uJ3QgcmVhbGx5IG5lZWQgdGhlIGlub2RlIGluIHRoZSB6b25lZCBjb2RlLCBidXQgdGhlIG9y
ZGVyZWRfZXh0ZW50Lg0KPj4NCj4+IEkndmUganVzdCBxdWlja2x5IHNraW1tZWQgb3ZlciAiYWRk
IGFuIG9yZGVyZWRfZXh0ZW50IHBvaW50ZXIgdG8gc3RydWN0IA0KPj4gYnRyZnNfYmlvIHYyIiBi
dXQgZGlkbid0IGZpbmQgYW55dGhpbmcgdGhhdCBhZGRzIGl0IGZvciBzY3J1YiB3cml0ZXMgYXMg
d2VsbC4NCj4gDQo+IFRoYXQgaXMgY29ycmVjdCwgYnV0IGFzIGZhciBhcyBJIGNhbiB0ZWxsIGl0
IGlzIGp1c3QgdGhlIHN5bXB0b20uDQo+IA0KPiBUaGUgdW5kZXJseWluZyBpc3N1ZSBpcyB0aGF0
IHRoZSBzY3J1YiBjb2RlIGhhcyBubyB6b25lIGF3YXJlbmVzcyBhdA0KPiBhbGwsIGFuZCBqdXN0
IHRyaWVzIHRvIHJld3JpdGUgc2VjdG9ycyBpbiBwbGFjZS4gIFRoZSBvbGQgY29kZSBPVE9IDQo+
IHRyaWVkIHRvIGFsd2F5cyBtaWdyYXRlIHRoZSBlbnRpcmUgQkcgKGFrYSB6b25lKS4NCj4gDQoN
CkhtbSBhdCBsZWFzdCBmbHVzaF9zY3J1Yl9zdHJpcGVzKCkgc2hvdWxkIG5vdCBnbyBpbnRvIHRo
ZSBzaW1wbGUgd3JpdGUgDQpwYXRoIGF0IGFsbDoNCg0KCVsuLi5dDQogICAgICAgIC8qICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICAgKiBTdWJtaXQgdGhlIHJlcGFpcmVkIHNlY3RvcnMuICBGb3Igem9u
ZWQgY2FzZSwgd2UgY2Fubm90IGRvIHJlcGFpciAgICANCiAgICAgICAgICogaW4tcGxhY2UsIGJ1
dCBxdWV1ZSB0aGUgYmcgdG8gYmUgcmVsb2NhdGVkLiAgICAgICAgICAgICAgICAgICAgICAgICAg
DQogICAgICAgICAqLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBpZiAoYnRyZnNfaXNfem9uZWQoZnNf
aW5mbykpIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAg
ICAgICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IG5yX3N0cmlwZXM7IGkrKykgeyAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICBzdHJpcGUgPSAmc2N0
eC0+c3RyaXBlc1tpXTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIGlmICghYml0bWFwX2VtcHR5KCZz
dHJpcGUtPmVycm9yX2JpdG1hcCwgc3RyaXBlLT5ucl9zZWN0b3JzKSkgew0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBidHJmc19yZXBhaXJfb25lX3pvbmUoZnNfaW5mbywgICAgICAg
ICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNjdHgtPnN0cmlwZXNbMF0uYmctPnN0YXJ0KTsNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYnJlYWs7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgfQ0KCX0g
ZWxzZSB7DQogICAgICAgICAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBucl9zdHJpcGVzOyBp
KyspIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcmVwYWlyZWQ7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0K
ICAgICAgICAgICAgICAgICAgICAgICAgc3RyaXBlID0gJnNjdHgtPnN0cmlwZXNbaV07ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAg
ICAgICAgICAgICAgICAgICBiaXRtYXBfYW5kbm90KCZyZXBhaXJlZCwgJnN0cmlwZS0+aW5pdF9l
cnJvcl9iaXRtYXAsICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
c3RyaXBlLT5lcnJvcl9iaXRtYXAsIHN0cmlwZS0+bnJfc2VjdG9ycyk7DQogICAgICAgICAgICAg
ICAgICAgICAgICBzY3J1Yl93cml0ZV9zZWN0b3JzKHNjdHgsIHN0cmlwZSwgcmVwYWlyZWQsIGZh
bHNlKTsgICAgIA0KICAgICAgICAgICAgICAgIH0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgfSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
Cg0K
