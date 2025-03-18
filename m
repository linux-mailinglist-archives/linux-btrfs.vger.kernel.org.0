Return-Path: <linux-btrfs+bounces-12388-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC49A6797B
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7684C7A37AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4471A2567;
	Tue, 18 Mar 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="joI0xoag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="42+5Y3vD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="joI0xoag";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="42+5Y3vD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CD212FA6
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315411; cv=none; b=NdjaZsEd3f47g7VPg8AphRgQ2NjMuG3MXyCEAFIlhrXKNZsQAhrLdaN/bUz15Oy9c367aCRyC11JGDgSJQ+nV6RbRxePBBDA0+/WnVVDUj0TemCg2fn4vRVCbY2T6EY9eAQ1SGktMl/V6pmP5375UwaMMiBoW8F+oMIoNUUSZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315411; c=relaxed/simple;
	bh=+1Nf0GT6JEqLifTXMsVHvKeq47tnTEvNkUENcggFQ9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFkqhDwhrT1f8aQWnI+9k4add7B1QfaJm8BOPcbROqjkB+aunFX9iYXZA/5WiIXkztcDzw9u+tgJ2wKK2J7dxytQQPbYEBD9Csop3x9a2DOyX8kEdGKr+d5eCMrXfrPeJDmO7kdshDh0yUnolzkN1cdPBtRVFhv1lwKj5pkNfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=joI0xoag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=42+5Y3vD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=joI0xoag; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=42+5Y3vD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1107E1F78B;
	Tue, 18 Mar 2025 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742315403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t03onKQ3OJ4XO9LvgDVJvRkSqo2BceY9fiVzb2AWBDc=;
	b=joI0xoaglKSjh+gs/TkPG/mfCQRzSuXsBG269qJAR2e1vYkGyt6rX0Ihdu4yfB1Mok1xmS
	9cHRzMMTWjQNteSZRIFliUdHgO+0BxTUwpkjjea+DETQv+KhTUpbEio0T9/fdjXgOPUwzU
	X4ozQr6/kUikcq9B7wb5mxK530L6F4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742315403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t03onKQ3OJ4XO9LvgDVJvRkSqo2BceY9fiVzb2AWBDc=;
	b=42+5Y3vDCLKNB4gG/r6zcWOAUT9A+l+H8p+0VT+J6DAjZlb6rP4yKfP17K3JWKgIT8ZmYH
	UWnfsWlXlT795NAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=joI0xoag;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=42+5Y3vD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742315403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t03onKQ3OJ4XO9LvgDVJvRkSqo2BceY9fiVzb2AWBDc=;
	b=joI0xoaglKSjh+gs/TkPG/mfCQRzSuXsBG269qJAR2e1vYkGyt6rX0Ihdu4yfB1Mok1xmS
	9cHRzMMTWjQNteSZRIFliUdHgO+0BxTUwpkjjea+DETQv+KhTUpbEio0T9/fdjXgOPUwzU
	X4ozQr6/kUikcq9B7wb5mxK530L6F4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742315403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t03onKQ3OJ4XO9LvgDVJvRkSqo2BceY9fiVzb2AWBDc=;
	b=42+5Y3vDCLKNB4gG/r6zcWOAUT9A+l+H8p+0VT+J6DAjZlb6rP4yKfP17K3JWKgIT8ZmYH
	UWnfsWlXlT795NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E87111379A;
	Tue, 18 Mar 2025 16:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id REhqOIqf2WdoNwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Mar 2025 16:30:02 +0000
Date: Tue, 18 Mar 2025 17:30:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move block perfect compression out of
 experimental features
Message-ID: <20250318163001.GH32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <d79b3627f9b2aed116c930bad3048da3aabcb2bd.1742028548.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d79b3627f9b2aed116c930bad3048da3aabcb2bd.1742028548.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1107E1F78B
X-Spam-Score: -4.21
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, Mar 15, 2025 at 07:19:26PM +1030, Qu Wenruo wrote:
> Commit 1d2fbb7f1f9e ("btrfs: allow compression even if the range is not
> page aligned") introduced the block perfect compression for block size <
> page size cases.
> 
> Before that commit, if the fs block size is smaller than page size (aka
> subpage cases), compressed write is only enabled if the dirty range is
> fully page aligned.
> 
> This block perfect compression support is introduced in v6.13, and has
> been tested for two kernel releases.
> I believe it's time to move it out of experimental features so that we
> can get more tests in the real world.

I think this is ok, the subpage is not that common and the compression
is a basic feature that we need to get tested more thoroughly anyway.

Reviewed-by: David Sterba <dsterba@suse.com>

