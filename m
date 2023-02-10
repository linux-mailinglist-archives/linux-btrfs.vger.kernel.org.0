Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292B691A38
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 09:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBJIol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 03:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjBJIok (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 03:44:40 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC91910DC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 00:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676018679; x=1707554679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u98O3w/udRQQ9a0GszJAJ7s8n4u5ljclf3LwGZ1uvTE=;
  b=ell4MeDnCk99lqAWzMyzKLMDM/CDLQVsco9czUtS0ybfU7sx0j3R/cRx
   t9PJCUetLRgBTdADS0KmexNe971esK14abQ78oyVszppjWxD6oh1m8Hi0
   GTv6pJ919r6geVc13Mu+aDVtiJAJ5f/l13kIkPL/T9t2VnH+XVbRdL9Tf
   cBRYxjqIVnVLneGPI9cmwYDw25S+832U8vCsp2TEDdByUZWKpwRs9Br4T
   kBiegPbzTEWlBcm2eT9LOkzsghM57L13AnhXhVtpTgHIRDrx9Wi1XiNsK
   XrsxqRjGPDGXtv6rOE4lkweeUfZ/ps2mcNrH8Tc8sNgwwTh7+RBzecB84
   A==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669046400"; 
   d="scan'208";a="223020936"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 16:44:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMH4T6nVAYLaVyCrMjLxsFCn82nK/bXiDQ040Hbu020ivWFL3O8W7biHf8GzoJRc1keu/n6FGUQDJ5iNenOlxpcpKDipI4cmCR1bzR7JPOtFvZBsqN7fvkti+yCU8d0V7l8v78j9GOzqvj/W/Cz8GUatmC9sVBUN+9+4x/NUTC4T0Ef+cZhJoB34h5ouU8IJ4ZChxmUKrafthoEV47AfidsWRCU0PFGsVd2Szq2MzqsZ7UjnIMfyc7RgV7JEXDWtxvB55jLO1+VnGRxay7xk6X9GVKdfSGKpTHoBpaFfz9UKpJVljfMn29eonZPfkFOd/Jlhw8aDoJvhq4lrJTvRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u98O3w/udRQQ9a0GszJAJ7s8n4u5ljclf3LwGZ1uvTE=;
 b=dPEbksXYSMoecSIEjLaoySkbgb1/AecAeIBSk8wc/6iKPReeVcxZ3RHjqURepyDIy4f2nuhZA0wB73tinyDE/YqwVlk/t+V7nuwBZh9eEOji61/SrYgqEBG2wspL0WaVo1h712R7emdc99jqyO3WXYPi4wfrcOJZIChmvEY3SCTQlfF7cTyWaNCtsEna2nqnm8xmNHmdROGcH6D7TDe2YVOFs7p1bY+xNKCd1uIDSn+wueMIABQ8hXknwa9zVEaNjmzCWte3z4BpXsHokRspzuP2M42WrlN6Z9Ezn/K+KB05/9v6Iq10PyrS+/cV7IzDKjhBSdh38l+rLnBB79bzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u98O3w/udRQQ9a0GszJAJ7s8n4u5ljclf3LwGZ1uvTE=;
 b=F/x2Ouqwfl0bdIkrVnsavineBMoADKe13cpvOeijs5oU0Hx2ny1Xkxvr+x8+R+jVegrVc1YPoIkAEQOpq9eW4879l2icdrOqyQ+qL2yB5pFU/r09Xl+LzXtUNKvz4jckpU2IDN1CVyqutp6Ml+QBHi5y5goxXcw1bZ/O7nIF7KA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0691.namprd04.prod.outlook.com (2603:10b6:404:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 10 Feb
 2023 08:44:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 08:44:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Phillip Susi <phill@thesusis.net>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Topic: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Thread-Index: AQHZO6w01UFWKaz32kSJ4ybjKHGu4q7GxvEAgAEZcYA=
Date:   Fri, 10 Feb 2023 08:44:19 +0000
Message-ID: <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <874jrun7zl.fsf@vps.thesusis.net>
In-Reply-To: <874jrun7zl.fsf@vps.thesusis.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0691:EE_
x-ms-office365-filtering-correlation-id: 4acb0561-31c2-4754-4e19-08db0b430053
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tl50cADCgpwxDDO8AKVEmR02pTWdc0cIdlaa3dW85LYejArAwcBeAEhLblBA52f2PxtpYRbQg/qsAp6dVkZAdvPudEQKnAq32jAm+YjOur7zISAIDxxvopnTGu3OqKRysiMMbXdEsh8VqQVhb8APm/ceaPT5Itg49aKD9L3EG5VNXAK+4RSQ6Mdg/gmIePQ0WOlSqia8Xd2QqA6axtLInoMZ8duvNYZMn5zJXMb7qd9zsSHNqNzRV4KYGKkBLNHcw66QpDZQni4g+oqGyVp1cYsOkbZKAhucO2qktnhwoOQfBUcaPZfN0Hbr4bWAMBV2zP37VPBJfxs5CwY9W7ccSUbOQ+UFvxlgZKQmN0jxtDFVQYupjiRFMBHugCYu6/+VI/X1xrangZJkzBUNMtJzBicwbISpTqLhWOsbOh1/SIDAzgNIDM2DWZ7lSN0qtA+OGvK5idVC5teUw1zvVE826ZuSC48OLvPq64XtK9sv2Nf18KC9ej4TLvXhQ7sfJEi5JPvkLX9rsOM7kJ9MzvHZrAgbOfvbs4Hikrnrv6JdnMJxMnIPn4yfYAz7ndET/u8FcqQNb/HvsMbSocuBKgI4ExY4TFbabwHEi5VbQXab1gDrW3zy/FaTNSw+zqCRbs2dhtXamPnSOd2ouakdq9zNHjhApu21tgAQ+Uj2z4zdaIPXz6ZeBckBXtYZ0N/1+2wSVnnmnsXWhMrOdScmrEUXNRTVOxl+cuijdNX0KGalbNxHnKHo1weZ9ihjswMPaAxt9wZrXNWlJcFXwEIdbXjN7FXyJMjI4Px/AiZncZ/zpIhbTR5aTX8xDwHJV6IHdOIwKkRTpcZUltalUSXHca5S4B8IW58j7r/j3h3Pv8SPHLY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(83380400001)(66946007)(76116006)(66476007)(66446008)(64756008)(91956017)(316002)(5660300002)(8936002)(4326008)(6916009)(8676002)(41300700001)(66556008)(478600001)(6506007)(6512007)(186003)(53546011)(2616005)(966005)(6486002)(71200400001)(38070700005)(31696002)(36756003)(86362001)(2906002)(38100700002)(122000001)(82960400001)(5930299012)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUpHbFo5bXJsZmthaDdJODFLaUhzVlY2bVRxdWwyck94QUlBbHJBZnpwVzIx?=
 =?utf-8?B?YWU2blBQL0Z1MkN0MEk2aFUxUGxDSjR0WUFKNHZkeDdHU24yV0NRS0grM2lN?=
 =?utf-8?B?VFh6aXpPSi9mejArTUlMbGp0Z1MweWtOc3NvZXhMemh0OGNyYjFoUmRWZThq?=
 =?utf-8?B?ZnNuTUFYdXl3VnArZmJRTS9KeFI3WCtRM1lYclFMY2dQaXZjWmNia1ZRalor?=
 =?utf-8?B?T2xFVkJiMzlhcjY4ZkZaQUwwQk5pNUYwdUNQTWg0UTV5KzJhaTdPS1loNmN2?=
 =?utf-8?B?bVZYR1BJbFN6eVBXR1J4UVNKa005NGxhYnkvcDZLTE1xcXJsVGNHdThjTFZx?=
 =?utf-8?B?VlV1aUZPaFRmMGJpYmJ6dkRaVHI0YkhVY3AvVE1jOTNpZmkva0JCL2lDS0s0?=
 =?utf-8?B?a09CVVpMNjNVSjNFV2I0NkY0TkxLSWU0Yk01dmppbmp5OThSYnNaMlJ5SDNV?=
 =?utf-8?B?SHpBTTdXbEV6dVAwVVlHZmVzOTY4UmZyeWRDOTN0a2hsUVJpSVErU09hTHhL?=
 =?utf-8?B?UEZFTVZud2pJc3RCRTdSNzRqZ3RNQ1VBWThlQzAxT1lHVlA0SFdyOTEvWWpz?=
 =?utf-8?B?ZjNDMmUzYzB5eTc2RVQ2UXhvRkE5eGNZN040aTk3RXlLbkF5eHpGdHNBZndV?=
 =?utf-8?B?Yzc5cEhwUUVzVXBHeXRncG9lMURWMDB2NThaZVo2aEZKQ242TVdXa3JpU1NW?=
 =?utf-8?B?NjYwSkRjbjdSZDVadHg0S1cwZHhaTW1YdVdKNzR6VExWOHY5azZnT2lhMkZn?=
 =?utf-8?B?QVkzM0xzamtGQ1ljTUk2anE0ZmE5eGFDMTVIcjRwL2VqdkY3Mk90bXdleDFp?=
 =?utf-8?B?WUJWKy9ScWVtVy9Gdm4zOVFVclcwU3BEV0dKUGI4NjVFYUpqcUtCZUl0SzVh?=
 =?utf-8?B?cFN6bkFJanJyNk90WUk2L2xmaVd3cStWNW1rK1hwRmtLcURJcEcrb0JLVkxy?=
 =?utf-8?B?TGlpZU5tTUJNUytOZ0h5TDJieUZPQmlWaDZHTmRXRnFhUkVtOEJ2VUJjK2xQ?=
 =?utf-8?B?bHRTV21YcXh3Sy9JZW1ueTM1dU1RY3ZaTkl1Y25oRHNiWnEvcFA4dFVJS2J1?=
 =?utf-8?B?ZUc1OC94RllaK2lxQ0o5OFZxMmFxSTlnSVFha09kRzlXMU1ibFNEWjR4bHhs?=
 =?utf-8?B?NlRBd2Fhek5Qa3hlOFptZGgyUHpRVWhha1F5cVYzdlZpbkR2QTJCSCtaSGN5?=
 =?utf-8?B?M3NHbUJ0OTQ2RTl5ZW1KalluUXpOWjBTSGF4TDk2aEoyeXhaYVh2bHJabG9H?=
 =?utf-8?B?RUgwQjVHanJJZUY5NXZsU2FJdmU3dW9CWU9TYVJuaFo4RUhZK0NrVzgrekhF?=
 =?utf-8?B?c3dKMU1zRjRzcXNhSzdpVWFVbEU5c1doS04zVnZuZ3llMk13WmJYYk9qTzJv?=
 =?utf-8?B?WHV3UEp5OStQbWRnZnZLMFE0bDduQXB2UGdiZFg2Z25nOFJXYzBqdUt0MW8y?=
 =?utf-8?B?ZW5EaWxiZTNHdHBSRmVmWnVFclJlNWRXZndhZ1BqY2pLNnRHNmRrZjNwa0Zm?=
 =?utf-8?B?WWgwR1Z3TVlXN0VHMkI2OFNzcml4TlNPZDhUSkF4cDZGTkt5RlVKMUk4Nnpn?=
 =?utf-8?B?aUUxa080Z0lzQ1ZyNGRDV2hSdlBRaUtyQ2tFU1JBaTIxWmxkOFZzVFVzTVQ2?=
 =?utf-8?B?QzBJWjlyZVlKakJ2RnlBWThiNXk2OUZjSzRTemFZckV0K2ZTS2JKTWo0aDJV?=
 =?utf-8?B?bVBLcmVSaVlmQUhwZWFXWXZrb2xnZlBXeDY0SklQY2h4V2VJTWRUNUc4bVcw?=
 =?utf-8?B?b21CTkg0OFBIS3VrZElDSEVOU3lSM0Mwb1ZCN1JqVVBZdW5DcmcxN3N0U0ZX?=
 =?utf-8?B?U1dsOU1qSGdUV1VvOGFvaUdIVVFkVjBKT1NWV3Z4TE1FTUlCc2FwWmJkSmxX?=
 =?utf-8?B?ZmlFYXNxSmovenFQQjMrZHFnNWh4U2wvM1B3R2VyZVRxK2s5L0crQ2NCTU1l?=
 =?utf-8?B?NDRJV2dTZ1E1Y3RIei9JUTA5aGpoc1R2bDR0a1NkOHZLUlU2NjNFZDFYVVNr?=
 =?utf-8?B?L1d5bzVlQjVKcmp2SHFLM0xxSXp4djl1OWR4cXM2cTlvRUZXT0E2Ui8ydEJS?=
 =?utf-8?B?c29RRXRLT0p4QnMxaEZobTgxeFhCVTZ1TzhKN3g1TVBJVHVFZ3htck5GRW0x?=
 =?utf-8?B?THJyRkE2cDVNWTNBMGJEMjl0ZVZaVGE0N3E4VFFNMkNvUDdmS3RYb3l2bmlH?=
 =?utf-8?B?bDdBWU5sb2xybVd2bFlTc2FqNXFmbmRMNnN0THozaFNmSVVoejExSGorUlJm?=
 =?utf-8?Q?kJUjRO0coHATyOSTWF4jBrxiOA01An2mGmpuvfWCkQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7715804BB4ADD14AAD8C873D3A09B8E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +ghz6VBVZTVMKwIuGVz+f/mWPB7PYr8okmnsT9Uo7sSsH8NSnpC/2PqI4yoe7um3tH4YfgASJ5UJqjKCJGnvsQQs0tUCiSEGC4Fu2TR0nFFM5GVfgR6cITAnNw/Zqma7FJYfltrg5HpWtzGcx4ZrkGyFMZVY/9VCYkbSB/f9zUhLl5Nl2E0/MO/AOQRycvNXQcv5Z0GQd+iM8IN1acGP8jInNOko7ACyZKaHSZ40220Au5Zb4ndoKOItW/6jWAoSUGsd+95GSOnSeTRxqU3myaINsL4REhD36zhEljMT2LsPN0yl9YF6Bx3g3cPe7YpkebBMJnj8V6pAVDnW1aIObKVDiVas6pvP5ixcRwjo2ErS5yMi1gfPlQ0t6I6qGgKPbRXkBZO+F+T4EqFZbgwXTvuvI0PLcveluLUl9Thwo/I2g9OmbtKyQTVCu9lR+qNbio7mWr50yN1gblPEWLzBOn/XU071/iFBXtahJ2fkDSSwcRf+Hvx2DpnB4EiNCanDCsohlVgTJcVoDf2MRXzBsSqJhmscnLbadbG4UQKR5oT1KSyo1ZNM5hMyb2htG062Reba9HnsTVxA9xzDd1aHPNpqBQqp+OgRkGWYkHvqVSrn09gtW199Q4jXphIzRyet/DlVM16bOrlWqBDtsvjZ6jIv42/B0/CZBtLQCPgVmYl2LJw7dnBlEP1ZmgdJ7vZih9C+JGxGuIszsrsb4sYq3Wl0kxPVzJDW7V/zACkzoH/fjAEIYt2mbFVQQVIkRhnWS397OQGUwIpMgrLjv3WxaGeURPKUGle+e0m0y2a3y/EKxL7dTp+lEvhNd2iy0GP7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acb0561-31c2-4754-4e19-08db0b430053
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 08:44:19.9075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JZ7OD+r0s/bRfTAl+N7VRFliTBWLRexWGlAHcvpN9rmIcdWBjUXezV9r3GFHxZ/JU40VYltrz+ECneV1lG/Hgcp9D6nPycOCVBk1hdiMcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0691
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDkuMDIuMjMgMTc6MDEsIFBoaWxsaXAgU3VzaSB3cm90ZToNCj4gDQo+IEpvaGFubmVzIFRo
dW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+IHdyaXRlczoNCj4gDQo+PiBBIGRl
c2lnbiBkb2N1bWVudCBjYW4gYmUgZm91bmQgaGVyZToNCj4+IGh0dHBzOi8vZG9jcy5nb29nbGUu
Y29tL2RvY3VtZW50L2QvMUl1aV9qTWlkQ2Q0TVZCTlNTTFhSZk83cDVLbXZub1FML2VkaXQ/dXNw
PXNoYXJpbmcmb3VpZD0xMDM2MDk5NDc1ODAxODU0NTgyNjYmcnRwb2Y9dHJ1ZSZzZD10cnVlDQo+
IA0KPiBOaWNlIGRvY3VtZW50LCBidXQgSSdtIHN0aWxsIG5vdCBxdWl0ZSBzdXJlIEkgdW5kZXJz
dGFuZCB0aGUgcHJvYmxlbS4NCj4gQXMgbG9uZyBhcyBib3RoIGRpc2tzIGhhdmUgdGhlIHNhbWUg
em9uZSBsYXlvdXQsIGFuZCB0aGUgcmFpZCBjaHVuayBpcw0KPiBhbGlnbmVkIHRvIHRoZSBzdGFy
dCBvZiBhIHpvbmUsIHRoZW4gc2hvdWxkbid0IHRoZXkgYmUgYXBwZW5kZWQgdG9nZXRoZXINCj4g
YW5kIGhhdmUgYSBkZXRlcm1pbmlzdGljIGxheW91dD8NCj4gDQo+IElmIHNvLCB0aGVuIGlzIHRo
aXMgYWRkaXRpb25hbCBtZXRhZGF0YSBqdXN0IG5lZWRlZCBpbiB0aGUgY2FzZSB3aGVyZQ0KPiB0
aGUgZGlza3MgKmRvbid0KiBoYXZlIHRoZSBzYW1lIHpvbmUgbGF5b3V0Pw0KPiANCj4gSWYgc28s
IHRoZW4gaXMgdGhpcyBhbiBvcHRpb25hbCBmZWF0dXJlIHRoYXQgd291bGQgb25seSBiZSBlbmFi
bGVkIHdoZW4NCj4gdGhlIGRpc2tzIGRvbid0IGhhdmUgdGhlIHNhbWUgem9uZSBsYXlvdXQ/DQo+
IA0KPiANCg0KTm8uIFdpdGggem9uZWQgZHJpdmVzIHdlJ3JlIHdyaXRpbmcgdXNpbmcgdGhlIFpv
bmUgQXBwZW5kIGNvbW1hbmQgWzFdLg0KVGhpcyBoYXMgc2V2ZXJhbCBhZHZhbnRhZ2VzLCBvbmUg
YmVpbmcgdGhhdCB5b3UgY2FuIGlzc3VlIElPIGF0IGEgaGlnaA0KcXVldWUgZGVwdGggYW5kIGRv
bid0IG5lZWQgYW55IGxvY2tpbmcgdG8uIEJ1dCBpdCBoYXMgb25lIGRvd25zaWRlIGZvcg0KdGhl
IFJBSUQgYXBwbGljYXRpb24sIHRoYXQgaXMsIHRoYXQgeW91IGRvbid0IGhhdmUgYW55IGNvbnRy
b2wgb2YgdGhlIA0KTEJBIHdoZXJlIHRoZSBkYXRhIGxhbmRzLCBvbmx5IHRoZSB6b25lLg0KDQpU
aGVyZWZvciB3ZSBuZWVkIGFub3RoZXIgbG9naWNhbCB0byBwaHlzaWNhbCBtYXBwaW5nIGxheWVy
LCB3aGljaCBpcw0KdGhlIFJBSUQgc3RyaXBlIHRyZWUuIENvaW5jaWRlbnRhbGx5IHdlIGNhbiBh
bHNvIHVzZSB0aGlzIHRyZWUgdG8gZG8NCmwycCBtYXBwaW5nIGZvciBSQUlENS82IGFuZCBlbGlt
aW5hdGUgdGhlIHdyaXRlIGhvbGUgdGhpcyB3YXkuDQoNCg0KWzFdIGh0dHBzOi8vem9uZWRzdG9y
YWdlLmlvL2RvY3MvaW50cm9kdWN0aW9uL3pucyN6b25lLWFwcGVuZA0K
