Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2D3F4EB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhHWQtY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 12:49:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39584 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHWQtX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 12:49:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 25C0121FCD;
        Mon, 23 Aug 2021 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629737320;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVpJ2+g3yulFBVPgNdMuAgRYSKFDajmjsy97X2Lwymw=;
        b=f9oo9//cquJI0d3BrYWZoY0YxAxDSy7FaQOU89jZK++px5EmZK+aHAwARoE50ajpMIUzmq
        Qs1vT3mbqkSfkInrtPBoan46leS0bI7Ah/2VdZscrfK6UpESHa6dHmdiyJzyN9e/D99UZC
        LZZuID58+fniwbHeresUwcjUXXHs5Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629737320;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVpJ2+g3yulFBVPgNdMuAgRYSKFDajmjsy97X2Lwymw=;
        b=RVdfp+yD+j2CQQm7jLBB9k/IliUI0dym2wInuUzIGHUCm8JaDNC1jiGCK2PHXvyocFZ/Ud
        yXC1DqUFHIarV+DA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1E25BA3BBB;
        Mon, 23 Aug 2021 16:48:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AEC33DA725; Mon, 23 Aug 2021 18:45:40 +0200 (CEST)
Date:   Mon, 23 Aug 2021 18:45:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] btrfs: introduce btrfs_subpage_bitmap_info
Message-ID: <20210823164540.GG5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-4-wqu@suse.com>
 <7b9c1c27-1938-4702-e6b2-db5a840f7a84@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9c1c27-1938-4702-e6b2-db5a840f7a84@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 01:11:43PM +0300, Nikolay Borisov wrote:
> > +/*
> > + * Extra info for subpapge bitmap.
> > + *
> > + * For subpage we pack all uptodate/error/dirty/writeback/ordered
> > + * bitmaps into one larger bitmap.
> > + *
> > + * This structure records how they are organized in such bitmap:
> > + *
> > + * /- uptodate_offset	/- error_offset	/- dirty_offset
> > + * |			|		|
> > + * v			v		v
> > + * |u|u|u|u|........|u|u|e|e|.......|e|e| ...	|o|o|
> 
> nit: the 'e' that the dirty offset is pointing to should be a 'd', I'm
> sure David can fix this while merging.

I don't see any 'e' under the dirty offset arrow, there's just 'o' and
the arrow points to end of |e|e| and continues with ...
