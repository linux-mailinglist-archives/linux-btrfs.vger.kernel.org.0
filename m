Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640AC3B5D94
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhF1MJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 08:09:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhF1MJb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 08:09:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6176520274;
        Mon, 28 Jun 2021 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624882025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ygu/BCsj8RXZyT6f2EzQPOTwRMsCpf8mrt8YMg1X1I=;
        b=WL+9YI3rPNH+eKaBI0mB4awQHLu0m/fJIw/iAxHTFVNX3ehDQDbnntkDMVVNQyroxCqPuO
        jVjzQVuMLksZv2iuJrix/UWQv3c2pYJtHtUCNQ7usBEBxhx2IUTXUt2U4wKFzlKax6LREW
        PAJitYAya9Pq4NfMerd0Zuuyo5+9+x0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624882025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ygu/BCsj8RXZyT6f2EzQPOTwRMsCpf8mrt8YMg1X1I=;
        b=KZSF6M0mdjOGByKVKwrqFgXY2JJEltmMnUqcoHHvPi3HpFMkDD8rzl8hcMWEKUE64CSpeW
        BUdxtRvprb8GxUCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DAC0DA3B92;
        Mon, 28 Jun 2021 12:07:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5D19DA7F7; Mon, 28 Jun 2021 14:04:35 +0200 (CEST)
Date:   Mon, 28 Jun 2021 14:04:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "13145886936@163.com" <13145886936@163.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] btrfs: remove unneeded variable: "ret"
Message-ID: <20210628120435.GC2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB70814C2126868BE1DE1DDC19E7039@DM6PR04MB7081.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 28, 2021 at 09:48:40AM +0000, Damien Le Moal wrote:
> This one is actually a good fix :)

It's not a good fix and has been posted several times already. What
needs to be done in this function is to propagate error codes from the
whole call tree starting in that function. Removing code triggering a
warning is perhaps the simplest thing to make the warning go away but
the right fix needs some understanding of the function and context.

The patch also comes without any explanation so that does not help to
back the intentions to remove it. Reveiew of such path is "Please
explain".

Replying to patches attempting to fix the warning (and not the code)
does not seem to help, it's just pointing to the previous iterations.

Everybody is free to run checkers, find the warnings and send patches,
that's fine and that's how open communities work.  But in this case
we'll probably have to put a note in code not to touch that particular
line/variable.

> Just did a make with gcc 11 and W=2 and this warning does not show up, but there
> are a lot more warnings about unused macros and some "variable may be used
> uninitialized" in the zone code... -> Johannes ?
> 
> There are lots of warnings about ffs() and other core functions not in btrfs
> code though.

That the higher W= warning levels are too noisy and have to be filtered
or specific issues fixed after manual selection. We've recently added a
more fine grained list of warnings that would apply only in fs/btrfs, so
if you find more that are worth fixing and then enabling by default, no
problem.

Some set-but-not used could be useful to point to code to analyze if
it's not obscuring some bug but given that thre are lots of instances in
the system includes we can't enable it.
