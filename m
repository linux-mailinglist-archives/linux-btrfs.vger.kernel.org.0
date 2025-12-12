Return-Path: <linux-btrfs+bounces-19701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D0CB92AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 16:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3EFE300C8E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0832145E;
	Fri, 12 Dec 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NubJaiRc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UG+bXcNw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NubJaiRc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UG+bXcNw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB82F49FE
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554103; cv=none; b=VEe3VqWXJTAHa78fYFEO2QoRZKpUosC1ji0W0ePjIWx+5urwq3VH8htWB96WeH88mIACkzGCjsW1tEpPUzSkq72Wcp0d55eu0LHxYaSVK/98jwNwWqjHxYfpRdMr0Yh/7C/t9OeAAoF8YO1ZLxi/OKHXRAVq758cmJt3qd5XaTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554103; c=relaxed/simple;
	bh=ponqQTgT3V/j+lLHzyG5AyEANueRxB/4xRGzKNn880Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYMjID9dLQkxFo6eGnMjcIoVpN+NMBelJ7R3Hgzj9x5PA26nGM52ZYukobK62PBM5m2THkEUOdpxfgg28cusYG4wAOyFuJNNNbYrDL8xDum6ZeHzwsgCZbiECSin9jrtvwIMpNAvfYLxcObFSJ/yH/e08fRm1vHU/9VTDQt3eik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NubJaiRc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UG+bXcNw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NubJaiRc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UG+bXcNw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F23BC5BEE7;
	Fri, 12 Dec 2025 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765554099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3snGe4ZWe8sOULiKd186MIZcGo7e3c5Tj8PBbsru1J0=;
	b=NubJaiRcEVTlZzQUkgAlaDTTjhUWYVRCNkEHwY4mNsNcbBMdkt4ypnGKLPN7XYifTOKack
	MWD3CSbFcw6761FftMmITAZTrZZTiuRQsDpukZP9O3lXEvD44ENiQwKw2jTx3jSUgi6ywq
	kpsdWY6PPhiM1uayu5WapbDNKurrd0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765554099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3snGe4ZWe8sOULiKd186MIZcGo7e3c5Tj8PBbsru1J0=;
	b=UG+bXcNwbuUFd5Gr/jqxxd5yIn5JsikT3WhooLBngwFBCyhW6oWPJJLUAu/6V4OSjPOzDh
	cEGyR0V2kcaukqCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765554099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3snGe4ZWe8sOULiKd186MIZcGo7e3c5Tj8PBbsru1J0=;
	b=NubJaiRcEVTlZzQUkgAlaDTTjhUWYVRCNkEHwY4mNsNcbBMdkt4ypnGKLPN7XYifTOKack
	MWD3CSbFcw6761FftMmITAZTrZZTiuRQsDpukZP9O3lXEvD44ENiQwKw2jTx3jSUgi6ywq
	kpsdWY6PPhiM1uayu5WapbDNKurrd0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765554099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3snGe4ZWe8sOULiKd186MIZcGo7e3c5Tj8PBbsru1J0=;
	b=UG+bXcNwbuUFd5Gr/jqxxd5yIn5JsikT3WhooLBngwFBCyhW6oWPJJLUAu/6V4OSjPOzDh
	cEGyR0V2kcaukqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D437D3EA63;
	Fri, 12 Dec 2025 15:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZBSfM7I3PGk2BgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 12 Dec 2025 15:41:38 +0000
Date: Fri, 12 Dec 2025 16:41:37 +0100
From: David Sterba <dsterba@suse.cz>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix qgroup extent_changeset leak in page_mkwrite
Message-ID: <20251212154137.GA3195@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251212050947.148242-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212050947.148242-2-eraykrdg1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,suse.com,vger.kernel.org,gmail.com,linuxfoundation.org,syzkaller.appspotmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[2f8aa76e6acc9fce6638];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Fri, Dec 12, 2025 at 08:09:48AM +0300, Ahmet Eray Karadag wrote:
> syzbot reported a memory leak originating from ulist_prealloc()
> called from qgroup_reserve_data() in the btrfs_page_mkwrite()
> path. When btrfs_check_data_free_space() succeeds and
> btrfs_delalloc_reserve_metadata() later fails, we free the data
> reservation via btrfs_free_reserved_data_space(), but we never
> free the extent_changeset pointed to by data_reserved.
> 
> Add the missing extent_changeset_free(data_reserved) in this
> error path, matching the other exit paths in btrfs_page_mkwrite()
> and the failure handling in btrfs_check_data_free_space().
> 
> Reported-by: syzbot+2f8aa76e6acc9fce6638@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2f8aa76e6acc9fce6638
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>

Thanks a fix is already available and will be in linux-next. Pull
request with the fix will be sent after rc1.

