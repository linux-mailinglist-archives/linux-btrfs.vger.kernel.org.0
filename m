Return-Path: <linux-btrfs+bounces-2598-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565085C376
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 19:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC8AB25419
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBE678665;
	Tue, 20 Feb 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQMCGWag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7UEVYjO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQMCGWag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x7UEVYjO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD57764C;
	Tue, 20 Feb 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452797; cv=none; b=tFrFHgY5WMcoyIIU7SWg8z9AFmKtcY/EQpFjfBRbbJQkqzozBY+IPLGleikif9G4/XkEHiWS8k4he1vm3Q75cbTgJTEmaQLLgf1QtP4TWaD0Qhjhql4bMiDA786l1RPWpTiWDpy9A1Hl2Jc29/plWnkilJGjEKWGajZLHEqJRgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452797; c=relaxed/simple;
	bh=EqcKyO3P7dppHSuzNcw0smmf/DhyVg96kMAjvjcqGTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAhXBS7svoVMwdPgc2YtiBoRRjryc3zo0oSbnAQfsLviA+vPfjevBDw8S5T+6SRdwOqwDmLVfbp9z8hjypgBtYE7f4K+y0i6KAXZlEU3+CvNpXjqhxJjUVkRX4SCASQrmFQoGHQnesQcdOesAXKrNzxMDgW+1rYn+rd4RtQPt1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UQMCGWag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7UEVYjO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UQMCGWag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x7UEVYjO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 605EA21DBD;
	Tue, 20 Feb 2024 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708452793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOCOp+pOd/LrYT1vXNYbEllONUwin50q8/G6oCcTLxE=;
	b=UQMCGWagPB137wK/YpauccnrD3ApbBzw975mAPxhMIJghA4fLOjm5yy1m+6di1pHcG6KV2
	H1hl/AXFVpqYpMR+ofKH4zJYC4PvEeB1rmAT7O/btHYD7Sywi0KAl5Aib3DZ0rAZ/0hoJF
	/kLKBcOfTMo7Th00k9fdW7f48EK2P6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708452793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOCOp+pOd/LrYT1vXNYbEllONUwin50q8/G6oCcTLxE=;
	b=x7UEVYjO4SsRB3Q6K5h0OWWbmg234tA0+vMQei9FAFy7XbpmdIxlvANPVOD7iprd3FacZz
	uROFOqIQLpdCG+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708452793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOCOp+pOd/LrYT1vXNYbEllONUwin50q8/G6oCcTLxE=;
	b=UQMCGWagPB137wK/YpauccnrD3ApbBzw975mAPxhMIJghA4fLOjm5yy1m+6di1pHcG6KV2
	H1hl/AXFVpqYpMR+ofKH4zJYC4PvEeB1rmAT7O/btHYD7Sywi0KAl5Aib3DZ0rAZ/0hoJF
	/kLKBcOfTMo7Th00k9fdW7f48EK2P6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708452793;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOCOp+pOd/LrYT1vXNYbEllONUwin50q8/G6oCcTLxE=;
	b=x7UEVYjO4SsRB3Q6K5h0OWWbmg234tA0+vMQei9FAFy7XbpmdIxlvANPVOD7iprd3FacZz
	uROFOqIQLpdCG+CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 445681358A;
	Tue, 20 Feb 2024 18:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zoh5ELnr1GWoXwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 20 Feb 2024 18:13:13 +0000
Date: Tue, 20 Feb 2024 19:12:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	dsterba@suse.com, aromosan@gmail.com, bernd.feige@gmx.net,
	CHECK_1234543212345@protonmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
Message-ID: <20240220181236.GF355@suse.cz>
Reply-To: dsterba@suse.cz
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
 <20240214071620.GL355@twin.jikos.cz>
 <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=35N4OBrbJB61rK0mt2w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.19
X-Spamd-Result: default: False [-2.19 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-1.19)[89.06%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,suse.com,gmail.com,gmx.net,protonmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On Tue, Feb 20, 2024 at 02:08:00PM +0000, Filipe Manana wrote:
> On Wed, Feb 14, 2024 at 7:17 AM David Sterba <dsterba@suse.cz> wrote:
> > On Tue, Feb 13, 2024 at 09:13:56AM +0800, Anand Jain wrote:
> > https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering
> 
> So this introduces a regression.
> 
> $ ./check btrfs/14[6-9] btrfs/15[8-9]

Thanks, with this I can reproduce it and have some ideas what could go
wrong.

