Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84D864DA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2019 16:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfHHOxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Aug 2019 10:53:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44058 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbfHHOxk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Aug 2019 10:53:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E3FAAEB3
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2019 14:53:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D6B6DA7C5; Thu,  8 Aug 2019 16:54:08 +0200 (CEST)
Date:   Thu, 8 Aug 2019 16:54:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v1.1 1/3] btrfs: tree-checker: Add EXTENT_ITEM and
 METADATA_ITEM check
Message-ID: <20190808145407.GA8267@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190807140843.2728-1-wqu@suse.com>
 <20190807140843.2728-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807140843.2728-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 07, 2019 at 10:08:41PM +0800, Qu Wenruo wrote:
> +
> +static int check_extent_item(struct extent_buffer *leaf,
> +			     struct btrfs_key *key, int slot)
> +{
> +	struct btrfs_fs_info *fs_info = leaf->fs_info;
> +	struct btrfs_extent_item *ei;
> +	bool is_tree_block = false;
> +	u64 ptr;	/* Current pointer inside inline refs */

While u64 is wide enough, I suggest to use unsigned long as the
intermediate type for pointer conversions.
