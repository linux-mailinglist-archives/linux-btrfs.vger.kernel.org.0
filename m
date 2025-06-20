Return-Path: <linux-btrfs+bounces-14814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC3AE1AA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 14:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C561BC7999
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jun 2025 12:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B328A730;
	Fri, 20 Jun 2025 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhRBb37x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DuQmjtO1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhRBb37x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DuQmjtO1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF628A40F
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Jun 2025 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421431; cv=none; b=i3etkdtJsYfPE7xN+1Ael8WzG1eJfXdjd76dEF742N75PjffogpH390N5BENKBC+3cYXjBe13T07yJQR+KpsUGrCpVKo17rdL4e8VjKkFAq9wwVLVyxAlp7Qs21S5GW/v6etRDhEbHaI3cHzuUMOM5Q9PcQMYLerjbByZvD/8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421431; c=relaxed/simple;
	bh=0c6G4ezB7n9pkIUyv9bnGlcuKAlKhDQ3VpEzkNKVIsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef8DoneFiy9BZ8ntalVEzCKjbmLbOkhRnPKcXMjtUu/v/w05JCnNV7Lsmu+82SEAPxmUUoNjcxIN/RlFULWXBN3l42zyEvJS9WQ9yCHkjF9/l9vIeyx3Wkm7h5l5yiupPIMMHel2OMIQ2WKdZ9Ck9U+n/Dl2MURaS7U7YqMoqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhRBb37x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DuQmjtO1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhRBb37x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DuQmjtO1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 59D231F390;
	Fri, 20 Jun 2025 12:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750421427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgunLvfVe+hv/xr6J58uQgXIaJOYMDgGWti1qfCqXYE=;
	b=fhRBb37xCR9dyzu3U+/ieNwSoawNlxLClFW1kvk0AamtDbyOX+LWUMQbMFngbk6MM9mmpJ
	K2DBlJcG+nns/XJBrERfGVUeQtnBgsqPnjm73CH7b6w1gUWfGBRbRL0unLvnK774CQkO69
	lfmmgTMk3Tqk6oxj25BTpfML0F9mqwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750421427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgunLvfVe+hv/xr6J58uQgXIaJOYMDgGWti1qfCqXYE=;
	b=DuQmjtO1k8Zbmu/ykG2yhS9wMPzheUH4BA5VKubSJySyAA0uXKgQ2lsIScufqKxDkOPS79
	Uzj1hEULkRXqleCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fhRBb37x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DuQmjtO1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750421427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgunLvfVe+hv/xr6J58uQgXIaJOYMDgGWti1qfCqXYE=;
	b=fhRBb37xCR9dyzu3U+/ieNwSoawNlxLClFW1kvk0AamtDbyOX+LWUMQbMFngbk6MM9mmpJ
	K2DBlJcG+nns/XJBrERfGVUeQtnBgsqPnjm73CH7b6w1gUWfGBRbRL0unLvnK774CQkO69
	lfmmgTMk3Tqk6oxj25BTpfML0F9mqwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750421427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgunLvfVe+hv/xr6J58uQgXIaJOYMDgGWti1qfCqXYE=;
	b=DuQmjtO1k8Zbmu/ykG2yhS9wMPzheUH4BA5VKubSJySyAA0uXKgQ2lsIScufqKxDkOPS79
	Uzj1hEULkRXqleCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 330ED13736;
	Fri, 20 Jun 2025 12:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RJoBC7NPVWhRIwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 20 Jun 2025 12:10:27 +0000
Date: Fri, 20 Jun 2025 14:10:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: open code RCU for device name
Message-ID: <20250620121025.GO4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750244832.git.dsterba@suse.com>
 <6d43001159c86467bfa1afe928deade5805af8fe.1750244832.git.dsterba@suse.com>
 <CAPjX3FeGLSJ2WFJqdN12saSEAeBYObsoJdttYiA=iDZNMKM1HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FeGLSJ2WFJqdN12saSEAeBYObsoJdttYiA=iDZNMKM1HQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 59D231F390
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Jun 19, 2025 at 12:15:25PM +0200, Daniel Vacek wrote:
> > @@ -2167,7 +2171,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
> >         btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
> >
> >         /* Update ctime/mtime for device path for libblkid */
> > -       update_dev_time(device);
> > +       update_dev_time(device;
> 
> This looks like a mistake. I believe the hunk should be removed,
> otherwise it won't compile.

Yes it's a mistake. I've checked how it got there, most likely after
reordering the patch moving RCU to update_dev_time, the parameter
changed from device->name to device.

