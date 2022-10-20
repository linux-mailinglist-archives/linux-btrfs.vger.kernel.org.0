Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BF605725
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 08:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJTGJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 02:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJTGJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 02:09:48 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4263D2CDDE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666246187; x=1697782187;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=RBUQp/2/xNRw6sBIfdO+hfGDQuV/OmhpV1TpC8dSD9E6JTO9UtzLe8y/
   OHaWuqtymhDt+swUnhQoLBb186suPMW7RRlKybZtlBxqV5SU+3qnL8tR/
   gCaRhmshRK1tDfi5glMoJJAwv+393KfkL+mLJm9VXyjzHfdxUNvV3fMZY
   AdKhrWzChAkK4H4Ht7HtLxJZqLLu2PESmX5anAJk9dcbKhzmShqJEgl6j
   o72c5IDMLy6wTgX8wMv5AoX/Be6zZwl+vUek+aTvKEBPPzX9lW+91jatF
   XCAZBDnt/pIjYzj9TKSUtyKdZEZKgZIrER7QAQtyaIVaQiEK3pRW0MDIT
   g==;
X-IronPort-AV: E=Sophos;i="5.95,198,1661788800"; 
   d="scan'208";a="318620192"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 20 Oct 2022 14:09:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJhAbDvn50tTkssAIL6f+wuSOa/GkP1SCVgREUJ4adOZyi35aqZ7XAjYM6H5RKptpLpltdtKJjWqdQh42O2dqgqee+zB39ck7qbjK4nZ72imZDlpyAaMrua8eMtzW9K0rlhHBE7OIiPtHFZIfqvFHedBS0YIol6uEkMXs0rod+I5u44haJ0C3zQa7XnzOhQQbn1BcivgWyNvtVGyNGWakls33nNtdzgNHXtq7y2wi5BeX3jFh970PQVr3e1CJ+QdOwkoCY+f/5Y82Ko4ktEyCZaJuTGcvxhC0h9hjSOjDzr/J5udKji0roqIaHQhhyb80s82H2bbeVicAlq9EWeDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bYMkpzXOObEZL0Ab9GyLXgfxw4AfiWLqb5bSGAAY5BaoRYYccmgni87baPrQX/2x/EB8VErwGM+RI6zo5PAPIf/i3AHp1DSzBjcDBe2T7i/yF4982ntmRFKRS7lVBsZe9ATkG9c4UXmvDtIAH9tWssw1bLPGhtniErG/cotWMS9p8SFJuEFCfPYDh51Tp+s8rct81tVgznaaghstLIgR/0WcUJ5m+7Hg/QVcmtGczjiejbiQYUFXBfu84F9ESP++sLBoeYadcoiKXMkCSYxaK0HfX0b7+Q47hWV+tLCdkqR82O1a2O8DVxS/UeLsr1NQoaMiRCYYu6ZFxFeWKxR3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=gZbVSAMG5hAS7GgCjlTcaRq213wY0b2olXwKZaLhNmrmvpLbxWMwKxi5rPmrVzXL/vn0hRhqWWS+ZFQqHfqdf21qmft1kNUy0tKLihcok2PQMLTONa8XGOBAdfxXOukepElV4etf1AuzuqSqn2aEkJlvx/6k/4GpuNU1NSiGtmQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7104.namprd04.prod.outlook.com (2603:10b6:208:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 06:09:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::34a2:dabd:a115:edff%5]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 06:09:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 02/15] btrfs: move assert helpers out of ctree.h
Thread-Topic: [PATCH v3 02/15] btrfs: move assert helpers out of ctree.h
Thread-Index: AQHY48szyAfyTT/5JkSmkLaOMcWQbK4WzX0A
Date:   Thu, 20 Oct 2022 06:09:41 +0000
Message-ID: <90caf371-f205-5de2-afb1-f044bc7e338a@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <d89ffe6bc0dd3fa90d5567a9a790a00acbf3d1e9.1666190849.git.josef@toxicpanda.com>
In-Reply-To: <d89ffe6bc0dd3fa90d5567a9a790a00acbf3d1e9.1666190849.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7104:EE_
x-ms-office365-filtering-correlation-id: f96802e1-6e85-4e6e-15f2-08dab261ad4f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmmG6uo+2VnV0vJMls53Xo0ZTw5Y3n4kqos8eYMMpFarpHXQCKX02IGGclCMi/PkS6QbFFepFaA4Jj5lwYisktHzA9m7eBGJrPovvq8IOp68EndukaKRyius0mlYmnA/TVs0XbzRumnLTZEFMh7NHLb1GB8F2yT8JpCoPyxJKzmtFSG+1+d/6lap8OfTg4kCS68+AMQ8b8pPAOX3Yx5QGCceRMjbZl6My413qiSoRGZEs1x3s6FDJdfhWUj4EkKdAgFWTNWzPZmBOGLkbR4gSRMxQBtt5kE1MaSZNZpX6RVJMd5YsWVdq8aeegb3oLOuSiXJfcJFh9UaSAuxqkZrX+wAo+X7K/6HBjQc+clAJ4e6tJ6qBlkew9XhmPV02gL+ZkuxNgi000FemFY/HkPSdkPwkjIuZyXNhhH643sWChAYWFutv/WJP925srketz+1Xl9C1sa9v7RGP0jk+cNyrEVtkxer77deRg36VDoMnVSIb9ceVsQPiBnZ6t9+a7Jh3wbp9ucQ8PjvqoY7rQJfPD033hAvL7LcL79va+GoWPZjGOEjpcXyyaAaTVvHG8y7dFYqS6+f2/unlCV2+HA0o1spwYmzGz7e0Q76XIJApeINCvjiaisJSINPXkhts/pdswXlXXO7NeLwCu1CHMGrn3brQWn7Wg9Eob/qsgYYXGt1R4MW1J1TEDQxNZpx4QpZe7B1oJuk+fBg1Ie0ALMaCHSFPBuS+jPnGc/AK9/Wq18XjFyD6nC7BfSBOh0dTpDffUIfEsBBHko3YubYR1cVo+A0LkcFdAE4ey7h/7pqCYTSYHmG0zl5h6ofKLsRQ5hlIZ6STvMQ8TzUYSbSTb1Rcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(31686004)(6486002)(478600001)(6512007)(6506007)(4270600006)(36756003)(86362001)(2616005)(186003)(71200400001)(558084003)(2906002)(19618925003)(31696002)(316002)(110136005)(66476007)(122000001)(82960400001)(76116006)(66946007)(91956017)(38100700002)(5660300002)(66446008)(8676002)(38070700005)(64756008)(41300700001)(8936002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGVyK3RZWEZNZk5ZYlJEL1VLQVhod0tZd1liM3hvU2grT0ZycEJPUzJTYSsv?=
 =?utf-8?B?azJ6N2p3V1RHVEpFaWd0Mkd0Mi80Wkg5b3FaTjFPVVRGelhVeXpsZ1F4M2Ev?=
 =?utf-8?B?VEhFVTFKSXRrQWRJc3U5T2UwUW54dnF0bVkrWWRIVThjVFozU0dmbmhWcDhN?=
 =?utf-8?B?NzA3OWdmUmJUcDFEZEo2MnhzbHdjMzZSc2k1UHdXb003OGR0QWNPVWNtczhQ?=
 =?utf-8?B?VTdicmNJOG5oNWl5TXZ1d0Q4azRnNTJQbFc2TXpjNUY2ekNGc0NXQU1Jczk5?=
 =?utf-8?B?U2Vwd1NxUXptbEtSODFxY1FDQTZRWGRkRmo2WmxFYVlHVUY0RUwxU29ZMVdl?=
 =?utf-8?B?dFM4b21iVnUxZ1crWTFDVWJ5ZU0yNkNnWmhVWE9QVm1uck1JbjJFVDYvRkNr?=
 =?utf-8?B?V0hPeUhVZ1k0YWJsaFhWZ1lpcTYvYkNDVDRaYUJmejVBWGpIck5GNVVQeHRo?=
 =?utf-8?B?ajJud2VuVXJzd2NvMHArU1E3ZnFKTHRFY1ZQdUlySkxVUnlmU2RhZmQvd0E2?=
 =?utf-8?B?UzRDV3BxVXJQcW80a3MranNPcXI0NGg4SEpwbFRKRUhHQTVvNkVXWFp2OUNt?=
 =?utf-8?B?OVBNcUtYbjJhMnpQcFp0c2lmTUpkSkd3c1FBSC9hVTB1UFFoeEN5MXZzS0xw?=
 =?utf-8?B?WkRENVZpMzAzUklRNUJ0QzVXYk9Mbm1sMDNnNU9nUUZZSVl1UUY0a2k0UWgw?=
 =?utf-8?B?VkJKblBBOC9PZE95ZUp1VFFUOFpPaTdyUnVyYW5BTnVqMnNwZ0xQeEU2NDRX?=
 =?utf-8?B?a2p5czUra1V4ckVodTJWR1N1YkFuanRpSjBVZEdRQ0ZmWHpDL1Nkb0RMTnZV?=
 =?utf-8?B?eVVqTGFmMnFGV3Z6SlJLNVFpSHlJdWRjbWl5MldCc1ZPMUIxU2Jhdk9ZVEV1?=
 =?utf-8?B?UW1qczJrbW0xVFlocTlsVUp5KzMzRmxWU2hqK2c5K25kZ2RUcHBuU2FocFQ3?=
 =?utf-8?B?dW1ISFlJeDFiRWU5VG1xMmJsSXB2UXVOV3BPVkovbFM3VGtKVk5oRFhqV2wy?=
 =?utf-8?B?Ykgrcmpib0lQRlkzd2xJK0Y1ZlNsOXhmWEtQK2toWVdDaE9qa0hxcUVlQXdr?=
 =?utf-8?B?S1dHZ1pwdlJPN2RvWlRnMUU5c1ppdE03b2VqMHpyQm5Gam5ja3dCVCtxQkla?=
 =?utf-8?B?Z0lJTkRpQkZSdVNOQ09jK0JDZS81ZjJXeklXcm1uREtvSExMczFFamI4cXc2?=
 =?utf-8?B?TjM5Y1UzQ3JNcW9lYVVDRUh5VTkwNVc3MlIrU1pGZmJlbEEyTGtlQUhuWWFY?=
 =?utf-8?B?ZlJDVUdtczg5L0UxQ2RQdXdoSjJVeUI0N3ZtNXhlay9uZ1ZaTG9YdTVieHFJ?=
 =?utf-8?B?eDI4QnNQZ2hXTFdRRURJd3RYTUZNV0hkVnRBVGg0U3E5bHU0SXRkTS9nOXJ0?=
 =?utf-8?B?Q0RiUm90WlNXOHcwc2pGZFVYVHcvbCtmaVR1bnYvdW1sdFZ2a1hDSysvbzdZ?=
 =?utf-8?B?MG8vRjJONWs5VFFNQk1HcDJzVCtsYm5VTWQ5VFA2R3BzbDRET214TTQ1WkNH?=
 =?utf-8?B?c3UzdzZHanR1WmhiQXFxRWlHL2s4MjZOc2hGMDNvV0I2ckJPMTlWWkRPaWFm?=
 =?utf-8?B?WW1temYzdld6bXBzVXZldi9mSEZHMEpNaUZiT1F3OWdSdFpXaEdIUTcySXli?=
 =?utf-8?B?Smhud25uU1p5czJybDJZNVlmSXZqak9USjBjNmUwck95MVpkTVVkeUZOa3pY?=
 =?utf-8?B?RkdpRlV3eUZqcjFKd3RyRGdaK1p2dFpQNUpDUXpIbmxmUUhtS2VFZERTK3Ft?=
 =?utf-8?B?Tjltd1MraHhZR05Xc0wydXFTZlVjV2pybWRQYmJ3Rm9hcTcxdXpGY0xqdW0v?=
 =?utf-8?B?SDVrbGZ0Z1N0Uk5PQ3B3czhLbllSeG92c2JBSGJLRzltNnNUZU9PYkh2Mk1j?=
 =?utf-8?B?U1JJQlpHT3RhVFkvSmZKYjNpaG9yZThaYXRuRzB6ei84alZ2bTVpWlhCYnpI?=
 =?utf-8?B?dkxiVGlERDRBRWsyWnNKMjhFR0RkbGVyM2VzZEJUY1oyckZJWklQZ25GTnp3?=
 =?utf-8?B?U2RpOTFJWTA4WU5yODNqZkp2NURZdDZEMEtnS3hidGhsZjQvRmdKT3pPbXh5?=
 =?utf-8?B?dlpMMVIvWXRwU1d1WkI4cUNjejYxSlVsbDNTL1dDYjZiSG1RMWFsWlU4Q2tu?=
 =?utf-8?B?bE5xSm9icHNPNk1VZyt1YWNzZnp2ckZGS0Rtbk8zQ2FibWdPSjFRVWRKQlJP?=
 =?utf-8?B?Nk1mQklBcHg4blltb1p1czlpQktWZWpTakgvZzZUSHlnUDNZbjlGZUlsU0gz?=
 =?utf-8?Q?lMzlbAnhWtKyHaJZtskGFLX2CJMP0UFgblLm2m89SQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <362E36FADAECB142B431116FC4C5C738@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96802e1-6e85-4e6e-15f2-08dab261ad4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 06:09:41.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZTPzl5NvohZ23C4A8G5w9PJPJlB/KKni/EhU1AYqv81t5IlU2F5EO4gHL9+fR0HlLuHXOGtg2PEtpuyVGibdsySQ9n6BzWF0uVNirg+yw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7104
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
