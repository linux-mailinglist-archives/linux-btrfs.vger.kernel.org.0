Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF76E1FD251
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQQjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 12:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:49910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFQQjK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 12:39:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BCC3CAC52;
        Wed, 17 Jun 2020 16:39:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DB61DA728; Wed, 17 Jun 2020 18:38:59 +0200 (CEST)
Date:   Wed, 17 Jun 2020 18:38:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Refactor prealloc_file_extent_cluster
Message-ID: <20200617163859.GP27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200617091044.27846-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617091044.27846-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 17, 2020 at 12:10:41PM +0300, Nikolay Borisov wrote:
> Those 3 minor patches refactor prealloc_file_extent_cluster by:
> 
> 1. Removing useless check
> 2. Re-order code around to make heavyweight operations outside of inode lock,
> (not that it matters for performance) and also get rid of the out label
> 3. Switch a while to a for loop to make the loop intentino more explicit.
> 
> 
> Nikolay Borisov (3):
>   btrfs: Remove hole  check in prealloc_file_extent_cluster
>   btrfs: Perform data management operations outside of inode lock
>   btrfs: Use for loop in prealloc_file_extent_cluster

Added to misc-next, thanks.
