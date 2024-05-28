Return-Path: <linux-btrfs+bounces-5328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC018D26E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 23:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E52288F08
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 21:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9FC17B430;
	Tue, 28 May 2024 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="raDEaXUh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4G5geOP2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="raDEaXUh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4G5geOP2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1416F90E
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930648; cv=none; b=HeX/6F4a9RTfbe/cuTeKqbJdtc73TbvV2bdycZZPcb6qunf3eL8Fxn6cdVRIAgdw6Nux3SmmdUHbXg2xIe/kG0GE+vWYSJHooToHwidJjTriIotDCr5AeCXKALGKf8Qhl0Pjpde1Ft6AZLn0qj6uSKp/gXP66r4HKhjMpZHCNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930648; c=relaxed/simple;
	bh=90Ypq3A8ZdZnnhHTNXe1AThgI70jcuRRsw52NXbo3LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooGFYE9TZPpIWA8lzNsf2H1mBhNBVyfKBZgXSW1XKY+mZxMFATxjK4kOnAZ2bkkrwYY8NQLRwj4YOsVCwNaTPnzlwCQrLUdgm/PCPugxfC1UaRv9gCJiujKgmkKgiTl2OtHqZyem02LXbXQhqYUmfZm+pf2NRf8SzDMv1WqAIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=raDEaXUh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4G5geOP2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=raDEaXUh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4G5geOP2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 94F4F2044D;
	Tue, 28 May 2024 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716930644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sArI3yP20SaSuDDKDmXUD+PTc1jtcKDGW+JzyeMIif8=;
	b=raDEaXUhcfRkdO+SbuQlZVSGS4nj2Ms20wtPI2iT92jwcrFSoajFTvbua9z4hnR6IeExq+
	EXGFttn66qpI19OluAtfzstDquid/oBqaW8wSWdz38X8KYw+g6ZtqG0BN4icUiZS64nHAA
	QIOQIT4vdwxZWTZcgF57CgCUsQHYgRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716930644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sArI3yP20SaSuDDKDmXUD+PTc1jtcKDGW+JzyeMIif8=;
	b=4G5geOP2XJ0XLHLx0+x7N8jSpVi2M2Zmwu6HKkldMh43TDzv3tvXuTNn78H7Cpml8rwOUq
	t4GeYegLxxAWOFBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=raDEaXUh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4G5geOP2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716930644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sArI3yP20SaSuDDKDmXUD+PTc1jtcKDGW+JzyeMIif8=;
	b=raDEaXUhcfRkdO+SbuQlZVSGS4nj2Ms20wtPI2iT92jwcrFSoajFTvbua9z4hnR6IeExq+
	EXGFttn66qpI19OluAtfzstDquid/oBqaW8wSWdz38X8KYw+g6ZtqG0BN4icUiZS64nHAA
	QIOQIT4vdwxZWTZcgF57CgCUsQHYgRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716930644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sArI3yP20SaSuDDKDmXUD+PTc1jtcKDGW+JzyeMIif8=;
	b=4G5geOP2XJ0XLHLx0+x7N8jSpVi2M2Zmwu6HKkldMh43TDzv3tvXuTNn78H7Cpml8rwOUq
	t4GeYegLxxAWOFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CE4D13A6B;
	Tue, 28 May 2024 21:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rRhLHlRIVmazMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 28 May 2024 21:10:44 +0000
Date: Tue, 28 May 2024 23:10:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: cleanup recursive include of the same header
Message-ID: <20240528211039.GG8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1716874214.git.wqu@suse.com>
 <ee22eaba04729cf6452ed1223c5187e617cfa4c1.1716874214.git.wqu@suse.com>
 <CAL3q7H6eviZPj0abhL_x+R=7Do23-JbOwJYpzpESacBpf4Z4NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6eviZPj0abhL_x+R=7Do23-JbOwJYpzpESacBpf4Z4NQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 94F4F2044D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Tue, May 28, 2024 at 11:20:25AM +0100, Filipe Manana wrote:
> On Tue, May 28, 2024 at 6:34 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> > We have several headers that are including themselves, triggering clangd
> > warnings.
> >
> > Just remove such unnecessary include.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Maybe add a
> 
> Fixes: 602035d7fecf ("btrfs: add forward declarations and headers, part 2")

Adding Fixes: to tags could trigger the stable workflow and the patches
could be picked for backport although it's not necessary. Mentioning the
patch that introduced the problme in changelog text should be sufficient
in such cases.

