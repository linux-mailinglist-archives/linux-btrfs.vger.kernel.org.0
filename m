Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A9752D0B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiESKmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiESKmJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 06:42:09 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6647966FB8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652956925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3fmfgzcfsGgkP3gMEXfIGQQIQCUYcBTZZ5Hl8URqnHE=;
        b=I/IoLG53wgLeP+/tgPq26JUzx0nIvdQY4fQS7XRPJMWNlCvAe2ptuGgS51JaeEdFijcSWC
        oAxiO+b15BruRrNhVuBZXhAXVxXKNZYQ75MZwqRrzF/ir+IHbGYchrVOHO94UydUsdD2Fi
        qZkTfU/wGaEbtTMg1g8lxJ6q1ODuDZo=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-eqxKQm0dNCaHu-QZ6UjDpg-1; Thu, 19 May 2022 12:42:04 +0200
X-MC-Unique: eqxKQm0dNCaHu-QZ6UjDpg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBW6uRZsmvsXB69Ce9GotvX5rXfbaRvVYjBhFXz3zCU9SEPJzFnqao40gp6D6GW7NY2OHo1nhwBDVb/yOb9BWSO6hkdoGFACq0lSza6QSmSesw4obncE+JTMJC7CuIeTuLESPThWv/4K5Ug44zsQiRElQcMGpbViqlcSlcazGAnBUs+0rhWRex40otuRW27buqwVk5rGQL0PI/MkaR8/wmiAQgIb1agzpU78DTiJQF9bsRYY/NMNxhqXo8BHzPQ2w+VDh6han7BtC98w0+Z/ndo0jlWfMpw+GtF7q3URSz0bM0HGHJLQyKsFK2toQK5cqBWorGnMvlgRg8kFT5/QRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBQco4hFOVthi9WHNYWH67KxFylWBq0ml2+CN5gcQ7M=;
 b=QB53HT+CU/GVmQI5ShyooXlCkpH7v1h/uebnrOX06RLwguzv7qNurLHPjCzSlgYSZcA+K8dBgte6a3Z4GZRE/Dz4oRxgYogsDxIpeKfahLolBinMWYDf7PDnNgeRo2nDpV3my+UQjmLxKoopkszmWoSZ742ehTVCHzfiuYUnqieNtK9nc/1zLF+Ysy+81YSQG1R9O3sXQ+4wenaBTw0B0g+RGIsK7sXsHZ6g2RsNPD/ACHwq+OKsyD8smSHe+fW0mUEz3vjnoyASHp9aSd2p9bazfE/ac7Rvz63BH822EOXEJ7Rlyr16BgMoaN1LOviJIt3kfE3Kir4YteoMy65xGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM6PR04MB4423.eurprd04.prod.outlook.com (2603:10a6:20b:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 10:42:02 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 10:42:02 +0000
Message-ID: <d99b2ba3-23d2-0ea1-9aa4-13a898e77ab6@suse.com>
Date:   Thu, 19 May 2022 18:41:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-13-hch@lst.de>
 <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
 <20220519093641.GA32623@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220519093641.GA32623@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e60e243c-75fa-42e7-67a8-08da39843583
X-MS-TrafficTypeDiagnostic: AM6PR04MB4423:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6PR04MB44239D8F333EB9ABAE8192F3D6D09@AM6PR04MB4423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eouYEldCX6TkyRr9lFf+sgwqbcG4ne/J1ivSbltxpJu/jbSOdfWwnf2Ql6O1PUnPgodXZiTnmdlhvFmLxcdWT2wrVdBac8GFqjeDAyAFMF10dE+vK+dF6dkoClP4PEDfILtHFiLzc32HXC0AksoFQetMJEO2cXRmMIGV9451jQHEPTZMjTM2uM69uuyB5ybAOeuFJHVw8+7kLHDfJvgqJ2vBuFBfnKKwCBoPManwxidyVdjfe5ei1udOmz4AfdgsyeGPOZjzhELtEwJ6TeP2bpgbKGZrA2quLpHdVtvFodJoDrfh6unfjnDCol+a9WJwr6VT/JV/zCbuNhtGPZfHQF4K4cuNZagTuboMih1pIQwmbu8lF+I4yGvz0a918ACan7DZ0c/OAcp1nhV4k6r+ivetVq9xpEL6gas9+DFLvJZRCmvS0jKrW5aBBF9t49N1AAE0w3ilK9SNODiGNmjG+4RhkExs9/Wf1UQGhOGiYYuira30k5WLBKJPApYdN+EJxm4uZP+UJ8vU3ArL1dfy/RA51lnV5KtrNqlEOKiEyKYSfJZ26/aiOnUByARqi3/WFzTFUym26XB+96Giw/UyRjxCutm9DhLuALVhemlldq6XYLim9CiJMFppxL0KnmsrKGoYl7fwCRJWIzzTjQKK4S22ZkJ4OoF1y9Rd6Bw4T9vqJevntPvZyMAOm1A0SAIJ/Cve3/XcNFCM3QRc7ezbfkw2EAKTtl6Hf1/dvT2CC87YkFYEZ68wL0trxfz4r9AG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(53546011)(31696002)(2616005)(86362001)(83380400001)(5660300002)(316002)(31686004)(66476007)(8676002)(4326008)(66556008)(36756003)(6512007)(8936002)(66946007)(2906002)(54906003)(6506007)(6486002)(6666004)(508600001)(38100700002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5tQ4pBiEiXUKxIUoT9kQg4aKgp5WWTfy9Q0+nhLUN5lkHCt56drrMqoaWkNm?=
 =?us-ascii?Q?fny+jlJsmaG6vnAqS9KR00A1Kqs66rdc/mFd/H+l2sR8KpIITvSB8eQ5YdGG?=
 =?us-ascii?Q?61f1qIv8xEBvVXidgL15zTErFLv0plYzPyQHZXRaxaKgXvl/5AYOq+yJEbLi?=
 =?us-ascii?Q?+/Db9KCCOC6hNDn/W+CeY2/3YqAQeZWjaQuXTTlFJlCTC7JUmh7hOWMCkTWR?=
 =?us-ascii?Q?lcm4d+J2f9D19z2nlmCORB/J+rHSUHGP1DbTYKBq8Q5b3yG830KMOzmSPUeq?=
 =?us-ascii?Q?E/ybsFVZySWJUbb6ZsF4RIDGP4OaTPvJlIH/p4HZhm02R+LdvUjVyUbichcK?=
 =?us-ascii?Q?qIRnI2nsgssIHKc7c7db5oy6nFIzvqGCcfDUR3nlZQM4NeZgYXYavLwPP5C+?=
 =?us-ascii?Q?YBWyjeMyVt+xYPRMun8noVmRZGa9qIIOXE2zWufFaKiYMrgAY8p6Q7bjr827?=
 =?us-ascii?Q?2V9jfIveUskJvi1w5xyCsD+rrMyCH3As3k/VD1ixaa7fWh6sWBqcdddMgRoB?=
 =?us-ascii?Q?pdtVNLlADV3qndsDdy4a9cag7LRrdm2Czz+Pxc6LWxKEebvy/b1C873faWGg?=
 =?us-ascii?Q?aZ4hVPT6kd6eaiM8X2sVIoqPTEaZvMBwnSMAt5ybHC9SWnE8/tLSIiaOHnKw?=
 =?us-ascii?Q?sMYhgWpgLHS27K4tN3x9JnNdSt1WwwJ8K7wijwnVHOTvz2SkkwzIVbklJDHf?=
 =?us-ascii?Q?PFjQa2KIvfHL3PDO0Vi8kFXemGinlOz9z+oYebG7KN8w+hUKytJpY/ZvM/Kv?=
 =?us-ascii?Q?HuX5ekk2r7wcNoGrNZPTRdCMlXzUWghiVy3V5WfPdzs0R6WCnifGwEPcdulL?=
 =?us-ascii?Q?zrafPLE4SRXC8SM5iQzRibn2EBFnBIgLrgIQjt+TMhMqOKjAom9zk1rw0Lmo?=
 =?us-ascii?Q?Und9EH1OtBBCFaY+ueGFVfoWDpn4jmEz26JCZcVJWYWfi+EVaeZPclVZy383?=
 =?us-ascii?Q?AzG2u4+8IFnOx8tSQg01S4eUT4UGWRKoI/5Y1D47zKrp1VF3rd2zGrh93DKL?=
 =?us-ascii?Q?LuSsLPycoOsDmCRknQqQzuXmGHdDjwvdsOlfK6ZU+bBMG/8yRdWnNdO7NVt5?=
 =?us-ascii?Q?ab1fV+6AD/xCEA69R7GFZwcf9edpR+Zg9JrbLih6HRyus6EvcDys2lqUdI3J?=
 =?us-ascii?Q?WeM7N/8jFotkiFUY9mrdNisByKmvHFj/W2zYSMUKKjd7zYurEVuvZlehVH+z?=
 =?us-ascii?Q?EHRwX1Vjec5G9I2DR7CJV4PT1W9X6h9CqFp7dabwuOT49+l0lpU2oP1MskNN?=
 =?us-ascii?Q?f45JKicLs2/qkv9cA1lIbVHzjCvEcSmGshuAri6XLFGqbMmxciBOW7RpRJOJ?=
 =?us-ascii?Q?uup/EXUJQti6Rtc2G6r6vtavDtZSuF1fZcLEwVxMIfAIQhvaJpBf+BHU2G9O?=
 =?us-ascii?Q?44iMvQJP5BsQd1U2yr6OscvKRthzLyoHOQzpv8ZsO7AalCYLNnVh9SeuocV2?=
 =?us-ascii?Q?PsFG76BUmx7/X3cPQvz1lzcsCzh46EelwPOzQdvm2s7++KSa4GSjuvWFUZam?=
 =?us-ascii?Q?9w3qqNQ1qjmN9T2CJS4ZdJpiFHBsHePN1GVoLDMQKMF6GBpe57bkkEhf2UjT?=
 =?us-ascii?Q?iUU9XnnZfIzv92vtNh9/5Dmg/PpL+ZodRG+4yzYO3Vdi+wGuZitxTnem8v0N?=
 =?us-ascii?Q?wOVJQEx/3Z+G1p1NdZhkvbLVVi10jiPwzjNvq/54jF2nkkgqnPKBefuIbw4S?=
 =?us-ascii?Q?jhZWPcy5WgHIoC0eNjOFfbyUmgvMdowTCUozzJO43ftYW0HxC956JffzQ955?=
 =?us-ascii?Q?Dk8JHSQhzTRCWbEGNYh30Hw42LxqBltGrNc9PEn/OSR5YRB6z1/JFGMWvFjs?=
X-MS-Exchange-AntiSpam-MessageData-1: Ft7Au4+mASAggg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60e243c-75fa-42e7-67a8-08da39843583
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:42:02.5755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHfDUzP14a1fKOGOp+SeRypQn6LMnQ15sYVC0mu05DrUMeshyMaKvmvCoWQB3c88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4423
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 17:36, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 07:04:22AM +0800, Qu Wenruo wrote:
>> Function btrfs_repair_read_bio() will only return true if all of its
>> data matches csum.
>>
>> Consider the following case:
>>
>> Profile RAID1C3, 2 sectors to read, the initial mirror is 1.
>>
>> Mirror 1:	|X|X|
>> Mirror 2:	|X| |
>> Mirror 3:	| |X|
>>
>> Now we will got -EIO, but in reality, we can repair the read by using
>> the first sector from mirror 3 and the 2nd sector from mirror 2.
>=20
> I tried to write a test case for this by copying btrfs/140 and then
> as a first step extending it to three mirrors unsing the raid1c1
> profile.  But it seems that the tricks used there don't work,
> as the code in btrfs/140 relies on the fact that the btrfs logic
> address repored by file frag is reported by dump-tree as the item
> "index" =C4=ADn this line:
>=20
> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 itemsiz
>=20
> but for the raid1c3 profile that line reports something entirely
> different.
>=20
> for raid1:
>=20
> logical: 137756672
> item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 137756672) itemoff 15751 itemsize=
 112
>=20
> for raid1c3:
>=20
> logical: 343998464
> item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 298844160) itemoff 15621 itemsize=
 144
>=20
> any idea how to find physical sectors to corrupt for raid1c1?
>=20

I also recently hit weird cases why extent allocator no longer puts the=20
first data extent at the beginning of a chunk.

So in that case, the best solution is to use "btrfs-map-logical -l=20
343998464", which will directly return the physical offset of the wanted=20
logical on each involved devices.

Although we need to note:

- btrfs-map-logical may not always be shipped in progs in the future
   This tool really looks like a debug tool. I'm not sure if we will keep
   shipping it (personally I really hope to)

- btrfs-map-logical only return data stripes
   Thus it doesn't work for RAID56 just in case you want to use it.

Despite the weird extent logical bytenr, everything should be fine with=20
btrfs-map-logical.

I'll take some time looking into the weird behavior change.

Thanks,
Qu

