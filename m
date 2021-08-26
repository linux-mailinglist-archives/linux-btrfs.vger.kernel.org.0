Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B156E3F8DAB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhHZSNz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 14:13:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46586 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhHZSNy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 14:13:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 25C781FEA7;
        Thu, 26 Aug 2021 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630001586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DihxGUg+emuqdPblNt0ChR6gTaK6XR/dqkG7Jzj6Vxc=;
        b=ORi+hbzRnP1HRUq4nmLztaqdpg2FpaPn3lI0D43laPGXWdW/ef87ybsLSaOwbS6EgQIFWD
        MmRIwaFrKApAvxb3YW+V8SSa5NH39fTbIexZxyOWvw/UwQFhMbC0KbqboUthoiI6CPrW94
        9+BSMbVs4s3bJ4djFX1gPEe8/3fKEdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630001586;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DihxGUg+emuqdPblNt0ChR6gTaK6XR/dqkG7Jzj6Vxc=;
        b=0zYhmxq+iDK9h9ZhyrBkKJd4qthoeoAowK4xRAV+mYZ88E5j69+tZUgsSLtwuOx1Q3OuMt
        8gDedqCOwwcPWcBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1DB5FA3B8B;
        Thu, 26 Aug 2021 18:13:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B386CDA7F3; Thu, 26 Aug 2021 20:10:17 +0200 (CEST)
Date:   Thu, 26 Aug 2021 20:10:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reduce return argument of btrfs_chunk_readonly
Message-ID: <20210826181017.GP3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <32a8d585312548c69ca242c6fd671755f78ddace.1628609924.git.anand.jain@oracle.com>
 <da5074a6-c0bb-a844-bbfe-c57f38bba876@suse.com>
 <249bb6d8-4be1-90b6-1893-c7d0adef1a0b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <249bb6d8-4be1-90b6-1893-c7d0adef1a0b@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 04:58:30PM +0800, Anand Jain wrote:
> On 11/08/2021 15:15, Nikolay Borisov wrote:
> > On 10.08.21 г. 18:48, Anand Jain wrote:
> >> btrfs_chunk_readonly() checks if the given chunk is writeable. It returns
> >> 1 for readonly, and 0 for writeable. So the return argument type bool
> >> shall suffice instead of the current type int.
> >>
> >> Also, rename btrfs_chunk_readonly() to btrfs_chunk_writeable() as we check
> >> if the bg is writeable, and helps to keep the logic at the parent function
> >> simpler.
> 
> > I don't see how the logic is kept simpler, given that you just invert
> > it.
> 
>   IMO it is simpler to read. No? In btrfs_chunk_readonly(), we consider a
>   chunk is readonly when the device it is on has _no_ DEV_STATE_WRITEABLE
>   flag set.  So rename to btrfs_chunk_writeable() is correct. We also use
>   readonly to the filesystem.

The logic in the function is to check for each stripe if it has
writeable flag and short cuircit if not, and this follows as we're
indeed checking for the writeable status. Further there's a check for
the missing devices that can drop previous witebale status. This all
reads as the the main point is 'writeable' status, so I'm fine with the
rename.
