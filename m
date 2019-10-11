Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E00D485D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 21:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfJKTXB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 15:23:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:53004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728776AbfJKTXB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 15:23:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C871B4A0;
        Fri, 11 Oct 2019 19:22:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08801DA808; Fri, 11 Oct 2019 21:23:12 +0200 (CEST)
Date:   Fri, 11 Oct 2019 21:23:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] btrfs: block-group: Fix a memory leak due to
 missing btrfs_put_block_group()
Message-ID: <20191011192311.GK2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010023928.24586-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 10:39:26AM +0800, Qu Wenruo wrote:
> In btrfs_read_block_groups(), if we have an invalid block group which
> has mixed type (DATA|METADATA) while the fs doesn't have MIX_BGS
> feature, we error out without freeing the block group cache.
> 
> This patch will add the missing btrfs_put_block_group() to prevent
> memory leak.
> 
> Fixes: 49303381f19a ("Btrfs: bail out if block group has different mixed flag")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Please send independent fixes out of feature patchsets so it does not
get lost due to priorities fixes vs features. I'll add it to misc-next
and queue for 5.4. Thanks.
