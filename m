Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E840D46EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 19:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfJKRuQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 13:50:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:36426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728588AbfJKRuP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 13:50:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A84FB333;
        Fri, 11 Oct 2019 17:50:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F213CDA808; Fri, 11 Oct 2019 19:50:27 +0200 (CEST)
Date:   Fri, 11 Oct 2019 19:50:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: add missing extents release on file extent
 cluster relocation error
Message-ID: <20191011175027.GF2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20191009164345.23713-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009164345.23713-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 09, 2019 at 05:43:45PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we error out when finding a page at relocate_file_extent_cluster(), we
> need to release the outstanding extents counter on the relocation inode,
> set by the previous call to btrfs_delalloc_reserve_metadata(), otherwise
> the inode's block reserve size can never decrease to zero and metadata
> space is leaked. Therefore add a call to btrfs_delalloc_release_extents()
> in case we can't find the target page.
> 
> Fixes: 8b62f87bad9cf0 ("Btrfs: rework outstanding_extents")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
