Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5560D4A5FCC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiBAPPZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 10:15:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51396 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiBAPPZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 10:15:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 525041F37C;
        Tue,  1 Feb 2022 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643728524;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YoaT3q9zQvaL7F+aDTPKfjQjX5NFoogmkMzzYICYbE=;
        b=tmMkqrLE7g2PjrgLCdGvJX/bLxS6TWaa1emKvmRID0yCxCe3tMCYOKh6/rXQKwOwDZYFjl
        R2upL2fP50GXInIYCkMWIthek3ZhXVxGrchDUmyMqSrnAFCPny9IPCZAl1TuQw416i7y22
        3R/jSB0PjcjArthzMhKzC8l4H3rhRWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643728524;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YoaT3q9zQvaL7F+aDTPKfjQjX5NFoogmkMzzYICYbE=;
        b=FQf492xXK0a8SwvEPCXTba18DIDNZKtdCrRIsEXUGMjQ4Rj0t0+wq+/jQuuzXUbOgeaEZo
        CS5yf3hNg0INeIDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4B66EA3B83;
        Tue,  1 Feb 2022 15:15:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 52927DA7A9; Tue,  1 Feb 2022 16:14:40 +0100 (CET)
Date:   Tue, 1 Feb 2022 16:14:40 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test case to verify that btrfs won't waste
 IO/CPU to defrag compressed extents already at their max size
Message-ID: <20220201151439.GR14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20220127055306.30252-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127055306.30252-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 01:53:06PM +0800, Qu Wenruo wrote:
> There is a long existing bug in btrfs defrag code that it will always
> try to defrag compressed extents, even they are already at max capacity.

As commended under the patch, this not considered a bug, because the
defrag ioctl is expected to reshuffle the extents, with or without
compression and improving the compression ratio if asked to recompress
with hither level. What is not perfect is the kernel side that could try
harder to merge extents into bigger contiguous chunks, but as long as
the compression is involved it's not possible to decide if the extents
should be skipped or not.
