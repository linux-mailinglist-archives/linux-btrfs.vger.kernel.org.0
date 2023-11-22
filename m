Return-Path: <linux-btrfs+bounces-317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D3C7F5307
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 23:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746AD1C20C2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79721F607;
	Wed, 22 Nov 2023 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yAG99R1E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLdxse5j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1363B9
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 14:12:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49A5A21985;
	Wed, 22 Nov 2023 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700691146;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASaksTAmvl5CcoekhEgGEIY7lKgt9PRq54fNd65hZxw=;
	b=yAG99R1Ef7KSAaAPJkjYn69LH95e4ctatXKOmGizFp1vj5mv4wzobsWKg8Bgql3kD/tfPd
	CLFSrXBheSPAkZgdcj0Xr7KtymeY9oN7Xkpi3PXR3UiJIlV2libcHvuILu4S3hcmHcaUjm
	rWg8HdIBCae5Ox/I6NuFHNhVem6Nr2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700691146;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ASaksTAmvl5CcoekhEgGEIY7lKgt9PRq54fNd65hZxw=;
	b=FLdxse5jF0ZsZzXHWfEDGe6fIQnWCCRrPkGoc1/5kXILLaSqCA7vUHy1mI4GBKJyf81DgE
	IQqegQ+13uQo5SBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1024613467;
	Wed, 22 Nov 2023 22:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Fi4hA8p8XmUnPQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Wed, 22 Nov 2023 22:12:26 +0000
Date: Wed, 22 Nov 2023 23:05:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: allow extent buffer helpers to skip
 cross-page handling
Message-ID: <20231122220516.GF11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
 <20231122134642.GB11264@twin.jikos.cz>
 <c1c0dacb-8db5-4b6b-90f1-a71487fb44dd@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c0dacb-8db5-4b6b-90f1-a71487fb44dd@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.985];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.79)[99.10%]

On Thu, Nov 23, 2023 at 06:31:41AM +1030, Qu Wenruo wrote:
> 
> 
> On 2023/11/23 00:16, David Sterba wrote:
> > On Thu, Nov 16, 2023 at 03:49:06PM +1030, Qu Wenruo wrote:
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >>   	char *kaddr;
> >>   	int i;
> >>
> >> +	memset(result, 0, BTRFS_CSUM_SIZE);
> >>   	shash->tfm = fs_info->csum_shash;
> >>   	crypto_shash_init(shash);
> >> +
> >> +	if (buf->addr) {
> >> +		crypto_shash_digest(shash, buf->addr + offset_in_page(buf->start) + BTRFS_CSUM_SIZE,
> >> +				    buf->len - BTRFS_CSUM_SIZE, result);
> >> +		return;
> >> +	}
> >
> > This duplicates the address and size
> >> +
> >>   	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
> >>   	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
> >>   			    first_page_part - BTRFS_CSUM_SIZE);
> >> @@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
> >>   		kaddr = page_address(buf->pages[i]);
> >>   		crypto_shash_update(shash, kaddr, PAGE_SIZE);
> >>   	}
> >> -	memset(result, 0, BTRFS_CSUM_SIZE);
> >>   	crypto_shash_final(shash, result);
> >
> > I'd like to have only one code doing the crypto_shash_ calls, so I'm
> > suggesting this as the final code (the diff is not clear);
> 
> This looks good to me, mind to update it inside your branch?

Thanks, yes I'll update it. As it's not a completely trivial change I'd
like to get the confirmation first.

