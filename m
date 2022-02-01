Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE894A623D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 18:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiBARUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 12:20:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45990 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBARUX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 12:20:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 17AA521128;
        Tue,  1 Feb 2022 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643736023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKklzdprz/P9AaA3MTQ1yvpyfpjxgJD4SEtESCAU2sI=;
        b=LLJSmZ58zK/Z+ijeLl/kPDK5L3VkHgLqfN82SrfKt+Yx9UOf22oZ7lciEw4N6xyxbjM3Ey
        lk+r+vPTQun+r3Fm+4h+OpUpi45tz7QfWpbq0sdlJ5M36BtAshhFmiF+L/skKlCbyA7PUg
        8UHnJvBVfKAXhsNAUB13j4NEbIBJEtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643736023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKklzdprz/P9AaA3MTQ1yvpyfpjxgJD4SEtESCAU2sI=;
        b=1l5ZQILDpKR9qcIAtJXBCYRuWAZqEZf1jS1ZZdAdXmJec/bNPZFmYn0eYc7l51zZh2Drry
        q/OgQmEnf1LSwvDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0FA05A3B8B;
        Tue,  1 Feb 2022 17:20:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E9E82DA7A9; Tue,  1 Feb 2022 18:19:38 +0100 (CET)
Date:   Tue, 1 Feb 2022 18:19:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: subv del: hide a bogus warning on an
 unprivileged delete
Message-ID: <20220201171938.GW14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Adam Borowski <kilobyte@angband.pl>,
        linux-btrfs@vger.kernel.org
References: <20220124133632.62597-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124133632.62597-1-kilobyte@angband.pl>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 24, 2022 at 02:36:32PM +0100, Adam Borowski wrote:
> Checking the default subvolume uses TREE_SEARCH which is a CAP_SYS_ADMIN
> only operation, and thus will fail when unprivileged, even if we have
> permissions to actually delete the subvolume.
> 
> This produces a warning even if all is ok.  Let's hide it if we're not
> root (root but !CAP is odd enough to warn).
> 
> Fixes 87804a3f0663a4d1891395bd97b8e81e6f183e66
> Ref: https://bugs.debian.org/998840
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Thanks, added to devel, that covers the part when the search fails. It
could also fail when the default subvolume is not set so I might add a
separate check for that.
