Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2612034D73C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbhC2Sbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:31:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhC2SbX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:31:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 100FAAFF0;
        Mon, 29 Mar 2021 18:31:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EFAE3DA842; Mon, 29 Mar 2021 20:29:13 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:29:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: move log tree node allocation out of
 log_root_tree->log_mutex
Message-ID: <20210329182913.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Filipe Manana <fdmanana@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <984c070461f31182e87d1b4f27c4565088a31b40.1616595693.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984c070461f31182e87d1b4f27c4565088a31b40.1616595693.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 24, 2021 at 11:23:11PM +0900, Naohiro Aota wrote:
> Commit 6e37d2459941 ("btrfs: zoned: fix deadlock on log sync") pointed out
> a deadlock warning and removed
> mutex_{lock,unlock}(&fs_info->tree_root->log_mutex). While it looks like it
> always cause a deadlock, we didn't see actual deadlock in fstests runs. The
> reason is log_root_tree->log_mutex != fs_info->tree_root->log_mutex, not
> taking the same lock. So, the warning was actually a false-positive.
> 
> Since btrfs_alloc_log_tree_node() is protected only by
> fs_info->tree_root->log_mutex, we can (and should) move the code out of the
> lock scope of log_root_tree->log_mutex and silence the warning.
> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
