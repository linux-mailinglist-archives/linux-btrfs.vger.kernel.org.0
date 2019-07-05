Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590ED604AB
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfGEKoi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 06:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfGEKoi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 06:44:38 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA17921850
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2019 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562323476;
        bh=QqbFoWXcimobK0VMR9LYLIoX+Okgb4qw8DeP9rylPro=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E2V5fY6k4erI1ID3Pc++54Rf5/NA9XyuB4hEutkpMTHJ11sFKfSXGBXIMHBxMNvV1
         awjvAQ4LpbZ51jm/9JG4gHV5F/k/pP7aj84if9JaKVVkleTCawlcB/C669yIfJUXlZ
         KaxKZ0k/3GQGXpqAMRTo/hFtcvVhTZdA9dK3jYc8=
Received: by mail-ua1-f46.google.com with SMTP id o2so2038791uae.10
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 03:44:36 -0700 (PDT)
X-Gm-Message-State: APjAAAVVup4MZ+Fh4Rkfr/xPdxGZf8HJHTIFN0GvDCvq9WIlcxN4K4Ti
        IA7l92utKgbBGFE3zAIv0drpHcQOwhS4weyYYDg=
X-Google-Smtp-Source: APXvYqwj6C+obpxzsqfkC6SFAoJsnYR1ofMwUprfIry7KQO/9WZtl85v9DJ/Ljp4V2P98G3QGac/XxRPbdWy1k8U4gM=
X-Received: by 2002:ab0:208c:: with SMTP id r12mr1469415uak.27.1562323475979;
 Fri, 05 Jul 2019 03:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190704152409.20665-1-fdmanana@kernel.org> <324ad8e5-c6f6-f31f-c7b4-8673326d076b@suse.com>
In-Reply-To: <324ad8e5-c6f6-f31f-c7b4-8673326d076b@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 5 Jul 2019 11:44:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4dFOEt7S-TKeAnCJ1fZQUBJcWGMji-nBBLNg8v4aS3_w@mail.gmail.com>
Message-ID: <CAL3q7H4dFOEt7S-TKeAnCJ1fZQUBJcWGMji-nBBLNg8v4aS3_w@mail.gmail.com>
Subject: Re: [PATCH 1/5] Btrfs: fix hang when loading existing inode cache off disk
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 10:09 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 4.07.19 =D0=B3. 18:24 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we are able to load an existing inode cache off disk, we set the sta=
te
> > of the cache to BTRFS_CACHE_FINISHED, but we don't wake up any one wait=
ing
> > for the cache to be available. This means that anyone waiting for the
> > cache to be available, waiting on the condition that either its state i=
s
> > BTRFS_CACHE_FINISHED or its available free space is greather than zero,
> > can hang forever.
> >
> > This could be observed running fstests with MOUNT_OPTIONS=3D"-o inode_c=
ache",
> > in particular test case generic/161 triggered it very frequently for me=
,
> > producing a trace like the following:
> >
> >   [63795.739712] BTRFS info (device sdc): enabling inode map caching
> >   [63795.739714] BTRFS info (device sdc): disk space caching is enabled
> >   [63795.739716] BTRFS info (device sdc): has skinny extents
> >   [64036.653886] INFO: task btrfs-transacti:3917 blocked for more than =
120 seconds.
> >   [64036.654079]       Not tainted 5.2.0-rc4-btrfs-next-50 #1
> >   [64036.654143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> >   [64036.654232] btrfs-transacti D    0  3917      2 0x80004000
> >   [64036.654239] Call Trace:
> >   [64036.654258]  ? __schedule+0x3ae/0x7b0
> >   [64036.654271]  schedule+0x3a/0xb0
> >   [64036.654325]  btrfs_commit_transaction+0x978/0xae0 [btrfs]
> >   [64036.654339]  ? remove_wait_queue+0x60/0x60
> >   [64036.654395]  transaction_kthread+0x146/0x180 [btrfs]
> >   [64036.654450]  ? btrfs_cleanup_transaction+0x620/0x620 [btrfs]
> >   [64036.654456]  kthread+0x103/0x140
> >   [64036.654464]  ? kthread_create_worker_on_cpu+0x70/0x70
> >   [64036.654476]  ret_from_fork+0x3a/0x50
> >   [64036.654504] INFO: task xfs_io:3919 blocked for more than 120 secon=
ds.
> >   [64036.654568]       Not tainted 5.2.0-rc4-btrfs-next-50 #1
> >   [64036.654617] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
> >   [64036.654685] xfs_io          D    0  3919   3633 0x00000000
> >   [64036.654691] Call Trace:
> >   [64036.654703]  ? __schedule+0x3ae/0x7b0
> >   [64036.654716]  schedule+0x3a/0xb0
> >   [64036.654756]  btrfs_find_free_ino+0xa9/0x120 [btrfs]
> >   [64036.654764]  ? remove_wait_queue+0x60/0x60
> >   [64036.654809]  btrfs_create+0x72/0x1f0 [btrfs]
> >   [64036.654822]  lookup_open+0x6bc/0x790
> >   [64036.654849]  path_openat+0x3bc/0xc00
> >   [64036.654854]  ? __lock_acquire+0x331/0x1cb0
> >   [64036.654869]  do_filp_open+0x99/0x110
> >   [64036.654884]  ? __alloc_fd+0xee/0x200
> >   [64036.654895]  ? do_raw_spin_unlock+0x49/0xc0
> >   [64036.654909]  ? do_sys_open+0x132/0x220
> >   [64036.654913]  do_sys_open+0x132/0x220
> >   [64036.654926]  do_syscall_64+0x60/0x1d0
> >   [64036.654933]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Fix this by adding a wake_up() call right after setting the cache state=
 to
> > BTRFS_CACHE_FINISHED, at start_caching(), when we are able to load the
> > cache from disk.
> >
> > Fixes: 82d5902d9c681b ("Btrfs: Support reading/writing on disk free ino=
 cache")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  fs/btrfs/inode-map.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
> > index ffca2abf13d0..4a5882665f8a 100644
> > --- a/fs/btrfs/inode-map.c
> > +++ b/fs/btrfs/inode-map.c
> > @@ -145,6 +145,7 @@ static void start_caching(struct btrfs_root *root)
> >               spin_lock(&root->ino_cache_lock);
> >               root->ino_cache_state =3D BTRFS_CACHE_FINISHED;
> >               spin_unlock(&root->ino_cache_lock);
> > +             wake_up(&root->ino_cache_wait);
>
> One of the two callers of start_caching doesn't actually wait for the
> cache to load - btrfs_return_ino. Is this expected or is it also a bug?

It's expected. It doesn't need to allocate an inode, so it doesn't
need to wait for the caching to complete - it just wants to mark an
inode as free in the cache.

>
> The presence of such a glaring omission of the wake up means this code
> hasn't been tested much.

It hasn't. Last time I tried it was more than one year ago, maybe two.

Thanks.

>
> >               return;
> >       }
> >
> >
