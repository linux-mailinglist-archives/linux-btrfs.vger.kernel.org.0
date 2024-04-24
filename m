Return-Path: <linux-btrfs+bounces-4512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCB58B06A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 11:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414821C20CDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8C215A494;
	Wed, 24 Apr 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W/kYT09R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTt+56n4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W/kYT09R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTt+56n4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1B1598FE
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952555; cv=none; b=r8xHcOKzezBKaC5ziqEc2YldVYPWWpwINn+BV7PSf+VJf99HJutaDP4fMxQstaFoS2DOmckl3/sM6D1Ti3hbC3FRLG2csMqqJnEXHJn7OPz/iuXiyIEyUv8WFqzUJn50KsEI4dlOqbbzXtn0ZXgdssZK3tgfcWK9kGQv1y8YqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952555; c=relaxed/simple;
	bh=1nGLIRYMp1ftvB3FPgyZ4rLhikP+tQwRZUbfsTWre/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDjYCQBJd3Y/c/oRgVvxC9KAqSybS/kYhwbSEywYqMTkztSKow5DVn9LhFaTr4ObupnEck0TnQJnokgx/7dS1EpgmRzgXoj+RbtFVCJCewr7vBlYSKBSSn7gAJSR4m8sxVvHulXSD7z2NiaXKJBH4qc/RSpTI3ecvI0PfP2GrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W/kYT09R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTt+56n4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W/kYT09R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTt+56n4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D117C3EE5A;
	Wed, 24 Apr 2024 09:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713952551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snBTuBZa9Txbu6KhVrmC4CBvX9tb32BSrdgMEKM6lwY=;
	b=W/kYT09RrTqYjq70FYW0N6z8WhjXg9k1nM4jYMScVFotCDxRtEQ3ic2s4rOL+pmhF4RozS
	DH7+T3Ksl/3sZ7E66iNcZjaY4ixAnwg7jPyau9nDvgk3EMOv5zeTNNh34rluY99Ko5p4+l
	tDR+SFihxq7wnphkT4urLydNbOu1FuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713952551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snBTuBZa9Txbu6KhVrmC4CBvX9tb32BSrdgMEKM6lwY=;
	b=nTt+56n4TbHEXBYNJKpPMHjvYqAliuQaFwctrUisM21qygQ338zOZPjVQgdCvx57m6JXXP
	C+lR/ZkeG7V9iABA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713952551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snBTuBZa9Txbu6KhVrmC4CBvX9tb32BSrdgMEKM6lwY=;
	b=W/kYT09RrTqYjq70FYW0N6z8WhjXg9k1nM4jYMScVFotCDxRtEQ3ic2s4rOL+pmhF4RozS
	DH7+T3Ksl/3sZ7E66iNcZjaY4ixAnwg7jPyau9nDvgk3EMOv5zeTNNh34rluY99Ko5p4+l
	tDR+SFihxq7wnphkT4urLydNbOu1FuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713952551;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snBTuBZa9Txbu6KhVrmC4CBvX9tb32BSrdgMEKM6lwY=;
	b=nTt+56n4TbHEXBYNJKpPMHjvYqAliuQaFwctrUisM21qygQ338zOZPjVQgdCvx57m6JXXP
	C+lR/ZkeG7V9iABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9C401393C;
	Wed, 24 Apr 2024 09:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gQsyLSfXKGZdQQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 24 Apr 2024 09:55:51 +0000
Date: Wed, 24 Apr 2024 11:48:18 +0200
From: David Sterba <dsterba@suse.cz>
To: HAN Yuwei <hrx@bupt.moe>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: mkfs.btrfs enabled RST by default casuing unable to mount on
 stable kernel
Message-ID: <20240424094818.GJ3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46FCC719DD77BA7B+fd2aa1a9-91c4-4634-a584-0989f055cb40@bupt.moe>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.19
X-Spam-Level: 
X-Spamd-Result: default: False [-3.19 / 50.00];
	BAYES_HAM(-2.19)[96.15%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto]

On Wed, Apr 24, 2024 at 01:45:24PM +0800, HAN Yuwei wrote:
> I have found incompatibility issue on btrfs-prog & kernel. btrfs-progs 
> is v6.7.1, kernel is 6.7.5-aosc-main.
> 
> Using this command to create btrfs volume:
> # mkfs.btrfs -f -d raid10 -m raid1c4 -s 16k -L HYWDATA_ZONED_TEST 
> /dev/sdb /dev/sdc /dev/sdd /dev/sde
> 
> When mounting, dmesg said:
> [  329.071403] BTRFS info (device sdb): first mount of filesystem 
> 7b4f2ca6-efe3-48d9-81f6-ba65a00db85e
> [  329.080422] BTRFS info (device sdb): using crc32c (crc32c-generic) 
> checksum algorithm
> [  329.088222] BTRFS info (device sdb): using free space tree
> [  329.093673] BTRFS error (device sdb): cannot mount because of unknown 
> incompat features (0x5b41)
> [  329.102442] BTRFS error (device sdb): open_ctree failed
> 
> dump-super said:
> [...]
> incompat_flags          0x5b41
>                          ( MIXED_BACKREF |
>                            EXTENDED_IREF |
>                            SKINNY_METADATA |
>                            NO_HOLES |
>                            RAID1C34 |
>                            ZONED |
>                            RAID_STRIPE_TREE )
> [...]
> 
> 
> RAID_STRIPE_TREE need CONFIG_BTRFS_DEBUG to be supported and this 
> feature flag is disabled on most distributions. I hope RST can be 
> disabled by default on btrfs-progs.

IMO this works as intended. Features may be enabled ahead of time in
btrfs-progs due to early testing and not requiring the experimental
build. The experimental status of progs features is about completeness
of the implementation, so if mkfs creates a filesystem with RST then it
could be enabled.

The kernel support is still missing some features and there are some
known bugs, this is conveniently hidden behind the DEBUG option so it
does not affect distributions.

However it seems that the documentation is not clear about that and the
status page should be updated.

