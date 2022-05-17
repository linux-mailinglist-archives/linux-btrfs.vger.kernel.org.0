Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9A52AE5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 01:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiEQXEk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiEQXEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 19:04:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27053A4E
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652828667;
        bh=X4aU3Ibx7CzlcU09xDMpRuglfWpHooMo6tcidMFdH6E=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=YgOYnsjk30IEX5ABt38OsDw89GuChQoZkcrXn3juvzKBk/4D7FK/9RWLqM8w3dBt+
         ifnxG8jqNgwIJigkiLh4PGnP0vbK55h7VugEi5qKb46dY/WONRnadoXdSBgokjswpO
         CSfqfvwaIcdv/rAbIbwz0FG4CqgkQTubrah98GJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9uK-1o9JqS33Q2-00IBBX; Wed, 18
 May 2022 01:04:27 +0200
Message-ID: <e2c4e54c-548b-2221-3bf7-31f6c14a03ee@gmx.com>
Date:   Wed, 18 May 2022 07:04:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-13-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 12/15] btrfs: add new read repair infrastructure
In-Reply-To: <20220517145039.3202184-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PsgyTJEXk7p3nncNzckQAhmXavpo9dThUqYOMuMPoUJwCsPo3qK
 TAav9tAzj8YrbJrqEoVZtn/5UQfnEGElL8r28rR1nsKm5YbJ5FAugpj3rQJ4qxjkG9rX6Ka
 KwYk/COEKNjMECH+QXorGM0z8VIELoJmKzYQVKRK6ds5rPDCcvBccavB2HsG8lOih866ghA
 zR1kDiZgpV+rjCjC7EnzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ssjnrpr/Yho=:1rphGwrsTe4rQ33e4ltbes
 irO6s8lbw8aZT7tv8P3vyd7fMz2VbMjHLMH8hspLgxAvmG/8+hbRQ/M/TIXNdbOXFtQR1CjMT
 3uRuMrGtjltsgFuOU9lfAdNwKhuF/o+SvlflrG/JKmOHDUZgxBx/VLOMITji4KMeLhzzDJwIb
 zAXHxhZTy4wKWwPO59fbptROxl4V0VmmOkVDj9KZJ0j+z5WTXhPYLSePIMN1z1OPlWKAYPkVh
 GURZVjJV1PckgUiG2FdO6vEcVyvXEC6g0qPWOceHy/8YXxLzfrpUtOZlxAgd8VSj3avhwp96S
 9HsAPsIb00pvGO1JL0ej3k0aW8mLc8tDfkx8EfXC+A7sBVcNVKSsomub8WoJrYZF4TBlhToc0
 Zj/sVWy/lKM2w4ZZwq3xg3rLMT0EwdQ6s/Q5TbdyTXwribBwcULqeWVyzsCpbPDcLN6rEqtBJ
 YLZBi7NTlu52yBa9P03hxFV/1Do3EeoM5cFMjSJeKB4V0fw+RAFAi0HqEn1FC/FzcHt+XQJZV
 Ag2EhqBqDlLzxd4dlYLfV08gK+yzVa9IE78zfedoM8O6adpm2Af0iRnsp3fbkKljIdCKZlk2T
 qTkX62w6XEn2YNbg0JjHu5QgjaGZgoWRuSI3hcyAMLbq+QL19SiDw2eIuHQT4Ct4zRvctUFKX
 sfuY8o09yyDsOwDNZM44m3n7Wb4kj2NgPk9pRsOobaKmXKIxpaC8nq7kBXtJO8/AEPpS5MHIK
 wggpJr3X7MKFAhhekCD3MU5+21zxnnFOWgc/IPCGXZaixR1GjjZifyxbkIdSOG3Dlz8/tANh9
 fdSU4+6uCUTIKd33DVa3YPxdh37Cy0NuU/gugseEsSCYMufiOtTaGWW6Gy6N1YJQvZ4LMfsW1
 fEjYX5tgEcK/KCX6kquFgEipQCHg8bylXmQCGnIlBO6YfqX584MTSlRcPfBxS33SjZlLkfFdS
 skA6oP/jAa8CO8xwL0IV0NxztaeYVUk5N/9KZHK+DAB/9zigKuVqlYt3fDvi/82gGl6ISPyIf
 wkGs8cBz9zUgoPuTfpLkXQqmXbCj1uB9lor4SbcWlrV8epm8SgQMzBSWWbqmrJ498AlJ3832h
 quKz2x2fbOD2T2IZ2lKEsf1S47JnN9oktZ57mefJGLmRRt1AD2QHjwjsg==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/17 22:50, Christoph Hellwig wrote:
> This adds a new read repair implementation for btrfs.  It is synchronous
> in that the end I/O handlers call them, and will get back the results
> instead of potentially getting multiple concurrent calls back into the
> original end I/O handler.  The synchronous nature has the following
> advantages:
>
>   - there is no need for a per-I/O tree of I/O failures, as everything
>     related to the I/O failure can be handled locally
>   - not having separate repair end I/O helpers will in the future help
>     to reuse the direct I/O bio from iomap for the actual submission and
>     thus remove the btrfs_dio_private infrastructure
>
> Because submitting many sector size synchronous I/Os would be very
> slow when multiple sectors (or a whole read) fail, this new code instead
> submits a single read and repair write bio for each contiguous section.
> It uses clone of the bio to do that and thus does not need to allocate
> any extra bio_vecs.  Note that this cloning is open coded instead of
> using the block layer clone helpers as the clone is based on the save
> iter in the btrfs_bio, and not bio.bi_iter, which at the point that the
> repair code is called has been advanced by the low-level driver.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/Makefile      |   2 +-
>   fs/btrfs/read-repair.c | 211 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/read-repair.h |  33 +++++++
>   fs/btrfs/super.c       |   9 +-
>   4 files changed, 252 insertions(+), 3 deletions(-)
>   create mode 100644 fs/btrfs/read-repair.c
>   create mode 100644 fs/btrfs/read-repair.h
>
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 99f9995670ea3..0b2605c750cab 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -31,7 +31,7 @@ btrfs-y +=3D super.o ctree.o extent-tree.o print-tree.=
o root-tree.o dir-item.o \
>   	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>   	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o =
\
>   	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
> -	   subpage.o tree-mod-log.o
> +	   subpage.o tree-mod-log.o read-repair.o
>
>   btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) +=3D acl.o
>   btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) +=3D check-integrity.o
> diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
> new file mode 100644
> index 0000000000000..3ac93bfe09e4f
> --- /dev/null
> +++ b/fs/btrfs/read-repair.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Christoph Hellwig.
> + */
> +#include "ctree.h"
> +#include "volumes.h"
> +#include "read-repair.h"
> +#include "btrfs_inode.h"
> +
> +static struct bio_set read_repair_bioset;
> +
> +static int next_mirror(struct btrfs_read_repair *rr, int cur_mirror)
> +{
> +	if (cur_mirror =3D=3D rr->num_copies)
> +		return cur_mirror + 1 - rr->num_copies;
> +	return cur_mirror + 1;
> +}
> +
> +static int prev_mirror(struct btrfs_read_repair *rr, int cur_mirror)
> +{
> +	if (cur_mirror =3D=3D 1)
> +		return rr->num_copies;
> +	return cur_mirror - 1;
> +}
> +
> +/*
> + * Clone a new bio from the src_bbio, using the saved iter in the btrfs=
_bio
> + * instead of bi_iter.
> + */
> +static struct btrfs_bio *btrfs_repair_bio_clone(struct btrfs_bio *src_b=
bio,
> +		u64 offset, u32 size, unsigned int op)
> +{
> +	struct btrfs_bio *bbio;
> +	struct bio *bio;
> +
> +	bio =3D bio_alloc_bioset(NULL, 0, op | REQ_SYNC, GFP_NOFS,
> +			       &read_repair_bioset);
> +	bio_set_flag(bio, BIO_CLONED);

Do we need to bother setting the CLONED flag?

Without CLONED flag, we can easily go bio_for_each_segment_all() in the
endio function without the need of bbio->iter, thus can save some memory.

> +
> +	bio->bi_io_vec =3D src_bbio->bio.bi_io_vec;
> +	bio->bi_iter =3D src_bbio->iter;
> +	bio_advance(bio, offset);
> +	bio->bi_iter.bi_size =3D size;
> +
> +	bbio =3D btrfs_bio(bio);
> +	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
> +	bbio->iter =3D bbio->bio.bi_iter;
> +	bbio->file_offset =3D src_bbio->file_offset + offset;
> +
> +	return bbio;
> +}
> +
> +static void btrfs_repair_one_mirror(struct btrfs_bio *read_bbio,
> +		struct btrfs_bio *failed_bbio, struct inode *inode,
> +		int bad_mirror)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	struct btrfs_inode *bi =3D BTRFS_I(inode);
> +	u64 logical =3D read_bbio->iter.bi_sector << SECTOR_SHIFT;
> +	u64 file_offset =3D read_bbio->file_offset;
> +	struct btrfs_bio *write_bbio;
> +	blk_status_t ret;
> +
> +	/*
> +	 * For zoned file systems repair has to relocate the whole zone.
> +	 */
> +	if (btrfs_repair_one_zone(fs_info, logical))
> +		return;
> +
> +	/*
> +	 * For RAID56, we can not just write the bad data back, as any write
> +	 * will trigger RMW and read back the corrrupted on-disk stripe, causi=
ng
> +	 * further damage.
> +	 *
> +	 * Perform a special low-level repair that bypasses btrfs_map_bio.
> +	 */
> +	if (btrfs_is_parity_mirror(fs_info, logical, fs_info->sectorsize)) {
> +		struct bvec_iter iter;
> +		struct bio_vec bv;
> +		u32 offset;
> +
> +		btrfs_bio_for_each_sector(fs_info, bv, read_bbio, iter, offset)
> +			btrfs_repair_io_failure(fs_info, btrfs_ino(bi),
> +					file_offset + offset,
> +					fs_info->sectorsize,
> +					logical + offset,
> +					bv.bv_page, bv.bv_offset,
> +					bad_mirror);
> +		return;
> +	}
> +
> +	/*
> +	 * Otherwise just clone the whole bio and write it back to the
> +	 * previously bad mirror.
> +	 */
> +	write_bbio =3D btrfs_repair_bio_clone(read_bbio, 0,
> +			read_bbio->iter.bi_size, REQ_OP_WRITE);

Do we need to clone the whole bio?

Considering under most cases the read repair is already the cold path,
have more than one corruption is already rare.

> +	ret =3D btrfs_map_bio_wait(fs_info, &write_bbio->bio, bad_mirror);
> +	bio_put(&write_bbio->bio);
> +
> +	btrfs_info_rl(fs_info,
> +		"%s: root %lld ino %llu off %llu logical %llu/%u from good mirror %d"=
,
> +		ret ? "failed to correct read error" : "read error corrected",
> +		bi->root->root_key.objectid, btrfs_ino(bi),
> +		file_offset, logical, read_bbio->iter.bi_size, bad_mirror);
> +}
> +
> +static bool btrfs_repair_read_bio(struct btrfs_bio *bbio,
> +		struct btrfs_bio *failed_bbio, struct inode *inode,
> +		int read_mirror)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +	u32 start_offset =3D bbio->file_offset - failed_bbio->file_offset;
> +	u8 csum[BTRFS_CSUM_SIZE];
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	u32 offset;
> +
> +	if (btrfs_map_bio_wait(fs_info, &bbio->bio, read_mirror))
> +		return false;
> +
> +	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
> +		return true;
> +
> +	btrfs_bio_for_each_sector(fs_info, bv, bbio, iter, offset) {
> +		u8 *expected_csum =3D
> +			btrfs_csum_ptr(fs_info, failed_bbio->csum,
> +					start_offset + offset);
> +
> +		if (btrfs_check_data_sector(fs_info, bv.bv_page, bv.bv_offset,
> +				csum, expected_csum))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +bool __btrfs_read_repair_end(struct btrfs_read_repair *rr,
> +		struct btrfs_bio *failed_bbio, struct inode *inode,
> +		u64 end_offset, repair_endio_t endio)

The reason I don't use "end" in my patchset is, any thing related "end"
will let people to think it has something related with endio.

And in fact when checking the function, I really thought it's something
related to endio, but it's the equivalent of btrfs_read_repair_finish().

> +{
> +	u8 bad_mirror =3D failed_bbio->mirror_num;
> +	u8 read_mirror =3D next_mirror(rr, bad_mirror);
> +	struct btrfs_bio *read_bbio =3D NULL;
> +	bool uptodate =3D false;
> +
> +	do {
> +		if (read_bbio)
> +			bio_put(&read_bbio->bio);
> +		read_bbio =3D btrfs_repair_bio_clone(failed_bbio,
> +				rr->start_offset, end_offset - rr->start_offset,
> +				REQ_OP_READ);
> +		if (btrfs_repair_read_bio(read_bbio, failed_bbio, inode,
> +				read_mirror)) {

A big NONO here.

Function btrfs_repair_read_bio() will only return true if all of its
data matches csum.

Consider the following case:

Profile RAID1C3, 2 sectors to read, the initial mirror is 1.

Mirror 1:	|X|X|
Mirror 2:	|X| |
Mirror 3:	| |X|

Now we will got -EIO, but in reality, we can repair the read by using
the first sector from mirror 3 and the 2nd sector from mirror 2.

This is a behavior regression.

And that's why the original repair and all my patchsets are doing sector
by sector check, not a full range check.

Thanks,
Qu

> +			do {
> +		    		btrfs_repair_one_mirror(read_bbio, failed_bbio,
> +						inode, bad_mirror);
> +			} while ((bad_mirror =3D prev_mirror(rr, bad_mirror)) !=3D
> +					failed_bbio->mirror_num);
> +			uptodate =3D true;
> +			break;
> +		}
> +		bad_mirror =3D read_mirror;
> +		read_mirror =3D next_mirror(rr, bad_mirror);
> +	} while (read_mirror !=3D failed_bbio->mirror_num);
> +
> +	if (endio)
> +		endio(read_bbio, inode, uptodate);
> +	bio_put(&read_bbio->bio);
> +
> +	rr->in_use =3D false;
> +	return uptodate;
> +}
> +
> +bool btrfs_read_repair_add(struct btrfs_read_repair *rr,
> +		struct btrfs_bio *failed_bbio, struct inode *inode,
> +		u64 start_offset)
> +{
> +	if (rr->in_use)
> +		return true;
> +
> +	if (!rr->num_copies) {
> +		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
> +
> +		rr->num_copies =3D btrfs_num_copies(fs_info,
> +				failed_bbio->iter.bi_sector << SECTOR_SHIFT,
> +				failed_bbio->iter.bi_size);
> +	}
> +
> +	/*
> +	 * If there is no other copy of the data to recovery from, give up now
> +	 * and don't even try to build up a larget batch.
> +	 */
> +	if (rr->num_copies < 2)
> +		return false;
> +
> +	rr->in_use =3D true;
> +	rr->start_offset =3D start_offset;
> +	return true;
> +}
> +
> +void btrfs_read_repair_exit(void)
> +{
> +	bioset_exit(&read_repair_bioset);
> +}
> +
> +int __init btrfs_read_repair_init(void)
> +{
> +	return bioset_init(&read_repair_bioset, BIO_POOL_SIZE,
> +			offsetof(struct btrfs_bio, bio), 0);
> +}
> diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
> new file mode 100644
> index 0000000000000..e371790af2b3e
> --- /dev/null
> +++ b/fs/btrfs/read-repair.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BTRFS_READ_REPAIR_H
> +#define BTRFS_READ_REPAIR_H
> +
> +struct btrfs_read_repair {
> +	u64 start_offset;
> +	bool in_use;
> +	int num_copies;
> +};
> +
> +typedef void (*repair_endio_t)(struct btrfs_bio *repair_bbio,
> +		struct inode *inode, bool uptodate);
> +
> +bool btrfs_read_repair_add(struct btrfs_read_repair *rr,
> +		struct btrfs_bio *failed_bbio, struct inode *inode,
> +		u64 bio_offset);
> +bool __btrfs_read_repair_end(struct btrfs_read_repair *rr,
> +		struct btrfs_bio *failed_bbio, struct inode *inode,
> +		u64 end_offset, repair_endio_t end_io);
> +static inline bool btrfs_read_repair_end(struct btrfs_read_repair *rr,
> +		struct btrfs_bio *failed_bbio, struct inode *inode,
> +		u64 end_offset, repair_endio_t endio)
> +{
> +	if (!rr->in_use)
> +		return true;
> +	return __btrfs_read_repair_end(rr, failed_bbio, inode, end_offset,
> +			endio);
> +}
> +
> +int __init btrfs_read_repair_init(void);
> +void btrfs_read_repair_exit(void);
> +
> +#endif /* BTRFS_READ_REPAIR_H */
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index b1fdc6a26c76e..b33ad892c3058 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -48,6 +48,7 @@
>   #include "block-group.h"
>   #include "discard.h"
>   #include "qgroup.h"
> +#include "read-repair.h"
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/btrfs.h>
>
> @@ -2641,10 +2642,12 @@ static int __init init_btrfs_fs(void)
>   	err =3D extent_io_init();
>   	if (err)
>   		goto free_cachep;
> -
> -	err =3D extent_state_cache_init();
> +	err =3D btrfs_read_repair_init();
>   	if (err)
>   		goto free_extent_io;
> +	err =3D extent_state_cache_init();
> +	if (err)
> +		goto free_read_repair;
>
>   	err =3D extent_map_init();
>   	if (err)
> @@ -2708,6 +2711,8 @@ static int __init init_btrfs_fs(void)
>   	extent_map_exit();
>   free_extent_state_cache:
>   	extent_state_cache_exit();
> +free_read_repair:
> +	btrfs_read_repair_exit();
>   free_extent_io:
>   	extent_io_exit();
>   free_cachep:
