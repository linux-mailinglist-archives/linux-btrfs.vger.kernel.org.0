Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FC53F4F73
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 19:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhHWRXn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 13:23:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50188 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhHWRXm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 13:23:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A425F1FFD4;
        Mon, 23 Aug 2021 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629739378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxJR1CAmUsR2iRLocbncSLUZJytLJR+wmczfmryqMr8=;
        b=EW3zLw9PGcOnFBn7pkVrSFAnEm7kEhQaFVc4/Be3vQxcj/77cSPJgyMIaNYl1CPf6tjks2
        guqEANgNKGiGb2neuk5eHteXDZ0oFnwdeWOtEIkww7a54sPEoWCTlN3mGTDa9JckicgQkt
        e8zn7PL6nbxOl5UPkXcz7j77ZZPt4OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629739378;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxJR1CAmUsR2iRLocbncSLUZJytLJR+wmczfmryqMr8=;
        b=+ou3lB1UqYDxwheu7M9uN1LNTO8HEhc1BoXxmfhp5nEd2N/49RgZpTibOGVboXmI0jvpao
        SUThjAqDVmcEpSAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9BAE4A3BB0;
        Mon, 23 Aug 2021 17:22:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20F97DA725; Mon, 23 Aug 2021 19:19:59 +0200 (CEST)
Date:   Mon, 23 Aug 2021 19:19:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] btrfs-progs: image: new data dump feature
Message-ID: <20210823171958.GK5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210812054815.192405-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812054815.192405-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 01:48:11PM +0800, Qu Wenruo wrote:
> This patchset includes the following features:
> 
> - Introduce data dump feature to dump the whole fs.
>   This will introduce a new magic number to prevent old btrfs-image to
>   hit failure as the item size limit is enlarged.
>   Patch 1 and 2.
> 
> - Reduce memory usage for compressed data dump restore
>   This is mostly due to the fact that we have much larger
>   max_pending_size introduced by data dump(256K -> 256M).
>   Using 4 * max_pending_size for each decompress thread as buffer is way
>   too expensive now.
>   Use proper inflate() to replace uncompress() calls.
>   Patch 3
> 
> - A fix for small dev extent size mismatch with superblock
>   This no longer affects single device dump restore, thus it's only
>   for multi-device dump restore.
>   Patch 4

I'll merge this patchset and try it with the new experimental build (now
in devel). Which means that the feature would have to be explicitly
enabled with configure --enable-experimental. This is to get us some
time to work on it and not be blocked nor block a release of progs.

To mark it as experimental the key bits enabling the interface need to
be behind if (EXPERIMENTAL) or under #if EXPERIMENTAL, but that should
be it. Please update the patchset accordingly. This is the first attempt
to do that so we may need to tweak something but I'd like to establish
this kind of patch flow for the future and your patchset looks like a
good testing ground. Thanks for volunteering.
