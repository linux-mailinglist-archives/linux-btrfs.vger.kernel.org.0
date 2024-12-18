Return-Path: <linux-btrfs+bounces-10585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BED9F6EC6
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173867A2925
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38211FC7F8;
	Wed, 18 Dec 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cDytL1mR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DHhAh0O7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cDytL1mR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DHhAh0O7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B392158520
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552886; cv=none; b=dO5ASj3B/9mts0xchnqZonMESBNWwgM9nFbGU/TAxBomHCFms/fFGUxEC3JGdLo865sqYo9eRO/nomDUnY95MA+DuHvrOCfnbByvpRFRSM3i3rhUmeB0AXAeEvUUKldr6ZvKXHl7PfrIpFFlthux8ZPl3HokrdB36V8cuvjTKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552886; c=relaxed/simple;
	bh=G17cGmdPl1sQd2zc+GTtr5kjCAPd5h1CerdiepbDE6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsj0lts0TEmZoGgq/d+66Dk107jOxtGEyqj60b+8I67LPcW6xIvti21Tn4F0C+xPWSk81o65Eq9DJNWtYT2tY07J+xoYoxksaoCIIMxJDJZYjtcm2EOqYHyDj5jrZWkfEhMJ+WO3POB5d9TJXOBLxKC+cINHvR0Ljtt7tanBNIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cDytL1mR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DHhAh0O7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cDytL1mR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DHhAh0O7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 158A421164;
	Wed, 18 Dec 2024 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734552882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnlKzjScXtFVcbKhdGK18bPn2lMkuQMQbM+KlWPIik=;
	b=cDytL1mRf2R5iFGdosWr0j1T5AVYnWpv1eDvEARxoEjcqdq5S9b29WMzDTRp8OvAm5WD/b
	uyfJCDrPTEGSa9riDsC87MJAfA4hfhAgbYga0oSHEPtELnqcs/giEActC+PO4oxKw3FCXF
	o9o+OmLXZ9/n4oezOLOTb6XGVCFRSds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734552882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnlKzjScXtFVcbKhdGK18bPn2lMkuQMQbM+KlWPIik=;
	b=DHhAh0O7dANtyGGU0x52tBgO8jukpVIChGYOGZKpIZ48cjuRaRtjq1fjyNLzm3GUoZw2Rm
	5DBAcicjvj5WQBDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cDytL1mR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DHhAh0O7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734552882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnlKzjScXtFVcbKhdGK18bPn2lMkuQMQbM+KlWPIik=;
	b=cDytL1mRf2R5iFGdosWr0j1T5AVYnWpv1eDvEARxoEjcqdq5S9b29WMzDTRp8OvAm5WD/b
	uyfJCDrPTEGSa9riDsC87MJAfA4hfhAgbYga0oSHEPtELnqcs/giEActC+PO4oxKw3FCXF
	o9o+OmLXZ9/n4oezOLOTb6XGVCFRSds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734552882;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnlKzjScXtFVcbKhdGK18bPn2lMkuQMQbM+KlWPIik=;
	b=DHhAh0O7dANtyGGU0x52tBgO8jukpVIChGYOGZKpIZ48cjuRaRtjq1fjyNLzm3GUoZw2Rm
	5DBAcicjvj5WQBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0789137CF;
	Wed, 18 Dec 2024 20:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3a17OjEtY2f1CgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 20:14:41 +0000
Date: Wed, 18 Dec 2024 21:14:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: move csum related functions from ctree.c into
 fs.c
Message-ID: <20241218201440.GF31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734368270.git.fdmanana@suse.com>
 <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
 <36af89a5-f7e8-4a9f-a7ff-880a84d2fc6d@gmx.com>
 <CAL3q7H7pwip+TwR7tTS7cLHz0UWBzfAP9ZpcXN6OGT7O800i3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7pwip+TwR7tTS7cLHz0UWBzfAP9ZpcXN6OGT7O800i3Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 158A421164
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Dec 17, 2024 at 08:55:21AM +0000, Filipe Manana wrote:
> > I'm wondering if those simple functions can be converted to inline.
> >
> > Although btrfs_csums[] array has to be put inside fs.c, those functions
> > seems be fine defined as inline ones inside the header.
> 
> Yes, the array being inside fs.c makes it hard to inline in the header.
> 
> Keep in mind that this is a change just to move things around, the
> goal is not to change the implementation or optimize anything.
> Plus it's not like these functions are called in hot code paths where
> saving a function call has any significant impact.

Yeah the checksum related functions are not on any hot path, usually
called once or twice in a function. Exporting the btrfs_csum array to
make a few functions inilne should have some measurable impact.

