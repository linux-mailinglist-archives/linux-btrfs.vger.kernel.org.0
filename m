Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9662E3EEDA4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhHQNpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 09:45:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34260 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbhHQNpA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 09:45:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE89A1FF4D;
        Tue, 17 Aug 2021 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629207866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZSJNHPuCrzMjYpCdpKAjbCAHqrgB3vNeqCu7yiVeMkE=;
        b=IaDYNSDECfF44CKRl0GrinuolDj248F5LCRrRleXUdWZAUKgHupIVZnge1OVH0RpZQllds
        n1+Vh4zEvU+ogX1dv1nBcbKhAwSBTkQyCmfVrAKpY7FRXn+35Rv+twwvtzjQbKJBpsgKSS
        eBIZuxUdrRPcZjbOTNA2tzRZb/WzKMY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9878D132AB;
        Tue, 17 Aug 2021 13:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id TgOtIjq9G2FkRQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 17 Aug 2021 13:44:26 +0000
Subject: Re: [PATCH v2 0/2] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <e43ffa4b-a8b0-28da-fc7e-75185b5c8ea5@suse.com>
Date:   Tue, 17 Aug 2021 16:44:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817093852.48126-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.08.21 г. 12:38, Qu Wenruo wrote:
> Currently we use u16 bitmap to make 4k sectorsize work for 64K page
> size.
> 
> But this u16 bitmap is not large enough to contain larger page size like
> 128K, nor is space efficient for 16K page size.
> 
> To handle both cases, here we pack all subpage bitmaps into a larger
> bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
> subpage usage.
> 
> This is the first step towards more page size support.
> 
> Although to really enable extra page size like 16K and 128K, we need to
> rework the metadata alignment check.
> Which will happen in another patchset.
> 
> Changelog:
> v2:
> - Add two refactor patches to make btrfs_alloc_subpage() more readable
> - Fix a break inside two loops bug
> - Rename subpage_info::*_start to subpage_info::*_offset
> - Add extra comment on what each subpage_info::*_offset works
> 
> 

Overall this looks better, with my small nits addressed:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> Qu Wenruo (4):
>   btrfs: only call btrfs_alloc_subpage() when sectorsize is smaller than
>     PAGE_SIZE
>   btrfs: make btrfs_alloc_subpage() to return struct btrfs_subpage *
>     directly
>   btrfs: introduce btrfs_subpage_bitmap_info
>   btrfs: subpage: pack all subpage bitmaps into a larger bitmap
> 
>  fs/btrfs/ctree.h     |   1 +
>  fs/btrfs/disk-io.c   |  12 ++-
>  fs/btrfs/extent_io.c |  76 +++++++++-------
>  fs/btrfs/subpage.c   | 205 ++++++++++++++++++++++++++++++-------------
>  fs/btrfs/subpage.h   |  54 ++++++++----
>  5 files changed, 238 insertions(+), 110 deletions(-)
> 
