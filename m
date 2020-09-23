Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C1275830
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 14:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgIWMrY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 08:47:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgIWMrY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 08:47:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D8F1CB2B5;
        Wed, 23 Sep 2020 12:47:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4B48DA6E3; Wed, 23 Sep 2020 14:46:06 +0200 (CEST)
Date:   Wed, 23 Sep 2020 14:46:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: send, fix some failures due to commands with
 wrong paths
Message-ID: <20200923124606.GM6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1600693246.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600693246.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 21, 2020 at 02:13:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Incremental send operations can often fail at the receiver due to a wrong
> path in some command. This small patchset fixes a few more cases where
> such problems happen. There are sporadic reports of this type of failures,
> such as [1] and [2] for example, and many similar issues were fixed in a
> more distant past. Without having the full directory trees of the parent
> and send snapshots, with inode numbers, it's hard to tell if this patchset
> fixes exactly those reported cases, but the cases fixed by this patchset
> are all I could find in the last two weeks.
> 
> [1] https://lore.kernel.org/linux-btrfs/57021127-01ea-6533-6de6-56c4f22c4a5b@gmail.com/
> [2] https://lore.kernel.org/linux-btrfs/87a7obowwn.fsf@lausen.nl/
> 
> 
> Filipe Manana (2):
>   btrfs: send, orphanize first all conflicting inodes when processing
>     references
>   btrfs: send, recompute reference path after orphanization of a
>     directory

Thanks, added to misc-next.
