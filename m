Return-Path: <linux-btrfs+bounces-6913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBC294329B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 17:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE37283872
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34523101EE;
	Wed, 31 Jul 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z546KCil";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZPB5WGq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z546KCil";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iZPB5WGq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567681FB4
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438121; cv=none; b=u80NeCoau0gSbpLYYWmjIF/qCKmhNA2cWE4mFomVmP7sKWKVmqfDzL3vxjOba1uIFshTS/8vc7V4jIc3OLs06iCMtZnqCCQIu4b5/F2l/WAWtGgTm9j5dc1XYMkmeDlnX+xH5QsmsXFzgrJ+wduKCIfvYLGGzGY4CCJMv9zTuq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438121; c=relaxed/simple;
	bh=dh/js2mg0X5J5qIvv96vLRks1mC+kYw6B/SZ1ok90vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCCwS7EYcK9VAHFiBTqBMKMKxjd2DEGuCLUWQfpzIPue5VCfrqUSrr914xQSZQgwg9rl9cR+LpYjUVJ+Esn0RkkDCOajlQZ17eaePSmQ5Hu1s+gRo7oARbEo5Y3EvukkgtKOFcvClKirQ7zx/mqYysQ08hiCuy2GpFotUbxiBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z546KCil; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iZPB5WGq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z546KCil; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iZPB5WGq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA11B1F849;
	Wed, 31 Jul 2024 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722438109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBM4t9V/t7HLPurJsM5kKAtWIhdECsTjdo3b+a/BZwU=;
	b=z546KCilNsT9EyJ1uN+0gVvT5HetfCjd8G1I2Zv8hkrM2/YxrkVYXsT20D1qkr2pueMmtE
	N+LUmfgh/2WtnamTgYi1yKAzYAwjZU5AqzyFr9i5n3GrxadLc89omvNl3gaXSJ/9s7l2Vt
	ybOnP5TnOO2MDFw6Ca/p02tt62DjBJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722438109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBM4t9V/t7HLPurJsM5kKAtWIhdECsTjdo3b+a/BZwU=;
	b=iZPB5WGqS/dbBeMHkfrql1Sw7rFQQWOJiNyaJSoWf98oxPCMBeFNR9Mh1TyEubLrS+UoBH
	aWVeWrWUT0H+liDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722438109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBM4t9V/t7HLPurJsM5kKAtWIhdECsTjdo3b+a/BZwU=;
	b=z546KCilNsT9EyJ1uN+0gVvT5HetfCjd8G1I2Zv8hkrM2/YxrkVYXsT20D1qkr2pueMmtE
	N+LUmfgh/2WtnamTgYi1yKAzYAwjZU5AqzyFr9i5n3GrxadLc89omvNl3gaXSJ/9s7l2Vt
	ybOnP5TnOO2MDFw6Ca/p02tt62DjBJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722438109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBM4t9V/t7HLPurJsM5kKAtWIhdECsTjdo3b+a/BZwU=;
	b=iZPB5WGqS/dbBeMHkfrql1Sw7rFQQWOJiNyaJSoWf98oxPCMBeFNR9Mh1TyEubLrS+UoBH
	aWVeWrWUT0H+liDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9ECE513297;
	Wed, 31 Jul 2024 15:01:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NAR/Jt1RqmaMfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jul 2024 15:01:49 +0000
Date: Wed, 31 Jul 2024 17:01:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Neal Gompa <neal@gompa.dev>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: emit a warning about space cache v1 being
 deprecated
Message-ID: <20240731150148.GQ17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <51e96d7a2754991bc369065d74290e7a436934c7.1722358018.git.josef@toxicpanda.com>
 <CAEg-Je8a+_GnkxKHG2zmhHrofsV2nsM7ubq0xGtjuNj7Jen_Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je8a+_GnkxKHG2zmhHrofsV2nsM7ubq0xGtjuNj7Jen_Hw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue, Jul 30, 2024 at 11:08:10PM -0400, Neal Gompa wrote:
> On Tue, Jul 30, 2024 at 12:47 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > We've been wanting to get rid of this for a while, add a message to
> > indicate that this feature is going away and when so we can finally have
> > a date when we're going to remove it.  The output looks like this
> >
> > BTRFS warning (device nvme0n1): space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2
> >
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v1->v2:
> > - Made it all one line as per Dave's comment.
> >
> >  fs/btrfs/super.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 0eda8c21d861..1eed1a42db22 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -682,8 +682,11 @@ bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_
> >                 ret = false;
> >
> >         if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
> > -               if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE))
> > +               if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
> >                         btrfs_info(info, "disk space caching is enabled");
> > +                       btrfs_warn(info,
> > +"space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2");
> > +               }
> >                 if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
> >                         btrfs_info(info, "using free-space-tree");
> >         }
> > --
> > 2.43.0
> >
> >
> 
> Do we want to declare specifically when we'll get rid of this?
> Otherwise this looks good to me.

It would be better yes but we should time it to be in the upcoming LTS
release so it keeps maximum compatibility. Also we need some time to
make the change visible in a released kernel. ETA is January 2025 so
closest match is 6.14 without v1.

If there's a strong technical reason for dropping it earlier we might do
that.  The conversion to folio API is progressing and we don't want to
port code-to-be-deleted to new API.

