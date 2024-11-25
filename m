Return-Path: <linux-btrfs+bounces-9892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2CC9D8984
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 16:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF6AB635AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87131A0AF0;
	Mon, 25 Nov 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qLx6pdb1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="37x3+rJ8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dbn7ZLCT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lZG4lkxl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4551AF0B6;
	Mon, 25 Nov 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548065; cv=none; b=DPwmfYgpFcBbRyXtI1Np6pfRzVp4yMCvCJU5cpQBCoR4YnBBoU/0GvzAEkdrKifj/NIt6LpMsgTzqXwKuLJpNsxp50ZRFn4VyMPqCpQ15hpYm3+hB4pQKGrxakdMM+A6l7CahI0ZqFkhcn1HslZsUsuVDYKszi7wYJ0/jn9WqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548065; c=relaxed/simple;
	bh=seO3Pm/x9LSkjva1NX4KCFamd/LgWUSzvy43QNb/CGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRIfmz6Fzkip+LqH9BRvCN4Og/Mqon4zrf6D85cAMJ3NA6DUgRo/gc1LSfcGeuRiPRI+OlXi6Q5b6z0ywN3wBysAAKRw4uqWt/bnBIrFGFyNaggOtLiOBBLMWBFgJKPrJYIhoic+I/o1Do0yKTq0C1f1tPs3z2urLiUigI66nac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qLx6pdb1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=37x3+rJ8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dbn7ZLCT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lZG4lkxl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1D54210EC;
	Mon, 25 Nov 2024 15:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732548061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoAWULgQ+12/qkERTrKknRtiwarJfKO1XnhLhe1rT7Q=;
	b=qLx6pdb1bKc9/i8dg3f/wh9WDkS+X1p7r1zT+J8sP5njYA1FU9Pgq6QLDpbifDMSXftVER
	TjNNJo3wmljcBu3m6uX24W60Ev4gx1fJDGZEDZFwAnIaUI9QTcQmpIWI9oeFlGIdYnpIYf
	Wtc6i1TVzI5qQb5VYT09RDQkwBnDawg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732548061;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoAWULgQ+12/qkERTrKknRtiwarJfKO1XnhLhe1rT7Q=;
	b=37x3+rJ80cfbXKr7osJFP6rAcWd4kjWRmIdDrVWG9WqohQB+//egUTwzkVxvDS6TB9h5Tb
	CHKgeV6pyQXmHdDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Dbn7ZLCT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lZG4lkxl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732548060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoAWULgQ+12/qkERTrKknRtiwarJfKO1XnhLhe1rT7Q=;
	b=Dbn7ZLCTu48pZJxHkD3M00ilIIcwOxcvgpEp8YK2RIexdf12bjLZ99HXXRPZ6xA5yYmtsk
	sWNBC0x4g08teb9T/7Fk9BGbxMNF/QnQPvuaGEF2m8p0smeSVvWvTTy+ceFULtEDvNYcVE
	buSuhhOeXPr4zToO4J3zTBxfmHS9shI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732548060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoAWULgQ+12/qkERTrKknRtiwarJfKO1XnhLhe1rT7Q=;
	b=lZG4lkxlQjwO92tdWCI1jORy2ql+f2qOEv+YJXHzox6W/ND2IbCTTmccD2ekWm4DYeZRdC
	6dZi+kUG/kha7gBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E2E0137D4;
	Mon, 25 Nov 2024 15:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0kR/ItyVRGf/WgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Nov 2024 15:21:00 +0000
Date: Mon, 25 Nov 2024 16:20:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 09/19] btrfs: zlib: make the compression
 path to handle sector size < page size
Message-ID: <20241125152059.GY31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241124123912.3335344-1-sashal@kernel.org>
 <20241124123912.3335344-9-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124123912.3335344-9-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B1D54210EC
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sun, Nov 24, 2024 at 07:38:44AM -0500, Sasha Levin wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> [ Upstream commit f6ebedb09bb276256e084196e2322562dc4aac10 ]
> 
> Inside zlib_compress_folios(), each time we switch the input page cache,
> the @start is increased by PAGE_SIZE.
> 
> But for the incoming compression support for sector size < page size
> (previously we support compression only when the range is fully page
> aligned), this is not going to handle the following case:
> 
>     0          32K         64K          96K
>     |          |///////////||///////////|
> 
> @start has the initial value 32K, indicating the start filepos of the
> to-be-compressed range.
> 
> And when grabbing the first page as input, we always call "start +=
> PAGE_SIZE;".
> 
> But since @start is starting at 32K, it will be increased by 64K,
> resulting it to be 96K for the next range, causing incorrect input range
> and corruption for the future subpage compression.
> 
> Fix it by only increase @start by the input size.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please drop this patch from stable, it's preparatory work and has
otherwise no effect.

