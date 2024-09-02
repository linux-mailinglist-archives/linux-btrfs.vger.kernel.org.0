Return-Path: <linux-btrfs+bounces-7739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41995968E9B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 22:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797FCB2175A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4961C62C6;
	Mon,  2 Sep 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fAAUIN95";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvTCgEI8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fAAUIN95";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kvTCgEI8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220841C62B3
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307190; cv=none; b=rFVbwm+i0neEaxGieGbG+Umjegw0OnjLOsHWJkwT8FQ7Ku75/S4dCFZ6zHw3a/SB1Hru0gSzqs6dRD3k2nxlDQZgtAebksRvS8I8DkpmK5RvxvnID0tVJmdYF4BvUArSJaSgsZUX/KvkPnvf0lk0xVjX/WppffO+D2sBJttbxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307190; c=relaxed/simple;
	bh=d2/J1xh4zhDr5wAmzFr8Pvq5LWXgh2hnePvDxvWTmXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVkKZRKejBaYu+jCLScw3IlWp6T9ILmAOliJZ5sjHXmSo4IY+idd4H9BFLy3khqMddcIDnYkAw6WcV4u0xWL1/VvT/LCFE73ZxcASOf9LmSIIgAsA4g6Ht3220fTGfncex4BEZDG96rqbeVAikb/K1v82eeOGulR0ziowwVvI9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fAAUIN95; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvTCgEI8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fAAUIN95; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kvTCgEI8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3A1721B14;
	Mon,  2 Sep 2024 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725307186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U441g24HcH60foook8OpjeJIWD9k7L9fiC9peU4cLpQ=;
	b=fAAUIN95EeVJUhy/9gMTrWGGRLUXDHnfJvXVwfvz6EG3Pej4X7/nqAfqUZVxpD6amb0ksf
	3GUlXj5CkvzmxIgfNuNadYGW5UgETdG4X2c+IAflB6Q88diUgSgoWdE69Tt3Z0dCPV13gO
	hblJETVq3EFhpqoJhLUAUL8yFukshlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725307186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U441g24HcH60foook8OpjeJIWD9k7L9fiC9peU4cLpQ=;
	b=kvTCgEI8PMrE3hiiYJVgetBdEB3I1gQUYVo1j0h/2rtsDC0VVkJQorwkekNqRPbrrPsNTL
	uEytv9xH99UljvBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fAAUIN95;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kvTCgEI8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725307186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U441g24HcH60foook8OpjeJIWD9k7L9fiC9peU4cLpQ=;
	b=fAAUIN95EeVJUhy/9gMTrWGGRLUXDHnfJvXVwfvz6EG3Pej4X7/nqAfqUZVxpD6amb0ksf
	3GUlXj5CkvzmxIgfNuNadYGW5UgETdG4X2c+IAflB6Q88diUgSgoWdE69Tt3Z0dCPV13gO
	hblJETVq3EFhpqoJhLUAUL8yFukshlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725307186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U441g24HcH60foook8OpjeJIWD9k7L9fiC9peU4cLpQ=;
	b=kvTCgEI8PMrE3hiiYJVgetBdEB3I1gQUYVo1j0h/2rtsDC0VVkJQorwkekNqRPbrrPsNTL
	uEytv9xH99UljvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEB811398F;
	Mon,  2 Sep 2024 19:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cqvhNTEZ1mbbEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 19:59:45 +0000
Date: Mon, 2 Sep 2024 21:59:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Xuefer <xuefer@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: is conventional zones used for metadata?
Message-ID: <20240902195929.GA26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAMs-qv_QuHCA2pU4w4fiQbqnvo2PikmhM=AE+YrNzLsKxQ149w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMs-qv_QuHCA2pU4w4fiQbqnvo2PikmhM=AE+YrNzLsKxQ149w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F3A1721B14
X-Spam-Score: -3.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Sep 02, 2024 at 11:35:35PM +0800, Xuefer wrote:
> For zoned devices there're conventional zones and
> Sequential-write-required zones. I use btrfs on HC620 (HGST
> HSH721414ALE6M0). The conventional zones are about 131GiB in
> total.but.My disk metadata is using 13GiB which should fit into
> 131GiB.conventional but it uses a big size which causes unnecessary
> big unusable zones.
> 
>     Device zone unusable:        728.00GiB
> Metadata,RAID1: Size:736.50GiB, Used:12.62GiB (1.71%)
>    /dev/sde      736.50GiB
>    /dev/sdf      736.50GiB
> 
> this behavior make me wonder if btrfs take the advantage of
> conventional zones for storing system/metadata data

Currently, conventional zones are written to as if they were sequential,
the same code that does the emulation on non-zoned devices. I found only
one exception for the conventional zone, it's the superblock that is not
appended each time but rather overwritten at the offset 0.

IIRC the conventional+sequential devices were meant as intermediate step
towards sequential-only devices. Filesystems that overwrite in place
could have been adapted to use the conventional zones for metadata.
There was a talk at LSF/MM 2015 https://lwn.net/Articles/637035/ and
https://git.kernel.org/pub/scm/fs/xfs/xfs-documentation.git/tree/design/xfs-smr-structure.asciidoc .

So, this depends if the mixed zone type devices are expected to be
available in the future or if the current ones are the end of the
line. We've seen that the host-aware have been also discontinued (and
support removed from linux).

