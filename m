Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD1C3B5E6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhF1M4Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 08:56:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhF1M4Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 08:56:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2611D2028C;
        Mon, 28 Jun 2021 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624884839;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKVjVMrVPBFeCnK/n7uN9JueuOHCtAmbxUIBNkBtv9A=;
        b=l8hX+fNHT3t/4MoZnSjwzdjfTyTLlOJK7l073xnAFBO6bHfavv61QsTHCeCdhlBRoJ01JO
        AuOVmM46sNyWxxxCyNh0qnkwsDetpIwjpB1AKEZ8OAzTLCAPSOq8h3KxLqrr58t5Ml8hZ/
        mWxQPrXP3VzIaICkFCWMVxWsJy8GDAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624884839;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKVjVMrVPBFeCnK/n7uN9JueuOHCtAmbxUIBNkBtv9A=;
        b=dTsEkIXYinkloemSqpcCXpllMh/rbqPVYIR1j4aPvMQ8P9dGZmuz8/6lenl2H9SW9njU8E
        r8ZfqN5T+4t2+iBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9B4B3A3B9B;
        Mon, 28 Jun 2021 12:53:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ABD06DA7F7; Mon, 28 Jun 2021 14:51:29 +0200 (CEST)
Date:   Mon, 28 Jun 2021 14:51:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Message-ID: <20210628125129.GD2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
References: <20210628083050.5302-1-13145886936@163.com>
 <ee06042f-da1a-9137-dda3-b8f14bf1b79a@gmx.com>
 <DM6PR04MB7081A02339DB3ACC72F86261E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <PH0PR04MB7416F1BC157F848540DF37389B039@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e73fd408-d5c3-0e17-b3f4-e12f2c105bc0@gmx.com>
 <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210628120435.GC2610@twin.jikos.cz>
 <ce9083c7-ed1c-1248-484b-3b8650734f52@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce9083c7-ed1c-1248-484b-3b8650734f52@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 28, 2021 at 08:19:28PM +0800, Qu Wenruo wrote:
> On 2021/6/28 下午8:04, David Sterba wrote:
> > On Mon, Jun 28, 2021 at 09:48:40AM +0000, Damien Le Moal wrote:
> >> This one is actually a good fix :)
> > 
> > It's not a good fix and has been posted several times already. What
> > needs to be done in this function is to propagate error codes from the
> > whole call tree starting in that function. Removing code triggering a
> > warning is perhaps the simplest thing to make the warning go away but
> > the right fix needs some understanding of the function and context.
> > 
> > The patch also comes without any explanation so that does not help to
> > back the intentions to remove it. Reveiew of such path is "Please
> > explain".
> > 
> > Replying to patches attempting to fix the warning (and not the code)
> > does not seem to help, it's just pointing to the previous iterations.
> 
> But in this particular patch, it's really doing proper cleanup.
> 
> The truth is, the whole function, btrfs_destroy_delayed_refs(), only get 
> called when a transaction is aborted, and to cleanup all pending delayed 
> refs.
> 
> Thus in this particular function, there is nothing to return an error, 
> since we're already erroring out.
> 
> And in fact we should use void for btrfs_destroy_delayed_refs().
> 
> Thus opposite to my initial thought, it's in fact OK for the cleanup.
> Just one step left to change the function to return void.
> 
> And obviously, with all these comment above added to commit message.

The logic about making a function void and removing the return value has
some assumptions:

- no BUG/BUG_ON inside the function itself
- all called functions are return-value clean and either handle
  everything transparently or return a value
- the above applies recursively to the whole call chain

btrfs_destroy_delayed_refs itself contains one BUG, so that needs to be
fixed. The whole problem of making it void is in the pinned rage, see
eg. btrfs_error_unpin_extent_range. Nikolay did some cleanups there but
there are still some BUGs left in place of error handling, namely in
unpin_extent_range and I did not check completely.

I understand that it's tempting to just turn the function to void,
because there's nothing obviously wrong, but that's only on first sight.
A proper review must follow the code and once there's unhandled error
deeper in the callchain, it has to be solved first.

IIRC we've cleaned most of if not all the easy cases so it may not be
that easy to identify something we haven't seen yet. I'll put something
to the wiki in case people are interested. There's
https://btrfs.wiki.kernel.org/index.php/Project_ideas#Cleanup_projects
it hasn't been up to date but it is the place where to look for such
things.
