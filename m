Return-Path: <linux-btrfs+bounces-4627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C18B5F4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 18:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8B1C21996
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7385C62;
	Mon, 29 Apr 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RVtqP71h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2oqCFjFu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rU6iDkNQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vz7Al63S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F184D15
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714409033; cv=none; b=ZCgfRor2v+gdkP5gmRaRRH4vX0AzsMvo7rq+04HoTayvW/5+3WYrbw+G0q2Z3oRO61sy5dALK/FNSWrUZZTMUBt0KJa/n71T6Rb52RVCn8biJtgl9+12vEsRQ4jMGokI74kN7qnEAWrbLFXnUhxeWuuZuv6xWnLKAEyUMqfzrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714409033; c=relaxed/simple;
	bh=XH8Cx56RkkDJgWmoDaOw4ogo/13UqvBrfQ0rBB3ky0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haH/ZNBlWybSW6aiQE+/zobndGuxX1A1RWePIIwtcNj+B4TEjoimkWuain4lOsB1MCFJ1VTy67v51r2tol7aKeJ6pvVDticwabXemXcA68GVOzDp6aRmAUSOxpYijP++yA+miqkZVsUCXmvtvJB6htiOXwPzuhtAa58TlAll5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RVtqP71h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2oqCFjFu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rU6iDkNQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vz7Al63S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C6581F385;
	Mon, 29 Apr 2024 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714409030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svx7K1Kil5Y7USEvYNARe7yyQTUi7DU8m27i92KWoMg=;
	b=RVtqP71hMP1o9UvxoUGwz1T8qA0/JCKWU8QB7EgC+Lp79CAGDaZC2dxTfrjxP5qlUjmApS
	dak7dAGQNPJXT1FQxsOMdHXzlEKkNCEsTwmQzGv1UxGyZDcBkOuJuow3UspB/jPJ3FoGwO
	791JrPLoCNmnQp8mWQ98S/7HIsoxFUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714409030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svx7K1Kil5Y7USEvYNARe7yyQTUi7DU8m27i92KWoMg=;
	b=2oqCFjFuMyYxo8EWRvFaniFCqUlhhFnvI7zfCmhKSuSdRWidXMBimgkmI3VaKhltpT1Dl8
	3yc1jD39TLCrrgCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714409028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svx7K1Kil5Y7USEvYNARe7yyQTUi7DU8m27i92KWoMg=;
	b=rU6iDkNQwEuU2wubvpVK4xxAuNcQN7mvFWzvIX10s4pO9XtbAcIkYSWMxe1v/UkM/1gPn7
	peVXGlu5k+GgKcXpn9CcMmaCa2hwwDj0Efj/Ytv9ghA8AF7YfJW9vSfem1l6ky+1YcM+eG
	sAoMkgVAPtyy6QR2/JRDIkD1mP0Q9hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714409028;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svx7K1Kil5Y7USEvYNARe7yyQTUi7DU8m27i92KWoMg=;
	b=vz7Al63SY0AHJjmXGtONDHgMRd0rBaGZnBJSr80l1CeycrY75kPQ7g1w8BZ/rsrPIy/CUQ
	FnEG+ju/QlGNpuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67B6E138A7;
	Mon, 29 Apr 2024 16:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nSziGETOL2b3NwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 16:43:48 +0000
Date: Mon, 29 Apr 2024 18:36:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, boris@bur.io
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240429163634.GH2585@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]

On Fri, Apr 26, 2024 at 07:21:08AM +0930, Qu Wenruo wrote:
> > btrfs subvolume delete 123
> > btrfs subvolume sync 123
> > btrfs qgroup remove 0/123
> >
> > but this needs to wait until the sync is finished and that is not
> > expected for the subvolume delete command.
> 
> That's the problem, and why doing it in user space has it limits.
> 
> Furthermore, with drop_subtree_threshold or other qgroup operations
> marking the qgroup inconsistent, you can not delete that qgroup at all,
> until the next rescan.

Ok so that makes it more complicated and better solved in kernel, with
the compatibility issues mentioned in the other mail.

> > It needs to be fixed but now
> > I'm not sure this can be default in 6.9 as planned.
> 
> I'd say, you should not implement this feature without really
> understanding the challenges in the first place.
> 
> And that's why I really prefer you send out non-trivial btrfs-progs for
> review, other than pushing them directly into github repo.

As discussed on slack, the development happens in git, for btrfs-progs
the mails are overhead that does not pay off.

