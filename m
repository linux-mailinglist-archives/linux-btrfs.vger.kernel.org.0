Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D896475C18
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 16:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbhLOPp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 10:45:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:50538 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244074AbhLOPp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 10:45:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3E62A1F3CB;
        Wed, 15 Dec 2021 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639583155;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsT7dJN8qJtm2nwvUZAo+ujS17LE1NFt+jViOff8eSA=;
        b=B/MwMiJBkSAgNkNPC/BkPg4W+JZNXyhLjgwvSYpTn5H3PJx4E9Sr9zGIBUtSKEXHfTLMnx
        UGTdERRP4bLuSdMTnE3K8A2zcJHgL0UIe3JS+aY1HGKGsUeRSYYNNCIXgg9KKDNQh/Sm68
        hciD1gvt0DWgNhKAjMnUGpnc3T84E+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639583155;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsT7dJN8qJtm2nwvUZAo+ujS17LE1NFt+jViOff8eSA=;
        b=+lsIAWoB+siqMcm/RvBNedS928O5iIGY4ir8817xsBwNCnXTp6rfxBfYcB+SNGY/cn2mOf
        9ml/JGJb88XIOnBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 375F3A3B87;
        Wed, 15 Dec 2021 15:45:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 898F5DA781; Wed, 15 Dec 2021 16:45:36 +0100 (CET)
Date:   Wed, 15 Dec 2021 16:45:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: cleanup the argument list of scrub_chunk()
Message-ID: <20211215154536.GA28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211215065942.26683-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215065942.26683-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 02:59:41PM +0800, Qu Wenruo wrote:
> The argument list of scrub_chunk() has the following problems:
> 
> - Duplicated @chunk_offset
>   It is the same as btrfs_block_group::start.
> 
> - Confusing @length
>   The most instinctive guess is chunk length, and one may want to delete
>   it, but the truth is, it's device extent length.
> 
> Fix this by:
> 
> - Remove @chunk_offset
>   Use btrfs_block_group::start instead.
> 
> - Rename @length to @dev_ext_len
>   Also rename the caller to remove the ambiguous naming.
> 
> - Rename @cache to @bg
>   The "_cache" suffix for btrfs_block_group is removed for a while.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Good cleanups, added to misc-next, thanks. I've renamed the dev_ext_len
to dev_extent_len, as it's close to the key name BTRFS_DEV_EXTENT_KEY
and sounds more familiar.
