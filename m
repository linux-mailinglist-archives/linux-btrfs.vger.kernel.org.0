Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB54B760
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfFSLuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 07:50:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfFSLuH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 07:50:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3983AF7C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 11:50:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79762DA88C; Wed, 19 Jun 2019 13:50:53 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:50:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/6] btrfs: use common helpers for extent IO state
 insertion messages
Message-ID: <20190619115053.GB8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1560880630.git.dsterba@suse.com>
 <b7824fd41f86ac8bcb4dfd19565d590d97cbe2f5.1560880630.git.dsterba@suse.com>
 <39818dbd-efc1-7290-2c64-b1c2f9d71a91@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39818dbd-efc1-7290-2c64-b1c2f9d71a91@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 19, 2019 at 09:54:16AM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.06.19 г. 21:00 ч., David Sterba wrote:
> > Print the error messages using the helpers that also print the
> > filesystem identification.
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 8634eda07b7a..a6ad2f6f2bf7 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -524,9 +524,11 @@ static int insert_state(struct extent_io_tree *tree,
> >  {
> >  	struct rb_node *node;
> >  
> > -	if (end < start)
> > -		WARN(1, KERN_ERR "BTRFS: end < start %llu %llu\n",
> > -		       end, start);
> > +	if (end < start) {
> > +		btrfs_err(tree->fs_info,
> > +			"insert state: end < start %llu %llu", end, start);
> > +		WARN_ON(1);
> > +	}
> 
> nit: if (WARN_ON(end < start))
>        btrfs_err(...)

That's not the same. The message is printed after the warning and with
panic-on-warn it's not printed at all. WARN prints the format string
first, so btrfs_err+WARN_ON preserves that.
