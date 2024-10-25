Return-Path: <linux-btrfs+bounces-9175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B879B0CA1
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 20:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC1C1F21492
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 18:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8620D4F9;
	Fri, 25 Oct 2024 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B4uKYLgz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9aT6z5Al";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqMhHRNC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="up4zWkXL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3A13B5AE;
	Fri, 25 Oct 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879402; cv=none; b=P9Ah7uaTuRLTGyZimWspA0OQvWAQ7JALfVUCW5Xp9m8ukwPZoXwoPNh4k6rlvav6OZo/dGsyalEa5lIl5iDvo7u6zi0BWlG3SR3BxNUElN+op6MX0DObK2Lbomv386konDDrllCEuAkmRoJSXV52TRR32DMDCpmOFTFpOe6+yzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879402; c=relaxed/simple;
	bh=bLAIJsxFb6W4t2nZjay4Fx/wzn4Oxu/qVugdUZ9wXoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRUVRTjjyb0c5yQME8ee0FROPBQEGwSJ5C2cBOUuCWQIZDEy26d2yHJH8n30ytf/BhV6xU2A7vOCal3NyvsC5x9My1Jj1NsOnlLxt+FB4O84nDt3wNLr8HvFlz7BJED59oGSxoj50LYoEd9juTHhv0d72qBaXQsF6cPorbrqOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B4uKYLgz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9aT6z5Al; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AqMhHRNC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=up4zWkXL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CED71FB97;
	Fri, 25 Oct 2024 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729879398;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNmuAFCfHSnn6YkV+yvDtN2I0JDVQ2I+Fez05bFXgnw=;
	b=B4uKYLgzfXbmzbtV06HZfa6bUPsPUt210OexqCso3Ketdta5xsXbA6yyAyxIXox1yH7fsQ
	TL6BjqHoaMCgbAVM06tecVGW+t8TA388HiJEcW7vs0iZVry6t2r/D9PJkIetHReEDDRCML
	wfaWKVKQlk4YH6zyV5N4u+Ox3x8YlIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729879398;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNmuAFCfHSnn6YkV+yvDtN2I0JDVQ2I+Fez05bFXgnw=;
	b=9aT6z5AlqTFj/GtzJNktk0vtuCDjQd3Rog9sJZbdgiTxbvfCk96Ln5FBVBYE7dZnprN4ID
	LK8Apd8tjmOBOQCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AqMhHRNC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=up4zWkXL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729879397;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNmuAFCfHSnn6YkV+yvDtN2I0JDVQ2I+Fez05bFXgnw=;
	b=AqMhHRNClHj1k8Xk17eGSZOzOpHdLFn+2WtvikBgOhp20E23IMs3jM5wwU06umg/LJskaG
	zNuo76p6k2ZeOrzR0svXHw+upwTKSY6nb2A77KwHR9nl/wHH+kDKe1qYAhhb6gaC4zG4al
	RsF52uNL3UrOy7N53ZlJA6Az8HRFijo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729879397;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNmuAFCfHSnn6YkV+yvDtN2I0JDVQ2I+Fez05bFXgnw=;
	b=up4zWkXLKkRSKIBVq5hOwOh6DF/riD9jgjIOjQArUIEc1y5HYHOrQcr17dD/AI2rgRQFQb
	CQ8hGxpcuFb/xSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DED4132D3;
	Fri, 25 Oct 2024 18:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0DyLBWXdG2cLHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 25 Oct 2024 18:03:17 +0000
Date: Fri, 25 Oct 2024 20:03:15 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com, clm@fb.com,
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: add a sanity check for btrfs root
Message-ID: <20241025180315.GI31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
 <20241025045553.2012160-1-lizhi.xu@windriver.com>
 <03bcaafe-4a15-487a-af2b-b23970162bbb@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03bcaafe-4a15-487a-af2b-b23970162bbb@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4CED71FB97
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[3030e17bd57a73d39bd7];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,appspotmail.com:email,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Fri, Oct 25, 2024 at 08:23:07PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/25 15:25, Lizhi Xu 写道:
> > Syzbot report a null-ptr-deref in btrfs_search_slot.
> > It use the input logical can't find the extent root in extent_from_logical,
> > and triger the null-ptr-deref in btrfs_search_slot.
> > Add sanity check for btrfs root before using it in btrfs_search_slot.
> 
> Although I'd prefer to explain a little more about why the NULL root
> pointer can happen (caused by the rescue=all mount option), which can
> cause NULL root pointer for non-critical tree roots, like
> uuid/csum/extent or even device trees.
> 
> You don't need to bother sending an update.
> I can add such info when pushing to the maintainer's tree.
> 
> >
> > Reported-by: syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3030e17bd57a73d39bd7
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>

> > @@ -2023,6 +2023,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> >   	int min_write_lock_level;
> >   	int prev_cmp;
> >
> > +	if (!root)
> > +		return -EINVAL;

The function returns errors indirectly so it's not clear which could be
ultimately returned. I did a quick search over the calls starting in
btrfs_search_slot() and it seems that EINVAL is not used so we'd know if
it ends up in some error report. The ones I found: EAGAIN, EIO, EUCLEAN,
ENOMEM.

