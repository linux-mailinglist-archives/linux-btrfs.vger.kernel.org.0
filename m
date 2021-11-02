Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7721D443458
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhKBRMK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 13:12:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34890 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKBRMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 13:12:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9BF59218F7;
        Tue,  2 Nov 2021 17:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635872974;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1qhIDkJUQBSVjACzHb12nq3csNihY4cDGWF67L2XNw=;
        b=vJVjA9zgCJPuChRZHP8LlHHNjd8laa4mcXIXuxuMCZ3OAjWE0gqfGI0QzuFrm5XmKauQmh
        jEX5hYRrZmHXumU0a63r4rqv6F1Udsnum/dDFjSNd2h/Pw4aAuJ5KqWMZst9UwnQZynfwu
        rLXqw7H+QHYAp3wuEegmgt7nLy+IJtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635872974;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1qhIDkJUQBSVjACzHb12nq3csNihY4cDGWF67L2XNw=;
        b=02JQqy7jq1ITpAOjy0TU+FaTyfW8rTXtNhDPExnwTAFMLkYkHA15lTpEtP4SMCqcX/A06v
        4GFdUlmogjA5pQBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 95DDF2C144;
        Tue,  2 Nov 2021 17:09:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4595ADA7A9; Tue,  2 Nov 2021 18:08:59 +0100 (CET)
Date:   Tue, 2 Nov 2021 18:08:59 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: printf format fixes for 32bit x86
Message-ID: <20211102170859.GS20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211027124846.100854-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027124846.100854-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 27, 2021 at 08:48:46PM +0800, Qu Wenruo wrote:
> When compiling btrfs-progs on 32bit x86 using GCC 11.1.0, there are
> several warnings:
> 
>   In file included from ./common/utils.h:30,
>                    from check/main.c:36:
>   check/main.c: In function 'run_next_block':
>   ./common/messages.h:42:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'u32' {aka 'unsigned int'} [-Wformat=]
>      42 |                 __btrfs_error((fmt), ##__VA_ARGS__);                    \
>         |                               ^~~~~
>   check/main.c:6496:33: note: in expansion of macro 'error'
>    6496 |                                 error(
>         |                                 ^~~~~
> 
>   In file included from ./common/utils.h:30,
>                    from kernel-shared/volumes.c:32:
>   kernel-shared/volumes.c: In function 'btrfs_check_chunk_valid':
>   ./common/messages.h:42:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'u32' {aka 'unsigned int'} [-Wformat=]
>      42 |                 __btrfs_error((fmt), ##__VA_ARGS__);                    \
>         |                               ^~~~~
>   kernel-shared/volumes.c:2052:17: note: in expansion of macro 'error'
>    2052 |                 error("invalid chunk item size, have %u expect [%zu, %lu)",
>         |                 ^~~~~
> 
>   image/main.c: In function 'search_for_chunk_blocks':
>   ./common/messages.h:42:31: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
>      42 |                 __btrfs_error((fmt), ##__VA_ARGS__);                    \
>         |                               ^~~~~
>   image/main.c:2122:33: note: in expansion of macro 'error'
>    2122 |                                 error(
>         |                                 ^~~~~
> 
> There are two types of problems:
> 
> - __BTRFS_LEAF_DATA_SIZE()
>   This macro has no type definition, making it behaves differently on
>   different arches.
> 
>   Fix this by following kernel to use inline function to make its return
>   value fixed to u32.
> 
> - size_t related output
>   For x86_64 %lu is OK but not for x86.
> 
>   Fix this by using %zu.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
