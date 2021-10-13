Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E6342C04E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 14:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhJMMo5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 08:44:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52464 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbhJMMoy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A923D20128;
        Wed, 13 Oct 2021 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634128970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hil4MpnCH1kkesaFuAgygK7JGwMX4FO6wBrqDLf8eoM=;
        b=JYklM3u21P4gCk0evLWpxyaIbEmXu8uKnPBsYDhWUVUdjONsClk10afYwlzCaSnDZuUdVQ
        zvWRo4KtNt9kk33vpk4wdjAINyCoBczQuQYyXOjlN00rNyYmmEJrIUNFo3IF539pg3uOi3
        tk8R+qx+ce4/64RcTKzogr/eBQQdPPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634128970;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hil4MpnCH1kkesaFuAgygK7JGwMX4FO6wBrqDLf8eoM=;
        b=UqK2NnrXpM0LiYuH+cF7B07rnxv9JTGEg4fHx9bAN2O7uEww4LG/oZsDSG0pU+opUadq8L
        BKTx4QTKDb7N/hCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F1823A3B88;
        Wed, 13 Oct 2021 12:42:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 88D0ADA7A3; Wed, 13 Oct 2021 14:42:26 +0200 (CEST)
Date:   Wed, 13 Oct 2021 14:42:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: parse-utils: allow single number qgroup id
Message-ID: <20211013124226.GE9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20211011070937.32419-1-wqu@suse.com>
 <20211011132132.GH9286@twin.jikos.cz>
 <bf23e581-e03a-7254-b6d7-b9d67efaadc0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf23e581-e03a-7254-b6d7-b9d67efaadc0@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 12, 2021 at 06:59:30PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/10/11 21:21, David Sterba wrote:
> > On Mon, Oct 11, 2021 at 03:09:37PM +0800, Qu Wenruo wrote:
> >> [BUG]
> >> Since btrfs-progs v5.14, fstests/btrfs/099 always fail with the
> >> following output in 099.full:
> >>
> >>    ...
> >>    # /usr/bin/btrfs quota enable /mnt/scratch
> >>    # /usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch
> >>    ERROR: invalid qgroupid or subvolume path: 5
> >>    failed: '/usr/bin/btrfs qgroup limit 134217728 5 /mnt/scratch'
> >>
> >> [CAUSE]
> >> Since commit cb5a542871f9 ("btrfs-progs: factor out plain qgroupid
> >> parsing"), btrfs qgroup parser no longer accepts single number qgroup id
> >> like "5" used in that test case.
> >>
> >> That commit is not a plain refactor without functional change, but
> >> removed a simple feature.
> >>
> >> [FIX]
> >> Add back the handling for single number qgroupid.
> >
> > This unfortunately breaks something else, as it's changing the whole
> > parse_qgroupid helper to accept single value id, which is also used for
> > 'qgroup create'.
> 
> For 'qgroup create' I think it's OK to accept single value id.
> 
> It's a handy shortcut for '0/<subvolid>'.

The 0/subvolid qgroup cannot be created manually IIRC.
