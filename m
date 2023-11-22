Return-Path: <linux-btrfs+bounces-281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BBA7F4855
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 14:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8752C1C20ACF
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5384E622;
	Wed, 22 Nov 2023 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yrt0lVYw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGsol3QI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07380197
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 05:53:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A977F1F385;
	Wed, 22 Nov 2023 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700661232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4POG8bHffxXvdd8/Hwd88L+gZluCnDm37d9TAqgicF0=;
	b=yrt0lVYwtVJjoHcEFfK6mtspAd0frlFucKdfhC+G+1gczxnlkIhJbeeQLy/2OxlBxTQxza
	ulq0Rygi3TsTBCROX57LupEIAjTNFZDlQZfj3pA4wldKz7Dc2rtr0JilCY7LsiCxE+d4Sx
	th/0Dw1vzLe+De+V7XlwPHXSTXcGudU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700661232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4POG8bHffxXvdd8/Hwd88L+gZluCnDm37d9TAqgicF0=;
	b=GGsol3QIDR3VS/ZydgTyFirTNfePfeRqWmsMOG8TRrQXi/wlFekW7cEj1CNZ/Pvir+coYL
	K/9uDrMc+yKvPPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 824F213467;
	Wed, 22 Nov 2023 13:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WU3wHvAHXmWJdgAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 13:53:52 +0000
Date: Wed, 22 Nov 2023 14:46:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231122134642.GB11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.81
X-Spamd-Result: default: False [-3.81 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.81)[99.19%]

On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>  	char *kaddr;
>  	int i;
>  
> +	memset(result, 0, BTRFS_CSUM_SIZE);
>  	shash->tfm = fs_info->csum_shash;
>  	crypto_shash_init(shash);
> +
> +	if (buf->addr) {
> +		crypto_shash_digest(shash, buf->addr + offset_in_page(buf->start) + BTRFS_CSUM_SIZE,
> +				    buf->len - BTRFS_CSUM_SIZE, result);
> +		return;
> +	}

This duplicates the address and size
> +
>  	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
>  	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>  			    first_page_part - BTRFS_CSUM_SIZE);
> @@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>  		kaddr = page_address(buf->pages[i]);
>  		crypto_shash_update(shash, kaddr, PAGE_SIZE);
>  	}
> -	memset(result, 0, BTRFS_CSUM_SIZE);
>  	crypto_shash_final(shash, result);

I'd like to have only one code doing the crypto_shash_ calls, so I'm
suggesting this as the final code (the diff is not clear);

 74 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 75 {
 76         struct btrfs_fs_info *fs_info = buf->fs_info;
 77         int num_pages;
 78         u32 first_page_part;
 79         SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 80         char *kaddr;
 81         int i;
 82
 83         shash->tfm = fs_info->csum_shash;
 84         crypto_shash_init(shash);
 85
 86         if (buf->addr) {
 87                 /* Pages are contiguous, handle it as one big page. */
 88                 kaddr = buf->addr;
 89                 first_page_part = fs_info->nodesize;
 90                 num_pages = 1;
 91         } else {
 92                 kaddr = page_address(buf->pages[0]);
 93                 first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
 94                 num_pages = num_extent_pages(buf);
 95         }
 96         kaddr += offset_in_page(buf->start) + BTRFS_CSUM_SIZE;
 97         first_page_part -= BTRFS_CSUM_SIZE;
 98
 99         crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
100                             first_page_part - BTRFS_CSUM_SIZE);
101
102         for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
103                 kaddr = page_address(buf->pages[i]);
104                 crypto_shash_update(shash, kaddr, PAGE_SIZE);
105         }
106         memset(result, 0, BTRFS_CSUM_SIZE);
107         crypto_shash_final(shash, result);
108 }

