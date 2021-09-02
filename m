Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480CD3FF14E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbhIBQ0E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 12:26:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhIBQ0E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 12:26:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E8C5020382;
        Thu,  2 Sep 2021 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630599904;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=un9uvgee6I8cNno4S8CRlPoXS3z+/NvaWpUIRKlC2s4=;
        b=v6SUgtKcDl5d+RDF/iSsriauava5phQjHI29Be2HYuvBLsVJZa9iRaMsW+AKpOWPnxnBfa
        2A78o3Z75Xmh1HP2UvMj7AlmOynhzJnE9OkQQE5iwN5F9+eFrqdeVUAeWDMbtvG5ibJnF5
        7hIJlpyk6Nm1CSWQW8P9Gtq9QAYA8/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630599904;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=un9uvgee6I8cNno4S8CRlPoXS3z+/NvaWpUIRKlC2s4=;
        b=UMbhqp4uHp2SoRioVFoAPhQPgzsnub4/VW6VBE3apYbzki0Z5IV7SZHsVbNrIuiLasJaRg
        bt26DvzYeZQluFDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DE7E7A3B9F;
        Thu,  2 Sep 2021 16:25:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A745ADA72B; Thu,  2 Sep 2021 18:25:03 +0200 (CEST)
Date:   Thu, 2 Sep 2021 18:25:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: qgroup: address the performance penalty for
 subvolume dropping
Message-ID: <20210902162502.GZ3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210831094903.111432-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831094903.111432-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 05:48:58PM +0800, Qu Wenruo wrote:
> Btrfs qgroup has a long history of bringing huge performance penalty,
> from subvolume dropping to balance.
> 
> Although we solved the problem for balance, but the subvolume dropping
> problem is still unresolved, as we really need to do all the costly
> backref for all the involved subtrees, or qgroup numbers will be
> inconsistent.
> 
> But the performance penalty is sometimes too big, so big that it's
> better just to disable qgroup, do the drop, then do the rescan.
> 
> This patchset will address the problem by introducing a user
> configurable sysfs interface, to allow certain high subtree dropping to
> mark qgroup inconsistent, and skip the whole accounting.
> 
> The following things are needed for this objective:
> 
> - New qgroups attributes
> 
>   Instead of plain qgroup kobjects, we need extra attributes like
>   drop_subtree_threshold.
> 
>   This patchset will introduce two new attributes to the existing
>   qgroups kobject:
>   * qgroups_flags
>     To indicate the qgroup status flags like ON, RESCAN, INCONSISTENT.
> 
>   * drop_subtree_threshold
>     To show the subtree dropping level threshold.
>     The default value is BTRFS_MAX_LEVEL (8), which means all subtree
>     dropping will go through the qgroup accounting, while costly it will
>     try to keep qgroup numbers as consistent as possible.
> 
>     Users can specify values like 3, meaning any subtree which is at
>     level 3 or higher will mark qgroup inconsistent and skip all the
>     costly accounting.
> 
>     This only affects subvolume dropping.
> 
> - Skip qgroup accounting when the numbers are already inconsistent
> 
>   But still keeps the qgroup relationship correct, thus users can keep
>   its qgroup organization while do the rescan later.
> 
> 
> This sysfs interface needs user space tools to monitor and set the
> values for each btrfs.
> 
> Currently the target user space tool is snapper, which by default
> utilizes qgroups for its space-aware snapshots reclaim mechanism.

This is an interesting approach, though I'm there are some usability
questions. First as a user, how do I know I need to use it?  The height
of the subvolume fs tree is not easily accessible.

The sysfs file is not protected in any way so multiple tools can decide
to set it to different values. And whether rescan is required or not
depends on the value so setting it.

It might be better to set the level (or a bit) to the subvol deletion
request, eg. a "fast" mode that would internally use maximum height 3 to
do slow deletion and anything else for fast leaving qgroup numbers
inconsistent.
