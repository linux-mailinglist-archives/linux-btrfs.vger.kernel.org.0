Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDBE45D6EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 10:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351067AbhKYJR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 04:17:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41986 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345522AbhKYJP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 04:15:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D177C2113D;
        Thu, 25 Nov 2021 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637831536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bTki8fKLeEVmGDHZQEHTyIYCOzNCo0WPGCXVwvBbMoc=;
        b=VGP1VvHjsd6T2GZKvXrjW3Xj9A38luKkKAEky1oIoNCxdR5HNx3Vy/NhAMJ/5C5U95RDOS
        /KMVqi/qNe+VUqrrEJQJNtVu5bqsP7KokLgyRL7DMgi7G7jSjwzSVD30o7C4hgiA3Pr6zL
        tkYDsHYnoddma3pjxfqLWJJ8HFq3PIw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0DB513F62;
        Thu, 25 Nov 2021 09:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 11HFJHBTn2FxGgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 25 Nov 2021 09:12:16 +0000
Subject: Re: [PATCH v2 3/3] btrfs: call mapping_set_error() on btree inode
 with a write error
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1637781110.git.josef@toxicpanda.com>
 <f6f2469932a07a706149353618a1f77e88706fc2.1637781110.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ffca7be9-8246-460e-68e8-2b3e86822383@suse.com>
Date:   Thu, 25 Nov 2021 11:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f6f2469932a07a706149353618a1f77e88706fc2.1637781110.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.11.21 г. 21:14, Josef Bacik wrote:
> generic/484 fails sometimes with compression on because the write ends
> up small enough that it goes into the btree.  This means that we never
> call mapping_set_error() on the inode itself, because the page gets
> marked as fine when we inline it into the metadata.  When the metadata
> writeback happens we see it and abort the transaction properly and mark
> the fs as readonly, however we don't do the mapping_set_error() on
> anything.  In syncfs() we will simply return 0 if the sb is marked
> read-only, so we can't check for this in our syncfs callback.  The only
> way the error gets returned if we called mapping_set_error() on
> something.  Fix this by calling mapping_set_error() on the btree inode
> mapping.  This allows us to properly return an error on syncfs and pass
> generic/484 with compression on.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/extent_io.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 3454cac28389..1a67f4b3986b 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4314,6 +4314,14 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
>  	 */
>  	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
>  
> +	/*
> +	 * We need to set the mapping with the io error as well because a write
> +	 * error will flip the file system readonly, and then syncfs() will
> +	 * return a 0 because we are readonly if we don't modify the err seq for
> +	 * the superblock.
> +	 */
> +	mapping_set_error(page->mapping, -EIO);
> +
>  	/*
>  	 * If we error out, we should add back the dirty_metadata_bytes
>  	 * to make it consistent.
> 
