Return-Path: <linux-btrfs+bounces-10994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D08A1511C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A5D188C7BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2025 14:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018B24F218;
	Fri, 17 Jan 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vBDbKghq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qLYYT9IO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V8apREC9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ni8cBuOq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF5D530
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122522; cv=none; b=oUyNgZppCpz5yh8L3bH2qeNnSQ4eK0Z4/XgDPdqU/YKyZfeueh3OBjnG0O0gzw43MUsso0neZrBCTyWxASKoIMeScLq7viLM1usk2eJSmfCbseq6qSd50cpQbJGC3Dg4U09Az136PDca+ILtfM6FKZug+le2UUhJ2Iehchn19/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122522; c=relaxed/simple;
	bh=tfJkiq4YYeYALbNmzze4R6pqWBc75SQqJ9LuFSqtp00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxY71TuK63HYqzeg7VkU1LkGTz3RtLJogmVO0z0GAj3stBw1jVM/OPtGMXiz8Ngsm7zX3qdWoe3dzSekC/R4ROPjCBTQHYnjmDQjcqc37DByoui3w6E9arpujqgir9gtDxJvQkR/ZSLbevAkuAarj0OGanGLdk0OSQu2J6+3iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vBDbKghq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qLYYT9IO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V8apREC9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ni8cBuOq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66CD42118B;
	Fri, 17 Jan 2025 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737122518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS401er/EsMyVjxUxzZcE2Bv0H/hJl83emGCtbeNdmY=;
	b=vBDbKghqHSYHvwL7MpOlOu6b5DerWRVgOztYIA57BklhX6MoaONc38qEQYqJhA4mjalPAh
	fNsVESJ3hb3JYDYnjPkIIu7R6z4cGVcR4x6yw5L1dtk0PFCF0WqgVuXBKnsx26HJGA7rWP
	Q5eqltb5+Uiv2/tpgPdiweO+ELD5tq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737122518;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS401er/EsMyVjxUxzZcE2Bv0H/hJl83emGCtbeNdmY=;
	b=qLYYT9IOrbTkKaK3iUxm/GWwG52IU9gR2a/2gYnjnK/6a0Jxd0C7WBYnyHMxiffK4nhzSk
	yD5aLnPcyS4VqrBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737122517;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS401er/EsMyVjxUxzZcE2Bv0H/hJl83emGCtbeNdmY=;
	b=V8apREC9LKiqSF6BBXkdI9sdmbJ5UeMzrEQ0o+Jwl/B2PGwwrOHUsVSMXKKk8MINSFK9W/
	vJjLibcyDLSW6md1r5L8oyiZaKZRRJDaMPxKkv5K7p35zbfpoIboUQAi1FTgU0aH6Tgyyf
	ZoQVSNkDph1QFrmGyRIWsgeMrSyJY9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737122517;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sS401er/EsMyVjxUxzZcE2Bv0H/hJl83emGCtbeNdmY=;
	b=ni8cBuOqXg4cyJppZfIN8Qm1TkkjPh9/uRrztHnjU6J79yy1/Egn8LJ9tjrDNWaUMoAFd4
	k6iZE4Nd9SZQKsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F8BD139CB;
	Fri, 17 Jan 2025 14:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bClDD9Viimc1bQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 17 Jan 2025 14:01:57 +0000
Date: Fri, 17 Jan 2025 15:01:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove loopback device resolution
Message-ID: <20250117140151.GD5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6094201431aa981c6e0d149b6d528bc4b7a5af91.1737020580.git.wqu@suse.com>
 <20250116114219.GC5777@twin.jikos.cz>
 <46387df4-91d9-426d-8881-e0ae97bd86cf@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46387df4-91d9-426d-8881-e0ae97bd86cf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Jan 17, 2025 at 07:22:09AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/1/16 22:12, David Sterba 写道:
> > On Thu, Jan 16, 2025 at 08:13:01PM +1030, Qu Wenruo wrote:
> >> [BUG]
> >> mkfs.btrfs has a built-in loopback device resolution, to avoid the same
> >> file being added to the same fs, using loopback device and the file
> >> itself.
> >>
> >> But it has one big bug:
> >>
> >> - It doesn't detect partition on loopback devices correctly
> >>    The function is_loop_device() only utilize major number to detect a
> >>    loopback device.
> >>    But partitions on loopback devices doesn't use the same major number
> >>    as the loopback device:
> >>
> >>    NAME            MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
> >>    loop0             7:0    0    5G  0 loop
> >>    |-loop0p1       259:3    0  128M  0 part
> >>    `-loop0p2       259:4    0  4.9G  0 part
> >>
> >>    Thus `/dev/loop0p1` will not be treated as a loopback device, thus it
> >>    will not even resolve the source file.
> >>
> >>    And this can not even be fixed, as if we do extra "/dev/loop*" based
> >>    file lookup, `/dev/loop0p1` and `/dev/loop0p2` will resolve to the
> >>    same source file, and refuse to mkfs on two different partitions.
> >>
> >> [FIX]
> >> The loopback file detection is the baby sitting that no one asks for.
> >>
> >> Just as I explained, it only brings new bugs, and we will never fix all
> >> ways that an experienced user can come up with.
> >> And I didn't see any other mkfs tool doing such baby sitting.
> >>
> >> So remove the loopback file resolution, just regular is_same_blk_file()
> >> is good enough.
> >
> > The loop device resolution had some bugs in the past and was added for a
> > reason that's not mentioned in the changelogs.
> >
> > The commits have some details why it's done, they also mention that
> > partitioned devices are resolved so it's not that there's no support for
> > that.
> >
> > 0cf3b78f404b01 ("btrfs-progs: Fix partitioned loop devices resolving")
> > abdb0ced0123d4 ("Btrfs-progs: fix resolving of loop devices")
> 
> The problem of those two fixes are pretty simple, they just do not work
> in the first place.
> 
> resolve_loop_device() is only triggered if is_loop_dev() returns >0 values.
> 
> But as I explained, resolve_loop_device() won't return >0 if a
> partitioned loopback device is passed.
> 
> So why those patches are introduced in the first place?

I don't know, all I'm asking here is to keep protection against some
accidental use of loop device with mkfs. I looks similar to what we do
with regular block devices, the same device cannot be specified twice.
If the loop device is buggy then it'll be better to fix it then delete
it.

