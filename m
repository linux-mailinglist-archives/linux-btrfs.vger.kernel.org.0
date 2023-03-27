Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617D76CABAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjC0RPK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0RPJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 13:15:09 -0400
Received: from mta-p6.oit.umn.edu (mta-p6.oit.umn.edu [134.84.196.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34A630C4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 10:15:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4PlfZg24wBz9xgkn
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 17:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OFVc5wqnNWnk for <linux-btrfs@vger.kernel.org>;
        Mon, 27 Mar 2023 12:15:07 -0500 (CDT)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4PlfZg02N8z9xgkl
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 12:15:06 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4PlfZg02N8z9xgkl
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4PlfZg02N8z9xgkl
Received: by mail-pl1-f199.google.com with SMTP id e5-20020a17090301c500b001a1aa687e4bso6160245plh.17
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1679937306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tVXOJsxLWotnZZGqDcLDtvuB7AhtoazmLj3Fq/GvM8=;
        b=YHYaaUsfe3YZQaZ9mk+t+3ZdawT5ZKkyjhPVLu6v5pF8hYZfIIxZKt0pVtutLZtkDe
         hNc9U8JxbKBJcvLYqRbrAeKUQ51Ex3ImciQW0gULuIY++R3p3ytGQ/O+wrW88APPK4Nu
         i7qXKKZBqR61FLA+oUtFHHfcPkKalbO2JZKnzfRWw6HWJl0v5+sncEIlnZU5vEBwPj5n
         3u9eln/0LkYlsoBLwc9H2Gzlmphrs9IS8FFLuHk+J35Pz1wpmcWxKGpfYBA9HlIjVeJ5
         l80NQ0kSN5L0kC1iEX8ojRYRGJRy1fzJU9tNW6bLIGBDC+X+xeFlhOfdgxmbmadVUGMX
         qAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tVXOJsxLWotnZZGqDcLDtvuB7AhtoazmLj3Fq/GvM8=;
        b=hE0Y6ZSK/ZF08h7bcJkwYC55zUG1SrIDjbrASyb1EBzFc0Y5gGMpvhAxv7IU8COkVg
         Q/beNgKgEqy/DAeww7uhvRDhqa0Hfbiwq1Wdc0O7WhVktz96TBUp+b4V0egGQWcxRq+u
         XjdQczJ7UP+vE/R+h6WcVPEGWEoxfKBiWE57EooH5PIsLUvaRlOlQsic+lPvynyXRwhL
         +I714mhPaCfextVG3OmLcCaS8voKJOThdVGZ6WinXtQxAaYceevocsvE2MsiuRPWioig
         X8m+f7hlXcwjYPcEPbVUgb4NUwBr7iOvR9xHzxkpi4XVa3RGCnflHs2s+Bzuiy6Da0ce
         fc9w==
X-Gm-Message-State: AAQBX9c3mUV40iEvaryhQIbbg6qQomdC9Zn2h3vxKvyQ9pkdSjmSlWh6
        7CpkFzA50t33E34PGG28X48GU8BGbYSlWGO5GKpDMkrLNeRMrcBHDuyfGs1xSe6PhvLFFIg05vI
        v3vlYbdOYaUIfnhaoV5O2qxfRzhRo3Jg1IVX+Kha2M9M=
X-Received: by 2002:a05:6a00:1a0b:b0:625:4ff8:3505 with SMTP id g11-20020a056a001a0b00b006254ff83505mr6769155pfv.1.1679937306199;
        Mon, 27 Mar 2023 10:15:06 -0700 (PDT)
X-Google-Smtp-Source: AK7set8NTIcwNU0vVDmROc2tDjXsbTUXPIhqhwwc3JRHvMOpBw6661P+xGIIRMgh7I9pnQnGjNuaXqACZEyqgor/L4w=
X-Received: by 2002:a05:6a00:1a0b:b0:625:4ff8:3505 with SMTP id
 g11-20020a056a001a0b00b006254ff83505mr6769141pfv.1.1679937305832; Mon, 27 Mar
 2023 10:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLfK3VnoHksj2J-r-r360yJ6T6Dd1LX2iTNJ9njmmfttvc8bg@mail.gmail.com>
 <0cf5a777-53b5-7f49-05ae-3fa732689154@gmail.com>
In-Reply-To: <0cf5a777-53b5-7f49-05ae-3fa732689154@gmail.com>
From:   Matt Zagrabelny <mzagrabe@d.umn.edu>
Date:   Mon, 27 Mar 2023 12:14:23 -0500
Message-ID: <CAOLfK3UHnS7o1dBqgJi0bPbsebtvrY8K62LbcjRhXGagRW80_g@mail.gmail.com>
Subject: Re: help with mounting subvolumes
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Andrei!


On Fri, Mar 24, 2023 at 12:59=E2=80=AFPM Andrei Borzenkov <arvidjaar@gmail.=
com> wrote:
>
> On 24.03.2023 20:20, Matt Zagrabelny wrote:
> > Greetings,
> >
> > I do not use subvolumes (yet). I've searched the internet for some
> > tutorials on mounting subvolumes, but the documentation seems lacking.
> >
> > So far, I've tried...
> >
> > # btrfs subvolume create /foo
> > # mount -t btrfs -o subvol=3Dfoo,defaults,nodatacow
> > /dev/disk/by-uuid/5f33a159-4475-44e5-a5f8-40a23e18983a /mntfoo
> > mount: /mntfoo: mount(2) system call failed: No such file or directory.
> >         dmesg(1) may have more information after failed mount system ca=
ll.
> >
> > However /mntfoo exists:
> >
>
> It does not say "mount point does not exist".
>
> Argument of subvol=3D option must be full path from the top level
> directory. You root filesystem most likely is already located in one of
> btrfs subvolumes, so subvolume foo is inside other subvolume and you
> need to provide full path.
>
> tw:/home/bor # mount /dev/vda2 -o subvol=3Dfoo /tmp/foo
> mount: /tmp/foo: mount(2) system call failed: No such file or directory.
>         dmesg(1) may have more information after failed mount system call=
.
> tw:/home/bor # mount /dev/vda2 -o subvol=3D/@/.snapshots/1/snapshot/foo
> /tmp/foo
> tw:/home/bor #

Thank you for the assistance. I'm learning much.

I'm still hitting an error using the "/@/.snapshots..." syntax:

root@ziti:~# cd /
root@ziti:/# lsblk -f
NAME        FSTYPE FSVER LABEL UUID
FSAVAIL FSUSE% MOUNTPOINTS
nvme0n1
=E2=94=9C=E2=94=80nvme0n1p1 vfat   FAT32       BFD8-2BC8
505.2M     1% /boot/efi
=E2=94=9C=E2=94=80nvme0n1p2 btrfs              5f33a159-4475-44e5-a5f8-40a2=
3e18983a
 66G    71% /
=E2=94=94=E2=94=80nvme0n1p3 swap   1           9800be53-1f85-47bc-bc8b-ed45=
92b123fd
            [SWAP]
root@ziti:/# btrfs subvolume list /
ID 256 gen 606183 top level 5 path @rootfs
root@ziti:/# btrfs subvolume create subv_content
Create subvolume './subv_content'
root@ziti:/# mkdir subv_mnt
root@ziti:/# date > subv_content/foo
root@ziti:/# btrfs subvolume list /
ID 256 gen 606187 top level 5 path @rootfs
ID 257 gen 606187 top level 256 path subv_content
root@ziti:/# mount /dev/nvme0n1p2 -o subvolid=3D257 /subv_mnt
root@ziti:/# ls /subv_mnt
foo
root@ziti:/# umount /subv_mnt
root@ziti:/# mount /dev/nvme0n1p2 -o
subvol=3D/@/.snapshots/1/snapshot/subv_content /subv_mnt
mount: /subv_mnt: mount(2) system call failed: No such file or directory.
       dmesg(1) may have more information after failed mount system call.
root@ziti:/#

As you can see, I can successfully mount the subvolume using the
subvolid options, but I'd like to understand how to get the subvol
option to work.

From man 5 btrfs:

subvol=3D<path>
  Mount subvolume from path rather than the toplevel subvolume. The
path is always treated as relative to  the
  toplevel subvolume.  This mount option overrides the default
subvolume set for the given filesystem.

I was going to ask about the "path is always treated as relative",
which seems to somewhat conflict with your recommendation of "must be
full path from the top level".

Maybe the man page could be clarified a bit?

Nevertheless, I started trying different permutations of subvolume
names and this one seemed to work:

root@ziti:/# mount /dev/nvme0n1p2 -o subvol=3D@rootfs/subv_content /subv_mn=
t
root@ziti:/#

From which "btrfs subvolume list -a /" tells me the path to use for
the mount option of subvol:

root@ziti:/# btrfs subvolume list -a /
ID 256 gen 606213 top level 5 path <FS_TREE>/@rootfs
ID 257 gen 606190 top level 256 path @rootfs/subv_content

Maybe the man page could include the above command to help noobs like
me determine the right path to use?

Anyhow, thanks again for the help!

-m
