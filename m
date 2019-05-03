Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3751813151
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfECPh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 11:37:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55092 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbfECPh5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 11:37:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E593AD1A;
        Fri,  3 May 2019 15:37:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08AD1DA885; Fri,  3 May 2019 17:38:55 +0200 (CEST)
Date:   Fri, 3 May 2019 17:38:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Rik van Riel <riel@fb.com>
Cc:     "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: don't double unlock on error in btrfs_punch_hole
Message-ID: <20190503153855.GJ20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Rik van Riel <riel@fb.com>,
        "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
References: <20190503151007.75525-1-josef@toxicpanda.com>
 <CAL3q7H6aoGNzYoXM7R5T4DsxYtOGZi0iaBEOiKB5GJrsXksaEA@mail.gmail.com>
 <b50d4c12828e720a965ef8c9c4b436383fa86f36.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b50d4c12828e720a965ef8c9c4b436383fa86f36.camel@fb.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 03, 2019 at 03:31:33PM +0000, Rik van Riel wrote:
> On Fri, 2019-05-03 at 16:25 +0100, Filipe Manana wrote:
> > On Fri, May 3, 2019 at 4:21 PM Josef Bacik <josef@toxicpanda.com>
> > wrote:
> > > If we have an error writing out a delalloc range in
> > > btrfs_punch_hole_lock_range we'll unlock the inode and then goto
> > > out_only_mutex, where we will again unlock the inode.  This is bad,
> > > don't do this.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> > 
> > Looks good, I introduced the double unlock accidentally.
> 
> Does the patch need a Fixes: tag so the -stable
> people know how far to backport it?

I add the tags.
