Return-Path: <linux-btrfs+bounces-20976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFZZL/IadGnS2AAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20976-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 02:05:54 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B97BDE8
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 02:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3795301F9AD
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290031C5D59;
	Sat, 24 Jan 2026 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSeglnzE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLXO9EXr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sSeglnzE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLXO9EXr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75F27732
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216747; cv=none; b=OvhBpd2DjN9RemvePViVsGAoSnrc5UH3t2dRKIDMFH4Et+FLkVW3KMSNGr2nqIojyapzPOpBeTTMK0OgkzUhvAKuIKFV6sfoJ1vkMixfMgT7GkEqLQetMTg/LZ8dmnDbXJJaDCefroGD+ZwMtkS4SGohKyonAduzm2gqmH+ZNQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216747; c=relaxed/simple;
	bh=7Ftq5NXmU2WeYH1BnKE2DHt62KFZ7z7HLmCJbJWrbPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aED0vQWxMaSdTyzabM2lsrG6NBCaVLNoxOP+MIn9JCOyiAgCcM7xET34Q32ZiCEasz9nZSGJZDT3jjQqdZX/2fG4a+PZX0AOoLOnXC+c3EVt1ZfKsm1Ck6vWzi9t7JRRuNiEr4PUm5qQXO+hUaYEeB+qoii7wAfD5KKpj5auWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSeglnzE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLXO9EXr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sSeglnzE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLXO9EXr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D64233694;
	Sat, 24 Jan 2026 01:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769216744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksn6oTYEM1nin8poWs3VbUFs+hvEZkUkqHaUpPCEBbY=;
	b=sSeglnzENd8IktdR0D2O0o6jHJz0Rr18a5t+ZCOADsnprLntHmOLNQdb+c+ToQqLgj5pS4
	4DAIk0uE0adwhm9XKXJBmWnmj0nAJRpGhv0l/KnqURQEphURDYJ2GjGorx+qp8yfhduEm6
	52KAvYyGYWtHt6ny3xe/Yl+ux8RJpEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769216744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksn6oTYEM1nin8poWs3VbUFs+hvEZkUkqHaUpPCEBbY=;
	b=fLXO9EXrhUBCAZpbatRbuJsmpUGNd/kvzVRjkkMpPvTt4DrzufZM/DXVzDngLEmpkj+RZm
	qLrpQOg9A4T91DCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769216744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksn6oTYEM1nin8poWs3VbUFs+hvEZkUkqHaUpPCEBbY=;
	b=sSeglnzENd8IktdR0D2O0o6jHJz0Rr18a5t+ZCOADsnprLntHmOLNQdb+c+ToQqLgj5pS4
	4DAIk0uE0adwhm9XKXJBmWnmj0nAJRpGhv0l/KnqURQEphURDYJ2GjGorx+qp8yfhduEm6
	52KAvYyGYWtHt6ny3xe/Yl+ux8RJpEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769216744;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ksn6oTYEM1nin8poWs3VbUFs+hvEZkUkqHaUpPCEBbY=;
	b=fLXO9EXrhUBCAZpbatRbuJsmpUGNd/kvzVRjkkMpPvTt4DrzufZM/DXVzDngLEmpkj+RZm
	qLrpQOg9A4T91DCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4120F136AA;
	Sat, 24 Jan 2026 01:05:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NJK4D+gadGmDEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 24 Jan 2026 01:05:44 +0000
Date: Sat, 24 Jan 2026 02:05:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs-progs: enhance detection on unknown keys in
 subvolumes
Message-ID: <20260124010539.GA26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1765876829.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765876829.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20976-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,twin.jikos.cz:mid]
X-Rspamd-Queue-Id: 1E1B97BDE8
X-Rspamd-Action: no action

On Tue, Dec 16, 2025 at 07:53:46PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add a new test case
> 
> This is inspired by a real world bitflip corruption, where an INODE_REF
> is now 8 (an unknown key type), causing btrfs-check to freak out and the
> existing INODE_REF/DIR_ITEM/DIR_INDEX repair is not cutting this
> particular case for the original mode.
> 
> Lowmem mode is better, but for this particular image it's too large and
> lowmem is too slow to be practical.
> 
> As the first step, detect and report such unknown keys in subvolume
> trees as an error.
> 
> With a new test case for it.
> 
> In the long run we should allow btrfs-check --repair to delete such
> unknown keys.
> 
> Qu Wenruo (2):
>   btrfs-progs: enhance detection on unknown inode keys
>   btrfs-progs: add a test case for unknown keys in subvolume trees

Added to devel, thanks.

