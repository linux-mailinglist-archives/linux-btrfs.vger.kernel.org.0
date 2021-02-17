Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7A631D7C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 12:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhBQLAo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 06:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBQLAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 06:00:17 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3FC061756
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:59:36 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id w19so12213212qki.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 02:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=E+6t3PC6yhuezdOV+3xxhvWtoUnvchcJZ/CQEHoVwl8=;
        b=GakB00K/7PbTRq7xN0WZPfANXxDOUIAm82MlqIQ7vaWi+M5LbQ5EZkXtAc7YFw2nSe
         CEJcCAwWdGM0cAbEuLb0guCgrE3ToeH93glbspzvrIFVz9Flt+aKvhJ+xf7BBpvEu+Dd
         84B0E7TxF5wqFUa49oThhDpV9KAu64XHIOzQh0e7LR4MIfqhfHFGyBcyWk3ykGVS6cgr
         VgEgTSm4UNGcBN3r/8OtaJ9U7pZDOFiaGDAmZhF+rupkY5DP08Q2gs1ZEPPXXnRaPzXM
         zQ7IJny9MRKtrJT64O+vChGQ3N5QAmXq3fFTqtJhm7jEEFSUKoHO8zuIMKngJcNggVrM
         9/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=E+6t3PC6yhuezdOV+3xxhvWtoUnvchcJZ/CQEHoVwl8=;
        b=lgKCdsi5Tn5XnoKE+ofPjr12YaYT96eVa99I4gAPFROijyPw8C+jDquOY6oeagjcMM
         3JKQYJYNyXOrE05Z/P3kLH/KQZ2RP6+/Ks48oU4otabo6j9tf/n6GyPVWcBChBLKRD/S
         v3sEXCUSjFwoufL3ZZL1vaDdFTeuydr3jWitiKiXigCTFK+ikmheypbqBHazPqexOumk
         8PqWTiEKxTPmW42x7NBLjKu7gz4s1wmv0FhMegRPwLALdQwAPb9MiMzz6xqBMjMbmvtx
         NedNV2uGmQ3OIyGNHE19oK17pD+UKJ0fAL00ir/sH2+OcQ3FYFBsSOLWqQOnzRSrA1i9
         P9Zw==
X-Gm-Message-State: AOAM533sf34BTDqJYGb69w2FeYM7DnpkuebTN6TaanNjO0iolvDiGLyM
        w/xHF1yUMlMNfyOER+lNNb2RrznU5swJiN67e7tjmulaLLJ19A==
X-Google-Smtp-Source: ABdhPJwKAPikojZthFwQgS0C4X4Mm/llYthQyjcQOzzyZ9SiSsX/D4Gvrl1WbiUpFxpZeqpEwLSr4JkkJ855Im16T28=
X-Received: by 2002:a05:620a:118e:: with SMTP id b14mr24478513qkk.438.1613559575918;
 Wed, 17 Feb 2021 02:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20200624115527.855816-1-wqu@suse.com> <CAL3q7H5sgq_vXpP5rB+bBOBNqaq1+AszGLZvfdgdMLDruQZ4_w@mail.gmail.com>
 <5ba8b5d2-d76b-835d-31c0-80f700104230@gmx.com>
In-Reply-To: <5ba8b5d2-d76b-835d-31c0-80f700104230@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 17 Feb 2021 10:59:24 +0000
Message-ID: <CAL3q7H5SGQTrozDERvhkdoZ5yh7zoHYmT+1JfP4s_bWL2Tx_DA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Ensure the data chunks size
 never exceed device size
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Jiachen YANG <farseerfc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 11:42 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/2/16 =E4=B8=8B=E5=8D=8810:45, Filipe Manana wrote:
> > On Wed, Jun 24, 2020 at 10:00 PM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> The following script could lead to corrupted btrfs fs after
> >> btrfs-convert:
> >>
> >>    fallocate -l 1G test.img
> >>    mkfs.ext4 test.img
> >>    mount test.img $mnt
> >>    fallocate -l 200m $mnt/file1
> >>    fallocate -l 200m $mnt/file2
> >>    fallocate -l 200m $mnt/file3
> >>    fallocate -l 200m $mnt/file4
> >>    fallocate -l 205m $mnt/file1
> >>    fallocate -l 205m $mnt/file2
> >>    fallocate -l 205m $mnt/file3
> >>    fallocate -l 205m $mnt/file4
> >>    umount $mnt
> >>    btrfs-convert test.img
> >>
> >> The result btrfs will have a device extent beyond its boundary:
> >>    pening filesystem to check...
> >>    Checking filesystem on test.img
> >>    UUID: bbcd7399-fd5b-41a7-81ae-d48bc6935e43
> >>    [1/7] checking root items
> >>    [2/7] checking extents
> >>    ERROR: dev extent devid 1 physical offset 993198080 len 85786624 is=
 beyond device boundary 1073741824
> >>    ERROR: errors found in extent allocation tree or chunk allocation
> >>    [3/7] checking free space cache
> >>    [4/7] checking fs roots
> >>    [5/7] checking only csums items (without verifying data)
> >>    [6/7] checking root refs
> >>    [7/7] checking quota groups skipped (not enabled on this FS)
> >>    found 913960960 bytes used, error(s) found
> >>    total csum bytes: 891500
> >>    total tree bytes: 1064960
> >>    total fs tree bytes: 49152
> >>    total extent tree bytes: 16384
> >>    btree space waste bytes: 144885
> >>    file data blocks allocated: 2129063936
> >>     referenced 1772728320
> >>
> >> [CAUSE]
> >> Btrfs-convert first collect all used blocks in the original fs, then
> >> slightly enlarge the used blocks range as new btrfs data chunks.
> >>
> >> However the enlarge part has a problem, that it doesn't take the devic=
e
> >> boundary into consideration.
> >>
> >> Thus it caused device extents and data chunks to go beyond device
> >> boundary.
> >>
> >> [FIX]
> >> Just to extra check before inserting data chunks into
> >> btrfs_convert_context::data_chunk.
> >>
> >> Reported-by: Jiachen YANG <farseerfc@gmail.com>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > So, having upgraded a test box from btrfs-progs v5.6.1 to v5.10.1, I
> > now have btrfs/136 (fstests) failing:
> >
> > $ ./check btrfs/136
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 debian8 5.11.0-rc7-btrfs-next-81 #1 SMP
> > PREEMPT Tue Feb 16 12:29:07 WET 2021
> > MKFS_OPTIONS  -- /dev/sdc
> > MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> >
> > btrfs/136 7s ... [failed, exit status 1]- output mismatch (see
> > /home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad)
> >      --- tests/btrfs/136.out 2020-06-10 19:29:03.818519162 +0100
> >      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad
> > 2021-02-16 14:31:30.669559188 +0000
> >      @@ -1,2 +1,3 @@
> >       QA output created by 136
> >      -Silence is golden
> >      +btrfs-convert failed
> >      +(see /home/fdmanana/git/hub/xfstests/results//btrfs/136.full for =
details)
> >      ...
> >      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/136.out
> > /home/fdmanana/git/hub/xfstests/results//btrfs/136.out.bad'  to see
> > the entire diff)
> > Ran: btrfs/136
> > Failures: btrfs/136
> > Failed 1 of 1 tests
> >
> > A bisect pointed to this patch.
> > Did you get this failure on your test box as well?
>
> Nope.
>
> Just tested with btrfs-progs v5.10.1, it passes:
>   $ which btrfs
>   /usr/bin/btrfs
>   $ btrfs --version
>   btrfs-progs v5.10.1
>   $ sudo ./check btrfs/136
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 btrfs-desktop-vm 5.11.0-rc4-custom+ #4
> SMP PREEMPT Mon Jan 25 18:35:22 CST 2021
>   MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>   MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>
>   btrfs/136 6s ...  10s
>   Ran: btrfs/136
>   Passed all 1 tests
>
> Would you mind to provide the 136.full to help debugging the failure?

Sure, here it is (also at https://pastebin.com/XhEX2dju):

root 10:06:39 /home/fdmanana/git/hub/xfstests (master)> cat
/home/fdmanana/git/hub/xfstests/results//btrfs/136.full
mke2fs 1.45.6 (20-Mar-2020)
Discarding device blocks: done
Creating filesystem with 5242880 4k blocks and 1310720 inodes
Filesystem UUID: 9519afc8-8ea0-42da-8ac5-3b4c20469dd1
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
4096000

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

Run fsstress -p 20 -n 100 -d
/home/fdmanana/btrfs-tests/scratch_1/ext3_ext4_data/ext3
tune2fs 1.45.6 (20-Mar-2020)
e2fsck 1.45.6 (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 3A: Optimizing directories
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/sdc: ***** FILE SYSTEM WAS MODIFIED *****
/dev/sdc: 235/1310720 files (22.1% non-contiguous), 129757/5242880 blocks
Run fsstress -p 20 -n 100 -d
/home/fdmanana/btrfs-tests/scratch_1/ext3_ext4_data/ext4
ERROR: missing data block for bytenr 1048576
ERROR: failed to create ext2_saved/image: -2
WARNING: an error occurred during conversion, filesystem is partially
created but not finalized and not mountable
create btrfs filesystem:
blocksize: 4096
nodesize: 16384
features: extref, skinny-metadata (default)
checksum: crc32c
creating ext2 image file
btrfs-convert failed
root 10:14:18 /home/fdmanana/git/hub/xfstests (master)>


Thanks


>
> Thanks,
> Qu
> >
> > Thanks.
> >
> >> ---
> >>   convert/main.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/convert/main.c b/convert/main.c
> >> index c86ddd988c63..7709e9a6c085 100644
> >> --- a/convert/main.c
> >> +++ b/convert/main.c
> >> @@ -669,6 +669,8 @@ static int calculate_available_space(struct btrfs_=
convert_context *cctx)
> >>                          cur_off =3D cache->start;
> >>                  cur_len =3D max(cache->start + cache->size - cur_off,
> >>                                min_stripe_size);
> >> +               /* data chunks should never exceed device boundary */
> >> +               cur_len =3D min(cctx->total_bytes - cur_off, cur_len);
> >>                  ret =3D add_merge_cache_extent(data_chunks, cur_off, =
cur_len);
> >>                  if (ret < 0)
> >>                          goto out;
> >> --
> >> 2.27.0
> >>
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
