Return-Path: <linux-btrfs+bounces-17190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F243BBA0EF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135101C2223A
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Sep 2025 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8374530E853;
	Thu, 25 Sep 2025 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p55iiTlu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kZQin+3r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DSpVWpqJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IGlfYOm1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4FE30C342
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Sep 2025 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822457; cv=none; b=iQCyID7k5jx9yidLCP/22ZrI3SYeS+ghdFo11r9aQrhmnNLwjxYvO3ANPJX6PD7Mjvf5mP4PT9hMGkb1Kv1jO06oyXmgur6q2fN39HdoQjbwViQhmU1IRImQvyLEkwJZnXexHjZ/tSG7C17kuWDCMy1akOHkenOCA4MMzoqEtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822457; c=relaxed/simple;
	bh=9p2N0AMjfA2G2Z5HFNujsaZ900Ps6ZJ1g5GaoG4yaxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzOXeM4jkgRnuLyXlcy7IQKqTZ4BUNSwYZNEbVhX7XucxvFohspAgnlb3V4//0QoJcMUJVocLx/KmfPLOg7n9/oFAe9w+Fw0yX/bSwKIvrFM6CVdQuUUCcIBK/q43beOKqsI7DIg+V5M0jkmkXDyPrAC5mpbPWKRfypRORwBs0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p55iiTlu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kZQin+3r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DSpVWpqJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IGlfYOm1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07A44174A1;
	Thu, 25 Sep 2025 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758822454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m++ezEZanNzZcXMExNjKsjogGHka+kYGUIwCdZNVoE4=;
	b=p55iiTluY8uKZxvXT1L3sESJ8UkLBA8e0giuG6lSZGl5lBfFbgVgArbV3zo9FZtxJl+ZjC
	/vAhXJpqZ2ijJtolsOG5pjWQX30dPrnceZPE2a/nbscMi10K2MiEUvqk3De5DsQUse5zVT
	fx/7Zca+JPhItJ6GYjJOL33+ooYPoK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758822454;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m++ezEZanNzZcXMExNjKsjogGHka+kYGUIwCdZNVoE4=;
	b=kZQin+3rqE9cbdP0HZ4jvqSe1H2Wfidj22r6HBVDnU8FksQjc/9H7kwF1cqF/Gw+OV8EXl
	fviBBhWXGFrCS7CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758822453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m++ezEZanNzZcXMExNjKsjogGHka+kYGUIwCdZNVoE4=;
	b=DSpVWpqJvieWV0Nwv/OTkEIIXCT94Gdngmm4iiAltGu2GcTwvKq/gZkbYuxtPDy1xd/n7a
	ko9jzT0SMkbKHA9oSy3tRgxE01Q5tHlcYOd9fk7ma1+BNWuVnFm7NhcHiuDVLLfWnVGdWF
	ASpKQoGkM/5ny6TnpXnjr3FU2vff4h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758822453;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m++ezEZanNzZcXMExNjKsjogGHka+kYGUIwCdZNVoE4=;
	b=IGlfYOm1/u9Uy/tz9BMVD4Pgu3DH5bqpSW9Fw5O7L/7zXciBODxXkB7Iv44M9EYhmiDe3W
	uynaKVbQ1Bsqd0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFBCF13869;
	Thu, 25 Sep 2025 17:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0VspNjSA1WhrfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Sep 2025 17:47:32 +0000
Date: Thu, 25 Sep 2025 19:47:31 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: Miquel =?iso-8859-1?Q?Sabat=E9_Sol=E0?= <mssola@mssola.com>,
	linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: ioctl: Fix memory leak on duplicated memory
Message-ID: <20250925174731.GQ5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250925145331.357022-1-mssola@mssola.com>
 <20250925172529.GA1937085@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925172529.GA1937085@zen.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[mssola.com:email,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Thu, Sep 25, 2025 at 10:25:29AM -0700, Boris Burkov wrote:
> On Thu, Sep 25, 2025 at 04:53:31PM +0200, Miquel Sabaté Solà wrote:
> > On 'btrfs_ioctl_qgroup_assign' we first duplicate the argument as
> > provided by the user, which is kfree'd in the end. But this was not the
> > case when allocating memory for 'prealloc'. In this case, if it somehow
> > failed, then the previous code would go directly into calling
> > 'mnt_drop_write_file', without freeing the string duplicated from the
> > user space.
> > 
> > Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
> 
> LGTM, thanks for the fix!
> 
> One thing though: I don't like the label names. I think with multiple
> cleanups the best way is to name each label with the cleanup it is for.
> Once you have some named ones, "out" feels unspecific, and encoding
> every single action like "out_sa_drop_write" doesn't scale as you add
> more cleanups, so it's just not a useful pattern. It's already quite
> clunky with just two.

The patch is adding a new label and it follows the pattern we use
elsewhere, with "out_<what>" pattern. The standalone 'out' is there and
I agree it should be named like 'out_free_prealloc' or such but it's in
the original code and it's been there for a long time. Cleaning that up
is for another patch.

