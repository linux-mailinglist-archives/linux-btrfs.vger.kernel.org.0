Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE37A150F27
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgBCSMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 13:12:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:53928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbgBCSMO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 13:12:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B45C2AD89;
        Mon,  3 Feb 2020 18:12:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 517E4DA7A1; Mon,  3 Feb 2020 19:11:59 +0100 (CET)
Date:   Mon, 3 Feb 2020 19:11:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/6] btrfs: introduce the inode->file_extent_tree
Message-ID: <20200203181159.GC2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <20200117140224.42495-1-josef@toxicpanda.com>
 <20200117140224.42495-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117140224.42495-4-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 09:02:21AM -0500, Josef Bacik wrote:
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index a3febe746c79..c8bcd2e3184c 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -44,6 +44,7 @@ enum {
>  	IO_TREE_TRANS_DIRTY_PAGES,
>  	IO_TREE_ROOT_DIRTY_LOG_PAGES,
>  	IO_TREE_SELFTEST,
> +	IO_TREE_INODE_FILE_EXTENT,

I've reordered the two and added the missing enum -> string map for the
tracepoints.
