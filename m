Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA24594A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 19:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhKVSYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 13:24:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50572 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbhKVSYS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 13:24:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 215171FD58;
        Mon, 22 Nov 2021 18:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637605271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wL/Kr2Kx1SLJcm9q5IgjMesZZXb87rwxl9thp8JqVX0=;
        b=JwHy9yVQqcowyJ16GB0zyCkynZo9QBwhX8NIXrE9/eXTGbGmjAf/h//liXbRcb+3874P05
        RrauNckkeshaBjfr2finNI/6fYrKSN5+K9W8FwwjoOPqqlvD6/46QYLen1j1L43jSkUBKb
        MWwi2YVfV6zX8HRt5Upzh4HiAlaLM80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637605271;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wL/Kr2Kx1SLJcm9q5IgjMesZZXb87rwxl9thp8JqVX0=;
        b=xvMqXh8Qh/o8rSUBF3ZKKSfb10F66vdyv/Mifx+q3Vz8tHVpcPpBmOe+5pD/n8kppzxsJw
        DmzyNl5a20ipqSBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 19CA4A3B84;
        Mon, 22 Nov 2021 18:21:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 65329DA735; Mon, 22 Nov 2021 19:21:04 +0100 (CET)
Date:   Mon, 22 Nov 2021 19:21:04 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: fix the memory leak caused in lzo_compress_pages()
Message-ID: <20211122182104.GM28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20211120083411.120338-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120083411.120338-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 20, 2021 at 04:34:11PM +0800, Qu Wenruo wrote:
> [BUG]
> Fstests generic/027 is pretty easy to trigger a slow but steady memory
> leak if run with "-o compress=lzo" mount option.
> 
> Normally one single run of generic/027 is enough to eat up at least 4G ram.
> 
> [CAUSE]
> In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
> compatible") we changed how @page_in is released.
> 
> But that refactor makes @page_in only released after all pages being
> compressed.
> 
> This leaves error path not releasing @page_in. And by "error path"
> things like incompressible data will also be treated as an error
> (-E2BIG).
> 
> Thus it can leave btrfs to leak memory even there is nothing wrong
> happened.
> 
> [FIX]
> Add check under @out label to release @page_in when needed, so when we
> hit any error, the input page is properly released.
> 
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compatible")

This commit has caused problems I don't want to repeat, it's an example
of a 'rewrite in one go' vs 'incremental changes', this is a pattern
known to avoid exactly because of the sublte semantics not transferred
into the new version. Please keep that in mind for future patches, it's
much safer to review 5 patches doing the change in smaller steps.
Anyway, thanks for the fix, added to misc-next.
