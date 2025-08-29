Return-Path: <linux-btrfs+bounces-16531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7AB3C5A5
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 01:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92511C81E2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527942D6407;
	Fri, 29 Aug 2025 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F7BFQQla";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JCLrWlOH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D3sJjI50";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jNRdJzSF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD5273F9
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 23:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510716; cv=none; b=mM5txvkcEzlMJ6S8E5NIvfK0BeN11UCdZqXvVWiBkf9y6gajF8Zl0arVpyaLO9l3uiWuFWpSVn5UNt3pQNNi+tYlafGQkw+w4GcPSjq0JtBGOizha33y4kLFt1BDHDRTbl1G29WnqfP6vUXnGqWYpizJkk9lBO2ocAZDtWVdvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510716; c=relaxed/simple;
	bh=VxSajVrNbzbS8d5HzteMixox1DYpqxJ+egmpiQV1z6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRSgOZUeA28G/kpaqK1AFWt0tvHrSW/itGWkwOyWTIudpTUDL0y8KM4At0mYE8twRuRJariaCpsVyZ07di8i7nt0J2gJKrjUsmk1JxJBRKaXeHaOPXZMvOCpx8SHvH/Y3/60eNU9zu3ovZwFiUncBAH7XsDK5h/bR3irOFtvya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F7BFQQla; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JCLrWlOH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D3sJjI50; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jNRdJzSF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A989420100;
	Fri, 29 Aug 2025 23:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756510712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJpo4RWwfLxIVosTaziZE0Ook4wGza6zNlyQReqIKxY=;
	b=F7BFQQlabOroa0DCIrLpGQv+7YnO7T0p2CpggfZ/UaPJnRvsY0J22xO9jzxxTk5NqumqDx
	YR6eIAlvI03AOTciIT7X+kt8a3F1v38VA7SW1ve9qfPbTzXa/cIMwU7ZQ93OY36RL9CSf7
	SvxRUOzuC2dUpNu11Vj9W0rQ4+NLZFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756510712;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJpo4RWwfLxIVosTaziZE0Ook4wGza6zNlyQReqIKxY=;
	b=JCLrWlOHppxmkasCUvKbjADOb1mopyTUVxZbgoyWdNNExpH/J9+uC2rXnxWcoAe38ZrjcD
	28UIl7MLtQjE3rCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=D3sJjI50;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jNRdJzSF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756510711;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJpo4RWwfLxIVosTaziZE0Ook4wGza6zNlyQReqIKxY=;
	b=D3sJjI50BgtGMCsGYiPlC5S17/eV1tzeE7/xm4GDnsWroufey1dqjyBtwOUU4L1VeYXq5I
	aKUFC1GmRHWofHTMEU3vKcNVumAtyxQpwWIH8FSPKKtX9IKYlDtSxOO4sXdkvTgg4deu5P
	brLymHVH838Rz0f5Y+FPOK5CZcjN4XA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756510711;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dJpo4RWwfLxIVosTaziZE0Ook4wGza6zNlyQReqIKxY=;
	b=jNRdJzSF9PaAvDEEdIEjsNjvKhm8GHOkWyIGc2K3gOS4lr5scb4hq2kcr+lfHP5VOQaZX4
	FXNCcgy9L4UuKeAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9611113326;
	Fri, 29 Aug 2025 23:38:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wr41JPc5smjQKgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Aug 2025 23:38:31 +0000
Date: Sat, 30 Aug 2025 01:38:30 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix lzo compression level output
Message-ID: <20250829233830.GA5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9182b66aba2db19b939fdd3ceaafb07217210c1a.1756436553.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9182b66aba2db19b939fdd3ceaafb07217210c1a.1756436553.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A989420100
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Aug 29, 2025 at 12:32:34PM +0930, Qu Wenruo wrote:
> [BUG]
> Since commit "btrfs: accept and ignore compression level for lzo", we
> will always set the lzo compress level to the default one.
> 
> This makes test case btrfs/220 fail with the following messages:
> 
>  FSTYP         -- btrfs
>  PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc3-custom+ #281 SMP PREEMPT_DYNAMIC Thu Aug 28 11:15:21 ACST 2025
>  MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>  MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
>  btrfs/220 5s ... - output mismatch (see /home/adam/xfstests/results//btrfs/220.out.bad)
>      --- tests/btrfs/220.out	2022-05-11 11:25:30.749999997 +0930
>      +++ /home/adam/xfstests/results//btrfs/220.out.bad	2025-08-29 12:26:54.215307784 +0930
>      @@ -1,2 +1,8 @@
>       QA output created by 220
>      +Unexepcted mount options, checking for 'compress=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress=lzo'
>      +Unexepcted mount options, checking for 'compress=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress=lzo'
>      +Unexepcted mount options, checking for 'compress=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress=lzo'
>      +Unexepcted mount options, checking for 'compress-force=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress-force=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress-force=lzo'
>      +Unexepcted mount options, checking for 'compress-force=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress-force=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress-force=lzo'
>      +Unexepcted mount options, checking for 'compress-force=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress-force=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress-force=lzo'
>      ...
>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/220.out /home/adam/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
> 
> [CAUSE]
> That commit changes lzo parsing use btrfs_compress_str2level() all time.
> This means even lzo doesn't support compress level, we will still set
> the default level, which is 1 for lzo.
> 
> And btrfs_show_options() will use compress_level for every compression
> algorithm, causing the mount option output change thus the test case
> failure.
> 
> [FIX]
> Just change btrfs_show_options() to skip the compress level for lzo.
> 
> Please fold this one into the original commit.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

