Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B287E34FDFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 12:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhCaKXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 06:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhCaKWt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 06:22:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777BFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 03:22:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j9so17388725wrx.12
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wRtIAGBLDQNvrMOod6h6223GZ0wCIQUSjaURwJzPRWU=;
        b=T4uoZRxW9JAvlBi2NazJ1r+4tNNaWUYWxrktHIdQoBHRREv8KfnvUdG7pOnvUCBhkT
         pQqs0zM8W8ZwIUhlnAFkzE2y7Maqao/mVrVBuaOjM2oVlpGFaVhwbriSP0MeqbxQOnoJ
         Uouq9f5M9+h2LD8VZNBSRqrwgJQo8/ef+yBSU35xkmVEvIWlVWtxxGpzFWhHa3CoxZZv
         +1XpGFzm11DmzUpgpv9hCmEBwzgNRYG2SiDgijY2X/ehZZehEly09AJerzitDpz19j8r
         73gRko/6twWdshRguM4pAQ9px27whnD1iUKlyfkYXNMJiF2AdPcZRstnwRS/STzGZFOp
         8Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=wRtIAGBLDQNvrMOod6h6223GZ0wCIQUSjaURwJzPRWU=;
        b=t/OBhPyvMg9krhOkTo1DL3Net7Ipu0wpPTL3BBc0DzMv1VE1B8YtM6tVIwb1+itNCy
         JShcZzIdE8F8AU9qkthZwjFgl1qBj+w9DA63xDNmQwUIuncSGPHlIDPO5PgUK7hE8Vec
         E0M5n2HWJxW6261gFNmsjClsCxiQNHov2GNv3lApx0Pt//IXNIjF0/BF4efsfDKmhsbs
         7z7BvnkON80SN7SdNTbLk14618Zns5YeGopCBGtGAhyIlNSN2WV47sr6HDgIQ/zhTFKI
         Hq3HCR+OtCQywvoA7Ndrpb7Sik/Qc9PvLXHkTSFw1sPdyCJXGcbCGgWGfZvEjDqOTlP2
         PfaA==
X-Gm-Message-State: AOAM53311ffYkFYl0A6INDXMnCRI1yXU9npJKQJZSduN8Px6uW6nY469
        RvqlmHmgVKOHNRe1xOwBLlIVSNaU6ijmcefWm6+puPUFzWs=
X-Google-Smtp-Source: ABdhPJy57Om/UjK3ysjOVDJUxDQNB/7R7eNMP1aEfpUtwr2+djMDm1uQwsq31Un4yMiBD2uBz9/C7fIfAY7LNi4hnjs=
X-Received: by 2002:adf:84e6:: with SMTP id 93mr2677233wrg.376.1617186168208;
 Wed, 31 Mar 2021 03:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <CABDFzMi0AXwBaiL-aFW1G5-UMwgTffza5hbr-9MNHWyGfmyDAQ@mail.gmail.com>
 <CAJCQCtRM-MUPTBSmXa=PE-MBWBrLFta2Gx1+AY1Hox5AZBSfxQ@mail.gmail.com>
In-Reply-To: <CAJCQCtRM-MUPTBSmXa=PE-MBWBrLFta2Gx1+AY1Hox5AZBSfxQ@mail.gmail.com>
From:   Thierry Testeur <thierry.testeur@gmail.com>
Date:   Wed, 31 Mar 2021 12:22:37 +0200
Message-ID: <CABDFzMiMVx86TeQ2u3r7L42VxTcz1b4FzLYooko3Xy1drcCJ=A@mail.gmail.com>
Subject: Re: Support demand on Btrfs crashed fs.
To:     Chris Murphy <lists@colorremedies.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

WDC Red with Firmware Version: 80.00A80
Exact, 8 of thems on my array, and have forgotten to disable write cache  :=
/
And all that you decribed is my case.

I understand that it could be a very hard situation for expect an
massive data recovery, even if the datas are still here, the fs
structure is (partially?) crashed.

I don't have a good knowledge on btrfs structure, as i have on some
older FS, like AFS (Amiga file system) and FAT, because with childs, i
have less time to dig it (like others, we all have only 24hours by day
;)
 ).

As like i said, if anyone have encountered a similar crash, or have
any idea, i'm open to every suggestion, as the last tape backup that i
have is 5 years old, and my tape library have crashed when restored it
on a new disk. So i'm really stuck on that.

For futur raid (14Tb WD Gold x3, for the start), i wish to stay on
mdadm/raid5 an Btrfs. (because i don't have enought data on Btrfs
raid, and it seems it could have somes issues)
What is the best practice for max prenvention of this type of
corruption/crash? Snapshot stored on different disk and/or external
backup, <put any idea here>?

This is another question, but i think this time i have to minimize the
risk for this futur partition, and i have to make some diging on
internet on the subjet, but i'm convicted that this place is a far
away better place to ask for some advices thant on forums ;)

Thanks for all your time and share.
Thierry

Le mer. 31 mars 2021 =C3=A0 08:14, Chris Murphy <lists@colorremedies.com> a=
 =C3=A9crit :
>
> I'm going to fill in some details from the multiday conversation with
> IRC regulars. We couldn't figure out a way forward.
>
> * WDC Red with Firmware Version: 80.00A80, which is highly suspected
> to deal with power fail and write caching incorrectly, and at least on
> Btrfs apparently pretty much always drops writes for critical
> metadata.
> * A power fail / reset happened
> * No snapshots
> * --repair and --init-extent-tree  may not have done anything because
> they didn't complete
> * Less than 10% needs to be recovered and it's accepted that it can't
> be repaired. The focus is just on a limited restore, but we can't get
> past the transid failures.
>
>
> zapan@UBUNTU-SERVER:~$ sudo btrfs check --readonly /dev/md0
> Opening filesystem to check...
> parent transid verify failed on 23079040831488 wanted 524940 found 524941
> parent transid verify failed on 23079040831488 wanted 524940 found 524941
> Ignoring transid failure
> parent transid verify failed on 23079040319488 wanted 524931 found 524939
> Ignoring transid failure
> Checking filesystem on /dev/md0
> UUID: f4f04e16-ce38-4a57-8434-67562a0790bd
> [1/7] checking root items
> parent transid verify failed on 23079042863104 wanted 423153 found 524931
> parent transid verify failed on 23079042863104 wanted 423153 found 524931
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D23079040999424 item=3D11 paren=
t
> level=3D2 child bytenr=3D23079042863104 child level=3D0
> ERROR: failed to repair root items: Input/output error
> [2/7] checking extents
> parent transid verify failed on 23079042863104 wanted 423153 found 524931
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D23079040999424 item=3D11 paren=
t
> level=3D2 child bytenr=3D23079042863104 child level=3D0
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> root 5 root dir 256 not found
> parent transid verify failed on 23079042863104 wanted 423153 found 524931
> Ignoring transid failure
> ERROR: child eb corrupted: parent bytenr=3D23079040999424 item=3D11 paren=
t
> level=3D2 child bytenr=3D23079042863104 child level=3D0
> ERROR: errors found in fs roots
> found 0 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 0
> total fs tree bytes: 0
> total extent tree bytes: 0
> btree space waste bytes: 0
> file data blocks allocated: 0
> referenced 0
>
> btrfs-find-root doesn't find many options to work with, and all of
> them fail with 'btrfs restore -t'
>
>
> zapan@UBUNTU-SERVER:~$ sudo btrfs-find-root /dev/md0
> parent transid verify failed on 23079040831488 wanted 524940 found 524941
> parent transid verify failed on 23079040831488 wanted 524940 found 524941
> Ignoring transid failure
> parent transid verify failed on 23079040319488 wanted 524931 found 524939
> Ignoring transid failure
> Superblock thinks the generation is 524941
> Superblock thinks the level is 2
> Found tree root at 23079040999424 gen 524941 level 2
> Well block 23079040327680(gen: 524940 level: 2) seems good, but
> generation/level doesn't match, want gen: 524941 level: 2
> Well block 23079040389120(gen: 524939 level: 2) seems good, but
> generation/level doesn't match, want gen: 524941 level: 2
> zapan@UBUNTU-SERVER:~$ sudo btrfs restore -viD -t 23079040389120
> /dev/md0 /mnt/raid1/restore/
> parent transid verify failed on 23079040389120 wanted 524941 found 524939
> parent transid verify failed on 23079040389120 wanted 524941 found 524939
> Ignoring transid failure
> parent transid verify failed on 23079040323584 wanted 524939 found 524941
> parent transid verify failed on 23079040323584 wanted 524939 found 524941
> Ignoring transid failure
> parent transid verify failed on 23079040319488 wanted 524931 found 524939
> Ignoring transid failure
> This is a dry-run, no files are going to be restored
> Reached the end of the tree searching the directory
> zapan@UBUNTU-SERVER:~$ sudo btrfs restore -viD -t 23079040327680
> /dev/md0 /mnt/raid1/restore/
> parent transid verify failed on 23079040327680 wanted 524941 found 524940
> parent transid verify failed on 23079040327680 wanted 524941 found 524940
> Ignoring transid failure
> parent transid verify failed on 23079040831488 wanted 524940 found 524941
> parent transid verify failed on 23079040831488 wanted 524940 found 524941
> Ignoring transid failure
> parent transid verify failed on 23079040319488 wanted 524931 found 524939
> Ignoring transid failure
> This is a dry-run, no files are going to be restored
> Reached the end of the tree searching the directory
>
>
>
>
>
> --
> Chris Murphy
