Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E0313C8BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 17:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAOQGK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 11:06:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:50034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOQGK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 11:06:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45501AD07;
        Wed, 15 Jan 2020 16:06:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1394FDA791; Wed, 15 Jan 2020 17:05:55 +0100 (CET)
Date:   Wed, 15 Jan 2020 17:05:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] btrfs: Fix return value while kcalloc fails in
 btrfs_rmap_block
Message-ID: <20200115160554.GR3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, YueHaibing <yuehaibing@huawei.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        nborisov@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200115142027.56960-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115142027.56960-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 15, 2020 at 10:20:27PM +0800, YueHaibing wrote:
> In btrfs_rmap_block(), if kcalloc fails, it should return
> -ENOMEM instead of 0.
> 
> Fixes: 767f58cdaf20 ("btrfs: Refactor btrfs_rmap_block to improve readability")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, folded to the patch.
