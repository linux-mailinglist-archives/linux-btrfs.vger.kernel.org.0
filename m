Return-Path: <linux-btrfs+bounces-8942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3B99F818
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 22:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C600B28625F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 20:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD61A76DD;
	Tue, 15 Oct 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Vb4kW2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="umUMZx2D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Vb4kW2G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="umUMZx2D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10D14F117
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729024310; cv=none; b=gdMD0VdPtJ23Tho+Bnhd2+/+wTEUQpFlUCg0KpFSmBp2oqm6c46V+htvpAOOePBLlRuWpJf1Gx0M9X2iLfJp8WdZtfX72KRJD08Wmxhp7hBGlDAqgJX3hYAWtfL3CTIyHo8sr8CSXArqkkK9apPMeuJCqXrHGcNQ/C0NHfKjSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729024310; c=relaxed/simple;
	bh=n6NilfTZ5ou9qYkmnWGkliPMV9e/4bXnXaUs3FgXME8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGh3BCjpXP5BtBwBxnyYl5X5tSrs4PfRZVK/mxqwAgZLei9UDx5UeSM9/puRQIbedBtb0CE4L18xfPbof02ROoIAODxVE0+6V0ZYsBop9f73cLG2v8GfN87PcHF25/bhB0nYuRu2JYQevjbUR9kDOgtjGpmLvGPM+g6a1/D40n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Vb4kW2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=umUMZx2D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Vb4kW2G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=umUMZx2D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92D6B1FDDA;
	Tue, 15 Oct 2024 20:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729024305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRbfKHOfEz38B1LFjSxUlLcP7DURwKHbTXre/UEi450=;
	b=1Vb4kW2GyGLz5lQA0oe4X6VSCwLo3VyPghYAJofin9yU0GCwxjwoSirt3CxH3fWe87wZrL
	KNyFD7nCngPDeU+Pja4Cn359frHLl9Cdevlqw49YiHKGUzpt/tGTt+rzdNLxf3u+xa8RX4
	NnbK2WpR0c3uXHVk2WqKsNQHiUB639A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729024305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRbfKHOfEz38B1LFjSxUlLcP7DURwKHbTXre/UEi450=;
	b=umUMZx2DqEg07vcn3l3YPUqz8BSkko42kTXt1t7DrSdksf/KB3Z6UjQivl8w/CnKxDPuwD
	v/Cfc/Jqi4tBwIAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729024305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRbfKHOfEz38B1LFjSxUlLcP7DURwKHbTXre/UEi450=;
	b=1Vb4kW2GyGLz5lQA0oe4X6VSCwLo3VyPghYAJofin9yU0GCwxjwoSirt3CxH3fWe87wZrL
	KNyFD7nCngPDeU+Pja4Cn359frHLl9Cdevlqw49YiHKGUzpt/tGTt+rzdNLxf3u+xa8RX4
	NnbK2WpR0c3uXHVk2WqKsNQHiUB639A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729024305;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zRbfKHOfEz38B1LFjSxUlLcP7DURwKHbTXre/UEi450=;
	b=umUMZx2DqEg07vcn3l3YPUqz8BSkko42kTXt1t7DrSdksf/KB3Z6UjQivl8w/CnKxDPuwD
	v/Cfc/Jqi4tBwIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7948013A53;
	Tue, 15 Oct 2024 20:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PtRWHTHRDmcLbAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Oct 2024 20:31:45 +0000
Date: Tue, 15 Oct 2024 22:31:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Racz Zoltan <racz.zoli@gmail.com>
Cc: clm@fb.com, linux-btrfs@vger.kernel.org, inux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs/inode.c: Fixed an identation error
Message-ID: <20241015203140.GL1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241015202215.10086-1-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015202215.10086-1-racz.zoli@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Oct 15, 2024 at 11:22:15PM +0300, Racz Zoltan wrote:
> Fixed identation error
> 
> Signed-off-by: Racz Zoltan <racz.zoli@gmail.com>

Sorry, we don't want pure whitespace change patches.

Explanation: https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#how-not-to-start

