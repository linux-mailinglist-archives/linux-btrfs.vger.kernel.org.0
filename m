Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD602C685B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgK0PAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 10:00:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbgK0PAI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 10:00:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7D12ABD7;
        Fri, 27 Nov 2020 15:00:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D670FDA7D9; Fri, 27 Nov 2020 15:58:36 +0100 (CET)
Date:   Fri, 27 Nov 2020 15:58:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Remove deprecated inode cache feature
Message-ID: <20201127145836.GZ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201126131039.3441290-1-nborisov@suse.com>
 <20201126153135.GY6430@twin.jikos.cz>
 <90b5646b-cd53-f5bd-7214-44387c523203@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90b5646b-cd53-f5bd-7214-44387c523203@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 26, 2020 at 06:00:24PM +0200, Nikolay Borisov wrote:
> 
> 
> On 26.11.20 г. 17:31 ч., David Sterba wrote:
> > There's still the remaining issue what to do with the space occupied by
> > the cache inode if the feature was enabled. I haven't researched that,
> > eg. how big the inode is if it's worth removing it at all or if we
> > should do some lightweight scan to remove them at some appropriate time.
> 
> I'd rather implement this in btrfs-progs.

I did a quick check, 1M empty files created then every 7th deleted (so
there are no large ranges to free), resulting in ~140K files and that
occupied about 680KiB. So for 1M files it's about 5M of space, where
metadata part is small (<1KiB), the bitmaps are stored in hidden data
inodes.  All in all it does not sound like a terrible waste of space.
