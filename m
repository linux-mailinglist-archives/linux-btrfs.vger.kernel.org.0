Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1E422E05
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhJEQfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 12:35:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51522 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhJEQfm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 12:35:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7AD6520045;
        Tue,  5 Oct 2021 16:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633451630;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Et2EFwFiRUM+XqglD+HWnZQYehmpdo2SK3+2BkMKTps=;
        b=HUYS0z5AAky92UTyFwocKGfOUMnkQc99sgV8VTXXtCGJjdlqvKHDiWsxjIzJ7n/T1JWSRY
        e4ZWaOylO4+yXVeSSRybRCnHhZobM8szJweJb3FEeZ4xxwhWKNA1SyUcBJKNXVOKfUTaUU
        x3W9qHQVHFl+9QgjYG/0ThjmbxYZi50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633451630;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Et2EFwFiRUM+XqglD+HWnZQYehmpdo2SK3+2BkMKTps=;
        b=kXxEg3wAarmS6rf9jZUXyuw3iNdvufRDAvxz5sy7gOabB8PsKF+IF0GmQiz7wSh+X+GIOX
        Ko250Gu6iVlve9Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 73F54A3B81;
        Tue,  5 Oct 2021 16:33:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A6F2DDA7F3; Tue,  5 Oct 2021 18:33:30 +0200 (CEST)
Date:   Tue, 5 Oct 2021 18:33:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 15/26] btrfs: refactor submit_compressed_extents()
Message-ID: <20211005163330.GH9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-16-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072208.21634-16-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 03:21:57PM +0800, Qu Wenruo wrote:
> We have a big hunk of code inside a while() loop, with tons of strange
> jump for error handling.
> 
> It's definitely not to the code standard of today.
> 
> Move the code into a new function, submit_one_async_extent().
> 
> Since we're here, also do the following modifications:
> 
> - Comment style change
>   To follow the current scheme
> 
> - Don't fallback to non-compressed write then hitting ENOSPC
>   If we hit ENOSPC for compressed write, how could we reserve more space
>   for non-compressed write?
>   Thus we go error path directly.
>   This removes the retry: label.

I'm not happy about mixing this change with a refactoring, as it's a
functional change and in the logic how compressed writes do the
fallback. This should have proper reasoning and some kind of independent
testing. As it does not sound wrong I'll leave as it is, hopefully this
won't haunt us in the future.
