Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF8646A388
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 18:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhLFSDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 13:03:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36108 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhLFSDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 13:03:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0084B212BA;
        Mon,  6 Dec 2021 17:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638813590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mr7QIs04bj5nzt8srOesO01E9m7XhBNTIyoX8+G//SM=;
        b=Nx6+46R86brXGAxwG7PNC9L0z7NWnZO4VHUOQus1Oq255WXdq6gTdDITYWzNe9FJaGuIfg
        P2iQNZmj0a4GRMizgck5DvBxxXgs5+NaUN3iW9H7+v/xGFdYccI9w4ZoZzY8OFGaNcmi0+
        4ifc9ddxak8XEYaBQ3fd4+AB8SeBi7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638813590;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mr7QIs04bj5nzt8srOesO01E9m7XhBNTIyoX8+G//SM=;
        b=x6AdliCtL7hXD92S5wVcGThC8M/h438qLjXUD0KprXm+uOz6WTPGeB40QW7PX9e01Vi7XM
        LMX59SG4ipeWhJCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C3794A3B85;
        Mon,  6 Dec 2021 17:59:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8745CDA799; Mon,  6 Dec 2021 18:59:35 +0100 (CET)
Date:   Mon, 6 Dec 2021 18:59:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: clear data relocation bg on zone finish
Message-ID: <20211206175935.GQ28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <50bfb0a3d3bedc7038f2e1926c95aa71a3260e75.1638434808.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50bfb0a3d3bedc7038f2e1926c95aa71a3260e75.1638434808.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 02, 2021 at 12:47:14AM -0800, Johannes Thumshirn wrote:
> When finishing a zone that is used by a dedicated data relocation
> block_group, also remove its reference from fs_info, so we're not trying
> to use a full block_group for allocations during data relocation, which
> will always fail.
> 
> The result is we're not making any forward progress and end up in a
> deadlock situation.
> 
> Cc: Naohiro Aota <Naohiro.Aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Added to misc-next, thanks.
