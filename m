Return-Path: <linux-btrfs+bounces-748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE51880897E
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 14:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A851F21480
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B52F40C0E;
	Thu,  7 Dec 2023 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PICrZt+i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcfM03uD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PICrZt+i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcfM03uD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38746D5E
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Dec 2023 05:50:15 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF5271FB69;
	Thu,  7 Dec 2023 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701957013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgAUd+TPuIRlZ7KLPwzwwGWGnkPBeynQBMz/lmtgc7Q=;
	b=PICrZt+ignnodCUHEmYgsVJwo1678LI1Rn6//6gfkxiy5U/NoiK1jS6ps4Yt+KMKkBleER
	q990NowiBDcIUO1PmjINrOXI92dufmaINj4hEReh40pgZb0BjEMGsYspJ+V/m1IoJZh3Va
	b1ck2SbGFfaqQrUK3xa9UgA9s07ZWgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701957013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgAUd+TPuIRlZ7KLPwzwwGWGnkPBeynQBMz/lmtgc7Q=;
	b=mcfM03uDTxM1BFT+3F9S2StmaMysbTfVBrr62J57k2ZwYCdKAXeqaUVvq9ec6hs2aR4dej
	HnU5r6okL0voelBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701957013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgAUd+TPuIRlZ7KLPwzwwGWGnkPBeynQBMz/lmtgc7Q=;
	b=PICrZt+ignnodCUHEmYgsVJwo1678LI1Rn6//6gfkxiy5U/NoiK1jS6ps4Yt+KMKkBleER
	q990NowiBDcIUO1PmjINrOXI92dufmaINj4hEReh40pgZb0BjEMGsYspJ+V/m1IoJZh3Va
	b1ck2SbGFfaqQrUK3xa9UgA9s07ZWgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701957013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgAUd+TPuIRlZ7KLPwzwwGWGnkPBeynQBMz/lmtgc7Q=;
	b=mcfM03uDTxM1BFT+3F9S2StmaMysbTfVBrr62J57k2ZwYCdKAXeqaUVvq9ec6hs2aR4dej
	HnU5r6okL0voelBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A694A13907;
	Thu,  7 Dec 2023 13:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gYJwKJXNcWWHGgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 07 Dec 2023 13:50:13 +0000
Date: Thu, 7 Dec 2023 14:43:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/2] btrfs: cleanup metadata page pointer usage
Message-ID: <20231207134322.GW2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1701902977.git.wqu@suse.com>
 <55a172a8d8501f8111ef300fa8919ecb813acff8.1701902977.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a172a8d8501f8111ef300fa8919ecb813acff8.1701902977.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Score: -3.96
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -5.16
X-Spamd-Result: default: False [-5.16 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.16)[69.39%]
X-Spam-Flag: NO

On Thu, Dec 07, 2023 at 09:39:28AM +1030, Qu Wenruo wrote:
>  /* Release all pages attached to the extent buffer */
>  static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
>  {
>  	int i;
> -	int num_pages;
> +	int num_folios;
>  
>  	ASSERT(!extent_buffer_under_io(eb));
>  
> -	num_pages = num_extent_pages(eb);
> -	for (i = 0; i < num_pages; i++) {
> -		struct page *page = folio_page(eb->folios[i], 0);
> +	num_folios = num_extent_folios(eb);
> +	for (i = 0; i < num_folios; i++) {

I could not resist and updated the style in a few functions to

	int num_folios = num_extent_folios(eb);

	for (int i = 0; ...) {
	}

i.e. move num_extent_folios() to the declarataions unless there's some
'return/return' between them and moved the global 'int i' to the for()
loop.

It's a cleanup but the lines are changed anyway and we'll probabaly not
touch this code anytime soon.

