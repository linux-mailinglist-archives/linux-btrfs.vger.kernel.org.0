Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA326A46AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 17:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjB0QF6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 11:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0QF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 11:05:57 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619C20699
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 08:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677513956; x=1709049956;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=KqjWo9iBO+EbuM0OIKd9Q30jX+3p4DCI1O9+TkTJmbMflviXVBppE7UA
   pRuu7/EJhh/zzVajA/DJkwJcZQJcnprqpYhgqRQV4Or/Y8WBQ1eVkQ+YK
   T8UL/YGW+M+waQ0scwZdJpJcLLoQuhH/UK7N6G82MfIBAWR+yjhutUJKY
   Jj/Y+wUV2WdSt+CON8d/RDCrFXNn/AKcvRnEyYBukfd0oXY3tki8ZVKWc
   7qqFzaDQXd32L2aGSeXbXKl3wrlcTnr3YH/xQL/dAxm/G715waFVSK027
   eM4gBgHnXWDmPYUbRI5ZgaBcEDO30VmFa5UrcBCSEozBQqoc9XJ+8Uf/0
   g==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673884800"; 
   d="scan'208";a="224341467"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2023 00:05:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqXLPFPu9FcRRImJA6Q/GhHYhz6gk7HRF1Q6FkY6/BLbua1X5cBr+jK8MBn3fHx8AkR2I4J7t9/nV6IEW2ZhrlTrzJtW9aGoLXmEYLpRnd5R/XVVOMB0ItcirUjUrVqg17UJyvLM95Vl69cRU7feI17TRV5jxT6RUJB8vtzXyF6Tc1p2LOHMtOv5CAygFLTj8KjCmNMaqE0SM5YMrUTCry7eC702RBWA8loGm5/cKLvpHcPSTX7179t7+wG9s2IbvD8ReVMF+m56utYKfF2Z9fFdhUMkfqOWan7Lqr1wFFwE8msAQehmJ3v4na4221EbygEntqLNYMIMgOCowMu//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Nx95y2y9h0aPAl0NVH8eR4KD/MCWCFiyWCIsPoA4jj6rvckafdj4BEZbH1ErhPj4lGZxqUUpnDx+prUSNpE1dFJ/2iTfwrV9r4b3VBip5EVm928ZkLDj/Gi4KwfbiFwJwgfBxqZEixz+O4O5m5EHVdcHJTlk5grWsX3nvs9/UXSTXS4v8b8nbG0mQ9p/kM+Dt/xnld+g+Qaq6VD3VH1TV9PeRFcaSrLrTlBZWdYX6QNkENLiSvnWrhqDhfeSBFR/ECAkwqB5YXuJKvJqS2lS0+1x5j4LNb+8KfF4tqTglWP3ULp5G+UvKVAhEILgqAjFpBqWWpebTbaO5ijAlLQcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PdRsN8/oN3FVpbnk/CmhwsVPucEPorlTwWpK5gCA/PVIACU6QjmjLrfs/jYFDcsm9ppRpFy6V9MHItFyflzNcUPqCnJrBCRwxli0LFBy499Ml8VsKNdIZwfPabU7RXnOR6PzWYLiKbF1xJevf9HATMoMXAPJN5hmJnMRPKHL84g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB3858.namprd04.prod.outlook.com (2603:10b6:406:ce::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 16:05:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 16:05:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/12] btrfs: don't set force_bio_submit in
 read_extent_buffer_subpage
Thread-Topic: [PATCH 01/12] btrfs: don't set force_bio_submit in
 read_extent_buffer_subpage
Thread-Index: AQHZSr6Z0mbO+LxBW0W7qamAHsb+2a7i9T0A
Date:   Mon, 27 Feb 2023 16:05:52 +0000
Message-ID: <4ecc5fcd-3053-6b61-e6f5-f52ce9cc9362@wdc.com>
References: <20230227151704.1224688-1-hch@lst.de>
 <20230227151704.1224688-2-hch@lst.de>
In-Reply-To: <20230227151704.1224688-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB3858:EE_
x-ms-office365-filtering-correlation-id: 493685ca-0cf1-4f1b-190e-08db18dc8068
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwzQEOuXEJS66e9nst2j9lwEvvwmAIbWgyIQ0EdUXvOURV+eu+OfeSuC7e4eYOCIn+2MojsxWR3QOWpuElzNVO5j8tS3+guE6QAESMx9/qGtH8JuhlkC/1fHgWjuqiwHvWbqTK5T8VHI6p4b7JUV3rHXb9VVDBN9cF0LxJNnXOBmyipKzpti5H7hh0A3ZmkChiC1D1Y7BC90BO60NqUvkWkz6Z8RQuoZgiqE1Qvyp/Y5IKxKLJtc2LPAafAYk7KdgBxCZaLgq4cAbbVzx90gXFuj9ylbu9SM0+hLoSUC84AvN+c7BKS4upSfnvzubxyxLISeRC1Xeclw9dT7YPWSyUvSSGvLWjODKFdoHsSRwygnxFle+r6X68SPUxJ8jbd8JMPYrdCShQcJTsPVdXJkc2B+FZo/TGPH+NypOEp0R2EARoiGefVifv4u/d3LEnqyCiYORDt1sBMdZbbrx9Ts9nc+VND4GcwVp6KscSthlZsPJN89dtiEng2C0sJmmkQK3YFtg9oVyY+TPQkDPHS3u3uWUsDzg96Syjvh73ecyWyoWV/nydTiWQqf/0ubwsfMxQMAQ8pOJKCZXD7UGwwVKe7yOCmP81DXHk7XX8G5i4wS3WabLeFby31V6NWsr4b2XQcJQ5Q6T23v0B0uff6jqwXmXmtjwxrNZBM6NtCXOzcQbEPrfa0ZNFUBLtgeHWpB9mdRFmaEif3pMKZPj2LzSoTOfWOy/2E7hZERTEqSqw9qt9iMJCD4KNKx7/Ct1oDpsWYNTRPt5klp8Bi9usAhPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(558084003)(36756003)(110136005)(316002)(6486002)(38070700005)(478600001)(71200400001)(5660300002)(8936002)(2906002)(19618925003)(66946007)(66446008)(66556008)(64756008)(76116006)(66476007)(91956017)(4326008)(8676002)(41300700001)(82960400001)(86362001)(31696002)(38100700002)(4270600006)(186003)(2616005)(6512007)(6506007)(122000001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0hodlcvNDM3cmZWOTFjYUZJVGRXNGVSdDRoQ0JkMm5ZcEUxK3lYVTRRU0R3?=
 =?utf-8?B?bS9qZ0lFOFJodWRHQUlsT1NOMjNHNC9SMWVyV3pLdkNaWkJHczkzYUZ4NURy?=
 =?utf-8?B?RnI1cmIwQld1Zk1vUEFXOHJpZjgwRHFmS2Qvd1VUa2RKVUdySkpPUXJPRU9w?=
 =?utf-8?B?QUU4RVMySkhQR2xmVUxCaXR4SlVSSmZuKzh4bGo1Mzg3R2ZWb0Q4NE9TMmVx?=
 =?utf-8?B?K3h4d3VOWHNHQ1JnaUVtenN3bC9aOG1PMGVvQ21jK2lFellmNXJGR2dQVmZs?=
 =?utf-8?B?eUVLeU5SNTlkd1ZZNUt3V1hQSnlHSi9GVUQ0T3pxTDUxc2J1U0M3b0NpWTlZ?=
 =?utf-8?B?SDAwWjdBSGszSXc4ZjA2aDdhVUpPUTh4N01YSmhGdy9VdUc1d2VnejdwRGM3?=
 =?utf-8?B?c1lMeEhKdUVrdHZnZ2xjKy9HVTVWUnBDKytTdW5hWk45S3VJTkxCQWl2K0VO?=
 =?utf-8?B?S0srSWtRdFhqeDM2a0UvamM5MTN0cjdYcnFEenJCRFNuRXVFUFZOZ2k1a2Nq?=
 =?utf-8?B?YStSUXZlRUhWRXJuL2R2emNFOHlYanJreXdUck13YUxvVWZObjdXL0FqR2Fw?=
 =?utf-8?B?LzBGS2FiSHFCK05HSjZoazg0SkJlaDR0YXVwZnpvcE5mVTB4N1VOSmpQL1hi?=
 =?utf-8?B?dXBVcEUycjJobEpvTktVYXBEZ1E1Ty84Vmc5VUdhV2YzaGV6Q2t4ZnFENGk0?=
 =?utf-8?B?bDhUOGk0NEM2M055NktUOW9jMFlZUHE2T3U4dklEVkpYRmhQeWxHUUN3eUN6?=
 =?utf-8?B?V1FOT3FZUmkvTUw0dFI3bzdmTkNNZHNta2wrQ25ZZ2VPcWZTK1o5VzdmRW5v?=
 =?utf-8?B?T1RNN2lwRDI4ZVJzYjNXZ0VWZS9RdVc1TFVKamI3TGRBb21PTUFrK2kzUHdr?=
 =?utf-8?B?RUp5R2ozNjdtT0hvL0hsSDRqZ2V6RGZaZTNYdk90WEhzQUozeWloV2MwYXZp?=
 =?utf-8?B?Zm9yNGNRd2p6bUZseEpIelFLUit3Tis4U0RIell3bmJrVUxaKzBVL01zRyt0?=
 =?utf-8?B?ZHp0SlRnQ1BnNTFHTVBPZ3B6M3FJNXlRajE5MkpPOVY2Rmw5TFdoeFN5b01C?=
 =?utf-8?B?MUpvMndjQ3lGNDhCcEN4OWRkUS9aTnpkbDkyUFdRTkJNb01oU2NnWjV4azFH?=
 =?utf-8?B?am5EUUhzM21aSHcrbW1ZcnlqYyt4L2tleFcxMzFYQVFSMlh3emZrd1VBTkVK?=
 =?utf-8?B?Q3RBZFhDclFNTllxYW9BYjBPbzA4NGxpclBKV3ZRb0F5QzV3VFN1elEyTitE?=
 =?utf-8?B?QVVzTFZaVFREZWxXTDU2elJIbXZIRG5CbU93eWxnbnY5SkMzNTJVZXR1NTBi?=
 =?utf-8?B?ZzQxTmRDM1dVZGJWYnhwUk9WM0VnVEs3aWdtR3hySHlJYk5Zbjl3b3F0TkJa?=
 =?utf-8?B?UGZTVmVXamdGekszQi9MSjI3enBZbW5sSDI2ZEt3NWV0WHRPRkZzdGllR1lS?=
 =?utf-8?B?TWc5dHBSRTlEa2Vva0I3SGFsZlBxOGhrSmpIeEdUa3h6d0hNWGo5T2ZZVDJY?=
 =?utf-8?B?YXZKcEpodnh6K2ZzajF4SGk5OTRRQmlnb2ZxWnRoS05odGhHSm84TGlsdXc0?=
 =?utf-8?B?YUg1MndoKzRWaFlOZGphRnZuNk54MlcwdUVGMmNSTkdTSE5oakpVT0JoREUv?=
 =?utf-8?B?QmRGUTFWWUl1NmJZT1llTlhHQXdaRDF0MHhKaVhPOVovbHZZQjJzS2FzN1RD?=
 =?utf-8?B?OG1pTlV3bUppNU5LNzhDRlhnUjUzNkRSeGtvU1B4bE1RQ1d6U0VaYlFKWnVT?=
 =?utf-8?B?S1Z4UWNYb2JDd3VsMGtxZ3liL1dFZ21MMTJjaDIwNGlxQkRpTXYyQXV5ZXNz?=
 =?utf-8?B?MG1UKzQ1QUxTNHFTMUNDV0dYQ0dNUm12YStJeTRkdFJoR0RQN0RwZjVxVjlI?=
 =?utf-8?B?RXdheThJaVR4bFhNSTI5SlphdGFwQjZKSTNWSlRTOWNKNlI0dmtyT0lnQ0hM?=
 =?utf-8?B?cDN6V2RYMVd1c2VJLzlIdmZGQ25maFk5NW9ZdlRmanR5TERrZmZTZDVVT3d0?=
 =?utf-8?B?WGJuNkVsQmx0SzNzNTNUeW5tdDZJNHc0V1JvbDNiYmdkd1VvYjBYbThZcGN3?=
 =?utf-8?B?ZjRKS2JMUEdqcHNCMk40cTFUSlBIZE5jL3VTQlQ5cldqdE55MXpnZUtZaDNJ?=
 =?utf-8?B?M2pOSVRWS3IyUFV3b2hLMkROZG1mTjZ5dlNXV0lvMklZRzZ3a0VoOE93OUlq?=
 =?utf-8?B?MjZsQ3NXSXpTNUk5d3BxUFZPeURlWHZUT2FkZUxhbG5EcWlQanhxempOZEd2?=
 =?utf-8?Q?J591d3uViT9EeDdvelMfX4F/74PjzlgxrrFQ50ns1g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65B26027FA0B3C4E8B91412900DC1F55@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lY/SmJFD88wjKsD/tWtuEJvby7f2atCBlerljbgs3LXS9UDwl1j15EiBFoY6NlY2/k0dQEVx1OzG+ozzC1WaZ4cympDS0acPK9pQ9OpBrMnO6n3L05R+cdc7NsWZE1mq3dkxUnJPhHf9YM0amjppBx7R1wpauJv4tKvdAr7sWcJD0LlM5qujcvdbhKMR5wm85OOxJl249UNsX4ZXVWdH26do0TVhnoFg9ZjRsSCO9moWkbSwsyfGcZR+p+ZwV7unmMycrEuidJIyc8hCkdvjarln760vLpSaNt0MAyaZl11f7BTrQP1ywGI/rnndwVwvBbDYQ60DMCG+f+OpdJVl4XpUtfNXE3hyvdh/apbDxh7LapQwBuP6P2L9BtERX9bGrT3tGAQTT5CBBYA90rt4gA2UnQJwyNa6TdEE6J+LjpNrbJO6lFV90Ef11HfcCKLxTJc8trHaogAaSvCmjRrxWNiMfKMLdcrZ1QvCrupijVWbYWxeFGypkJDEOsXzhx2qGt9xhFumjoR5JtuICVv3GxB0j2pv5P1kzn9cYI5GltdTEEpaggPQPkpq1qg2k0VVaUgwo3B5ZMSZVzl7y/1igViuSBFE1XtZffe/01aGaGWBinC/8N97Ik1ZG+wMejbKv/UQRfF8jfWsi+xkXA2rbQ27RFWgooIYDZ/Ikz/ZpuMA8t0wjGGxuxEMW+BPgBfqDtrq8h0bbJ4+fGyXVjXxyeA9lKqY3Jv7/t4XH16Ze/qma2ZifLMcbBO2moR1MmkzXCaANuyzw7ZB67qPR9BHYQFQkfeKx7b0s0/t5cN3eQRRw5fDKGicE/vmphNRg/pg/I18lwfiqkx/cAh1dxItoxM6jZDs7XWZcgMktcWja6ngPJbyve6/NSgwDWiMoj9V
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493685ca-0cf1-4f1b-190e-08db18dc8068
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 16:05:52.8765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDozHSfKsmF75wAbxMFhEotrEKN+d7IXkQcRNfxyAQCyP3ubhpUbeHIseyqhEZn87D7Vl0g6XEvpBVKOg9lw1IesQStO8cft3aya+7azo90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3858
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
