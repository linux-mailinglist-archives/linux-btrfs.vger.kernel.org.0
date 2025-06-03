Return-Path: <linux-btrfs+bounces-14429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF30ACCE4C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 22:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6577716DD77
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C71F1534;
	Tue,  3 Jun 2025 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLwCOPUs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgkMqC9E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLwCOPUs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VgkMqC9E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442617C224
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983105; cv=none; b=u5BcWenLjijlugG6UabjP6SIwRprHbkElPJ/yW1K0sCD4/qZR3hGXJJ/jbmTkBPhjdOgzeLSNbdTInUqFjhqx9kSjMRtRCB+rBrjbDvaK/GxpV75IxfDZQge4dCzR3VJIj04J6nStH+NIAizQxgmNlST8Rfl5lu7VDE637B7yII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983105; c=relaxed/simple;
	bh=UD8CDdPPCgzlE4UpPExw1g7wgBWu/eHdRUTs06US00g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3Vcn8vEvBkRtKHlbIAOyECP/0Mwy1o/1PUwC3b5IPlGzQcb9eyFXbCkbf/MEZzX5lSixDrG8fgvshxk7tOSvpuQBR2j7AXhTyDrJI9XM+BNjAetlMvZbU5wEQIfzBdGVgxMpxYqURD1Nq52I8FV54+TxPGFXgOtIxKMnxw27Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLwCOPUs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgkMqC9E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLwCOPUs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VgkMqC9E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6579C219D0;
	Tue,  3 Jun 2025 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748983101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4Hqux2RDFplVZWH2vxABOzL4D2x4leHU50XLb9pWsE=;
	b=ZLwCOPUs5PtS1QH6jTs583ZLChoqRuCaebHAHDoE9XAe9tqSbWPCh/voy0wlXlIQLvmBBU
	RfVvIdKMxaoD3wQQUTAxnHXJ6gkYPQq9a1I1ky3PFoBfUPBUjeXWTi3QBiZn+RYDgkqDk7
	sJETY2DfiQkV0IlxfWBd96pMDwkEiPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748983101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4Hqux2RDFplVZWH2vxABOzL4D2x4leHU50XLb9pWsE=;
	b=VgkMqC9E0/GYmzTdMfqBOywsBifBxhRHuZO/6sfjCAtSxR7eXPrIkC4wldCTQWNLZIrdzL
	e9OEDM/9tD7n9AAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748983101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4Hqux2RDFplVZWH2vxABOzL4D2x4leHU50XLb9pWsE=;
	b=ZLwCOPUs5PtS1QH6jTs583ZLChoqRuCaebHAHDoE9XAe9tqSbWPCh/voy0wlXlIQLvmBBU
	RfVvIdKMxaoD3wQQUTAxnHXJ6gkYPQq9a1I1ky3PFoBfUPBUjeXWTi3QBiZn+RYDgkqDk7
	sJETY2DfiQkV0IlxfWBd96pMDwkEiPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748983101;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R4Hqux2RDFplVZWH2vxABOzL4D2x4leHU50XLb9pWsE=;
	b=VgkMqC9E0/GYmzTdMfqBOywsBifBxhRHuZO/6sfjCAtSxR7eXPrIkC4wldCTQWNLZIrdzL
	e9OEDM/9tD7n9AAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D65B13A1D;
	Tue,  3 Jun 2025 20:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id En+0Ej1dP2i+FQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 20:38:21 +0000
Date: Tue, 3 Jun 2025 22:38:20 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix invalid inode pointer dereferences during log
 replay
Message-ID: <20250603203820.GO4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <774f04cc2a403a615ac24ecc9386fb870a88b956.1748975634.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774f04cc2a403a615ac24ecc9386fb870a88b956.1748975634.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Jun 03, 2025 at 07:55:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In a few places where we call read_one_inode(), if we get a NULL pointer
> we end up jumping into an error path, or fallthrough in case of
> __add_inode_ref(), where we then do something like this:
> 
>    iput(&inode->vfs_inode);
> 
> which results in an invalid inode pointer that triggers an invalid memory
> access, resulting in a crash.
> 
> Fix this by making sure we don't do such dereferences.
> 
> Fixes: b4c50cbb01a1 ("btrfs: return a btrfs_inode from read_one_inode()")
> CC: stable@vger.kernel.org # 6.15+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

