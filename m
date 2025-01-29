Return-Path: <linux-btrfs+bounces-11139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E015A21E0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C071886447
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230501494CC;
	Wed, 29 Jan 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hLyrfpua";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzMyLQjJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B/wxvE6n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8uZ5sPrT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D418462;
	Wed, 29 Jan 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158168; cv=none; b=gLHuv725d7TNgR+E85QfLByd66XbMGJtdW5zyuTFFny5wiBiz+rYmfUeP5gDaUO5dXNbBtLFDgNae39kivvkpIkn242B5Z3f/hB4w7hsxL8KjSRG3S34VklAUyCCeQWHO03N1FZK1yZRkXLbViD8HLFie2PZDJ75nt4RJd2MnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158168; c=relaxed/simple;
	bh=ymO3agEz5Ckfrl2fb585HGGeRxDxa+ezHaj0A/2yZoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEt4gY75tRd/ZRq6gkGeNV/7W/GNk3Bpwir4NdYwz/iX1S5mvyaqJ75k3gi1alN5swfjpJ6Nd3b7yD1PmXZj+d/0I7QBnbWNo2w5URmCKcrsD2tulqEpr6WzuWfHiMO8yVqtnl1dMvHnr8Sa+kxrFmQNKG7Dw/jsg/hUvpw1Wco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hLyrfpua; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzMyLQjJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B/wxvE6n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8uZ5sPrT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A8ED1F365;
	Wed, 29 Jan 2025 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738158164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT6ApTO+gA0XzngqrmsmK3mpuGfGBWh7iu4P+o+DX+8=;
	b=hLyrfpuaYE5MLxmGyc54bKCls2Rouo98edFfWlLT9sQX6QC/7v/JMNensUyE1wiJTyPSix
	2lEWjwXaMMEsBI7qZPNXkRxR/fdeQ1o/BNUPR90RLPeFrSrcIgKXVSRPsvbwnj8LUeuSLa
	xknjd3zFy/Rb3YlqZK901ssEAyEPBWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738158164;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT6ApTO+gA0XzngqrmsmK3mpuGfGBWh7iu4P+o+DX+8=;
	b=pzMyLQjJho92X0AzJ6SJuIVeiay4M7OdE8eB2QIaeTusOuH9gk73stuoZxdvnF6CupgxTz
	FLJK5prhq5WhgKDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738158163;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT6ApTO+gA0XzngqrmsmK3mpuGfGBWh7iu4P+o+DX+8=;
	b=B/wxvE6nywkMcWuCxSNkKF7IwTN317pn6184P0xQwWaS3QplO3n8MBPHEcLUNzWAG7JRcj
	SBMrJBsenG4DMWZan9+Ctk6Gq18e1v07vIAXdDMPBu9QmFFbfGlxiVSlM7Kf8+CQQcJJNR
	Zpx86d1a6ZTDTj/aCr+uIKiq/3ky1qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738158163;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT6ApTO+gA0XzngqrmsmK3mpuGfGBWh7iu4P+o+DX+8=;
	b=8uZ5sPrTMzRd/CnZFIuHCIlQ0m2E7B7Q7ERPyFUx00441+M+U4Pmkbn1zFphokmhi8pt8H
	GKvzfGfaocIJR8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17C09137DB;
	Wed, 29 Jan 2025 13:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KgYGBVMwmmcmCQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 29 Jan 2025 13:42:43 +0000
Date: Wed, 29 Jan 2025 14:42:26 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] btrfs/zstd: enable negative compression levels mount
 option
Message-ID: <20250129134226.GC5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250128145106.1368263-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128145106.1368263-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

In next patch iteration if there's one please fix the subject so there's
"btrfs: zstd: ...".

On Tue, Jan 28, 2025 at 03:51:04PM +0100, Daniel Vacek wrote:
> This patch allows using the fast modes (negative compression levels) of zstd
> as a mount option.
> 
> As per the results, the compression ratio is lower:
> 
> for level in {-10..-1} 1 2 3; \
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

Thanks, this is a good overview. The ratio comparing the now default
level 3 against the fastest level -10 is between 1.6-1.9x, with roughly
linear progression with each level.

We still need the compression times. This may be harder to get from
kernel, so one possibility is to add tracepoints or gather the
statistics inside kernel before/after compression calls and then print
to the log.

Or maybe the 'zstd' utility can be configured to run its benchmarks
close to what kernel does, ie. the block size, memory limit and maybe
more. I've skimmed the manual page and there's enough to choose from.

The last thing is to implement a userspace microbenchmark. Recently
mkfs.btrfs learned compression support so you could reuse this code for
that.

> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> Changes in v3:
>  * Correct the accidentally replaced string in `clip_level()` function.

The code looks good now. Thanks.

