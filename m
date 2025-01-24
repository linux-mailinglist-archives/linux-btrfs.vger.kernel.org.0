Return-Path: <linux-btrfs+bounces-11062-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70097A1BE1C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 22:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51BB167267
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB451DC985;
	Fri, 24 Jan 2025 21:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UbyvubAu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g58Y+3u8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UbyvubAu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g58Y+3u8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CB1BD9E7
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737755399; cv=none; b=kvew8cgQ/wzQPA65jJYm3FgN9psd3vyrqLk8v8nuMN4QsegzqnKA+8DFMRtQRaERqnLnjFPndSfgqtl9XXb6Mm0EyFmS/UeR62VDVY4/YXae3AC2zDqqSox/roslwNAlo0Mzx3WROKAsRKC8hcVs1pMidmKbGNNiy03Y9guHuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737755399; c=relaxed/simple;
	bh=sSw+EeHUeE9Ng/5i39enS++uacoPT4rMx5CaI2rVsxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfzqbnSfRnoRAkd7fe2aDfT8phZxlBxzn3CD2INROPzZARBNDL4ugNdBTL23qV89GbwI50xOkWmIIeoiymHN2WOH1GktucjCe9XijTB6+RRXyTyABcSjF/51ISJtO8MZ8r5/7Vw/e4+9GCm0Vqp0vU4/2Z048Am9erh/5Caslxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UbyvubAu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g58Y+3u8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UbyvubAu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g58Y+3u8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD60A1F443;
	Fri, 24 Jan 2025 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737755394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+UmlJ6Nlwh/8sCgT5fTeBMyFlujbIAE10tIzA2Le7Q=;
	b=UbyvubAuzfi2WjjdCqnjxKPWzdG8Y0DoppXWbO/luvR+VK3U/5BejCZgphpwUcUkcS6vh+
	+KewaIqUAQrditbkzGhIXkWO81M4lALgTbC7p3pND7w0NbRVCD+LBcrVyDMlaccQCnqi6z
	Ql5XZCBB6lV13dEPeaR1d437H1BImTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737755394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+UmlJ6Nlwh/8sCgT5fTeBMyFlujbIAE10tIzA2Le7Q=;
	b=g58Y+3u8D1bNu8x2oItuVT/WkuyPzUZndKQEay1TZaRa77YbRtPunn3NocekY2Q0yOAHcD
	3aogVtGhfTEWoxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737755394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+UmlJ6Nlwh/8sCgT5fTeBMyFlujbIAE10tIzA2Le7Q=;
	b=UbyvubAuzfi2WjjdCqnjxKPWzdG8Y0DoppXWbO/luvR+VK3U/5BejCZgphpwUcUkcS6vh+
	+KewaIqUAQrditbkzGhIXkWO81M4lALgTbC7p3pND7w0NbRVCD+LBcrVyDMlaccQCnqi6z
	Ql5XZCBB6lV13dEPeaR1d437H1BImTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737755394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+UmlJ6Nlwh/8sCgT5fTeBMyFlujbIAE10tIzA2Le7Q=;
	b=g58Y+3u8D1bNu8x2oItuVT/WkuyPzUZndKQEay1TZaRa77YbRtPunn3NocekY2Q0yOAHcD
	3aogVtGhfTEWoxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB110139CB;
	Fri, 24 Jan 2025 21:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HyaNKAILlGeSFAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 24 Jan 2025 21:49:54 +0000
Date: Fri, 24 Jan 2025 22:49:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Matthew Wilcox <willy@infradead.org>, Qu Wenruo <wqu@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: Fix two misuses of folio_shift()
Message-ID: <20250124214952.GP5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250121054054.4008049-1-willy@infradead.org>
 <20250121054054.4008049-2-willy@infradead.org>
 <33fa9947-cead-4f38-a61a-39b053f37a03@suse.com>
 <20250121161011.GG5777@suse.cz>
 <Z4_gmbY6_sTVAeIL@casper.infradead.org>
 <20250122152450.GJ5777@twin.jikos.cz>
 <6206360a-545d-4842-b43d-1855f78d7da5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6206360a-545d-4842-b43d-1855f78d7da5@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.85
X-Spamd-Result: default: False [-3.85 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.05)[-0.268];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Jan 24, 2025 at 04:41:46PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/1/23 01:54, David Sterba 写道:
> > On Tue, Jan 21, 2025 at 05:59:53PM +0000, Matthew Wilcox wrote:
> >>>>> +			if (folio_contains(folio, i_size >> PAGE_SHIFT) &&
> >>>>
> >>>> Although folio_contains() is already a pretty good improvement, can we
> >>>> have a bytenr/i_sized based solution for fs usages?
> >>>
> >>> Good point, something like folio_contains_offset() that does the correct
> >>> shifts.
> >>
> >> I'd call it folio_contains_pos(), but I'm not sure there's a lot of
> >> users.  We've got a lot of filesystems converted now, and btrfs is the
> >> first one to want something like that.  I've had a look through iomap
> >> and some other filesystems, and I can't see anywhere else that would use
> >> folio_contains_pos().
> >
> > Ok then, we can live with that, but please keep it in mind for future
> > folio API updates. Thanks.
> >
> Then the whole series looks good to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> And since the whole series is reviewed, should I merge this series into
> for-next now?

Yes please.

