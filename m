Return-Path: <linux-btrfs+bounces-5444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E88FB70C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65C41C22505
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F848143C76;
	Tue,  4 Jun 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GbJS1Z6R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gyGemsSQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zczugT9m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYC4IgMz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD334143C49;
	Tue,  4 Jun 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514881; cv=none; b=OjzXHbk7G4nMW6Bec+IEdVIRD3aPeLdZI1jmRKgT7LrU9yG6acdvQ1978jMcWjzC8AsMPdqXEvLfCoQkf+TQkZShwamqze6d1QhuF03Xf5OvHOv3mzhR5IyXu/2d+Y4L0+BavTTCaAZzrJy68eKMhfiFlvqtUn0xiaHRh+Pfiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514881; c=relaxed/simple;
	bh=7InPF3dhmXGJBJvYqqQdc55DRAfBmvll4gL/tQKL3io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wm4lBYrW1QXy2WZollRUTW9FrsGK8sHnWhT2H7mC1AIl/yPRCLneBbGAcqZ2N3tNZG8jSY+XAniiu/WdEU1AtEO4Btfc4HQ754VVUWxXCc5ko6NWer0fXYb9DVhYYd4W0oiIHOQr+Q9L23LMmT7VxdhdCgKMNcv9UX96eTqrhso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GbJS1Z6R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gyGemsSQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zczugT9m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYC4IgMz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EED3D1F7FE;
	Tue,  4 Jun 2024 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717514878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPysgDGGnrs/I15i7JwpcikL92nmUShWXX6b4akW3GY=;
	b=GbJS1Z6RZt2A4fQfsnbd00Pb6Azl5E8jdjxq//miTNgXBDe92xND8igIjNcLAc4Rhv9DQc
	mtWOBSRVbLJ8m55VoSMGYWe5irHR3Eb5slmF/Bk8Cl6Lz0FvTC9czEGg8YfUpCGDCgLCHh
	Qskcc0Y8EeIwx490LeAHkVTmWO/aw0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717514878;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPysgDGGnrs/I15i7JwpcikL92nmUShWXX6b4akW3GY=;
	b=gyGemsSQQvucHDNXGS7TJbUcSbFalFib2evD2nBQw3TC8C39Cw8HD9dEXZncrgm91xb2Ap
	qun87sr6JXwABzDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717514877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPysgDGGnrs/I15i7JwpcikL92nmUShWXX6b4akW3GY=;
	b=zczugT9mcNLDbgGyIb5AoH4zVR89vBv1f0USwf6sRamqJWNsPMbDQYTPbLgbz+91of5Vux
	W5A2OvpfSbCrrDGXY+Q0PHLOp96NxNi3onfqa0JGgUwmCNptL+HZhIYIK4f4LJ1Jp3VPeu
	mfs33xLYZV9ScZqkDYp/9w1I6i7S0Fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717514877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xPysgDGGnrs/I15i7JwpcikL92nmUShWXX6b4akW3GY=;
	b=WYC4IgMz6II6R4Q3O4oYp2UW+RGqoQqFLWutzYnmYURgM9z3uejgQJH6WDARTmcsS6uMbb
	vLpyo7TF86ED6uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D20EF13A93;
	Tue,  4 Jun 2024 15:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w5PMMn0yX2b/JAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 04 Jun 2024 15:27:57 +0000
Date: Tue, 4 Jun 2024 17:27:56 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix raid-stripe-tree tests with non-experimental
 btrfs-progs build
Message-ID: <20240604152756.GF12376@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <95d9d97299aa1149da63566d57ef4ee673127cec.1717503211.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d9d97299aa1149da63566d57ef4ee673127cec.1717503211.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Jun 04, 2024 at 01:14:48PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When running the raid-stripe-tree tests with a btrfs-progs version that
> was not configured with the experimental features, the tests fail because
> they expect the dump tree commands to output the stored and calculated
> checksums lines, which are enabled only for experimental builds.
> 
> Also, these lines exists only starting with btrfs-progs v5.17 (more
> specifically since commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
> experimental, new option to switch csums")).
> 
> The tests fail like this on non-experimental btrfs-progs build:
> 
>    $ ./check btrfs/304
>    FSTYP         -- btrfs
>    PLATFORM      -- Linux/x86_64 debian0 6.9.0-btrfs-next-160+ #1 SMP PREEMPT_DYNAMIC Tue May 28 12:00:03 WEST 2024
>    MKFS_OPTIONS  -- /dev/sdc
>    MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>    btrfs/304 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad)
>        --- tests/btrfs/304.out	2024-01-25 11:15:33.420769484 +0000
>        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad	2024-06-04 12:55:04.289903124 +0100
>        @@ -8,8 +8,6 @@
>         raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
>         leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
>         leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
>        -checksum stored <CHECKSUM>
>        -checksum calced <CHECKSUM>
>         fs uuid <UUID>
>         chunk uuid <UUID>
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/304.out /home/fdmanana/git/hub/xfstests/results//btrfs/304.out.bad'  to see the entire diff)
>    Ran: btrfs/304
>    Failures: btrfs/304
>    Failed 1 of 1 tests
> 
> So update _filter_stripe_tree() to remove the checksum lines, since we
> don't care about them, and change the golden output of the tests to not
> expect those lines. This way the tests work with both experimental and
> non-experimental btrfs-progs builds, as well as btrfs-progs versions below
> v5.17.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

In version 6.9 of btrfs-progs the messages will be printed only with
increased verbosity so we'll have same output for normal and
experimental build but it ideed needs to be removed from the golden
output.

