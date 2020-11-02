Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA772A2D7F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 15:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKBO6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 09:58:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:52552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgKBO6D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 09:58:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02E81AC53;
        Mon,  2 Nov 2020 14:58:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4231DA7D2; Mon,  2 Nov 2020 15:56:24 +0100 (CET)
Date:   Mon, 2 Nov 2020 15:56:24 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/68] btrfs: add basic rw support for subpage sector
 size
Message-ID: <20201102145624.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 02:24:46PM +0800, Qu Wenruo wrote:
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage_data_fullpage_write
> 
> Qu Wenruo (67):

So far I've merged

      btrfs: extent_io: fix the comment on lock_extent_buffer_for_io()
      btrfs: extent_io: update the comment for find_first_extent_bit()
      btrfs: extent_io: sink the failed_start parameter to set_extent_bit()
      btrfs: disk-io: replace fs_info and private_data with inode for btrfs_wq_submit_bio()
      btrfs: inode: sink parameter start and len to check_data_csum()
      btrfs: extent_io: rename pages_locked in process_pages_contig()
      btrfs: extent_io: only require sector size alignment for page read
      btrfs: extent_io: rename page_size to io_size in submit_extent_page()

to misc-next.  This is from the first 20, the easy and safe changes.
There are few more that need more explanation or another look.
