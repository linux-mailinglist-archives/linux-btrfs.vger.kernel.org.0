Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA247416F6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Sep 2021 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbhIXJti (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Sep 2021 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbhIXJti (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Sep 2021 05:49:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A7BC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Sep 2021 02:48:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i4so38034148lfv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Sep 2021 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpm0mT0+eenLMItsYZfXSu/l4UmBXS03x9KQI6Ul27g=;
        b=BEalfSb1iIqErEIrjAg1T6eY8k3eyRM63rGcLbNv2DhYp76Gv0QQLyKqBuaWLeZaPL
         KN4dSNEdNe1c94j+iI4vSrUK0jJ9z+F+IFR3eutT7+5NCi8b6pPES719d1tW+dXq+sVo
         lA6NXaNP8hXhi1Bm23CoMFqEhyQdLoSDL01CRia3QadZJOvAtFaP9cpZn0fRk5ZMjGFv
         jsMnmvwwx2SSAaVocLh0eSAsOw03s6QbRtyoS9o3EuBAmWILUOeoLXDUZp+mIJAtl9I2
         D7/rm0O8X9xLmnPRsQDRzigVLWPKR2LZlrmNh8fUvMTbn1CLe2gdQuy/eYPZeniQrnPX
         qtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpm0mT0+eenLMItsYZfXSu/l4UmBXS03x9KQI6Ul27g=;
        b=U6mjSxkyNpJuDoz9+Su4psfqhjOvuxe1EcFKVSedfyWlgBYMThsPel3P0ODLDfoIro
         gIgrR/ES8dYHP1TVkKwJNkoOZXEdEdZFFEWckKdTKrAU4TGnlvuXME57UsQE75FyFYsW
         uNJ2qA/ypaMU14IxA34nhW+S48vw9ZK5UgQIWKcKWm4Mf4V1kRpUEzpx5S7FeZocn3wj
         1JkuJ4PTJUsx+OKEiB6uMRG9UKLVqCK0Wn5k6TiAWfcrNZO+wcoaPVLytaWswX3ex3i1
         AANjxsvBfVroKQhQV/0g+I5zYo2wvzJXNbCr+PGvxPB41XcYQhT6RL+94q2xdjs4VInJ
         b4IA==
X-Gm-Message-State: AOAM530ZaYr3Ijh/Ka9rktA7IUXo2ebOZEhQD8mZJYkmqPLbDN0Ah9nz
        +EulWzd4QB+pnrzkWtDveT+OSDNkaXnU5+Gj6pY=
X-Google-Smtp-Source: ABdhPJxwc2rjbZ8B5A+Rw0Pe+le5scaTbg1f0lhleQZZHFwRbq5I/OPIeLq8xnLEVEWeFQiQqBfhW0fVTfL3Ks1a32o=
X-Received: by 2002:ac2:5493:: with SMTP id t19mr8425913lfk.282.1632476883360;
 Fri, 24 Sep 2021 02:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com> <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com> <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com> <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
 <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com>
 <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com> <CAGqt0zxrm=A8v7Mm6CDNUv77Sxsgt_kp4uJpCbpbCGXrnUmBqA@mail.gmail.com>
 <8af945a3-db88-d1b8-bba3-3f6180f91fcf@suse.com> <CAL3q7H7Ty-0HOy5xQU_JMuzYZoNbihL9-gdk+vwk64+GowEmCQ@mail.gmail.com>
 <8a781d5e-bdee-b44c-f237-292804b822ab@gmx.com>
In-Reply-To: <8a781d5e-bdee-b44c-f237-292804b822ab@gmx.com>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Fri, 24 Sep 2021 10:47:51 +0100
Message-ID: <CAGqt0zx+eC0B1Pr-GXOkwn7icc0OWBduWbcmYRg3K8Uw1DXC5Q@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On Thu, Sep 23, 2021 at 12:16 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/9/23 18:46, Filipe Manana wrote:
> > On Thu, Sep 23, 2021 at 11:20 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >>
> >>
> >> On 2021/9/23 18:08, Yuxuan Shui wrote:
> >>> Hi,
> >>>
> >>> On Thu, Sep 23, 2021 at 10:45 AM Qu Wenruo <wqu@suse.com> wrote:
> >>>>
> >>>> Mind to provide the full send stream dump?
> >>>>
> >>>> This indeed looks like a bug now.
> >>>
> >>> Sorry, this might have data I am not allowed to share, and I don't
> >>> think I will be able to vet all the files in the stream.
> >>>
> >>> But if you can let me know what I can do to help debugging, I could try that.
> >>
> >> That's totally understandable.
> >>
> >> Surprisingly, I can't even find a proper way to get the nodatasum flag
> >> per-file.
> >> Thus I guess things may go complex by using "btrfs ins dump-tree"
> >>
> >> For the receive failure case, mind to provide the following info?
> >>
> >> - The inode number of the clone source
> >>     You can use 'stat' command to get the inode number:
> >>     $ stat /mnt/btrfs/file  | grep Inode
> >>     Device: 29h/41d      Inode: 257         Links: 1
> >>
> >> - The tree dump of the clone source
> >>     $ btrfs ins dump-tree -t <subvolid> <device> | \
> >>       grep "(<INODE> INODE_ITEM 0) item" -A 5
> >>          item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
> >>                  generation 7 transid 7 size 0 nbytes 0
> >>                  block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
> >>                  sequence 3 flags 0x0(none)
> >>                  atime 1632391968.333333415 (2021-09-23 18:12:48)
> >>                  ctime 1632391968.333333415 (2021-09-23 18:12:48)
> >>
> >>      <subvolid> is the subvolume id of the clone source.
> >>
> >> - The tree dump of the clone dest directory
> >>     The inode number can be get using the same 'stat' command.
> >>     Then pass it to the same "btrfs ins dump-tree" command, with
> >>     <subvolid> <device> and <INODE> modified.
> >>
> >> Then we can be sure what's causing the NODATASUM flag mismatch.
> >
> > Catching up on the whole thread, that is indeed a possible cause of failure.
> >
> > Someone can do something like:
> >
> > 1) mount fs without -o nodatacow and without -o nodatasum
> > 2) receive snapshot A
> > 3) umount fs
> > 4) mount fs with -o nodatacow or -o nodatasum
> > 5) start receiving an incremental stream that has A as parent and
> > snapshot B as the send snapshot
> > 6) files created in B end up with the NODATASUM flag set
> > 7) the send stream has a clone operation to clone from some file in A
> > to a file in B - this fails, as the file in A does not have the
> > nodatasum bit but the file in B has it
>
> Exactly.
>
> We can craft a test case for it (but without a fix for a while).

As a quick fix, is it possible to convert existing files that are not
nodatasum to nodatasum?

>
> >
> > I'm thinking that for cases like this, we could use a flag for send to
> > tell it to not generate clone operations and do regular write commands
> > instead.
>
> My biggest concern here is, we should properly include the inode flags
> in the send stream, and provide an interface to change btrfs specific
> flags (currently only NODATASUM) at the receive side.
>
> With that we can set the proper inode flags before writing/cloning, no
> matter the mount option.
>
> But this is a big project, involving changing send stream format,
> introducing new ioctl interface.
>
> Thanks,
> Qu
>
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >
> >

I have a dumb question. As an outsider, it seems to me that cloning
from a file with datasum to a file with nodatasum can have a well
defined semantic? i.e. say I clone from A (datasum) to B (nodatasum),
then reading from B should skip checksum verification, and modifying B
would write data without checksum, and leaving A with checksum.

Is this not practical to implement due to btrfs' internal structure?

Thanks!

-- 

Regards
Yuxuan Shui
