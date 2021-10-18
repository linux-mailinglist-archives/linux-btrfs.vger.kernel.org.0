Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830D143231B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhJRPlo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:41:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48018 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhJRPlk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:41:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F1301FD7F;
        Mon, 18 Oct 2021 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634571568;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNJFWNwl0KvwWOh/A+Mj5Wlz+NHBPTshYeOvf9VUlp8=;
        b=YyFkSizFLl8b0JH6+/3oGI64W/S3WpKlNtZJpUXHZeVZBxw541F3L2bmLXSbKsO5RU9Fvj
        mUNCc2aC22ZxFWup0uLKrckP+JcK6OuCf4Mebth0BujJHppV+izqzD6p1UA7wj7pWdR6gj
        qbcdCc8gthuRMQ7+kUIs/u4I85G4REE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634571568;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNJFWNwl0KvwWOh/A+Mj5Wlz+NHBPTshYeOvf9VUlp8=;
        b=MaMzfZJV3Tue+MvBhxTwXt2YdSoBpmq2F1BwvXmupu/PF0lnOvR53Rfn19tuppfndciV79
        nRhtFo/8JHcIw7Ag==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3DEA6A3B8A;
        Mon, 18 Oct 2021 15:39:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3DBA3DA7A3; Mon, 18 Oct 2021 17:39:01 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:39:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
Message-ID: <20211018153901.GL30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
 <9e808e25-ed2b-d114-dd50-97f3b7c295fe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e808e25-ed2b-d114-dd50-97f3b7c295fe@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 12:42:21PM +0300, Nikolay Borisov wrote:
> 
> 
> On 14.10.21 г. 12:39, Johannes Thumshirn wrote:
> > Currently auto reclaim of unusable zones reclaims the block-groups in the
> > order they have been added to the reclaim list.
> > 
> > Change this to a greedy algorithm by sorting the list so we have the
> > block-groups with the least amount of valid bytes reclaimed first.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > 
> > ---
> > Changes since v2:
> > - Go back to the RFC state, as we must not access ->bg_list
> >   without taking the lock. (Nikolay)
> 
> So following my feedback on his v2 Johannes added an assert for the
> emptylessn of the list which triggered. Turns out that's due to the fact
> unpin_extent_range calls __btrfs_add_free_space_zoned which adds a bg
> via its ->bg_list to the reclaim list. Actually accessing any of the
> blockgroups on reclaim_bgs list without holding unused_bg_lock is wrong,
> because even if reclaimi_bgs is spliced to a local list, each individual
> block group can still be accessed by other parts of the code and its
> ->bg_list used to link it to some list, all of this happens under
> unused_bgs_lock. So that's the reason why we need to keep the code as is.

Thanks, this is exactly what should appear in the changelog in case
there's a implementation we might do but can't for $reasons. I've
written a summary as a note.
