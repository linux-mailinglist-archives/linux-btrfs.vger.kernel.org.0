Return-Path: <linux-btrfs+bounces-5302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774FD8D0848
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC0DB2B101
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2024 16:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F296155CA6;
	Mon, 27 May 2024 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="akvUQLSZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1oCo9j7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="akvUQLSZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a1oCo9j7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E3E17E913;
	Mon, 27 May 2024 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826487; cv=none; b=p1fGERFVt25iWxc2bVXYw5J77q/IqTuEKGFOJqT5H/4It8iGWWEM0Me47qobRnDfa6qgPXgmMMqM+ZI3Xf/iKS+FXVlXjdDXojjwqNx0t5sc3f6XUn5yMBQbPIAAWdpcxUPyBGE+CHr2012L9uGvqV52XP0zElA5NRiHe2xX888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826487; c=relaxed/simple;
	bh=ujfSi3fu/yloH/M4yTSPIT1sEFbDxfHs66CZJiGQ9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikdCnRan+F4/lEMX+3UQw1j9aSj+RdnEAr+QhFkQsOZuqYk3+xhRphk97wSCHXchWAXwTsXwdS3ThcPtqyyypL++UERC/one13Kh2hlAZnDtdyqeMf+1NjR898NIaKy4xqabdygQIGz1p2Vn2Na6SYA26wzuwGqb82RVBTKzFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=akvUQLSZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1oCo9j7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=akvUQLSZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a1oCo9j7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80E2121F87;
	Mon, 27 May 2024 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716826483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wssN6e0yGUvF1iJN/7+g+bS10CSfVX5ayRqBNqac4Bk=;
	b=akvUQLSZJCeZpd4YAWKDu+6iaZkf53Lp+CcaAX8/Y9tfDwqcIX8ZGqPBrHN3aNkSKOSXgJ
	kG8UL6qMP1UsEYC6eCZCvbUE9zS2UZl+4qNt4ndaN7CFPACfNfHN/mjUtphBkK9+zJlFse
	tNiF1r+oRn+f94HsVBDDohpr12yNeSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716826483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wssN6e0yGUvF1iJN/7+g+bS10CSfVX5ayRqBNqac4Bk=;
	b=a1oCo9j7HDlkvWOhfs9ZESGIw/LCCJltL0LKO5WUSP0Gc68pFUF4jOgtq6qZ/Qs6ybEiqN
	tygARkaIUU6t/UAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=akvUQLSZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a1oCo9j7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716826483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wssN6e0yGUvF1iJN/7+g+bS10CSfVX5ayRqBNqac4Bk=;
	b=akvUQLSZJCeZpd4YAWKDu+6iaZkf53Lp+CcaAX8/Y9tfDwqcIX8ZGqPBrHN3aNkSKOSXgJ
	kG8UL6qMP1UsEYC6eCZCvbUE9zS2UZl+4qNt4ndaN7CFPACfNfHN/mjUtphBkK9+zJlFse
	tNiF1r+oRn+f94HsVBDDohpr12yNeSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716826483;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wssN6e0yGUvF1iJN/7+g+bS10CSfVX5ayRqBNqac4Bk=;
	b=a1oCo9j7HDlkvWOhfs9ZESGIw/LCCJltL0LKO5WUSP0Gc68pFUF4jOgtq6qZ/Qs6ybEiqN
	tygARkaIUU6t/UAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6730B13A56;
	Mon, 27 May 2024 16:14:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1icIGXOxVGYzXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 27 May 2024 16:14:43 +0000
Date: Mon, 27 May 2024 18:14:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RIP: + BUG: with 6.8.11 and BTRFS
Message-ID: <20240527161438.GB8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e8b3311c-9a75-4903-907f-fc0f7a3fe423@gmx.de>
 <3c053912-4e47-4c44-be80-dee4ade8bc6b@gmx.de>
 <1d887489-200c-46e1-9ee3-8b18722ce19c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d887489-200c-46e1-9ee3-8b18722ce19c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com,gmx.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 80E2121F87
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Mon, May 27, 2024 at 07:02:56PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/5/27 00:16, Toralf Förster 写道:
> > On 5/26/24 11:08, Toralf Förster wrote:
> >>
> >> I upgraded yesterday from kernel 6.8.10 to 6.8.11.
> >>
> >> The system does not recover from reboot in moment.
> >
> > It recovered eventually, I switched to 6.9.2, which runs fine so far.
> > But these are new log messages:
> 
> That looks exactly the one Linus recently reported
> (https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/)

It could be similar to what was fixed in ef1e68236b91 ("btrfs: fix race
in read_extent_buffer_pages()"), also hard to reproduce. The stack
traces are the only clues we have now.

