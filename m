Return-Path: <linux-btrfs+bounces-12047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA89A54630
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363AF17161C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 09:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6006208992;
	Thu,  6 Mar 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4BRhg9s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="scq7niL4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4BRhg9s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="scq7niL4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145120101A
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253055; cv=none; b=iLykFk9i6O72dAfrllcoiNmQr6w8aLz4W2rj/75B3xz6rcdnnpScz8qRNdV/nfKtDrTS40tTfJsvjvhB80mL0QO6juR2qSIYd7Pl/daesVn1109eEXQMHvnLs7fKW2yl+8QqbrBdhjGkXf2gX3G3pr3yLqkydwJnehxUr08u2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253055; c=relaxed/simple;
	bh=doItNh7lrcFHw+7MCCwsMIhzv4WpYm+QzTDXz4kmyfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXOL1GUhbkML85C6HzVi7p000ZUTchtJONd1TiBaDyyNDdjtObDNoOqVtflhV562j/QEp/jg8MA0Q+kMWU6C4K5N1g2Q5uONG8plcH+TTP4oLPo5NRdmigH484b2TO0rQtvWXd54yfndYZQ3l2hvAXvqgvyxLaS7GPwRje+YbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4BRhg9s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=scq7niL4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4BRhg9s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=scq7niL4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 969861F747;
	Thu,  6 Mar 2025 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741253045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6WU0fDNy/kG2iIU1QuVoA3OouHHIWc3XQ+A1TSYpwk=;
	b=K4BRhg9sY4l5U+3vXyHWKH5x5RpLuHzAGb1mvEFW9Y8iwXSc0HtD8eaNLpCnUIkXY2mwrM
	XclZ/+Zi9kiJsNKmlAzpFeKKxgDFlAKn324B9TLv1Xx3k+G3xi8iP7rJSUspkzZD6UO+4T
	hmrpxsAho8o5UeNAjtnbePMvMPJqfmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741253045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6WU0fDNy/kG2iIU1QuVoA3OouHHIWc3XQ+A1TSYpwk=;
	b=scq7niL4+Fh2wudCHT4hwSnDoEX71YabqypDwl6FfZZWrDkT9B7kzSKiG0RQoB+i9Ghlwy
	rTWgq8fc+pPP8bCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K4BRhg9s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=scq7niL4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741253045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6WU0fDNy/kG2iIU1QuVoA3OouHHIWc3XQ+A1TSYpwk=;
	b=K4BRhg9sY4l5U+3vXyHWKH5x5RpLuHzAGb1mvEFW9Y8iwXSc0HtD8eaNLpCnUIkXY2mwrM
	XclZ/+Zi9kiJsNKmlAzpFeKKxgDFlAKn324B9TLv1Xx3k+G3xi8iP7rJSUspkzZD6UO+4T
	hmrpxsAho8o5UeNAjtnbePMvMPJqfmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741253045;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6WU0fDNy/kG2iIU1QuVoA3OouHHIWc3XQ+A1TSYpwk=;
	b=scq7niL4+Fh2wudCHT4hwSnDoEX71YabqypDwl6FfZZWrDkT9B7kzSKiG0RQoB+i9Ghlwy
	rTWgq8fc+pPP8bCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA8213A61;
	Thu,  6 Mar 2025 09:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z1j9GrVpyWclFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Mar 2025 09:24:05 +0000
Date: Thu, 6 Mar 2025 10:24:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, Filipe Manana <fdmanana@kernel.org>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] btrfs: fix inline data extent reads which zero
 out the remaining part
Message-ID: <20250306092400.GJ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739608189.git.wqu@suse.com>
 <4e0368b2d4ab74e1a2cef76000ea75cb3198696a.1739608189.git.wqu@suse.com>
 <CAL3q7H5yrvxK5QFeCmfU+_sMmxpFyfcL_W8CALcCPLjkbbJHLQ@mail.gmail.com>
 <64782982-20d5-41e7-81d0-6960f3b5c0ee@gmx.com>
 <CAPjX3FcqrQ-0PF1OxMzr=rNNwdz3M3vq5VQGGZFC-ndhdfSc7A@mail.gmail.com>
 <3586594f-f24f-4307-abec-3b20b3437cdf@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3586594f-f24f-4307-abec-3b20b3437cdf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 969861F747
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Feb 28, 2025 at 10:09:46AM +1030, Qu Wenruo wrote:
> 在 2025/2/28 01:06, Daniel Vacek 写道:
> > On Fri, 21 Feb 2025 at 23:39, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> [...]
> >> Any good suggestions? Especially I'm pretty sure such pattern will
> >> happen again and again as we're approaching larger data folios support.
> >
> > Perhaps an fstest which fails having the later patch without this one
> > would help?
> 
> BTW, for the backports I really mean stable backports, not someone
> picking up those out-of-tree patches.
> 
> And for the fstests failure suggestion, it's already covered by both
> generic fstests runs and a dedicated btrfs specific one.
> 
> But unfortunately it's not the first nor the last time that stable
> branches picks some patches without their dependency.
> 
> So I guess what we can do is really just checking the stable patch mails
> and manually reject those incorrect backports, at least for now.

I try to do that as I get CCed on all of them, other than patch authors
and the mailinglist. It's getting harder to evaluate the patch for old
stable trees, even with the dependencies listed. If you see a patch
backport and feel it's wrong, incomplete or not necessary please reply.
Most of them are OK because we do proper patch separation but cleanups
and refactoring introduce subtle changes that do not transfer across
distant versions.

