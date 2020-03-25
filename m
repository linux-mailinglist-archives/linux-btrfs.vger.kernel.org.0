Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF76192B5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 15:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCYOmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 10:42:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgCYOmu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 10:42:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F34A3ACF0;
        Wed, 25 Mar 2020 14:42:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 131FEDA7EB; Wed, 25 Mar 2020 15:42:18 +0100 (CET)
Date:   Wed, 25 Mar 2020 15:42:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for valgrind errors during
 fsck-tests
Message-ID: <20200325144217.GD5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200324105315.136569-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324105315.136569-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 24, 2020 at 06:53:09PM +0800, Qu Wenruo wrote:
> This patchset can be fetched from github:
> https://github.com/adam900710/btrfs-progs/tree/valgrind_fixes
> 
> Inspired by that long-existing-but-I-can't-reproduce v5.1 bug, I will
> never trust D=asan/D=uban anymore, and run valgrind on all fsck-tests.
> 
> The patchset is the result from the latest valgrind runs.
> 
> The first patch is to make "make INSTRUMENT=valgrind test-fsck" run
> smoothly without false alerts due to mount/umount failure with valgrind.

Thanks, that's great. In addition to that, all commands that use the
SUDO_HELPER/root_helper won't pass through valgrind. For maximum
coverage we might want to remove the helper from the subcommands of
'btrfs'. From a quick scan I found a lot of them and I'm not sure that
all are required. There's a lot of copy&paste in the tests, so that
would have to be cleaned up, or we leave it as it is and run the whole
tests under root.

> With this patchset applied (along with that fix for v5.1), fsck tests
> all passes without valgrind error except mentioned fsck/012 above.
> 
> Qu Wenruo (6):
>   btrfs-progs: tests/common: Don't call INSTRUMENT on mount command
>   btrfs-progs: check/original: Fix uninitialized stack memory access for
>     deal_root_from_list()
>   btrfs-progs: check/original: Fix uninitialized memory for newly
>     allocated data_backref
>   btrfs-progs: check/original: Fix uninitialized return value from
>     btrfs_write_dirty_block_groups()
>   btrfs-progs: check/original: Fix uninitialized extent buffer contents
>   btrfs-progs: extent-tree: Fix wrong post order rb tree cleanup for
>     block groups

Added to devel.
