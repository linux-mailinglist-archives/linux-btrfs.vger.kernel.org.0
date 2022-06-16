Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0606B54D6B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 03:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbiFPBCg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiFPBCc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 21:02:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298C113F
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655341344;
        bh=nn2LiqxrcxnmETSQlnIBaDzU9seLsYT09VNB/xdT4rU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bivFYVK4Ze477f5IIr3J1mst/x/2UV/D/qvZoE+klzN92M7FJt6eh3B2dogwJuib6
         twpBnDtRB0eIXi3Gz53t9yhgGxMd2p61J+ZgnOFiUygFGDEpw+5A9ylMEU011Pk3Iw
         MwvppW6vxM6WarwiqwnaohxQO5Vf5sjEkSP0wm4k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8GMq-1nfcyd2BFo-014EwT; Thu, 16
 Jun 2022 03:02:24 +0200
Message-ID: <dd307f15-b4cb-56da-5a67-d80826602b76@gmx.com>
Date:   Thu, 16 Jun 2022 09:02:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/5] btrfs: remove the btrfs_map_bio return value
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-4-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220615151515.888424-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0CJc/MnBllyHkRwdrXo3hSg6pD7VSixWjUSDyW5G35jRtyiNBi2
 r+oTvW0vJYNDELb5RWty1gbdwGh/+XV/uAVw60AMSWzKkOr4bMSOIXGvDG2L4PrR3IE7bKo
 QCXbqtQePh6PCoTPyPvXi/va5Ph1PlCPkumj0SIPc/qtgzyby6aGiJbX7mKtffc1/LaJBG4
 zaq9vusQYlvhqR3qIcdbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ldmObTBOjpg=:PFpy8Zp08sLjPs2ZzRedfH
 XP7yhammjcY1Al3WJDtielyfJZVaHdMxZDwOTvajALwPBOD1hZ5NNlj+5aJ/L7yfMhedYiefc
 vAdElE5pCjfQR0VbsukL0QIlxFiKY4/yROclYhNdMdy00hdNMcYQmdrHDhd8u5Zy24l0uR0eQ
 XiujS0f5eXnl0uYpaeJBqyiH1kNGJi+pBRYng5c9T4ijFi9amfK61GIa+U5awJ1CZDLC7W8oU
 9jW8xmAAiV6gn7e/+p0+XLKhM/du7Hr1qiCvwYYDDlJNwoILmkTAGxFj6GVwp9g0B6w38YJOC
 +wAXmq2i5FaYyTKKWqGRyHitbS+OB40L1kuX/HM7qC9OUhGRK2he5jPn7qrIlzzfUTwLoFLYt
 VFDOHSwl4KheBg9tNXte/UeLCL+Sgm1A7zsGyq8sMD5jZkj/6PgRbMJnVwL/h3bV4bC0e8hAq
 3VfMdEB1e6Y+evpst/mloAnr/W64oIsa3zhPpRN2MS/VksXbn8wrCIBeNM222ZgNUfsP/q5Mf
 PHbRNA2tkEBE40DahT4gSThXDMtx6ViBmiGHYn1J3tilQh+DuvwG1FbXrUAmdqxuPsVT20Olx
 6UbIBbS3AujGVeonZ7FokekN3uHPRoddVWGffOtfjEZI//yv9cN0kCfNtvWFM/giRcqtdZERk
 aARqVMkffG24aJ+ShBj1WPkRcmwyetiuG7CMLCjPyKfwbRIy/6LTX5ykUvoYLYUKXEM6gMGm8
 4L+JuM5imaGyd9bMy+eTty1ooQK3GPWtiL5qE4pya06/IZsgLEizlnFVvjc9u/jKoJuxUDPlx
 GrrqEtzdCPL6FRw4xrxUXNaUpNQUj1+kmRhbKWxu73dE3lDpegvPgxugwGjLfmw8zSeevfEgz
 QC9TOurFHoVVxGBX99VpPzsTsxTFpBdUFi0+5rCRiypheDmQFIVGSTXR+Rgqk/2P1pYr6xoAp
 G2HRmxa0WfUQ/pOSP6jfrp1SxXQewiJ8ABYvUCTTSpalpdRo/KC7TeYQZdvbwY+Y7pmIshgVo
 MBLCvDxNScXN0PNa0C4qOg+S5gloKYMUrnZL5piSvExOQR3Iweu3aQLBXJVGQlaURYCaH3Wix
 +EUpPGwZ0lQKl90couR80gjDv1jxJWGM4RpM2+77MVEL2igHhm3nhM58w==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/15 23:15, Christoph Hellwig wrote:
> Always consume the bio and call the end_io handler on error instead of
> returning an error and letting the caller handle it.  This matches
> what the block layer submission does and avoids any confusion on who
> needs to handle errors.
>
> As this requires touching all the callers, rename the function to
> btrfs_submit_bio, which describes the functionality much better.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/compression.c |  8 ++------
>   fs/btrfs/disk-io.c     | 21 ++++++++++-----------
>   fs/btrfs/inode.c       | 25 ++++++++++---------------
>   fs/btrfs/volumes.c     | 13 ++++++++-----
>   fs/btrfs/volumes.h     |  4 ++--
>   5 files changed, 32 insertions(+), 39 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 63d542961b78a..907fc8a4c092c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -593,9 +593,7 @@ blk_status_t btrfs_submit_compressed_write(struct bt=
rfs_inode *inode, u64 start,
>   			}
>
>   			ASSERT(bio->bi_iter.bi_size);
> -			ret =3D btrfs_map_bio(fs_info, bio, 0);
> -			if (ret)
> -				goto finish_cb;
> +			btrfs_submit_bio(fs_info, bio, 0);
>   			bio =3D NULL;
>   		}
>   		cond_resched();
> @@ -931,9 +929,7 @@ void btrfs_submit_compressed_read(struct inode *inod=
e, struct bio *bio,
>   			sums +=3D fs_info->csum_size * nr_sectors;
>
>   			ASSERT(comp_bio->bi_iter.bi_size);
> -			ret =3D btrfs_map_bio(fs_info, comp_bio, mirror_num);
> -			if (ret)
> -				goto finish_cb;
> +			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
>   			comp_bio =3D NULL;
>   		}
>   	}
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 800ad3a9c68ed..5df6865428a5c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -728,7 +728,6 @@ static void run_one_async_done(struct btrfs_work *wo=
rk)
>   {
>   	struct async_submit_bio *async;
>   	struct inode *inode;
> -	blk_status_t ret;
>
>   	async =3D container_of(work, struct  async_submit_bio, work);
>   	inode =3D async->inode;
> @@ -746,11 +745,7 @@ static void run_one_async_done(struct btrfs_work *w=
ork)
>   	 * This changes nothing when cgroups aren't in use.
>   	 */
>   	async->bio->bi_opf |=3D REQ_CGROUP_PUNT;
> -	ret =3D btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror=
_num);
> -	if (ret) {
> -		async->bio->bi_status =3D ret;
> -		bio_endio(async->bio);
> -	}
> +	btrfs_submit_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num)=
;
>   }
>
>   static void run_one_async_free(struct btrfs_work *work)
> @@ -814,7 +809,7 @@ static blk_status_t btree_submit_bio_start(struct in=
ode *inode, struct bio *bio,
>   {
>   	/*
>   	 * when we're called for a write, we're already in the async
> -	 * submission context.  Just jump into btrfs_map_bio
> +	 * submission context.  Just jump into btrfs_submit_bio.
>   	 */
>   	return btree_csum_one_bio(bio);
>   }
> @@ -839,11 +834,15 @@ void btrfs_submit_metadata_bio(struct inode *inode=
, struct bio *bio, int mirror_
>   	bio->bi_opf |=3D REQ_META;
>
>   	if (btrfs_op(bio) !=3D BTRFS_MAP_WRITE) {
> -		ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
> +		btrfs_submit_bio(fs_info, bio, mirror_num);
> +		return;
> +	}
> +	if (!should_async_write(fs_info, BTRFS_I(inode))) {
>   		ret =3D btree_csum_one_bio(bio);
> -		if (!ret)
> -			ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +		if (!ret) {
> +			btrfs_submit_bio(fs_info, bio, mirror_num);
> +			return;
> +		}
>   	} else {
>   		/*
>   		 * kthread helpers are used to submit writes so that
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7a54f964ff378..6f665bf59f620 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2617,7 +2617,8 @@ void btrfs_submit_data_write_bio(struct inode *ino=
de, struct bio *bio, int mirro
>   			goto out;
>   		}
>   	}
> -	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
> +	return;
>   out:
>   	if (ret) {
>   		bio->bi_status =3D ret;
> @@ -2645,14 +2646,13 @@ void btrfs_submit_data_read_bio(struct inode *in=
ode, struct bio *bio,
>   	 * not, which is why we ignore skip_sum here.
>   	 */
>   	ret =3D btrfs_lookup_bio_sums(inode, bio, NULL);
> -	if (ret)
> -		goto out;
> -	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -out:
>   	if (ret) {
>   		bio->bi_status =3D ret;
>   		bio_endio(bio);
> +		return;
>   	}
> +
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
>   }
>
>   /*
> @@ -7863,8 +7863,7 @@ static void submit_dio_repair_bio(struct inode *in=
ode, struct bio *bio,
>   	BUG_ON(bio_op(bio) =3D=3D REQ_OP_WRITE);
>
>   	refcount_inc(&dip->refs);
> -	if (btrfs_map_bio(fs_info, bio, mirror_num))
> -		refcount_dec(&dip->refs);
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
>   }
>
>   static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private =
*dip,
> @@ -7972,7 +7971,8 @@ static inline blk_status_t btrfs_submit_dio_bio(st=
ruct bio *bio,
>   						      file_offset - dip->file_offset);
>   	}
>   map:
> -	return btrfs_map_bio(fs_info, bio, 0);
> +	btrfs_submit_bio(fs_info, bio, 0);
> +	return BLK_STS_OK;
>   }
>
>   static void btrfs_submit_direct(const struct iomap_iter *iter,
> @@ -10277,7 +10277,6 @@ static blk_status_t submit_encoded_read_bio(stru=
ct btrfs_inode *inode,
>   					    struct bio *bio, int mirror_num)
>   {
>   	struct btrfs_encoded_read_private *priv =3D bio->bi_private;
> -	struct btrfs_bio *bbio =3D btrfs_bio(bio);
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>   	blk_status_t ret;
>
> @@ -10288,12 +10287,8 @@ static blk_status_t submit_encoded_read_bio(str=
uct btrfs_inode *inode,
>   	}
>
>   	atomic_inc(&priv->pending);
> -	ret =3D btrfs_map_bio(fs_info, bio, mirror_num);
> -	if (ret) {
> -		atomic_dec(&priv->pending);
> -		btrfs_bio_free_csum(bbio);
> -	}
> -	return ret;
> +	btrfs_submit_bio(fs_info, bio, mirror_num);
> +	return BLK_STS_OK;
>   }
>
>   static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *b=
bio)
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ff777e39d5f4a..739676944e94d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6724,8 +6724,8 @@ static void submit_stripe_bio(struct btrfs_io_cont=
ext *bioc,
>   		}
>   	}
>   	btrfs_debug_in_rcu(fs_info,
> -	"btrfs_map_bio: rw %d 0x%x, sector=3D%llu, dev=3D%lu (%s id %llu), siz=
e=3D%u",
> -		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
> +	"%s: rw %d 0x%x, sector=3D%llu, dev=3D%lu (%s id %llu), size=3D%u",
> +		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
>   		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
>   		dev->devid, bio->bi_iter.bi_size);
>
> @@ -6735,8 +6735,8 @@ static void submit_stripe_bio(struct btrfs_io_cont=
ext *bioc,
>   	submit_bio(bio);
>   }
>
> -blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *b=
io,
> -			   int mirror_num)
> +void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> +		      int mirror_num)
>   {
>   	u64 logical =3D bio->bi_iter.bi_sector << 9;
>   	u64 length =3D bio->bi_iter.bi_size;
> @@ -6781,7 +6781,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *=
fs_info, struct bio *bio,
>   	}
>   out_dec:
>   	btrfs_bio_counter_dec(fs_info);
> -	return errno_to_blk_status(ret);
> +	if (ret) {
> +		bio->bi_status =3D errno_to_blk_status(ret);
> +		bio_endio(bio);
> +	}
>   }
>
>   static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_ar=
gs *args,
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 588367c76c463..c0f5bbba9c6ac 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -573,8 +573,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_i=
nfo);
>   struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle=
 *trans,
>   					    u64 type);
>   void btrfs_mapping_tree_free(struct extent_map_tree *tree);
> -blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *b=
io,
> -			   int mirror_num);
> +void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
> +		      int mirror_num);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       fmode_t flags, void *holder);
>   struct btrfs_device *btrfs_scan_one_device(const char *path,
