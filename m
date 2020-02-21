Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E4716844F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 18:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBURAx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 12:00:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:60748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgBURAw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 12:00:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A891AE41;
        Fri, 21 Feb 2020 17:00:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E2243DA70E; Fri, 21 Feb 2020 18:00:33 +0100 (CET)
Date:   Fri, 21 Feb 2020 18:00:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix deadlock during fast fsync when logging
 prealloc extents beyond eof
Message-ID: <20200221170033.GO2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200220132949.20571-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220132949.20571-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 20, 2020 at 01:29:49PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>   [ 2780.030369] R13: 0000000051eb851f R14: 00007ffdba3c85f0 R15: 0000557a49220d90
> 
> So fix this by making btrfs_truncate_inode_items() not lock the range in
> the inode's iotree when the target root is a log root, since it's not
> needed to lock the range for log roots as the protection from the inode's
> lock and log_mutex are all that's needed.
> 
> Fixes: 28553fa992cb28 ("Btrfs: fix race between shrinking truncate and fiemap")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, I'll add it to the rc3 queue so both fixups are in the same
release and can be picked by stable too.
