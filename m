Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D08D118F3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfLJRpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 12:45:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:33226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727527AbfLJRpU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 12:45:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F733AC2F;
        Tue, 10 Dec 2019 17:45:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8703EDA727; Tue, 10 Dec 2019 18:45:19 +0100 (CET)
Date:   Tue, 10 Dec 2019 18:45:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/9] btrfs: remove redundant i_size check in
 __extent_writepage_io()
Message-ID: <20191210174518.GE3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1575336815.git.osandov@fb.com>
 <365cd6fdadd6a91c22ccf61fcb1deb688763a176.1575336816.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <365cd6fdadd6a91c22ccf61fcb1deb688763a176.1575336816.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 05:34:22PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In __extent_writepage_io(), we check whether
> i_size <= page_offset(page).
> 
> Note that if i_size < page_offset(page), then
> i_size >> PAGE_SHIFT < page->index. If i_size == page_offset(page), then
> i_size >> PAGE_SHIFT == page->index && offset_in_page(i_size) == 0.
> 
> __extent_writepage() already has a check for these cases that
> returns without calling __extent_writepage_io():
> 
>   end_index = i_size >> PAGE_SHIFT
>   pg_offset = offset_in_page(i_size);
>   if (page->index > end_index ||
>      (page->index == end_index && !pg_offset)) {
>           page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
>           unlock_page(page);
>           return 0;
>   }
> 
> Get rid of the one in __extent_writepage_io(), which was obsoleted in
> 211c17f51f46 ("Fix corners in writepage and btrfs_truncate_page").
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: David Sterba <dsterba@suse.com>
