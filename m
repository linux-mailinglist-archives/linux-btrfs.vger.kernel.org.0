Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9EC3F0E2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 00:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhHRWcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 18:32:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbhHRWcK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 18:32:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C99F22035;
        Wed, 18 Aug 2021 22:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629325894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiekDP0v76KmF+iZ1aqqsGX6sDk7YQqiqsZLRUjcAQ0=;
        b=B1ZAY0Nn4m4eyz78M/HrBzP/3kFDUZTZuVlt8bPUDI2/7wIZRrO6J92EjgldjhEvoQ9T+i
        ChOmY9ic9ZSl4Q0rYfdazYO0x77XPfS8wHoIyIlZZcCPLjxgiXLlKlUsvbhwwslLSssemp
        ViKRYkTd+R7/JOFRqPzwvd61xmrKBJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629325894;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CiekDP0v76KmF+iZ1aqqsGX6sDk7YQqiqsZLRUjcAQ0=;
        b=Udu1UB7twS6jS6VF+Idt/rbeO8SXkXkFmDLeGavXhjwRKTp1uQILfSRaZj+koLWG1n19ZM
        +KrXBSunw3zYvsBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 945D8A3B98;
        Wed, 18 Aug 2021 22:31:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D9F1DA72C; Thu, 19 Aug 2021 00:28:37 +0200 (CEST)
Date:   Thu, 19 Aug 2021 00:28:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [RESEND PATCH] btrfs: rename btrfs_alloc_chunk to
 btrfs_create_chunk
Message-ID: <20210818222837.GY5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20210818104119.172294-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818104119.172294-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 01:41:19PM +0300, Nikolay Borisov wrote:
> The user facing function used to allocate new chunks is
> btrfs_chunk_alloc, unfortunately there is yet another similar sounding
> function - btrfs_alloc_chunk. This creates confusion, especially since
> the latter function can be considered "private" in the sense that it
> implements the first stage of chunk creation and as such is called by
> btrfs_chunk_alloc.
> 
> To avoid the awkwardness that comes with having similarly named but
> distinctly different in their purpose function rename btrfs_alloc_chunk
> to btrfs_create_chunk, given that the main purpose of this function is
> to orchestrate the whole process of allocating a chunk - reserving space
> into devices, deciding on characteristics of the stripe size and
> creating the in-memory structures.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
