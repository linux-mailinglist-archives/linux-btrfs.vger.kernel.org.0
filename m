Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C957C415CCA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 13:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhIWL0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 07:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbhIWL0t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 07:26:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F2C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 04:25:18 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 2so5827584qtw.1
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=29AMVGUCgHK8wMOHzcEvpTkKNGsw3HzYoZBwIi+bhxI=;
        b=X3VdVm0KZVcY16or0QluG5XmoiRGn4SmejlO1QQmgR3WFa3AsywdrBnlBkza6hkkHH
         DE8Pg7z1eHHgBkgycXCAyMsT9vMRbAzdf0ufkmIEd8i/zgxhdTws1Nr7J+B9L7jsrHOe
         ectR6pQFdTIwhLuanh7mAnvm5pPvzSMqLBnV4RtQDGjmsH1Zv9AYFuZ6aomreHft2AF4
         R47rtNRG6lD3ci9Fkowxhcl9oG7EPlNvoIpm8Fw+uAX+niEq01RC2vRvOhNZGTnpFqNf
         ym8yeq5FiNpaTUGQSAREi5uM/s5qW2pRBqUlB+zpwz9dU4Nw9v3eudzCweCViytpbLfc
         TkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=29AMVGUCgHK8wMOHzcEvpTkKNGsw3HzYoZBwIi+bhxI=;
        b=TU5UPy2KYYO0gLtT5ON/MWueeKOAgKzkK30LB171Wf/m0tSeFH92bFwmai38up7vGM
         kG4gWmS8xPZ500z6/Zv+ihoyROs35TxzXOy/kx2NUitfJaILwHVv+pB+24oi7HduSB33
         z/uPnij5Op3OG63QSej7U5sMI79Am6+JzhmfNGW7kf4HCIZPfX/nXzpX9td1tuIlaEWT
         dzu4r6xM49+Dgbqn4mih2YXyuwbIZjH6J8WWr4KA9a6ulWwwUoHsN9oYaw9RLyqDa5Lu
         tqduCtNHN7W5w4BzGJ7FdyKKcTs9IQqFtaB1BTVyYVsS3uDuHAbINCx276alq2F1z+JQ
         bH6w==
X-Gm-Message-State: AOAM532xffb78CrLxqSFugHrtUbzetJP0pCLbQ5KyHo24Sc5HrlRzwB/
        0eIt009U6s19tG3HqrGtoFWLiMRbdG3HHpHoprVxg3Q2
X-Google-Smtp-Source: ABdhPJz/FYcNgg6aZ5IrruuzI+UYEpFudvbIxkN9jmQeBBNLmKkVOfq+2qCQkQXVXZ4f/oXTgjm7LEu5BJ/ygWwH/J0=
X-Received: by 2002:a05:622a:180c:: with SMTP id t12mr4102005qtc.304.1632396317681;
 Thu, 23 Sep 2021 04:25:17 -0700 (PDT)
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
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Sep 2021 12:24:41 +0100
Message-ID: <CAL3q7H5T6_HbUX-EjNjz_Ww5_R4uj5VQvtG2ydjzdx+0gpf6PA@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Yuxuan Shui <yshuiv7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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
> >>> But if you can let me know what I can do to help debugging, I could t=
ry that.
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
> > Catching up on the whole thread, that is indeed a possible cause of fai=
lure.
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
>
> >
> > I'm thinking that for cases like this, we could use a flag for send to
> > tell it to not generate clone operations and do regular write commands
> > instead.
>
> My biggest concern here is, we should properly include the inode flags
> in the send stream, and provide an interface to change btrfs specific
> flags (currently only NODATASUM) at the receive side.

That would require changing the send stream format.
Not sure if Omar's v2 stream allow for that.

>
> With that we can set the proper inode flags before writing/cloning, no
> matter the mount option.

Well, making the sending side force the receiving side to have the
flags that the sending has (or doesn't have), is not something I'm
sure that everyone wants.

Compression for example - the sending side has no compression, but the
receiving side was mounted with -o compress because it wants
compression.
Having the send side clear the compression flag on every file would be
surprising to many users.

The same may or may not apply to nodatacow or nodatasum. I think there
are people relying on the mount options of the receiving side taking
effect.

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



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
