Return-Path: <linux-btrfs+bounces-15037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4528AEB3FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B151B16ACC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6D29993F;
	Fri, 27 Jun 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+xkW5EC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tIxGDdUT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+xkW5EC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tIxGDdUT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788F298CC7
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019237; cv=none; b=Y6FFdY1LlURrVppbypea0STqx632OrRWhmuvYVojMdugENFX2vW/YsFqF2j05+bcY/4q7k+K4S+FeYaVKzRDnH5NXSntGacQGFpCV8o5nMAs3MeDN2SxuDcHUWYitRZ1NCZpTe5gif+ec6DvQOYjSRd+PmGs9sBTQmQEeg64wnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019237; c=relaxed/simple;
	bh=7BPIeTdrWO9xcmpoC3Af2BxTukPluisiLS9rvA0h9XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPmnjYtvd2O7KmB++W8JqDPEz0i6Dlkf1TyG/vbFnmd5s3HxKf5evszZxvjdU6DWZYVXyMQtET1RLsOeOWU2INH76YjNgNcC5EgJnIFZuvxRFf6C6kTxKCKbAefLqGUUB+6aLsqYvs/n7kBXr4YJyhxIN9GUQjALEaOMJLwLpq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+xkW5EC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tIxGDdUT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+xkW5EC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tIxGDdUT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C6D01F390;
	Fri, 27 Jun 2025 10:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751019233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cmQUQ2O+VlgEf0Sh6o/5yAaDPMg+ZOafVEcbRdlzF4=;
	b=z+xkW5ECn53i74C2qcvXkNRzpW/ef/h8BsCVEdusaVIoNBXJD/1bIw4sDwvuykxOCOBzDE
	BCtDB1+Kz32ec00QpTr0GYa6dU200OFeWjH47bfSeyMKWKjLfmcorWUTb3MJOXL3R/dUeH
	hwNoDQO3M4G1RW80CrCkh34C98CNYos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751019233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cmQUQ2O+VlgEf0Sh6o/5yAaDPMg+ZOafVEcbRdlzF4=;
	b=tIxGDdUTwLR9HZ4AvovrOGvTB4vV8TZdi2nhHe2aqev17npgozdO+kSopY5W+SkcM1gmNz
	qItyzhHol/AUcmAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751019233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cmQUQ2O+VlgEf0Sh6o/5yAaDPMg+ZOafVEcbRdlzF4=;
	b=z+xkW5ECn53i74C2qcvXkNRzpW/ef/h8BsCVEdusaVIoNBXJD/1bIw4sDwvuykxOCOBzDE
	BCtDB1+Kz32ec00QpTr0GYa6dU200OFeWjH47bfSeyMKWKjLfmcorWUTb3MJOXL3R/dUeH
	hwNoDQO3M4G1RW80CrCkh34C98CNYos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751019233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cmQUQ2O+VlgEf0Sh6o/5yAaDPMg+ZOafVEcbRdlzF4=;
	b=tIxGDdUTwLR9HZ4AvovrOGvTB4vV8TZdi2nhHe2aqev17npgozdO+kSopY5W+SkcM1gmNz
	qItyzhHol/AUcmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E06913786;
	Fri, 27 Jun 2025 10:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OK1yIuFuXmj0ewAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 27 Jun 2025 10:13:53 +0000
Date: Fri, 27 Jun 2025 12:13:52 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: qgroup: avoid memory allocation if qgroups are
 not enabled
Message-ID: <20250627101352.GF31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b0e317f51f01fd88c32fd14f6bd8ea40b88943fb.1750954008.git.fdmanana@suse.com>
 <bd2bcda4d19bc931752ffa7b1730c5e5fa9d7b48.1750955238.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2bcda4d19bc931752ffa7b1730c5e5fa9d7b48.1750955238.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Jun 26, 2025 at 05:29:34PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At btrfs_qgroup_inherit() we allocate a qgroup record even if qgroups are
> not enabled, which is unnecessary overhead and can result in subvolume
> and snapshot creation to fail with -ENOMEM, as create_subvol() calls this
> function.
> 
> Improve on this by making btrfs_qgroup_inherit() check if qgroups are
> enabled earlier and return if they are not, avoiding the unnecessary
> memory allocation and taking some locks.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Update changelog, the problem is at the ioctl level and not at
>     snapshot creation during transaction commits.

Reviewed-by: David Sterba <dsterba@suse.com>

