Return-Path: <linux-btrfs+bounces-4630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19E8B60D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 19:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DED7B230FF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9B12A16B;
	Mon, 29 Apr 2024 17:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CZXnFIcz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQpSO5tK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CZXnFIcz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQpSO5tK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B01312A160
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413324; cv=none; b=ECgRfD9SvF2u2MYSGHAUq+aGTCYyZWDqnRHqGKBkHCJl8GXZT6ixh8uJcFqfyAeJePALNHlNJAuQyOrhsvX9LHWIU33moaanRH/EYmTNfyGWSk2gZIxmbEWbufgxYqHrJPg4jvf1BI2YQKZwYCiWfXAKFjrV109kLj0w1DTCnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413324; c=relaxed/simple;
	bh=vYcMKcz/gzOW8GmjB2pPpCc5/EuMp9/+AJLwbAyE8us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlmUhLQWx4hsHumFi/u3HWbFa0Frt6ZfRfKgE7dM2ri9Ve+s/7yWmJrQog4/FRtGQxOTwQFm1yICorSc9yB5isnzxMPVgLOMYSTKKv0t6Ylo0ka3sW6C1M9X2W1Vff/qR4AX1K9dkcX51GZf94gTu3SiVL+txfV60D34yEKl0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CZXnFIcz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQpSO5tK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CZXnFIcz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQpSO5tK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21D99218F3;
	Mon, 29 Apr 2024 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714413319;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYcMKcz/gzOW8GmjB2pPpCc5/EuMp9/+AJLwbAyE8us=;
	b=CZXnFIczfN52USSlGA4u+NWgS/iTs11Ah6KKLcqYcKKpkQdaA1RjVN38Z7MeIHwd6+daNh
	QN5X3z1nEPhci2ewMdx+0busgnRNOfgwDrzC2GDERYuPNdURlwEkdR/nR2ZnjHKjFlpqnZ
	Iw8c8DRpZIj7uhywrrdmbiHAlNfQNd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714413319;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYcMKcz/gzOW8GmjB2pPpCc5/EuMp9/+AJLwbAyE8us=;
	b=fQpSO5tKNM9rewZGZjtSyR4tCfsmhT6jvoYTg9oefl4HRLqF9P7sWLHBInXrVFt5l6hpys
	9Pc2xgEsfhP7IeAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CZXnFIcz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fQpSO5tK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714413319;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYcMKcz/gzOW8GmjB2pPpCc5/EuMp9/+AJLwbAyE8us=;
	b=CZXnFIczfN52USSlGA4u+NWgS/iTs11Ah6KKLcqYcKKpkQdaA1RjVN38Z7MeIHwd6+daNh
	QN5X3z1nEPhci2ewMdx+0busgnRNOfgwDrzC2GDERYuPNdURlwEkdR/nR2ZnjHKjFlpqnZ
	Iw8c8DRpZIj7uhywrrdmbiHAlNfQNd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714413319;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vYcMKcz/gzOW8GmjB2pPpCc5/EuMp9/+AJLwbAyE8us=;
	b=fQpSO5tKNM9rewZGZjtSyR4tCfsmhT6jvoYTg9oefl4HRLqF9P7sWLHBInXrVFt5l6hpys
	9Pc2xgEsfhP7IeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05479139DE;
	Mon, 29 Apr 2024 17:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yb4WAQffL2ZyTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 17:55:19 +0000
Date: Mon, 29 Apr 2024 19:48:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: misc-tests: remove the subvol-delete-qgroup
 test case
Message-ID: <20240429174805.GK2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1714082499.git.wqu@suse.com>
 <afcd81cd552fec9c8357342b7895c87b2c02eb24.1714082499.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcd81cd552fec9c8357342b7895c87b2c02eb24.1714082499.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.39)[77.51%];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 21D99218F3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.60


Subject: "btrfs: misc-tests: remove the subvol-delete-qgroup test case"

Please use the subject format "btrfs-progs: tests: ..."

