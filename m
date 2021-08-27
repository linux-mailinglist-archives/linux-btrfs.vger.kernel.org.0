Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395163F96C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Aug 2021 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbhH0JWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Aug 2021 05:22:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36798 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhH0JWC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Aug 2021 05:22:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E1AFC2236D;
        Fri, 27 Aug 2021 09:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630056072;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjYcYL04fczge0xU/GI870F3yDVatDT3EvGr73D+alo=;
        b=oasU/Uze/701Lvsdkj+5e9BdatqIc9aEOEt4gJgwQekGgWKQwS7SgEv0kmHK91IyxEpYmy
        PT8UrDvR3EqHHv6cjkFZVdZ0iigP3bQefzjZuF5iXFL18atrM7SQrlHMRyfdBqavIEBIk0
        yke2jjDBeuN6AxxCspqKBKPSdfxkmW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630056072;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjYcYL04fczge0xU/GI870F3yDVatDT3EvGr73D+alo=;
        b=1xgwLolICaX6WZd/C7z1Buggj7TBASy5kbFXmbGtr4x5ecHy6OcPxhJHavvaf86CgBKN7F
        EhMTtCIWdy1qSyCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DBD8AA3B93;
        Fri, 27 Aug 2021 09:21:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 691C1DA7F3; Fri, 27 Aug 2021 11:18:24 +0200 (CEST)
Date:   Fri, 27 Aug 2021 11:18:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 00/11] btrfs: defrag: rework to support sector perfect
 defrag
Message-ID: <20210827091824.GU3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210806081242.257996-1-wqu@suse.com>
 <20210823194303.GS5047@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823194303.GS5047@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 23, 2021 at 09:43:03PM +0200, David Sterba wrote:
> On Fri, Aug 06, 2021 at 04:12:31PM +0800, Qu Wenruo wrote:
> > Now both regular sectorsize and subpage sectorsize can pass defrag test
> > group.
> 
> > Qu Wenruo (11):
> >   btrfs: defrag: pass file_ra_state instead of file for
> >     btrfs_defrag_file()
> >   btrfs: defrag: also check PagePrivate for subpage cases in
> >     cluster_pages_for_defrag()
> >   btrfs: defrag: replace hard coded PAGE_SIZE to sectorsize
> >   btrfs: defrag: extract the page preparation code into one helper
> >   btrfs: defrag: introduce a new helper to collect target file extents
> >   btrfs: defrag: introduce a helper to defrag a continuous prepared
> >     range
> >   btrfs: defrag: introduce a helper to defrag a range
> >   btrfs: defrag: introduce a new helper to defrag one cluster
> >   btrfs: defrag: use defrag_one_cluster() to implement
> >     btrfs_defrag_file()
> >   btrfs: defrag: remove the old infrastructure
> >   btrfs: defrag: enable defrag for subpage case
> 
> The patch 9 was taken from your git repository. Patchset now in a topic
> branch, I'll do one round and then move it to misc-next. Any followups
> please send as separate patches, thanks.

Now moved to misc-next, thanks.
