Return-Path: <linux-btrfs+bounces-17900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62973BE4EC6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 19:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F201B358656
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE1A21A434;
	Thu, 16 Oct 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nH9wYeIy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynGS9wdP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nH9wYeIy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynGS9wdP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D07219A89
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637254; cv=none; b=J792aeGidgvPgvoA9jlT5UIIY2mXhwTq+Z0809oRx1VgPdOZXQpbipdkhvr43dFEp7/oA1az4umYCWhAMehQ7XDuYwqm0bUDQ3H/q9DjT+Iy1DdrnDpzxj78IWKerM/rN+G03sD93WzAuCHqcxq8uzSw0Vx1YmQ/nIxobPDHYp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637254; c=relaxed/simple;
	bh=d+vm+NxRjFiMTrudewjDVa8DJGZPQ0JsIFfjFyljcUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0EvyEt6g2i1a5uDJVAYDm3Q0LHih6Tger3i3GSTYznlT9tgfHrP+ma4LbitRNau+YIFi/MtPMY6J39F/IGmVkG8MJTgb1Fz2QJLYA+H4I04NDCX3TQIIkpZjIMOf9wSrOkFxoToCA4J7VfgXQY2QeqKX5k6NDbkW4nIV2POcOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nH9wYeIy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynGS9wdP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nH9wYeIy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynGS9wdP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D7711FB4C;
	Thu, 16 Oct 2025 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760637250;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5Tt+3++IlC3QNPMF27kzxd1UBOmh0e9Y597g1BDvqg=;
	b=nH9wYeIyE1Cfb0beNKBUPpoD78n0Axj4cfKzgV5clEpXKQUO5DoxLk6Hegh+P8tthVmLnC
	SN2w1++ZgppxW2KQ353X5R41TdOIW10791ue9UOQjWrKKgxYNZ5bQP9ZGOW6HJ9sawzlpa
	zi051Nf6zrskYPd2ESF6vxrqCya5yFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760637250;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5Tt+3++IlC3QNPMF27kzxd1UBOmh0e9Y597g1BDvqg=;
	b=ynGS9wdPKnzqHJMW6SJMMy0GkSH4YJYWUaUhtnrh7w9OyZQ1mmsPI9Vhn4uFnt38jRoWKf
	EDtPo5/QJvAAKWAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nH9wYeIy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ynGS9wdP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760637250;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5Tt+3++IlC3QNPMF27kzxd1UBOmh0e9Y597g1BDvqg=;
	b=nH9wYeIyE1Cfb0beNKBUPpoD78n0Axj4cfKzgV5clEpXKQUO5DoxLk6Hegh+P8tthVmLnC
	SN2w1++ZgppxW2KQ353X5R41TdOIW10791ue9UOQjWrKKgxYNZ5bQP9ZGOW6HJ9sawzlpa
	zi051Nf6zrskYPd2ESF6vxrqCya5yFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760637250;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5Tt+3++IlC3QNPMF27kzxd1UBOmh0e9Y597g1BDvqg=;
	b=ynGS9wdPKnzqHJMW6SJMMy0GkSH4YJYWUaUhtnrh7w9OyZQ1mmsPI9Vhn4uFnt38jRoWKf
	EDtPo5/QJvAAKWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FFDA1340C;
	Thu, 16 Oct 2025 17:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id one2A0Ix8WgGSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 Oct 2025 17:54:10 +0000
Date: Thu, 16 Oct 2025 19:54:08 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove pointless data_end assignment in
 btrfs_extent_item()
Message-ID: <20251016175408.GJ13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9a0df9f54ffd27b41bdae2c60b0ffd59a85a3eb2.1760610675.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0df9f54ffd27b41bdae2c60b0ffd59a85a3eb2.1760610675.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1D7711FB4C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Thu, Oct 16, 2025 at 11:31:31AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no point in setting 'data_end' to 'old_data' as we don't use it
> afterwards. So remove the redundant assignment which was never needed
> and added when the function was first added in commit 6567e837df07
> ("Btrfs: early work to file_write in big extents").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

