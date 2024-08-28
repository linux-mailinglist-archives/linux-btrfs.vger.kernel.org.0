Return-Path: <linux-btrfs+bounces-7652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952F96342B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 23:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0161C237B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 21:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D91AD9D0;
	Wed, 28 Aug 2024 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="snovRBA0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9hrlAQbg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHwXQfoz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WvONVaoy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8321A4F33;
	Wed, 28 Aug 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724882198; cv=none; b=W8ztsKvr0aMfyClKdCjUEKshYLkVk0PsKyuaXvDRnauX8c5Wjpilc0Dm0I8sg/zzH55/pT/ZK8NsgCd3Cl9mepbENsc8stsDRn9GIUteVlp8IPiwYmZR4gI3pdn85J9ltUTvFk6T5F0+nN2A2wiM1IWQYgCio0htcOPw3yTY++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724882198; c=relaxed/simple;
	bh=JkexkIuMDd301M8amuwfTGnVa+Or+je1SVqJwgdPP7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9x1/2B9gc+t4zmFOeiwXp4UFmVikMaGzi9WPydy7rzLcnX5Zi2SLlFsHjGLMtSqWEXQ5zvfEPZ4nomJyq3RV8AgcQm9bgUfYs5PO8w+gMiCsdEo7whzaatYxKZxz/MvHzEbUXPFkFYu1lPt3sCmElJbP8Ob1QCvRj9RU26OdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=snovRBA0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9hrlAQbg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHwXQfoz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WvONVaoy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F9AB1FC0A;
	Wed, 28 Aug 2024 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724882194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZfya40WWjepWCyZQxYboFgmxDl/M9pWV9p14+Dr01g=;
	b=snovRBA0IJZkRGpQ0bMr6HQdTCqVmmQBPP8z0xLv7wIA6J59taWmO/FI1oEp7sdSoYFCv3
	xzJ6ruzVo2d83KQXkMXjbZWqvgPGV6v4QV2GnXCV/P43IanSb22rU1ENP+Pm1QEgzQnPQa
	zaKwtfu/BR6lghIrpj29s+K/bIhOkMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724882194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZfya40WWjepWCyZQxYboFgmxDl/M9pWV9p14+Dr01g=;
	b=9hrlAQbgSCTvFD5eRFj2inBCO7/cs+L1f5rF6zuH57Er/gYSL3TveCLx0zXth1orJsJfP6
	EoFRH6k74MhMzrBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724882193;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZfya40WWjepWCyZQxYboFgmxDl/M9pWV9p14+Dr01g=;
	b=uHwXQfozmdRx8x0CW+X6+AfnLkCL7dCpGSDdfSrbjRXOH0iXm169p6/F3nHmBB36Xb6F3O
	pCm835/u0b7ikQzIBk28nNaGtiSnUfvw870x9q/gzxyaQMPdvEpz4Q6Dbch5vqY1ryHA7X
	wI2IoeioH+BCfO2EP+YO+qeCBAwnjPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724882193;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZfya40WWjepWCyZQxYboFgmxDl/M9pWV9p14+Dr01g=;
	b=WvONVaoyl5oCmyF6RVzMfcKTmv9yEFffijJUW2NgQYFTsMO1gkz9Dh2wFkF4f8ZI59IZkz
	yHNJgSzeK3KIb2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B3B7138D2;
	Wed, 28 Aug 2024 21:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fVDxGRGdz2a+PgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 Aug 2024 21:56:33 +0000
Date: Wed, 28 Aug 2024 23:56:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: qgroup: don't use extent changeset when not
 needed
Message-ID: <20240828215632.GJ25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8d26b493-6bc4-488c-b0a7-f2d129d94089@gmx.com>
 <20240828161411.534042-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828161411.534042-1-pchelkin@ispras.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[81670362c283f3dd889c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,fb.com,toxicpanda.com,bur.io,vger.kernel.org,linuxtesting.org,syzkaller.appspotmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,linuxtesting.org:url,appspotmail.com:email,ispras.ru:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Wed, Aug 28, 2024 at 07:14:11PM +0300, Fedor Pchelkin wrote:
> The local extent changeset is passed to clear_record_extent_bits() where
> it may have some additional memory dynamically allocated for ulist. When
> qgroup is disabled, the memory is leaked because in this case the
> changeset is not released upon __btrfs_qgroup_release_data() return.
> 
> Since the recorded contents of the changeset are not used thereafter, just
> don't pass it.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000aa8c0c060ade165e@google.com
> Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota disable")
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v2: rework the fix as Qu Wenruo suggested - just don't pass unneeded
>     changeset. Update the commit title and description accordingly.

Thanks, added to for-next.

