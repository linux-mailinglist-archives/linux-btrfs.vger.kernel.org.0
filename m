Return-Path: <linux-btrfs+bounces-19591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1769FCAED0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 04:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49426302379A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 03:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455FB2EC092;
	Tue,  9 Dec 2025 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGLBtrSn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="awdG7ukz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGLBtrSn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="awdG7ukz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3752765DF
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251138; cv=none; b=RiNLflMaMY8av5Vh/eyw2YUcTkwVnLoSgAutCSVVGLiNPbiGlxYcKVo6Pt4dVUDWhpglB++9oefSLbMWDLQ9qvx0HHmL1ilXMjGRjmoFWml4je4ivjmtvyLg8rqUEyCWk2+P7YXgCPohDG2R+tccn9n/+lZgFDm+zEo1qMXzeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251138; c=relaxed/simple;
	bh=iKbUOvozTUcDjWGdk0gFrhHRUlevzyfHRqWi1OObHPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWY9TRuDIUF18sVtkKM4fKDZSOdiL7l0JZtbLS/VPRrKBbrLdBaHJ1q8AQdDkfqz8DSiQ6K4FtmjpNxzuvtnP0eseVdrm110LECMcIkAlRIRgQhTENiNwDIv358rqk5ISa/d5x4Te+n3sYOh6SVRwEqscDgQzHIarxY/4Xe8b/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGLBtrSn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=awdG7ukz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGLBtrSn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=awdG7ukz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 932255BD8E;
	Tue,  9 Dec 2025 03:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765251134;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dK5KHqJHuxC0Vq5OqfttGAUtjiXF9FshssrZSe7Fcxg=;
	b=VGLBtrSnPe8iGZ26utWGY6liH0g1BUcjJjgoQMAuFWtfLILPc37EbKfrR6tZwtw+4xfRTl
	Ialui0y2c5pbz6+D73lH9Jltrb9zGiZ/8Nndk8Ka/C7Hz7wZk1zJQuApu/blVa5iJSeiZi
	6j81H9n0f6nP6jNR/3I8QGoq4cNVWC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765251134;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dK5KHqJHuxC0Vq5OqfttGAUtjiXF9FshssrZSe7Fcxg=;
	b=awdG7ukzLJVArLakQLMyksZCPpJAg5z9C6iAP3Q6yywR9OfduKgSIrYDNIJ0PH7SmnyhaQ
	pdNiTrOJE6iRycAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765251134;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dK5KHqJHuxC0Vq5OqfttGAUtjiXF9FshssrZSe7Fcxg=;
	b=VGLBtrSnPe8iGZ26utWGY6liH0g1BUcjJjgoQMAuFWtfLILPc37EbKfrR6tZwtw+4xfRTl
	Ialui0y2c5pbz6+D73lH9Jltrb9zGiZ/8Nndk8Ka/C7Hz7wZk1zJQuApu/blVa5iJSeiZi
	6j81H9n0f6nP6jNR/3I8QGoq4cNVWC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765251134;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dK5KHqJHuxC0Vq5OqfttGAUtjiXF9FshssrZSe7Fcxg=;
	b=awdG7ukzLJVArLakQLMyksZCPpJAg5z9C6iAP3Q6yywR9OfduKgSIrYDNIJ0PH7SmnyhaQ
	pdNiTrOJE6iRycAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 737013EA63;
	Tue,  9 Dec 2025 03:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B5OtGz6YN2kqegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Dec 2025 03:32:14 +0000
Date: Tue, 9 Dec 2025 04:32:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>
Cc: linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix NULL dereference on root when tracing inode
 eviction
Message-ID: <20251209033213.GF4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251021091125.259500-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021091125.259500-1-mssola@mssola.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[d991fea1b4b23b1f6bf8];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Tue, Oct 21, 2025 at 11:11:25AM +0200, Miquel Sabaté Solà wrote:
> When evicting an inode the first thing we do is to setup tracing for it,
> which implies fetching the root's id. But in btrfs_evict_inode() the
> root might be NULL, as implied in the next check that we do in
> btrfs_evict_inode().
> 
> Hence, we either should set the ->root_objectid to 0 in case the root is
> NULL, or we move tracing setup after checking that the root is not
> NULL. Setting the rootid to 0 at least gives us the possibility to trace
> this call even in the case when the root is NULL, so that's the solution
> taken here.
> 
> Fixes: 1abe9b8a138c ("Btrfs: add initial tracepoint support for btrfs")
> Reported-by: syzbot+d991fea1b4b23b1f6bf8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d991fea1b4b23b1f6bf8
> Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>

Added to for-next, thanks.

