Return-Path: <linux-btrfs+bounces-16020-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE6B225E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 13:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BF216D588
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516472EA162;
	Tue, 12 Aug 2025 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9tOo/PK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JPRo6Jfd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g9tOo/PK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JPRo6Jfd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391312857DF
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Aug 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998313; cv=none; b=iwFx4aDLSXBz/bJrWhX+0uSrl2/Kocg0Qz/GuikooAUC0wOu+epYPH7JmQD6gW77DYwNNeKHym1gkTdTASGg2iseUwwymIDn3tCDrdd8ZKOfXrYjk/sbMljk3DAm3/oY4X0lf/XRSlSfmpBj9QH0SSPfkM3w2i6jDDvGnv+hFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998313; c=relaxed/simple;
	bh=I71Z7l0nFSxiv5eDZJVoB+QuPooCxPdTisct3Knpid8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I10DyxxWA7hQe9QDANOtqjkdSgh3pYWUVdDzI4pAa0piImMJICii1DFHBa/CiaX+ysx2/+0P2OvGaL/km2YM28EQ6CFyA/pHFjyhfg0ejumf2aKraRG8Sd8xHLFcSue3UvAhrtbXaeQAAXCajF+Cgp4/n9cz9EjOk1Xt4X4AYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9tOo/PK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JPRo6Jfd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g9tOo/PK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JPRo6Jfd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4600921B94;
	Tue, 12 Aug 2025 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754998310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyHkQ5ebqDjNh/UaaXjQYZ/oPtiUyQHec4dnFAgOBJM=;
	b=g9tOo/PKblWq8NmWGa/JtUB7e1khasAW1vqKnvfqaN0SEzlDiAPkqdU2U1QYQQh6LJiUCU
	BbEX79xRZpVkQqTc7quWvHats1fXMYYsyFVe+Q0NXQpQfLEzKwn144gxysdFMDAVr1v9FJ
	lzM5H24zxQF7+0iPMxnDFcGrAcJkGdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754998310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyHkQ5ebqDjNh/UaaXjQYZ/oPtiUyQHec4dnFAgOBJM=;
	b=JPRo6JfdWsicFKm0DSVOjR46JW4MO1vqNxGGp6tbe/yv+QBnN3dFgbQAOSyE2Y8l2h8+G4
	LrZIvHpqvzdGvOBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754998310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyHkQ5ebqDjNh/UaaXjQYZ/oPtiUyQHec4dnFAgOBJM=;
	b=g9tOo/PKblWq8NmWGa/JtUB7e1khasAW1vqKnvfqaN0SEzlDiAPkqdU2U1QYQQh6LJiUCU
	BbEX79xRZpVkQqTc7quWvHats1fXMYYsyFVe+Q0NXQpQfLEzKwn144gxysdFMDAVr1v9FJ
	lzM5H24zxQF7+0iPMxnDFcGrAcJkGdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754998310;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyHkQ5ebqDjNh/UaaXjQYZ/oPtiUyQHec4dnFAgOBJM=;
	b=JPRo6JfdWsicFKm0DSVOjR46JW4MO1vqNxGGp6tbe/yv+QBnN3dFgbQAOSyE2Y8l2h8+G4
	LrZIvHpqvzdGvOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31777136C7;
	Tue, 12 Aug 2025 11:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sW+rCyYmm2jzGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 12 Aug 2025 11:31:50 +0000
Date: Tue, 12 Aug 2025 13:31:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Kyoji Ogasawara <sawara04.o@gmail.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, brauner@kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: restore mount option info messages during mount
Message-ID: <20250812113149.GC5507@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250728020719.37318-1-sawara04.o@gmail.com>
 <20250808145640.GT6704@twin.jikos.cz>
 <CAKNDObASx8Nqd85AfzbEyMAC8XubHjcgZMzDbJyC_snYV-TJpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKNDObASx8Nqd85AfzbEyMAC8XubHjcgZMzDbJyC_snYV-TJpQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.50

On Mon, Aug 11, 2025 at 05:08:39PM +0900, Kyoji Ogasawara wrote:
> > > @@ -1428,7 +1430,6 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
> > >  {
> > >       btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> > >       btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
> > > -     btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> >
> > Shouldn't this rather be NODATACOW? The logic around the option is the
> > same as for NODATASUM, but for some reason NODATACOW is under
> > btrfs_info_if_unset() call.
> >
> > >       btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
> > >       btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
> > >       btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
> > > --
> > > 2.50.1
> > >
> 
> Thank you for your suggestion.
> I'll update the code to handle NODATASUM similarly to NODATACOW.
> 
> =====
> btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
> btrfs_info_if_set(info, old, NODATACOW, "setting nodatacow");
> ...
> btrfs_info_if_unset(info, old, NODATASUM, "setting datasum");
> btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
> =====
> 
> Let me know if there's anything else I should consider.

I haven't seen other problems in the mount options. Please send the
fixes as separate patches. Thanks.

