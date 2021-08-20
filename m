Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07463F2D02
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhHTNUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 09:20:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbhHTNUC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 09:20:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A4EA21FE1C;
        Fri, 20 Aug 2021 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629465563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTHEvfT1i8IgC4a1wFNzGar1AmzgrZgiQed0g34vj4k=;
        b=Zwpm9JiDinxosTxXgYl0FXym0FPf3amcxsrCfAUjSto8XCDBgIMYcN34hGq/ANpP/kiXWv
        q6oRirOmYKSpe7sWGIFpAIo2hDrtTFuBFsBog8Zkkmaf2pLT34o63+QUOTV93IoLxXziQT
        mFkVV4AEOrf5Kmb1j5I6EHTlZ9CqpFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629465563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NTHEvfT1i8IgC4a1wFNzGar1AmzgrZgiQed0g34vj4k=;
        b=nQbv0FU6awVy5lE7suXjFVBk/NUX/kJNEwfR9/6xtGj3rg9jnniDKUEi7AXT9r/W54w90Q
        91fxHdGDmbSBsLAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9E804A3B87;
        Fri, 20 Aug 2021 13:19:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E124CDA8CA; Fri, 20 Aug 2021 15:16:25 +0200 (CEST)
Date:   Fri, 20 Aug 2021 15:16:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 0/4] btrfs-progs: image: new data dump feature
Message-ID: <20210820131625.GU5047@twin.jikos.cz>
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

So this looks like a big thing, new format, new version, bringing all
the fun and problems with proper format design, description and
validation - that we don't have for v1 either. How would old progs
version handle the new version? There's no proper detection so it could
just try to use the dump and then fail at some random point (I haven't
tried, just gusessing).

The version cannot be selected explicitly on the command line, only -d
would silently change it.

The documentation should also come with the patch though it might not be
complete until we agree on the whole feature or implementation, but not
even updating the command line interface in manual page happens way too
often and I randomly notice and have to fix it myself.

Data in the dump could be useful but I'd still like to see some usecase
description.
