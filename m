Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45552DB5A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 20:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438556AbfJQSOZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 14:14:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:34412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395229AbfJQSOZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 14:14:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 99120B345;
        Thu, 17 Oct 2019 18:14:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F318ADA808; Thu, 17 Oct 2019 20:14:33 +0200 (CEST)
Date:   Thu, 17 Oct 2019 20:14:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix qgroup double free after failure to reserve
 metadata for delalloc
Message-ID: <20191017181432.GN2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191015095439.6511-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015095439.6511-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 10:54:39AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we fail to reserve metadata for delalloc operations we end up releasing
> the previously reserved qgroup amount twice, once explicitly under the
> 'out_qgroup' label by calling btrfs_qgroup_free_meta_prealloc() and once
> again, under label 'out_fail', by calling btrfs_inode_rsv_release() with a
> value of 'true' for its 'qgroup_free' argument, which results in
> btrfs_qgroup_free_meta_prealloc() being called again, so we end up having
> a double free.
> 
> Also if we fail to reserve the necessary qgroup amount, we jump to the
> label 'out_fail', which calls btrfs_inode_rsv_release() and that in turns
> calls btrfs_qgroup_free_meta_prealloc(), even though we weren't able to
> reserve any qgroup amount. So we freed some amount we never reserved.
> 
> So fix this by removing the call to btrfs_inode_rsv_release() in the
> failure path, since it's not necessary at all as we haven't changed the
> inode's block reserve in any way at this point.
> 
> Fixes: c8eaeac7b73434 ("btrfs: reserve delalloc metadata differently")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, added to 5.4-rc queue.
