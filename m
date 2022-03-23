Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD24E593E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbiCWTi5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbiCWTi4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 15:38:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4618AE52
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 12:37:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220323193724euoutp013f47315c7c0bf4c80802da6fbb29b4df~fGbK7nG2l0050400504euoutp01c
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 19:37:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220323193724euoutp013f47315c7c0bf4c80802da6fbb29b4df~fGbK7nG2l0050400504euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648064244;
        bh=plYOGyh7jR7O+BmDiHcHeHJdfIg/906AXupWlBFmig8=;
        h=Date:From:Subject:To:CC:In-Reply-To:References:From;
        b=joubyw9WltqyatSd7dfwnw9aQg6kqkfhVMP9oKrrLJu54E9gTDZTY+Bfz/EfvPnso
         s1SeUXSYFQgMTKT6yJsu9+HEXzoZF1zOeMDNGDdGaIpda3eAzXOPE+F1FTVCl7Ec5R
         uL+VDgugO4cgtTpoZUh7y+VpLYkmTajvVPZTY4GM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220323193723eucas1p2bb5435d6bcc56a35bcb239119f9231b1~fGbKvKk-t2458724587eucas1p2E;
        Wed, 23 Mar 2022 19:37:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 93.7A.10260.3F67B326; Wed, 23
        Mar 2022 19:37:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220323193723eucas1p235ab0ebcd1580901c192d244c3f977df~fGbKfl46v2457424574eucas1p2D;
        Wed, 23 Mar 2022 19:37:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220323193723eusmtrp1b918a969e71dea2d91836f32f66b2b41~fGbKe9Kng0860008600eusmtrp1R;
        Wed, 23 Mar 2022 19:37:23 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-01-623b76f3180a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EA.4B.09404.3F67B326; Wed, 23
        Mar 2022 19:37:23 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220323193723eusmtip225585ae223504a2382af4e7149726021~fGbKPrC9C1483614836eusmtip2d;
        Wed, 23 Mar 2022 19:37:23 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.55) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 23 Mar 2022 19:37:17 +0000
Message-ID: <ebfd2c53-583d-749c-764a-7d9f9b86ae54@samsung.com>
Date:   Wed, 23 Mar 2022 20:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
From:   Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Javier Gonzalez" <javier.gonz@samsung.com>
Content-Language: en-US
In-Reply-To: <PH0PR04MB7416D06ED74EE14B13C1DB3E9B189@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87qfy6yTDOZsNrK48KORyeJv1z0m
        iz8PDS0uPV7BbnFjwlNGi4nHN7M6sHlsWtXJ5rF+y1UWjwmbN7J6fN4k59F+oJspgDWKyyYl
        NSezLLVI3y6BK2P71w/MBVMEKjbs28vYwPiAp4uRk0NCwERi0ecnjCC2kMAKRomeMx5djFxA
        9hdGie2Pd7BBOJ8ZJT4umsIK09E0uY0JIrGcUeLzlckscFUdHx9BObsYJdbsmAY2mFfATmLD
        3ZPMIDaLgKrEmZbf7BBxQYmTM5+wgNiiAhESL4/8BRrLwcEmoCXR2AlWIizgIdF/eyMbiC0i
        UC1xsWUdWJwZZP6pmQkQtrjErSfzwVo5BWIlDqywgQhrSrRu/w1VLi+x/e0cZogHlCSuPX/K
        AmHXSpzacgvsGQmBDxwSs+ZvYIdIuEgcmzITyhaWeHV8C5QtI3F6cg8LREM/o8TUlj9Q3TOA
        gXd4M9gVEgLWEn1nciAaHCWe7bjGBhHmk7jxVhDiID6JSdumM09gVJ2FFBKzkLwzC8kPs5D8
        sICRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg6jn97/jXHYwrXn3UO8TIxMF4iFGC
        g1lJhHfxB/MkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxS
        DUxNuxgjlHa66+2Wn/qC7c8f4+e5bw77Jkirn9Px7vYpO5cpxxMoz9FVmvKqxmeTv3rBglnu
        zzYd2ztnMa96uLZv9yYHewuGRKkfTjWc8exBLR/Z7f1tann3bfneWTnpr1/eNt3WdZ0ruo7G
        q7xn4D7ePi/m0auaLXtOht85eebrBpMFrjcvyb7/NeuF1YHo7Pf22XXzOGXTK5bXr0krdck+
        /s7u8vNdfLU/dzE9/pG+Y2bivGN/HUujXuytX5v/7qBCy0Grq2vd7p0Nud14OWaFRpONla0n
        k6zl2yfbvlr/PZetk1Di+qwyq2lZ8P8TLMpTrPdZ2F3qFXCJ8/iaxbJd97LlbKdN94v9Radf
        d1FiKc5INNRiLipOBADXCfF9rAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xe7qfy6yTDNY+krW48KORyeJv1z0m
        iz8PDS0uPV7BbnFjwlNGi4nHN7M6sHlsWtXJ5rF+y1UWjwmbN7J6fN4k59F+oJspgDVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P71w/MBVME
        Kjbs28vYwPiAp4uRk0NCwESiaXIbUxcjF4eQwFJGiY13p7NAJGQkPl35yA5hC0v8udbFBlH0
        kVHiwpHH7BDOLkaJqRdnMIJU8QrYSWy4e5IZxGYRUJU40/KbHSIuKHFy5hOwqaICERJty6YA
        1XBwsAloSTR2gpUIC3hI9N/eyAZiiwhUS1xsWQcWZwaZf2pmAsSuBlaJi6veMEIkxCVuPZnP
        BDKHUyBW4sAKG4iwpkTr9t9QvfIS29/OYYZ4QEni2vOnUI/VSnz++4xxAqPoLCTXzUIydRaS
        UbOQjFrAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMGK3Hfu5ZQfjylcf9Q4xMnEwHmKU
        4GBWEuFd/ME8SYg3JbGyKrUoP76oNCe1+BCjKTCIJjJLiSbnA1NGXkm8oZmBqaGJmaWBqaWZ
        sZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QD0/4mQa1drcmPZKYKXXasMPuWVGJ3skxSPmud
        nqeXC9vb/p/fFtRdnl9yxIzJ8t51N7YDRruZNk8/sqwo6NHbXxXux/iNeGNC+nLfnlhWXnpt
        55xLlZNm/TLf/nrPxLT/uxkylRs/G0jui3z73qZ4gadEfb/db2n+1AWyX8N4V3h7/5r82O+q
        g+aCCpnTZ7pcWSe9db/6gc9086kGS7klNTE/Ymx+63G32x5YoxGrtubCAue4i7tUTcP/JJ3/
        ImXt2xidb6wimOT0vmlhg+TrXb9C/jIXzvv9a7p80bd3yXK3Wf//UbnD5vX8x84kef8UZfXf
        WzmvPejZLvbg81F5ptf78/9+0Cm87df8fVLGAiWW4oxEQy3mouJEADXB9pphAwAA
X-CMS-MailID: 20220323193723eucas1p235ab0ebcd1580901c192d244c3f977df
X-Msg-Generator: CA
X-RootMTR: 20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
        <CGME20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4@eucas1p2.samsung.com>
        <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
        <f4e4a70c-0349-fafa-8375-8c4177a3e260@samsung.com>
        <PH0PR04MB7416CD1BC88132E22790A1869B189@PH0PR04MB7416.namprd04.prod.outlook.com>
        <b0e84388-b56f-d8b9-2795-ec8d74431475@samsung.com>
        <PH0PR04MB7416E2A6492CA8BB2DF07BE09B189@PH0PR04MB7416.namprd04.prod.outlook.com>
        <ec5f09ab-b868-7128-cacd-000f66f3b9e1@samsung.com>
        <PH0PR04MB7416D06ED74EE14B13C1DB3E9B189@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-03-23 12:52, Johannes Thumshirn wrote:

>> This looks good. And the test btrfs/237 is failing, as it should be
>> because of the change in reclaim condition. Are you planning to update
>> this test in fstests later?
> 
> Yes, once I have an idea how to do. Probably just fill the FS until
> ~75% of the drive is filled and then use the original logic.
> 
Perfect.
>> I still have one more question: shouldn't we use the usable disk bytes
>> (zcap * nr_zones) instead of disk_total_bytes (zsze * nr_zones) to
>> calculate the `total` variable? The `used` value is a part of the usable
>> disk space so I feel it makes more sense to calculate the `factor` with
>> the usable disk bytes instead of the disk_total_bytes.
>>
> 
> disk_total_bytes comes from the value the underlying device driver set
> for the gendisk's capacity via set_capacity().
Yes, I understand that part. My comment was more about how pedantic we
need to be for reclaim as set capacity via the device driver will
include the unusable holes (lbas between zcap and zsze).

For e.g., zns drive with 96M zone capacity and 128M zone size with 10
zones will have a total disk capacity of 1280M but the usuable capacity
is 960M.

Let us say the `used` value is 128M, then the `factor` value with the
current approach is 128 / 1280 = 10%.

But if we use the usable capacity of a zns drive, then the `factor`
value will be 128 / 960 = 13.3%.

This might not be problem for lower value of `used` but my concern is
when the drive is nearing its capacity.

Let's take the same example where the `used` value is now 900M. Then the
factor with the current approach is 70% (900 / 1280), still below the
default 75 for bg_reclaim_threshold but when used with the usable
capacity, it is 93% (900 / 960).

So essentially we are postponing the reclaim assuming we have enough
room left but in reality it is not.

I still don't have a complete understanding of the full stack with btrfs
on zoned devices so please correct me if I am wrong.

-- 
Regards,
Pankaj
