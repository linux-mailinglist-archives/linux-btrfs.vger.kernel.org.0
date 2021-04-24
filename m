Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7DB36A2D6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Apr 2021 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhDXTr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Apr 2021 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhDXTrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Apr 2021 15:47:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48826C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 12:47:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so51784370wrr.2
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDT2sQFISLV8tACvU1kgJBr2c/5TnIN3OrNELXfJGLU=;
        b=dI3eZQQm7tbAju+uSFpM/eiubH9QJsBkEhG3t2zBpu/PEs44rIGxsm4Z8OJ5c7e3bH
         dpI4DU121C64Fq5fcBX1SPGHubDlJYiQFYcuJqyh4ltw6P9NwwsCJEasSfqaoz7v6J0N
         CCh77dF25OV23RxbvTyXQ81IKUB7xULhzgWFiqdm7ivZ7Qw42v9y+/R0qE40XKQ8roKN
         zVM9W+DxY7DW1WRdn3sjXQee5hHGfvCcNVYfrAweQ9YwAFE0swXXX8LGOw3RkEemU8JA
         D6JT6lMw4SQJpy+DtVsymZU0KznXRUiZuVdi2vn8u87F32ODaq789ane5pZcoQrB1QyF
         vumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDT2sQFISLV8tACvU1kgJBr2c/5TnIN3OrNELXfJGLU=;
        b=W4Ol6zvVtwbdryPTLKTTkxdbocwMM6N3QZgBTkNxPRrlIPeWyMVvwIedDRvzXBfejr
         AMlzcNPkwoJ7QUSwXwgTFj2mkHayB4w5/7Sg5yjIWX+fHOcCUABGsmfK+QLp1bm7gLN+
         6twwiL0HericJ7a7tAd2Od7F0/pLoHDhmX3+M7Jk/P3siSzkensTisen6vxCMCaz66fd
         Wtn9UWFgHOkxTBLA9ehXCtdSWwVVWPMsBVmkrH6u+34+Lx1eOaYPEEQKaYkxPR9gNoxs
         YkKJwaX4xVinKfuZZiYFxHlVrzPrvN1rZoenNN9BhzLy8Z6ljXzq3Twp2xISiuqR0WDI
         quzw==
X-Gm-Message-State: AOAM533B76u+T4SJGArOcRGjg1W2l+W/Lua4czPgoBiPCNZSTx1OY1YJ
        gv6ezutMsAUirr0rUh4kReISiWv1vQvTcMVjRJJ9KA==
X-Google-Smtp-Source: ABdhPJylWt3EME19umLV6JkTIqCjfS8hN82KVSj//m3ljsO+a//Vlw3Mjx5k0eXZRqwWEZqEd7RyMgQDZVQdS+Amj+Q=
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr12576923wrc.236.1619293631863;
 Sat, 24 Apr 2021 12:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <9ca589ec-26b1-1b92-fe4a-af9006e516c6@gmail.com>
In-Reply-To: <9ca589ec-26b1-1b92-fe4a-af9006e516c6@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 24 Apr 2021 13:46:55 -0600
Message-ID: <CAJCQCtT6iNwN20uHjv4FPs--6_j34XpmD=6M+_Jkt7AiBcvMag@mail.gmail.com>
Subject: Re: Restoring a file from damaged btrfs raid1 shard
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 21, 2021 at 9:24 PM Konstantin Svist <fry.kun@gmail.com> wrote:
>
> Hi,
>
> I have a drive which I replaced from a raid1 pair (caused a lot of
> command timeouts).
>
> Before I pulled it, I forgot to check if there are any files not
> properly stored in the other copy.
>
> The file is quite old, so the recent changes on the partition don't matter
>
>
> #uname -a
>
> Linux xx 5.11.12-200.fc33.x86_64 #1 SMP Thu Apr 8 02:34:17 UTC 2021
> x86_64 x86_64 x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.10
>
> # mount -oro,degraded /dev/sdb3  /mnt/
> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdb3,
> missing codepage or helper program, or other error.
>
> Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): allowing degraded
> mounts
> Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): disk space caching
> is enabled
> Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): has skinny extents
> Apr 21 20:21:11 xx kernel: BTRFS warning (device sdb3): devid 3 uuid
> 8c5ca74b-83fd-4625-92f0-ec14ef64b0a8 is missing
> Apr 21 20:21:11 xx kernel: BTRFS warning (device sdb3): devid 4 uuid
> ff2c7128-b213-402f-a487-fb070ab8e902 is missing

raid1 means two copies, no matter how many drives. Since two devices
are missing, the file system can't be mounted. There might be enough
metadata remaining for 'btrfs restore' to scrape the files you want
off the drive, but it may be a long shot. It really just depends on
what device the file and file metadata are on, and whether the
remaining devices have enough of both to allow a recovery.

https://btrfs.wiki.kernel.org/index.php/Restore


> Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): bdev /dev/sdb3
> errs: wr 189563, rd 4799, flush 0, corrupt 2389, gen 0
> Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): bdev (efault) errs:
> wr 0, rd 0, flush 0, corrupt 35, gen 0
> Apr 21 20:21:11 xx kernel: BTRFS info (device sdb3): bdev (efault) errs:
> wr 348, rd 0, flush 0, corrupt 0, gen 0
> Apr 21 20:21:11 xx kernel: BTRFS error (device sdb3): parent transid
> verify failed on 4883446087680 wanted 5857871 found 5852153
> Apr 21 20:21:11 xx kernel: BTRFS error (device sdb3): failed to read
> block groups: -5
> Apr 21 20:21:11 xx kernel: BTRFS error (device sdb3): open_ctree failed
>
> # btrfs fi show /dev/sdb3
> warning, device 3 is missing
> warning, device 3 is missing
> parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
> parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
> Ignoring transid failure
> leaf parent key incorrect 4883446087680
> ERROR: failed to read block groups: Operation not permitted
> Label: none  uuid: fef6d003-b7a5-4e9e-9875-5774052ce2ed
>     Total devices 3 FS bytes used 614.46GiB
>     devid    1 size 929.51GiB used 666.03GiB path /dev/sdb3
>     *** Some devices missing
>
>
> # btrfs-find-root /dev/sdb3
> warning, device 3 is missing
> warning, device 3 is missing
> parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
> parent transid verify failed on 4883446087680 wanted 5857871 found 5852153
> Ignoring transid failure
> leaf parent key incorrect 4883446087680
> ERROR: failed to read block groups: Operation not permitted

Sounds to me like system chunk may not be on any of the remaining
drives. This is critical to being able to translate logical addresses
to physical mapping, in order for either mount or restore to work.


> Superblock thinks the generation is 5857883
> Superblock thinks the level is 1
> Found tree root at 4883439714304 gen 5857883 level 1
> Well block 4883437158400(gen: 5857882 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883434635264(gen: 5857881 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883426295808(gen: 5857880 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883417972736(gen: 5857879 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883409846272(gen: 5857878 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883352633344(gen: 5857877 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883347685376(gen: 5857876 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883343622144(gen: 5857875 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883438944256(gen: 5857870 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883439239168(gen: 5857869 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883377176576(gen: 5857824 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883357188096(gen: 5857788 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883340165120(gen: 5857732 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883371884544(gen: 5857731 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883361087488(gen: 5857730 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883380404224(gen: 5857729 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883374358528(gen: 5857727 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883342721024(gen: 5857718 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883398656000(gen: 5857713 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883346784256(gen: 5857706 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883409584128(gen: 5857704 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883436666880(gen: 5857439 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883436650496(gen: 5857439 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883436290048(gen: 5857439 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883436126208(gen: 5857439 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883387858944(gen: 5857438 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883371753472(gen: 5857437 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883428802560(gen: 5855304 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883428786176(gen: 5855304 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883411075072(gen: 5855303 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883411042304(gen: 5855299 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883388497920(gen: 5855299 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883428999168(gen: 5855293 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883431686144(gen: 5855262 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883417563136(gen: 5855256 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883416678400(gen: 5855256 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883408601088(gen: 5855254 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883394183168(gen: 5855253 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883394166784(gen: 5855253 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883388792832(gen: 5855253 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883431817216(gen: 5852142 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883373441024(gen: 5852073 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883366723584(gen: 5852070 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883363430400(gen: 5778963 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883363758080(gen: 5778927 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883363627008(gen: 5775596 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883363594240(gen: 5775596 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883361841152(gen: 5775596 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883362332672(gen: 5772011 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883362217984(gen: 5772011 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883362168832(gen: 5772011 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883357614080(gen: 5742160 level: 0) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
> Well block 4883344556032(gen: 5701778 level: 1) seems good, but
> generation/level doesn't match, want gen: 5857883 level: 1
>

You can try plugging these larger block values in, starting at the top
(most recent) into 'btrfs restore -iv -D -t $BLOCKNUM' and see if
it'll work.


-- 
Chris Murphy
