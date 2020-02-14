Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4415E767
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 17:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392143AbgBNQxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 11:53:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:56690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404393AbgBNQxv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 11:53:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 793CEB019;
        Fri, 14 Feb 2020 16:53:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E4A8BDA703; Fri, 14 Feb 2020 17:53:34 +0100 (CET)
Date:   Fri, 14 Feb 2020 17:53:34 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Add comment for BTRFS_ROOT_REF_COWS
Message-ID: <20200214165334.GC2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200212074651.33008-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212074651.33008-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 03:46:51PM +0800, Qu Wenruo wrote:
> This bit is being used in too many locations while there is still no
> good enough explaination for how this bit is used.
> 
> Not to mention its name really doesn't make much sense.
> 
> So this patch will add my explanation on this bit, considering only
> subvolume trees, along with its reloc trees have this bit, to me it
> looks like this bit shows whether tree blocks of a root can be shared.

I think there's more tan just sharing, it should say something about
reference counted sharing. See eg. btrfs_block_can_be_shared:

 864         /*
 865          * Tree blocks not in reference counted trees and tree roots
 866          * are never shared. If a block was allocated after the last
 867          * snapshot and the block was not allocated by tree relocation,
 868          * we know the block is not shared.
 869          */

And there can be more specialities found when grepping for REF_COWS. The
comment explaination should be complete or at least mention what's not
documenting. The I find the suggested version insufficient but don't
have a concrete suggestions for improvement. By reading the comment and
going through code I don't feel any wiser.
