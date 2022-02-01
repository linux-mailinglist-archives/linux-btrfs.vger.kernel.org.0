Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FC4A62A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 18:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiBARiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 12:38:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47090 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbiBARiI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 12:38:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CDF021155;
        Tue,  1 Feb 2022 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643737087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBcwKlOrUHUg4knSKw4vGLUV9fxBZyg4TYVYZStUlrA=;
        b=OQ458+FHuO0Z6UKkbOEYFE5A9EXbzgrUWhTH0Gnhy6UA0mK0YuJj3YUen3dhICdcq4dbwK
        jrGtjMl4eqauc8yQZhjrPZGWQVvGPcLbMDLxNMOPmb7+UAT1h2lcKAFuHZd1KYGwz+ViLx
        r8uH7wqF1hI2Is82bNFcZ1EmCvJjGJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643737087;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBcwKlOrUHUg4knSKw4vGLUV9fxBZyg4TYVYZStUlrA=;
        b=XDkmLLxM0UWUJdfmNDuOCXMDoN5vPDsg/3LvhNUORLlPNYIN4W2wTX9PrP7FjhFBKsELQT
        oEweVEiYtgZSUyBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 94E4FA3B84;
        Tue,  1 Feb 2022 17:38:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8DCCDDA7A9; Tue,  1 Feb 2022 18:37:23 +0100 (CET)
Date:   Tue, 1 Feb 2022 18:37:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: fsck: detect obviously invalid metadata
 backref level
Message-ID: <20220201173723.GY14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220117023850.40337-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117023850.40337-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 10:38:47AM +0800, Qu Wenruo wrote:
> There is a report that kernel tree-checker rejects a tree block of
> extent tree, as it contains an obvious corrupted level (which is an
> obvious bit flip).
> 
> But btrfs check, at least original mode, doesn't detect it at all.
> While with my crafted image, lowmem mode would just crash due to the
> large level value overflowing path->nodes[level].
> 
> Lowmem is enhanced to reject such level, and the existing code will
> verify the level and report errors.
> 
> Original mode is more tricky, as it doesn't have level check at all.
> I don't have a good idea to implement full level check at original mode,
> so here I just introduced a basic check for tree level and reject it.
> 
> Finally introduce a test case for this.
> 
> Qu Wenruo (3):
>   btrfs-progs: check/lowmem: fix crash when METADATA_ITEM has invalid
>     level
>   btrfs: check/original: reject bad metadata backref with invalid level
>   btrfs-progs: tests/fsck: add test image with invalid metadata backref
>     level

Added to devel, thanks.
