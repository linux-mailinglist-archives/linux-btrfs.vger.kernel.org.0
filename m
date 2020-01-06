Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D31316A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 18:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgAFRWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 12:22:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:36358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgAFRWr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 12:22:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6646B12C;
        Mon,  6 Jan 2020 17:22:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7A9BDA78B; Mon,  6 Jan 2020 18:22:35 +0100 (CET)
Date:   Mon, 6 Jan 2020 18:22:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] btrfs: introduce the inode->file_extent_tree
Message-ID: <20200106172234.GN3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20191230213118.7532-1-josef@toxicpanda.com>
 <20191230213118.7532-3-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230213118.7532-3-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 30, 2019 at 04:31:15PM -0500, Josef Bacik wrote:
> @@ -60,6 +60,11 @@ struct btrfs_inode {
>  	 */
>  	struct extent_io_tree io_failure_tree;
>  
> +	/* keeps track of where we have extent items mapped in order to make
> +	 * sure our i_size adjustments are accurate.
> +	 */
> +	struct extent_io_tree file_extent_tree;

This is not exactly lightweight and cut to the minimum needed, the size
is 40 bytes and contains struct members that are unused. At least the
file extents tree seems to be in use unlike that io_failure_tree wasting
the bytes almost 100% of time.
