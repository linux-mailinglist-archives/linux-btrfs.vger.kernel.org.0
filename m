Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BD6C315B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 13:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCUMSY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 08:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCUMSX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 08:18:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437B93D1
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679401101; x=1710937101;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3QJcQQixdAhzk/7APBVOD6/nwaoFtKkmXuOe9ZDNq4o=;
  b=EIa+IlS646JQgRhaD53WnrTRrJ3/POubIA/TmNnwnozj7pFuevyEC2U8
   X2tdFPXD9OfLjyj4ItRHvDmhuZZ1qW7mGZeuUu9aJuKXlSJQqZflNObe1
   c5JtprHSUyGmU3aPmojp0DmaTF8U5A4wfJP/4v8Ad7kqfebvgn6azKiqj
   Ow20+pFfNZM9xSTMhuqhThaHG8xT2QdT6vNrCeBFBJ1XJ+IN1A9DNAqPQ
   BROpMTmf0QxLxESUnHvHHCb8BTQf/oIMnF8x3Hm20AXqjrnkiJ1qRh9cF
   2Ktu4G83VLhVieerBcEr1Q2RP28KS4xabQ//BTOCuHZwyhAcXSVKFwvMy
   g==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673884800"; 
   d="scan'208";a="224419395"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2023 20:18:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOBOV51rd8UOcFEayOV2WkCfgQTbDWJIg3fCMCu6vH2+Ir9y/S0iN7adEJeyxrmpVYBmccei7v6zVhXQjtyjEFuaK+eKANcbYlTSdjgtyXZKAfaVQBot3qAYpKWS3OIjCI0XzWRYa2Mvl5wtMUm31gW1UYuJtp7ZYUxCC20tD3vEZMr1ozmmt0vKCMaC+E/Z1xRd3/qx+lJ6f03B+FFb1aQtuUjVXWRbpw2r38Xyc0tO9HYeaYRp/7Y3MlU5eA0hRt56//8cDzljGeL+Nvx3BSRDAs9LPnXuhSbQ9DXJCaNuEGRFL0v100an9K5MtapvfLxlvnjhTqvuMAmUWMMibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QJcQQixdAhzk/7APBVOD6/nwaoFtKkmXuOe9ZDNq4o=;
 b=hd5xmEpIggADSCsgtYeAtl0UqvkQBzuchGgrXESBRYoo2cnu5lxXxGhz+9B5/6UU2qHJYHkfFDOCOm7P1QuOnmAp33IxOHRJTpAFwlDn0gOCuS+QHB0os2kezP1MJXd/oYPYQtbyz3pVpYprNHmfB4GwGjVixZY5h7t6uuTwMjUZTdFXIPmhnk2cdUsxRXFl50N3AJaW8SHyPhG7vADmKdLAZMHtMQZMP8UbJgoM1Er6KVFslvs1eueE8XpvQWgl4EJkeaPcJm0l+wmQvjrBUe8Fe+8zU6av4+llL6uMSZFlOvNSKOH284xyuaB0DP9F0QgHpSwNT3fBsdRDmYewqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QJcQQixdAhzk/7APBVOD6/nwaoFtKkmXuOe9ZDNq4o=;
 b=j7Ax1zRg8K2GI7AFSYB1jp4iEMp1pYPN0y0WlJn58zmDZ7YhfixSkWJmLoGCWTODhs7/rH/xXWogPTorg8Y82ysu9ArJR7gqwD0642fkBvR3m4IPQ3XkffvyntMx1YjNa8syW6KWVMs0TMUQt2fdp/xxcT1jdp8w5sErQY3twR4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7882.namprd04.prod.outlook.com (2603:10b6:510:ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:18:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:18:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/24] btrfs: pass a bool to btrfs_block_rsv_migrate() at
 evict_refill_and_join()
Thread-Topic: [PATCH 01/24] btrfs: pass a bool to btrfs_block_rsv_migrate() at
 evict_refill_and_join()
Thread-Index: AQHZW+ZTU8joe+qJm0mr7PQ6lNlIa68FJqEA
Date:   Tue, 21 Mar 2023 12:18:16 +0000
Message-ID: <3357c01f-9c6c-fb32-4e95-19dfcdec73e0@wdc.com>
References: <cover.1679326426.git.fdmanana@suse.com>
 <e0732832e3c238485454b0a46f0d6da983a5daa5.1679326429.git.fdmanana@suse.com>
In-Reply-To: <e0732832e3c238485454b0a46f0d6da983a5daa5.1679326429.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7882:EE_
x-ms-office365-filtering-correlation-id: 5bc091bb-7660-49b0-279e-08db2a0659db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /6+75qgEjHFWkvwJ+RLqQ6tmyAsIJvnyJOlfH4TTdkQHuRM3wdGNRPWi5iYxAxfwUYghpQ23UEMnn/kclaDvL7C1Ncdy0Ffql7N9inE+QnbGKTSGUe/XE+VfYAB5uZULoibOFdvLokCBhvLyaU5h/hepTh2ZAQgoFMSCF77QbYzPvrkv4AZYxLWMS7JdmtUTjOgR6nbsaueZ9Tp6uIS+W4T0orhHmQAvz6l0jikITE9QCXrOBNnjEvCyiS54Ej8eMAiUIiEdplxLUVt9TSAYJx0STKnHrZHsRSSLQwVy7bSHmDpgdwxXQ04TDnVo7xDl6n5K4pTdH3ht0CoY7iENQW/NVxsxCWZNDnUGSDO4KdFA6Nc/bDdgaBZRvU2mMoWTsuCkqrJOnnMWxdjfWp9UsQO7dUCt4TKhQbFZek/xegYivJNTzI9bU7B/bF2Ypr/MbbCFBrCMRJcggMW0sF7CcDQS5VLTjFTkVCAd9yT3JcQrwwwVmQckKcDr6/+FBVViUsq8Mp7BD18E5oveLmWvPS6G3AUthtwijelgAKU+c8Z0M50CLbOr8cCSrmHXkCF0PDQ3pwW3LUbO9CwSCNreIAD30ESmJzbuof8UuQE560hV0FtROuaLD8t0NAsfdeEmZjoiRmJuYATrMvrNGlYAyQoF/T5TYAmSLfTZ8bTrZf9NHSKBuXsPXTfLRW2ZAR7C9NEmozveFHsPvm1a1bQ7mZVmUxygZBtHJR8XE1lo1MKAaPxU4oNPW+MjGQ6KqmqR78WO3vKYGBHYGEZjFUx4Kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199018)(86362001)(38100700002)(19618925003)(31696002)(71200400001)(122000001)(558084003)(8936002)(66556008)(110136005)(316002)(76116006)(36756003)(66946007)(91956017)(66446008)(8676002)(41300700001)(66476007)(64756008)(5660300002)(478600001)(2906002)(82960400001)(31686004)(186003)(2616005)(38070700005)(6512007)(6506007)(4270600006)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS9IcDlyclZaSk1HRnVDS3dya0VXbnhEMkhwaFFQalJUS3lFTlJpQTZBeW5Z?=
 =?utf-8?B?b1dwVERGaGtXNWRMUDdCbnA5a3NtVDM0WTE5NXQzdVk0cVQxOUU0cmtJTnoy?=
 =?utf-8?B?VElKWWp6dWRRb3h1S0hQUWIxNUFNdnZKNTVCNlhqSFF4aFErd2tnN1BzdklU?=
 =?utf-8?B?WjRkeU1kNmF2WHdRU004eENIdXlLdmZlT3libjZONkZYdUcxamcwZTl6YTQy?=
 =?utf-8?B?M3A5VWFmc3Jha3J5UDNqMGZWeWFncjVLbE5xQ1RNMERYVkFXK1RJUGlKaU5U?=
 =?utf-8?B?K2dWaC8rMVlqeU5heVpxbkIxZUNnWHJSbHlPSEplN0FEa1dVSlFwSy8zZlk2?=
 =?utf-8?B?R3I2SUdmK1k4N1EyS214ci95NWJSTlJCRmFFTTNYWjlBUE05T0Z5a3Nkalht?=
 =?utf-8?B?NURUczRnMkg5ZTluOFRRR1JNZGI1OGRtWDRVR2E2cEZLRm45TFhXSkx2NFcv?=
 =?utf-8?B?NUdUdlVmUzllWXFTUm1pTC9ySTBMWU53dnYySXZvWURyUWlLYmRPc2VDd0ov?=
 =?utf-8?B?c0oyVTFKTWMwSkRWTGZEZ2pobjVNKzg2VjBCUWFNTTEyV3dESDU3TWMrdW15?=
 =?utf-8?B?Ky9DS1VnTmx6eXd1UXpzZ3VJSE9SeXlFcE02T0xIQ2x5R3NrK2JOeDRHdU8w?=
 =?utf-8?B?dm9Ka21qVkxDK2pWNVZFTFpKMVNIRnQzd0EyR3lETG1Kby9sYUhhMHFGVXds?=
 =?utf-8?B?Y0RBL0JUTWt6cEJ3WFBBU2srbUZhdUhkNVZQYW5RUTJtTVlZZEcyUjRZem0y?=
 =?utf-8?B?NmRZcHhWaVR0VEg1YkFTenlTaFlWV0xQdTRydE4zRUtrYXV2bnRpY05lS1do?=
 =?utf-8?B?UGcvQm5yODNCWlV6N0RETW9Fc01kN2ZVSENKanF3cmZickZqR2FMaGJMR2xx?=
 =?utf-8?B?OXUzZDJmV0l2ZnNseEdPUEs2ZEpoekE2amF6ZjhHNE93VHFIUk1GWFZWZERW?=
 =?utf-8?B?VnFja3VpSnN4WmZTanNFVkhsT3phN2NZYm9rQVF6L0RVYzlOc0tUOWY0MGZV?=
 =?utf-8?B?MDNWaC9MYVNvTVc0eHRPb0d4dGlwa28wVkNrK1ZkMDlFYnJaMnVCa0U0MDZ3?=
 =?utf-8?B?N0xlbkZoZ1g1VlMwZzdSTllkRmkzLzJHT3dhZWVUNWlraTFYamxBY2NXZDUy?=
 =?utf-8?B?MzBCeEhRY291NW9QejZIUk9zYXFSR1gyTTVWeWhoQmpjdTM2UXVDb2h1NzI5?=
 =?utf-8?B?RVpJRWE3dXNtWmIvMXdkdzVSYUtqSzhodnJrWm8wc2sveDB3WjU0Q2l0Z2U2?=
 =?utf-8?B?cDBtdkpLM0tBY3ovc1FxRmtuSzdQZkdpMm4weEEwVnVzbisvUm1BUDlEVXkr?=
 =?utf-8?B?Vk8za0haUnprK004dC81TjB2UFVBdkw0WmNCRjJNdmxaVFdvczBCcXBiV1Ez?=
 =?utf-8?B?enBBQ2YrUVhFU1UvdmVPNkltMzVldFNuTkJvbWtJMURtR20yMkdyRkQwT3hN?=
 =?utf-8?B?U3lkTWN0M0VMTWhoWWFMOXd0cUZxNThlWXNWdzNaa1FGS2gwVldVRGdId09p?=
 =?utf-8?B?REVqSmpaV0RpaWxvdFA0K29hbmtDRWJ5eHNhcWVEMGlXS0V0eTB4U0JJZWxY?=
 =?utf-8?B?RlBVa01ZbC9uYXFBVXZLaXEzQjhHNUxIdzFRd3ZCRnh0OVpxTXdlSW9xbllF?=
 =?utf-8?B?OHBtNXVia3hmYkNSc0RYVE1JYklLVGtzZFlneXNNVndFR25RcnptT3hkQ2ZO?=
 =?utf-8?B?a0daUXJnZ2xGMEhSQ3lzbVhtWUxPOEZKZDZ6ajF4MGZQT3NPeStlZkRGbzVD?=
 =?utf-8?B?V3NNM3NRWFZobXkyWlJ5aGN6QlB3dW1FYm9TT3J1NlAvTkptUVBqcURaMEFy?=
 =?utf-8?B?TGFNVGRqK2tQUENDamd2VXdCaERHOGRURXY1Z1ZteU1OWTFXbGNJQ2NjNFFP?=
 =?utf-8?B?YUtYWkRXcG9HS3ZmS2xZdHJEWlJLWkxlNkdvTG50V25DTW9NVGpNbXFlQjN5?=
 =?utf-8?B?Q0V4aHh1b1JtckRwQ2YwM0U2VXo4dlduSk5aZVFZOFRRM2pSWDhxdTBiNkZz?=
 =?utf-8?B?NXpKOW5wVEpheDFOMjI5czdOZDIvUkNFVWRubG92ejBnY2hTQi9ZV1RSTFpa?=
 =?utf-8?B?U1B0RTBhQ2Y1bDI2Q245c2NTU1I2Z1d5c0FWdGExUHBDZHZaNytxNlZhOVNx?=
 =?utf-8?B?c0tGOHI5VEZiTGpNd3JRcEw4cDc3TGlRanJRSkJwUlREcGpZM3V3bEVkOEtH?=
 =?utf-8?B?WFpmSTVCdGdYaEtZU0VDK3RaV0pxSWFIOTB4RDlOR2lPTUg1Q0lLZHozM1Ni?=
 =?utf-8?B?WWdVdGtxTUE4bXpnMG95YVJubkZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA51322871852040AE3C136E7B61DF7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ubON/ZXfuPaUXo8DZaTQm8pFsAqKT/7c9zaeXbkoNIFKbJpRca8NgtAUG/OaqGBdBmUj/VHZMysLLN1TBJyARW+uyhsmUbEOflowu2dJ/+OWMayWdiqTGuYw3cp11autkZokgWkCF6A9UMPM+RnwfjtC3eWRKPKhNY9uP8i75OeZpEpRpuI8rswR1FajEV2SDjheF4db49vHDvZjZtYxSxbRmWJCkkA8XDHXGDeaVW8f0tZiavM86P/bSqAWhdUeC+3zDIMd99Oh1IkWu5WnbFOU/Y8A7Zx5hSMxFUdTFX96n2AOFZqT28/3ypYGxNn5o3K7TWIHQ0tqk4FdsnFWRnoX12WN+Zc1FG9+T6qXR3AvYW3vhvmy9npoXOXaRXjuQf7a/lhJOERkIucpsEU5Pued4YZeJcc+fSblUmCycbjchSbyI/b/GKgZK1FWdRPBQDcSWLG3XYeclKDG0Rgfi112vIwenLpOXY+6jmAmL1Kd/5+eKc07vxB4pCO89CGGAy/rSPtTh/RVluM2pqt+zMaDq+OtMAQLo28fI/yZ9Jc9N866Uts6lJ0brM91Is1MzvnMAMuELVrHLyhOh61jNSh96/HIVGwmuQHqKaOWnzpd0K5zLJirkfqHxWfiE2PKYNlSkPHLIA1ZbMa+cCBI6GIDbgynK3Im3BhiHJUgXxjD6IiMPmarDu9WuNbzOi0mYebob/2IFTZU1PfeO4EMP0J/7V2Ddlv2ajSuv2teRZvfDuakQRMvzW35T18OeIjYdc3cHEVy5ttvF9Z4jIoperZEJrAnviGjigeG8kdaSUycRJSxcA4UhRY+K0ZaCLkL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc091bb-7660-49b0-279e-08db2a0659db
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 12:18:16.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x94akQOrcKTFGZyHwt+hpCnzM6FfPJB7p6PhXTL4BUDzf8ovX00kE53QGWGn6T3ywv9iO7J+p1Rrdh9FR40GRz+luhCdmrlES1VmM2UcPi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7882
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

U2ltcGxlIGVub3VnaCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVz
LnRodW1zaGlybkB3ZGMuY29tPg0K
