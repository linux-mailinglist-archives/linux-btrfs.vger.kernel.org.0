Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA1276CC33
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjHBMAV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjHBMAU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 08:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A224213D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 05:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06FEC61943
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 12:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2C5C433CB
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690977612;
        bh=2qybXwqdSn+w8W8IHblPpWLSvBVX7VqICogjePH5b7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JITUYlpvgwioIEToQr6qgP9RM/R7edwobhyqDfU5HLmPk9VL9D7ZV1GC+7TJ3csQX
         /nIFqm+3+UTsKRNIUhSwJSpJ+/eaBYU42GonRFcM/X2yLNsAfxZgbk4hvz5J3grFjB
         MqJj6QMAPjAL4mHkdII6p/1WIvk/N6AyMmPXv+Z4KF3tIm7xqmNv9Zcp/mTMMKRf/9
         CQknFOydscSyz9bixmQqkO/ojQk1tShrsXymJvsiUeSzLe/R0cCRSM22A2N6Tk7HW7
         eHQUvg3m+2R6UqveJ1ekYcW1fEbuJJmHsOmR4OR5vPP0rYz6Kjy+I/odIjH+htiCui
         e5erAFU6obQcw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56ca4d7079aso2698934eaf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 05:00:12 -0700 (PDT)
X-Gm-Message-State: ABy/qLYco07VxBJr1zUorOmSiL4dM81McLT977MWkes17fXrIxbkg1I7
        FlBFNP/Xd96x/VERvX2xS9Br73K+WCerNLQLq2g=
X-Google-Smtp-Source: APBJJlE//sW14e7wZU6ja0XtNv87osaFaIlaZ57ffI6/jmYpIpBJwhQ+3GBeiJ3HZai9a+UixfVS4cAAtxmclgbFchY=
X-Received: by 2002:a4a:9cc1:0:b0:56c:d9d4:e80d with SMTP id
 d1-20020a4a9cc1000000b0056cd9d4e80dmr5667084ook.2.1690977611499; Wed, 02 Aug
 2023 05:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690970028.git.wqu@suse.com> <f72bd0cd2198d017d31f7f797546944b2afdd4ab.1690970028.git.wqu@suse.com>
In-Reply-To: <f72bd0cd2198d017d31f7f797546944b2afdd4ab.1690970028.git.wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 2 Aug 2023 12:59:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5dNDdCeZXWEd_jUg79w6Hc45i9_T5hC_+Un+FEAX=-7g@mail.gmail.com>
Message-ID: <CAL3q7H5dNDdCeZXWEd_jUg79w6Hc45i9_T5hC_+Un+FEAX=-7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btrfs: avoid race with qgroup tree creation and relocation
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 2, 2023 at 12:20=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Syzbot reported a weird ASSERT() triggered inside prepare_to_merge().
>
> With extra debug output, it shows we're trying to relocate tree blocks
> for quota root:
>
>  BTRFS error (device loop1): reloc tree mismatch, root 8 has no reloc roo=
t, expect reloc root key (-8, 132, 8) gen 17
>  ------------[ cut here ]------------
>  BTRFS: Transaction aborted (error -117)

So this message doesn't exist before the 2nd patch in series, and
neither the transaction abort.
What we have is an assert.

I would suggest pasting here the assertion failure and stack trace reported=
 at:

https://lore.kernel.org/linux-btrfs/000000000000a3d67705ff730522@google.com=
/

So:

assertion failed: root->reloc_root =3D=3D reloc_root, in fs/btrfs/relocatio=
n.c:1919
------------[ cut here ]------------
kernel BUG at fs/btrfs/relocation.c:1919!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9904 Comm: syz-executor.3 Not tainted
6.4.0-syzkaller-08881-g533925cb7604 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 05/27/2023
RIP: 0010:prepare_to_merge+0xbb2/0xc40 fs/btrfs/relocation.c:1919
Code: fe e9 f5 (...)
RSP: 0018:ffffc9000325f760 EFLAGS: 00010246
RAX: 000000000000004f RBX: ffff888075644030 RCX: 1481ccc522da5800
RDX: ffffc90005c09000 RSI: 00000000000364ca RDI: 00000000000364cb
RBP: ffffc9000325f870 R08: ffffffff816f33ac R09: 1ffff9200064bea0
R10: dffffc0000000000 R11: fffff5200064bea1 R12: ffff888075644000
R13: ffff88803b166000 R14: ffff88803b166560 R15: ffff88803b166558
FS:  00007f4e305fd700(0000) GS:ffff8880b9800000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056080679c000 CR3: 00000000193ad000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 relocate_block_group+0xa5d/0xcd0 fs/btrfs/relocation.c:3749
 btrfs_relocate_block_group+0x7ab/0xd70 fs/btrfs/relocation.c:4087
 btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3283
 __btrfs_balance+0x1b06/0x2690 fs/btrfs/volumes.c:4018
 btrfs_balance+0xbdb/0x1120 fs/btrfs/volumes.c:4402
 btrfs_ioctl_balance+0x496/0x7c0 fs/btrfs/ioctl.c:3604
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4e2f88c389

This is what we normally do anyway.

>
> [CAUSE]
> Normally we should not use reloc tree for quota root at all, as reloc
> trees are only for subvolume trees.
>
> But there is a race between quota enabling and relocation, this happens
> after commit 85724171b302 ("btrfs: fix the btrfs_get_global_root return v=
alue").
>
> Before that commit, for quota and free space tree, we exit immediately
> if we can not grab it from fs_info.
>
> But now we would try to read it from disk, just as if they are fs trees,
> this sets ROOT_SHAREABLE flags in such race:
>
>             Thread A             |           Thread B
> ---------------------------------+------------------------------
> btrfs_quota_enable()             |
> |                                | btrfs_get_root_ref()
> |                                | |- btrfs_get_global_root()
> |                                | |  Returned NULL
> |                                | |- btrfs_lookup_fs_root()
> |                                | |  Returned NULL
> |- btrfs_create_tree()           | |
> |  Now quota root item is        | |
> |  inserted                      | |- btrfs_read_tree_root()
> |                                | |  Got the newly inserted quota root
> |                                | |- btrfs_init_fs_root()
> |                                | |  Set ROOT_SHAREABLE flag
>
> [FIX]
> Get back to the old behavior by returning PTR_ERR(-ENOENT) if the target
> objectid is not a subvolume tree or data reloc tree.
>
> Fixes: 85724171b302 ("btrfs: fix the btrfs_get_global_root return value")
> Reported-and-tested-by: syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail=
.com
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Other than that, it looks good to me:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/disk-io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index da51e5750443..5fd336c597e9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1300,6 +1300,16 @@ static struct btrfs_root *btrfs_get_root_ref(struc=
t btrfs_fs_info *fs_info,
>         root =3D btrfs_get_global_root(fs_info, objectid);
>         if (root)
>                 return root;
> +
> +       /*
> +        * If we're called for non-subvolume trees, and above function di=
dn't
> +        * found one, do not try to read it from disk.
> +        *
> +        * This is mostly for fst and quota trees, which can change at ru=
ntime
> +        * and should only be grabbed from fs_info.
> +        */
> +       if (!is_fstree(objectid) && objectid !=3D BTRFS_DATA_RELOC_TREE_O=
BJECTID)
> +               return ERR_PTR(-ENOENT);
>  again:
>         root =3D btrfs_lookup_fs_root(fs_info, objectid);
>         if (root) {
> --
> 2.41.0
>
