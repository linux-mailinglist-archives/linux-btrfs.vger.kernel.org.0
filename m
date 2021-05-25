Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6B39048B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhEYPGb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 11:06:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:60628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhEYPG1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 11:06:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621955097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7q1ZvK3ZHjcCu7pRwRdRD+fkQFGr71E4XWiZdEb+Ygk=;
        b=2I+D2d3vcqvicwTetBdblF1LUGD2mhve67BexECZgFjd0stHM3Fb4DMnKQTK0D3COsyGQz
        0F7F2v8nl9XVM7oS0W5Z7vUgcEa6ssYgaehFnhfQ/ZJbdDpIjdpXqJ4HedgXkPku593gl0
        ZjY3KWjEYFry87tVQUoM8jzp+m5OQIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621955097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7q1ZvK3ZHjcCu7pRwRdRD+fkQFGr71E4XWiZdEb+Ygk=;
        b=5WUBaPCu0GHVx+M89m0Cox06runEJv3eRMovwn3dBjyevMJoHokxO5shElPuexlar/If11
        VlvVOVr9OTVBhfCA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C0F7AB71;
        Tue, 25 May 2021 15:04:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B86E2DA704; Tue, 25 May 2021 17:02:20 +0200 (CEST)
Date:   Tue, 25 May 2021 17:02:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix fsync failure with SQL Server workload
Message-ID: <20210525150220.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1621851896.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621851896.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 24, 2021 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> This patchset fixes a fsync failure (-EIO) and transaction abort during
> a workload for Microsoft's SQL Server running in a Docker container as
> reported at:
> 
> https://lore.kernel.org/linux-btrfs/93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de/
> 
> It also adds an optimization for the workload, by removing lots of fsyncs
> that trigger the slow code path and replacing them with ones that use the
> fast path, reducing the workload's runtime by about -12% on my test box.
> 
> Filipe Manana (3):
>   btrfs: fix fsync failure and transaction abort after writes to
>     prealloc extents
>   btrfs: fix misleading and incomplete comment of btrfs_truncate()
>   btrfs: don't set the full sync flag when truncation does not touch
>     extents

Added to misc-next, thanks. I've marked the first patch for 5.4+. It
applies cleanly up to 4.4 but I'm not sure if this is safe given the
amount of other fixes that are mentioned in the patch and other fsync
related fixes that have been applied.
