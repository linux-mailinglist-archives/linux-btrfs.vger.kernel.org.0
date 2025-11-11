Return-Path: <linux-btrfs+bounces-18867-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D25C4E9FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE7444F9F97
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9D32E6AD;
	Tue, 11 Nov 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E6gfdDhW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4oMcV6ux";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E6gfdDhW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4oMcV6ux"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45230C605
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872613; cv=none; b=eGwN2AouNiCv0SYjs9Zc21CrNovI0w46wmW1e9nM6H1DHIoyknbJZZLMACwtuJVPkx4MLoVjXRxx9i2bSrJc3kF+YZzJYwIHM+NiVeQNNY0CffMoCJfzSPp/IF4qaD4K8WVgOYLT3Mq8MJFoJFJ2krjIcPE/Bd3g+VRTaNNVkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872613; c=relaxed/simple;
	bh=9SvwPXiB2wbnvmAAMy8U+dxhH1KiGgk6xt+gVvj95cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5I3dnfe/YyWfV77I+RKBbmF1S5RYPB3l+ZlmH6EbbHZZPe8eQrlkxqyo39MSuJp9tbstCKk0UNyICrKf7etLxbnfPTqSYQTR1W4WvXFLkoFXZau+/qkhx4cCNzhrOnC7AN3mqKYg/n2GGkneKc5dsPJz+G2t5HYWQFjfSWvXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E6gfdDhW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4oMcV6ux; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E6gfdDhW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4oMcV6ux; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 942D721C34;
	Tue, 11 Nov 2025 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762872609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=riHFzSfgEO1X5fTnyssNT50GwYHL7wwrsblSTEMwA94=;
	b=E6gfdDhWyC3nBoNtU/BKnNE8eoNMfPlBf958LTwZP+T6DSnBxI7ur4iOnogyft29V4pAan
	EI/uL5eix7HV+11jt6I3IzUtjYGN5f24rG3Mt4AtAh6XDFauHTNr9Dt251oOtEjmhjFV0h
	h6dAzlKP3zrMf0ZUnmjog/ent5+sCWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762872609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=riHFzSfgEO1X5fTnyssNT50GwYHL7wwrsblSTEMwA94=;
	b=4oMcV6uxpCAi6FWUkr0ll50LoUXK8OsYsINE2083CAEulPEjGu2U4RtPEyytSzI9RpVj7l
	nUNXFCiofbTnHICw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762872609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=riHFzSfgEO1X5fTnyssNT50GwYHL7wwrsblSTEMwA94=;
	b=E6gfdDhWyC3nBoNtU/BKnNE8eoNMfPlBf958LTwZP+T6DSnBxI7ur4iOnogyft29V4pAan
	EI/uL5eix7HV+11jt6I3IzUtjYGN5f24rG3Mt4AtAh6XDFauHTNr9Dt251oOtEjmhjFV0h
	h6dAzlKP3zrMf0ZUnmjog/ent5+sCWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762872609;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=riHFzSfgEO1X5fTnyssNT50GwYHL7wwrsblSTEMwA94=;
	b=4oMcV6uxpCAi6FWUkr0ll50LoUXK8OsYsINE2083CAEulPEjGu2U4RtPEyytSzI9RpVj7l
	nUNXFCiofbTnHICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BDAC149ED;
	Tue, 11 Nov 2025 14:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xZsYHiFNE2mIMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Nov 2025 14:50:09 +0000
Date: Tue, 11 Nov 2025 15:50:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Baolin Liu <liubaolin12138@163.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] btrfs: simplify list initialization in
 btrfs_compr_pool_scan()
Message-ID: <20251111145008.GA13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251111120558.28240-1-liubaolin12138@163.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111120558.28240-1-liubaolin12138@163.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Tue, Nov 11, 2025 at 08:05:58PM +0800, Baolin Liu wrote:
> From: Baolin Liu <liubaolin@kylinos.cn>
> 
> In btrfs_compr_pool_scan(),use LIST_HEAD() to declare and initialize
> the 'remove' list_head in one step instead of using INIT_LIST_HEAD()
> separately.
> 
> No functional change.
> 
> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>

Added to for-next, thanks.

