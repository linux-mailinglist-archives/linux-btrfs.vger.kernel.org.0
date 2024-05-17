Return-Path: <linux-btrfs+bounces-5069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5EF8C896E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09C2B223CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4312F581;
	Fri, 17 May 2024 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wMVSuvcq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y1npJOuE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wMVSuvcq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y1npJOuE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB6112F39C
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960335; cv=none; b=An7FLzAzSHErtigs1fOTcpAQj1Nxda86pfhHt47kLp5NI8BfFtQlRDFLbckaBLWHxnY5NOxfnVJzeFgXJP3vGYgIo6jhe72KtRayg1uzmRvRZgSIHDHgnxOwxWZe/Fnxn+dkqEc8kViNGgTXHPATvG3k1nINQx/414v662wDK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960335; c=relaxed/simple;
	bh=I9Bq6eij9oVJ22xk1h8mTzr10rP5+iWvS3sOqeySfeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiByoDyxYOSLuLzyfNO0FBjlUzmIwONhlcBpvwM4XHyEr0MP4DFo2d8a/wQz4ZJDIIlziDwU92rB+d3gsWDCmpA1SIpn24IpV4VPkFN9pQbSz1+3xhbsgCvS3WecHNxArZm3jZgY1wQKcgspgPbYhgLvzciWhTZ6RKQauZRZhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wMVSuvcq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y1npJOuE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wMVSuvcq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y1npJOuE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CEFF5D4B4;
	Fri, 17 May 2024 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715960332;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCbTEdzZEKlTBx5sYbDYcOuOq0MAmJLE0ZDINnx2+ns=;
	b=wMVSuvcqRSWOM2kqVx5Afnh8bIn3VvWwI9xCSfcOkMOZTqBKU3Afooy4o9eUQ/8eEb8kjC
	oohio/kdqM631fTTlfd6kiwppqS1XZe6zcfZ6HXMi+KzPe5/fNiqUs0kX6SpjcH7+XMbcc
	BXDjNFHbnOVrN7AurCQqaxxAI0BMRPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715960332;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCbTEdzZEKlTBx5sYbDYcOuOq0MAmJLE0ZDINnx2+ns=;
	b=Y1npJOuEmyySELPEpa5OljcaXOSPsiOvMwHWJgsSgiOvViIAqeRCBI6S6x3/m5z2IUiMiS
	q8J6UxYTdYZfyDAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wMVSuvcq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y1npJOuE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715960332;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCbTEdzZEKlTBx5sYbDYcOuOq0MAmJLE0ZDINnx2+ns=;
	b=wMVSuvcqRSWOM2kqVx5Afnh8bIn3VvWwI9xCSfcOkMOZTqBKU3Afooy4o9eUQ/8eEb8kjC
	oohio/kdqM631fTTlfd6kiwppqS1XZe6zcfZ6HXMi+KzPe5/fNiqUs0kX6SpjcH7+XMbcc
	BXDjNFHbnOVrN7AurCQqaxxAI0BMRPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715960332;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CCbTEdzZEKlTBx5sYbDYcOuOq0MAmJLE0ZDINnx2+ns=;
	b=Y1npJOuEmyySELPEpa5OljcaXOSPsiOvMwHWJgsSgiOvViIAqeRCBI6S6x3/m5z2IUiMiS
	q8J6UxYTdYZfyDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FCFD13991;
	Fri, 17 May 2024 15:38:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZUxsDwx6R2YHQQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 May 2024 15:38:52 +0000
Date: Fri, 17 May 2024 17:38:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop bytenr_orig and fix comment in
 btrfs_scan_one_device
Message-ID: <20240517153847.GB17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0de852fd1caaf97aadd2ac62bf178c664069ed17.1715833048.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de852fd1caaf97aadd2ac62bf178c664069ed17.1715833048.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.07
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4CEFF5D4B4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.07 / 50.00];
	BAYES_HAM(-2.86)[99.41%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu, May 16, 2024 at 12:20:13PM +0800, Anand Jain wrote:
> Drop the single-use variable bytenr_orig and instead use btrfs_sb_offset()
> in the function argument passing.
> Fix a stale comment about not automatically fixing a bad primary
> superblock from the backup mirror copies. Also, move the comment
> closer to where the primary superblock read occurs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: David Sterba <dsterba@suse.com>

