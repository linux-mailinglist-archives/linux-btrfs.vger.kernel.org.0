Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81666938B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbjAMJ5w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 04:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbjAMJ53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 04:57:29 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35725EE09
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 01:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673603715; x=1705139715;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ya5kcGfk/ycYkhm4qCkHetXMmFDkJfd2qn5ZxRiqc10=;
  b=iiLCJukJ/itwhf6Kxf0LfwcT0EEM8DSLm5VTPi3D8pAplz8OCwZQ+nrY
   V1Hc+E3hYxghK/dP7rJRmDRYEAFTIzTTmZ6hotTSN3nFcmfgqNBj3Ip88
   z5e1czRYbvIz4+4Cf6toqJz/jsdc0sVAERzKbsAW+phcxKTflKj/aLUVb
   ft1esKIH7qCGt/c0bLbDf8eBz4p1oYZEb4YaFucUD4/AF3MWKQsKGRL2X
   KYHhSNebj8qekm7nYhFG+Ohkilp2hFV0m5SGgf3P0d/xWnjQI+zaMPkjU
   Bv4+rK1dbsaFNXiyaLSPSwCVlCrQtKJDze8astTcRILcJMsWXb8V7MZN0
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,213,1669046400"; 
   d="scan'208";a="219065633"
Received: from mail-dm3nam02lp2045.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.45])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2023 17:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkxRCIzc9ju4/reoHN6HarIR8HAPi8oKaQzjzrkRqJx/uLcfar+uYlQcLnczmu//7LqdkxfYuyXnVRU1kZjOFD42XP+fq1iYgt7SflxIYxfTCFxrCb2UQhBnpFV0DNrOoPYwYeJrkUmG/ibq1P6TJ/rBsjDKSelbwIabq1s/OXLph21kMuX5TrG2Or6GpRTeAcPoZMjEcp7EPLSVj1RDo4fVw/VrJqVO9tTrm6Rl/wNqbM/J3iDR9xO+NgOwFqoHTLaZo4fq0SV+kCu1z7KTZFksaFx9W+MsI2qYSti/hoEQahTlNLmGkwzPrcRS+Wb0EWZphRNrEuVgpUoAc/USYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya5kcGfk/ycYkhm4qCkHetXMmFDkJfd2qn5ZxRiqc10=;
 b=bhkF0lhclUMZQVZTu+W2uRVx78mJOtnwvC7uDk3AfFXCnuoEeCUj9jWQ2+NNRLhz6bRhVseKj1B8Yjkn/lSMpNURg2bcwD4gYvrLblous35ZFMbJX5ZaTpC6u4fPciIMmMdYb5Ov/KKSiOPLUuRjDdGuUEE8M5q0FV0xqJQKLvEdVCOruqLkHTpuBQ4yvMCsHbp4xuLGzw/b9QGurd7j6NHTTOl0m52iNw+JVjd6yHeZ5gcyoLlMa4Pwszmrhur6HYOrdDmKrGNvcdLsVOOr0gIm5PZX5cJphOVoWbUzXvNVAPJsYKJ+yBBMt1NFDFxW8DD3Y7pJ+mK4XtqHoKNy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya5kcGfk/ycYkhm4qCkHetXMmFDkJfd2qn5ZxRiqc10=;
 b=dzK5nmaPkQJS91xYK0r/l/Rc3vezlLlgTiYEnh9V+YPRc5+4ffNd0+5CQqwoLcHHGf0LIlVg3EN8pR8PiCbbTxx/0Aum20HMKq7N1Go+dxFy4sXFq6Jw5bbpE8i/t0iKZYUBjZ6BDOVL9nZ4v7J2T05ZCK5E8KPZr5dYlkRFdK8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5226.namprd04.prod.outlook.com (2603:10b6:5:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 09:55:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 09:55:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v4 3/5] btrfs: introduce size class to block group
 allocator
Thread-Topic: [PATCH v4 3/5] btrfs: introduce size class to block group
 allocator
Thread-Index: AQHZEOJcCCRhutlOXEuLcqSqd+5ZYK6cSHuA
Date:   Fri, 13 Jan 2023 09:55:11 +0000
Message-ID: <d5fecad9-30fe-56be-070e-c319d63355d1@wdc.com>
References: <cover.1671149056.git.boris@bur.io>
 <6f1b902d4284c1139caf7abbbc32c85960a0f2d5.1671149056.git.boris@bur.io>
In-Reply-To: <6f1b902d4284c1139caf7abbbc32c85960a0f2d5.1671149056.git.boris@bur.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB5226:EE_
x-ms-office365-filtering-correlation-id: 52627431-263a-44cc-fc41-08daf54c432d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m13WbveQE/sHCiIvEnFk/NEYiA2U9ZLLevsvxy9sTFawPP/jwdkgP9xxpb6w8Immdu4AQT4d/2QxPr1pBITRcsqMs6pBZzHS1rG2nE9kRN4Qbz4Qj4vxo9PXdQdpUPKzXjdbdmIyVUs5oVKE9iQwtVCVC8+vPnyFniXe3gJHVmRMfleModpRBYc6D0h8tVVyLXb+j22eFFZkQbeImTji7+JPss6G2w/icM90JAIqZaTwznD9hbcHHkyJwzN6mKff911Ii99dTMeazBYBqe//ytrHaAA58LQvIIsNiIKw5iB3ju4TZlLLq3Rs/0FJBdNy/10n4KvQ25TDjAeE1mr5XcrlzsEb1W6tGf1caiaCZh6PTKD6hkGD85raMAsmN7zzW6tnoK4k/joOsLO0DUAn6eB0WQXPOqq58eJYWU4pCQ4oc45yaUj7+prLHByWcCflaeyAlsekrqYqN8ZdKVlsT/GnBy7zyM8kn1FzEDmo3dn5JIomHHTxg+QOjAmmlColLZXz9Sb2JYwJZyA0iFiKO/frWbbGTSYkONyI6ZJH85RRZ5SAxfNexMKuIb+3MGNXh8gXphi5mD1UCK9adDfFos8Ox5GPp9fwVoyg/5/R6TuppqIHZdsH63l50iNClsE283+Uowj5+7yJz1F/1kyKJNklDEMsmteiu/LotBm2XeA4H2DJcH0yS/925/k4dFaT1EDXUTpS5RpLI5Dyv1+FQVppgtDzyuzXtUQc4oe0T5sj3+qahj01xMGorXCt4bCB313oLjxMeXBiGQ8uCopeQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(6506007)(186003)(2616005)(6512007)(76116006)(91956017)(66946007)(86362001)(66446008)(38100700002)(38070700005)(66476007)(31696002)(64756008)(36756003)(66556008)(5660300002)(122000001)(478600001)(8676002)(82960400001)(31686004)(2906002)(110136005)(8936002)(316002)(71200400001)(41300700001)(6486002)(53546011)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3JEQkNpc1R1WGgrbzg5T0lKWnEwVHNSRnBOck1GWjZxZWpqWDJtdWNIUFZW?=
 =?utf-8?B?TzZCc1htT3laSnB0QTVGZXFqU0oyeTI5YnAwemZTUDVPaTl1d2EvWHBZYWlM?=
 =?utf-8?B?Y0laU3FCaTF4T0NWOEVxUzc5RXprbng5dTZJZEllWS92dGNhQjZUNUV0QVZh?=
 =?utf-8?B?bE81MVlkNXlaNUEyd0RubkF1dE9QNjJkazlpTkFJYnQvR3hSeWxrZ1lEWHY4?=
 =?utf-8?B?YnJQeEk0NkVDUHpKdXdBVFZBaXFoN0tuVlV5NjVpdVRDcXovYXlEMDZid1Nq?=
 =?utf-8?B?dDJSK0IwVllzNHVNMlptRnV2L21UOXk5cWl5QXV0RlViTUxMQk15cUlLenc4?=
 =?utf-8?B?ek1RSGdCQ3dncGlxVndzZ0t4SEZIbWwyZS9wb0FSZnJJajlHalJoVzVUeUV6?=
 =?utf-8?B?THBmYUUxbEVZVko0SWFFeTlDbVo0anY5ZkFzZG1nbzlwL0VFZkRWdWpPWXYw?=
 =?utf-8?B?QW1MeU8xS0FyVFU5UkJIQnZNcXBTeTgyd0p5QUNmcWxxb2t5MlE1VzNPaVZW?=
 =?utf-8?B?STlDM0JoUFlzVm5FZVlLQVhNSE5HRWpWWTJHMHUySVM2VGUxeTVLTTErU0py?=
 =?utf-8?B?MFhjcDh5enVwaWxUOFcva242R0ZMWTVrQmdETEx5YVREbER6bFhyL2lraXJP?=
 =?utf-8?B?N1dKY2lHdXFMMXQyWHpONHJMeFJqSHp5ckJPQW15R0x0blNoTndEVkpWOVBN?=
 =?utf-8?B?bU0wVk85WWVacC9tN1ZGalNRNEFabUtwbTNiS3JtSUdJZUZsNVJwOVhXQzQy?=
 =?utf-8?B?L2F5M1M5RXBkaTJBRUZGbHRITm1XdDc0Vm1LblNaVjhlbS83SFNvNmpYZ1Vq?=
 =?utf-8?B?b2JOK2FLRzA4UUpNdWNLWU1MRGdPVVhpMXRRSXVvTnkrWTlBMk5uY3ZGTXRY?=
 =?utf-8?B?ck90d0M1VkszaXJZTmxqTTduUmRZNXRmYkhnczQ1T0ErQ0EzaDY5ZFJURDBn?=
 =?utf-8?B?cml4SDhaVXczMGlXZmNCYzhsNkk2cStwWGdNZENJZEJZd3ZXR2U5ODlWaGN6?=
 =?utf-8?B?ek1KZkNUVnFvTW1SS0E1Z1Bmc3czYmxhczV0L1RuZFJuQTBxc0libXlRcVFJ?=
 =?utf-8?B?SXowZ2M0NDVuUEdzQUt1VU5tbUJsaS9nbWJYWG5QLytWeXRwUDNNWVNtNkFv?=
 =?utf-8?B?UVhjcFFGZTRWaFd3dk5oUnJPaDcyeTBQbndMZnNNRzV1dUxhdXpxcVd5bTJr?=
 =?utf-8?B?MzB4Zk14SlFtSnRSOEN4SCtYWk5pUmFMdVhkaC9rZkVIK2ZCOVVqRGNpbVRr?=
 =?utf-8?B?NzZjcUR4ZXRwTHk0SzhnNGozaVZrbmlqbDEzRHc2Z2p1RFpzZENUNi9UcGJ1?=
 =?utf-8?B?M3JPcDBpZkZyWHZQRnBZTXpkVTc3SS9aV1l1TGtSMzhFQTFNVzhuMVZCUFgr?=
 =?utf-8?B?WWVaYUp3R1NzcStVQnFDR3hwS0duRzl5WkNkNlpPTW11Wk0zUHRSWU43UDJk?=
 =?utf-8?B?alVOQnFUNWtlVTVZclRtamhPRU9rR1RLTm1xTlcyODFtTTMrVC9ObWNwcWUr?=
 =?utf-8?B?azBsQW41Y081K1JlVlRhVWY3eHM5dHRNWjF6cGlvTitOZXgwd1o5QUZGdHlK?=
 =?utf-8?B?b1kzSUpMK2NuWEFuMUhpcWdtVzhUemdITkNRRXhpaksrTnlzSlRVbW9GZVJ3?=
 =?utf-8?B?S2FDQU9TazRkMGpQeGV1UlI4Q29hTjdaN3hqWTZxVndVL2dqMDdrN21rb3BW?=
 =?utf-8?B?bkVoSTlGOG1oNFVzZkVzUW9DQmNEVnMrdW9hc1NaWXpka05WQ2lIVTBFbXZZ?=
 =?utf-8?B?ektHRHJsTE9Xc2NwNjViaXRMQit0aHVVYkY5SDdsbHhudTkwV08vSFhUT25N?=
 =?utf-8?B?cVNlbE81aGw4dkU2bTB5cjd4aXZ5L0dJZURJTVJFOXBrUkpNUUVLNC9VdXJI?=
 =?utf-8?B?QVZjVjg3Uno3emZJOFcvdTJ3dTdWbWF3RW56OVlZN0g4bndhdCtCdDIxSXFO?=
 =?utf-8?B?UXhTVFVoOC9CcHNFdFc5Tm9qKzdTVHpPSjlySnI0V0FUMGVhTjdXVEdabWg3?=
 =?utf-8?B?ZUpDdkpXQ1IyWGxhM2hUY3BZV00vT2xId0gzeVRFdmpobmdwNlpQNHlCSW9u?=
 =?utf-8?B?Y0R2a3ZncTIxMWo5ZXVNZXA1bE5yUXpqd2J4cWQzMXpMaVlmb3ZkczBTVjdw?=
 =?utf-8?B?VDcxdnpqTFgrOTlyL2JKTGo4MW1QT09BKzM3MCtXb1IvNkttNzRJN2hGcWNv?=
 =?utf-8?B?akZOVjg0MUllTnNBUmRhK2g2anZid1pERVpXb29kYzdac3orb1NCMlZYYmdJ?=
 =?utf-8?Q?VMsQDbsUCJcrRAOrHa3437D0Om3zZW1jsUjV+Blrew=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B145C83025F440ACD659D19D474A57@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IpSt5Y3PI49apptTeseoERgut3zupk9mUCGwurI1CzRnCbOtYR2XE06XrtGH4Bz2XVfBNh4YHYYEuZmTBaEbLvNPHGPi3sC6UDQ0Fag5zMANaSeqqgjj1l+jP84YSm8KWjUIzZbGnztrfc3Zyvx3xy5RanQyZrgLmTsbB90BX1+eXgApSKx9Ah+7SOSWqjLnS7pzJTlPnuTioTfJpWb/kMbCF5uTuPcNE4I/tLATZ60CRkhhM6WAj6P/rbdk4z1n6QTIoanW7YpusezrU0PPY6bJ4Nt+BjClcMiV7+IBrGgbinqmAxGDKavIQ70l2DFdAIrOP1sYESra21/r+Envphj9zfUYN5Ekbek39is+eBh6UyeYbG3W/YviyCK8eRmLyC00hRyJqEZt63kAd7zBx0wy6eZVQoWqT+6Q9IY+sOLXGfMMnq4S6Asc2VfSdUu/yDHjj+ZQieHeIaFS/xScHwY5OTUshF59J/Ku40DkkZyg2rh1K2j82B/yic0HiOTcvj27wf5F40RU53P1m2H/9+tmlp+BuY2GW2SoONaSafsxjqS0sH2qaV/5ruMfn8ywdGsXN7Uc0/zYFTE3dcCVUj/+XUpR5J0kGtYrQw4WcxKEdVGlZy09BhL0x+jBfcuVVLypWAhm9n0yjlO2DBOj0hE2LkzBhJvk8MgRtTK6sF+kFVghO2ELy180YBUoZOxDvbb0I8Hu/bp7/UcouajFu2Xlrlbg+abA8d9Rp9z/Xjl5TPwcqWy2Rk5YzdmzqSp6g832tK4j0qsWiOtD+7picPEleokIt0VLZIhjLGE2zWxt49vqAOL+c5gq8VO4eDnr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52627431-263a-44cc-fc41-08daf54c432d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 09:55:11.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6qrb3HGmbBxQ6pfXlfND3hfRWCNoSxLPPo5YX4zQEjVmMfybTlaVhuOtAM6u34Wl2//HfoCeXASJ1FVM91uvKNOa9cVRBp693TgWe4FGu8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5226
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTYuMTIuMjIgMDE6MDcsIEJvcmlzIEJ1cmtvdiB3cm90ZToNCj4gKwkJCWlmIChyZXQgPT0g
LUVOT1NQQykgew0KPiArCQkJCXJldCA9IDA7DQo+ICsJCQkJZmZlX2N0bC0+bG9vcCsrOw0KPiAr
CQkJfQ0KPiAgCQkJZWxzZSBpZiAocmV0IDwgMCkNCj4gIAkJCQlidHJmc19hYm9ydF90cmFuc2Fj
dGlvbih0cmFucywgcmV0KTsNCj4gIAkJCWVsc2UNCg0KTml0Og0KDQoJCQlpZiAocmV0ID09IC1F
Tk9TUEMpIHsNCgkJCQlyZXQgPSAwOw0KCQkJCWZmZV9jdGwtPmxvb3ArKzsNCgkJCX0gZWxzZSBp
ZiAocmV0IDwgMCkgew0KICAJCQkJYnRyZnNfYWJvcnRfdHJhbnNhY3Rpb24odHJhbnMsIHJldCk7
DQogIAkJCX0gZWxzZSB7DQo=
