Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22489461C4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 17:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348033AbhK2RBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 12:01:52 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54512 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbhK2Q7v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 11:59:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 61BF81FD56;
        Mon, 29 Nov 2021 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638204993;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDOm53phVGuWrdoLZO8j4et8M+lvi93RozHfz4Q+91A=;
        b=aVaGzT2MbEERjHVeAJmb3+pJHkbiPEt5bnBB20uIJTgsFtciH/BrqodtxHh0MAVpNWE3z1
        sSfQhbQO6bGW8D7XOnLVec9v3oGoGyJ9Vof+I4dyPfk9347yixChbkt4rKjR3n6Cm/ILsj
        eC+OOwizzoe9ViTaZdCnmlIbNCe4jTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638204993;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDOm53phVGuWrdoLZO8j4et8M+lvi93RozHfz4Q+91A=;
        b=0WEuNf3Orbqm05NZD5LKEmtbg9rsTc6i259cK5Lf9IK5Q6l/SwlduhJqJGl+qQh3QvTzdT
        HqaY95MQFmvKaNAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 59DFAA3B87;
        Mon, 29 Nov 2021 16:56:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 135DBDA735; Mon, 29 Nov 2021 17:56:23 +0100 (CET)
Date:   Mon, 29 Nov 2021 17:56:22 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/3] Metadata IO error fixes
Message-ID: <20211129165622.GG28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637781110.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637781110.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 02:14:22PM -0500, Josef Bacik wrote:
> v1->v2:
> - I was debugging generic/484 separately because I thought it was data related,
>   but it turned out to be metadata related as well, so I've added the patch
>   "btrfs: call mapping_set_error() on btree inode with a write error" to the
>   series.
> 
> --- Original email ---
> 
> Hello,
> 
> I saw a dmesg failure with generic/281 on our overnight runs.  This turned out
> to be because we weren't getting an error back from btrfs_search_slot() even
> though we found a metadata block that shouldn't have been uptodate.
> 
> The root cause is that write errors on the page clear uptodate on the page, but
> not on the extent buffer itself.  Since we rely on that bit to tell wether the
> extent buffer is valid or not we don't notice that the eb is bogus when we find
> it in cache in a subsequent write, and eventually trip over
> assert_eb_page_uptodate() warnings.
> 
> This fixes the problem I was seeing, I could easily reproduce by running
> generic/281 in a loop a few times.  With these pages I haven't reproduced in 20
> loops.  Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs: clear extent buffer uptodate when we fail to write it
>   btrfs: check the root node for uptodate before returning it
>   btrfs: call mapping_set_error() on btree inode with a write error

Added to misc-next, thanks.
