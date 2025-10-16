Return-Path: <linux-btrfs+bounces-17899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F380BE4EB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06A8E4F5021
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73733215F5C;
	Thu, 16 Oct 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pGAlG5d2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7TgaWa3I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pGAlG5d2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7TgaWa3I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D1334697
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637189; cv=none; b=ASseIwkuzXxuVlAYuuiHxUm7/7/egjSNYzkXUOxYDu0Qg8lSw9cX9TRKWI7IlqaVFy1i3hyzcWUGACNhPAGRcKwXk9GL6G8RV72mKwSIcAWecmChNkBWkIqegY4qdfHkUg7WTTMS8W7ETADtIahbF4bow0LkCZTGMV83SKH3hvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637189; c=relaxed/simple;
	bh=G1KtWo7IRmcSGy1RrPTI0sYDu9s4iV0SZqYM48YP2mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqk5CYkVLPeGYr8WXVrNyxOOjxRkvuy9UyggInz7/JR2dmo48JE40Rpg7NwcCoEMiFBN7JNZ/WNdEW7zYISTRb0ADf4BhTLV884+cVEw/BWYR+YJ0PYp+vLakuz5ncLCB4jilhlLeUVWEwmHpwT09B7/77loLKZ8vDcCtogGNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pGAlG5d2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7TgaWa3I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pGAlG5d2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7TgaWa3I; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62CF31FB4B;
	Thu, 16 Oct 2025 17:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760637186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpMDYXH6q0aDreWeBCA44sjHZUCXQNSPX4+UkhOUM4M=;
	b=pGAlG5d2poLO34VBbQ8tdUhM3R4UZDH6wD2CMF0ZruR0DYMCu63EeOVi0CmokF/+55flOP
	UQfwHPVLobLrmCtxacOSkJx2eEN4ykm8OA7DPGElQyxcIeNeJSTl4I1BB2Y8+ZmmiuIiXD
	Fqm9MQWPMkrLAH4IbvNDEADR6FhQnlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760637186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpMDYXH6q0aDreWeBCA44sjHZUCXQNSPX4+UkhOUM4M=;
	b=7TgaWa3IPq00crEkWDSon6NCM7agjun7RlB24ZsllWTgTGObie2Coly6WfC1NimcFJf5mA
	1Zti/hLKQJUtqCAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760637186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpMDYXH6q0aDreWeBCA44sjHZUCXQNSPX4+UkhOUM4M=;
	b=pGAlG5d2poLO34VBbQ8tdUhM3R4UZDH6wD2CMF0ZruR0DYMCu63EeOVi0CmokF/+55flOP
	UQfwHPVLobLrmCtxacOSkJx2eEN4ykm8OA7DPGElQyxcIeNeJSTl4I1BB2Y8+ZmmiuIiXD
	Fqm9MQWPMkrLAH4IbvNDEADR6FhQnlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760637186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpMDYXH6q0aDreWeBCA44sjHZUCXQNSPX4+UkhOUM4M=;
	b=7TgaWa3IPq00crEkWDSon6NCM7agjun7RlB24ZsllWTgTGObie2Coly6WfC1NimcFJf5mA
	1Zti/hLKQJUtqCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 484ED1340C;
	Thu, 16 Oct 2025 17:53:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7q0qEQIx8Wg7SAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 Oct 2025 17:53:06 +0000
Date: Thu, 16 Oct 2025 19:53:05 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs-progs: tests: add new mkfs test for zoned
 device
Message-ID: <20251016175305.GI13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250910050412.2138579-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910050412.2138579-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Sep 10, 2025 at 02:04:08PM +0900, Naohiro Aota wrote:
> This series adds a new mkfs test for zoned device. The test is based on
> mkfs-tests/001-basic-profiles, but uses nullb devices instead of loop
> devices, to set a zoned profile.
> 
> Two preparation patches are necessaly for the test case. The first and
> second one fix the error handling of _find_free_index(). And, the third
> one adds wait_for_nullbdevs like the loop device's counterpart.
> 
> Changes:
> - v2
>   - Refine error/warn helpers not to print the message to stdout.
>   - Drop cond_wait_for_nullbdevs.
>   - Check if btrfs-progs is build with EXPERIMENTAL in the test.
> 
> Naohiro Aota (4):
>   btrfs-progs: tests: output error/warn message to stderr
>   btrfs-progs: tests: check nullb index for the error case
>   btrfs-progs: tests: add wait_for_nullbdevs
>   btrfs-progs: tests: add new mkfs test for zoned device

Added to devel, sorry for the delay.

