Return-Path: <linux-btrfs+bounces-8859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03B99A8A0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 18:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4CEB22CCE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E5199FC5;
	Fri, 11 Oct 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qhkNPbTC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QDKDMnfa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VnOEvGFd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7alE20ib"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2D198E7F;
	Fri, 11 Oct 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662986; cv=none; b=O30CRV7Aud/WnVYKaPkxkEuSZNOOvg/nFYy/Ns2Y41HzRIy3r+pwQKLle73MvVYijWs09r88LS5Zcg8G+YXe33Od9bCU4shJzob2JbPg8cWp+yLgH1j8T+MyveUQ1ZQ3MpVZr0HpyFuIpO4vBPxHDT0+O4SGSX1+xyKB7Cif68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662986; c=relaxed/simple;
	bh=4Xv9mFJWh2zaT2SmbVYcQ1utBb05Hj8xL+GDvsllSLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJTA2s23AMxWYzvRj2IxV2Yfc3OtCw4rI/xfYiS65ddtp0wnayAo3CrnYC2tCsJyO/Ij7dq87YJMnRfcXvVKSy+/s8IOFPpjV59ccAi8lIOvzaKW+uz6jBxj1F9GNkypbdiQt1qLLtxzgMhBzQmNbQPZ6N/GWDZsZhZOC1qL30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qhkNPbTC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QDKDMnfa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VnOEvGFd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7alE20ib; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E240A1F871;
	Fri, 11 Oct 2024 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728662982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+N1ZUlMPItjRVcCm4IinUgfijOdryJXv75jFTYjlHs=;
	b=qhkNPbTC/dv1JINfs7BVGvT9+BoCQfJoBRTMkYuCiuf2bptgxKMBMsTMsPjRY/8mxXAMeV
	LaBqWCJrCpCtmxhKzNhuDZN5ASoupCtLF0crBWkrzffgsY2D9aZ+VnzWrJjeiSa6bfUTKT
	5Qf4YxAkSzUqYZ6NudRuBUJ7LtOVaJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728662982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+N1ZUlMPItjRVcCm4IinUgfijOdryJXv75jFTYjlHs=;
	b=QDKDMnfaDvTMR1TeAGGhkR3amOnm5qdjROuspk8chCWji2kyKy59MuG5H7wBN/n1QB0+Ik
	N0qk3S2E99994jBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728662981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+N1ZUlMPItjRVcCm4IinUgfijOdryJXv75jFTYjlHs=;
	b=VnOEvGFdieSGuT22ebJOBz1TG0JWZGZqG2SkZu+uI9O6Y9squToRUhvdOxPWLtWMhLY7GW
	a7GM/jcT1tYmTrpQ8LJLiwQQNIOr02/GVJ/Rz0VTQfwac+c/IjoHvW2Cz0dVXmwTYlI7Bz
	EIh+MDUlbVSQa0ECFd6yAOqfDaZ79n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728662981;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+N1ZUlMPItjRVcCm4IinUgfijOdryJXv75jFTYjlHs=;
	b=7alE20ibM5J+akv2I4S/eDC5++wRTN4Z6RGixZMtfX5jpcQTenPipcS828e0kXe14qP8Hh
	04ZwgT11jgqtC3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCEE61370C;
	Fri, 11 Oct 2024 16:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jNoZMcVNCWcPNQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Oct 2024 16:09:41 +0000
Date: Fri, 11 Oct 2024 18:09:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Roi Martin <jroi.martin@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix uninit pointer free on read_alloc_one_name
 error
Message-ID: <20241011160940.GY1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241010194717.1536428-1-jroi.martin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010194717.1536428-1-jroi.martin@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Oct 10, 2024 at 09:47:17PM +0200, Roi Martin wrote:
> The read_alloc_one_name function does not initialize the name field of
> the passed fscrypt_str struct if kmalloc fails to allocate the
> corresponding buffer.  Thus, it is not guaranteed that
> fscrypt_str.name is initialized when freeing it.
> 
> This is a follow-up to the linked patch that fixes the remaining
> instances of the bug introduced by commit e43eec81c516 ("btrfs: use
> struct qstr instead of name and namelen pairs").
> 
> Link: https://lore.kernel.org/linux-btrfs/20241009080833.1355894-1-jroi.martin@gmail.com/
> Fixes: e43eec81c516 ("btrfs: use struct qstr instead of name and namelen pairs")
> Signed-off-by: Roi Martin <jroi.martin@gmail.com>

Added to for-next, thanks.

