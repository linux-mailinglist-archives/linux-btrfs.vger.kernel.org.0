Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4BE34D6AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC2SND (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Mar 2021 14:13:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231134AbhC2SMl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 14:12:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC67FAFE8;
        Mon, 29 Mar 2021 18:12:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7855DA842; Mon, 29 Mar 2021 20:10:32 +0200 (CEST)
Date:   Mon, 29 Mar 2021 20:10:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update outdated comment at
 btrfs_replace_file_extents()
Message-ID: <20210329181032.GO7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <32f9e43d999fcfaa2927513d7563790a5292fd7b.1616764397.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f9e43d999fcfaa2927513d7563790a5292fd7b.1616764397.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 26, 2021 at 01:14:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There is a comment at btrfs_replace_file_extents() that mentions that we
> set the full sync flag on an inode when cloning into a file with a size
> greater than or equals to 16MiB, through try_release_extent_mapping() when
> we truncate the page cache after replacing file extents during a clone
> operation.
> 
> That is not true anymore since commit 5e548b32018d96 ("btrfs: do not set
> the full sync flag on the inode during page release"), so update the
> comment to remove that part and rephrase it slightly to make it more
> clear why the full sync flag is set at btrfs_replace_file_extents().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
