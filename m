Return-Path: <linux-btrfs+bounces-21306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMvgKVWagWl/HAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21306-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 07:48:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C92D5745
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 07:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33F72309F1F7
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 06:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99E3783DB;
	Tue,  3 Feb 2026 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4ruEBQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Vluw/bT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4ruEBQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Vluw/bT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4654C7405A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100550; cv=none; b=KTw/X/0FsptDN8OF5Tj6RiQ7IBxHxF3KIPFaUn/EhoKO5mYYZIhiK1B/r96Zl8wrw1q+KUrog7t9ux54TiEuXWUe1408zNjvmMk3yArj+wz+Fqjm39Ta62VKl2Q+m13fYauSh1NEUnesOi6nY+mOckkrxjbKuNPJ3RXMoMDhAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100550; c=relaxed/simple;
	bh=edbTELprYH909xK/CoB6nTa1bntegyJu/uViBZY8ips=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/W7PR3ZtbOMMRB5qn3w5xPufzyhcXcglJCqcNUlkLJ8rQ/Jhn/ve1vUVYXvYRpbCeqnOk151ZkpzT8cn4X7wcLs7AzGaU6XAqazZ179JaYzKp2iblGk8iJzcyXaH/PpPACbWrR0BGYYr+hnicQdKGFnIkqZsOjFlvY4OEcl1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4ruEBQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Vluw/bT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4ruEBQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Vluw/bT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CB285BCC6;
	Tue,  3 Feb 2026 06:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770100547;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glKGbIsM5iB9fdBLzxD6TY8MKDh+dKIgFSrgMvXsFy0=;
	b=h4ruEBQHeXuGbFs4fRx6ynfPNcxtw362wSqOJV053m5+kMeBZPwUgZ/PPsIejX1/+v45Fe
	z6DlNtJJzyJpt0M5FvzqdPUknORQa+/tD8scbn5+FinJ8etJuxiCms9HUu/AJRWGDpz4v/
	07g8x0E2Xn6DdtSLyfFovfpHBB+tyQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770100547;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glKGbIsM5iB9fdBLzxD6TY8MKDh+dKIgFSrgMvXsFy0=;
	b=4Vluw/bTmTu3a1dOKLh61RhaIpHeBHr0Iu70ceP9xoXOc6eZWUqBtTdSvYgm+ffSMEzJkh
	8ouuoGiapA3NtiBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h4ruEBQH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4Vluw/bT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770100547;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glKGbIsM5iB9fdBLzxD6TY8MKDh+dKIgFSrgMvXsFy0=;
	b=h4ruEBQHeXuGbFs4fRx6ynfPNcxtw362wSqOJV053m5+kMeBZPwUgZ/PPsIejX1/+v45Fe
	z6DlNtJJzyJpt0M5FvzqdPUknORQa+/tD8scbn5+FinJ8etJuxiCms9HUu/AJRWGDpz4v/
	07g8x0E2Xn6DdtSLyfFovfpHBB+tyQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770100547;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=glKGbIsM5iB9fdBLzxD6TY8MKDh+dKIgFSrgMvXsFy0=;
	b=4Vluw/bTmTu3a1dOKLh61RhaIpHeBHr0Iu70ceP9xoXOc6eZWUqBtTdSvYgm+ffSMEzJkh
	8ouuoGiapA3NtiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24CE13EA62;
	Tue,  3 Feb 2026 06:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wJ3JB0OXgWkqUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Feb 2026 06:35:47 +0000
Date: Tue, 3 Feb 2026 07:35:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 0/9] btrfs: used compressed_bio structure for read and
 write
Message-ID: <20260203063545.GL26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1769656714.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769656714.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21306-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3C92D5745
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 01:53:37PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v5:
> - Implement an internal compress_bio_last_folio()
>   Upstream is removing bio_last_bvec_all(), and the recent stable page
>   bouncing for direct IO is going to make that function no longer
>   reliable.
> 
>   Thus we need to implement it locally, with some extra ASSERT()s to
>   make sure the compressed bio have all folio sizes fixed to
>   min_folio_size, so that we can use offset_in_folio(folio, bi_size) to
>   calculate the last position.
> 
> - Fix several spelling errors
>   jut -> just in patch 5 and chaning -> changing in patch 7.

I've moved the series to for-next, with some fixups here and there. The
tests for all three compression algorithms and we're short on time
before the 6.20/7.0 pull so any fixups please send as separate ptches.
Thanks.

