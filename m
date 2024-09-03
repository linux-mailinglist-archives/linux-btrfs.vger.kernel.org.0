Return-Path: <linux-btrfs+bounces-7800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFC96A762
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 21:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CF4B2172F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248751D7E4E;
	Tue,  3 Sep 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcsxfzme";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FnjPp3fb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcsxfzme";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FnjPp3fb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5EE1D7E43
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391812; cv=none; b=fRK3fJweORXcWRXH1seSjn1ZZmKpoo9S9d/tQxqrgcxMjQgPZbCevIXcb6OR3Ksj6ZO0JlD9nniQsw8LHvmXKmLjBpMQtNNL+0bqdvYbRmPHgA4RA0Ef0UYirDdfchjmDpt//kwIm3E6CrCRA7yRWTyK0j/2odGlrz0Ud/xE4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391812; c=relaxed/simple;
	bh=hqzhmzyGQba/NWeAiZnMBCvO0NFPayR9pL/OdZ5irYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkbhWQdOLbuGPZLkgkLKfIesVW0O1S/S/Bs8Ne9rgR3IBMEHBatS0yDj4IFBF3jcAHiz6nDOA3fT48l6KX5H+W9is6dvUd4+y8P2fIH1h3LAGI9ASVJfVJY8iqxsTP49p9T2gxrqtTTJHXDJWRnKFMAaswf/fNiaQqW7DTVqxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcsxfzme; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FnjPp3fb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcsxfzme; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FnjPp3fb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5BFBC21BA4;
	Tue,  3 Sep 2024 19:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725391808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uh3biL1+0OJOa8twizCluOhGREVc8SjMdSuyDBb8O0=;
	b=mcsxfzmewxvtV2heSTSdP3WjFdGFYhEI+KBmkpOPiC/hIu9+Mi7dVmcD99Pv3y1M/+g3Y1
	ZZ4n9KHE+08sLddyBHXF3DIEMZREOoHbkV2vopwXxcqZQyFuO33kSdvpoRIbNUwtVoc4eB
	w4Cr08Gsam2QYdn8j41/tVFA4aMue+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725391808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uh3biL1+0OJOa8twizCluOhGREVc8SjMdSuyDBb8O0=;
	b=FnjPp3fbbezQIWhelTEFRqBCQXp30qbo81g92JWAD178vqiVGO7RzzIzGJ3UYaysT78Yvq
	qOU9MqbISk9NJ5Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725391808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uh3biL1+0OJOa8twizCluOhGREVc8SjMdSuyDBb8O0=;
	b=mcsxfzmewxvtV2heSTSdP3WjFdGFYhEI+KBmkpOPiC/hIu9+Mi7dVmcD99Pv3y1M/+g3Y1
	ZZ4n9KHE+08sLddyBHXF3DIEMZREOoHbkV2vopwXxcqZQyFuO33kSdvpoRIbNUwtVoc4eB
	w4Cr08Gsam2QYdn8j41/tVFA4aMue+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725391808;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/uh3biL1+0OJOa8twizCluOhGREVc8SjMdSuyDBb8O0=;
	b=FnjPp3fbbezQIWhelTEFRqBCQXp30qbo81g92JWAD178vqiVGO7RzzIzGJ3UYaysT78Yvq
	qOU9MqbISk9NJ5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A605139D5;
	Tue,  3 Sep 2024 19:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BZb4DcBj12akMwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Sep 2024 19:30:08 +0000
Date: Tue, 3 Sep 2024 21:30:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Xuefer <xuefer@gmail.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: is conventional zones used for metadata?
Message-ID: <20240903193007.GJ26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAMs-qv_QuHCA2pU4w4fiQbqnvo2PikmhM=AE+YrNzLsKxQ149w@mail.gmail.com>
 <20240902195929.GA26776@twin.jikos.cz>
 <CAMs-qv99kdgrWeqN+piJpDSnWRCGT2adqka2eTUnjk09WphHQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMs-qv99kdgrWeqN+piJpDSnWRCGT2adqka2eTUnjk09WphHQg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -3.00
X-Spam-Flag: NO

On Tue, Sep 03, 2024 at 12:33:18PM +0800, Xuefer wrote:
> Thanks, that explains a lot for what I saw happen and what I read
> about emulated write pointer.
> about "intermediate step", it may be true for compatibility and
> migration, but conventional zones are IMHO really good for metadata.

Agreed and it could be implemented, but the question is if it's worth
given the number of existing devices.

> regardless of the idea bout advantage, there's a bug about conventional zones
> 
> sdd 3:0:0:0    disk ATA      HGST HSH721414ALE6M0   L4GMT10B VFGH8XBD
>       sata
> strace -f mkfs.btrfs -O zoned,raid-stripe-tree -L bak /dev/sdd -f
> ......
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] ioctl(3, BLKREPORTZONE, 0x7ffff71d3010) = 0
> [pid 12871] munmap(0x7ffff71d3000, 266240) = 0
> [pid 12871] ioctl(3, BLKDISCARD, [0, 268435456]) = -1 EOPNOTSUPP
> (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [268435456, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [536870912, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [805306368, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [1073741824, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [1342177280, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [1610612736, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [1879048192, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [2147483648, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [2415919104, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [2684354560, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [2952790016, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> [pid 12871] ioctl(3, BLKDISCARD, [3221225472, 268435456]) = -1
> EOPNOTSUPP (Operation not supported)
> 
> BLKDISCARD is not supported for conventional zones on my disk. I'm
> afraid the emulated pointer is not reset to 0 as intended
> https://bugzilla.kernel.org/show_bug.cgi?id=219170 this bug may also
> be related. the ending result were the same: failed to clean btrfs
> signature on "btrfs device delete" which sit on conventional zones

This looks like a case we should handle, though. The null_blk devices
can be set up to emulate conventional zones (but I don't know how
exactly this replicates the real device behaviour).

