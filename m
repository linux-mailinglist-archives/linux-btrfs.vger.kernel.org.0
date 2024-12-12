Return-Path: <linux-btrfs+bounces-10326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE039EFC09
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C475128CEF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BE1922E4;
	Thu, 12 Dec 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BsD00iIp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfUGiHj7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BsD00iIp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MfUGiHj7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEED188722;
	Thu, 12 Dec 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030464; cv=none; b=IcexBhQy2PzcDl4xek2k0UedMzXlXsKsrhzwpLSHqpZ2U7+9odrq9gvaQj+WUn+gBY5ysH7cbVaAfmFSFWIdqmJJ65lL44yXMhmZlSC1Qu9xqQr7WNeoXzTIbnJXDbXHxJVGMglbUp7j9v18neZTRrG0cIIVPu1nQk/VJImrvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030464; c=relaxed/simple;
	bh=sGdzzV6E/rI5g3logA4o76dfyuCnYsHfPPIMcI2XD7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbSukmHJ4Wf24yJ11K5veDUZWoWu002bo2BvUwtgYlkt4FBskxKAlMsbmthRJM5xr5M5+mEr8wElqHRj8k9rz/DLKieAuHxvJ+FFCiSsTTB2y//AkeoIqGIZko4q9/fHqyS+eIY3lyeXG0xdZrM/Ae7x0d1O3/GTWzgngmjnCfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BsD00iIp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfUGiHj7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BsD00iIp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MfUGiHj7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 846BE1F37C;
	Thu, 12 Dec 2024 19:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734030460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6nOQNfjlp8/gPOnK0kS3/hz4FmE6wWLT5nfsY448C4=;
	b=BsD00iIpeSnNTojWvYgfFaKfrqwDFZhSVmQOTexilwa2rXOQ7TsoxoDTeQWVyMWyRPxweD
	69mCvrQ724BhzTKUnEJkeIeGpkLmvpx0+zRx/2YA7134AsjvbIJAUBFo6umhG2aOJ2OBhz
	brBwPi2cZpiFwaluynweNctb/l5tu7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734030460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6nOQNfjlp8/gPOnK0kS3/hz4FmE6wWLT5nfsY448C4=;
	b=MfUGiHj7V/2Tju4jwVl4g4oAjnSi49ERQfxTaP1xtr7TMuo2jZ2HGseKYh9HGCTp+7CN1K
	48R+OmoWOUjkqxCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734030460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6nOQNfjlp8/gPOnK0kS3/hz4FmE6wWLT5nfsY448C4=;
	b=BsD00iIpeSnNTojWvYgfFaKfrqwDFZhSVmQOTexilwa2rXOQ7TsoxoDTeQWVyMWyRPxweD
	69mCvrQ724BhzTKUnEJkeIeGpkLmvpx0+zRx/2YA7134AsjvbIJAUBFo6umhG2aOJ2OBhz
	brBwPi2cZpiFwaluynweNctb/l5tu7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734030460;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A6nOQNfjlp8/gPOnK0kS3/hz4FmE6wWLT5nfsY448C4=;
	b=MfUGiHj7V/2Tju4jwVl4g4oAjnSi49ERQfxTaP1xtr7TMuo2jZ2HGseKYh9HGCTp+7CN1K
	48R+OmoWOUjkqxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 433BA13508;
	Thu, 12 Dec 2024 19:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xcPlD3w0W2dxQQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 12 Dec 2024 19:07:40 +0000
Date: Thu, 12 Dec 2024 20:07:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Omar Sandoval <osandov@fb.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
Message-ID: <20241212190738.GY31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241212075303.2538880-1-neelx@suse.com>
 <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
 <CAPjX3FcAZM4dSbnMkTpJPNJMcPDxKbEMwbg3ScaTWVg+5JqfDg@mail.gmail.com>
 <133f4cb5-516d-4e11-b03a-d2007ff667ee@wdc.com>
 <CAPjX3FchmM24-Afv7ueeK-Z1zBYivfj4yKXhVq6bARiGjqQOwQ@mail.gmail.com>
 <9d5b4776-e3c8-449c-bb0d-c200a1f76603@wdc.com>
 <CAPjX3FdU1mOkRr+JVE+S4og4NvjFerZhHC_qupFBTgjn9=s8MA@mail.gmail.com>
 <a8047d3a-ab45-42f0-8c60-f00829e40518@wdc.com>
 <CAPjX3Fexb19AcchSttsmm=JCcobBBCPXxF6_qkK=_yuqtgNRRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPjX3Fexb19AcchSttsmm=JCcobBBCPXxF6_qkK=_yuqtgNRRg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Dec 12, 2024 at 11:26:20AM +0100, Daniel Vacek wrote:
> On Thu, Dec 12, 2024 at 11:10 AM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
> >
> > On 12.12.24 10:35, Daniel Vacek wrote:
> > > On Thu, Dec 12, 2024 at 10:14 AM Johannes Thumshirn
> > > <Johannes.Thumshirn@wdc.com> wrote:
> > >> It got recently force pushed, 34725028ec5500018f1cb5bfd55c669c7bbf1346
> > >> it is now, sorry.
> > >
> > > Yeah, this looks very similar and it should fix the bug as well. In
> > > fact the fix part looks exactly the same, I just also changed the
> > > slab/stack allocation while you changed the atomic/refcount. But these
> > > are unrelated, IIUC. I actually planned to split it into two patches
> > > but David told me it's not necessary and I should send it as it is.
> > >
> > > Just nitpicking about your patch, the subject says simplify while I
> > > don't really see any simplification.
> > > Also it does not mention the UAF bug leading to crashes it fixes,
> > > missing the Fixes: and CC: stable tags.
> > >
> > > What do we do now?
> >
> > I think it's up to David if he want's to send the patch for this rc or
> > not. In my test environment the part that went upstream was sufficient
> > to fix the UAF, so this was the part that actually went to Linus first.
> 
> But it (I assume you are referring to `05b36b04d74a`) does not really
> fix the UAF. I'm still able to get the same crashes even with this
> commit applied. That was actually where I originally started testing.
> 
> > @Dave can you send '34725028ec55 ("btrfs: simplify waiting for encoded
> > read endios")' in the next PR? I can update the Fixes tag.
> 
> The commit message definitely needs to be updated mentioning that this
> actually fixes the UAF which `05b36b04d74a` does not really address.

Yeah, the commit message does not say anything about fixing things so I
skipped it when looking for -rc fixes.

