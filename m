Return-Path: <linux-btrfs+bounces-5532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690F9005C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754A31F2539B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B68190672;
	Fri,  7 Jun 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M+yzSsLD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p8FRvz/l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M+yzSsLD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p8FRvz/l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E973194C9D
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768569; cv=none; b=EalUiTwZkd3kJyujvnf90NYKbsdoCm5f8Z29GLgIdPuj2bZZsLvS4QhCXfMSvvtc42JtxxqICGZxBVf9cMiBMPks/pGZotnE0YRJeM2RX67uEXFBi0Q85J1P94llzNO97QFuzrg0WdjuMxOc35PMKkAJlfQgaz5mXm9oA/sC0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768569; c=relaxed/simple;
	bh=AZDgWCOzmfi1nHv0YG3LYR4UfFO4E5uxwFX5e1jrfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpeZeIAh76Sgs6O+AcRu8XyLwV5QAlyddw7kcAsIkD7UhbNZHLnF+xcSEKECw/Z6KP1rebdvASbCAuHY8CBD1lYLcz4zUh+rE8/1yJ2kany1tkERZt3jZi7uTihA7Ym1DiG3MxT9CSkug44DgRn5EMGcj2WxrYQOIPcznLC3Xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M+yzSsLD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p8FRvz/l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M+yzSsLD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p8FRvz/l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F30651FBA2;
	Fri,  7 Jun 2024 13:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717768565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhnBvNc5TN9P3sxBc5sACVdmqZmy3xHzmLRrw+WZ+k8=;
	b=M+yzSsLDLbHMEDb4dNGAVEMoelX0oV2LZLSbE8kCRT85M8wdYn8MnEdVRsQPlPsQsb89V7
	BhJKiHVRavcBZIgqnZyn4pDotiqAGppRNZw4/PHrJMHyzgQiE1MuAT5sFHj5g4KDxGklgM
	rSnCMiUXLzuBlFZru4+SIgZbeHgeqQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717768565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhnBvNc5TN9P3sxBc5sACVdmqZmy3xHzmLRrw+WZ+k8=;
	b=p8FRvz/losPbOTYzOUlsC/lhybrhJATe5w2BUNtm04XuEOz7MIIV3n9ZX1UiUOiajvkRby
	3Thmv6VAwJ0tv5Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M+yzSsLD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="p8FRvz/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717768565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhnBvNc5TN9P3sxBc5sACVdmqZmy3xHzmLRrw+WZ+k8=;
	b=M+yzSsLDLbHMEDb4dNGAVEMoelX0oV2LZLSbE8kCRT85M8wdYn8MnEdVRsQPlPsQsb89V7
	BhJKiHVRavcBZIgqnZyn4pDotiqAGppRNZw4/PHrJMHyzgQiE1MuAT5sFHj5g4KDxGklgM
	rSnCMiUXLzuBlFZru4+SIgZbeHgeqQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717768565;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhnBvNc5TN9P3sxBc5sACVdmqZmy3xHzmLRrw+WZ+k8=;
	b=p8FRvz/losPbOTYzOUlsC/lhybrhJATe5w2BUNtm04XuEOz7MIIV3n9ZX1UiUOiajvkRby
	3Thmv6VAwJ0tv5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD13A133F3;
	Fri,  7 Jun 2024 13:56:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XnDBNXQRY2YDfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 07 Jun 2024 13:56:04 +0000
Date: Fri, 7 Jun 2024 15:56:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2] btrfs: fix a possible race window when allocating new
 extent buffers
Message-ID: <20240607135603.GG18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
 <20240606192722.GF18508@twin.jikos.cz>
 <c3197ead-6393-4a80-9e7b-ed8eb9b8a298@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3197ead-6393-4a80-9e7b-ed8eb9b8a298@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.71
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F30651FBA2
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FREEMAIL_CC(0.00)[suse.cz,suse.com,vger.kernel.org,linux-foundation.org,gmail.com,fb.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto]

On Fri, Jun 07, 2024 at 01:57:38PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/6/7 04:57, David Sterba 写道:
> [...]
> >
> > Thanks. I'll pick the patch to branch for the next pull request, the fix has
> > survived enough testing and we should get it to stable without further delays.
> > I've edited the subject and changelog a bit, the problem is really the folio
> > private protection, it is a race window fix but that does not tell much what is
> > the cause. I've also added the reproducer script from Chris.
> >
> 
> Mind to push the updated version to for-next?

Now updated, otherwise if you need to find it the branch is
https://github.com/kdave/btrfs-devel/tree/misc-6.10 or it's in the
linux-next source branch
https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/log/?h=next-fixes

> I'd like to restart the test of larger metadata folios.
> Ironically if we force larger metadata folios (one folio one metadata),
> the race can also be solved, as now folio lock would kick in to prevent
> the race.

Yeah, but this would be an accidental fix. If we didn't understand that
the bug was in our implementation I'm guessing large folios would be
blamed and this won't make finding the problem easier. We need to be
sure that the easy page->folio conversion is solid. You can start
testing it but the actual switch may take a release or two.

