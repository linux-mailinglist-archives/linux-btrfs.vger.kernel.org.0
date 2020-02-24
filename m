Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83FE16A39F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBXKOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 05:14:18 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36694 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXKOS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 05:14:18 -0500
Received: by mail-ua1-f66.google.com with SMTP id y3so3018757uae.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Feb 2020 02:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Hg087/zxvfpyexbULUuRoUet8inDyQ6J2VZLIY9VGh8=;
        b=VtVp5YV0s74jxoXm9VxKuht2JqR1tH2jZOxygPU2P93Afo+fE9VM67EkQWNOu7X4Ly
         3FIMpcribiEJLkENgePw+C9cjjsSe/cA6mgybwz4UCbtg6rF6bKqKiqkXZBPcSZKrY5s
         CRHk3xR3XdMKT38ugyZ0wjIemH6QWssBe2rjO0G+2W08LHBhj5Bk6IxXcWPyEaFwY3E7
         kgLvFDf1bGmAeG0RZlAglkPYF6y4B9+LewsCIKrRLSXGwtBOdX9+suuS8XvtzGaJMvy5
         bu92gegavUSYI7EncuUvUcS+5H9er8FX/z4QP6s7gqH7M3kUAJ11WFYe8YHHrpuQVjci
         M+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Hg087/zxvfpyexbULUuRoUet8inDyQ6J2VZLIY9VGh8=;
        b=fWa5RfNyzoPyuJG3fHWY41xIkCbRdNjU8+XR/kC/1oN4FTYjsk3dD6tQ3Tk6L2kuqv
         a3ZHT81PFbRdFrK5FP5/F0qZ3avo5b4Edvqur5Z/UOWg1S3wDM4KoPICRA8k3GirpgIV
         Y6xNNSWT10sgaitx+01sbUXWFgmz3ebmUNm181V4R8K0AtK6N/KHbF9P2AOs97EOD247
         vlCP4qYjydJNpfHc0Dv3H8N5UT1aUaJpJrlqyyi+OIMWpUCXHGji7ToilqPNjt08OOU5
         T2F7yHxCz1tfaYdlQxrHm/isRGFjzbeW9aalzyn/gQkWuKokyN1tPGxCxSm/ntMtDAPF
         zLlg==
X-Gm-Message-State: APjAAAUlozkGOL6vo79Vucy+W/xvkbMBoFPMdWvlQkKhtdUKXvpZ6eoj
        ZxGMkbNObCeC9zs5qCsseAkZmC65E+vqF9TawT2XJQ==
X-Google-Smtp-Source: APXvYqx1zj4RE6gkYdvUthGTyO/Znn5oPrMDfC8JrbjUBj8tdQ3aM/eNAles5OrgwRznLq+maSdSxa/5T/8vostt8vk=
X-Received: by 2002:ab0:18a1:: with SMTP id t33mr25320602uag.123.1582539257381;
 Mon, 24 Feb 2020 02:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20200223234246.GA1208467@mit.edu> <0c0fa96f-60d6-6a66-3542-d78763bbe269@suse.com>
 <20200224064605.GA1258811@mit.edu>
In-Reply-To: <20200224064605.GA1258811@mit.edu>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 24 Feb 2020 10:14:06 +0000
Message-ID: <CAL3q7H4-edAwsSc0Z+dYVzphm6-D1BjvToywL0A2v6unsCCtyg@mail.gmail.com>
Subject: Re: btrfs: sleeping function called from invalid context
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 24, 2020 at 6:47 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Feb 24, 2020 at 02:28:22AM +0200, Nikolay Borisov wrote:
> > So this is fallout from 28553fa992cb28be6a65566681aac6cafabb4f2d becaus=
e
> > it's being called while we have locked extent buffers (before calling
> > btrfs_free_Path which is holding a rwlock (a variant of spinlock). And
> > actually unlocking btrfs' extent requires allocating structures to
> > reflect the new state. This allocation is currently done with GFP_NOFS
> > which implies DIRECT_RECLAIM hence the maybe sleep from slab allocator
> > is triggered.
> >
> > Filipe, can the unlock be done _after_ freeing the path or even better =
-
> > reduce the critical section altogether in btrfs_truncate_inode_items?
> >
> > I don't think '[PATCH] Btrfs: fix deadlock during fast fsync when
> > logging prealloc extents beyond eof' actually fixes the problem since
> > the unlock can happen under the path again.
>
> Hmm... I don't know if the problem has been *completely* fixed, but I
> can say that with -rc3 (which has the "fix deadlock during fast fsync
> when..." commit), I'm no longer seeing the kernel complaints when I
> run "gce-xfstests -c btrfs -g auto".  Here are the test results:
>
> TESTRUNID: tytso-20200223230308
> KERNEL:    kernel 5.6.0-rc3-xfstests #1522 SMP Sun Feb 23 23:01:10 EST 20=
20 x86_64
> CMDLINE:   -c btrfs -g auto
> CPUS:      2
> MEM:       7680
>
> btrfs/default: 988 tests, 8 failures, 203 skipped, 8739 seconds
>   Failures: btrfs/056 btrfs/153 btrfs/204 generic/065 generic/260
>     generic/475 generic/562 shared/298
> Totals: 785 tests, 203 skipped, 8 failures, 0 errors, 8678s
>
> FSTESTIMG: gce-xfstests/xfstests-202002211357
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests f7b47c5 (Tue, 11 Feb 2020 14:22:21 -0800)
> FSTESTVER: e2fsprogs v1.45.4-15-g4b4f7b35 (Wed, 9 Oct 2019 20:25:01 -0400=
)
> FSTESTVER: fio  fio-3.18 (Wed, 5 Feb 2020 07:59:58 -0700)
> FSTESTVER: fsverity v1.0 (Wed, 6 Nov 2019 10:35:02 -0800)
> FSTESTVER: ima-evm-utils v1.2 (Fri, 26 Jul 2019 07:42:17 -0400)
> FSTESTVER: nvme-cli v1.10.1 (Tue, 7 Jan 2020 13:55:21 -0700)
> FSTESTVER: quota  9a001cc (Tue, 5 Nov 2019 16:12:59 +0100)
> FSTESTVER: util-linux v2.35 (Tue, 21 Jan 2020 11:15:21 +0100)
> FSTESTVER: xfsprogs v5.4.0 (Fri, 20 Dec 2019 16:47:12 -0500)
> FSTESTVER: xfstests-bld a7ae9ff (Tue, 18 Feb 2020 14:22:36 -0500)
> FSTESTVER: xfstests linux-v3.8-2692-g3fe2fd0d (Fri, 21 Feb 2020 13:42:43 =
-0500)
> FSTESTCFG: btrfs
> FSTESTSET: -g auto
> FSTESTOPT: aex
> GCE ID:    9110223165715314154
>
> If you want the full test artifacts for this run, in case you want to
> dig into the test failures, let me know; I'm happy to send them.  The
> compressed tarfile is is 1952k, so it's a bit too large for the vger
> mailing list.

We do have some tests that fail in any kernel release so far. Some
because the corresponding fixes are not yet merged or some fail often
due to known problems.
Looking at your list of failure, I see some that shouldn't be failing
like btrfs/053.

If you want you can send me the test logs to my gmail address. Thanks.

>
> Cheers,
>
>                                                 - Ted



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
