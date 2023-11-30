Return-Path: <linux-btrfs+bounces-462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCD7FFF6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 00:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914A1281AD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Nov 2023 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411559538;
	Thu, 30 Nov 2023 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xeb0m2IO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H376VCXO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B64810E4
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Nov 2023 15:26:08 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B16361FD15;
	Thu, 30 Nov 2023 23:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701386766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAXPeXIyuZJ6mG4zCc/Q5HLqRssowkyizl474rifU2A=;
	b=Xeb0m2IO/q9DIhvvZXfcDEGnQY/PBTNm1LF3q5OgOELPyT2Z6/9IP/NAqz6q108KQrQIec
	4sfTmvOyDDHcrwyN3fP26DvAqpIKriEwDCDFBBcATrmOHMVWde8M2xYlrCfwYtfzba3YXS
	mxMcQFJfWbkZPluLSdHwRCXFtnSdfqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701386766;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tAXPeXIyuZJ6mG4zCc/Q5HLqRssowkyizl474rifU2A=;
	b=H376VCXOAgad649P1ASnuEVpU0b+rWs2OAP02Ksc1HYWyNwdt9ZEZifJzdl0RXeXO1JohC
	wJ6X/GsYvDaO3yDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A27E0138E5;
	Thu, 30 Nov 2023 23:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7ZJ0Jw4aaWW9awAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 30 Nov 2023 23:26:06 +0000
Date: Fri, 1 Dec 2023 00:18:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: migrate extent_buffer::pages[] to folio
Message-ID: <20231130231852.GW18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87c95b697347980b008d8140ceec49590af4f5d.1701037103.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 BAYES_SPAM(0.00)[22.17%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.993];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.00

On Mon, Nov 27, 2023 at 08:48:45AM +1030, Qu Wenruo wrote:
>  		return;
>  	}
>  
> -	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
> +	kaddr = folio_address(buf->folios[0]) + offset_in_page(buf->start);
>  	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>  			    first_page_part - BTRFS_CSUM_SIZE);
>  
> -	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
> -		kaddr = page_address(buf->pages[i]);
> -		crypto_shash_update(shash, kaddr, PAGE_SIZE);
> -	}
> +	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++)
> +		crypto_shash_update(shash, folio_address(buf->folios[i]),
> +				    PAGE_SIZE);

This still says PAGE_SIZE while it's folios, so for now we have the same
order for both, right? After full conversion we'll need folio_size().

