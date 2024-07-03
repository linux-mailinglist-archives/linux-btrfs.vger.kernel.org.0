Return-Path: <linux-btrfs+bounces-6184-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C850D926C60
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 01:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17637B2207A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC419005D;
	Wed,  3 Jul 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5BrAxiU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2e2J9wj0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P5BrAxiU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2e2J9wj0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04622136643
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720048846; cv=none; b=ecLJl2MffcZQGmlQ0fAE1HeO0GCBXyqw2kvKz5/WDa4knkUU76DbpjaixgnJ5XGtyfehTpy95co63D0Y+EDJpUc1UGbWEKKmGwEK+HsURbaV15Q3l+Zt+h8XY6u+crZzXpxH1CKihtJyKEVh3v+UvfnQ6CaQ+dN+Hy25d6GwTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720048846; c=relaxed/simple;
	bh=XrggcPOsCMynOR+UcoWb2Pm+3bnXFSpPAg4+C/1ahuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaokxFfFWk+70xD05i9cTEgz44bDcOxdAr3KidKcJo3ha01FG26W1k4tpwFjw7Ea9j0vtauIpXDQioO8YXdvKWcQ8aLo71ga2FWqFKHd72jwRaGUs7jySmL9Wuf7aOl6E0cpHTegDieE2FI9I4y7S/VG1C61GQyHBBSVJ2FLCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5BrAxiU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2e2J9wj0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P5BrAxiU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2e2J9wj0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2914C1F37E;
	Wed,  3 Jul 2024 23:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720048843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrggcPOsCMynOR+UcoWb2Pm+3bnXFSpPAg4+C/1ahuc=;
	b=P5BrAxiUsGyB1TZWyEqdVGFgtMUW9eBWLwEtcRFrUisNMN54A6y2UchQFN9n0/xBxx/yK7
	pP9qtrbgLDhNDzkFYs1Dzo4fhjcctMUdCCm3Wh4hcEVyo+CCFEQJKRYQEsHAPRvlOWPwnv
	V05GLqDX2aFhBaYd41sKsuM6aPqazpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720048843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrggcPOsCMynOR+UcoWb2Pm+3bnXFSpPAg4+C/1ahuc=;
	b=2e2J9wj0VG0RkXCRF93CgzZGX9HXrAMqn25KLO0nv0XiOlvQU+rZyUIWNfGMwb1XsbKJ7R
	sYoTYKLqGiDgLSDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720048843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrggcPOsCMynOR+UcoWb2Pm+3bnXFSpPAg4+C/1ahuc=;
	b=P5BrAxiUsGyB1TZWyEqdVGFgtMUW9eBWLwEtcRFrUisNMN54A6y2UchQFN9n0/xBxx/yK7
	pP9qtrbgLDhNDzkFYs1Dzo4fhjcctMUdCCm3Wh4hcEVyo+CCFEQJKRYQEsHAPRvlOWPwnv
	V05GLqDX2aFhBaYd41sKsuM6aPqazpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720048843;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XrggcPOsCMynOR+UcoWb2Pm+3bnXFSpPAg4+C/1ahuc=;
	b=2e2J9wj0VG0RkXCRF93CgzZGX9HXrAMqn25KLO0nv0XiOlvQU+rZyUIWNfGMwb1XsbKJ7R
	sYoTYKLqGiDgLSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 110AA13974;
	Wed,  3 Jul 2024 23:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x9tlA8vchWbrRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 03 Jul 2024 23:20:43 +0000
Date: Thu, 4 Jul 2024 01:20:33 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: receive: retry encoded_write on EPERM
Message-ID: <20240703232033.GS21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8c2e537199608a446d5f97ea0dda319d2b9c0dad.1719937610.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2e537199608a446d5f97ea0dda319d2b9c0dad.1719937610.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.94 / 50.00];
	BAYES_HAM(-2.94)[99.74%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -3.94
X-Spam-Level: 

On Tue, Jul 02, 2024 at 09:27:49AM -0700, Boris Burkov wrote:
> encoded_write fails if we run without CAP_SYS_ADMIN, but the decompress
> and write fallback could succeed if we are running with write
> permissions on the file. Therefore, it is helpful to fall back on EPERM
> as well. While this will increase the "silent failure" rate of encoded
> writes, we do have the verbose log in place to debug that while setting
> up a receive workflow that expects encoded_write.

I'm not sure this is good to have the fallback by default. There's
option --force-decompress so it needs to be user's choice to avoid
encoded writes. Otherwise if I have a stream with encoded data and
receive it I expect to be as close to the original as possible.

Once there's encryption implemented the fallback will interfere with
availability of the key.

The problem with automatic fallback is that it cannot be disabled and it
does not fail so user can't know that it's been silenly not encoded
written.

Whether a steram contains an encoded write cannot be known upfront, I
think we should add more options how to handle the encoded write.
Modes like 'always', 'fallback'.

The code change itself is simple, this is about defining the expected
use cases.

