Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46575231BC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgG2JFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 05:05:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:43547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgG2JFr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 05:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596013544;
        bh=4GwawfkAcSD2yl8xYKGXgeRtbUrFzBJD2NKUjC7cyCU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:In-reply-to:Date;
        b=bWWrKuFMVT18HV06Ljcyd6mt7mK8PA7SFSGK6qRKoflO4jtVAs1yt4tFszEVYOtuA
         IvmYDdi6s+ZDfweoND9u4unrLHeNNUxu+Q4dILb3medpEhmXY3H82mL9Dp0GigZX+x
         5UcmVpRbaD8i8h8NZtWhhuDtRweqksOkPsk0EQd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from nas ([103.217.255.46]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1khzfk2C6B-00hsPG; Wed, 29
 Jul 2020 11:05:44 +0200
From:   Su Yue <Damenly_Su@gmx.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: convert: report available space before convertion happens
References: <20200729084038.78151-1-wqu@suse.com> <20200729084038.78151-4-wqu@suse.com>
User-agent: mu4e 1.2.0; emacs 26.3
In-reply-to: <20200729084038.78151-4-wqu@suse.com>
Date:   Wed, 29 Jul 2020 17:05:34 +0800
Message-ID: <8sf28zdt.fsf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Provags-ID: V03:K1:DlIKaLT82yHnYJG7WMn/l2ehF6u+oVJOdQlOgPf4qP6Fmd+kAEM
 VlB56kcM/PjDGvzoyfF3FduVzqCgXN9B3e0fu3dlkYKTB7KmXr5jBNiMvu2L+kg4AemtUEm
 HOSDOmwfdUx1wsUhhRQX4Ru9uFBkkJJZ5HsGs75IbhapZSVCGiJcebR3bghVEiNRGc2SZzO
 9X79Wk6PezfcHSUTh9eRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5tDOvO9dUPk=:quKD+5o/YiMIT0m0+r/k6b
 7PkzQOGcjCypi62UuAM/K6BgbJqV6FvzFy895xqhuCnSTbUaol3aE/cjSVnZAMpZ73yZXu/8i
 hJqtNvUtb54BQYmuLQyrK8splF8bGp9l0z5xID/lkkH3YDc4iObDpesIYYBfrbbJKlZv/U+u5
 VbT7SnNFC4+TedtCbjUcJgLW6ahppRZJOPN6Bqz8Okvv4FjhCTFin6+EC79bNQRg+hC+w8lLe
 rp34lL98YyLgueogEN9Tis6o+73Fy7E1tTNK496RVcYRupd/NtH0i5iiGNFybI2kJBlydqyCJ
 egwbuwHeJbcGI3NfjfErL4FKgCE3v0BKSgUnkjqg3Zmm5HmA9SoPQK2A/pjMSCgnmagoAm8hV
 yqPdfpKrjzQ75puG4zbyYVPQZVnHbxuH/rOa96PQZimdw7vg6vuBFI6839fx2wwZKc0r/M8f4
 HGREhyz6uDbpVAnS2n/VhF7nY4g0SZddH+ARV44c7ZAlwESgpI3Uq0ukIJ7kbnNCRRmCY+NXc
 d7pp65Q95zdjupte5M9EKv8/SLowDSXWKEw8725RB7/HiJ0fWKjntQxw0pTfOf5bIVBBQYwlO
 FknElYH9k5KvOfiv2HdIpnJ73rs9pV1xscI0a4YoCOxbIUFO1rlQMRqj8z5KUP4kfK07jfvSk
 KYRr4xuCamiPaZ0TTnYRopHpCkYRknmRueoKCs2z2b7LuTE+lyInFUQgJyKkNwdNOOlpcuu/n
 7PUiMeAEMODgwHkzJVB1pi9w1SVR7OhHDNwBCcJToWWVm/mfbLDvOthaQMJRymVHl0+SfkJNs
 I4HHQmYZ2Nb/12fTxIcaRBCLXWN8AYIhWFU92B5Oeoc/EiZkdAZM3isqC6DBIa62nmA3A9JK+
 JozJ0mznAGII5rqOmGTD/cf+UOKBzYZ2GC7qhNovecqp3rFMzdDGhtLsRd7fmXdJvobtvBcbO
 VlqCifMytziqPcLl7sVZhe/1e+3ctV/W6gPIRnirBdEEvVQSbLiBTTyP0KWq39zbQhz/mcKot
 36Leo7faiuqC/L+oCLsjucW0Ay3I1ijuVFCUP+ABj3qgNOenSJ47EitdIEM+zY5Zv+w7NPe8K
 Xjv4VYflHJqzqMj0LSylHA9/JJ1kxlgMGnprBVsMQHytm29wy6Wbhn3oz2y3ouus0gKdA0Zj5
 D9jnz6r/PzNoiFtToldsUSN57e4kg6s1DkQRhezgX8JmwzHvkHWWrL/uu8/Z0jR0yjACpYKJZ
 AO0uF6E2zoVa6zS0EgNpgZfU6qfeIaA8SHdFF1A==
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 29 Jul 2020 at 16:40, Qu Wenruo <wqu@suse.com> wrote:

> Now if an ENOSPC error happened, the free space report would
> help user to determine if it's a real ENOSPC or a bug in btrfs.
>
> The reported free space is the calculated free space, which
> doesn't include super block space, nor merged data chunks.
>
> The free space is always smaller than the reported available
> space of the original fs, as we need extra padding space for
> used space to avoid too fragmented data chunks.
>
> The output exact would be:
>
> $ ./btrfs-convert  /dev/nvme/btrfs create btrfs filesystem:
>         blocksize: 4096 nodesize:  16384 features:  extref,
>         skinny-metadata (default) checksum:  crc32c
> free space report: free / total =3D 0 / 10737418240 (0%) <<<
> ERROR: unable to create initial ctree: No space left on device
> WARNING: an error occurred during conversion, the original
> filesystem is not modified
>
> Signed-off-by: Qu Wenruo <wqu@suse.com> ---
>  convert/common.h    |  9 +++++++++ convert/main.c      | 26
>  ++++++++++++++++++++++++-- convert/source-fs.c |  1 + 3 files
>  changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/convert/common.h b/convert/common.h index
> 7ec26cd996d3..2c7799433294 100644 --- a/convert/common.h +++
> b/convert/common.h @@ -35,6 +35,7 @@ struct
> btrfs_convert_context {
>  	u64 inodes_count; u64 free_inodes_count; u64 total_bytes;
> +	u64 free_bytes_initial;
>  	char *volume_name; const struct btrfs_convert_operations
>  *convert_ops;
> @@ -47,6 +48,14 @@ struct btrfs_convert_context {
>  	/* Free space which is not covered by data_chunks */ struct
>  cache_tree free_space;
> +	/* +	 * Free space reserved for ENOSPC report, it's just a
> copy +	 * free_space.  +	 * But after initial calculation,
> free_space_initial is no longer +	 * updated, so we have a good
> idea on how many free space we really +	 * have for btrfs.  +
> */ +	struct cache_tree free_space_initial;
>  	void *fs_data; };
> diff --git a/convert/main.c b/convert/main.c index
> 451e4f158689..49c95e092cbb 100644 --- a/convert/main.c +++
> b/convert/main.c @@ -727,6 +727,23 @@ out:
>  	return ret; }
> +static int copy_free_space_tree(struct btrfs_convert_context
> *cctx) +{ +	struct cache_tree *src =3D &cctx->free_space; +
> struct cache_tree *dst =3D &cctx->free_space_initial; +	struct
> cache_extent *cache; +	int ret =3D 0; + +	for (cache =3D
> search_cache_extent(src, 0); cache; +	     cache =3D
> next_cache_extent(cache)) { +		ret =3D
> add_merge_cache_extent(dst, cache->start, cache->size); +		if
> (ret < 0) +			return ret; +
> cctx->free_bytes_initial +=3D cache->size; +	} +	return ret; +}
> +
>  /*
>   * Read used space, and since we have the used space, *
>   calculate data_chunks and free for later mkfs
> @@ -740,7 +757,10 @@ static int convert_read_used_space(struct
> btrfs_convert_context *cctx)
>  		return ret;  ret =3D calculate_available_space(cctx);
> -	return ret; +	if (ret < 0) +		return ret; + +	return
> copy_free_space_tree(cctx);
>  }  /*
> @@ -1165,7 +1185,9 @@ static int do_convert(const char *devname,
> u32 convert_flags, u32 nodesize,
>  	printf("\tnodesize:  %u\n", nodesize); printf("\tfeatures:
>  %s\n", features_buf); printf("\tchecksum:  %s\n",
>  btrfs_super_csum_name(csum_type));
> - +	printf("free space report: free / total =3D %llu / %llu
> (%lld%%)\n", +		cctx.free_bytes_initial, cctx.total_bytes,
> +		cctx.free_bytes_initial * 100 / cctx.total_bytes);
>  	memset(&mkfs_cfg, 0, sizeof(mkfs_cfg)); mkfs_cfg.csum_type =3D
>  csum_type; mkfs_cfg.label =3D cctx.volume_name;
> diff --git a/convert/source-fs.c b/convert/source-fs.c index
> f7fd3d6055b7..d2f7a825238d 100644 --- a/convert/source-fs.c +++
> b/convert/source-fs.c @@ -74,6 +74,7 @@ void
> init_convert_context(struct btrfs_convert_context *cctx)
>  	cache_tree_init(&cctx->used_space);
>  cache_tree_init(&cctx->data_chunks);
>  cache_tree_init(&cctx->free_space);
> +	cache_tree_init(&cctx->free_space_initial);
>  }  void clean_convert_context(struct btrfs_convert_context
>  *cctx)

Did you forget the clean path? :)

=2D--
Su

