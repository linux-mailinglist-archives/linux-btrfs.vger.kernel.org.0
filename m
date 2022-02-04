Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73C4A9D00
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 17:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376609AbiBDQgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 11:36:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48798 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiBDQgN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 11:36:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E70881F382;
        Fri,  4 Feb 2022 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643992572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhHULf/uBumboTcItn8PhGQT6QNA0wy2WgDB2ljzziM=;
        b=odkVENlICXLsmJXSlGNFRZIv6fKMERyZIb9SwgEC3B8upaKESSOZFUayBB2PRNW95mmlCG
        H2LiE4GvKJ5Yrz7o9I/vQ8JYmInkbYJlPRaNjuL+K0Iok5d4HuaQHlGMzkBJDLJOVIN5J9
        3CPTbtX3CELIUN7ecdLr7WTe4vvZPxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643992572;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhHULf/uBumboTcItn8PhGQT6QNA0wy2WgDB2ljzziM=;
        b=fYX3soZhAS0t5UiRCqQVSPuylrjZkIbQ7eHlEF1rn2GLujFGHO6Ezvq5P+PO2fCsgMXwPg
        0O9AY+oGOU0Qz5CA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DFD4EA3B83;
        Fri,  4 Feb 2022 16:36:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4DF5ADA781; Fri,  4 Feb 2022 17:35:27 +0100 (CET)
Date:   Fri, 4 Feb 2022 17:35:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some misc cleanups and a fix around page
 reading
Message-ID: <20220204163527.GE14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1643902108.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643902108.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 03, 2022 at 03:36:41PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A small set of changes, mostly cleanups, a fix for an error that is not
> being returned, and adding a couple lockdep assertions.
> 
> Filipe Manana (4):
>   btrfs: stop checking for NULL return from btrfs_get_extent()
>   btrfs: fix lost error return value when reading a data page
>   btrfs: remove no longer used counter when reading data page
>   btrfs: assert we have a write lock when removing and replacing extent
>     maps

Added as topic branch to for-next, thanks.
