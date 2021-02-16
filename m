Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F41431CC22
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 15:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhBPOiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 09:38:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:40602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230446AbhBPOg5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 09:36:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D7BD8AD3E;
        Tue, 16 Feb 2021 14:36:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D23B6DA6EF; Tue, 16 Feb 2021 15:34:19 +0100 (CET)
Date:   Tue, 16 Feb 2021 15:34:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: ordered-extent: fix comment for btrfs ordered
 extent flag bits
Message-ID: <20210216143419.GP1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210211081405.392006-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211081405.392006-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 11, 2021 at 04:14:05PM +0800, Qu Wenruo wrote:
> There is small error in comment about BTRFS_ORDERED_* flags.
> 
> The 4 types are for ordered extent itself, not for direct io.
> Only 3 types support direct io, REGULAR/NOCOW/PREALLOC.
> 
> Fix the comment to reflect that.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
