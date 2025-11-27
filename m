Return-Path: <linux-btrfs+bounces-19383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F4C8FE98
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 19:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5278034279E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B6301473;
	Thu, 27 Nov 2025 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1Yhzgrf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D6C2FFFBC
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267784; cv=none; b=AyOYoPfw6wQwGuoYQ+Evy0euWAYAb6zB/V535ESBLtK8Lhnw7kqFQlAoh/n+YeOeb2y6QInRSbk3gu3gmYP3gX6EXvoEQJ8YPzIzpG+dTVD9XXwEXmg5YfZ9HHmzLx7sXVbgfZKeencTVtXpfSPIygGUV1aDHwpuAnY9QQ0p8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267784; c=relaxed/simple;
	bh=LbC9a5JiNlruuM0SQ0TahVfOyb1DvJGOtYpOJOkHNoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siMyaVgi/AnlcmOvILnwioQpJwHT3MHRO8CXv2Sju55makmKl2fV8L06kbF/Q3mNsYyYNryzDjHF6jmjg0UUvVlhoKdEFPqODL/mQuUU+1VIfl7UiX3pya/CpdwoNtj9nRHj4rVPWvYF7UM72DV2wkjyp/IKZlgL1a6nxklUOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1Yhzgrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661E8C4AF09
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 18:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764267784;
	bh=LbC9a5JiNlruuM0SQ0TahVfOyb1DvJGOtYpOJOkHNoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u1Yhzgrf7Y/i7ddpHbDcVF7iems3V1UTs3qBgn7u7uys55oq2+qHLBQNkR3f3A/eu
	 ZEjBY5nV1tFL4UbAaz4/przJMhXISNTkP2/aYDPqiIsWZcBmandV8CQvD84P6oQ74E
	 oW+fnZvF5fuY9XGw4mytGk3hxWYLf90CXTxdkd17aYBHVfVZuiYa0uP88Cy4gO4BQ8
	 IyZ8iejs+cKWPuu/RzT7MLuxBybuAMlPDdy7PmdaNjU8f2hy2fxTG5keS70FiM2dGp
	 FKZRL1V3ZTDXclK0Ch1z6HMIVX7g/ECK2ZC4PHPBvLkOyT68z78fzUASfoH+HYXxS6
	 Bv9GleCNIi4og==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7373fba6d1so171802466b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 10:23:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEU6wqndMkpM1FxdH34HzOHiN1TGeFNcuROX3dsj+CiEpJLBoef+G7rNev7qINloX4usrlFhASiJhwNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNqSLeuHFwiWTcR9al364PRsZu1p+rM2tLhxbNQspVu4bOOD4
	qcfD4m9ZR2VG2RcjhLWgNwse57qJrwB+2zvuZmnMot0f+erxIiHV9rDEjgdFJAWS9wn8uy88GDQ
	WLeeOJm7MxyLKDcMaxdiFprgsImIk5+4=
X-Google-Smtp-Source: AGHT+IEjcg9MJro+W1ptH5dDySrjjZP2GMc54RLEAwc3ZgNBfBqBB0XOQAGdqr+do20dDw4mkxPS8Phi9HtKEjiXX/k=
X-Received: by 2002:a17:907:3faa:b0:b73:21db:64aa with SMTP id
 a640c23a62f3a-b7671a46900mr2640701466b.38.1764267782951; Thu, 27 Nov 2025
 10:23:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7bbc9419-5c56-450a-b5a0-efeae7457113@gmail.com>
In-Reply-To: <7bbc9419-5c56-450a-b5a0-efeae7457113@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 27 Nov 2025 18:22:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4FG+knhfYfN-wBPOzzoa1_FOLTJ3xzPXf8ZvhFPWozOA@mail.gmail.com>
X-Gm-Features: AWmQ_bnI3AGZibVk-2e802OG1aH_s6luFHIzeFnvzg3i2BYrg1ptWo7ENTj26Yk
Message-ID: <CAL3q7H4FG+knhfYfN-wBPOzzoa1_FOLTJ3xzPXf8ZvhFPWozOA@mail.gmail.com>
Subject: Re: File system corruption after renaming directory and creating a
 new file with same name if system crashes
To: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:58=E2=80=AFPM Vyacheslav Kovalevsky
<slava.kovalevskiy.2014@gmail.com> wrote:
>
> File system becomes corrupted after renaming directory, creating and
> syncing a new file with the same name if system crashes.
>
>
> Detailed description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hello, we have found another issue with btrfs crash behavior.
>
> In short, two directories are created and synced. Then, first directory
> is renamed as subdirectory of the second directory. A new file is
> created with name that was previously associated with the first
> directory. The file is fsync'ed and moved under the renamed directory
> and fsync'ed again.

It doesn't need to be under the renamed directory, it can be any directory.

> After a crash, file system cannot be mounted,
> reporting block corruption.
>
> It seems that the directory entry becomes corrupted when the `nlink`

Not the directory entry but the directory inode.

Fix sent a few minutes ago:

https://lore.kernel.org/linux-btrfs/973df1035d967979681ed741f074e5db90aa4f7=
0.1764264662.git.fdmanana@suse.com/

Thanks.

> value is erroneously set to 2, somehow.
>
>
> System info
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Linux version 6.18.0-rc7, also tested on 6.18.0-rc2 and 6.14.11.
>
>
> How to reproduce
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Test:
>
> ```
> #include <errno.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> int main() {
>    int status;
>    int file_fd;
>
>    status =3D mkdir("dir1", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>    printf("MKDIR: %d\n", status);
>
>    status =3D mkdir("dir2", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
>    printf("MKDIR: %d\n", status);
>
>    sync();
>
>    status =3D rename("dir1", "dir2/dir3");
>    printf("RENAME: %d\n", status);
>
>    // create regular file with the name directory had before rename
>    status =3D open("dir1", O_RDWR | O_CREAT);
>    printf("OPEN: %d\n", status);
>    file_fd =3D status;
>
>    status =3D fsync(file_fd);
>    printf("FSYNC: %d\n", status);
>
>    status =3D rename("dir1", "dir2/dir3/not-dir");
>    printf("RENAME: %d\n", status);
>
>    status =3D fsync(file_fd);
>    printf("FSYNC: %d\n", status);
> }
> ```
>
> dmesg:
>
> ```
> [ 17.559361] BTRFS: device fsid 17a75b88-e58e-457d-83db-ea6599920bc7
> devid 1 transid 9 /dev/vdb (253:16) scanned by mount (1095)
> [ 17.559676] BTRFS info (device vdb): first mount of filesystem
> 17a75b88-e58e-457d-83db-ea6599920bc7
> [ 17.559690] BTRFS info (device vdb): using crc32c (crc32c-lib) checksum
> algorithm
> [ 17.562785] BTRFS info (device vdb): start tree-log replay
> [ 17.563301] page: refcount:2 mapcount:0 mapping:0000000077ae2817
> index:0x1d00 pfn:0x1057ac
> [ 17.563305] memcg:ffff89a500340000
> [ 17.563307] aops:btree_aops ino:1
> [ 17.563311] flags:
> 0x17ffffc800402a(uptodate|lru|private|writeback|node=3D0|zone=3D2|lastcpu=
pid=3D0x1fffff)
> [ 17.563315] raw: 0017ffffc800402a fffff9aa84135708 fffff9aa84073d88
> ffff89a51cb23a90
> [ 17.563318] raw: 0000000000001d00 ffff89a502951b40 00000002ffffffff
> ffff89a500340000
> [ 17.563319] page dumped because: eb page dump
> [ 17.563320] BTRFS critical (device vdb): corrupt leaf: root=3D5
> block=3D30408704 slot=3D6 ino=3D257, invalid nlink: has 2 expect no more =
than
> 1 for dir
> [ 17.564768] BTRFS info (device vdb): leaf 30408704 gen 10 total ptrs 17
> free space 14869 owner 5
> [ 17.564772] item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
> [ 17.564775] inode generation 3 transid 9 size 16 nbytes 16384
> [ 17.564776] block group 0 mode 40755 links 1 uid 0 gid 0
> [ 17.564778] rdev 0 sequence 2 flags 0x0
> [ 17.564779] atime 1764249615.0
> [ 17.564781] ctime 1764249645.130028300
> [ 17.564782] mtime 1764249645.130028300
> [ 17.564784] otime 1764249615.0
> [ 17.564785] item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
> [ 17.564787] index 0 name_len 2
> [ 17.564789] item 2 key (256 DIR_ITEM 2363071922) itemoff 16077 itemsize =
34
> [ 17.564791] location key (257 1 0) type 2
> [ 17.564792] transid 9 data_len 0 name_len 4
> [ 17.564794] item 3 key (256 DIR_ITEM 2676584006) itemoff 16043 itemsize =
34
> [ 17.564795] location key (258 1 0) type 2
> [ 17.564797] transid 9 data_len 0 name_len 4
> [ 17.564798] item 4 key (256 DIR_INDEX 2) itemoff 16009 itemsize 34
> [ 17.564800] location key (257 1 0) type 2
> [ 17.564801] transid 9 data_len 0 name_len 4
> [ 17.564803] item 5 key (256 DIR_INDEX 3) itemoff 15975 itemsize 34
> [ 17.564805] location key (258 1 0) type 2
> [ 17.564806] transid 9 data_len 0 name_len 4
> [ 17.564807] item 6 key (257 INODE_ITEM 0) itemoff 15815 itemsize 160
> [ 17.564809] inode generation 9 transid 10 size 14 nbytes 0
> [ 17.564811] block group 0 mode 40755 links 2 uid 0 gid 0
> [ 17.564812] rdev 0 sequence 1 flags 0x0
> [ 17.564813] atime 1764249645.130028300
> [ 17.564815] ctime 1764249645.130028300
> [ 17.564816] mtime 1764249645.130028300
> [ 17.564818] otime 1764249645.130028300
> [ 17.564819] item 7 key (257 INODE_REF 256) itemoff 15801 itemsize 14
> [ 17.564821] index 2 name_len 4
> [ 17.564822] item 8 key (257 INODE_REF 258) itemoff 15787 itemsize 14
> [ 17.564824] index 2 name_len 4
> [ 17.564825] item 9 key (257 DIR_ITEM 3753155587) itemoff 15750 itemsize =
37
> [ 17.564827] location key (259 1 0) type 1
> [ 17.564828] transid 10 data_len 0 name_len 7
> [ 17.564830] item 10 key (257 DIR_INDEX 2) itemoff 15713 itemsize 37
> [ 17.564831] location key (259 1 0) type 1
> [ 17.564833] transid 10 data_len 0 name_len 7
> [ 17.564834] item 11 key (258 INODE_ITEM 0) itemoff 15553 itemsize 160
> [ 17.564836] inode generation 9 transid 10 size 8 nbytes 0
> [ 17.564837] block group 0 mode 40755 links 1 uid 0 gid 0
> [ 17.564839] rdev 0 sequence 1 flags 0x0
> [ 17.564840] atime 1764249645.130028300
> [ 17.564842] ctime 1764249645.130028300
> [ 17.564843] mtime 1764249645.130028300
> [ 17.564844] otime 1764249645.130028300
> [ 17.564846] item 12 key (258 INODE_REF 256) itemoff 15539 itemsize 14
> [ 17.564847] index 3 name_len 4
> [ 17.564849] item 13 key (258 DIR_ITEM 1843588421) itemoff 15505 itemsize=
 34
> [ 17.564851] location key (257 1 0) type 2
> [ 17.564852] transid 10 data_len 0 name_len 4
> [ 17.564853] item 14 key (258 DIR_INDEX 2) itemoff 15471 itemsize 34
> [ 17.564855] location key (257 1 0) type 2
> [ 17.564856] transid 10 data_len 0 name_len 4
> [ 17.564858] item 15 key (259 INODE_ITEM 0) itemoff 15311 itemsize 160
> [ 17.564860] inode generation 10 transid 10 size 0 nbytes 0
> [ 17.564861] block group 0 mode 100000 links 1 uid 0 gid 0
> [ 17.564863] rdev 0 sequence 2 flags 0x0
> [ 17.564864] atime 1764249645.139028211
> [ 17.564865] ctime 1764249645.140028202
> [ 17.564867] mtime 1764249645.139028211
> [ 17.564868] otime 1764249645.139028211
> [ 17.564869] item 16 key (259 INODE_REF 257) itemoff 15294 itemsize 17
> [ 17.564870] index 2 name_len 7
> [ 17.564872] BTRFS error (device vdb): block=3D30408704 write time tree
> block corruption detected
> [ 17.566147] BTRFS: error (device vdb) in btrfs_commit_transaction:2535:
> errno=3D-5 IO failure (Error while writing out transaction)
> [ 17.567374] BTRFS warning (device vdb state E): Skipping commit of
> aborted transaction.
> [ 17.567377] BTRFS error (device vdb state EA): Transaction aborted
> (error -5)
> [ 17.568502] BTRFS: error (device vdb state EA) in
> cleanup_transaction:2020: errno=3D-5 IO failure
> [ 17.569956] BTRFS: error (device vdb state EA) in
> btrfs_replay_log:2093: errno=3D-5 IO failure (Failed to recover log tree)
> [ 17.571778] BTRFS error (device vdb state EA): open_ctree failed: -5
> ```
>
> Steps:
> 1. Create and mount new btrfs file system in default configuration.
> 2. Change directory to root of the file system and run the compiled test.
> 3. Cause hard system crash (e.g. QEMU `system_reset` command).
> 4. Remount file system after crash.
> 5. Observe that mount fails.
>
> Notes:
>
> - if path in open() is changed to any other name (instead of `dir1`) the
> bug will not manifest.
>
>

