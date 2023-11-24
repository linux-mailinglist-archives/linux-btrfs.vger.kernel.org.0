Return-Path: <linux-btrfs+bounces-346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC2C7F78D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 17:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A272128130B
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83234186;
	Fri, 24 Nov 2023 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svb9Q/R2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA591BE
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 08:22:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso23195a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700842919; x=1701447719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M64ztmWBiARV+bGOkqq9YDeivw9HkSbLr9/sDMlRs+I=;
        b=svb9Q/R28rG88XeCEoV0lfKZ3I9iQrd32uZDHauHkJ6Rnqp/YReWNaHgVR/cwvUihP
         N9K/X3UkJ7vSlT9XsxfACtrpW13I3DJlI7lAr7cMw34g+FNBgICwcW4UKHB8yTeh1nnr
         U/VWYrutjOw6pxBrJmK+ivtX3mOhnvVAmHZFsrDIVWYc3TU/6HOZyHtggv3NkLF0ZDvg
         RO1Ah9C9zqx10iHVmxOtVCh7O+ctEPKJQlikVwK5rsdkmHtwvYzAVuZD2fYFgvIUH4eM
         4ucogFYKy3brOzSs4oUn50F4hs8YXU58rpOymE9nMELGGkLOVxwicNWoL2KGACPFN0YQ
         hmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700842919; x=1701447719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M64ztmWBiARV+bGOkqq9YDeivw9HkSbLr9/sDMlRs+I=;
        b=WBr2WZ2FKXpdMeZ0IM0MDnHna8W51tM+EwlonZ5wV+/dW2tXGllHuIM5V5Nib5lypB
         0+2wNU+VJN5HF18z0WPYLZA8tk7K1c/Sr6m7WB+YTe8WenNM7jAPbC3SlRK89GQDJ7br
         sU6vUGXq9g7fAK5WUm2femZv9isqses7gnvcoPzZgXzPIwz7+A7syWedi/UsDJovRNdW
         S/lw1Lg6fV7EmU7zQRJUTe5/M6HWZ62Zdm1MRpsoLgGAdtVeDoxTixY3iX5+vO15sF7Z
         oBvNCLIbI+0cHNWBpVxRe6mHIDXsqO4dmeQo70ggNSkL2DZ3SYvkPp4e/6KejJBz53Li
         xtpQ==
X-Gm-Message-State: AOJu0Ywi8kGTNKc6jrp7Z19kvRify+oUoaYvs4Q0X5BHMn49pSBjxZgk
	iYh62TZgoYJqNp7ex1HXhMIOS7QTM8fFBGOJz2CZEA==
X-Google-Smtp-Source: AGHT+IHOeiCqx5ybJGDdPWiIWyOFgVXz//YKTM16O94xCOOn5kmMHZ2WfxY1jX/GPpN0CrU7+gR0RYsxj5OhmA7J/Hg=
X-Received: by 2002:a05:6402:b83:b0:544:e249:be8f with SMTP id
 cf3-20020a0564020b8300b00544e249be8fmr359458edb.1.1700842918703; Fri, 24 Nov
 2023 08:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000cf908705eaa8c5a7@google.com>
In-Reply-To: <000000000000cf908705eaa8c5a7@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Nov 2023 17:21:20 +0100
Message-ID: <CAG48ez0JNLENLRSaisWvaY7+o=CwGtP=ZcH_iBoSqW7qD-PU1Q@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __kernel_write_iter
To: syzbot <syzbot+12e098239d20385264d3@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 10, 2022 at 9:04=E2=80=AFAM syzbot
<syzbot+12e098239d20385264d3@syzkaller.appspotmail.com> wrote:
> HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D110f6f0a88000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd19f5d16783f9=
01
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D12e098239d20385=
264d3
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da=
-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12e24d042ff9/dis=
k-a6afa419.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4862ae4e2edf/vmlinu=
x-a6afa419.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+12e098239d20385264d3@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 20347 at fs/read_write.c:504 __kernel_write_iter+0x6=
39/0x740
[...]
>  __kernel_write fs/read_write.c:537 [inline]
>  kernel_write+0x1c5/0x340 fs/read_write.c:558
>  write_buf fs/btrfs/send.c:590 [inline]
>  send_header fs/btrfs/send.c:708 [inline]
>  send_subvol+0x1a7/0x4b60 fs/btrfs/send.c:7648
>  btrfs_ioctl_send+0x1e34/0x2340 fs/btrfs/send.c:8014
>  _btrfs_ioctl_send+0x2e8/0x420 fs/btrfs/ioctl.c:5233
>  btrfs_ioctl+0x5eb/0xc10
>  vfs_ioctl fs/ioctl.c:51 [inline]

The issue here is that BTRFS_IOC_SEND looks up an fd with fget() and
then writes into it with kernel_write(). Luckily the ioctl requires
CAP_SYS_ADMIN, and also Linux >=3D5.8 bails out on __kernel_write() on a
read-only file, so this has no security impact.

I'm about to send a fix, let's have syzkaller check it beforehand:

#syz test https://github.com/thejh/linux.git 573fd2562e0f

