Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381A446A99A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 22:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350548AbhLFVSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 16:18:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48090 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350550AbhLFVSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 16:18:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 540541FD2F;
        Mon,  6 Dec 2021 21:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638825284;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4S9nJl/pfdl90JxFczKjEwG1VK26wcfXfqDjhUvASI=;
        b=BjBEoFXH06Bw57E/JXmcGFItaJfn6hDPmbErbjImS+BV8jjNaLy8D22fhJBR9hXd9hBmfd
        z3tRF1n3r4Wn0SvYODc0z4VQHZmIx50E6DQAdFWIRk3y1PT5URujoha6+WFJoSZc4IFpLX
        unU9pKQIFmpIjp2VqIUV9GbBSV5Khkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638825284;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4S9nJl/pfdl90JxFczKjEwG1VK26wcfXfqDjhUvASI=;
        b=zJC2RArZquJ0WumRXqRuOwp+lIAlUhZr2C+kwZZQAvQWnlHADWjOQqlckKNam/1HEmADMj
        1p2kZ7XFgVsJTMBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4D3D5A3B83;
        Mon,  6 Dec 2021 21:14:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2CA76DA799; Mon,  6 Dec 2021 22:14:30 +0100 (CET)
Date:   Mon, 6 Dec 2021 22:14:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: update SCRUB_MAX_PAGES_PER_BLOCK
Message-ID: <20211206211430.GV28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211206055258.49061-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206055258.49061-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 06, 2021 at 01:52:57PM +0800, Qu Wenruo wrote:
> Use BTRFS_MAX_METADATA_BLOCKSIZE and SZ_4K (minimal sectorsize) to
> calculate this value.
> 
> And remove one stale comment on the value, in fact with recent subpage
> support, BTRFS_MAX_METADATA_BLOCKSIZE * PAGE_SIZE is already beyond
> BTRFS_STRIPE_LEN, just we don't use the full page.
> 
> Also since we're here, update the BUG_ON() related to
> SCRUB_MAX_PAGES_PER_BLOCK to ASSERT().
> 
> As those ASSERT() are really only for developers to catch early obvious
> bugs, not to let end users suffer.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

1 and 2 added to misc-next, thanks.
