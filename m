Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E483395791
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhEaI52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 04:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhEaI51 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 04:57:27 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3979C06174A
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 01:55:46 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g12so2373707qvx.12
        for <linux-btrfs@vger.kernel.org>; Mon, 31 May 2021 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3gNFG9ThfJffLDJZEurhBCfvsdn1oohta4PrcOHBIO8=;
        b=MGJsovRl/lgaZogYpniaQh2IKwAMrLzrTfFVlLgdeUfRQFiv+rod/Wkb4sHScHKUm3
         4Ir/nJD6jPTFZUD6XCn7Ee6KqbkNnRuyZLxLCPcC15ktW9Cmoqd/fAr1vX9/TyrgqWnb
         cw9WtdOFEze74JjhP6JYrn3Sf7WT+rJPA9SW+QrBLevZEf/EXCzZ3U7T7sbjeIo8nIZ+
         3pG+lLA/RED/QXZqMSzR42Z+4wuowoSH9VhtH6G1jS49UayZ4eeP85NYF1eF0VEzn+1m
         tqUs66JmG16zly+t0NkMjE0Qi0o2mRokQefwbpsWVHr57EeIElzo/9NIqmhwgFNpYeUN
         NdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3gNFG9ThfJffLDJZEurhBCfvsdn1oohta4PrcOHBIO8=;
        b=gkj1Tx2Y6U/Mij/FZLFg8Nv2eP5hVFpe7bzlg/dDF/FIYSspQdZ4X3dEwIAvOhfqiT
         ztZshMAdgNq/tZ4lU7rJkrgcwfNieRiRZ2vTwVTP8sexpcIwVHlXCVqt3hC3aAIJbAkp
         PWz5yBcaGi1vuNnxKHz9z2rY2+P5i3fx67p0aYw2qQTbDN8bfHsfJKA2ixoswMkzrTeB
         5UH7yue8VlaGBjl2rB5vwu0jCqJhCA4YTHHUZw9CYb/zkR6QEDle39/uv+D70l5WIpbC
         Njbv41X12hjWLR3fdURUuOvbSPotcRzTfVRlblk0sKv2o40qA5jJHAGMXjAgNiinplt0
         UClw==
X-Gm-Message-State: AOAM5320DhgrSobD8d3Z2qg5YJwhY5OF9iNaaxTan7TtaEpXydLXCMl+
        N2qrPBxEcO2E94kWldqp6UMhdraW9kt+Gt5sDW1IQA==
X-Google-Smtp-Source: ABdhPJx4P0pcgnL0rpLAZYSL+qbuUbusa0mIqFZq6/uoPfwHjkiT2W05PwwKO3aVYpWC3ouSnj8tvH2fNbOykZW9nJ4=
X-Received: by 2002:a05:6214:6f1:: with SMTP id bk17mr15932892qvb.37.1622451345749;
 Mon, 31 May 2021 01:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f9136f05c39b84e4@google.com> <21666193-5ad7-2656-c50f-33637fabb082@suse.com>
In-Reply-To: <21666193-5ad7-2656-c50f-33637fabb082@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 31 May 2021 10:55:34 +0200
Message-ID: <CACT4Y+bqevMT3cD5sXjSv9QYM_7CwjYmN_Ne5LSj=3-REZ+oTw@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in assertfail
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     syzbot <syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 10:44 AM 'Nikolay Borisov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
> On 31.05.21 =D0=B3. 10:53, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1434a312 Merge branch 'for-5.13-fixes' of git://git.ker=
nel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D162843f3d00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9f3da44a018=
82e99
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da6bf271c02e4f=
e66b4e4
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
> >
> > assertion failed: !memcmp(fs_info->fs_devices->fsid, fs_info->super_cop=
y->fsid, BTRFS_FSID_SIZE), in fs/btrfs/disk-io.c:3282
>
> This means a device contains a btrfs filesystem which has a different
> FSID in its superblock than the fsid which all devices part of the same
> fs_devices should have. This can happen in 2 ways - memory corruption
> where either of the ->fsid member are corrupted or if there was a crash
> while a filesystem's fsid was being changed. We need more context about
> what the test did?

Hi Nikolay,

From a semantic point of view we can consider that it just mounts /dev/rand=
om.
If syzbot comes up with a reproducer it will post it, but you seem to
already figure out what happened, so I assume you can write a unit
test for this.
