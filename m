Return-Path: <linux-btrfs+bounces-5480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44888FD501
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004A11C20A20
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63265143C4D;
	Wed,  5 Jun 2024 18:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ceG2MjW+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rLbqVJ1q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ceG2MjW+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rLbqVJ1q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1432E401
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610557; cv=none; b=MUiyP5CU+spVcLpoN+iDDkn3aO1t023Ys7a8ELkyG7hn+061xD/av1yjyDuzdV3JWWaPY0HcXaqGMFoWbqOxgHQeN9bHm/YipikfN20LtV4DjgJYi6VRCmUW/QUTk14znCzi4X4mgmJMEPsfDa9ffWLviIUGjSC17pWOX5iZ5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610557; c=relaxed/simple;
	bh=0MAVrm3IgWRwoI+x/4qcx9EReTpxp/fG7XBWhkhlD48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZYXL58tyXnUkQbc4UvJwKmM8VXkHrlC4wRN5P4O8MtDXGHoFYLlXAiSwzYK+6CIQyR6BmFskBLCBtdGsno1p74ObOPmWSYAwpFVIUd8AyM8V5LSHXP3xDsUkn/PMp21PfY/XLWqjjWaA8ogEBludSYUEtWIWYw5fTVGxqenUms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ceG2MjW+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rLbqVJ1q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ceG2MjW+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rLbqVJ1q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D4DC21A9A;
	Wed,  5 Jun 2024 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717610553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWgZtiwX3YX+Wx7ZTQlyqMYcjpMJV0jNm6tKxuyxSn0=;
	b=ceG2MjW+E7i4frMdc7lstuYkv+gQHZzAyuGxyV4wQ5FighATeuz9SKd9OXKY93pp5jTrCE
	ZX9CVRuiS6p7VnDrIxKCw7JftzcNnh9Yri0MC3j1Nov2Kdv2Rrv8Bd7dTylQ3OCs2XXz1V
	YIEsGKc5wSDgOoPRnUXSAV+jbNAxiY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717610553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWgZtiwX3YX+Wx7ZTQlyqMYcjpMJV0jNm6tKxuyxSn0=;
	b=rLbqVJ1qgDbUcW9XIJiT5j7jNXXXmO4UDxP5YUPWfchthCbQmLl2cK2NH/BHcXfYefUTDn
	k16ActFwHa2QDkBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ceG2MjW+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rLbqVJ1q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717610553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWgZtiwX3YX+Wx7ZTQlyqMYcjpMJV0jNm6tKxuyxSn0=;
	b=ceG2MjW+E7i4frMdc7lstuYkv+gQHZzAyuGxyV4wQ5FighATeuz9SKd9OXKY93pp5jTrCE
	ZX9CVRuiS6p7VnDrIxKCw7JftzcNnh9Yri0MC3j1Nov2Kdv2Rrv8Bd7dTylQ3OCs2XXz1V
	YIEsGKc5wSDgOoPRnUXSAV+jbNAxiY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717610553;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWgZtiwX3YX+Wx7ZTQlyqMYcjpMJV0jNm6tKxuyxSn0=;
	b=rLbqVJ1qgDbUcW9XIJiT5j7jNXXXmO4UDxP5YUPWfchthCbQmLl2cK2NH/BHcXfYefUTDn
	k16ActFwHa2QDkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B9C313A24;
	Wed,  5 Jun 2024 18:02:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id My3/HTmoYGYNeAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Jun 2024 18:02:33 +0000
Date: Wed, 5 Jun 2024 20:02:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fix a check condition in misc/038
Message-ID: <20240605180232.GD18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a49e6b43e3c140995567fea035017309b4bcd53c.1717480797.git.wqu@suse.com>
 <20240604155454.GA3413@localhost.localdomain>
 <b06a8ffc-f45b-4bf3-a5b3-64877771a549@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06a8ffc-f45b-4bf3-a5b3-64877771a549@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8D4DC21A9A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Wed, Jun 05, 2024 at 07:38:39AM +0930, Qu Wenruo wrote:
> >> -[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
> >> +if [ "$main_root_ptr" -ne "$backup_new_root_ptr" ]; then
> >> +	_fail "Backup ${slot_num} not overwritten"
> >
> > Don't we prefer just "$slot_num"?  I feel like I've gotten yelld at for this
> > before.  Just change the existing thing to be correct
> 
> I thought we prefer ${} to be more safe, but since it's followed by a
> space, it should be no difference.

The thing that I ask for is to quote all variables, otherwise the _ in
variable name is recognized so ${two_words} is the same as $two_words.
Where it would matter is if _ follows the variable, otherwise no ${ }.

