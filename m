Return-Path: <linux-btrfs+bounces-9952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91C9DB895
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF40164DD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Nov 2024 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601081A9B4E;
	Thu, 28 Nov 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yO7CmMPI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vktvv0hs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eo+zHfkF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IoJkoOKk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB38158527
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Nov 2024 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800442; cv=none; b=EsSqxChcjJJbp3XM1JNz+jhGIO5k4omQ1eEphtDBECbnrgmbhic3IKKwXA0EnT2q4S6fkG1yZl6z63FwKoxMWgAqQctUUT58PcgxIh5D8Ho01Z883r+kRfJAjsN26S1zx3xNNKOFzfR2FLX8ukIoZQQQoUdDWLtQ3cBysP2bxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800442; c=relaxed/simple;
	bh=OezJpeNfh+hwD4meuauGeEtDyOne4kxrX6rMHe7cJFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrpAbqo/vjNHBc5Z9WXt4pPz8JwKpQjpTTrvflqax0JvksIJ3WMfbLOF5eyRtJRNV6w1/2rcjRx+mFtZbjZIv0Wwa9Gjh5cWzSpJCztZP89JwxiNg6DDaOXFVhdoFWEykN6kilBxsf9IvH4GnpdIKnTsUqj9Eu9xn4hHaQFK9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yO7CmMPI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vktvv0hs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eo+zHfkF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IoJkoOKk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C00252117D;
	Thu, 28 Nov 2024 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732800439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+e+4XK4d0QMvc9t4vBQe77VJWRbVau42ZVgIrSDUBs=;
	b=yO7CmMPIBHHuFf31t1zz9tlLRPB6BKIkpq4rRpNc66xgrsT7f+H/MMsCl2ODT9dHQ58PVw
	4ZJcn2fFinhLHw7cZttBhaJ7jIzjfvo9cC3TNKwtenIGuz74NJzFYdvhxwQ2sP1VCYGLay
	UfxODxP4bjErCnQSTnxDO/brgX2cHcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732800439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+e+4XK4d0QMvc9t4vBQe77VJWRbVau42ZVgIrSDUBs=;
	b=Vktvv0hsPji4gvsmo/CGs9Kh+yMk3xI9EkGJGEvPXV3thm33pJKUmKC8VvM8N1FwT+UUDZ
	e6cWnWgFsti/R1Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eo+zHfkF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IoJkoOKk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732800437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+e+4XK4d0QMvc9t4vBQe77VJWRbVau42ZVgIrSDUBs=;
	b=eo+zHfkF/q56ILGQr6wcnLLm8x5bfkQSEnXKRzc1F1j/JtVKiZ4UANrBwPsZrGcZCrGRFg
	qW+A8jAPE3pcTka5XCo6Og+uDzxJ3MaNhiVkMCcslDB0KJaIrZspuUTd66xoAQirD28FCk
	485d9pXnXDCEnGRXphFiA0CIpY4ulpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732800437;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+e+4XK4d0QMvc9t4vBQe77VJWRbVau42ZVgIrSDUBs=;
	b=IoJkoOKkUS8pes6qXjrZKUdJNdFAwv0v8XATeDLNIE8ZN07WOGWqSEIVkC0RBguwfhY/YP
	oH18G94+JF0COfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A35F813690;
	Thu, 28 Nov 2024 13:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4uCuJ7VvSGdmfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 28 Nov 2024 13:27:17 +0000
Date: Thu, 28 Nov 2024 14:27:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: fix documentation build errors
Message-ID: <20241128132712.GT31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1731998908.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731998908.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C00252117D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Nov 19, 2024 at 02:56:14PM +0800, Anand Jain wrote:
> This patchset addresses documentation build issues related to
> link formatting, indentation, and target name handling.
> 
> Anand Jain (3):
>   btrfs-progs: fix doc compile error in CHANGES file
>   btrfs-progs: fix doc build issue caused by confusion between BTRFS_
>     and target
>   btrfs-progs: fix doc build errors correct hyperlink formatting

Added to devel, thanks.

