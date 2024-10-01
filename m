Return-Path: <linux-btrfs+bounces-8389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B13F98C13E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 744601C23B37
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588621C9EA6;
	Tue,  1 Oct 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZnEVoUzd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFQH+qnd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1QMeequU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HT2Yuye8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84731C8FB5
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795392; cv=none; b=SGhtL1NjNJalh4PLHzIxm5Z4nobc0OpgFLxiphS2UW5G0BY6HpY6Il1lZBxX/kJ0tNR07u8s31HQ3Twj5GuvTF25jQJdWl4kYE9U5U9N0GCvUX22MA9EaK4+Kh5jrdMCpHIeLQFSGQ6S03JGQPXv4KFRsmqsVbCzp3Ud5pTE2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795392; c=relaxed/simple;
	bh=jdTn4al41afgi+7SiIxUAVznwjrLLw80tWK57B1wsPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGFnHOPDwQtGuDrcqw8MChSUCJ9UnxCM5YGd7cC0yq8j0QTc7sZNSoeFKtarLOeJX+4JJQs6BzIEGHKMLQdDyHoc3+L9e+OBftUD2Q3oY66e8Xb9NAxflFRnSSOicES2KC6gpF2rwhTgKNtd1Oq8bFr+1ipRPr3EVi3E3gqNQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZnEVoUzd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFQH+qnd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1QMeequU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HT2Yuye8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2578B21B06;
	Tue,  1 Oct 2024 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727795389;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTvok5OhcRVBVNJhSjakK0Fc8SBCWNIevYw5+jrbdJA=;
	b=ZnEVoUzdMiKGHEIn9hLa9fcm+6ZUswC5R+xdjX29eP4gDLvrrSr+7nZImGnB9cAGS3Jl79
	rrR8H9DQTjnUcjZkI5RlsAPkOTFb5DXSZWHsHc/D2konNcG537/pr8crtqEOUc1DBI/vVS
	whaArCWwTi+apHiDVH1CTckLuCYEGK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727795389;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTvok5OhcRVBVNJhSjakK0Fc8SBCWNIevYw5+jrbdJA=;
	b=yFQH+qndasTIJWJPj8ebSJlGlDUkmp70hqgIFUiEIcqTBPO9ypW23oJjzxNrNfHigHpIyW
	G6f+IB3n6YcPT8Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727795387;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTvok5OhcRVBVNJhSjakK0Fc8SBCWNIevYw5+jrbdJA=;
	b=1QMeequUmnA0ACk1HtDZc9NcBmIszxNY2Lpj68RWviNVAsw706i0ktyjoyyjmpFV07t40U
	rLkEScPyqJU7OJEik8UWvlQp5EgTfxht/2EaWJhSjsCZWHr1TYWGx5KrM6kMTh2SNhnN/M
	j/JbcA4VOjV9wBB/bljsuy25rTn8BSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727795387;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTvok5OhcRVBVNJhSjakK0Fc8SBCWNIevYw5+jrbdJA=;
	b=HT2Yuye8Hgj8b1wUlyZDW09swtS9HGnQXrsTMmd28cucpWzGD06xzEUcs38d7j1MkBZ1F/
	fK3PWRSUhssXnmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1287A13A6E;
	Tue,  1 Oct 2024 15:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dfALBLsQ/GaiLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 01 Oct 2024 15:09:47 +0000
Date: Tue, 1 Oct 2024 17:09:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Peter Volkov <peter.volkov@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: BTRFS critical (device dm-0): corrupt node: root=256
 block=1035372494848 slot=364, bad key order, current (8796143471049 108 0)
 next (50450969 1 0)
Message-ID: <20241001150941.GB28777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAE+k_g+XFhkRBF0ErnRCBVaXAwUb3Tf9rm+Yny8u6aOLDQqihA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE+k_g+XFhkRBF0ErnRCBVaXAwUb3Tf9rm+Yny8u6aOLDQqihA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
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

On Tue, Oct 01, 2024 at 02:15:51PM +0000, Peter Volkov wrote:
> Hi! I've been using this system with this kernel (6.10.10) for a few
> months already and today out of nowhere btrfs broke with this error
> message:
> 
> [53923.816740] page dumped because: eb page dump
> [53923.816743] BTRFS critical (device dm-0): corrupt node: root=256
> block=1035372494848 slot=364, bad key order, current (8796143471049
> 108 0) next (50450969 1 0)

Quite obvious memory bitflip:

8796143471049 = 0x8000301c9c9
     50450969 = 0x301d219

The first one should probably be 0x301c9c9, but it's impossible to tell
how many other data/metadata could have been hit by this or another
memory bitflip so check can detect the things but not fix.

