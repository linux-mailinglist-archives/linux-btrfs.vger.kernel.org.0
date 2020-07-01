Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28A211254
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgGASFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 14:05:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:48358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgGASFY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 14:05:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E774FAD9F;
        Wed,  1 Jul 2020 18:05:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21EB3DA781; Wed,  1 Jul 2020 20:05:07 +0200 (CEST)
Date:   Wed, 1 Jul 2020 20:05:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH] btrfs: set tree_root->node = NULL on error
Message-ID: <20200701180507.GG27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Eric Sandeen <sandeen@redhat.com>
References: <20200630185302.3362-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630185302.3362-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 30, 2020 at 02:53:02PM -0400, Josef Bacik wrote:
> Eric reported an issue where mounting -o recovery with a fuzzed fs
> resulted in a kernel panic.  This is because we tried to free the tree
> node, except it was an error from the read.  Fix this by properly
> resetting the tree_root->node == NULL in this case.  The panic was the
> following
> 
> BTRFS warning (device loop0): failed to read tree root
> BUG: kernel NULL pointer dereference, address: 000000000000001f
> RIP: 0010:free_extent_buffer+0xe/0x90 [btrfs]
> Call Trace:
>  free_root_extent_buffers.part.0+0x11/0x30 [btrfs]
>  free_root_pointers+0x1a/0xa2 [btrfs]
>  open_ctree+0x1776/0x18a5 [btrfs]
>  btrfs_mount_root.cold+0x13/0xfa [btrfs]
>  ? selinux_fs_context_parse_param+0x37/0x80
>  legacy_get_tree+0x27/0x40
>  vfs_get_tree+0x25/0xb0
>  fc_mount+0xe/0x30
>  vfs_kern_mount.part.0+0x71/0x90
>  btrfs_mount+0x147/0x3e0 [btrfs]
>  ? cred_has_capability+0x7c/0x120
>  ? legacy_get_tree+0x27/0x40
>  legacy_get_tree+0x27/0x40
>  vfs_get_tree+0x25/0xb0
>  do_mount+0x735/0xa40
>  __x64_sys_mount+0x8e/0xd0
>  do_syscall_64+0x4d/0x90
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f5302f851be
> 
> Fixes: b8522a1e5f42 ("btrfs: Factor out tree roots initialization during mount")
> Reported-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next with Niks explanation, thanks.
