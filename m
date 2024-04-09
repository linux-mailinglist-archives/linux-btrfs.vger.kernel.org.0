Return-Path: <linux-btrfs+bounces-4052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFC89D7C3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 13:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBE9B23D63
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF5386242;
	Tue,  9 Apr 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hj/lgSxK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jF5VPWyf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AVJ5pYWa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Qd3MePn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A385954;
	Tue,  9 Apr 2024 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661648; cv=none; b=BXZgb1q66ekpX4dGRjcLQIZ781zcfxZMcGM5vOTUbIJlxX1kgw5yDdLoghsLq2fAR+w/AtLJ7Bq/kIbXVhFKqSI8yVNXr8WdCYE0Wesxb5VQkikMMkAk8a5krYAzNDo2oKGWFTRD17TULrkBVa4dcI2GcF9j9FcU6MEhWhJC+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661648; c=relaxed/simple;
	bh=8e5KM7LDCGv6Vaf2cfnG/O4ResxMWjR4xqsf8dTep2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh5wyBWmXJ8dKuoQQhftlxKUcQ2I8pkH4kI3eX0Oagar7m2i3zn5wMPfO121Xh3HriJKDItuV+XaloHKllYDNals2mFj8Teuc87bO5Pe5x6V23HSa0XnVgQwaab6Ek6tyUvqWMQSnQiy7sGMMuJH/H6MDSvaeJo24YLPcQcx/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hj/lgSxK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jF5VPWyf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AVJ5pYWa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Qd3MePn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E140B20963;
	Tue,  9 Apr 2024 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712661645;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LodrMtaby7zow8S0/Shuk8HHX1B0xsGoQLnrgz0bWc=;
	b=hj/lgSxKrXPUl6CQFMH5SlnNrj6jcEFltdKHbJpE6tuyeFvyoT2Nt1I5fsPmZTAJQ3PDif
	LpSh6LOXSp8vUubMyVoLUfWk5tBk6erPI7LpNfzpYhHkPR5VAJtegA/gCDKINIaQ05KHVP
	xVW0NF8UK8SWFSsx2TAre4fMbBUm0g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712661645;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LodrMtaby7zow8S0/Shuk8HHX1B0xsGoQLnrgz0bWc=;
	b=jF5VPWyfUa9z4Gj8pD9EhZMtSyHOMlA0JbyTCcCwTIH1gm16QkB2MCZ3AzLaNPI/N5kllY
	egV02+u1fl+ghhDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AVJ5pYWa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0Qd3MePn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712661644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LodrMtaby7zow8S0/Shuk8HHX1B0xsGoQLnrgz0bWc=;
	b=AVJ5pYWaSPOv362zqXtInTxWk5erJsgXlnd/9Rb/g1jn9zBD4R8iGSyXKUtFuIajRP8G8H
	o4Ye+RFhp2KJ11Y0QuWW1S5DIQ5PLkm24UXUmsK8SYyHk2KSvaoGKeiRAMlqZ3u2Lzg2S6
	TNqrDsTv9BgrHS4YCabduIlm4LwTKfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712661644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LodrMtaby7zow8S0/Shuk8HHX1B0xsGoQLnrgz0bWc=;
	b=0Qd3MePnhxQxVJIQBcFPMfITSd3pGHaAvJS9PBT8smIrdNMwQCHu7tgKwlIuvl3UhrW9j8
	1DaQhX3aATzROkAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C50391332F;
	Tue,  9 Apr 2024 11:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id amHxL4wkFWY6XwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 11:20:44 +0000
Date: Tue, 9 Apr 2024 13:13:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
Message-ID: <20240409111319.GA3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E140B20963
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon, Apr 08, 2024 at 12:46:18PM +0800, Anand Jain wrote:
> On 4/6/24 13:18, Qu Wenruo wrote:
> > [BUG]
> > All the touched test cases would fail after btrfs-progs commit
> > 5f87b467a9e7 ("btrfs-progs: subvolume: output the prompt line only when
> > the ioctl succeeded") due to golden output mismatch.
> > 
> > [CAUSE]
> > Although the patch I sent to the mail list doesn't change the output at
> > all but only a timing change, David uses this patch to unify the output
> > of "btrfs subvolume create" and "btrfs subvolume snapshot".
> > 
> > Unfortunately this changes the output and causes mismatch with
> > golden output.
> > 
> > [FIX]
> > Just redirect stdout of "btrfs subvolume snapshot" to $seqres.full.
> > Any error from "btrfs subvolume" subgroup would lead to error messages
> > into stderr, and cause golden output mismatch.
> > 
> > This can be comprehensively greped by
> > 'grep -IR "Create a" tests/btrfs/*.out' command.
> > 
> > In fact, we have around 274 "btrfs subvolume snapshot|create" calls in the
> > existing test cases, meanwhile only around 61 calls are populating
> > golden output (22 for subvolume creation, and 39 for snapshot creation).
> > 
> > Thus majority of the snapshot/subvolume creation is not populating
> > golden output already.
> > 
> 
> While golden output is better verification method in terms of
> accuracy, but, it falls short in verifying command exit codes.
> I personally think the run_btrfs_progs approach is better for
> 'btrfs subvolume snapshot'. It allows us to verify the command
> status without relying on the stdout.
> But, past discussions favored the golden output verification
> method instead of run_btrfs_progs.

I thought the whole point here was to depart from the golden output, at
least in selected cases, and only in btrfs/ subdirectory so it does not
accidentally break other filesystems' testing.

What past discussions favored does not seem to satisfy our needs and as
btrfs-progs are evolving we're hitting random test breakage just because
some message has changed. The testsuite should verify what matters, ie.
return code, state of the filesystem etc, not exact command output.
There's high correlation between output and correctness, yes, but this
is too fragile.

