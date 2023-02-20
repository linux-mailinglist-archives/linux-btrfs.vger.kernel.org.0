Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906B69C807
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 10:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjBTJyz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 04:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBTJyy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 04:54:54 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766E9B475
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 01:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676886893; x=1708422893;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TSezIxeTcCvPWbLFVCLchzzk7qn5qSONAEmsSc3BUc9WUsv+UxeCJKdq
   9IfG6avUrSh6UZ9WkBJsTBNWzKIL5xTuQ+m7b8JaUoJmFd79ta3zVFWnP
   cwNwKKqylHQu9nKu2ybSZ7/6IUZL345Ge3aGdx7Q0ur1xURLcOveWls0o
   c26chrjJeryvs6X/XqVh1DSyaT5zAiYPd+Un6I4fS6PAdtUPRdqhJ6FV0
   2t7MGYD5YykD9cPSOHMNXOwqE0x3u9FC3xmcXC9uXOwZTi5Wn+XPLd00B
   DNpmlvaAxEiTVuTJN4YNBjI+uxicii3S76s5faNzzX5qvf0hIje1BbbjF
   g==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="328024785"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 17:54:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XScG6vOTlUCj8VCSSeAM5IvRwfyM08XOv8G6r1Z47f5XCFd74p79K3jdvZNGYQGMq6mIjGvqgwkr8DGt4ORYCaL/CFDubNKBtVOYQsGglyteno8OYZ6rqmMrQNScrYUQMrY13NmjGGRUxKMGlFu9ea3KozJDhARERzoevYEYLCbmheiOIjA3fSZXZvTNYZxWgFPPx1RZhS/2MOKe+4OpoJA2RrX+pBQajDMSM+7k4PlaT/MBz4yu9HnNIEZ362M3hTWllx35+WBfvWsmkX6L6i41J2e6bHdjUR7oj4qOoObQPysZRxYG7dNE5dvdXXIM8XUCoRivPnxT2T2SS+PlQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=H1R9zdeNQ/dCJYxJYtyVkitZH1g1+0DhfZNq4rxcLp0/L+58nCdOmIfHhT4ogx8quhIqQlmDBNkqgla2HrCxxi1cXC4n6LF/fEhCRPhs8ZmM3cTj+10V6r/QCGhuFHXE4DkC8ca0/W49kVQYdOovchKcmarvE6RLbECZDxi+jpB28dEPadVOUPJbxo+8kbeQVmQQWsDTMMjbuBAnkN3FZRa35qbjMUNywvGJ74JUJ2+5VBl1YnMqe2LKni0UBUGvbyztv0Q5J+pbVRmiAcAN6HVG4kjkdc2A7Rz8mDR17k4+Ss/vZeCNgQ520loNdR7BbPmf+CKMF0t64bmL/qifiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=V9lfY/+HOQhIEJfbYxlDJakdIxIn3rN1T+em1ZkRyb4Lis+XzOMoLvuE4gePkVrU3si3zpxMpyt3D+480Kq53ownHDs5ArHz5KJxBTf8I+GSti5JBwCgMbO5MFeXCuQCHWzMd0KApcBJ9vMTCGZhejP4gVi0uSgumpkMR55jL9w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB4275.namprd04.prod.outlook.com (2603:10b6:406:fd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 09:54:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 09:54:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/12] btrfs: remove the sync_io flag in struct
 btrfs_bio_ctrl
Thread-Topic: [PATCH 04/12] btrfs: remove the sync_io flag in struct
 btrfs_bio_ctrl
Thread-Index: AQHZQiSqztrNkuH7NkeuYbpot9n+Gq7XnnSA
Date:   Mon, 20 Feb 2023 09:54:49 +0000
Message-ID: <04114a3f-91d7-1504-215b-c9f360d0a599@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-5-hch@lst.de>
In-Reply-To: <20230216163437.2370948-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB4275:EE_
x-ms-office365-filtering-correlation-id: 4895b88f-b7d3-46c7-7fbb-08db1328818c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +YiDA5r0Wkc8uIGWNk0Jr7GeNyMUpfDgbwoSMXxaZa+9GRsG2AMPUxunZu1AAKUM7kXF0nLpVlgiq09jQL5UTU1k71MqwospnPi1ibX2d3lrFCfuYUenb6dQk4tuqQ6dlygbZM/t1b5EcjTyx9hsEkTi4wby7eYZtYmmr1AKAKW4Ud3HjKSPIOq0zylhRUYsfEoGfREuQmbyVD1xoGhw0sfsTLFa5YpmKj9WuhEpstJ9ybYd8Y9VLE61lb+G9g04KJIzx+zjvA1eVaBS44sbMXLMT6OalrQLLBbxjhc1sMhMcfDCumRIVJOTsAvboo49sSj593fBY2oaNH/H7jgyvFw/eMFZYSl2BrK87eSmqLEzl1yVWtZZNGTLrekmVtGe7+2DMoDFccaeM1N/msKBbntNFMyj2tn2XEjmg0wkfXi1BZ8c76HsXI2AmOut7f4Z4CFjbEVrtKiQx3LZp4P0EGmHbTqkVXrvNzyW2ZcxgTyNx0AJJ/hl7zO3UBe84D3GfxrvLIyPbzKbBxD9163n+n9TfkPnwe5R8Oh/ECblo0/7NboiMlWCp8Lq1XkSC5O6EnqwvIds44SEmXRFPr7T1BslKGFAseAfDOpNVo+fd/sAhsLypo62PnEhXmfHznURDKqd9aBOGL2AikJsiPqEA54+ik93xpYeKdet1x8ghQVB2/lVJQLEpVtNMP/bRdPm2HhAKhFxPKPpgOP4/CqzzDYOpR2oFA34ua3KIjHUhJtAqXil7uif5yx922qe8FyLRLvkLLAV6PFK6UtM9pekxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199018)(6486002)(122000001)(31696002)(31686004)(86362001)(316002)(71200400001)(110136005)(8676002)(76116006)(66446008)(91956017)(66556008)(66476007)(66946007)(64756008)(6506007)(6512007)(4326008)(186003)(478600001)(82960400001)(41300700001)(38070700005)(8936002)(4270600006)(5660300002)(38100700002)(19618925003)(2616005)(2906002)(558084003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU9mSVFBdkl1dnUwcmJyOFFITFByaWpxbUxTcWVSZWprY0NZWnAwNmwyd00z?=
 =?utf-8?B?L3dKR0JXa0NvRmZjMTVIdzlndVVtMFFHY0w2MURUZHBRTDNTMDhZdGxZZHUw?=
 =?utf-8?B?MUhLOW5CZXVIKzVBSzV1Qm84N05CaXNTNkZkSXNqcS9kUmVBeHIwczNrWjdy?=
 =?utf-8?B?MU9lTzZhRDYxMXNkRXlXSDVVZEJ2d3ZnZWdJanFEeWQrNFh2ZDY4UnVTaldl?=
 =?utf-8?B?RHZvaEFXNlZtb25hb3A2T3Z5V215WTNGUDJneU1tVDdFTHYwRlcxNit5V1lS?=
 =?utf-8?B?SnZRWktvNEdkUlNtRlFGM1JGVDNSZU9FeW0yd3ZPcHgxUXJlbnJzcFdYUkRT?=
 =?utf-8?B?bGRkU1ByOFprNmgybFlrL09URldET1UyeU1uckpib1JyQ2pYRlpIUzVpcFp2?=
 =?utf-8?B?ZGhzRWY4WThIbmttTmFKaHhieWdUUGh6M21qRU9IcG0yRHIrTFlSVk12Ym9t?=
 =?utf-8?B?QWtBOWhTT0hqc2FTVTQralhwZTdudnFIMU1jS2tocllQK1JMZDBrT01RT1VQ?=
 =?utf-8?B?bE1kcDBIVkxBNjM4TWMxYkRpMUJaazhRL01mMndOWXNyd1hveUNyRTN6Q1Bm?=
 =?utf-8?B?My9MazhxaCtYTjdLU3VkTERuZElwcS9NZGtHelZpZ0tMMGlaNHNSUUtmZFRF?=
 =?utf-8?B?Z2YwTTVnUXcrbWc5UmJFZitleTlRTXdoNlBRUUQvcVFpbGhuNzgwZFRuU1pG?=
 =?utf-8?B?ZWRsUmsrMlhFSUgwUnA1NTliSjA1WXNLOFV3OFYzWUdVbkdDcXl0NTk5UEdL?=
 =?utf-8?B?R2djcHdjVDZmOXBmMUM0cjRGMitDaXRkNmxGLzZwKzdMbDN2YUpMWXkzYzI0?=
 =?utf-8?B?ZkJ0WXJaYjFxanhKZHJzMElwemE2OVhEdHp2Z1dnTVlPUEcrMTNnU1FGa0Nj?=
 =?utf-8?B?MmRvT3NXVkZGL0pYeEdZT3FSTXNDWHplNXJjZU5DTkYyWmZTdUFPanJucHkx?=
 =?utf-8?B?MGdvdllXcmIwUFh6K0gza1BiUUc2S1ZMa1dyejZzMWU0SnNXeHdrQm9vWGdN?=
 =?utf-8?B?VW1JRTA3SnJvQUNZaFpHWnA4dEIxQnFPM3VYcENhR0xmOExGNFk2M1dPSW53?=
 =?utf-8?B?c2gxWStUQzUyeTMvcXM5RjNtY01CWjRiK09RMUZPN2x3Q081UVBtSmg5c1JI?=
 =?utf-8?B?T3VuYlhEMDFxaTd1a3B5K0VxdVlWNGloY2VjMm5ock50VTBKS0VnQmR3VFg5?=
 =?utf-8?B?NVZtWkR2L1NvTzhJTks0VDQ4eDNGWDlaUy82QmVKb3RBdmtZMlZYVkFVZGwr?=
 =?utf-8?B?YnRsOEgrRDRHNC9SMW04MDY4SnhEMVgwSk45RFcxd01laVVWSVpDMnZSejNu?=
 =?utf-8?B?alNkWVQxRVg2TDNHV3c2TE90QnM2anpCdjAxWnU4cGpEQng0YmdrbW9ITzFm?=
 =?utf-8?B?WG5Ka1VGVE9XN2VLNGpuQVkvK2tTaFBuVDQ1QTd5NUFZYkJDUWxpSHprZm0w?=
 =?utf-8?B?aU1RZWErdjNpTFp4M013UExTbnZaclhxcWVEU2ovdk9XMkJidmpFM0hyeTl6?=
 =?utf-8?B?WWZFWlpWTStYdCtVQTRTeUxNcmNqUTJVam0zYTFKY041N2pkcDVDdHoxbnJC?=
 =?utf-8?B?ejV2akladFBLRlVpMVFXQUJndkRjSUxOQWNhRXJqWWRvMnBTZStnUWF0RFo0?=
 =?utf-8?B?eS9jc1k1UEx0YUNMVVdMY2g4UkVPaDFrdW1wRXFmWXFCQzdPZmRkTnMyREgw?=
 =?utf-8?B?bzNXVzVXZWl4VERRMUtpVHAxTWhXOXY1T0kxOXVBY04rdDNKZXdYckZYTktS?=
 =?utf-8?B?N1pINWtWVkVwY2RNSkZZbDI1dnVqbjRmaHZOSkhreHJ2bXdmeHZHTitqQytq?=
 =?utf-8?B?b1JwMSs5d1BDcTg3emlYbHVQNmFOb0Q3SkgrQmZNTWxEK2NuRUxkajYrd1pv?=
 =?utf-8?B?dk01YURucCtFVWZ2N2JRUmVFWEE2NWhUQzBwY0R3L1kxb1JNUk53MFlRRUtv?=
 =?utf-8?B?cGdHanlyMVplV2J2VXVvK01PUjQ1WXNIcGI2aVp1L1U4dUw2eVJJTnQ0VndY?=
 =?utf-8?B?VG80N0p6STJ5R0piUWlYQVp0eDdrbU5tcEZnMWhveVhDblJHOFlOSU1KemYy?=
 =?utf-8?B?OU1iNkhvWHl0NkxGUzFLQStTNzd6Y1BsU0doUGh3bGo0TEc1YW5jYU9NUFpL?=
 =?utf-8?B?SSt5eHIzaVc5UjdvbStIeUhHNmV2NXg1MThTTnR4M2I4WCtpWlZrV1RRQUtw?=
 =?utf-8?B?VUYxMmFtbC96YlFOenptQXJJR0Zic2lucXMvV3FrMmc4MXFIREhnOWg4RVFD?=
 =?utf-8?Q?ZjpvjFZFfV3PQ1qM6M39ogJXWLYLHLMK84Hi7i/cZg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AE1DDFC86A58442834EC4D5714273D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jlPPByt0MhJPIfTLqz3iDETnKUaA95yKSAbfV6lG8QW4u7Ofcobv8Cd46rqB6c+2xzxbUwlhPJFTaabCHsJ1HDDT6d4O1lhTaUKxI9L6W0dmjs4rwmYc588zGeGJ6P/3uFuks9hnT6dDxSKfIwzAylhu4YCa+EcQvq3pbJfzfQVEaXeFLFfKP9uhFwg4ccwDviyRmY1mwFxFkdGTre5NoVd95a+JSm+Gy0sLVXu16wESAMwUfru03BBMkCJq1Q4rwDZIJQrxtDk97ZIivPVHkqCnPn6eDCUb9hoaWBh71OsvrXcDSwVZaIdPXmvX0z0f9ZOV+m+j7czex9ysQBrGVQVU64l76JLI5of1cQEGVJtGtOzEspy92faCcMV7wkOLRccq8vJU5DybjfB8Ilw/ygpZz3ARCzRaL3OQ2wK4MWseCUjO/R50X33K45rxQ4tDpw/rElPINPvvq8/7/jFnMQUCYtXpHfdc+tsBc19XSioiH6xTt90jVNFcc7nUvhyE0HarOX4CZRmnJCqDnDgP8R1kNG+F/Z2P+CEmQCwmJ1hBYck3RHlGSgnR8W1c3xrht85yzkJ2/iOKUsj1gVB+QKQrpTcaVSnqS1+kaeP3EKG1InbHwDUU4j8BpC38rhkfxLDVj4BlNL5U4mVWpGVFKaA2jpZXM0Slw0vuu4ZEpPK9jNfJO7o/CwSRtUjbM4lcuxjqpEMQWpweV3s3GlOahi236eOnN4zur1FkqzIoNPUIkT0/Kl4QSMjwD1Jn6uQj1rX2lmliCMw0yXR+wxqYJkvRTVmQm3vyemVZ/MLGeaSJeGv6KMSeLlBTrhXcO289zs155wtwOL/RrkBjrQ7KS5zkVUkMdlaPQQD6SePCD2cULD1UEMw1Q4gclkHYqRaO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4895b88f-b7d3-46c7-7fbb-08db1328818c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 09:54:49.5520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQUQMVNxtEEkObmxSvJmoZuZqfpkwMcKuCBZniIHizClXzoo30oGw4C6A2fK5vhCisNNx/3M08vy7PR5H9Fh37uHB433nUHJ7eboZ/qpFbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4275
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
