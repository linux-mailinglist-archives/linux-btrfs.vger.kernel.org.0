Return-Path: <linux-btrfs+bounces-351-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D1D7F7A53
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 18:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D282813DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDA381C2;
	Fri, 24 Nov 2023 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="km8cf9k4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6031718
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 09:27:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so27136a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 09:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700846835; x=1701451635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voKJ3PYolsH2kKTHmf+m3gj4pWl9VQDRS+9wv0+naqU=;
        b=km8cf9k4kk1vPdOokFNlG+OpXTtu1SBkCcdLg8V5Zhd5x8hufrBuGPc8Al+qHwvj8Y
         HwU3nElOLI4+mku627yOHq5KnV+nuMIk0rS6SCOJXhMRshwBtbMXjAjajBjuajAolXxP
         qya3dGYNyPa0Dea480sQv1aejHDjXtS2ylhaSgFWp6RXojYtDgj4UjpKogRI/YUevk5H
         JtevwLpdCNI0FBZ6WSACVVA9ZC28iWYShAzFmEJTjPP1ZcqM9LvGo/NWkcYB1n8nplou
         egAM7RC37YPua30JeomPqgxsoJI//6kqmSZrIju0MBXoS7WqP8AopWgDa2145O1zQ4pA
         KcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846835; x=1701451635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voKJ3PYolsH2kKTHmf+m3gj4pWl9VQDRS+9wv0+naqU=;
        b=G+rZnePrzNV/nNa/q+m8L125B9DTKqlm+wwDAVn4Tx6Rp5NNtMDBSnYGEe2sCQWCvw
         xJH5+leC+ODp6Cm+dlDzlckSjFm5dw2NLyYrxtTb5W5s0y65VaIytIbrfo3iNU87OWBz
         iI8fg6dkrjS6oY5laWcoXio50SnjcPKlZptmovekPmcl7TvF/plC+zngR5PPCvYpWta0
         lwDSwaiBrovG5T3Yr/qOpYLWSTVrzy489/rK1gOF50JuUYUgsdmDjEmNBVvgFuZg9leZ
         kaOrXpB3zXLgZ6Nqt+H5CABtMEknrcNW/1hdokky7pQ42c3eUSQp7SOhkhgHczopfZ+T
         JqwA==
X-Gm-Message-State: AOJu0Yw6nVrynb6E9oWoukF2For/LJfw12DTaRrTgM1ukXZT1CjQLLgf
	W3a4Ibs+ECdMgD5wcLmugFuEmJ76lbYjYEubDV8MzA==
X-Google-Smtp-Source: AGHT+IG5wDUCEf6zix84IkqiNQHogSuRdDvjcL0/ZDM9Ke9K+pBdLBzocPTX+8i4zxw0w9GmhgXE3BbfTC9iHzrBHcM=
X-Received: by 2002:a05:6402:291b:b0:54b:de2:2272 with SMTP id
 ee27-20020a056402291b00b0054b0de22272mr27917edb.7.1700846835369; Fri, 24 Nov
 2023 09:27:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000cf908705eaa8c5a7@google.com> <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
 <20231124171707.GF18929@twin.jikos.cz>
In-Reply-To: <20231124171707.GF18929@twin.jikos.cz>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Nov 2023 18:26:37 +0100
Message-ID: <CAG48ez0hPQciXnpK8M1wqcD5qfHGLDbqEvjYk4mLS6zN3BNR5g@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __kernel_write_iter
To: dsterba@suse.cz
Cc: syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>, clm@fb.com, 
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 6:24=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
> On Fri, Nov 24, 2023 at 05:21:20PM +0100, Jann Horn wrote:
> > On Mon, Oct 10, 2022 at 9:04=E2=80=AFAM syzbot
> > <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com> wrote:
> > > HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.li=
naro...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D110f6f0a8=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd19f5d167=
83f901
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D12e098239d2=
0385264d3
> > > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71=
c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9=
/disk-a6afa419.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vm=
linux-a6afa419.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 20347 at fs/read_write.c:504 __kernel_write_iter=
+0x639/0x740
> > [...]
> > >  __kernel_write fs/read_write.c:537 [inline]
> > >  kernel_write+0x1c5/0x340 fs/read_write.c:558
> > >  write_buf fs/btrfs/send.c:590 [inline]
> > >  send_header fs/btrfs/send.c:708 [inline]
> > >  send_subvol+0x1a7/0x4b60 fs/btrfs/send.c:7648
> > >  btrfs_ioctl_send+0x1e34/0x2340 fs/btrfs/send.c:8014
> > >  _btrfs_ioctl_send+0x2e8/0x420 fs/btrfs/ioctl.c:5233
> > >  btrfs_ioctl+0x5eb/0xc10
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> >
> > The issue here is that BTRFS_IOC_SEND looks up an fd with fget() and
> > then writes into it with kernel_write(). Luckily the ioctl requires
> > CAP_SYS_ADMIN, and also Linux >=3D5.8 bails out on __kernel_write() on =
a
> > read-only file, so this has no security impact.
>
> I'm not sure if we could make the send ioctl safe for a non-root user,
> the code there has been doing tricks that have security implications.
>
> > I'm about to send a fix, let's have syzkaller check it beforehand:
> >
> > #syz test https://github.com/thejh/linux.git 573fd2562e0f
>
> The fix looks correct to me, thanks.

(I sent the fix to you and the other btrfs maintainers separately with
subject "[PATCH] btrfs: send: Ensure send_fd is writable", see
<https://lore.kernel.org/lkml/20231124164831.2191549-1-jannh@google.com/T/>=
.)

