Return-Path: <linux-btrfs+bounces-19576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD2CAE0E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 08 Dec 2025 20:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3DA663011B1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Dec 2025 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CFB2BDC2F;
	Mon,  8 Dec 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZVScAp1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3IYbZWH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VZVScAp1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3IYbZWH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63783B8D63
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Dec 2025 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765221548; cv=none; b=Cy4UQtV+bPSo+IA3J5QNl+NOiADj/QZzALh2I76Pr25UfeyG+yZG2QaYW726gy7A04SCCj/2DrdAaVPsJ1BK3KDQoqfLQmNKV5SMLtAqkZqLsYm53OqE1ebwt8K7NYNN+G+oHzuTj3WYjLaSjcQ2SQZZk2kodOffwuKlejQWB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765221548; c=relaxed/simple;
	bh=BweXvM/YSYGaDhW7A3NJIVblpwEBZPgYK3E5LKvDf/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3v2WZqmfqBTAAajxb5FyPi0WH6cB7tUMr8vik2htJo92CVy/3/VD1QCrn54iX5WT70K6Xb9NUC3UQqcSa9DC/UtMLj3Kx3hDEsxaicKokQUAvvhDzL25Fm4cZDVXlrLyHlSxSSUZeSWSVmhUZz0rDRyKpuAxXGRwEjDaEkyXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZVScAp1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3IYbZWH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VZVScAp1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3IYbZWH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A17AD5BD4B;
	Mon,  8 Dec 2025 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765221544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lShL5nExWqVZ5YVw0oIH1BlVYXjKyGf+608WdnYT2kw=;
	b=VZVScAp18eMrfZjF8M//aUdMe60lWER8U0RYsc0UBlIkMhkrLRIqdvia/wQPlDMpbB63lc
	expRkAVHl1h4nUnj0eh97dWoIeAhc9oATPHni64XmbSFtaseFSLrJB9IgoOdXRx6gNkqD+
	lTkskNesrhmTSpRqhk74Jz8pFqaXJCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765221544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lShL5nExWqVZ5YVw0oIH1BlVYXjKyGf+608WdnYT2kw=;
	b=g3IYbZWHVgh8TmrPz+T9WzuIAJygFamDFAWvFU4AKkbaFIVZI7KG05J5GKpybvxNcac6Og
	M7N/flV3yNTobmDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765221544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lShL5nExWqVZ5YVw0oIH1BlVYXjKyGf+608WdnYT2kw=;
	b=VZVScAp18eMrfZjF8M//aUdMe60lWER8U0RYsc0UBlIkMhkrLRIqdvia/wQPlDMpbB63lc
	expRkAVHl1h4nUnj0eh97dWoIeAhc9oATPHni64XmbSFtaseFSLrJB9IgoOdXRx6gNkqD+
	lTkskNesrhmTSpRqhk74Jz8pFqaXJCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765221544;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lShL5nExWqVZ5YVw0oIH1BlVYXjKyGf+608WdnYT2kw=;
	b=g3IYbZWHVgh8TmrPz+T9WzuIAJygFamDFAWvFU4AKkbaFIVZI7KG05J5GKpybvxNcac6Og
	M7N/flV3yNTobmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89F2A3EA63;
	Mon,  8 Dec 2025 19:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id utNyIagkN2ljQwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Dec 2025 19:19:04 +0000
Date: Mon, 8 Dec 2025 20:19:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: shrink the size of btrfs_bio
Message-ID: <20251208191903.GA4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ef5de8f907f74520338f0ce46f36f1335dc6e2f.1764921800.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.92 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.12)[-0.606];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.92

On Fri, Dec 05, 2025 at 06:34:30PM +1030, Qu Wenruo wrote:
> This is done by:
> 
> - Shrink the size of btrfs_bio::mirror_num
>   From 32 bits unsigned int to 8 bits u8.

What is the explanation for this? IIRC the mirror num on raid56 refers
to the device index, the type width should not be too narrow. But if
the semantics are different we can reduce the mirror num in other
structures as well.

