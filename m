Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4551415C2D
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhIWKsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 06:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbhIWKsY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 06:48:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B9C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:46:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y89so11226525ede.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=g1UzJ3NUt0EQQRYC4Tpy560jsYasrT769bTKTO3JQ9E=;
        b=Dq79puwVeFlkPqMorlOU/P68vg3CCUoLy2kcZg6QRj4hYhu497+ibj3Iu5+76mTryY
         5HYlqNLacAkEtHyF7569THQsgUfL1ZVWPWOg8ByLkwa5EqG/xlrUXFz4mVR+M6ym/CNy
         ejBw6jlOAzAD/sRp/Vh4TqNE9lPA/BmZICAqCDZhk/cqwEMt91ccVFidxlNPu4v33RQQ
         1qSJ+yitQiMtTWegiNXcfuYZf5Rv2eb/2RImp7wT3y/vSiSSIctvgEZAOnjeq3QmxWIw
         etBfLRLgpvhLE6VSifqj71gYBG63ZMfkhYlNNwJakItQzg321eJCuEIcIQMZcLhL7H86
         UIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=g1UzJ3NUt0EQQRYC4Tpy560jsYasrT769bTKTO3JQ9E=;
        b=LxSEFzlM1A0DvK7rGYUjVAqv6uzq3ty5DQP3BuCz088ubkslpu/8I7j/mhDkGEz2ir
         PbSpifDXC1c6kCsmFjB0PgYdk9SxNiqxcg9qj7+x+2Rw/OSTXg8yLBBJUqQjG8bwolwp
         gHPWkHNS0tw6LGFhRQ9FRRjciva7TZdSY2RdTf+mYOLIua7ahWCmz/py1TJEw7FRzX07
         6bS3WypX2V3cy3LVkb6VzJvjsqdxPnMVuQSZRkgtk6oF4PiDs9lnOKRyejJwg/IzZxrN
         lJzDl6RvXFows1mBCxhkMcAu3OEXhjJI1cxbmn3yMV1LqxYyeSPlolNDHKg6EDGARwjD
         KC2A==
X-Gm-Message-State: AOAM531UW9heZZp3F0NbxR7OmE0A8l3PEjPq5HdI/UOLYutV2HowXRik
        Z5OUCbkPFZ8pc/gKwNO0aZd2Q7yATvlNVrpnhfs=
X-Google-Smtp-Source: ABdhPJxUflf8k4hCpahSvQ8juJotblhP6axzf/FOXNlnFwSUex5/FEZ8b6v9R24vkAkfrK/YD12Lpz+FKLqG4nkRLtU=
X-Received: by 2002:a17:907:3f18:: with SMTP id hq24mr4215217ejc.384.1632394011701;
 Thu, 23 Sep 2021 03:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com> <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com> <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com> <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
 <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com>
 <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com> <CAGqt0zxrm=A8v7Mm6CDNUv77Sxsgt_kp4uJpCbpbCGXrnUmBqA@mail.gmail.com>
 <8af945a3-db88-d1b8-bba3-3f6180f91fcf@suse.com>
In-Reply-To: <8af945a3-db88-d1b8-bba3-3f6180f91fcf@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Sep 2021 11:46:15 +0100
Message-ID: <CAL3q7H7Ty-0HOy5xQU_JMuzYZoNbihL9-gdk+vwk64+GowEmCQ@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Qu Wenruo <wqu@suse.com>
Cc:     Yuxuan Shui <yshuiv7@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 11:20 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2021/9/23 18:08, Yuxuan Shui wrote:
> > Hi,
> >
> > On Thu, Sep 23, 2021 at 10:45 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Mind to provide the full send stream dump?
> >>
> >> This indeed looks like a bug now.
> >
> > Sorry, this might have data I am not allowed to share, and I don't
> > think I will be able to vet all the files in the stream.
> >
> > But if you can let me know what I can do to help debugging, I could try=
 that.
>
> That's totally understandable.
>
> Surprisingly, I can't even find a proper way to get the nodatasum flag
> per-file.
> Thus I guess things may go complex by using "btrfs ins dump-tree"
>
> For the receive failure case, mind to provide the following info?
>
> - The inode number of the clone source
>    You can use 'stat' command to get the inode number:
>    $ stat /mnt/btrfs/file  | grep Inode
>    Device: 29h/41d      Inode: 257         Links: 1
>
> - The tree dump of the clone source
>    $ btrfs ins dump-tree -t <subvolid> <device> | \
>      grep "(<INODE> INODE_ITEM 0) item" -A 5
>         item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
>                 generation 7 transid 7 size 0 nbytes 0
>                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>                 sequence 3 flags 0x0(none)
>                 atime 1632391968.333333415 (2021-09-23 18:12:48)
>                 ctime 1632391968.333333415 (2021-09-23 18:12:48)
>
>     <subvolid> is the subvolume id of the clone source.
>
> - The tree dump of the clone dest directory
>    The inode number can be get using the same 'stat' command.
>    Then pass it to the same "btrfs ins dump-tree" command, with
>    <subvolid> <device> and <INODE> modified.
>
> Then we can be sure what's causing the NODATASUM flag mismatch.

Catching up on the whole thread, that is indeed a possible cause of failure=
.

Someone can do something like:

1) mount fs without -o nodatacow and without -o nodatasum
2) receive snapshot A
3) umount fs
4) mount fs with -o nodatacow or -o nodatasum
5) start receiving an incremental stream that has A as parent and
snapshot B as the send snapshot
6) files created in B end up with the NODATASUM flag set
7) the send stream has a clone operation to clone from some file in A
to a file in B - this fails, as the file in A does not have the
nodatasum bit but the file in B has it

I'm thinking that for cases like this, we could use a flag for send to
tell it to not generate clone operations and do regular write commands
instead.

>
> Thanks,
> Qu
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
