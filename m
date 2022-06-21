Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2032D552B08
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345597AbiFUGgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiFUGgN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:36:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E014016
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655793363;
        bh=kUneMW5GaGixACyJ9hXXu41WwjCy0N3cYNzMn6lQ4IY=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=EkURzXzPVEAFFjmM2ZhdhYaJiq8dZ80mPd1JfXtrttEfMjmrUjVe1UXoDB8+7fmLM
         odyvk94LYANm5+2NY1qovTJScARiIC8EpBdWnB7FuwOQpOcU7O8GpNOyDSSq5wcyTF
         9KelaQAoW8T8UUtFp2uUEJysYz/dIgSg7CLGa1h8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MNbkp-1oJAWv1NGd-00P8b8; Tue, 21
 Jun 2022 08:36:03 +0200
Message-ID: <221407c5-0aec-6ab0-4f7f-e74a5873e4e0@gmx.com>
Date:   Tue, 21 Jun 2022 14:35:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, clm@fb.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20220621062627.2637632-1-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs: don't limit direct reads to a single sector
In-Reply-To: <20220621062627.2637632-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wmL8uZfqa2Sf7CvgvB23NtgabIhU/cmyjNB+3ZDhwz48gXtPvj9
 lmV10/Xj5bbZjLpLIHH1cUqqCFVHJ/353NBY8TzjAUcjThd9LcjaiuG2u7ZxK6BiqdJSLsv
 el8skOsWehLuk0S7UbN297ub0lYQM3KxCjYzyxG38T6k/mAYeu9KUU3gWcl5DyvPtzuH5Ox
 k7jwWvsfWZtBXkW8aKJfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fKE3BpmpPkY=:7grU4r/XSwUkNeYbNF03m2
 vT5qFQEgL7PLObx5Ggxi3d27kQkkW7AysRSyUi1M+gmz+kqCnn989VUvOISkq0bHN7d6Bg4Ss
 fLzllryyzMkco9M0F7sWqUWWwaR2Tffq9X/hfpe2CtLFK/v9P5vmymQ2BcKW+n1oqJYpCtovj
 lZJX7obsC5XwoXzt7NktAgv4OaKoAAxu/CThowqgWW7fnDWvyoGA3ddhWK37k4KQRtX7/PQrH
 JuiTNRuEzdKkqRE/KjqpYOEs/MBF9+QoVx4dKqRthFOeMtaWtTf87w3T+FfZzwenoXUXUl+YS
 0roHUksGyOAtcRYBMe7skCs+NvgZ9hnrTrzXfYspi3Poqoy3EPCvZPgKC0X4mSmgpKWXsY/t+
 ifGNveeySc/95lx2EY6uEZuld+0DOkPV+/iViAKDUbIpMaBVX07RCEUSqf43PlZiFweYHvTUj
 sV6BAhD6mzIJ4mQH+8mrRoxLUl0B+ltJ9fTEjCO0QVdKUz1TaYR5o1Y8WO4+aJlrMAiYGcih6
 AVgrNzXShGEk8AfnDG4G9hjyZN7YnFmwdC0ZjEBTnXTAdAGrLwiCPtYgMY1YOJ+bCzvm4s204
 qIhqxsyBK6kEiyMqJsaS5Uz2txFU7gvpeNwLbjZwC4wx87SckLJmhtR4fl4QQjjjpDoFSdu2G
 r9Uh2hoR3CkxxTRPYcC1HxKs1PUrf/5FqGkAw0rPlyVtsWI3jXMIsMRs4Xc3KBqspt7WzIBQ8
 uzaqpuJp3FrMM4BWQ6PyigAjydgKT3Mkml/b/sLQcl0/mzS/8TLp9fy8IxdfhEF3cPbQvqqpY
 5ibznvH7dlsympADpjik/v7TCo33vpPUKukBZv7M+svp2JUVeAO9gGonA+DOB5Gc75RA76xOQ
 jvVX/RanJTzoxOr0phXQpi1nvcUgGpAZCNqeIlULxw1uoYtvuZBN3yh6E5p4LzFy+/DQLeUni
 YE9lJk72Jzb3ZS5t6GIPx0DfqdaPNnzkY0CGmawoJ2I6GEhexbnHTZVJdeJP9HuF+EIUU1k9m
 sUiyuEm62i+eEG4caQAAMM1VBEZPj5wNp2U966lXdQ1v1aNKplzkY1BrQQxK2v6eSKEGszK3Z
 zeeiRmZAWCffdgn5jgMS7hfzW+VF7IIOP1ggaE+eeYqpPYEjk1dZbmWWQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/21 14:26, Christoph Hellwig wrote:
> Btrfs currently limits direct I/O reads to a single sector, which goes
> back to commit c329861da406 ("Btrfs: don't allocate a separate csums
> array for direct reads") from Josef.  That commit changes the direct I/O
> code to ".. use the private part of the io_tree for our csums.", but ten
> years later that isn't how checksums for direct reads work, instead they
> use a csums allocation on a per-btrfs_dio_private basis (which have thei=
r
> own performance problem for small I/O, but that will be addressed later)=
.
>
> There is no fundamental limit in btrfs itself to limit the I/O size
> except for the size of the checksum array that scales linearly with
> the number of sectors in an I/O.  Pick a somewhat arbitrary limit of
> 256 limits, which matches what the buffered reads typically see as
> the upper limit as the limit for direct I/O as well.
>
> This significantly improves direct read performance.  For example a fio
> run doing 1 MiB aio reads with a queue depth of 1 roughly triples the
> throughput:
>
> Baseline:
>
> READ: bw=3D65.3MiB/s (68.5MB/s), 65.3MiB/s-65.3MiB/s (68.5MB/s-68.5MB/s)=
, io=3D19.1GiB (20.6GB), run=3D300013-300013msec
>
> With this patch:
>
> READ: bw=3D196MiB/s (206MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s), io=
=3D57.5GiB (61.7GB), run=3D300006-300006msc
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

The patch itself looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

But the extra comment itself can be confusing.

> ---
>
> Changes since v1:
>    - keep a (large) upper limit on the I/O size.
>
>   fs/btrfs/inode.c   | 6 +++++-
>   fs/btrfs/volumes.h | 7 +++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 33ba4d22e1430..f6dc6e8c54e3a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7592,8 +7592,12 @@ static int btrfs_dio_iomap_begin(struct inode *in=
ode, loff_t start,
>   	const u64 data_alloc_len =3D length;
>   	bool unlock_extents =3D false;
>
> +	/*
> +	 * Cap the size of reads to that usually seen in buffered I/O as we ne=
ed
> +	 * to allocate a contiguous array for the checksums.
> +	 */
>   	if (!write)
> -		len =3D min_t(u64, len, fs_info->sectorsize);
> +		len =3D min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_SECTORS);

It's better just to craft a manual limit, that BTRFS_MAX_SECTORS doesn't
really match the real buffered read size (commented below).

Here I believe we can afford an artificial limit, no need to align with
any existing limit.

>
>   	lockstart =3D start;
>   	lockend =3D start + len - 1;
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index b61508723d5d2..5f2cea9a44860 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -354,6 +354,13 @@ struct btrfs_fs_devices {
>   				- 2 * sizeof(struct btrfs_chunk))	\
>   				/ sizeof(struct btrfs_stripe) + 1)
>
> +/*
> + * Maximum number of sectors for a single bio to limit the size of the
> + * checksum array.  This matches the number of bio_vecs per bio and thu=
s the
> + * I/O size for buffered I/O.
> + */
> +#define BTRFS_MAX_SECTORS	256

In fact, one bio vector can point to multiple pages, as its bv_len can
be larger than PAGE_SIZE.

And I have observed bio larger than 1MiB (4MiB or 16MiB IIRC?).
Thus this comment itself is unreliable, just putting SZ_1MiB as the
upper limit would be enough.

Thanks,
Qu


> +
>   /*
>    * Additional info to pass along bio.
>    *
