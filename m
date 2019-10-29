Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF640E8CEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390545AbfJ2Qmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 12:42:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:48682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390258AbfJ2Qmn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 12:42:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7132CB5B1;
        Tue, 29 Oct 2019 16:42:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 688E7DA734; Tue, 29 Oct 2019 17:42:50 +0100 (CET)
Date:   Tue, 29 Oct 2019 17:42:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] tree reading cleanups in mount
Message-ID: <20191029164248.GX3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191015154224.21537-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154224.21537-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 06:42:16PM +0300, Nikolay Borisov wrote:
> Hello, 
> 
> Here is the second version of the tree reading code which gets executed during 
> mount. This goes a bit further than the previous posting in that it not only 
> introduces a new function but also refactors the code which decides which backup
> root to use. Overall I think the semantics are now much cleaner and centralised
> in a single function - init_tree_roots rather than split between mount and 
> backup root write out. 
> 
> The series starts gradually by simplifying find_newest_super_backup and its
> callers (patches 1-2). 
> 
> It then paves the way forward by introducing read_backup_rooti (patch 3) which
> supersedes (patch 4) next_root_backup, the latter is then removed (patch 6). While
> at it I also remove the unnecessary objectid mutex during mount (patch 5). 
> 
> The final 2 patches streamlines how btrfs_fs_info::backup_root_index is being
> initialised. 
> 
> This patchset has been tested by simulating (via btrfs-corrupt-block) corruption
> of the primary root and resorting to using usebackuproot mount option. I've also 
> added a regression test to btrfs-progs that will follow shortly. 
> 
> Nikolay Borisov (8):
>   btrfs: Cleanup and simplify find_newest_super_backup
>   btrfs: Remove newest_gen argument from find_oldest_super_backup
>   btrfs: Add read_backup_root
>   btrfs: Factor out tree roots initialization during mount
>   btrfs: Don't use objectid_mutex during mount
>   btrfs: Remove unused next_root_backup function
>   btrfs: Rename find_oldest_super_backup to init_backup_root_slot
>   btrfs: Streamline btrfs_fs_info::backup_root_index semantics

Moved from topic branch to misc-next. The cleaned up code looks much
better, thanks.
