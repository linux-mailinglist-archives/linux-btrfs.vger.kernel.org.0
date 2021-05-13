Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7C3800BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 01:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhEMXRH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 19:17:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEMXRG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 19:17:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9F13AEAA;
        Thu, 13 May 2021 23:15:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DA70DA8EB; Fri, 14 May 2021 01:13:25 +0200 (CEST)
Date:   Fri, 14 May 2021 01:13:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 11/42] btrfs: introduce
 btrfs_lookup_first_ordered_range()
Message-ID: <20210513231325.GS7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-12-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230349.369603-12-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 28, 2021 at 07:03:18AM +0800, Qu Wenruo wrote:
> +struct btrfs_ordered_extent *
> +btrfs_lookup_first_ordered_range(struct btrfs_inode *inode, u64 file_offset,
> +				 u64 len)

Functions with return value that's long are sometimes awkward to format,
but the style I think is grep friendly is to put the return value and
name on the same line, the arguments go to the next line.

> +{
> +	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
> +	struct rb_node *n = tree->tree.rb_node;

Single letter variable names are hard to grep for inside the function,
so I've switched that to 'node'.
