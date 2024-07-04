Return-Path: <linux-btrfs+bounces-6204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42E927BBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 19:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075C228AED0
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182D1BB688;
	Thu,  4 Jul 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hL8Bqt0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aZcaczRd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hL8Bqt0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aZcaczRd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFD1B151F
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jul 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113046; cv=none; b=r3Z+tX8ck5eu/HWFYAJEzpNRkf8i+N+cHePYxX211NcjwUVYVqCRjfOvLjQE65MXTBYnfnnW7Y6+bQp5hK+r7NsPMTH0P/fXk1m7dJIFYD7GhreSKFrdT7ZaHecRQ3YyJuZw0ViLXpdRkYlmxlZVN4EO2++APqAYG5w3qZx+0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113046; c=relaxed/simple;
	bh=/8eBz9D+hTvtlpc/xozJSETUOzf5WZwLl2j4NGW9Q0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcNSM1/C6CbtW+ZZicWGTdeYQ4nJkoNF0BCGfRDz2zApV1AOsbcvhvirjRj50fV+7zeg/aMd8OGmGN5UkpOqVk9o/qxhVmg8iQl3ur3LkuQ4GKz+bEOHvaRdkNDia3JLQxtzkm3Biz3ifqr2CrjlS5wT7eJPIBuPBFtpPib70hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hL8Bqt0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aZcaczRd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hL8Bqt0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aZcaczRd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B944221A98;
	Thu,  4 Jul 2024 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720113042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bNFYQgPedYO9uxCjbJNKMX7S45wPx3XEq98Udpw9iFg=;
	b=hL8Bqt0S1FTwsscgPfG5enWj+J/VGsPYURn5yjOFP/PnX4SCE4wGNaEq8YhXuIxI8F+a0Q
	dAkcZFn5ZdfUh7nlZ9LWuyKhxXUP2n05CZhipmLWewQhSbtW7Pty45JUu9692QG9hx4ry3
	KVOzwRWL543p0ymLe64YH6NNx4prkFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720113042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bNFYQgPedYO9uxCjbJNKMX7S45wPx3XEq98Udpw9iFg=;
	b=aZcaczRdPg1Uf0TsYCQFFRxeE15fVKhDYI8SB7bdIpE7386LDu7jCNjddn49Lr9B45DBD3
	cV5j2McqKkEf2vAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720113042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bNFYQgPedYO9uxCjbJNKMX7S45wPx3XEq98Udpw9iFg=;
	b=hL8Bqt0S1FTwsscgPfG5enWj+J/VGsPYURn5yjOFP/PnX4SCE4wGNaEq8YhXuIxI8F+a0Q
	dAkcZFn5ZdfUh7nlZ9LWuyKhxXUP2n05CZhipmLWewQhSbtW7Pty45JUu9692QG9hx4ry3
	KVOzwRWL543p0ymLe64YH6NNx4prkFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720113042;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bNFYQgPedYO9uxCjbJNKMX7S45wPx3XEq98Udpw9iFg=;
	b=aZcaczRdPg1Uf0TsYCQFFRxeE15fVKhDYI8SB7bdIpE7386LDu7jCNjddn49Lr9B45DBD3
	cV5j2McqKkEf2vAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E62B13889;
	Thu,  4 Jul 2024 17:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BDYsJpLXhmaPXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jul 2024 17:10:42 +0000
Date: Thu, 4 Jul 2024 19:10:32 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix extent map use-after-free when adding pages
 to compressed bio
Message-ID: <20240704171031.GX21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <21fac1f722255954c5c7e67637e388451ad309c6.1720106056.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21fac1f722255954c5c7e67637e388451ad309c6.1720106056.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Jul 04, 2024 at 04:16:09PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Add add_ra_bio_pages() we are accessing the extent map to calculate
> 'add_size' after we dropped our reference on the extent map, resulting
> in a use-after-free. Fix computing 'add_size' before dropping our extent
> map reference.
> 
> Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/000000000000038144061c6d18f2@google.com/
> Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

