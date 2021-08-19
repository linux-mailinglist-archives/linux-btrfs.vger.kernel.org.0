Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C963F1918
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 14:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhHSM1B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 08:27:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53824 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSM1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 08:27:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E5C2D1FD93;
        Thu, 19 Aug 2021 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629375983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkJrcJABEGet9IUKBhdqqwdGpztxVrftV3J0H3Re8ao=;
        b=ZdC8n6xJ9Nu9mPvf3pC0VxfVFQ7g2KcL/PYMnBjpz4NEyx/Q/Og2fB3szIP80XIQ3AEnM+
        G7w7XuzufR6Oi9v969IVWpE19sAEaNft3j77JEf0CHsaB68a2Pkv/WCRXO4ur7D8OKSZIv
        iCh+3K3yk78Qrobg1dTerwcsEuVHXwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629375983;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkJrcJABEGet9IUKBhdqqwdGpztxVrftV3J0H3Re8ao=;
        b=RbdDARfoKXUZinSFV0hgbk9YBXKtbcFhd3mg0kZM0YNkTmDcermaEPJc0PU+Tt945uOzpg
        JWOdx98X1fF7RYAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5A301A3B9F;
        Thu, 19 Aug 2021 12:26:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ADDEEDA72C; Thu, 19 Aug 2021 14:23:26 +0200 (CEST)
Date:   Thu, 19 Aug 2021 14:23:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: replace BUG_ON() in btrfs_csum_one_bio() with
 proper error handling
Message-ID: <20210819122326.GD5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210816235540.9475-1-wqu@suse.com>
 <8babcc1b-2456-8632-7b56-f9867d333a0d@suse.com>
 <ac42cd2a-82dd-1987-4e18-e9d27e127172@gmx.com>
 <20210818230032.GA5047@twin.jikos.cz>
 <0f469eae-d30f-64cf-b07f-fb0a097e6741@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f469eae-d30f-64cf-b07f-fb0a097e6741@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 09:08:00AM +0800, Qu Wenruo wrote:
> I want to play safe by never bothering the WARN_ON() in if () condition
> anymore.
> 
> The fact that some if (WARN_ON()) is acceptable and some is not is
> already worrying.
> 
> Can we just stick to no-WARN_ON-in-if policy?

So what would be the reocommended way to do that? Also with the obvious
question "is the warning needed at all?"

	if (condition) {
		WARN_ON(1);
		...
	}

This will hide the condition in the warning report, the value is usually
in RAX and sometimes it helps to analyze what happend. We'd have to
either duplicate it like

	if (condition) {
		WARN_ON(condition);
		...
	}

or use a temporary variable.

Another question is what to do with current if+WARN calls. Lots of them
are there without a comment. Ideally if there's a need for a warning
even on a production build, there should be a message also printed.

Lots of them seem to be an assert in disguise (like in
extract_ordered_extent) or are called before returning EUCLEAN. We've
talked about this a few times before, we'd need more fine grained
warnings/assertions or have them better documented. There are 300+ of
them so that's a lot for a single pass audit, but at least some of them
share a common pattern and can be unified.
