Return-Path: <linux-btrfs+bounces-1243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2D8245A0
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 17:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7827A1F22C3F
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 16:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21C24B28;
	Thu,  4 Jan 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gy/HAVLT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3RcDYnQX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sbx8rM4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IbGrB8OO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04945249E9;
	Thu,  4 Jan 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E153E1F7FE;
	Thu,  4 Jan 2024 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704384021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4Xn9KqraJoS04FwRt9Y/22XkZrBEmyjMHNojdzv4mI=;
	b=Gy/HAVLT/Lk+a77XmOarzCG8JeNB9v0v2Ahcd3wAqdBKaZSN63/s/7xMv+p97pwzTQHTN/
	i+j1K6EJ4Zax5fH3dhEjaczLsAu/3hk2jhXUcrUVV+FRJuQTe+P9mTv2978/dNsvPoCLCd
	M1QoWUUcQ9ThYDvf+aXdH/LsfbC8oF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704384021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4Xn9KqraJoS04FwRt9Y/22XkZrBEmyjMHNojdzv4mI=;
	b=3RcDYnQX3tejAfIglkS/vB3BKM4ZfGzJiCriQh55CFaFwZnAU0Wetv1+74WMWedSm/qwlX
	qbOWJBMc+au3lsDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704384020;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4Xn9KqraJoS04FwRt9Y/22XkZrBEmyjMHNojdzv4mI=;
	b=sbx8rM4dc9FmLb/p4esF+K1oZoegZiiw6fSy93On66DAPlt2wGZCmvkSO1Yt8srOHb/HMb
	Fb8qfyVy9dYpVyRUWwVB/rJGAjgfe9MriXwQfVhHyHMAk7cBN2zOBHEBcLSeEvV+rFv0Yc
	iaXlf58d9fQ8Bi64aMfRP1nIrQ7L/N4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704384020;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4Xn9KqraJoS04FwRt9Y/22XkZrBEmyjMHNojdzv4mI=;
	b=IbGrB8OOCrVGLRSDSAgw7LmgTjNY50RaKsnr1mQqs8Ne3BGkmkriW9DPOWa0sHfGwA5ixF
	2XI8Fy0z8bY3jDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4C3113C96;
	Thu,  4 Jan 2024 16:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oI/aLxTWlmX9VwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jan 2024 16:00:20 +0000
Date: Thu, 4 Jan 2024 17:00:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com,
	syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: ref-verify: free ref cache before clearing mount
 opt
Message-ID: <20240104160009.GF15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240103103128.30095-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103103128.30095-1-pchelkin@ispras.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sbx8rM4d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IbGrB8OO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.08 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 BAYES_HAM(-0.37)[76.92%];
	 TAGGED_RCPT(0.00)[be14ed7728594dc8bd42,c563a3c79927971f950f];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim,linuxtesting.org:url,appspotmail.com:email,ispras.ru:email];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.08
X-Rspamd-Queue-Id: E153E1F7FE
X-Spam-Flag: NO

On Wed, Jan 03, 2024 at 01:31:27PM +0300, Fedor Pchelkin wrote:
> As clearing REF_VERIFY mount option indicates there were some errors in a
> ref-verify process, a ref cache is not relevant anymore and should be
> freed.
> 
> btrfs_free_ref_cache() requires REF_VERIFY option being set so call
> it just before clearing the mount option.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
> Reported-by: syzbot+be14ed7728594dc8bd42@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000e5a65c05ee832054@google.com/
> Reported-by: syzbot+c563a3c79927971f950f@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000007fe09705fdc6086c@google.com/
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Added to misc-next, thanks.

