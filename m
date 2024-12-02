Return-Path: <linux-btrfs+bounces-10011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5DC9E0657
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F54161D47
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83D20B801;
	Mon,  2 Dec 2024 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KpFaafg+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5kpP1mo6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KpFaafg+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5kpP1mo6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142E207A2D
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Dec 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150541; cv=none; b=QuW5w6H++FumVpDUvIGhot4rKLbIaGz0cWh6HWjoisLVc9FGlM6YArEXrJJF7boVJAzK2Iynb3N4P50PvAILlnHrSJky62z5TlzoME+LCqi4dIwEcIchEpxJ15SPI8CMlRTl3KU03ZbXEM7ra1Vf3hE/W7G8d9omNb+NoPEeSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150541; c=relaxed/simple;
	bh=g4gyYo4AIRU57Z6tbOXgvIU64xJlv/XRRWAUny1GZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxBY7vQZ0QzXPhSbgF5KpfD7hB4saAxD5iFFAUXOWXlBXxd8FKOpTrtbMCztDS1zNJ9kqZP9gRRvOe6ydt+4PtuWCUJquGvJPug+cbLZKK6u7OMqBlU2yep4D+h0SqJvH9z8nQ2uH+giSsiVXgeEnCaavCcHf9yAodfmOsYFUzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KpFaafg+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5kpP1mo6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KpFaafg+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5kpP1mo6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 164241F396;
	Mon,  2 Dec 2024 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733150538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
	b=KpFaafg+kPqnvpVh3YHkQdmaQlw+XGNIBssAslzy3A8aEHqrIISlTF1ehOUUwRU1aN+t9H
	h/jKCwRJyAHmgpCp4eCq9qNN1HL9ZUW0NlF7NLFMaIpkWxPHktfTjR2cFfC3b37qkpvaMe
	dqxFqsA5QKmD23bZwoX63bX5K1bCPHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733150538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
	b=5kpP1mo6qR13rjIEpR1gz8Hba6B7PYLeVBnFz5D6C0ORfoKQJulp6MsFe2XwoRvQbFEx/m
	2ZJHvhqrLKcrkoCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733150538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
	b=KpFaafg+kPqnvpVh3YHkQdmaQlw+XGNIBssAslzy3A8aEHqrIISlTF1ehOUUwRU1aN+t9H
	h/jKCwRJyAHmgpCp4eCq9qNN1HL9ZUW0NlF7NLFMaIpkWxPHktfTjR2cFfC3b37qkpvaMe
	dqxFqsA5QKmD23bZwoX63bX5K1bCPHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733150538;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yjBxfqO/ySVLd4QZxyp/PzwWoLWjLSKlZI5j2GSBajo=;
	b=5kpP1mo6qR13rjIEpR1gz8Hba6B7PYLeVBnFz5D6C0ORfoKQJulp6MsFe2XwoRvQbFEx/m
	2ZJHvhqrLKcrkoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E217313A31;
	Mon,  2 Dec 2024 14:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 50TsNUnHTWdKIwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 02 Dec 2024 14:42:17 +0000
Date: Mon, 2 Dec 2024 15:42:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Zorro Lang <zlang@kernel.org>, ltp@lists.linux.it,
	linux-btrfs@vger.kernel.org
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
Message-ID: <20241202144208.GB321427@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan>
 <Z029S0wgjrsv9qHL@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z029S0wgjrsv9qHL@yuki.lan>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

> Hi!
> > The code to skip filesystems in the case of all filesystems is in the
> > run_tcase_per_fs() function:

> > static int run_tcases_per_fs(void)
> > {
> >         int ret = 0;
> >         unsigned int i;
> >         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);

> > The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> > function which filters out them.

> Perhaps you mean that the skiplist does not work with .all_filesystems
> _and_ the LTP_SINGLE_FS_TYPE environment variable?

> I guess that we need:

> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index bbbb8df19..49b1d7205 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)

>         if (only_fs) {
>                 tst_res(TINFO, "WARNING: testing only %s", only_fs);
> +
> +               if (tst_fs_in_skiplist(only_fs, skiplist))
> +                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
> +

It's a nice feature to be able to force testing on filesystem even it's set to
be skipped without need to manually enable the filesystem and recompile.
(It helps testing with LTP compiled as a package without need to compile LTP.)
Therefore I would avoid this.

@Zorro Lang or are you testing whole syscalls on particular filesystem via
LTP_SINGLE_FS_TYPE=xfs ?

Kind regards,
Petr

>                 if (tst_fs_is_supported(only_fs))
>                         fs_types[0] = only_fs;
>                 return fs_types;

