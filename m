Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E383A2576
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 09:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhFJHaC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 03:30:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:43541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhFJHaB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 03:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623310081;
        bh=B+j6iypVVmOGP+DyFrFsLcrMWILhpJqG0p7fOMbN8Lw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jdDnwEPsHlIk1ncpKUC/VU9ZW5vkPKljUuz0rqVltlG45Vp64ErrHPM+QWBaCpmp5
         4oIkEkqZ+N/4uhAHjkY5xUV2udZ330u7/aY02uyUECHRWqm2uvEe39s1CC3HOgX4Mr
         oPjLBZ1m3vdT+b9QMVilEE9SFTe0x1jAP7kp3Fus=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHXBp-1m479d134r-00DWQb; Thu, 10
 Jun 2021 09:28:00 +0200
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9464ea87-6d50-9015-a6f5-c7b3d61458ca@gmx.com>
Date:   Thu, 10 Jun 2021 15:27:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:txlL/GxyBGx0gIsIFZnV1HQACj7B+4J7oIEQ8dPq7FiYPp33e7S
 X8MUkRAOdELkE0d4THkTEOlzLq9C8cpGpo6x5PT6d3NV3jwh48l7BUjkjL3OMAmWsCP/4wl
 +ozjhmBwcIMAZm4i73ewXpCVYIxaa5BnSTRraqIxSgY7dvLVupARxRWCTm4FINfK3kqsDHB
 NbQxhJ9aLiP1q9YIgWVgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Oa+bQc35z4=:WMc3nAoYpE7mq9F0Ssp+HE
 ZeGCCzUPHuYPmLf1I6NuvtJVh4R77ulzf/Zht7Q5vyo0hJJEHPhbFHXh9tXCyYQC0aV54OXD0
 BobekctjRO9Rmy0Y+KW5XIWCr9rRC7qFOp10oNaPPoSUphfmz1DwDLFeFoxJ0AzrMu+mRHFjk
 AvdTL2z3ngqB7J9gcbt3rKzeSWP1v4CSRT2pvXhuSMVtHxw4l1egarl5L4L4KhlQZN/IsepT7
 VDIATNPRxHvEVcLH34cyzie/cnXI2kJCYUH/xaxTa5JMpfy8kSz73uXJa5AATwCowGrHi/hc2
 IAttLP9YhfK5raJseBd1ZvZWLIKD8KcSyxWGf9b2f1gJcC4jVqh/16MYz1OqCxKiMZHrvxoYL
 S/FgJw+L7BopNXf3KUUa3zsQUofFcOf4tOGt93pRrowMCyL4Q0pfZKEwJ22pCTWLQadLdrb8h
 Jo9EbFbcj4eOeMxFxsUzrtjUGHhUwXJ4UuASpjxfaDC+hE2cLGzEXniDr8ye1CN3ldJTgs5UU
 wEshfmTGfONDZe4vkkSXManj3S8ulahPQF0oDgyFSrUtXTtGYXFb3FtPCrFm4FM68Ji3MsNZw
 cdjhW11lfW3pU0vbcQlTusZsJrnzHSlzebz9K2G3Sdr381HV9aM5ZREHrLsnwQAfrJw3BZkkO
 vnRZOwn6P8xw8vOW4Y0h/XnptLFuF870A3jjabfWo0Z/dLmCgknsXAUwIXmwnjkLHq0zG/Tc/
 WGHWuzyoDS8HcIRe/Oyx2Oab0kBmTaKRnagR3lmgGhnFgFcXG9EZoXZ4Y5LMyAS2cYalFq+XF
 zU6Yhpf0c8PytA0NokTSdjnakoKMD51sKC+Scytj3zW4u2IFGmwcG62HXjQRnkV+KOSGsDXen
 hSkMa2vvEKYo3sdVyN1QPs2wYJsCCE+on++gcA/eTUQUGuazGH3Pz4hO30lXvWrUYEncb4mMm
 rU5afPzE0y521Qgl4QLioM4923EmdGwUXeXRLTU0bkLDB9avXKmqAgNswvA4IXX9v7rUv9xOh
 R+jsHJkvARs3x5Zgvk/jHvpNbpNwjBfHs1nT6frHdecPwwdqrfXmwFokQx/pT3bkQcI6OYflP
 3L1PK1b6lpNOepgCHyDdy+uIUYNWvS6pQpuZxo6lF8RdrLRvuKx1qykzA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/18 =E4=B8=8B=E5=8D=8811:40, Johannes Thumshirn wrote:
> When multiple processes write data to the same block group on a compress=
ed
> zoned filesystem, the underlying device could report I/O errors and data
> corruption is possible.
>
> This happens because on a zoned file system, compressed data writes wher=
e
> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND
> operation. But with REQ_OP_WRITE and parallel submission it cannot be
> guaranteed that the data is always submitted aligned to the underlying
> zone's write pointer.
>
> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zone=
d
> filesystem is non intrusive on a regular file system or when submitting =
to
> a conventional zone on a zoned filesystem, as it is guarded by
> btrfs_use_zone_append.
>
> Reported-by: David Sterba <dsterba@suse.com>
> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat flag"=
)
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now working on compression support for subpage, just noticed some
strange code behavior, I'm not sure if it's designed or just a typo.

So please correct me if possible.

[...]
>
>   	bio =3D btrfs_bio_alloc(first_byte);
> -	bio->bi_opf =3D REQ_OP_WRITE | write_flags;
> +	bio->bi_opf =3D bio_op | write_flags;
>   	bio->bi_private =3D cb;
>   	bio->bi_end_io =3D end_compressed_bio_write;
>
> +	if (use_append) {
> +		struct extent_map *em;
> +		struct map_lookup *map;
> +		struct block_device *bdev;
> +
> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);
> +		if (IS_ERR(em)) {
> +			kfree(cb);
> +			bio_put(bio);
> +			return BLK_STS_NOTSUPP;
> +		}
> +
> +		map =3D em->map_lookup;
> +		/* We only support single profile for now */
> +		ASSERT(map->num_stripes =3D=3D 1);
> +		bdev =3D map->stripes[0].dev->bdev;
> +
> +		bio_set_dev(bio, bdev);
> +		free_extent_map(em);
> +	}
> +

Here for the newly created bio, we will try to call bio_set_dev() for
it. (although later patch refactor this part a little)

So far so good.

>   	if (blkcg_css) {
>   		bio->bi_opf |=3D REQ_CGROUP_PUNT;
>   		kthread_associate_blkcg(blkcg_css);
> @@ -432,6 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struct bt=
rfs_inode *inode, u64 start,
>   	bytes_left =3D compressed_len;
>   	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {
>   		int submit =3D 0;
> +		int len;
>
>   		page =3D compressed_pages[pg_index];
>   		page->mapping =3D inode->vfs_inode.i_mapping;
> @@ -439,9 +466,13 @@ blk_status_t btrfs_submit_compressed_write(struct b=
trfs_inode *inode, u64 start,
>   			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
>   							  0);
>
> +		if (pg_index =3D=3D 0 && use_append)
> +			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
> +		else
> +			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);
> +
>   		page->mapping =3D NULL;
> -		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <
> -		    PAGE_SIZE) {
> +		if (submit || len < PAGE_SIZE) {
>   			/*
>   			 * inc the count before we submit the bio so
>   			 * we know the end IO handler won't happen before
> @@ -465,11 +496,15 @@ blk_status_t btrfs_submit_compressed_write(struct =
btrfs_inode *inode, u64 start,
>   			}
>
>   			bio =3D btrfs_bio_alloc(first_byte);
> -			bio->bi_opf =3D REQ_OP_WRITE | write_flags;
> +			bio->bi_opf =3D bio_op | write_flags;

But here, for the newly allocated bio, we didn't call bio_set_dev() at all=
.

Shouldn't all zoned write bio need that bio_set_dev() call?

I guess since most compressed extents are pretty small, it's really hard
to hit a case where we need to split the bio due to stripe boundary,
thus very hard to hit anything wrong.

Anyway, since I'm working on compression code to make compressed write
to follow the same boundary check in extent_io.c, I can definitely
refactor the bio allocation code to add the zoned needed calls.

Thanks,
Qu

>   			bio->bi_private =3D cb;
>   			bio->bi_end_io =3D end_compressed_bio_write;
>   			if (blkcg_css)
>   				bio->bi_opf |=3D REQ_CGROUP_PUNT;
> +			/*
> +			 * Use bio_add_page() to ensure the bio has at least one
> +			 * page.
> +			 */
>   			bio_add_page(bio, page, PAGE_SIZE, 0);
>   		}
>   		if (bytes_left < PAGE_SIZE) {
>
