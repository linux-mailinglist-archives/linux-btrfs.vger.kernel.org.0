Return-Path: <linux-btrfs+bounces-5923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CD915317
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FF81F252F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5F19D082;
	Mon, 24 Jun 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SRNmQuYa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Vt5o73W";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SRNmQuYa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Vt5o73W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2FD4C637
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244973; cv=none; b=QwXAyYmd4UPh0/Y96RmGdyjjPZzY7vG/ICLzvarAh1FTB1IgS7gk1PGIFxEGTqbWzX2H770+RECsmVG5D3qsFm9uFegVk8XzhAdOmSg48aqG22dNbF7Qr32i4xKOkCrTj5m2gQjONg8U5fXJWxA5hZ7rkJfzdllmwoIJFiNHQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244973; c=relaxed/simple;
	bh=bOUwupypAoCNyP95hy53po98d50QdCPTs4YLSMaaoqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgT88tMV9sURYmxarLk5eDh5qA+4Kr2BbW26qkMD0UlbER+Wh1ey/XxRgd9dgIJc8R2n2SWk/dvE552UoYyEvRhQye7dpwD8ponAKeCWe+4TTChg4HK+wyvhvrLggjDogVFRtPXZZe5vapObdWJMMSx6coD1YhSQaMfBChywCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SRNmQuYa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Vt5o73W; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SRNmQuYa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Vt5o73W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37D8E21A1B;
	Mon, 24 Jun 2024 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719244970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOUwupypAoCNyP95hy53po98d50QdCPTs4YLSMaaoqQ=;
	b=SRNmQuYae3WwzsYx7UMbba9QwFBn8brCVMjvJpRXJBjvkzNqSzKJ7yt54bxst8OEp2Uh0T
	HWnpYv34/CqyiUwp/qjBLkf9Uwze3u3Fc8oIU8NdyF5j/7IkzhEcvpXaq8X/vrNIBXw593
	fLUSNB1REuDjvDPe9OlRCvD2PVkvu1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719244970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOUwupypAoCNyP95hy53po98d50QdCPTs4YLSMaaoqQ=;
	b=0Vt5o73WJU7fQXfvmC9wwmPM06CIy30DXEa91KTQb40VALqAI+FXFyXD4MdT8SJUgVo8tG
	AgP3c0EmA4eInbDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SRNmQuYa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0Vt5o73W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719244970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOUwupypAoCNyP95hy53po98d50QdCPTs4YLSMaaoqQ=;
	b=SRNmQuYae3WwzsYx7UMbba9QwFBn8brCVMjvJpRXJBjvkzNqSzKJ7yt54bxst8OEp2Uh0T
	HWnpYv34/CqyiUwp/qjBLkf9Uwze3u3Fc8oIU8NdyF5j/7IkzhEcvpXaq8X/vrNIBXw593
	fLUSNB1REuDjvDPe9OlRCvD2PVkvu1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719244970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bOUwupypAoCNyP95hy53po98d50QdCPTs4YLSMaaoqQ=;
	b=0Vt5o73WJU7fQXfvmC9wwmPM06CIy30DXEa91KTQb40VALqAI+FXFyXD4MdT8SJUgVo8tG
	AgP3c0EmA4eInbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FF2C1384C;
	Mon, 24 Jun 2024 16:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 14sDA6qYeWYJKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 16:02:50 +0000
Date: Mon, 24 Jun 2024 18:02:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: support STATX_DIOALIGN for statx
Message-ID: <20240624160248.GO25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240620132000.888494-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620132000.888494-1-lihongbo22@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 37D8E21A1B
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Jun 20, 2024 at 09:20:00PM +0800, Hongbo Li wrote:
> Add support for STATX_DIOALIGN for btrfs, so that direct I/O alignment
> restrictions are exposed to userspace in a generic way.

I looked at 8434ef1d8aafc523 that does also has some code coments, the
generic changelog does not mention DIO vs other features like verity or
inline files.

The statx manual page describes the high level meaning of the
dio_*_align values, so this is filesystem and implementation dependent.
So please mention what values can be expected for various features.

We do buffered io fallback on compressed data, on inline files too (I
think), it may be possible on verity too.

