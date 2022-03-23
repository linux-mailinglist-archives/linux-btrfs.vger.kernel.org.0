Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2C34E4EFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiCWJKi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 05:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiCWJKh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 05:10:37 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370383C724
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 02:09:06 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220323090904euoutp01c69184cac935e8c886d62b83b1c8eed9~e92kOiueY2142821428euoutp01j
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:09:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220323090904euoutp01c69184cac935e8c886d62b83b1c8eed9~e92kOiueY2142821428euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648026544;
        bh=jy0LVt9hZmOho4hyH3/yEpOhkjU2WZFog5JHskvT/NU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=S168k9x2xwqGEH/2XDYKTLEPEtzTQitvQ39DbwOBvJQPt8wj76TX6eBo6OpzkxV1Z
         bk0JaDAJSIE4zN7WLYSkTVcUEzYKutLegCpiHRPU9LffQSCkdQnVmOZ4LxAtejOTM2
         fH2sFCHh+PEmLI/Jt/qdAbMSYfhOoIropUcyD7Zs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220323090904eucas1p203081ba943dea39fc89fcabee298fe9a~e92kAL5-v0313403134eucas1p2l;
        Wed, 23 Mar 2022 09:09:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 11.0B.10009.FA3EA326; Wed, 23
        Mar 2022 09:09:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220323090903eucas1p1356e655b51a9e03500d446ea16fafd35~e92jo8zeT2267422674eucas1p1P;
        Wed, 23 Mar 2022 09:09:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220323090903eusmtrp256896c050b6fa3df0ff4106921d85939~e92joRroU1886418864eusmtrp2B;
        Wed, 23 Mar 2022 09:09:03 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-87-623ae3af68d2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5D.3A.09404.FA3EA326; Wed, 23
        Mar 2022 09:09:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220323090903eusmtip1c162803e7b3c7a36501e074146b90e73~e92jYqJmR3172531725eusmtip1i;
        Wed, 23 Mar 2022 09:09:03 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.55) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 23 Mar 2022 09:08:57 +0000
Message-ID: <f4e4a70c-0349-fafa-8375-8c4177a3e260@samsung.com>
Date:   Wed, 23 Mar 2022 10:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.5.0
Subject: Re: [PATCH 5/5] btrfs: zoned: make auto-reclaim less aggressive
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     Josef Bacik <josef@toxicpanda.com>, <linux-btrfs@vger.kernel.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        Javier Gonzalez <javier.gonz@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.55]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7rrH1slGbR0Wltc+NHIZPG36x6T
        xZ+HhhaXHq9gt7gx4SmjA6vHplWdbB7rt1xl8ZiweSOrx+dNch7tB7qZAlijuGxSUnMyy1KL
        9O0SuDJWX93IUrBQpuLg379MDYxbxbsYOTkkBEwkvu++wtbFyMUhJLCCUeLYxwVQzhdGieaO
        RiYI5zOjxKof/1hgWu58gUksZ5ToWjydDa5q1qlzLBDOLkaJRVPeAmU4OHgF7CQWPLIE6WYR
        UJXo+L4SbBKvgKDEyZlPwGxRgQiJl0f+MoHYwgIeEv23N7KB2MwC4hK3nswHi4sIhEk8ubSN
        GWQ+s8AsRom3D4+AzWcT0JJo7GQHMTkFEiVWXJCBaNWUaN3+mx3ClpfY/nYOM8QDShLXnj+F
        eqZW4tSWW0wQ9hcOiUsn80DGSAi4SLzdmAIRFpZ4dXwLO4QtI/F/53yw3yUE+hklprb8gXJm
        MEr0HN7MBNFsLdF3JgeiwVHi2Y5rbBBhPokbbwUhzuGTmLRtOvMERtVZSAExC8nDs5B8MAvJ
        BwsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEppvT/45/2sE499VHvUOMTByMhxgl
        OJiVRHgXfzBPEuJNSaysSi3Kjy8qzUktPsQozcGiJM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp
        1cA0k339/evpG4oNPpxg5Dg/Sb9lunUQc/LhWw4tDvb/LX6ryO4Jl/C5c2nqShvDkryk4xyF
        PmGhv7iELp837yl2Xlv4Vv+PhPt6ptJVnMfVZ6y8tGVqd/DjK9q6K/5pdex5v+ZipU/0A+6J
        smX55a/so1Rnf595cw3bM+Elc/qjg26dWn11W7qEbfFTww+FB4+X/ZSZ7nT1dPXbxSnsX0ID
        yvp1185dd+StQU6h8PtrwkUOB5Wljh3PC9E5JL71iRLLVv5jq6ISmlIU33CZ58+5qL/DeJN3
        L692wYryzjb/tOfTpu89vHTOvlNfNj2zuMITsv6NwNvXqy1/fmT45HFk5x6Vaj3TY93uEzjW
        u+5ZpcRSnJFoqMVcVJwIAHUy9y+mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7rrH1slGfw8Lmtx4Ucjk8XfrntM
        Fn8eGlpceryC3eLGhKeMDqwem1Z1snms33KVxWPC5o2sHp83yXm0H+hmCmCN0rMpyi8tSVXI
        yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MtYfXUjS8FCmYqDf/8y
        NTBuFe9i5OSQEDCRuPOlkamLkYtDSGApo0TP5KPMEAkZiU9XPrJD2MISf651sUEUfWSUOHLj
        BSuEs4tR4t729SxdjBwcvAJ2EgseWYI0sAioSnR8X8kCYvMKCEqcnPkEzBYViJBoWzYFbIGw
        gIdE/+2NbCA2s4C4xK0n85lAbBGBMIknl7Yxg8xnFpjFKPH24RGozS8YJRpn/WQGWcYmoCXR
        2MkOYnIKJEqsuCADMUdTonX7b3YIW15i+9s5UM8oSVx7/pQFwq6V+Pz3GeMERtFZSM6bheSM
        WUhGzUIyagEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAON127OeWHYwrX33UO8TIxMF4
        iFGCg1lJhHfxB/MkId6UxMqq1KL8+KLSnNTiQ4ymwDCayCwlmpwPTBR5JfGGZgamhiZmlgam
        lmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1M+9f11UbdX/rrhETIu4QbV68ueHZySdSs
        uEcupgvnvJnb5lvOE6VeyXPQeL2YhN75kLDdP1/2SkznbRQ7NWMbu36D4WGPVQvqv7o4C2+e
        xvuFa2JA07lfN57lzXyufsmrcvNRc9V3bw8r6Tk6vbdSc/F7Unjsy/8vadbt537VrvJw+zLt
        MsujW9tXnLxnvL9LiGVfpkLOC5VOxTVGyxbkLZI7W7anaqZI8upVyg8j8o6cdMzXTJql2m05
        UWD+BoNIQc5HNokxc9kLjPdXRJw3v76Bx2RdrMQRm46NL7rv//jqdK7l0HTHeTKsUSemTOpy
        vN3fEinyOLdXZuE/l43TDbeLLE0V7tpod0n87m35a0osxRmJhlrMRcWJAAmnsQ5cAwAA
X-CMS-MailID: 20220323090903eucas1p1356e655b51a9e03500d446ea16fafd35
X-Msg-Generator: CA
X-RootMTR: 20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
        <CGME20220321161435eucas1p28901f03d0533ae246f51a3b96bfc07b4@eucas1p2.samsung.com>
        <89824f8b4ba1ac8f05f74c047333c970049e2815.1647878642.git.johannes.thumshirn@wdc.com>
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

Hi Johannes,

I tried this patchset and I am noticing a weird behaviour wrt the value
of factor in btrfs_zoned_should_reclaim function.

Here is my setup in QEMU:
size 12800M
zoned=true,zoned.zone_capacity=128M,zoned.zone_size=128M

btrfs mkfs:
mkfs.btrfs -d single -m single <znsdev>;  mount -t auto <znsdev>
/mnt/real_scratch

I added a print statement in btrfs_zoned_should_reclaim to get the
values for the factor, used and total params.

When I run the btrfs/237 xfstest, I am noticing the following values:
[   54.829309] btrfs: factor: 4850 used: 19528679424, total: 402653184

The used > total, thereby making the factor greater than 100. This will
force a reclaim even though the drive is almost empty:

  start: 0x000000000, len 0x040000, cap 0x040000, wptr 0x000078 reset:0
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000040000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000080000, len 0x040000, cap 0x040000, wptr 0x0001e0 reset:0
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0000c0000, len 0x040000, cap 0x040000, wptr 0x000d80 reset:0
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000140000, len 0x040000, cap 0x040000, wptr 0x008520 reset:0
non-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000180000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0001c0000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000200000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000240000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x000280000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
  start: 0x0002c0000, len 0x040000, cap 0x040000, wptr 0x000000 reset:0
non-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]
.....
.....

I am also noticing the same behaviour for ZNS drive with size 1280M:

[   86.276409] btrfs: factor: 350 used: 1409286144, total: 402653184

Is something going wrong with the calculation? Or am I missing something
here?

On 2022-03-21 17:14, Johannes Thumshirn wrote:

> index 1b1b310c3c51..f2a412427921 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2079,3 +2079,26 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  }
> +
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_space_info *sinfo;
> +	u64 used = 0;
> +	u64 total = 0;
> +	u64 factor;
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return false;
> +
> +	if (!fs_info->bg_reclaim_threshold)
> +		return false;
> +
> +	list_for_each_entry(sinfo, &fs_info->space_info, list) {
> +		total += sinfo->total_bytes;
> +		used += btrfs_calc_available_free_space(fs_info, sinfo,
> +							BTRFS_RESERVE_NO_FLUSH);
> +	}
> +
> +	factor = div_u64(used * 100, total);
+       pr_info("btrfs: factor: %lld used: %lld, total: %lld ", factor,
used, total);
> +	return factor >= fs_info->bg_reclaim_threshold;
> +}

>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)

-- 
Regards,
Pankaj
