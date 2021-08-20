Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C143F2C17
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 14:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhHTMcu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 08:32:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37114 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhHTMct (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 08:32:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 35F9820152;
        Fri, 20 Aug 2021 12:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629462723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrF6d3yKEqBzD8ixFKCs+XKcdTWJyakdv0ayt1EYbQk=;
        b=sZI0QOJvTOc/1OsHiLFJdWdBGe3ZSk0P9Aucq5u1MtHm9TpFY7EedNcUFTwhfm1C7H8GD8
        fxRk+s2Pa6JICRqvnWj5INcjyKzt6Vgb5VlgB1A2bGwfe5oxa6rfaDlsUqVdI4qQeKnLO8
        3WYk8hdZZhVFBAEnWJJWKWFsIDulotQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629462723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrF6d3yKEqBzD8ixFKCs+XKcdTWJyakdv0ayt1EYbQk=;
        b=SeyhD80+zsHAJ6DMNs5Un3wUVfhK1aiRA8ruT9CHUiBhMyNLs58ZVkvs30ncx4SaKpSJJa
        3X4EM9mnmdRo4qCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 290B4A3B87;
        Fri, 20 Aug 2021 12:32:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7162EDA72C; Fri, 20 Aug 2021 14:29:05 +0200 (CEST)
Date:   Fri, 20 Aug 2021 14:29:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
Subject: Re: [PATCH] btrfs-progs: Drop the type check in
 init_alloc_chunk_ctl_policy_regular
Message-ID: <20210820122905.GP5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, nborisov@suse.com
References: <20210809182613.4466-1-mpdesouza@suse.com>
 <63cd4e76-72b4-7b99-ae94-075dfaf78bb7@oracle.com>
 <39f171e0-7c3c-7194-4265-e688d2df097e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f171e0-7c3c-7194-4265-e688d2df097e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 01:36:32PM +0800, Qu Wenruo wrote:
> > Looks good to me.
> > 
> > I hope there isn't any xfstests/tests/btrfs test case that is hardcoded
> > to the older block group alloc (like swap file test with relocation?).
> > But then the test case will need a fix, not btrfs-progs. So
> 
> Well, fsck/025 will fail, and it's not the test case needs a fix...
> 
> We just suddenly can't mkfs on a 128MiB device due to the enlarged 
> minimal stripe length of data chunks.
> 
> This still exposes a behavior difference between kernel and btrfs-progs...

So I'll reply here as all people involved are also CCed - I'm dropping
this patch for now.

The test 025 fails and my idea was to skip it for now but that still
leaves the problems with creating small filesystems, that's something
that has been working and it should keep doing so.

Proper fix: scale the chunk size for large filesystems and also small
filesystems. We can probably set the minimum size to somewhere like 64M
(for non-mixed setups), and scale the chunk sizes according to that.

d.
