Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64414415BD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 12:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbhIWKPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 06:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbhIWKPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 06:15:50 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B5C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:14:19 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id e5so3556439qvq.7
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=EecNnwGXh7EgC9Q9vCnkjdpy7FrtNxGFCyl5BlEUR1A=;
        b=WPnBhn+x1X1AAIXXEOMLNKIhZE11gca9c5x8jnOqxwOc+XvpfiC6IZvmHLI3NkbJVc
         NlCVxN6fJNwem8BHus0YJvqvqU+WGX/ZOm7Tv7xCPfHlk0kB59Ker5r4nCUT/t1gKW4Y
         C0ABwU6ctzhlO0fhT6qd2j4SQC4aJPe+gbSyy0ws+4l86YfzxUsW0eH659pe552/a+QU
         P+XhRsPAXXSjZvAVOj2tfC9CfnLrS8lKT1q8LugFE+qZHZaGOpBPIA7LgaLsIXj6BUdS
         fwTQR2K3iDrP5J362KUVKHmwuNEOHo/X+3DuXOi8W6Dfhbvr7z5qMdcVELJUPCabKY6H
         /DFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=EecNnwGXh7EgC9Q9vCnkjdpy7FrtNxGFCyl5BlEUR1A=;
        b=305Oiscu0DwmbrdbqCp3Gf1N1miKu2R0ou706oc3bnZpEH+wmmw/lYxMdlU5PYVtaD
         LUZsRYemDtkOoQwzUW16b7bsEHJEgYxL78AlCY6aTB1UmmbkyofZPaWcTkyrmW7diZuM
         1fAdA8FXLGlEHDP/mFxCn5xs8ssNM889zW4ocSn/cnKrvnTN9LKgY9scldYoY6pFSMZe
         A1k3IFNZsCY3CiKoNvh7tGSEK/GrlLJJA7j6lSCvig5ZSuPfK3ZDzviHf5o4S+ZodRvg
         NuxAz6RXylH5RIxzGZqoNXPIIapWqjBTjzvHQNMJimMlO/Nq5iRUQlteafuptiY1bjcN
         WmIQ==
X-Gm-Message-State: AOAM531EtfTixP3gKFgcyZ3r9NV/xHOUZ5iFgJKx6hxGLn0Ru8QMPjiR
        K6n7+a7YUNolU5u3O57KWX2jBnEaTPOQQTaqcIyiIv93TCk=
X-Google-Smtp-Source: ABdhPJyAwtbDptVmhQADMmOFcQfavBQv66GUEe/I+HPNQ62iFwUati9anQBWevoqtck1Gp/RhO5ltbLKC1oFqto7clw=
X-Received: by 2002:ad4:45c3:: with SMTP id v3mr3691738qvt.41.1632392058588;
 Thu, 23 Sep 2021 03:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
In-Reply-To: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Sep 2021 11:13:42 +0100
Message-ID: <CAL3q7H7HKtEpPvAwSpc8prFbwRaWjPUZ+rxDRtHwrBqVFqVDWg@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 22, 2021 at 8:40 PM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>
> Hi,
>
> The problem is as the title states. Relevant logs from `btrfs receive -vv=
v`:
>
>   mkfile o119493905-1537066-0
>   rename o119493905-1537066-0 ->
> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/ou=
t/include/zstd.h
>   utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd1=
11251c/out/include
>   clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd11=
1251c/out/include/zstd.h
> - source=3Dshui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-=
1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> source offset=3D0 offset=3D0 length=3D131072
>   ERROR: failed to clone extents to
> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/ou=
t/include/zstd.h:
> Invalid argument
>
> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6=
.1+zstd.1.5.0/zstd/lib/zstd.h,
> on the receiving end:
>
>   File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1e=
cc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>   Size: 145904 Blocks: 288 IO Block: 4096 regular file
>
> Looks to me the range of clone is within the boundary of the source
> file. Not sure why this failed?
>
> Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
> and btrfs-progs 5.13.1

So, this may or may not be due to the case Darrel ran into recently:

https://lore.kernel.org/linux-btrfs/CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihaw=
H1PgS6TiMchQ@mail.gmail.com/

If you follow the thread, there's a list of steps and things useful
for debugging there.

Also, to really check if you have snapshots with a duplicated
received_uuid, run the following on each filesystem (i.e. sending side
and receiving side):

btrfs subvolume list -puqR <mount point sending side>
btrfs subvolume list -puqR <mount point receiving side>

Finally, what's the exact command you are using to do the incremental
send? Are you passing 1 or more clone roots (-c option), or just -p?

Also, when you 'btrfs receive -vvv', what's the very first line?
It should be something like this:

receiving snapshot mysnap2 uuid=3D3208d767-fa97-3340-b5d5-33f64ba76458,
ctransid=3D7 parent_uuid=3Dd96591a4-7fbf-d44e-a8a8-c46fd1c7380d,
parent_ctransid=3D6

The output of receive -vvv is not enough to take any conclusion yet.
The operation will be invalid if we end up trying to clone from the
same file and root, because source and destination offsets are the
same.
But if it's from a different root and file, or just from a different
root but the same file, then it may or may not be invalid, depending
on the source file size.

One way to help figure that out is to use one of debug patches (for
btrfs-progs) I pasted on that thread, which is also at
https://pastebin.com/raw/9CbN9C0H

Thanks.

>
> --
>
> Regards
> Yuxuan Shui



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
