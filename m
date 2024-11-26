Return-Path: <linux-btrfs+bounces-9920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F89D9B57
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2D9163E11
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 16:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A971DA112;
	Tue, 26 Nov 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eWqNYyrS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZuA+4uGY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eWqNYyrS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZuA+4uGY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932571D9A41
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638247; cv=none; b=arm2TCE6H9ESAyxytSsiugTu4tDaxz1K0xPpstvtAv9G00+qiie4pDngcb3FaPx3aoaztJfeknXBMosEdPzKUnOr0QHK5lUgWNiJpLdecCEAQdJ+RV5fVT9Mds6bRFVXwR2yk1Lyq/De8I/RJw6tkIHuHmBfbjCqr0HhHxUeS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638247; c=relaxed/simple;
	bh=GOJKLlLUw5Y+CPxQP7IBKM0WmwxqKL1D0ctk/hAdHjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV4/VefS0Zzd13JG6M0Jj9FcLU6aLvtUP0vXp/DmLZ4AOKOFi2q65VlvUWadvun+qS/FceRSeFjTqHDpR9G7fevEY3OU48JCXQf3sKOk6/e0Pppn3V4ZypHlcNJGWpTYVmQzEV8pDzKWy99tzzvo9kao1mYVHpyLXLJPmnCD7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eWqNYyrS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZuA+4uGY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eWqNYyrS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZuA+4uGY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC28D2115E;
	Tue, 26 Nov 2024 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732638243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWmWPGH6ouotSFOjlPtAPz7Oh4NOAMzdgCeLxdfVSzc=;
	b=eWqNYyrSQ0nqiVSET0Hkn7tQkeHdEUtb6/amEyOkPj9FN3kduxJkbGlY1U4IB+IaiIQGrR
	qxQCh2drc0AruPYszqt7Ze3kNWW2CxZfI+oYAe8oK+6MWcwo/pZqb4h5akzAYGYcIoxQk8
	pmCh6PYDZpUDoLnZRD15I46dYsz8f48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732638243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWmWPGH6ouotSFOjlPtAPz7Oh4NOAMzdgCeLxdfVSzc=;
	b=ZuA+4uGYHITb/KYSkwxWEKIEuYDFiwugC7bQAodPe8a9fdOPqRmpgtLpPDthOVn9zIB+WA
	pTNJuKNUo1lOjtCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eWqNYyrS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZuA+4uGY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732638243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWmWPGH6ouotSFOjlPtAPz7Oh4NOAMzdgCeLxdfVSzc=;
	b=eWqNYyrSQ0nqiVSET0Hkn7tQkeHdEUtb6/amEyOkPj9FN3kduxJkbGlY1U4IB+IaiIQGrR
	qxQCh2drc0AruPYszqt7Ze3kNWW2CxZfI+oYAe8oK+6MWcwo/pZqb4h5akzAYGYcIoxQk8
	pmCh6PYDZpUDoLnZRD15I46dYsz8f48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732638243;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWmWPGH6ouotSFOjlPtAPz7Oh4NOAMzdgCeLxdfVSzc=;
	b=ZuA+4uGYHITb/KYSkwxWEKIEuYDFiwugC7bQAodPe8a9fdOPqRmpgtLpPDthOVn9zIB+WA
	pTNJuKNUo1lOjtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EC06139AA;
	Tue, 26 Nov 2024 16:24:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ldNRJiP2RWcjIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Nov 2024 16:24:03 +0000
Date: Tue, 26 Nov 2024 17:23:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: dsterba@suse.cz, ebiggers@kernel.org, fsverity@lists.linux.dev,
	linux-btrfs@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] btrfs: add FS_IOC_READ_VERITY_METADATA ioctl
Message-ID: <20241126162358.GL31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241126151123.GF31418@twin.jikos.cz>
 <20241126152331.90434-1-allison.karlitskaya@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126152331.90434-1-allison.karlitskaya@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: BC28D2115E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Nov 26, 2024 at 04:23:31PM +0100, Allison Karlitskaya wrote:
> 146054090b085 introduced fs-verity support for btrfs, but didn't add

Please use full reference of commits with the subject lines, like
146054090b08 ("btrfs: initial fsverity support")

The git alias command for that is below, you can name it like you want:

	show -s --pretty='format:%h (\"%s\")'

> support for FS_IOC_READ_VERITY_METADATA to directly query the Merkle
> tree, descriptor and signature blocks for fs-verity enabled files.
> 
> Add the (trival) implementation: we just need to wire it through to the
> fs-verity code, the same way as is done in the other two filesystems
> which support this ioctl (ext4, f2fs). The fs-verity code already has
> access to the required data.
> 
> Signed-off-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>

Added to for-next, thanks.

