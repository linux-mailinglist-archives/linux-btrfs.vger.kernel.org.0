Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4716AA75E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbfIEPb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 11:31:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732723AbfIEPb1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 11:31:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51CD1AF65;
        Thu,  5 Sep 2019 15:31:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D3818DA8F3; Thu,  5 Sep 2019 17:31:51 +0200 (CEST)
Date:   Thu, 5 Sep 2019 17:31:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Relinquish CPUs in btrfs_compare_trees
Message-ID: <20190905153151.GC2850@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190904163358.11591-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904163358.11591-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 04, 2019 at 07:33:58PM +0300, Nikolay Borisov wrote:
> When doing any form of incremental send the parent and the child trees
> need to be compared via btrfs_compare_trees. This  can result in long
> loop chains without ever relinquishing the CPU. This causes softlockup
> detector to trigger when comparing trees with a lot of items. Example
> report:
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 24s! [snapperd:16153]
> CPU: 0 PID: 16153 Comm: snapperd Not tainted 5.2.9-1-default #1 openSUSE Tumbleweed (unreleased)
> Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> pstate: 40000005 (nZcv daif -PAN -UAO)
> pc : __ll_sc_arch_atomic_sub_return+0x14/0x20
> lr : btrfs_release_extent_buffer_pages+0xe0/0x1e8 [btrfs]
> sp : ffff00001273b7e0
> Call trace:
>  __ll_sc_arch_atomic_sub_return+0x14/0x20
>  release_extent_buffer+0xdc/0x120 [btrfs]
>  free_extent_buffer.part.0+0xb0/0x118 [btrfs]
>  free_extent_buffer+0x24/0x30 [btrfs]
>  btrfs_release_path+0x4c/0xa0 [btrfs]
>  btrfs_free_path.part.0+0x20/0x40 [btrfs]
>  btrfs_free_path+0x24/0x30 [btrfs]
>  get_inode_info+0xa8/0xf8 [btrfs]
>  finish_inode_if_needed+0xe0/0x6d8 [btrfs]
>  changed_cb+0x9c/0x410 [btrfs]
>  btrfs_compare_trees+0x284/0x648 [btrfs]
>  send_subvol+0x33c/0x520 [btrfs]
>  btrfs_ioctl_send+0x8a0/0xaf0 [btrfs]
>  btrfs_ioctl+0x199c/0x2288 [btrfs]
>  do_vfs_ioctl+0x4b0/0x820
>  ksys_ioctl+0x84/0xb8
>  __arm64_sys_ioctl+0x28/0x38
>  el0_svc_common.constprop.0+0x7c/0x188
>  el0_svc_handler+0x34/0x90
>  el0_svc+0x8/0xc
> 
> Fix this by adding a call to cond_resched at the beginning of the main
> loop in btrfs_compare_trees.
> 
> Fixes: 7069830a9e38 ("Btrfs: add btrfs_compare_trees function")
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>
