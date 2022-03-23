Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26C34E4F05
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 10:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiCWJQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 05:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiCWJQP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 05:16:15 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFDB7628E
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 02:14:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220323091443euoutp01b7f3e501f21c1fbde3b349aa9e9d69e9~e97gg4oVl2692626926euoutp01l
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:14:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220323091443euoutp01b7f3e501f21c1fbde3b349aa9e9d69e9~e97gg4oVl2692626926euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648026883;
        bh=JivL1qR4vWAiog1XTB9P7BPHv+MzS1BzCwm7R2tW+c8=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=B4H31H45o6+XMnq23jaxmtF/FeSqzw87pCryJfMRxOTNApLzj7wtSbpnHcZLVmsrK
         NMj80BP1cBaAi9fJXFr1fWJstJYxLWelD3KQP72/16h5J5pGjvDRlW+s2NzY09F2D1
         b/ZuJF5e96UPgfqI7lDGyIFgC3qKcKKS/ZFHKmE0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220323091443eucas1p23f634e90688fa1d0188e67e4295b4e47~e97gLTzjp0485004850eucas1p2U;
        Wed, 23 Mar 2022 09:14:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 80.4C.10260.305EA326; Wed, 23
        Mar 2022 09:14:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220323091443eucas1p203fe319d15428466bc42f9a183f3be52~e97f3JedR0280102801eucas1p28;
        Wed, 23 Mar 2022 09:14:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323091443eusmtrp2ae291b9e550254ec9c185801c85b67cf~e97f2boTE2237822378eusmtrp2T;
        Wed, 23 Mar 2022 09:14:43 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-04-623ae503ad1d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.4B.09404.305EA326; Wed, 23
        Mar 2022 09:14:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220323091442eusmtip2686bdb6d33983d762466180309891c36~e97fs22g21809118091eusmtip2H;
        Wed, 23 Mar 2022 09:14:42 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.55) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 23 Mar 2022 09:14:39 +0000
Message-ID: <b0e84388-b56f-d8b9-2795-ec8d74431475@samsung.com>
Date:   Wed, 23 Mar 2022 10:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Javier Gonzalez" <javier.gonz@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <PH0PR04MB7416CD1BC88132E22790A1869B189@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7rMT62SDCa+l7C48KORyeJv1z0m
        iz8PDS0uPV7BbnFjwlNGB1aPTas62TzWb7nK4jFh80ZWj8+b5DzaD3QzBbBGcdmkpOZklqUW
        6dslcGXs/LqereA2S8XspQ/YGxjvMXcxcnBICJhINDYHdzFycQgJrGCUeLaoh72LkRPI+cIo
        cWleNETiM6PEvhNrwRIgDUvmXmKCSCxnlJjxr5kZrurvlV5GCGcXo8T8N5OZQVp4Bewk5p9e
        AGazCKhK3Pi4hAUiLihxcuYTMFtUIELi5ZG/TCC2sICHRP/tjWwgNrOAuMStJ/PB4iICYRLX
        rjYwQ8SBFpyamQDyA5uAlkRjJ9h1nAKxEouPzoZq1ZRo3f6bHcKWl9j+dg4zxAdKEteeP2WB
        sGslTm25BfaNhMALDomDm5awQiRcJP7eaWWDsIUlXh3fAvW+jMT/nfOhGvoZJaa2/IFyZjBK
        9BzezAQJVWuJvjM5EA2OEs92XGODCPNJ3HgrCHEQn8SkbdOZJzCqzkIKillIXp6F5IdZSH5Y
        wMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzDhnP53/OsOxhWvPuodYmTiYDzEKMHB
        rCTCu/iDeZIQb0piZVVqUX58UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYOTqkG
        prmnhO4u9td9z/yeLUWw5//0E64SZzk7olu3n/TbwJS9b/mPphtbz51yYrnAPrXLWPHZ711v
        399Oe/Nn3W+9ffpzOwvPcZn95n1Qye+pElLJM8/s+/MI76vm87xEnULezNCx225ym6/xvMyj
        MM7sG1pvJ04Pm3nS+PC9nhQDydSTVsrXjmkx/qra3seQN0Vo8VkF16eCVtqObJmsi839Cr51
        75AI/aG3aGlMj+J8xmae16bdnxYfsHD9yahnd+2e9F1/J/aism+vCtj8DcQ5U/4xd71a8dJx
        4bIQt+0BcTU85xbIbqwwLf/jK8f5/ecSxthVjMXTn6+X7+f23+ShLLzhwZyXnZv/Pgxt3LeM
        U4mlOCPRUIu5qDgRAJRT8nynAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7rMT62SDBYeYLW48KORyeJv1z0m
        iz8PDS0uPV7BbnFjwlNGB1aPTas62TzWb7nK4jFh80ZWj8+b5DzaD3QzBbBG6dkU5ZeWpCpk
        5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXs/LqereA2S8XspQ/Y
        GxjvMXcxcnJICJhILJl7iamLkYtDSGApo8S+6+8YIRIyEp+ufGSHsIUl/lzrYoMo+sgo8erB
        CShnF6PE1N4nrCBVvAJ2EvNPLwAbyyKgKnHj4xIWiLigxMmZT8BsUYEIibZlU8BqhAU8JPpv
        b2QDsZkFxCVuPZnPBGKLCIRJXLvawAwRB1pwamYCxLIPTBLNPTeBEhwcbAJaEo2dYNdxCsRK
        LD46G2qOpkTr9t/sELa8xPa3c6DeVJK49vwpC4RdK/H57zPGCYyis5CcNwvJGbOQjJqFZNQC
        RpZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgZG67djPLTsYV776qHeIkYmD8RCjBAezkgjv
        4g/mSUK8KYmVValF+fFFpTmpxYcYTYFhNJFZSjQ5H5gq8kriDc0MTA1NzCwNTC3NjJXEeT0L
        OhKFBNITS1KzU1MLUotg+pg4OKUamNjMndxLL1pefy3PUJpx9AhHRfI9y9Os6xf9+XUq4Z+r
        9rOelucaDTcWHbr4+RSz4cKln3hDJdN+vPWqd/sT+tF/dgzjmecZs52UnFRskgTd7RWmBtic
        f8Ajzcu3dn3Gac/ee78WycTWvrQ4q6Z2te/G9akuy0KMHb0XX/mdsHZ5eD3vU4ZHVr8UOjmX
        G2qs2zzj5aR5dzNuCuktOl63Y3fgc4aNy9RZz+QuSVI+Z+ZbxPMkwlA6kWFD9bzHO6NXV3Fc
        5D766EuBsbi8RJfhJvfth/ew5n9oLLJzDn46dVWUQmjElsld5w/zuDArJ9062bmRV6zg/qTp
        wrvCj5U5R6mHezjyxnFLeMj1t7y+osRSnJFoqMVcVJwIAKa6MFJdAwAA
X-CMS-MailID: 20220323091443eucas1p203fe319d15428466bc42f9a183f3be52
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



On 2022-03-23 10:11, Johannes Thumshirn wrote:
> On 23/03/2022 10:09, Pankaj Raghav wrote:
>> I am also noticing the same behaviour for ZNS drive with size 1280M:
>>
>> [   86.276409] btrfs: factor: 350 used: 1409286144, total: 402653184
>>
>> Is something going wrong with the calculation? Or am I missing something
>> here?
>>
> 
> Apparently I'm either too dumb for basic maths, or 
> btrfs_calc_available_free_space() doesn't give us the values we're expecting.
> 
I would say the latter :)
> I'll recheck.
Let me know if you can also reproduce the results.

-- 
Regards,
Pankaj
