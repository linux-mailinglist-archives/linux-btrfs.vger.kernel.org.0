Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB940BC84B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441047AbfIXM4E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 08:56:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:35830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395416AbfIXM4E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 08:56:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8EA69AEF8;
        Tue, 24 Sep 2019 12:56:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3CF6BDA959; Tue, 24 Sep 2019 14:56:22 +0200 (CEST)
Date:   Tue, 24 Sep 2019 14:56:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 01/12] btrfs-progs: don't blindly assume crc32c in
 csum_tree_block_size()
Message-ID: <20190924125622.GP2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190903150046.14926-1-jthumshirn@suse.de>
 <20190903150046.14926-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903150046.14926-2-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 05:00:35PM +0200, Johannes Thumshirn wrote:
> The callers of csum_tree_block_size() blindly assume we're only having
> crc32c as a possible checksum and thus pass in
> btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32] for the size argument of
> csum_tree_block_size().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> index 28912906d0a9..1ca71a4fcce5 100644
> --- a/mkfs/common.h
> +++ b/mkfs/common.h
> @@ -53,6 +53,8 @@ struct btrfs_mkfs_config {
>  	u64 features;
>  	/* Size of the filesystem in bytes */
>  	u64 num_bytes;
> +	/* checksum algorithm to use */
> +	enum btrfs_csum_type csum_type;

This is defined in the following patch so the compilation breaks here,
I'll see if reordering 1 and 2 fixes that.
