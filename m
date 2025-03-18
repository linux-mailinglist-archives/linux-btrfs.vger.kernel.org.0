Return-Path: <linux-btrfs+bounces-12383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC73A6783A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96852423F21
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0D20FA98;
	Tue, 18 Mar 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2erpn03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aD+k5uso";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2erpn03";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aD+k5uso"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3E20E709
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312761; cv=none; b=o2sigdZf8YGKqlTM7+NySXSVCVg82QsT8WvxtS7dG6tpMB1K2c/h25Yb4KvmZnjX4CEjVRmTrWQFZcE0K5ccf5QkZ6Hqi9N/D4NeK2P9L63apngZOiXYp2a1p2I5eIBWIpRR/J8jagNTguJYMSoWAhWkZi+xcCYAE9fZ8ZQdAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312761; c=relaxed/simple;
	bh=5F4ABLoAYJ7GDp5Q7yv2d6UrCUrlDm/5VuzurFmJqpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8rBjhpbpAROZ4aRFITwQtT9eF0TaaQf/jWupsTjHeWh8kApymreq6rm/p/elrCEZf8fgU/ULAVQzPcNeJ7glgMqlOKvHNd0gYITJG3DKWrRdmb+N8MXqh3vQBbQ0kPT5cyRg8D8C3juqcAKxyRtm/rln1bMf+8I/gLc3ZluJTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2erpn03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aD+k5uso; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2erpn03; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aD+k5uso; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D9DA211FB;
	Tue, 18 Mar 2025 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742312754;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F4ABLoAYJ7GDp5Q7yv2d6UrCUrlDm/5VuzurFmJqpE=;
	b=Y2erpn03MlPeTTroNuwhE1I11r4RJi46Us8tbmiA/nM+kzcFWrfEvgPSeAEgCN0vT8zt/u
	ENDdRL8vJZh4WTyXQag4IPtgxReWTBdwpeofydRbRiL+ORw2fQ1Q76/v04M5p2xDlrWuQJ
	UKHHKTunYvIZKACFhdpRjTcZHqsQias=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742312754;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F4ABLoAYJ7GDp5Q7yv2d6UrCUrlDm/5VuzurFmJqpE=;
	b=aD+k5uso0ly6SZN8sJonr+YWrTqTVamhLvdK2IHd6I74NYj1EFdkUvZOra7lBSEJ/uhVG6
	PuCvG5eI5rkpfHAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742312754;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F4ABLoAYJ7GDp5Q7yv2d6UrCUrlDm/5VuzurFmJqpE=;
	b=Y2erpn03MlPeTTroNuwhE1I11r4RJi46Us8tbmiA/nM+kzcFWrfEvgPSeAEgCN0vT8zt/u
	ENDdRL8vJZh4WTyXQag4IPtgxReWTBdwpeofydRbRiL+ORw2fQ1Q76/v04M5p2xDlrWuQJ
	UKHHKTunYvIZKACFhdpRjTcZHqsQias=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742312754;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5F4ABLoAYJ7GDp5Q7yv2d6UrCUrlDm/5VuzurFmJqpE=;
	b=aD+k5uso0ly6SZN8sJonr+YWrTqTVamhLvdK2IHd6I74NYj1EFdkUvZOra7lBSEJ/uhVG6
	PuCvG5eI5rkpfHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA5B139D2;
	Tue, 18 Mar 2025 15:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BnIJOTGV2Wd+KAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Mar 2025 15:45:53 +0000
Date: Tue, 18 Mar 2025 16:45:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
Message-ID: <20250318154552.GE32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250318095440.436685-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318095440.436685-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> This flag is set after inserting the eb to the buffer tree and cleared on
> it's removal. But it does not bring any added value. Just kill it for good.

Would be good to add the reference to commit that added the bit,
34b41acec1ccc0 ("Btrfs: use a bit to track if we're in the radix tree")
and wanted to make use of it, faa2dbf004e89e ("Btrfs: add sanity tests
for new qgroup accounting code"). And both are 10+ years old.

> Signed-off-by: Daniel Vacek <neelx@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

