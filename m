Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BDD50311B
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Apr 2022 01:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356363AbiDOWnU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 18:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiDOWnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 18:43:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF79D4D7
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650062445;
        bh=aB2MQVZ7+wXrXcQKTWBfL5U3QhQp+uoiysCJo98k4B0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EueTXZyBicoGBZKRjU1PvLkHpjrvmlJ0AihxZXuaonYHFErqxzJz97Rzh79KZDg6q
         5NNfdZ2gGIHP3PcZdClyxuZ9ajkj7TGrOCyjOIbK0VNn0Vy9OpAOXPmxXCuj/QiuuI
         2aPbzj4dGQWtGduPU6g2RBuVLCZqQFg097qEN09o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof5H-1oGR7t3XU9-00p4GZ; Sat, 16
 Apr 2022 00:40:45 +0200
Message-ID: <6ff6b834-d916-43b3-aa58-b6f7512682c2@gmx.com>
Date:   Sat, 16 Apr 2022 06:40:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/5] btrfs: do not return errors from
 btrfs_submit_metadata_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220415143328.349010-1-hch@lst.de>
 <20220415143328.349010-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220415143328.349010-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FhpGvzPjx2csXEu+BKQGL9JJkJdnsVDCfOhwMVN6crHQRf00cIM
 M9ISq4YAMU+vonthEd5atC6rUlcAAJGp+zTlfrGeMWCYXrlyYnXbw1r3wV3V3UYmnvRgZ5n
 9ansRq/QkXgylEgWgPqm3SAh/NPsez5FZ65lw6OCNyGBTnqpn31xeFgpaleR8H6kQebVKda
 QOUhHmaJM/ExqkRpL8wgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lB4usudkim0=:w0DW1EV6Adfhuk/xLVmyoE
 rFK5i9MlsHO+VA7L0NeWEFG02ZSH3zrD22M1wPqTGZjAgO/f6uR62dUtKRqWzJ6pMWhSXujyn
 Xn06Zixky2K64BZgdumqkbn1Wyjvd5//s5tFEeoyy+NkEGYp0OJF8A5OrVBofIIW7b6hhjSk0
 MszwxV3mphaetjfmw+dXjhN3iLm8M+f1Xa4qKSXdzkPtyJRLK10aFy/eHgha3j2YmzjFlwgCS
 gQOsdMrRa3pEVwdwoonmpRGuAHJdklfw8k3tB5nMtzG53hnTE9lNzGeMJhYIKFTtoPy4uWzbP
 jP5rnuDO6LTuXtrFeTTBgA5Q0fHPQ6qZg9zJjY4xrnWqbkzqj60JJ+FplzcJpLlpBgWjgysKV
 jtncjG+DcIhf6wgryK0BDtpcLgu2OCKki3x1tUH1C2zE70+CaP4UM82oe5O3WGMFMxw5fHv3n
 PkeogV1gigJwEm6rGedHKu14/s6Ac/b2TmTRXeUANKruaWH2ypL+gq90qMvQGoLenncPVOZtZ
 CQeE9z3gO0vmXZ80SaF3TzKra6VaPoJlri1KSf0BpG+7bhjSinCim6BkmaFXuzvLKWOCQTFSF
 HSAb1CBN08s0gmIyVw9OaZeHVrDHSCJXCJHqA6Xdj/pv/4Ajzi6k4kE9c2PZJS9MNpMNsTKmZ
 TOB3sbb9gfyh+Vlpkhq8sqJc+fwhVNihpq5g7Yy4EFgxcx11P0PVcDsQ3UpoTPUXzxIItKb13
 iB8Tapqc8t1ZpOrk2YEbsb+gVZ0vtG9LyWn/X78RmmSA8JJFDlN42O3JEaBDkCEZZ14XmLj8J
 DBaMRi5NobJ0LpzLwv0ODVxsxKhbFlOu+OG4RD5PraGolSljmLfn9vEZPrEghSxTYo/nseiiH
 FsXa0/Q9ZneUGYfUZa3dO4pMdEcgrofQVnhA7N0A9QZX1MymhD5OV51AYY471KNrNB7g+y6U4
 FHj5M8hPXKnYmXBV2LV/PXKNijQtr4AJzEkeoUyBAkfGOapgCMIJNADjCix8DInpX9v3TKQDM
 y5G9hCo4tnDUrmpaM510l80i/q7r4s+oybH6yiZz1RavtX6ICpKp3TaRHvcBC0RV//S0/AvWO
 54Sfs3z5EDXKGI=
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/15 22:33, Christoph Hellwig wrote:
> btrfs_submit_metadata_bio already calls ->bi_end_io on error and the
> caller must ignore the return value, so remove it.

Reviewed-by: Qu Wenruo <wqu@suse.com>

I think your cleanup is doing the first step towards a proper defined
behavior on how we should handle bios: just fire and forget.

Thanks,
Qu
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/disk-io.c | 26 ++++++++++----------------
>   fs/btrfs/disk-io.h |  4 ++--
>   2 files changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 28b9cf020b8df..9c488224edc73 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -920,8 +920,8 @@ static bool should_async_write(struct btrfs_fs_info =
*fs_info,
>   	return true;
>   }
>
> -blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio =
*bio,
> -				       int mirror_num)
> +void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
> +			       int mirror_num)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	blk_status_t ret;
> @@ -933,14 +933,12 @@ blk_status_t btrfs_submit_metadata_bio(struct inod=
e *inode, struct bio *bio,
>   		 */
>   		ret =3D btrfs_bio_wq_end_io(fs_info, bio,
>   					  BTRFS_WQ_ENDIO_METADATA);
> -		if (ret)
> -			goto out_w_error;
> -		ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +		if (!ret)
> +			ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
>   	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
>   		ret =3D btree_csum_one_bio(bio);
> -		if (ret)
> -			goto out_w_error;
> -		ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +		if (!ret)
> +			ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
>   	} else {
>   		/*
>   		 * kthread helpers are used to submit writes so that
> @@ -950,14 +948,10 @@ blk_status_t btrfs_submit_metadata_bio(struct inod=
e *inode, struct bio *bio,
>   					  0, btree_submit_bio_start);
>   	}
>
> -	if (ret)
> -		goto out_w_error;
> -	return 0;
> -
> -out_w_error:
> -	bio->bi_status =3D ret;
> -	bio_endio(bio);
> -	return ret;
> +	if (ret) {
> +		bio->bi_status =3D ret;
> +		bio_endio(bio);
> +	}
>   }
>
>   #ifdef CONFIG_MIGRATION
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 56607abe75aa4..1312d93c02edb 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -87,8 +87,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info =
*fs_info,
>   int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
>   				   struct page *page, u64 start, u64 end,
>   				   int mirror);
> -blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio =
*bio,
> -				       int mirror_num);
> +void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
> +			       int mirror_num);
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_inf=
o);
>   #endif
