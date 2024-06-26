Return-Path: <linux-btrfs+bounces-5996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA8919A1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 23:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F9A1F22ADD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89898193098;
	Wed, 26 Jun 2024 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XZTd/yHM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQD9gNhP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XZTd/yHM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQD9gNhP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83624190697
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438698; cv=none; b=R8NfSGZp4Xufq+J8mvj2bV5+cl6hsIgUZ0o4ujYF2v8LysoqTqSna6uzJ1biA2txXCthblFL9BaHIXjx3hDX8O3f2ohHQhc3Nzz4UbY38s8rrQUTwns364RTH5Lt/gcrD2Zbefr1QIGyPi7Lr+tq/HKHEztr90hc9EFDE0eup74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438698; c=relaxed/simple;
	bh=q0kYPcCNHdEfrcizJL672Lkx/epcDTqMVVBdf4aGjkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyrlJT8XNCVYnxRZyu8BypSOzi8Y+GUbjbYJY0rCt15frKtdOasPQuNVcohg/lzeGDirmLlNxpy7Xo6gKJ2yDXG5O3+5Hc9kh+LOMzzVxWsuWob/TUC8AzArWifEQamsJhbDKAmRvmcN/bVQmTmKcp6Nz+400mZvY/R4quFTqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XZTd/yHM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQD9gNhP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XZTd/yHM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQD9gNhP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E2551FB70;
	Wed, 26 Jun 2024 21:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719438694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0kYPcCNHdEfrcizJL672Lkx/epcDTqMVVBdf4aGjkk=;
	b=XZTd/yHML2ZgaPq/EC0P4iG86Iia7jAYModR1kqMOt9iIA1Xen71QYq882367eJQ7c9by8
	U2LcCVmYBrU9hN8W4sAm4XgoxoLaLUxZrQt6VM7AxYNPTIARtWN0+GPonPngwEcOq/7ftu
	GkmaWtXQwZ0bgiVG0yMe1TO7zscN/oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719438694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0kYPcCNHdEfrcizJL672Lkx/epcDTqMVVBdf4aGjkk=;
	b=BQD9gNhPBWbtErQCb57k2qRVrIp6e0sxj7oI1YaiDxUOKNn+hVeTuUjleygIfPk4PkPpfm
	3VwZX/fUJt7+aeAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="XZTd/yHM";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BQD9gNhP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719438694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0kYPcCNHdEfrcizJL672Lkx/epcDTqMVVBdf4aGjkk=;
	b=XZTd/yHML2ZgaPq/EC0P4iG86Iia7jAYModR1kqMOt9iIA1Xen71QYq882367eJQ7c9by8
	U2LcCVmYBrU9hN8W4sAm4XgoxoLaLUxZrQt6VM7AxYNPTIARtWN0+GPonPngwEcOq/7ftu
	GkmaWtXQwZ0bgiVG0yMe1TO7zscN/oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719438694;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0kYPcCNHdEfrcizJL672Lkx/epcDTqMVVBdf4aGjkk=;
	b=BQD9gNhPBWbtErQCb57k2qRVrIp6e0sxj7oI1YaiDxUOKNn+hVeTuUjleygIfPk4PkPpfm
	3VwZX/fUJt7+aeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3726F13AAD;
	Wed, 26 Jun 2024 21:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bSPyDGaNfGbTWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 26 Jun 2024 21:51:34 +0000
Date: Wed, 26 Jun 2024 23:51:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Fix typo in error message
Message-ID: <20240626215132.GC25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240620150503.2330637-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620150503.2330637-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4E2551FB70
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Jun 20, 2024 at 04:04:51PM +0100, Mark Harmstone wrote:
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>

Thanks, I've added the patch to for-next with fixups suggested by
Filipe.

