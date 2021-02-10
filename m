Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923C317486
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 00:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhBJXgT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 18:36:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:41316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232045AbhBJXgR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 18:36:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBFDDACB7;
        Wed, 10 Feb 2021 23:35:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 460DFDA6E9; Thu, 11 Feb 2021 00:33:42 +0100 (CET)
Date:   Thu, 11 Feb 2021 00:33:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2] btrfs: rework the order of btrfs_ordered_extent::flags
Message-ID: <20210210233342.GB1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20210126003545.8885-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126003545.8885-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 26, 2021 at 08:35:45AM +0800, Qu Wenruo wrote:
> --- a/fs/btrfs/ordered-data.h
> +++ b/fs/btrfs/ordered-data.h
> @@ -27,7 +27,7 @@ struct btrfs_ordered_sum {
>  };
>  
>  /*
> - * bits for the flags field:
> + * Bits for btrfs_ordered_extent::flags.
>   *
>   * BTRFS_ORDERED_IO_DONE is set when all of the blocks are written.
>   * It is used to make sure metadata is inserted into the tree only once
> @@ -38,24 +38,36 @@ struct btrfs_ordered_sum {
>   * IO is done and any metadata is inserted into the tree.
>   */
>  enum {
> +	/*
> +	 * Different types for ordered extent, one and only one of the 4 types
> +	 * can be set when creating ordered extent.

Sorry, I did not merge this followup in time for the 5.12 freeze and now
it would be too late to rebase the whole branch just to fix a comment.

The difference is 'types for direct io' and the 'the 4 type' (typo).
Please send an incremental patch, the comment would be incorrect and is
worth fixing. Thanks.
