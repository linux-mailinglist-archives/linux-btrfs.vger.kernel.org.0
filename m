Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02132C8F48
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 21:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgK3Ufg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 15:35:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:42132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgK3Ufg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 15:35:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21B7AABD7;
        Mon, 30 Nov 2020 20:34:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88FA0DA6E1; Mon, 30 Nov 2020 21:33:23 +0100 (CET)
Date:   Mon, 30 Nov 2020 21:33:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v7 00/10] btrfs: free space tree mounting fixes
Message-ID: <20201130203323.GL6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1605736355.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605736355.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 18, 2020 at 03:06:15PM -0800, Boris Burkov wrote:
> This patch set cleans up issues surrounding enabling and disabling various
> free space cache features and their reporting in /proc/mounts.  Because the
> improvements became somewhat complex, the series starts by lifting rw mount
> logic into a single place.
> 
> Boris Burkov (12):
>   btrfs: lift rw mount setup from mount and remount
>   btrfs: cleanup all orphan inodes on ro->rw remount
>   btrfs: only mark bg->needs_free_space if free space tree is on
>   btrfs: create free space tree on ro->rw remount
>   btrfs: clear oneshot options on mount and remount
>   btrfs: clear free space tree on ro->rw remount
>   btrfs: keep sb cache_generation consistent with space_cache
>   btrfs: use sb state to print space_cache mount option
>   btrfs: warn when remount will not change the free space tree
>   btrfs: remove free space items when disabling space cache v1
>   btrfs: skip space_cache v1 setup when not using it
>   btrfs: fix lockdep error creating free space tree

Moved from topic branch to misc-next, with some more fixups. I can do
some fixups until the end of this week. We need test coverage for
various ro->rw and v1/v2/no transitions, I'm aware you sent something
for fstests but haven't looked so far. The whole core for the v1->v2
conversion is there, from now on please send fixes as new patches.
Thanks.
