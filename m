Return-Path: <linux-btrfs+bounces-11043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6699A19512
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 16:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DC716559D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0927338DF9;
	Wed, 22 Jan 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjQ3V7YA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T9OOCRLG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VjQ3V7YA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T9OOCRLG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F4214205
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559407; cv=none; b=oIMPYj6ZvC4jmojmBt768H7M1sanAEQ0AiQpBFDvWQOKdUUnKbHiMiQFkBFfByH2btajY47Kx1SQu0ALTX6mvMvybFqxfr0cNe5FC4tP199awhurDPs0OWZBnJokYjyEc5Odq90EwXpS7wbTdM3VfuVcxZVBX2eHVBAhTeAMjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559407; c=relaxed/simple;
	bh=mQsn87RjA27lTIrU2E3yPyV3Li+KHDR3AHaSRy1xpv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFihMrWpbIwucCUGeQCVLkAor1YYVAS1CKILIuWDChqan2GxQWfW0CE5mw8ZxhEyR3D4WBNt7UivViNFPBj1nVmJIIkc3QWuHYjTLI3v2mHIAJHSA1Pee7iZM2c+3TS8d7UrWu/De7OcFCgyUc3SF20CfBDRZrMnQGUyMtAFXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjQ3V7YA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T9OOCRLG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VjQ3V7YA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T9OOCRLG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6177B1F7EF;
	Wed, 22 Jan 2025 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737559403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQsn87RjA27lTIrU2E3yPyV3Li+KHDR3AHaSRy1xpv4=;
	b=VjQ3V7YAvJh/P6t+I5k3d11aSECsvA+cV+nVIbGZHVY5QyQN8vicyTI3Jlm0P4zM4mSTtX
	hl/xik/PGjsVMHyKoi07xEbLuSbd/DhCs/u1IEw/MVy5dDH/Dta/ihpIb4UOka9EO7blSc
	7hF7kKP3yvUh5zAaVVrewF0kWUmObg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737559403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQsn87RjA27lTIrU2E3yPyV3Li+KHDR3AHaSRy1xpv4=;
	b=T9OOCRLGTnw4UNu3nEsAcqWEqb6tKIoe5vUYeZhldW8f3hIL1GrhwTel8Ni4tDS2HwrcTX
	r51cXkCp2C4HyxBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VjQ3V7YA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T9OOCRLG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737559403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQsn87RjA27lTIrU2E3yPyV3Li+KHDR3AHaSRy1xpv4=;
	b=VjQ3V7YAvJh/P6t+I5k3d11aSECsvA+cV+nVIbGZHVY5QyQN8vicyTI3Jlm0P4zM4mSTtX
	hl/xik/PGjsVMHyKoi07xEbLuSbd/DhCs/u1IEw/MVy5dDH/Dta/ihpIb4UOka9EO7blSc
	7hF7kKP3yvUh5zAaVVrewF0kWUmObg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737559403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQsn87RjA27lTIrU2E3yPyV3Li+KHDR3AHaSRy1xpv4=;
	b=T9OOCRLGTnw4UNu3nEsAcqWEqb6tKIoe5vUYeZhldW8f3hIL1GrhwTel8Ni4tDS2HwrcTX
	r51cXkCp2C4HyxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 504E91397D;
	Wed, 22 Jan 2025 15:23:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9EliE2sNkWdNWQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Jan 2025 15:23:23 +0000
Date: Wed, 22 Jan 2025 16:23:21 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
Message-ID: <20250122152321.GI5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250121183751.201556-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121183751.201556-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6177B1F7EF
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
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Jan 21, 2025 at 06:36:53PM +0000, Mark Harmstone wrote:
> For O_DIRECT reads and writes, both the buffer address and the file offset
> need to be aligned to the block size. Otherwise, btrfs falls back to
> doing buffered I/O, which is probably not what you want. It also creates
> portability issues, as not all filesystems do this.

One thing is to track io stats, we can probably do that in general. The
buffered fallback of misaligned direct io has been with us for ages.
That the fallback is silent (and what we want) is intentional as it
makes direct io work on compressed files.

So you may be specifically interested in catching the misaligned dio
requests.

> Add a new sysfs entry io_stats, to record how many times DIO falls back
> to doing buffered I/O. The intention is that once this is recorded, we
> can investigate the programs running on any machine where this isn't 0.

Tracking just one number per whole filesystem seems quite limited in
narrowing down the problem to an application. With compression enabled,
anywhere in the filesystem and then doing a direct io will make it hard.
I think you'll get more exact results by a targeted tool, BPF based or
such.

