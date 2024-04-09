Return-Path: <linux-btrfs+bounces-4055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497EE89D7F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 13:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A2E1F25562
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4008C128389;
	Tue,  9 Apr 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0TrB3DM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kjbNyZNt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0TrB3DM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kjbNyZNt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0630127B78;
	Tue,  9 Apr 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662378; cv=none; b=ZTvhvmod04o+YE0y9LZNF1Dht0oRCf4ghQKC5AyzzUDk3mO947Z5TDb9pSXu2hJ94Y0SGCTQr5zCE1S8Ui1lbXyX0yLpDfPZshsDIBlTEZM2mbS5mUUcj4perY0w/EHYZGWE2t75spm4TXusJ4Mzi8CZHMIrLc/NQ18mBSQxwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662378; c=relaxed/simple;
	bh=bWY/EyHCBZ5rYNS3jhlM00VXAZP01sQ0+8sE/3UgFDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seOnv6RCS9aqJWlTVPLVClf27zY86kE12NE/DnRkHKw5yZtiaOohnG1Q2PcByyIgvNjyLFE/tmGrycGSd4l7cywhuqZ0ppJ1f1KvK7IAOfebYJEpbhdDzlKu0qUWM3KPqb8ZKUb4sTQBypel7mreG7wxKGpeddB9iz2VU64XxeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0TrB3DM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kjbNyZNt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0TrB3DM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kjbNyZNt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BE9E33974;
	Tue,  9 Apr 2024 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712662374;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhResBqy6w19kUbZ+sh99Gzjwjr2TXA5KaqaU4/sUeU=;
	b=x0TrB3DM+eONDAmW5udw8QRfnxK2tTK18gMwFCzvqzu+TEZWNGrmDeQB218TYLLUEQKzBn
	a2BLxdJfacbrp98GJ9tqxXQT3S0oS8RhK0UJaWKNVn/pbljlNwZIKea54bJlv6IB7mBpGe
	dy2hUkHDlQzKIA9Mf9v2ZM0823JFv9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712662374;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhResBqy6w19kUbZ+sh99Gzjwjr2TXA5KaqaU4/sUeU=;
	b=kjbNyZNtMLdhp2FzN6yuilDrPBWsHl9Afhmndldl1KMpcRphWjQrQ+pmkq6evl96Tzvn63
	03U/GMX0+vKfEZDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x0TrB3DM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kjbNyZNt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712662374;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhResBqy6w19kUbZ+sh99Gzjwjr2TXA5KaqaU4/sUeU=;
	b=x0TrB3DM+eONDAmW5udw8QRfnxK2tTK18gMwFCzvqzu+TEZWNGrmDeQB218TYLLUEQKzBn
	a2BLxdJfacbrp98GJ9tqxXQT3S0oS8RhK0UJaWKNVn/pbljlNwZIKea54bJlv6IB7mBpGe
	dy2hUkHDlQzKIA9Mf9v2ZM0823JFv9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712662374;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jhResBqy6w19kUbZ+sh99Gzjwjr2TXA5KaqaU4/sUeU=;
	b=kjbNyZNtMLdhp2FzN6yuilDrPBWsHl9Afhmndldl1KMpcRphWjQrQ+pmkq6evl96Tzvn63
	03U/GMX0+vKfEZDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 40ABC1332F;
	Tue,  9 Apr 2024 11:32:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tiSmD2YnFWbfYQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 11:32:54 +0000
Date: Tue, 9 Apr 2024 13:25:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
Message-ID: <20240409112529.GB3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240406051847.75347-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406051847.75347-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5BE9E33974
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]

On Sat, Apr 06, 2024 at 03:48:47PM +1030, Qu Wenruo wrote:
> [BUG]
> All the touched test cases would fail after btrfs-progs commit
> 5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when
> the ioctl succeeded") due to golden output mismatch.
> 
> [CAUSE]
> Although the patch I sent to the mail list doesn't change the output at
> all but only a timing change, David uses this patch to unify the output
> of "btrfs subvolume create" and "btrfs subvolume snapshot".
> 
> Unfortunately this changes the output and causes mismatch with
> golden output.
> 
> [FIX]
> Just redirect stdout of "btrfs subvolume snapshot" to $seqres.full.
> Any error from "btrfs subvolume" subgroup would lead to error messages
> into stderr, and cause golden output mismatch.
> 
> This can be comprehensively greped by
> 'grep -IR "Create a" tests/btrfs/*.out' command.
> 
> In fact, we have around 274 "btrfs subvolume snapshot|create" calls in the
> existing test cases, meanwhile only around 61 calls are populating
> golden output (22 for subvolume creation, and 39 for snapshot creation).
> 
> Thus majority of the snapshot/subvolume creation is not populating
> golden output already.

That's an interesting find, so we actually already do prefer not to use
golden output. There are recent tests that do use it though, so it's not
done consistently.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This is just a quick fix for the test failures, if accepted, further
> cleanup would be done for unnecessary golden output for "btrfs
> subvolume" subgroup.

I like it and this looks like the direction we can take for more
commands, thanks.

