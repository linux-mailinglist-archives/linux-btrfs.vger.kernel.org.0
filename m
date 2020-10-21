Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C3E29549D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Oct 2020 00:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505627AbgJUWAR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 18:00:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:54644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505531AbgJUWAR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 18:00:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B72FAC0C;
        Wed, 21 Oct 2020 22:00:16 +0000 (UTC)
Date:   Wed, 21 Oct 2020 17:00:12 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 07/68] btrfs: disk-io: replace @fs_info and
 @private_data with @inode for btrfs_wq_submit_bio()
Message-ID: <20201021220012.sct2gz2o3km3zqsk@fiona>
References: <20201021062554.68132-1-wqu@suse.com>
 <20201021062554.68132-8-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021062554.68132-8-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just some commit header re-phrase 

On 14:24 21/10, Qu Wenruo wrote:
> All callers for btrfs_wq_submit_bio() passes struct inode as
              of                        pass                of

> @private_data, so there is no need for @private_data to be (void *),
> just replace it with "struct inode *inode".
> 
> While we can extra fs_info from struct inode, also remove the @fs_info
> parameter.

Since we can extract fs_info

> 
> Since we're here, also replace all the (void *private_data) into (struct
> inode *inode).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

-- 
Goldwyn
