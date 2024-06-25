Return-Path: <linux-btrfs+bounces-5961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2192B916D2F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448F01C20A0A
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A916F84A;
	Tue, 25 Jun 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bkbRHwq3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sWv126Ci";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ePW9ev7i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jar1394K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271116D4D7
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329683; cv=none; b=o8AHRllYbqJ9v9Kfd1QFPO+rBHwseAeFME8SSxd7lJBFNpyOOgMfPZJT4Cit3X+yXBiOQCw/pT4nXfLcNG0V8XC3uT1uAAFQ5jsKovCn0ttDiMWrIuw3yiWheUsw3JMV3cYo5KnArTDKLYf8ulLhPmExRPUOS+/hyrCSMxoI1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329683; c=relaxed/simple;
	bh=K8TVJh6mXS64s1z6UNOermbvurTiNdPSqCzqrYVJaZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkdwLr4ZNFE4FaTrOZLUKaMai6YeYPeKwe+zSkrxZgwNuG/rUmFQhy1nGfLQHnwButyc8tKSlWLo9BYiVcypJetcY7V4/hMsGeT4emCxyDUwMbK6QCCRsCLZ23GRy4J9qmvXUeoVMMZa4l2UO3DmyaVsZWexZH6PUCexDYuFpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bkbRHwq3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sWv126Ci; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ePW9ev7i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jar1394K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D629C1F892;
	Tue, 25 Jun 2024 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719329680;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScdCVoJGB5r7kQGboFV+RaStvJH+wtwx24phR9gYpgI=;
	b=bkbRHwq3JkQfdu9Ynq0V7mSD6ozyYrkG8vdHEH0mQcPwRRRbW2dki03ML0NuSJXhBDRxtT
	Dl5yloZDfUAVrK5NX2KdA7XHJp52N3jTyZv2hWoTEFxThnj9nyokHxSlhOdDPTYkxuvPR0
	qFJtuPewdb4cBTMr2bxoArfURxf3VnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719329680;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScdCVoJGB5r7kQGboFV+RaStvJH+wtwx24phR9gYpgI=;
	b=sWv126CiWqZE+O/GyyTUKGmPHIUeuCAm0WuXlXSwHWpmz18loPYKu2JD+5wY8Prb0IxP5J
	zqQ3bt02zKhExiDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719329679;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScdCVoJGB5r7kQGboFV+RaStvJH+wtwx24phR9gYpgI=;
	b=ePW9ev7itAMA5w7SAH9wkE0MZg0yk2vq18AaHSudyuUZv6zgU5DSPNhUzgIkkdkvqop7vG
	yBSif4FJxB4L3cQ7qLTQxc38vECU+VO+5GiKu0fdPEi16+HGww2flq3MR2SauP8S4KKfHX
	DVZY7Igl3d+Zmc15GC+Dk369mQ01mzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719329679;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScdCVoJGB5r7kQGboFV+RaStvJH+wtwx24phR9gYpgI=;
	b=Jar1394KD3RcgePj/ywHroLpTmFo90sEs8YMM4K+ld0fuOBMBIjcyJgdnIUSMw43iokymb
	Fu2J0Xp7W3rcRcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEAC413A9A;
	Tue, 25 Jun 2024 15:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MDlVLo/jemZ9QQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 25 Jun 2024 15:34:39 +0000
Date: Tue, 25 Jun 2024 17:34:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/8] btrfs-progs: add subvol list options for sane path
 behavior
Message-ID: <20240625153438.GW25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718995160.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718995160.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Jun 21, 2024 at 11:53:29AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hello,
> 
> btrfs subvol list's path handling has been a constant source of
> confusion for users. None of -o, -a, or the default do what users
> expect. This has been broken for a decade; see [1].
> 
> This series adds two new options, -O and -A, which do what users
> actually want: list subvolumes below a path, or list all subvolumes,
> with minimal path shenanigans. This approach is conservative and tries
> to maintain backwards compatibility, but it's worth discussing whether
> we should instead fix the existing options/default, or more noisily
> deprecate the existing options.

I'm working on a replacement command of 'subvolume list', there seems to
be no other sane way around that. The command line options are indeed
confusing and the output is maybe easy to parse but not nice to read.
Changing meaning of the options would break too many things as everybody
got used to the bad UI and output.

We can add the two new options but I'd rather do that only in the new
command so we can let everybody migrate there.

> One additional benefit of this is that -O can be used by unprivileged
> users.

This should be the default (and is supposed to be in the new command).

> Patch 1 fixes a libbtrfsutil bug I encountered while testing this.
> Patches 2 and 3 fix libbtrfsutil's privilege checks to work in user
> namespaces. Patches 4 and 5 remove some unused subvol list code. Patch 6
> documents and tests the current, insane behavior. Patch 7 converts
> subvol list to use libbtrfsutil. This is a revival of one of my old
> patches [2], but is much easier now that libbtrfs has been pared down.
> Patch 8 adds the new options, including documentation and tests.
> 
> Thanks!
> Omar
> 
> 1: https://lore.kernel.org/all/bdd9af61-b408-c8d2-6697-84230b0bcf89@gmail.com/
> 2: https://lore.kernel.org/all/6492726d6e89bf792627e4431f7ba7691f09c3d2.1518720598.git.osandov@fb.com/
> 
> Omar Sandoval (8):
>   libbtrfsutil: fix accidentally closing fd passed to subvolume iterator

I've picked this patch now as it's a fix.

