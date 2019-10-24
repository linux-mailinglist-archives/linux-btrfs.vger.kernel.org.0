Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCDE3C29
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 21:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437128AbfJXTkJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 15:40:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfJXTkJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 15:40:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0EBCB12E;
        Thu, 24 Oct 2019 19:40:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 828DBDA733; Thu, 24 Oct 2019 21:40:19 +0200 (CEST)
Date:   Thu, 24 Oct 2019 21:40:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Consider system chunk array size for new
 SYSTEM chunks
Message-ID: <20191024194019.GK3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190828023313.22417-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828023313.22417-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 28, 2019 at 10:33:12AM +0800, Qu Wenruo wrote:
> For SYSTEM chunks, despite the regular chunk item size limit, there is
> another limit due to system chunk array size.
> 
> The extra limit is removed in a refactor, so just add it back.
> 
> Fixes: e3ecdb3fdecf ("btrfs: factor out devs_max setting in __btrfs_alloc_chunk")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

So these patches fix test btrfs/194 failure, and given the regression
also worth pushing to 5.4-rc.
