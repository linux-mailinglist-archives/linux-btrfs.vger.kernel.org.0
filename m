Return-Path: <linux-btrfs+bounces-11300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC3A29892
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 19:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFBF1675E9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6AC1FCFD4;
	Wed,  5 Feb 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iPXbQZhH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tT2MiVE9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H4rs0IHi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eNmkrXZL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1381FCCF2;
	Wed,  5 Feb 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779430; cv=none; b=G78LBdhZYV6etWUDK9uCY5F/ncT9CSIDdKg5MOvEL0IRDupBx45fyoQ5eUjjhkEjZNHMgc58owVli3H6R52IAtFsO4nVW1ojgCTfUsMDfuw1aqC0r5l8LurYMa3fJ5zCuARtPwaHcYGenOkyJ5kYRMaPjGnz47f7Cm45k3Ss1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779430; c=relaxed/simple;
	bh=BkQR2waoTAZKgITUbNMtnjCqTXW/9yjFpf4WkmVnNU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g82T5j1EgnAGNSCBDX9rXhcRxNChs5DDFWfpts7jh5OcCEY9H55Yck2TC+bz551+TVkpFG9MCISdfdGHsT5cH1pLhzEB3Sw0CQvoZm0iE/c4uTywQl7x2yqawpZETi6aKH2k/lT5t1bLDfTVgNzy7nHx/RaTC9ka1hl3TA4luUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iPXbQZhH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tT2MiVE9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H4rs0IHi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eNmkrXZL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED37621133;
	Wed,  5 Feb 2025 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738779427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8siezr1ai4ZQ0ls9ObxiOIGBjp5BylhpOfmEyMRYuSY=;
	b=iPXbQZhH70vEQ4YmosOZqQlmm3Sf1qtPNhkOyPDdFl4u/jWVl5a9tJ9qYUMT99euBq0Wix
	qCJYIHIs1WvCBBUCG444iajEhph78C72rnivmYxAm+BreI5Qz7IiyDfbO/WJUMF36kLYGn
	ar0PFj+ceveqdS/3XDK5ruNIsi8VW2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738779427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8siezr1ai4ZQ0ls9ObxiOIGBjp5BylhpOfmEyMRYuSY=;
	b=tT2MiVE9qMkiMHHBHVH0g9B4xGW6knqVz0g9zoBGYV/iCK56k14VUrGy6PNaGhM8SQjXXm
	Nb4FBOK2UxY7JLDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H4rs0IHi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eNmkrXZL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738779426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8siezr1ai4ZQ0ls9ObxiOIGBjp5BylhpOfmEyMRYuSY=;
	b=H4rs0IHi97g8kH3sV7labgHBU6IXb0/UBgN000ZqmkvfRE2iI/rjpXO3firHqdmRi//f9b
	rT1fRP4Tff9m18+tPoST/yGltQsjRECnW+NUaZyYu1MvcNXx+xz6orMi7sddL5khvFsn+G
	jFKTHVX2ggWkmDX/EWW4vvbBEwX4uoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738779426;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8siezr1ai4ZQ0ls9ObxiOIGBjp5BylhpOfmEyMRYuSY=;
	b=eNmkrXZL6ViAF95eHA2ssnMk9/rXF2fY1VO1Hg1Xs9BSflXkkEEzP/fqA3cLcZ5V7PXz2K
	I/P7g0XrvHcZBaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDBD913694;
	Wed,  5 Feb 2025 18:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wK8dLSKro2d0VgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Feb 2025 18:17:06 +0000
Date: Wed, 5 Feb 2025 19:17:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: zstd: enable negative compression levels mount
 option
Message-ID: <20250205181705.GL5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250130175821.1792279-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130175821.1792279-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: ED37621133
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Jan 30, 2025 at 06:58:19PM +0100, Daniel Vacek wrote:
> This patch allows using the fast modes (negative compression levels) of zstd
> as a mount option.
> 
> As per the results, the compression ratio is lower:
> 
> for level in {-15..-1} 1 2 3; \
> do printf "level %3d\n" $level; \
>   mount -o compress=zstd:$level /dev/sdb /mnt/test/; \
>   grep sdb /proc/mounts; \
>   cp -r /usr/bin       /mnt/test/; sync; compsize /mnt/test/bin; \
>   cp -r /usr/share/doc /mnt/test/; sync; compsize /mnt/test/doc; \
>   cp    enwik9         /mnt/test/; sync; compsize /mnt/test/enwik9; \
>   cp    linux-6.13.tar /mnt/test/; sync; compsize /mnt/test/linux-6.13.tar; \
>   rm -r /mnt/test/{bin,doc,enwik9,linux-6.13.tar}; \
>   umount /mnt/test/; \
> done |& tee results | \
> awk '/^level/{print}/^TOTAL/{print$3"\t"$2"  |"}' | paste - - - - -
> 
> 		266M	bin  |	45M	doc  |	953M	wiki |	1.4G	source
> =============================+===============+===============+===============+
> level -15	180M	67%  |	30M	68%  |	694M	72%  |	598M	40%  |
> level -14	180M	67%  |	30M	67%  |	683M	71%  |	581M	39%  |
> level -13	177M	66%  |	29M	66%  |	671M	70%  |	566M	38%  |
> level -12	174M	65%  |	29M	65%  |	658M	69%  |	548M	37%  |
> level -11	174M	65%  |	28M	64%  |	645M	67%  |	530M	35%  |
> level -10	171M	64%  |	28M	62%  |	631M	66%  |	512M	34%  |
> level  -9	165M	62%  |	27M	61%  |	615M	64%  |	493M	33%  |
> level  -8	161M	60%  |	27M	59%  |	598M	62%  |	475M	32%  |
> level  -7	155M	58%  |	26M	58%  |	582M	61%  |	457M	30%  |
> level  -6	151M	56%  |	25M	56%  |	565M	59%  |	437M	29%  |
> level  -5	145M	54%  |	24M	55%  |	545M	57%  |	417M	28%  |
> level  -4	139M	52%  |	23M	52%  |	520M	54%  |	391M	26%  |
> level  -3	135M	50%  |	22M	50%  |	495M	51%  |	369M	24%  |
> level  -2	127M	47%  |	22M	48%  |	470M	49%  |	349M	23%  |
> level  -1	120M	45%  |	21M	47%  |	452M	47%  |	332M	22%  |
> level   1	110M	41%  |	17M	39%  |	362M	38%  |	290M	19%  |
> level   2	106M	40%  |	17M	38%  |	349M	36%  |	288M	19%  |
> level   3	104M	39%  |	16M	37%  |	340M	35%  |	276M	18%  |
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> Changes in v4:
>  * Fix a bug with workspace lru_list.
>  * Keep the levels down to -15 as agreed.

Thanks, I'll add the patch to for-next soon. The information about times
is only a changelog update so this can be done later once we have it.

