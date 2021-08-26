Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A193F89D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhHZOLy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 10:11:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58654 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHZOLx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 10:11:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5B6B01FE8D;
        Thu, 26 Aug 2021 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629987065;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OX/mFzb13r8Bs1QFM1eohwTatctwiIbJkBIgWBdbd/A=;
        b=i/BYmwO0yesykP+nCNjJIzUze2LO2TTQcosa6w6cQQSx/O0tndDV9P4nRCQ3zJCCcHdnQ/
        mvNzFcopS5+QZo11owf5jtXdjqXQKGGY/Uhge+dP2RGHmN/lMUmgR4PtaJTpEntM10kV+4
        lemmDaM+SZ4GJw62EXt5kLDEc6qFEMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629987065;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OX/mFzb13r8Bs1QFM1eohwTatctwiIbJkBIgWBdbd/A=;
        b=LKwrOgoDMDjN1gq74eKKlmu3RJ2d2pwYiOsq2o39vkOePXorEfwnHGNwQbyHBkDgrVGDc/
        5qpI3Yj31ddlUHBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 54054A3B8C;
        Thu, 26 Aug 2021 14:11:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3ECF8DA7F3; Thu, 26 Aug 2021 16:08:17 +0200 (CEST)
Date:   Thu, 26 Aug 2021 16:08:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2] btrfs: reflink: Initialize return value in
 btrfs_extent_same()
Message-ID: <20210826140817.GM3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        Filipe Manana <fdmanana@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20210820004100.35823-1-realwakka@gmail.com>
 <CAL3q7H5UvRXk7TLQOt-bnkN4Tca-v7c6JBW6vz90KEaYJuMp1g@mail.gmail.com>
 <20210823235134.GA45534@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823235134.GA45534@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 11:51:34PM +0000, Sidong Yang wrote:
> On Mon, Aug 23, 2021 at 10:44:08AM +0100, Filipe Manana wrote:
> > On Fri, Aug 20, 2021 at 1:42 AM Sidong Yang <realwakka@gmail.com> wrote:
> > >
> > > btrfs_extent_same() cannot be called with zero length. This patch add
> > > code that initialize ret as -EINVAL to make it safe.
> > 
> > I suppose the motivation of the patch is to fix a warning from smatch,
> > or other similar tools, about 'ret' not being initialized when olen is
> > 0.
> 
> Yes, Actually I used smatch you said.

It's good to mention that it's a warning reported by some tool, not all
such warnings are valid or have to be fixed.

> > Initializing 'ret' to some value surely makes the warning go away,
> > even though it's not possible for olen to be 0 at btrfs_extent_same(),
> > as that
> > is filtered up in the call chain.
> > 
> > However setting to -EINVAL by default is confusing and counter
> > intuitive because dedupe operations are supposed to return 0 (success)
> > for a 0 length range.
> 
> Yeah, I think it depends on btrfs_extent_same()'s concept. It does
> nothing when 0 length. It's okay if we consider it's normal operation
> and it seems natural.
> 
> >
> > So 'ret' should be initialized to 0 to avoid any confusion.
> 
> Agree. I want to know other people's thoughts.

I agree with Filipe, please resend the patch with ret = 0 and
explanation why want it. Thanks.
