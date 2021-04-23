Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225D9369081
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Apr 2021 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhDWKqR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 06:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhDWKqR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 06:46:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54620AE38;
        Fri, 23 Apr 2021 10:45:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3028ADA7FE; Fri, 23 Apr 2021 12:43:20 +0200 (CEST)
Date:   Fri, 23 Apr 2021 12:43:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: Correct try_lock_extent() usage in
 read_extent_buffer_subpage()
Message-ID: <20210423104320.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20210408124025.ljsgund6jfc5c55y@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408124025.ljsgund6jfc5c55y@fiona>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 08, 2021 at 07:40:25AM -0500, Goldwyn Rodrigues wrote:
> try_lock_extent() returns 1 on success or 0 for failure and not an error
> code. If try_lock_extent() fails, read_extent_buffer_subpage() returns
> zero indicating subpage extent read success.
> 
> Return EAGAIN/EWOULDBLOCK if try_lock_extent() fails in locking the
> extent.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Added to misc-next, thanks.
