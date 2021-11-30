Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCE463D56
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Nov 2021 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245216AbhK3SEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Nov 2021 13:04:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57840 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbhK3SEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Nov 2021 13:04:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A10221891;
        Tue, 30 Nov 2021 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638295264;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=agDUIp5jy6bjxbEoHdOnb3vReVX/2+J1VtSFzdphYkA=;
        b=JJiw39HsqI9z8QCoq3xUfKirjvfAScfEPSuM2S2vm3D2hQDfTexo1cSL95RT3uj48XKOZe
        BlkBkbvR/5pSbPxjP8sq5MFhrvB4t0shkURg5Yh4Y7Oj05RugBkwtDFCSb8E2t6iZp7xuu
        p2Q/9+qwIxY/6qttdZgUAD0ByX1SsyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638295264;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=agDUIp5jy6bjxbEoHdOnb3vReVX/2+J1VtSFzdphYkA=;
        b=BrA/fkcNmQW6RZMYxBPyUVtPSxAuPZ5wH8Me5hfZGYgHWIRhvDN6+61x3zxEPBTJB4qybi
        S8oRerRq+dt0e/AA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 92880A3B81;
        Tue, 30 Nov 2021 18:01:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A478EDA7A3; Tue, 30 Nov 2021 19:00:53 +0100 (CET)
Date:   Tue, 30 Nov 2021 19:00:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/20] btrfs-progs: extent tree v2 global root support
 prep work
Message-ID: <20211130180053.GK28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636399481.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1636399481.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 02:26:28PM -0500, Josef Bacik wrote:
> v1->v2:
> - reworked the root node helper thing to check the level as well as per Qu's
>   suggestion.
> - Fixed a place where we weren't inluding common/repair.h to get a helper that I
>   moved (not entirely sure how this still built but whatever.)
> - Fixed a place where I could get fs_info from an eb instead of passing it
>   around.
> 
> --- Original email ---
> Hello,
> 
> This is a series of patches to do all the prep work needed to support extent
> tree v2.  These patches are independent of the actual extent tree v2 support,
> some of them are fixes, some of them are purely to pave the way for the global
> root support.  These patches are mostly around stopping direct access of
> ->extent_root/->csum_root/->free_space_root, putting these roots into a rb_tree,
> and changing the code to look up the roots in the rb_tree instead of accessing
> them directly.  There are a variety of fixes to help make this easier, mostly
> removing access to these roots that are strictly necessary.  Thanks,
> 
> Josef
> 
> Josef Bacik (20):
>   btrfs-progs: simplify btrfs_make_block_group
>   btrfs-progs: check: don't walk down non fs-trees for qgroup check
>   btrfs-progs: filesystem-show: close ctree once we're done
>   btrfs-progs: add a helper for setting up a root node
>   btrfs-progs: btrfs-shared: stop passing root to csum related functions
>   btrfs-progs: check: stop passing csum root around
>   btrfs-progs: stop accessing ->csum_root directly
>   btrfs-progs: image: keep track of seen blocks when walking trees
>   btrfs-progs: common: move btrfs_fix_block_accounting to repair.c
>   btrfs-progs: check: abstract out the used marking helpers
>   btrfs-progs: check: move btrfs_mark_used_tree_blocks to common
>   btrfs-progs: mark reloc roots as used
>   btrfs-progs: stop accessing ->extent_root directly
>   btrfs-progs: stop accessing ->free_space_root directly
>   btrfs-progs: track csum, extent, and free space trees in a rb tree
>   btrfs-progs: check: make reinit work per found root item
>   btrfs-progs: check: check the global roots for uptodate root nodes
>   btrfs-progs: check: check all of the csum roots
>   btrfs-progs: check: fill csum root from all extent roots
>   btrfs-progs: common: search all extent roots for marking used space

Half of the series was in devel, the rest added as well, thanks.
