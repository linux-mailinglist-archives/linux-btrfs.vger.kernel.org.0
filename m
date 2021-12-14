Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA04474837
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbhLNQfg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 11:35:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47774 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhLNQff (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 11:35:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B1F011F381;
        Tue, 14 Dec 2021 16:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639499734;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Arjua0wvjZuZ871p4NqGVFn9sd0364bT0bZwdBSwHE=;
        b=wuT/q166yjJ8Or8oLAxQIfwDb3Qrc9kRU6bGujadl9AKYvcoAJnyN1h3TQOG1ekdacXFm+
        D6hosgVUY9DY00IhKn6wMaGM8jrh09JVYM8U1ninRwZv/K+ZFfSjpdlBVRZdmkqyt2XOEV
        Q0q/9Hb2AZkyjr0qDJIXn3w7v67pJ+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639499734;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Arjua0wvjZuZ871p4NqGVFn9sd0364bT0bZwdBSwHE=;
        b=i3L/2wiwC0LmqVQAaqKd742Omh4YuO818rROs/GrviFaSmeHukP8FfVVceATFfzTPe8pYX
        wKHSJx+vF1w3HEAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AB2DBA3B8D;
        Tue, 14 Dec 2021 16:35:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8C0F6DA781; Tue, 14 Dec 2021 17:35:16 +0100 (CET)
Date:   Tue, 14 Dec 2021 17:35:16 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Refactor unlock_up
Message-ID: <20211214163516.GX28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211214133939.751395-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214133939.751395-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 14, 2021 at 03:39:39PM +0200, Nikolay Borisov wrote:
> The purpose of this function is to unlock all nodes in a btrfs path
> which are above 'lowest_unlock' and whose slot used is different than 0.
> As such it used slightly awkward structure of 'if' as well as somewhat
> cryptic "no_skip" control variable which denotes whether we should
> check the current level of skipiability or no.
> 
> This patch does the following (cosmetic) refactorings:
> 
> * Renames 'no_skip' to 'check_skip' and makes it a boolean. This
> variable controls whether we are below the lowest_unlock/skip_level
> levels.
> 
> * Consolidates the 2 conditions which warrant checking whether the
> current level should be skipped under 1 common if (check_skip) branch,
> this increase indentation level but is not critical.
> 
> * Consolidates the 'skip_level < i && i >= lowest_unlock' and
> 'i >= lowest_unlock && i > skip_level' condition into a common branch
> since those are identical.
> 
> * Eliminates the local extent_buffer variable as in this case it doesn't
> bring anything to function readability.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Much better, added to misc-next, thanks.
