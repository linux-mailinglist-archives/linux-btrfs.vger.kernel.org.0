Return-Path: <linux-btrfs+bounces-19752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75703CBF6F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E87301F5E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 18:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C2253932;
	Mon, 15 Dec 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="URhxnMWG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lTp8gveL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KCwxaF0d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="926Kk8VD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D437268690
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823328; cv=none; b=tCDK/yA0V6QOfJ3iqhu35+Q045Y9ozyJZM4rF9eWDu1IbXRHBK2iTe/xz9gAiHMAvyce9fp6q5F79sfBvYyASl1B2PWfmFZj9cCwjgTfW9xrLBo+TOeR6YFJuUW79jhnGzYRu2a6TZF4MXHEw6uAAipj95KRy4S2MhJasoVNI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823328; c=relaxed/simple;
	bh=cHkClbS6w2WTvCYEqEdmD61brGsBOK7+EPfhJkbCUM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxoNLzxA5lel213Go4D8dJtPWq4hKKQDuDhw0/l34BtxHfeHU/amBnnHbYz3tlnTNkRRuvQ0F8n/BSCl9zJkSLdZ6JUjatKxN0Gdj7kn+AqlxVCNjlP6BRxD++0pGpflDlh0KxVJEfMSBGvy6vI1xVth8IH70juhHo0YmdOX5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=URhxnMWG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lTp8gveL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KCwxaF0d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=926Kk8VD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 981B65BCC2;
	Mon, 15 Dec 2025 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765823323;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwMR7GcZwjMUt7ny2lTk6nrVG5eRDhzrc8rjkYW3NAY=;
	b=URhxnMWG7h4e6HtZShjVphmnLtnp+vaCTCxHh3fU1ZzdtYWhE7O0Zv8TjdB2qgCO5VAn4z
	hkB8FDQDS7BfNP2il3oXIRQH24E0Tl+5SE9JL8on84odgIluYg/HRkmGM6OSveXfofD7wo
	mZzmfMa9qliHrF+dFBSzK3+avsLfAkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765823323;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwMR7GcZwjMUt7ny2lTk6nrVG5eRDhzrc8rjkYW3NAY=;
	b=lTp8gveLaAaa5yoXoM8ncnGIHETBNtXtrJKfUr00Fo8pgVVQNYF3pShekQE768YfWPk398
	iQq1GuQdHPAdDRDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KCwxaF0d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=926Kk8VD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765823322;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwMR7GcZwjMUt7ny2lTk6nrVG5eRDhzrc8rjkYW3NAY=;
	b=KCwxaF0db0fD3VqXvou2skachfCgy634vMbVcFALrvwNcYtmmLuVck3L42eX+VuRp9Y5eo
	mQCSu10nNmDp4u6sHPOEHDyRDQEVIId4yMh2cJlqPgQAoBYn2WMFb+Lo7q94WFG3uwJJrT
	XBAcVxdhwh99L+PZzLRIlE3QcbgRqtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765823322;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwMR7GcZwjMUt7ny2lTk6nrVG5eRDhzrc8rjkYW3NAY=;
	b=926Kk8VDKn569HJiBw5+3uNObzVbHrWDngwZfYlo8b8BiT9EXtkohKLfXG3qRAAKq1somL
	3kae0ja/iFV8XODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80F713EA63;
	Mon, 15 Dec 2025 18:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TH5JH1pTQGntdwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 18:28:42 +0000
Date: Mon, 15 Dec 2025 19:28:41 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs: add a new test case to verify quick
 qgroup inherit
Message-ID: <20251215182841.GC3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251204044108.181671-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204044108.181671-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 981B65BCC2
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, Dec 04, 2025 at 03:11:08PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that simple quota exposed a bug in the quick
> qgroup inherit, that if there is a multi-level qgroup parent
> relationship, only the direct parent got updated.
> 
> [TEST CASE]
> The test case will create the following subvolume and qgroups first:
> 
> - A new subvolume at '/subv1'
> - Qgroup 1/1
> - Qgroup 2/1
> 
> And subvolume '/subv1' is assgiend to qgroup 1/1, so 1/1 is the direct
> parent.
> Then qgroup 1/1 is also assigned to 2/1, so 2/1 is an indirect parent of
> subvolume '/subv1'.
> 
> Then the trigger part is to creating a snapshot of '/subv1' and also
> assigned the new snapshot into qgroup 1/1 during the snapshot creation.
> 
> Since 1/1 is the parent of '/subv1' and the new snapshot, and qgroup 1/1
> fully owns '/subv1', we can do a quick inherit.
> 
> After the triggering part, just finish the test case and the fsck after
> the test case should detect any qgroup inconsistency.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

