Return-Path: <linux-btrfs+bounces-7569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642996138C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE441F231C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2935A1C9DF7;
	Tue, 27 Aug 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U5b0bDY7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QgrGA6oE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U5b0bDY7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QgrGA6oE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D91BFE00;
	Tue, 27 Aug 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774627; cv=none; b=ZlM6Cy57bvOavjgTWZuOZnm7osR4gH8FT7llPE1wAVuZXgAfkdvyhf4M7LpjUMODAUZh8x8qt/53pzxSP5Qe/Qg48zx4V6v9BoUgPxYt8GW08IOoWi96Plk11J/CMY+zRzzPffvwnolJ0DdWQX2NuBXMaf2Zu465wk9SExeLZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774627; c=relaxed/simple;
	bh=R7ILmJPieSrdKrj9WN95aD2sNlqQE96fQOp/anLClBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzbWXmZalwGz21ESOklQo9Fglyrj9Z5V6bEBI6AGK0vwBeWaMu0Bat0dxDIQoFPkwkpeQz5bhJPQCv4qLxRzfIIminceDryzbytbLK3MCGOlHiEzoWtUGUFcGuVDAYmxRq5cBa7PhizNclgbdBHX0Yadw55sm3qIfMgkfjaHMl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U5b0bDY7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QgrGA6oE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U5b0bDY7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QgrGA6oE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7DF21A6E;
	Tue, 27 Aug 2024 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724774623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7ILmJPieSrdKrj9WN95aD2sNlqQE96fQOp/anLClBA=;
	b=U5b0bDY72u7IAAc0Fx488byf/0TfBjPsObV2tt+mf1LLDuGldDH53zMoayQWMi6wB6SkKq
	pdKNItUnNZypZ1+4Tz90o6J5OmRTqt/5M41uytoHtNMpEUjl9GxXcsHkvZSZ1bexKwMm6H
	u6xprYLCn644H7WzMZWZif1gUlQRT0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724774623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7ILmJPieSrdKrj9WN95aD2sNlqQE96fQOp/anLClBA=;
	b=QgrGA6oErQTC3pZ+4Pp0JLH9C4N3F5IglUDvrw1zH8qJOxaW4Ujswrh97t4u9SgvQKCeIH
	gbsyNX9nlahM5dAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U5b0bDY7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QgrGA6oE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724774623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7ILmJPieSrdKrj9WN95aD2sNlqQE96fQOp/anLClBA=;
	b=U5b0bDY72u7IAAc0Fx488byf/0TfBjPsObV2tt+mf1LLDuGldDH53zMoayQWMi6wB6SkKq
	pdKNItUnNZypZ1+4Tz90o6J5OmRTqt/5M41uytoHtNMpEUjl9GxXcsHkvZSZ1bexKwMm6H
	u6xprYLCn644H7WzMZWZif1gUlQRT0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724774623;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7ILmJPieSrdKrj9WN95aD2sNlqQE96fQOp/anLClBA=;
	b=QgrGA6oErQTC3pZ+4Pp0JLH9C4N3F5IglUDvrw1zH8qJOxaW4Ujswrh97t4u9SgvQKCeIH
	gbsyNX9nlahM5dAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5638813A44;
	Tue, 27 Aug 2024 16:03:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i9bTFN/4zWbQMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 Aug 2024 16:03:43 +0000
Date: Tue, 27 Aug 2024 18:03:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: add missing extent changeset release
Message-ID: <20240827160341.GZ25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240827151243.63493-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827151243.63493-1-pchelkin@ispras.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7B7DF21A6E
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[81670362c283f3dd889c];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Tue, Aug 27, 2024 at 06:12:43PM +0300, Fedor Pchelkin wrote:
> The extent changeset may have some additional memory dynamically allocated
> for ulist in result of clear_record_extent_bits() execution.

This can happen, as clear_record_extent_bits adds more data to the
changeset in some cases. What I don't see yet how it happens. An extent
range must be split so that a new entry is added with different bits
set. This is usual thing, but why does this happen with the quotas
disabled.

