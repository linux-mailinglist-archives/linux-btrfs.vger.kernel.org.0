Return-Path: <linux-btrfs+bounces-12391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B627A67A9F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 18:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31131726F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FFE212FB1;
	Tue, 18 Mar 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2hrJPqJ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sq5nHMJS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2hrJPqJ5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sq5nHMJS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2669212F9F
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318174; cv=none; b=ADNcBuCeN2aB0U1NKCHMx1lwVZEUpj92iz1bi9LuRqhhFCUbMgSoKVkm8m/BbgmkuHcnYyW7/m7c/zKKuCe0bzCQwwbYfVWx1fb7zfPZiIel/Jjgj5YsA64IPhdfUT0vlkt64oKBnjkceumojQi943VWJgPGtnI6YW0Zly9a/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318174; c=relaxed/simple;
	bh=rvupHrSmd8ZFrAnxNh3osQQ01Qb/YlbOTSfnBMmhPdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEVh5yfy6798V8+4YmkzrKY2dfX7djeiB9BA47dEnQno15PUVhBgwBG/0Q5HYEeQtsmRlwyTIyxxDNkkYpxpuIthBbBCGllrVVm9LI7Sih9nkwHwKhctApuUY/Saac3Gi1R+hdpA93e+K9u7IIZ2B4Yigp7dp4iuP9ketiH0WnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2hrJPqJ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sq5nHMJS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2hrJPqJ5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sq5nHMJS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B338C1F792;
	Tue, 18 Mar 2025 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742318170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yl1wj28j2uniBMX6YXjydr7sQzV7EWIM7YtceHrKzvs=;
	b=2hrJPqJ5FWHjPEpRD7XO+xRjLnY2eT+aTaPuPIlNVKeXD5h00jHAi+z3KYS4EeFE9ml6b1
	RCBSg8VNXSoxOQQoNC31Srus6Mn6npj1Du/L2adbmb3AIcywoxOVDCOo2AlZ8UbOqn/wcS
	poSib1iK2PLKXb9teH7r55Ey9kG/WT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742318170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yl1wj28j2uniBMX6YXjydr7sQzV7EWIM7YtceHrKzvs=;
	b=sq5nHMJSYi1WVUIgtokIukvZitHRT4THl+UBaKjTkFfhDei+mTCU0wtdzffdGgDO5TJmkk
	3JTNSDabdBXveNDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2hrJPqJ5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sq5nHMJS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742318170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yl1wj28j2uniBMX6YXjydr7sQzV7EWIM7YtceHrKzvs=;
	b=2hrJPqJ5FWHjPEpRD7XO+xRjLnY2eT+aTaPuPIlNVKeXD5h00jHAi+z3KYS4EeFE9ml6b1
	RCBSg8VNXSoxOQQoNC31Srus6Mn6npj1Du/L2adbmb3AIcywoxOVDCOo2AlZ8UbOqn/wcS
	poSib1iK2PLKXb9teH7r55Ey9kG/WT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742318170;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yl1wj28j2uniBMX6YXjydr7sQzV7EWIM7YtceHrKzvs=;
	b=sq5nHMJSYi1WVUIgtokIukvZitHRT4THl+UBaKjTkFfhDei+mTCU0wtdzffdGgDO5TJmkk
	3JTNSDabdBXveNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 988A4139D2;
	Tue, 18 Mar 2025 17:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MicFJVqq2WdRRgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Mar 2025 17:16:10 +0000
Date: Tue, 18 Mar 2025 18:16:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
Message-ID: <20250318171605.GJ32661@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250318095440.436685-1-neelx@suse.com>
 <20250318154552.GE32661@twin.jikos.cz>
 <CAPjX3FdLp-niyvQX5vkrPtqwJcRB+hcax=0wRbKdQvJS4T+-PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FdLp-niyvQX5vkrPtqwJcRB+hcax=0wRbKdQvJS4T+-PA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B338C1F792
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Mar 18, 2025 at 06:07:20PM +0100, Daniel Vacek wrote:
> On Tue, 18 Mar 2025 at 16:45, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Mar 18, 2025 at 10:54:38AM +0100, Daniel Vacek wrote:
> > > This flag is set after inserting the eb to the buffer tree and cleared on
> > > it's removal. But it does not bring any added value. Just kill it for good.
> >
> > Would be good to add the reference to commit that added the bit,
> > 34b41acec1ccc0 ("Btrfs: use a bit to track if we're in the radix tree")
> > and wanted to make use of it, faa2dbf004e89e ("Btrfs: add sanity tests
> > for new qgroup accounting code"). And both are 10+ years old.
> 
> Right, I could have checked the history.
> 
> Though honestly from the diff of these two commits I don't see any
> valid usage of this flag either. Must have been somewhere in the
> context or I'm missing something.

Yeah, from the diff it can be seen if the code has any effects. It's
recommended to analyze the code also from the historical context because
it can be a leftover from a cleanup (and most of the time it is), but
there's still a chance the initial intentions of the code are still
valid and it was the cleanup that broke it.

