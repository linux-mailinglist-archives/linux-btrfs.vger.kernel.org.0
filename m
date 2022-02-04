Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E394A9CB9
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376428AbiBDQQF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 11:16:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33214 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376407AbiBDQP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 11:15:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B1F9210EF;
        Fri,  4 Feb 2022 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643991358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WJzjvB5ukg0+QVobKBoSDsoW/T60QWsuuFQwXJfAsI=;
        b=jf2r9u0Iyb4n843a+uP+3raMHqfW0qile2nw86zuRGyXVcXKJ+352Hr1K4iCN8qNgld8qx
        IfJSGSGhSV/EK3eJ5YJ5Ntlxjkgl1JOYnzYpkmySl0AOkfnKm9t3FlVDhcQru6C9OhduDK
        u1lWwyOl4w00uEP2UbjFDnj7CzSuEWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643991358;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9WJzjvB5ukg0+QVobKBoSDsoW/T60QWsuuFQwXJfAsI=;
        b=doWkSgFtK7TclrdsfRTc/pexusVwwWqTiMTA1QTMSAefPDXYrvppk48UhR+Jg4VimLlwhs
        mjrQ/3AVIj6FUeAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 81D71A3B89;
        Fri,  4 Feb 2022 16:15:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D4B97DA781; Fri,  4 Feb 2022 17:15:12 +0100 (CET)
Date:   Fri, 4 Feb 2022 17:15:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: stop checking for NULL return from
 btrfs_get_extent_fiemap()
Message-ID: <20220204161512.GC14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <90e3cf42e593327159cd261d71da2bedb53cc562.1643976372.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e3cf42e593327159cd261d71da2bedb53cc562.1643976372.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 04, 2022 at 04:06:27AM -0800, Johannes Thumshirn wrote:
> In get_extent_skip_holes() we're checking the return of
> btrfs_get_extent_fiemap() for an error-pointer or NULL, but
> btrfs_get_extent_fiemap() will never return NULL, only error-pointers or a
> valid extent_map.
> 
> The other caller of btrfs_get_extent_fiemap(), find_desired_extent(),
> correctly only checks for error-pointers.
> 
> Cc: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
