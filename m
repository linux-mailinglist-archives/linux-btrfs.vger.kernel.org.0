Return-Path: <linux-btrfs+bounces-16334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D26DB33D19
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 12:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD67B0B13
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC282D97BF;
	Mon, 25 Aug 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG2H44ys"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DB262FC1;
	Mon, 25 Aug 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118613; cv=none; b=QxLHef0UEyku6mNiUQvA9y84ktuRfRhU5UEQhXtkjFft4GNK+emohjLrREjJyogQUM3o+mFlMeOWZOlshI4B444M7n41xSX4lT0+OsVpHbsqipbRcawgJWJtKlJWI18PM2F8wjJcOZcvNZCvQSH64+gWXO1i7hby37hBgOp2Rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118613; c=relaxed/simple;
	bh=csuMMNrS9NJXg5juXrf01zavwUwhn7WO3M0PQBHLi8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywb0I4Ymffj+zzwv6F6BL7skNDglmTGBgPMG5BRySg+BS8DZyQboxVfVnaFvQ7DfCyjsavfmsfTE/mK+Pr3xhMunaGlnLq/ZrJa4RyEqb6+EiOvmmZjlb8A/NqTjiXNx+DF59bCNhZga4aI/GmuCS1qUSTltlJ2S3IwtvgiVqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG2H44ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509E7C4CEED;
	Mon, 25 Aug 2025 10:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756118613;
	bh=csuMMNrS9NJXg5juXrf01zavwUwhn7WO3M0PQBHLi8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CG2H44ysEn5M/ALbLaPu52M/Fotc03B5sfdLbBd6BHPsD0eOtC838/3nAv4vH416K
	 fdOzpXu7S3ev07/e++FhFe14OyeF9nIu//hLkvCd4jc8cUBwQIVW06RMpj57aO0fE6
	 f3Bud/eeB0joCds67lHbudnvKjs4tL6+t1YX7vGAKbzv+4noRuzNorVXPrKSOs2Xaq
	 BMBwpqmQN3YDuBgYQXXyU2aMvgKF8jrZP3CNhEKKIrzPhJb0yXZ9Zojtr4FCx3Rbqu
	 +Fgu11W206hAaAmSHTLjgVKmv3jMSycypg2WaO92EtxzPelP5uLQya66exyEcjEWtN
	 YSuykEuvesZyQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb731caaaso627322466b.0;
        Mon, 25 Aug 2025 03:43:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdeX7KjeY2VPFEsX4JMIkgiYnhjZGoQ2UPC2tY1ugPxAqgLUTjeYM0vmvgBIzjn4qrvyvwat4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+sYy0GDbJK9qPhx+5N+ChSezZu/0SvseE0F8ie3S1wDz6qft
	5Jic5FyNSo1EqC7n8eYKwkugc9wwks3aCLpFJLYEHXE/er5iv1nYZNpK4xyvie1JJV3qGFoLt3F
	YY9K7tZTLZDLLTd0UlJxxEU+ldAgRZkM=
X-Google-Smtp-Source: AGHT+IFvI/3cjZZvd6uaftHsSekI9ZnT8HW3azy6/Mpt9c6J7MViN+mbwIRBEQ9vRRfIxAKX4foKfWGRW6Phk0TqDwg=
X-Received: by 2002:a17:907:60ca:b0:af9:35f0:7a0f with SMTP id
 a640c23a62f3a-afe28ffb668mr1000041666b.28.1756118611709; Mon, 25 Aug 2025
 03:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fe1f1d9e9f2425fa25a2ff9295b4e194125392f6.1755991465.git.wqu@suse.com>
In-Reply-To: <fe1f1d9e9f2425fa25a2ff9295b4e194125392f6.1755991465.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 25 Aug 2025 11:42:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7eZp0QG_UyiNaagC=uEk_od87jsdVrJq0YyyXfOnb-nw@mail.gmail.com>
X-Gm-Features: Ac12FXxRbcMZBduTRCZI8H6tym4NftX1LcGorbMuWMfk_pOAzpqAq0TF-olpYWk
Message-ID: <CAL3q7H7eZp0QG_UyiNaagC=uEk_od87jsdVrJq0YyyXfOnb-nw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: do more strict compressed read merge check
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 12:27=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When running test case generic/457, there is a chance to hit the
> following error, with 64K page size and 4K btrfs block size, and
> "compress=3Dzstd" mount option:
>
> FSTYP         -- btrfs
> PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.17.0-rc2-custom+ #129 SMP =
PREEMPT_DYNAMIC Wed Aug 20 18:52:51 ACST 2025
> MKFS_OPTIONS  -- -s 4k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- -o compress=3Dzstd /dev/mapper/test-scratch1 /mnt/scratc=
h
>
> generic/457 2s ... [failed, exit status 1]- output mismatch (see /home/ad=
am/xfstests-dev/results//generic/457.out.bad)
>     --- tests/generic/457.out   2024-04-25 18:13:45.160550980 +0930
>     +++ /home/adam/xfstests-dev/results//generic/457.out.bad    2025-08-2=
2 16:09:41.039352391 +0930
>     @@ -1,2 +1,3 @@
>      QA output created by 457
>     -Silence is golden
>     +testfile6 end md5sum mismatched
>     +(see /home/adam/xfstests-dev/results//generic/457.full for details)
>     ...
>     (Run 'diff -u /home/adam/xfstests-dev/tests/generic/457.out /home/ada=
m/xfstests-dev/results//generic/457.out.bad'  to see the entire diff)
>
> The root problem is, after certain fsx operations the file contents
> change just after a mount cycle.
>
> There is a much smaller reproducer based on that test case, which I
> mainly used to debug the bug:
>
> workload() {
>         mkfs.btrfs -f $dev > /dev/null
>         dmesg -C
>         trace-cmd clear
>         mount -o compress=3Dzstd $dev $mnt
>         xfs_io -f -c "pwrite -S 0xff 0 256K" -c "sync" $mnt/base > /dev/n=
ull
>         cp --reflink=3Dalways -p -f $mnt/base $mnt/file
>         $fsx -N 4 -d -k -S 3746842 $mnt/file
>         if [ $? -ne 0 ]; then
>                 echo "!!! FSX FAILURE !!!"
>                 fail
>         fi
>         csum_before=3D$(_md5_checksum $mnt/file)
>         stop_trace
>         umount $mnt
>         mount $dev $mnt
>         csum_after=3D$(_md5_checksum $mnt/file)
>         umount $mnt
>         if [ "$csum_before" !=3D "$csum_after" ]; then
>                 echo "!!! CSUM MISMATCH !!!"
>                 fail
>         fi
> }
>
> This seed value will cause 100% reproducible csum mismatch after a mount
> cycle.
>
> The seed value results only 2 real operations:
>
>   Seed set to 3746842
>   main: filesystem does not support fallocate mode FALLOC_FL_UNSHARE_RANG=
E, disabling!
>   main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RAN=
GE, disabling!
>   main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE=
, disabling!
>   main: filesystem does not support exchange range, disabling!
>   main: filesystem does not support dontcache IO, disabling!
>   2 clone       from 0x3b000 to 0x3f000, (0x4000 bytes) at 0x1f000
>   3 write       0x2975b thru    0x2ba20 (0x22c6 bytes)  dontcache=3D0
>   All 4 operations completed A-OK!

Can you please make a test case for fstests?
Without fsx of course, since when new operations are added or fsx is
changed in other ways, the same seed is likely to not exercise the bug
anymore.

Just using xfs_io (writes, cloning, etc).

>
> [CAUSE]
> With extra debug trace_printk(), the following sequence can explain the
> root cause:
>
>   fsx-3900290 [002] ..... 161696.160966: btrfs_submit_compressed_read: r/=
i=3D5/258 file_off=3D131072 em start=3D126976 len=3D16384
>
> The "r/i" is showing the root id and the ino number.
> In this case, my minimal reproducer is indeed using inode 258 of
> subvolume 5, and that's the inode with changing contents.
>
> The above trace is from the function btrfs_submit_compressed_read(),
> triggered by fsx to read the folio at file offset 128K.
>
> Notice that the extent map, it's at offset 124K, with a length of 16K.
> This means the extent map only covers the first 12K (3 blocks) of the
> folio 128K.
>
>   fsx-3900290 [002] ..... 161696.160969: trace_dump_cb: btrfs_submit_comp=
ressed_read, r/i=3D5/258 file off start=3D131072 len=3D65536 bi_size=3D6553=
6
>
> This is the line I used to dump the basic info of a bbio, which shows the
> bi_size is 64K, aka covering the whole 64K folio at file offset 128K.
>
> But remember, the extent map only covers 3 blocks, definitely not enough
> to cover the whole 64K folio at 128K file offset.
>
>   kworker/u19:1-3748349 [002] ..... 161696.161154: btrfs_decompress_buf2p=
age: r/i=3D5/258 file_off=3D131072 copy_len=3D4096 content=3Dffff
>   kworker/u19:1-3748349 [002] ..... 161696.161155: btrfs_decompress_buf2p=
age: r/i=3D5/258 file_off=3D135168 copy_len=3D4096 content=3Dffff
>   kworker/u19:1-3748349 [002] ..... 161696.161156: btrfs_decompress_buf2p=
age: r/i=3D5/258 file_off=3D139264 copy_len=3D4096 content=3Dffff
>   kworker/u19:1-3748349 [002] ..... 161696.161157: btrfs_decompress_buf2p=
age: r/i=3D5/258 file_off=3D143360 copy_len=3D4096 content=3Dffff
>
> The above lines show that btrfs_decompress_buf2page() called by zstd
> decompress code is copying the decompressed content into the filemap.
>
> But notice that, the last line is already beyond the extent map range.
>
> Furthermore, there are no more compressed content copy, as the
> compressed bio only has the extent map to cover the first 3 blocks (the
> 4th block copy is already incorrect).
>
>    kworker/u19:1-3748349 [002] ..... 161696.161161: trace_dump_cb: r/i=3D=
5/258 file_pos=3D131072 content=3Dffff
>    kworker/u19:1-3748349 [002] ..... 161696.161161: trace_dump_cb: r/i=3D=
5/258 file_pos=3D135168 content=3Dffff
>    kworker/u19:1-3748349 [002] ..... 161696.161162: trace_dump_cb: r/i=3D=
5/258 file_pos=3D139264 content=3Dffff
>    kworker/u19:1-3748349 [002] ..... 161696.161162: trace_dump_cb: r/i=3D=
5/258 file_pos=3D143360 content=3Dffff
>    kworker/u19:1-3748349 [002] ..... 161696.161162: trace_dump_cb: r/i=3D=
5/258 file_pos=3D147456 content=3D0000
>
> This is the extra dumpping of the compressed bio, after file offset
> 140K (143360), the content is all zero, which is incorrect.
> The zero is there because we didn't copy anything into the folio.
>
> The root cause of the corruption is, we are submitting a compressed read
> for a whole folio, but the extent map we get only covers the first 3
> blocks, meaning the compressed read path is merging reads that shouldn't
> be merged.
>
> The involved file extents are:
>
>         item 19 key (258 EXTENT_DATA 126976) itemoff 15143 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13635584 nr 4096
>                 extent data offset 110592 nr 16384 ram 131072
>                 extent compression 3 (zstd)
>         item 20 key (258 EXTENT_DATA 143360) itemoff 15090 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 13635584 nr 4096
>                 extent data offset 12288 nr 24576 ram 131072
>                 extent compression 3 (zstd)
>
> Note that, both extents at 124K and 140K are pointing to the same
> compressed extent, but with different offset.
>
> This means, we reads of range [124K, 140K) and [140K, 165K) should not

"we reads of range..." -> the reads of ranges...

> be merged.
>
> But read merge check function, btrfs_bio_is_contig(), is only checking
> the disk_bytenr of two compressed reads, as there are not enough info
> like the involved extent maps to do more comprehensive checks, resulting
> the incorrect compressed read.

So this is a variant of similar problems solved in the past where for
compressed extents we merged when we shouldn't have:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D005efedf2c7d0a270ffbe28d8997b03844f3e3e7
http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D808f80b46790f27e145c72112189d6a3be2bc884
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8e928218780e2f1cf2f5891c7575e8f0b284fcce

And we have test cases btrfs/103, btrfs/106 and btrfs/183 that
exercise those past pugs.

>
> Unfortunately this is a long existing bug, way before subpage block size
> support.
>
> But subpage block size support (and experimental large folio support)
> makes it much easier to detect.
>
> If block size equals page size, regular page read will only read one
> block each time, thus no extent map sharing nor merge.
>
> (This means for bs =3D=3D ps cases, it's still possible to hit the bug wi=
th
> readahead, just we don't have test coverage with content verification
> for readahead)
>
> [FIX]
> Save the last hit compressed extent map start/len into btrfs_bio_ctrl,
> and check if the current extent map is the same as the saved one.
>
> Here we only save em::start/len to save memory for btrfs_bio_ctrl, as
> it's using the stack memory, which is a very limited resource inside the
> kernel.
>
> Since the compressed extent maps are never merged, their start/len are
> unique inside the same inode, thus just checking start/len will be
> enough to make sure they are the same extent map.
>
> If the extent maps do not match, force submitting the current bio, so
> that the read will never be merged.
>
> CC: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> v2:
> - Only save extent_map::start/len to save memory for btrfs_bio_ctrl
>   It's using on-stack memory which is very limited inside the kernel.
>
> - Remove the commit message mentioning of clearing last saved em
>   Since we're using em::start/len, there is no need to clear them.
>   Either we hit the same em::start/len, meaning hitting the same extent
>   map, or we hit a different em, which will have a different start/len.
> ---
>  fs/btrfs/extent_io.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 0c12fd64a1f3..418e3bf40f94 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -131,6 +131,22 @@ struct btrfs_bio_ctrl {
>          */
>         unsigned long submit_bitmap;
>         struct readahead_control *ractl;
> +
> +       /*
> +        * The start/len of the last hit compressed extent map.
> +        *
> +        * The current btrfs_bio_is_contig() only uses disk_bytenr as
> +        * the condition to check if the read can be merged with previous
> +        * bio, which is not correct. E.g. two file extents pointing to t=
he
> +        * same extent.
> +        *
> +        * So here we need to do extra check to merge reads that are
> +        * covered by the same extent map.
> +        * Just extent_map::start/len will be enough, as they are unique
> +        * inside the same inode.
> +        */
> +       u64 last_compress_em_start;
> +       u64 last_compress_em_len;
>  };
>
>  /*
> @@ -957,6 +973,32 @@ static void btrfs_readahead_expand(struct readahead_=
control *ractl,
>                 readahead_expand(ractl, ra_pos, em_end - ra_pos);
>  }
>
> +static void save_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
> +                              const struct extent_map *em)
> +{
> +       if (btrfs_extent_map_compression(em) =3D=3D BTRFS_COMPRESS_NONE)
> +               return;
> +       bio_ctrl->last_compress_em_start =3D em->start;
> +       bio_ctrl->last_compress_em_len =3D em->len;
> +}

Something so simple can be open coded instead in the single caller...

> +
> +static bool is_same_compressed_em(struct btrfs_bio_ctrl *bio_ctrl,
> +                                 const struct extent_map *em)
> +{
> +       /*
> +        * Only if the em is completely the same as the previous one we c=
an merge
> +        * the current folio in the read bio.
> +        *
> +        * Here we only need to compare the em->start/len against saved
> +        * last_compress_em_start/len, as start/len inside an inode are u=
nique,
> +        * and compressed extent maps are never merged.
> +        */
> +       if (em->start !=3D bio_ctrl->last_compress_em_start ||
> +           em->len !=3D bio_ctrl->last_compress_em_len)
> +               return false;

Same here. In fact we already have part of this logic in the caller, see be=
low.


> +       return true;
> +}
> +
>  /*
>   * basic readpage implementation.  Locked extent state structs are inser=
ted
>   * into the tree that are removed when the IO is done (by the end_io
> @@ -1080,9 +1122,19 @@ static int btrfs_do_readpage(struct folio *folio, =
struct extent_map **em_cached,
>                     *prev_em_start !=3D em->start)
>                         force_bio_submit =3D true;
>
> +               /*
> +                * We must ensure we only merge compressed read when the =
current
> +                * extent map matches the previous one exactly.
> +                */
> +               if (compress_type !=3D BTRFS_COMPRESS_NONE) {
> +                       if (!is_same_compressed_em(bio_ctrl, em))
> +                               force_bio_submit =3D true;
> +               }

We already do almost all of this above - we only miss the extent map
length check.
We have the prev_em_start which already stores the start offset of the
last found compressed extent map, so we're duplicating code and logic
here unnecessarily.

Further with this new logic, since last_compress_em_start and
last_compress_em_len are initialized to zero, we always do an
unnecessary split for the first readahead call that spans more than
page/folio.
We need to distinguish the first call and ignore it - that's why
*prev_em_start is initialized to (u64)-1 and we check that special
value above.



> +
>                 if (prev_em_start)
>                         *prev_em_start =3D em->start;
>
> +               save_compressed_em(bio_ctrl, em);

This could have been placed under the check for compress_type !=3D
BTRFS_COMPRESS_NONE...

In other words, this could be simplified to this:

(also at https://pastebin.com/raw/tZHq7icd)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c12fd64a1f3..a982277f852b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -131,6 +131,22 @@ struct btrfs_bio_ctrl {
  */
  unsigned long submit_bitmap;
  struct readahead_control *ractl;
+
+ /*
+ * The start/len of the last hit compressed extent map.
+ *
+ * The current btrfs_bio_is_contig() only uses disk_bytenr as
+ * the condition to check if the read can be merged with previous
+ * bio, which is not correct. E.g. two file extents pointing to the
+ * same extent.
+ *
+ * So here we need to do extra check to merge reads that are
+ * covered by the same extent map.
+ * Just extent_map::start/len will be enough, as they are unique
+ * inside the same inode.
+ */
+ u64 last_compress_em_start;
+ u64 last_compress_em_len;
 };

 /*
@@ -965,7 +981,7 @@ static void btrfs_readahead_expand(struct
readahead_control *ractl,
  * return 0 on success, otherwise return error
  */
 static int btrfs_do_readpage(struct folio *folio, struct extent_map
**em_cached,
-      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
+     struct btrfs_bio_ctrl *bio_ctrl)
 {
  struct inode *inode =3D folio->mapping->host;
  struct btrfs_fs_info *fs_info =3D inode_to_fs_info(inode);
@@ -1075,13 +1091,15 @@ static int btrfs_do_readpage(struct folio
*folio, struct extent_map **em_cached,
  * is a corner case so we prioritize correctness over
  * non-optimal behavior (submitting 2 bios for the same extent).
  */
- if (compress_type !=3D BTRFS_COMPRESS_NONE &&
-    prev_em_start && *prev_em_start !=3D (u64)-1 &&
-    *prev_em_start !=3D em->start)
- force_bio_submit =3D true;
-
- if (prev_em_start)
- *prev_em_start =3D em->start;
+ if (compress_type !=3D BTRFS_COMPRESS_NONE) {
+ if (bio_ctrl->last_compress_em_start !=3D U64_MAX &&
+    (em->start !=3D bio_ctrl->last_compress_em_start ||
+     em->len !=3D bio_ctrl->last_compress_em_len))
+ force_bio_submit =3D true;
+
+ bio_ctrl->last_compress_em_start =3D em->start;
+ bio_ctrl->last_compress_em_len =3D em->len;
+ }

  em_gen =3D em->generation;
  btrfs_free_extent_map(em);
@@ -1296,12 +1314,15 @@ int btrfs_read_folio(struct file *file, struct
folio *folio)
  const u64 start =3D folio_pos(folio);
  const u64 end =3D start + folio_size(folio) - 1;
  struct extent_state *cached_state =3D NULL;
- struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ };
+ struct btrfs_bio_ctrl bio_ctrl =3D {
+ .opf =3D REQ_OP_READ,
+ .last_compress_em_start =3D U64_MAX,
+ };
  struct extent_map *em_cached =3D NULL;
  int ret;

  lock_extents_for_read(inode, start, end, &cached_state);
- ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
+ ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
  btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);

  btrfs_free_extent_map(em_cached);
@@ -2641,7 +2662,8 @@ void btrfs_readahead(struct readahead_control *rac)
 {
  struct btrfs_bio_ctrl bio_ctrl =3D {
  .opf =3D REQ_OP_READ | REQ_RAHEAD,
- .ractl =3D rac
+ .ractl =3D rac,
+ .last_compress_em_start =3D U64_MAX,
  };
  struct folio *folio;
  struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
@@ -2649,12 +2671,11 @@ void btrfs_readahead(struct readahead_control *rac)
  const u64 end =3D start + readahead_length(rac) - 1;
  struct extent_state *cached_state =3D NULL;
  struct extent_map *em_cached =3D NULL;
- u64 prev_em_start =3D (u64)-1;

  lock_extents_for_read(inode, start, end, &cached_state);

  while ((folio =3D readahead_folio(rac)) !=3D NULL)
- btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
+ btrfs_do_readpage(folio, &em_cached, &bio_ctrl);

  btrfs_unlock_extent(&inode->io_tree, start, end, &cached_state);

Thanks.
>                 em_gen =3D em->generation;
>                 btrfs_free_extent_map(em);
>                 em =3D NULL;
> --
> 2.50.1
>
>

