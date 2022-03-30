Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75C84EC81D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiC3PYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348129AbiC3PYN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 11:24:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA500192362
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 08:22:26 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220330152221euoutp019ff0bd873b2fac24ebf88dc13312d572~hMdfbB5BK2825528255euoutp01b
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 15:22:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220330152221euoutp019ff0bd873b2fac24ebf88dc13312d572~hMdfbB5BK2825528255euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648653741;
        bh=98afstKcFp5woRvh65sc5QmV9YMqipjOsmmsVa5Nx1k=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=MLQRvd4WR7oyElNmKRxJyl366gC1zeBMBBOQdDKpFgKO/1OdMdy53KbjfCT8rcM0u
         ee44dAb+c37RfvnlKdWQrJlpA5TX/sTd4jQJ21XQsADNHIUz+tXWf0VdDyEmT9dEwP
         ikVk1UWXTrnapRMsGFjXIzQwv86Ads6YVYgZYsoc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220330152221eucas1p2583340b98c12008908de79481a98b1bf~hMdfLac0i2620626206eucas1p20;
        Wed, 30 Mar 2022 15:22:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7B.56.10009.DA574426; Wed, 30
        Mar 2022 16:22:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220330152221eucas1p1bcf2d34b16a062815e866c5dca3b0c84~hMde2rEWQ2746527465eucas1p13;
        Wed, 30 Mar 2022 15:22:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220330152221eusmtrp1c940646da465833d90dfe591007b714c~hMde12-fM2667026670eusmtrp1R;
        Wed, 30 Mar 2022 15:22:21 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-f2-624475ad139b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 08.72.09522.DA574426; Wed, 30
        Mar 2022 16:22:21 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220330152220eusmtip2fa608e1f58bd5d57ae0f93306788df18~hMdesYm5q1625416254eusmtip2N;
        Wed, 30 Mar 2022 15:22:20 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.91) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 30 Mar 2022 16:22:20 +0100
Message-ID: <e5584ddc-9c06-8860-9999-3978e27c5c4d@samsung.com>
Date:   Wed, 30 Mar 2022 17:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] btrfs: zoned: make auto-reclaim less aggressive
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <c69adfe62944e32a0d2e37b25c34cd49edc15f43.1648543951.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.91]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7prS12SDA79lLJY/Ps7i8XfrntM
        Fn8eGlpceryC3WLi8c2sDqweZxYcYfeYsHkjq8fnTXIe7Qe6mQJYorhsUlJzMstSi/TtErgy
        Pva8Ziy4J1dx/e1GtgbGVZJdjJwcEgImEnMuNrN3MXJxCAmsYJR4NvE1M4TzhVHi95JeFgjn
        M6NE+8cZ7DAtu1Z8hEosZ5Q496yfHa7q9pQVbBDOLkaJx4tbgco4OHgF7CQ2L8wG6WYRUJXY
        cuY+G4jNKyAocXLmExYQW1QgQuLXrUdgG4QFvCV+XL/HDGIzC4hL3HoynwnEFhEIlWj5sJIV
        ZD6zwASgzU/mgc1nE9CSaOwE6+UUSJQ4cukvI0SvpkTr9t/sELa8xPa3c5ghPlCSmLFvMyOE
        XStxasstJpCZEgIfOCTunN/DBpFwkdjzczIrhC0s8er4Fqj3ZSROT+5hgbCrJZ7e+M0M0dzC
        KNG/cz0byEESAtYSfWdyIGocJfoPPIIK80nceCsIcQ+fxKRt05knMKrOQgqKWUhenoXkhVlI
        XljAyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMNGc/nf80w7Gua8+6h1iZOJgPMQo
        wcGsJML78aBzkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5O
        qQYm37lye6IK+a/vqeSbYsL4qzl356KoEnFL162OBaqr57osTCkxOdiQFaIakciwTs0iui3G
        W/jZi8C/bJOdwnbzH7pR7DD71I/JO6f8CXkhPJV1+q6KPtl33qWxp/a+XW3bdOrWaZu61KI3
        ml/3nmPnjX0qume7MM8rd7crv01nBXutdDXpS9letEzYzVjup8614z8nPFj0jW+7TF75snm5
        8w3Wn1+XJ1yhtsnJ+abTR9XiBrF5drvq+x6uCrsUsbaLaXIA6/3vM9cYJVQ0z5l47vWuC3ra
        F7MPKMVdYNv7Nt3dXV3o4Uz3xtNvBWJ1izNVV+xnyus0WLu8cN2aFI4iVW3DCXfnJ5Vuulbl
        2LBUiaU4I9FQi7moOBEAyDQHP6MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xe7prS12SDLb8Z7ZY/Ps7i8XfrntM
        Fn8eGlpceryC3WLi8c2sDqweZxYcYfeYsHkjq8fnTXIe7Qe6mQJYovRsivJLS1IVMvKLS2yV
        og0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyPva8Ziy4J1dx/e1GtgbGVZJd
        jJwcEgImErtWfGTpYuTiEBJYyihx/9dRFoiEjMSnKx/ZIWxhiT/Xutggij4ySixcMxusSEhg
        F6PE+weyXYwcHLwCdhKbF2aDhFkEVCW2nLnPBmLzCghKnJz5BKxcVCBCYtmuqWC2sIC3xI/r
        95hBbGYBcYlbT+YzgdgiAqESLR9WsoLsYhaYwChx7sk8qF0vGCV2Tc8E2cUmoCXR2Al2G6dA
        osSRS38ZIeZoSrRu/80OYctLbH87hxnifiWJGfs2M0LYtRKf/z5jnMAoOgvJebOQnDELyahZ
        SEYtYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERib24793LyDcd6rj3qHGJk4GA8xSnAw
        K4nwfjzonCTEm5JYWZValB9fVJqTWnyI0RQYRhOZpUST84HJIa8k3tDMwNTQxMzSwNTSzFhJ
        nNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1OqgSlSpkxGPNb5Vufe4rT4114e88VZt06xPng1jccp
        YeLNORulogL5X7PVRcy6XxJ1vFIuxPNmg0nD9X4B49hZXxbX856tYHjwQ7rj7VndU++/SD38
        NfXpf4892ZGTquROGAj0L7t7+F+83vzlM88HCqndSDFRrGgN/L5u65r2d0eeTb7+cFrMhD2T
        3ZWuSGsun2r+4zW74esw43cfHDXm5Mi3P1191qJv2Y59rxI0pPza9vy3N8kuv3SnrF3dyTKo
        YUHnOcaP65IfFs+f7X6UZdpbdrnQtWazZOOLFP+d4q02npZ4x85XpUKtscNjwbfURLf+n113
        F4ZNCeVu5RS8uF/tWPxTx5dLTmV5L90VeEWJpTgj0VCLuag4EQDyARxFVgMAAA==
X-CMS-MailID: 20220330152221eucas1p1bcf2d34b16a062815e866c5dca3b0c84
X-Msg-Generator: CA
X-RootMTR: 20220329085623eucas1p1966efab8140be00383df73e684e1aac8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220329085623eucas1p1966efab8140be00383df73e684e1aac8
References: <cover.1648543951.git.johannes.thumshirn@wdc.com>
        <CGME20220329085623eucas1p1966efab8140be00383df73e684e1aac8@eucas1p1.samsung.com>
        <c69adfe62944e32a0d2e37b25c34cd49edc15f43.1648543951.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM. Tested it in QEMU with zcap == zsize and zcap!= zsize.

Tested-by: Pankaj Raghav <p.raghav@samsung.com>

On 2022-03-29 10:56, Johannes Thumshirn wrote:
> The current auto-reclaim algorithm starts reclaiming all block-group's
> with a zone_unusable value above a configured threshold. This is causing a
> lot of reclaim IO even if there would be enough free zones on the device.
> 
> Instead of only accounting a block-group's zone_unusable value, also take
> the ratio of free and not usable (written as well as zone_unusable) bytes
> a device has into account.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 10 ++++++++++
>  fs/btrfs/zoned.c       | 28 ++++++++++++++++++++++++++++
>  fs/btrfs/zoned.h       |  6 ++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 628741ecb97b..12454304bb85 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1512,6 +1512,13 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
>  	return bg1->used > bg2->used;
>  }
>  
> +static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	if (btrfs_is_zoned(fs_info))
> +		return btrfs_zoned_should_reclaim(fs_info);
> +	return true;
> +}
> +
>  void btrfs_reclaim_bgs_work(struct work_struct *work)
>  {
>  	struct btrfs_fs_info *fs_info =
> @@ -1522,6 +1529,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
>  		return;
>  
> +	if (!btrfs_should_reclaim(fs_info))
> +		return;
> +
>  	sb_start_write(fs_info->sb);
>  
>  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 1b1b310c3c51..c0c460749b74 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2079,3 +2079,31 @@ void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info)
>  	}
>  	mutex_unlock(&fs_devices->device_list_mutex);
>  }
> +
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	u64 used = 0;
> +	u64 total = 0;
> +	u64 factor;
> +
> +	ASSERT(btrfs_is_zoned(fs_info));
> +
> +	if (!fs_info->bg_reclaim_threshold)
> +		return false;
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (!device->bdev)
> +			continue;
> +
> +		total += device->disk_total_bytes;
> +		used += device->bytes_used;
> +
> +	}
> +	mutex_unlock(&fs_devices->device_list_mutex);
> +
> +	factor = div64_u64(used * 100, total);
> +	return factor >= fs_info->bg_reclaim_threshold;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index c489c08d7fd5..f2d16395087f 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -74,6 +74,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
>  			     u64 length);
>  void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg);
>  void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info);
> +bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info);
>  #else /* CONFIG_BLK_DEV_ZONED */
>  static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>  				     struct blk_zone *zone)
> @@ -232,6 +233,11 @@ static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
>  static inline void btrfs_clear_data_reloc_bg(struct btrfs_block_group *bg) { }
>  
>  static inline void btrfs_free_zone_cache(struct btrfs_fs_info *fs_info) { }
> +
> +static inline bool btrfs_zoned_should_reclaim(struct btrfs_fs_info *fs_info)
> +{
> +	return false;
> +}
>  #endif
>  
>  static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)

-- 
Regards,
Pankaj
