Return-Path: <linux-btrfs+bounces-20886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDAqBfuAcWk1IAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20886-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 02:44:27 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1CD60773
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 02:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90D21440863
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 01:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247933590A8;
	Thu, 22 Jan 2026 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Za37mx1p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V7jJSx2P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Za37mx1p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V7jJSx2P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974A3570BD
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Jan 2026 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046188; cv=none; b=P/T4IcZI6j2kGMZRrTSlcF/pE0VmA4Md4sWVTTydUcOqMoHjqCHwGtvZYUAPoMeWDmSWy4e7C92lOXzGKBqhTFvwR2eBUQKdU5qlBSROZXM7V7wAzUaJbxNidyp3tcE3nj1ow8gd+KpxrKJZPPaG4IberQBQ25wES7tKOEAWa+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046188; c=relaxed/simple;
	bh=s6h0usmm8b2sU6hamn5jPyy/tdR1sMPXA4AhDhzQe+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qud4j16t6jzy0yvl3xfCBCvxvaWTZUVTxgiCHyBOZjiGXa8P4hoxBw4FjDX1AWRlkXF3K+L34kMDxNXV+Ud2DSe7tzjv95aaxiBWSkEijT4DJBnd25xJAE80c22EgvNT4g+4w2svOV8NgPRLGo/1C5PaVLDV54/9v6g0Oy9B/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Za37mx1p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V7jJSx2P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Za37mx1p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V7jJSx2P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88C1E33698;
	Thu, 22 Jan 2026 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769046184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvv3jj75Oyp33mmKVFTASDFnJPsv4XfsKTk8OTebVzo=;
	b=Za37mx1pyf6HRZk1ifwaoXMZGHbI9Ov2Ul4XaGsZj/6e+XvMVmC1iC5SgUIjm4RH4LK22k
	FuOtBV5jUb4iiS+KAfHr0ca9AVOgtNmQZIWF16/n8vwxB9ezf5ULpm+p6c0Y2Onc8tCDa8
	AktTdyidflSS6n5Lw1J9Z55EXhi1fV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769046184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvv3jj75Oyp33mmKVFTASDFnJPsv4XfsKTk8OTebVzo=;
	b=V7jJSx2PTQDV5mfuP7Hixq6XYJvYO8a8hZog8oDrGrecxj2VPppYyl8PPoea8Os0HAoKkt
	0YfRmH/CLfv3pnCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Za37mx1p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V7jJSx2P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769046184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvv3jj75Oyp33mmKVFTASDFnJPsv4XfsKTk8OTebVzo=;
	b=Za37mx1pyf6HRZk1ifwaoXMZGHbI9Ov2Ul4XaGsZj/6e+XvMVmC1iC5SgUIjm4RH4LK22k
	FuOtBV5jUb4iiS+KAfHr0ca9AVOgtNmQZIWF16/n8vwxB9ezf5ULpm+p6c0Y2Onc8tCDa8
	AktTdyidflSS6n5Lw1J9Z55EXhi1fV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769046184;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvv3jj75Oyp33mmKVFTASDFnJPsv4XfsKTk8OTebVzo=;
	b=V7jJSx2PTQDV5mfuP7Hixq6XYJvYO8a8hZog8oDrGrecxj2VPppYyl8PPoea8Os0HAoKkt
	0YfRmH/CLfv3pnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79FA73EA63;
	Thu, 22 Jan 2026 01:43:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8JSYHaiAcWmybwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 22 Jan 2026 01:43:04 +0000
Date: Thu, 22 Jan 2026 02:43:03 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: cleanup and fix
 sample_block_group_extent_item()
Message-ID: <20260122014303.GU26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1769028677.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769028677.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[suse.cz];
	TAGGED_FROM(0.00)[bounces-20886-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,suse.com:email]
X-Rspamd-Queue-Id: AE1CD60773
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 08:52:36PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Trivial changes, details in the change logs.
> 
> Filipe Manana (2):
>   btrfs: remove bogus root search condition in sample_block_group_extent_item()
>   btrfs: deal with missing root in sample_block_group_extent_item()

Reviewed-by: David Sterba <dsterba@suse.com>

