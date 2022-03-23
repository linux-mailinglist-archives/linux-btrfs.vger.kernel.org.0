Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1945C4E5143
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 12:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiCWL0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 07:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCWL0B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 07:26:01 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71DF271B
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 04:24:30 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220323112428euoutp0178784544bf77cc79f9bbee26698f0c57~e-syaxd_q0922509225euoutp01t
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 11:24:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220323112428euoutp0178784544bf77cc79f9bbee26698f0c57~e-syaxd_q0922509225euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648034668;
        bh=4rrfV0nV9YNFWr2G8eh+hujiZPia20dEFzbhk/pVJ6w=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=mpITlEZCO6AitlYyFudYIr1/4bbvRuYRwmA6qJ6+Iw9v+m6EEfcY/B03zqC1XD6zZ
         raR4WmBrnpy+ljqDJbKZ6kqqRMcY6/k3mavuacLd9GO+hzVK0aeLi30jkKSVx/5Hg1
         l2/L9JKMeELUcC5kI5onlB4ra+zZFDbYcRolwRKU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220323112428eucas1p103b1b151b23b8f233a6a1e7bdd017a90~e-syNMAvQ1649816498eucas1p14;
        Wed, 23 Mar 2022 11:24:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CD.C6.10260.C630B326; Wed, 23
        Mar 2022 11:24:28 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220323112427eucas1p12fd8bbfbe35641df28032260350a585c~e-sxwduDx1219812198eucas1p1C;
        Wed, 23 Mar 2022 11:24:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323112427eusmtrp2927bfb643c281120a5030c527f61a349~e-sxv3c3u0565905659eusmtrp2Q;
        Wed, 23 Mar 2022 11:24:27 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-90-623b036c412f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 97.C1.09522.B630B326; Wed, 23
        Mar 2022 11:24:27 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220323112427eusmtip226679943faae73d48e1b8a84edd48720~e-sxoQCfT0303803038eusmtip2f;
        Wed, 23 Mar 2022 11:24:27 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.55) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 23 Mar 2022 11:24:26 +0000
Message-ID: <ec5f09ab-b868-7128-cacd-000f66f3b9e1@samsung.com>
Date:   Wed, 23 Mar 2022 12:24:24 +0100
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
In-Reply-To: <PH0PR04MB7416E2A6492CA8BB2DF07BE09B189@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87o5zNZJBnsusVlc+NHIZPG36x6T
        xZ+HhhaXHq9gt7gx4SmjA6vHplWdbB7rt1xl8ZiweSOrx+dNch7tB7qZAlijuGxSUnMyy1KL
        9O0SuDLOHw8reClWsb97GmsD4yeBLkZODgkBE4me3n72LkYuDiGBFYwSj54sZYZwvjBK3N3Y
        ywThfGaU2LzlHTtMS3PnFKiq5YwSO3ceYoWrujZlI9SwXYwSpzdOZwZp4RWwk7j6sBHMZhFQ
        lfh7dwkrRFxQ4uTMJywgtqhAhMTLI3+ZQGxhAQ+J/tsb2UBsZgFxiVtP5oPFRQTCJK5dbWCG
        iAMtODUzoYuRg4NNQEuisZMdxOQUiJWYOTkZokJTonX7b3YIW15i+9s5zBAPKElce/6UBcKu
        lTi15RbYlxICbzgkFvy/CJVwkVh6+SYbhC0s8er4FqjvZST+75wP1dDPKDG15Q+UM4NRoufw
        ZiaQKyQErCX6zuRANDhKPNtxjQ0izCdx460gxEF8EpO2TWeewKg6CykkZiH5eBaSH2Yh+WEB
        I8sqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwIRz+t/xrzsYV7z6qHeIkYmD8RCjBAez
        kgjv4g/mSUK8KYmVValF+fFFpTmpxYcYpTlYlMR5kzM3JAoJpCeWpGanphakFsFkmTg4pRqY
        imef0LzR/GMrr9Jsl5PbJ623Cf9We35VxbJ19TKPX8gmKWh9rjuq6P9R9H/bbnvp53teG/Kz
        1qoWaffKLUo8/eiDCtskRvYzt16d6lugesOk4KzxVvG5217GuMi63rt6jmcHy1tnq30tf1Me
        51ne2PRyzjELqXzRs2Gpe6+wH16pIt9YVlO9ffd5viuOH22nbjv3LfnGRguT2mPHrsrO+3VW
        +hmfZVOdxC771aUfu9dK//3BJ/Pgus2a0kmPLA5sdivgEzzx0uHcbKVl5nOTdkVeLOy49OLJ
        /WTdbz/D7BceknDf8Mo60kDnjVhwsu2aJ9q5JxIz9lXbcAQkKBcnCzMHdEx4fSqVkfta5ZRP
        TkosxRmJhlrMRcWJAOG9YUCnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7rZzNZJBmufqltc+NHIZPG36x6T
        xZ+HhhaXHq9gt7gx4SmjA6vHplWdbB7rt1xl8ZiweSOrx+dNch7tB7qZAlij9GyK8ktLUhUy
        8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLOHw8reClWsb97GmsD
        4yeBLkZODgkBE4nmzinMXYxcHEICSxklml4+ZIRIyEh8uvKRHcIWlvhzrYsNougjo0Tvn5OM
        EM4uRokTM/6zglTxCthJXH3YyAxiswioSvy9uwQqLihxcuYTFhBbVCBCom3ZFLAaYQEPif7b
        G9lAbGYBcYlbT+YzgdgiAmES1642MEPEgRacmpkAsewHs8TrnidARRwcbAJaEo2d7CAmp0Cs
        xMzJyRDlmhKt23+zQ9jyEtvfzmGGeEBJ4trzpywQdq3E57/PGCcwis5Cct0sJFfMQjJqFpJR
        CxhZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG6bZjPzfvYJz36qPeIUYmDsZDjBIczEoi
        vIs/mCcJ8aYkVlalFuXHF5XmpBYfYjQFBtFEZinR5HxgmsgriTc0MzA1NDGzNDC1NDNWEuf1
        LOhIFBJITyxJzU5NLUgtgulj4uCUamBy/WW73O2U/K8fOrZXAibkxR+d+95Kml2W13R5Srn2
        2zmm//nfnXorOf+7QBeT2aMfk3J3cU843mUwt8I9dkO0992vTbPKmh2LIq1samz3ui890nuO
        e0nLzAJeQ7WlpxeyzPLbNSm568uT/xPuiduZr+Q1u/rvx6SvYSf83jxZsfuZVqSj4Yfpf9nV
        uXgOqBaVbDyat9OuXfhnbrB76cekc5rz3+Z67HQ4Ln/faWvwu5+/KzdJ8k28cnST1JQ9Dw/L
        aG64cvv9Az0D4Qdb+hcn7nqvIDV9o7bbp7P8D/yen+F9Fmt04XYNS8/hJ5XzFIUtH1dss73V
        9Ex0adoU4w6u1j06Aft49+hsfq/0Quv+ZiWW4oxEQy3mouJEAFKKHiFbAwAA
X-CMS-MailID: 20220323112427eucas1p12fd8bbfbe35641df28032260350a585c
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



On 2022-03-23 11:39, Johannes Thumshirn wrote:
> 
> It looks like we can't use btrfs_calc_available_free_space(), can
> you try this one on top:
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index f2a412427921..4a6c1f1a7223 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2082,23 +2082,27 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
>  
>  bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
>  {
> -       struct btrfs_space_info *sinfo;
> +       struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +       struct btrfs_device *device;
>         u64 used = 0;
>         u64 total = 0;
>         u64 factor;
>  
> -       if (!btrfs_is_zoned(fs_info))
> -               return false;
> -
>         if (!fs_info->bg_reclaim_threshold)
>                 return false;
>  
> -       list_for_each_entry(sinfo, &fs_info->space_info, list) {
> -               total += sinfo->total_bytes;
> -               used += btrfs_calc_available_free_space(fs_info, sinfo,
> -                                                       BTRFS_RESERVE_NO_FLUSH);
> +
> +       mutex_lock(&fs_devices->device_list_mutex);
> +       list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +               if (!device->bdev)
> +                       continue;
> +
> +               total += device->disk_total_bytes;
> +               used += device->bytes_used;
> +
>         }
> +       mutex_unlock(&fs_devices->device_list_mutex);
>  
> -       factor = div_u64(used * 100, total);
> +       factor = div64_u64(used * 100, total);
>         return factor >= fs_info->bg_reclaim_threshold;
>  }
> 
size 1280M:
[   47.511871] btrfs: factor: 30 used: 402653184, total: 1342177280
[   48.542981] btrfs: factor: 30 used: 402653184, total: 1342177280
[   49.576005] btrfs: factor: 30 used: 402653184, total: 1342177280
size: 12800M:
[   33.971009] btrfs: factor: 3 used: 402653184, total: 13421772800
[   34.978602] btrfs: factor: 3 used: 402653184, total: 13421772800
[   35.991784] btrfs: factor: 3 used: 402653184, total: 13421772800
size: 12800M, zcap=96M zsze=128M:
[   64.639103] btrfs: factor: 3 used: 402653184, total: 13421772800
[   65.643778] btrfs: factor: 3 used: 402653184, total: 13421772800
[   66.661920] btrfs: factor: 3 used: 402653184, total: 13421772800

This looks good. And the test btrfs/237 is failing, as it should be
because of the change in reclaim condition. Are you planning to update
this test in fstests later?

I still have one more question: shouldn't we use the usable disk bytes
(zcap * nr_zones) instead of disk_total_bytes (zsze * nr_zones) to
calculate the `total` variable? The `used` value is a part of the usable
disk space so I feel it makes more sense to calculate the `factor` with
the usable disk bytes instead of the disk_total_bytes.

-- 
Regards,
Pankaj
