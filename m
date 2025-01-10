Return-Path: <linux-btrfs+bounces-10900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB1A094C3
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5927A1CEC
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BD3211473;
	Fri, 10 Jan 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uIKKSnzw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dbZBghYY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2czB6vth";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VX4LFSRF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3520B80D
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522020; cv=none; b=A1UcDZKDZJJ2tZ2C0/WhsqgPJPcrZwgxIHcdjRpQr0X9mdWUp+COjIJ2gSyXp1GMrgze3TvUnwOB1I96c32D5Uks7BSPKkoZHB23fH8QgUUza1NH8alWOEyiFPSSHtT+P2o4TUbMxlpipORE90QxFMbd3i7SLG/CSoUqZBvetcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522020; c=relaxed/simple;
	bh=kGAauAEQ+a4woCVS0FOKzwOmVnJCs7Iy/+V3ia3XLwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdUMuP3j0+aA6ezlN6+3eVAuZXxjGcsXiPu4Ayt27bZHiFto4j4zIO3ND3JdZHS9/GkPoYNkmh3jnjYjSfUMkJe/jbjKW1O0i3sL3Va6IxgmWpLb98w9oUNErCZtJw0t7zVZGGHvEqi3KlLkfXpklUYHSZ5pfYbfCd4R15OSS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uIKKSnzw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dbZBghYY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2czB6vth; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VX4LFSRF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECEDA21137;
	Fri, 10 Jan 2025 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736522011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0xDK1S2M/TXzAzyU8vOZJNXqkdsStW1vfmya1u681w=;
	b=uIKKSnzwmfd/KRE0aQWViFboS13tuLHxx12+TOGFdbUafTTHEyojIhXzPW6c6s4wdMsyNI
	rr73Qrm6ebgd3rVenClMzFkz+i7RHMwEcAxkDj4QSpE+46SFl42Jitmgtcg4z63cDbCsCA
	uRZ8QalO4w7TnKY7jAQ2cFhsU1AOH6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736522011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0xDK1S2M/TXzAzyU8vOZJNXqkdsStW1vfmya1u681w=;
	b=dbZBghYYwFItpAKN1eDVR65dzfdA0C5Ne0qf2nLcr+RqIPKCn/4oL0ufTt+Vl8A6GQ6lh5
	LT7FRDlZUHDW21Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736522010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0xDK1S2M/TXzAzyU8vOZJNXqkdsStW1vfmya1u681w=;
	b=2czB6vth6v5jAwACYI+UzfelXu02tNj4c+Idd2zQOw41CMUPRnJva/T1IjSUEEH75fSzac
	OzW1YMYilsFD/9pYs05U85KIo/ARAUBTobhcXZFrnEafvTdrFBj8R7iLKYod0gOquoy1JX
	+ytHu1dcdsspk6G6oBzbQKvYYpd5fAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736522010;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0xDK1S2M/TXzAzyU8vOZJNXqkdsStW1vfmya1u681w=;
	b=VX4LFSRFhmSg4wZ4H9Aid6ef8tFKX3POEtAxhaepQYrX1ofjUR2vOvweDXxiAZGyX5+qqr
	metxAXTBSXke+NDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D09CE13763;
	Fri, 10 Jan 2025 15:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wmy1Mho5gWd4AwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 10 Jan 2025 15:13:30 +0000
Date: Fri, 10 Jan 2025 16:13:25 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/18] btrfs: rename __unlock_for_delalloc() and drop
 underscores
Message-ID: <20250110151325.GA12628@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1736418116.git.dsterba@suse.com>
 <cb2e56cec569be6600b2a159f8ecf98907ad87e6.1736418116.git.dsterba@suse.com>
 <ce2fb42e-6607-411c-8163-ab52383ba6d0@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2fb42e-6607-411c-8163-ab52383ba6d0@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Jan 09, 2025 at 12:07:43PM +0000, Johannes Thumshirn wrote:
> On 09.01.25 11:27, David Sterba wrote:
> > Drop the underscores as the naming scheme does not apply here and to
> > have the unlock for parity with lock_delalloc_folios().
> 
> That sentence somehow doesn't sound good in my head, maybe
> 
> Drop the leading underscores in '__unlock_for_delalloc()' and rename it 
> to 'unlock_delalloc_folio()'. This also ensures naming parity with 
> 'lock_delalloc_folios()'.

Right, I'll use that wording, thanks.

