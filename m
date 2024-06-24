Return-Path: <linux-btrfs+bounces-5922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7C9152E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C51B250A3
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F67919D893;
	Mon, 24 Jun 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vpm7TLkL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2FCRI7dT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c64RC4dH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iO8XH4If"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F019D092
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244243; cv=none; b=BU9w1z7HkGptS7hB9Vcfu4F0Qy4zLcS/c8My0biBm+Ysus1PhGiQvZO+84wbOW4CnTmylC56UUVQZ9XtdbLey/VqFO+UYCpiscjmhZD3dh9CTlGzdvcH+xm+H0Q+uC+6IbQz7dLTNxAfqKpdmdCNk4Ts+dlhOCSnO4Y8t6kzTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244243; c=relaxed/simple;
	bh=s+fnR5E4jqvLUPKMzUtiBWpONHFgNaTlJK8o1jP2EKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByeVBfzNrtdemuUI1uuOV9gcjrsdR+oyGu+I9k+IytyMat1F3eSYQuv/dtUC+U4sdqp7YcYMJ0zLpuL+MOpdwIyZe6NA6mq5ga7FhjKqVvdw3b5afSX8uANvUgbCmAZHQ+M7ckif8NhlbQxZC7SKo6ULJG+uKJN2DLOSsEHclBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vpm7TLkL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2FCRI7dT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c64RC4dH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iO8XH4If; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 53DCE219E3;
	Mon, 24 Jun 2024 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719244240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kljuxG5vIzV5uWjRfOLMKmFmq/rrQ5gJ6oPYyGajsoE=;
	b=Vpm7TLkLgzK/271TA850ZlstVmuFCKqDouBnpISDsCX7/QVk+15kIx6KzLAFq7R23jx0ni
	VyIV5TkLrZtCHVxJrXTNgMzRo2c4h7nW5SmYaBxxzQOt5qbCetnQFxduesAXtR/XjCYeLw
	15QJatC/eWxNrhiInuKw70/73P5USaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719244240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kljuxG5vIzV5uWjRfOLMKmFmq/rrQ5gJ6oPYyGajsoE=;
	b=2FCRI7dTTyP+UcBg6ATxwMUk1PD5cKiKogrd0Mm7f05Byz1prg/I4SmNwSMsxDIPBYbnK9
	fRYiKvkbPctnUrCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719244239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kljuxG5vIzV5uWjRfOLMKmFmq/rrQ5gJ6oPYyGajsoE=;
	b=c64RC4dHGzLgpXCjFuADPmpGYUUuic+95GAmd/dylDHZg40i3NAXVDsOH6WPd/mDzxjYTY
	aOERRnt528kbi/JMTpKH1c27nGen8r2sASbHjjqxMuw83RjTgC5Trx83U3H6HQ5uPe2KF8
	chlWR4zbYuXj9dItHqzUJXa5YDCojL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719244239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kljuxG5vIzV5uWjRfOLMKmFmq/rrQ5gJ6oPYyGajsoE=;
	b=iO8XH4IfZ10DtfW9S4w/cnVR7r9VfD6QVzOp4u+6+O/NCvO2jgAY1HjdazP3B/UiwCA42v
	aBUHUy1ZRovQrlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46C6613AA4;
	Mon, 24 Jun 2024 15:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WyYZEc+VeWZfJAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 15:50:39 +0000
Date: Mon, 24 Jun 2024 17:50:38 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix uninitialized return value in the ref-verify
 tool
Message-ID: <20240624155038.GN25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <612bf950d478214e8b76bdd7c22dd6a991337b15.1719143259.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612bf950d478214e8b76bdd7c22dd6a991337b15.1719143259.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]

On Sun, Jun 23, 2024 at 12:50:26PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the ref-verify tool, when processing the inline references of an extent
> item, we may end up returning with uninitialized return value, because:
> 
> 1) The 'ret' variable is not initialized if there are no inline extent
>    references ('ptr' == 'end' before the while loop starts);
> 
> 2) If we find an extent owner inline reference we don't initialize 'ret'.
> 
> So fix these cases by initializing 'ret' to 0 when declaring the variable
> and set it to -EINVAL if we find an extent owner inline references and
> simple quotas are not enabled (as well as print an error message).
> 
> Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/59b40ebe-c824-457d-8b24-0bbca69d472b@gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

