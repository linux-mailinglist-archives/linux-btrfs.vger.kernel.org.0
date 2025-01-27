Return-Path: <linux-btrfs+bounces-11084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D2A1DBC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7023A7566
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 18:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86618B484;
	Mon, 27 Jan 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JXOryR1q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zD3Fb8g2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j2Z4iJIr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5pmBH97"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FA18A6A9;
	Mon, 27 Jan 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738000987; cv=none; b=ARI8wIbjJ/20S5v+vOPsLdUGmOwiBAnq0kxztuWP20xHM6dQa0UCNGiiiWp2ypwsC3boD9ILIseDVNOTNFjkbumV6/dKPfHFL9wjPPUnMPM2PGi6+2lMzBstG2KhRkVCWa68EiQ4rOhC643zUqxi12vr/hQbW3yl1ILFXFJVSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738000987; c=relaxed/simple;
	bh=s8Bfh77fWEM9R4v4Dk7RAfsxtigHhE/aOPlmralwDnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE4NVKJagEhdp6eueHJk7LNSB8eGrKWRsEEwsMEQzuTPrSjGxfD8JKr23oGwnb4hKgk4fGKxNcA8VcwqhrSxoMwidUzn1fFMgoRFgVQb4E5nG+WH+LM9A9eVNTwrvQHuWZw7JT7FiejN/Fj4jKqEu2s2u3cVIhR6orEv82UwX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JXOryR1q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zD3Fb8g2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j2Z4iJIr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5pmBH97; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7C592110A;
	Mon, 27 Jan 2025 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738000977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TId1yipIxpPXHp4CGK0YAn/iCHccWNYDh0tvkE9PwM0=;
	b=JXOryR1qsLVA+p7Fc18PAFwjM7HhAQxFQCPf0nS0w65zL6BWNXwepg681o6+sz82j0k3g0
	KsfgdiEegV2V/dsFzJjHha/LsqT2XTnQSbLLy7o778DzHKH7cXrlNIvbUF8BFlhIBk4W4y
	rrSuZe/hMbxBc7JOMxrsFCAdMRT6tz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738000977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TId1yipIxpPXHp4CGK0YAn/iCHccWNYDh0tvkE9PwM0=;
	b=zD3Fb8g2sOqDdpAJmcDwVqBXtpxB9LwFxRnjvzMPxtu4BY9l5/MoDrksTl2qPwZNsNs8S6
	q77RIJFIyk/YMIDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j2Z4iJIr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a5pmBH97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738000976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TId1yipIxpPXHp4CGK0YAn/iCHccWNYDh0tvkE9PwM0=;
	b=j2Z4iJIraE6569Tz55CHzOC4h60Dz+wqFD6pCD5uK6CQRFN+qR/A1bYQM78o430T/le90O
	5G7SeKebsOcS/C79iC7/e3l5DlnNhWi2sxyxqvsDSrrsinlVdD4qgr6UJeqeKtZtBRqyy9
	cSUeWpefqIMOAs723AcouOhXd0WaQ/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738000976;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TId1yipIxpPXHp4CGK0YAn/iCHccWNYDh0tvkE9PwM0=;
	b=a5pmBH97LZcPnGhify1NnWKjfao4bLpJsKdTDAtQimDLPU7f+oEsw+4fxPZnTkJ9AsOFLV
	Up9EvMQ4/WE/TMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAEA7137C0;
	Mon, 27 Jan 2025 18:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ois2KVDKl2fGJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 27 Jan 2025 18:02:56 +0000
Date: Mon, 27 Jan 2025 19:02:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs/zstd: enable negative compression levels mount
 option
Message-ID: <20250127180250.GQ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250124075558.530088-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124075558.530088-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D7C592110A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Fri, Jan 24, 2025 at 08:55:56AM +0100, Daniel Vacek wrote:
> This patch allows using the fast modes (negative compression levels) of zstd.
> 
> The performance benchmarks do not show any significant (positive or negative)
> influence other than the lower compression ratio. But %system CPU usage
> should also be lower which is not clearly visible from the results below.
> That's because with the fast modes the processing is IO-bound and not CPU-bound.
> 
> for level in {-15..-1} {1..15}; \
> do printf "level %3d\n" $level; \
>   mount -o compress=zstd:$level /dev/sdb /mnt/test/; \
>   grep sdb /proc/mounts; \
>   sync; time { time cp /dev/shm/linux-6.13.tar.xz /mnt/test/; sync; }; \
>   compsize /mnt/test/linux-6.13.tar.xz; \
>   sync; time { time cp /dev/shm/linux-6.13.tar /mnt/test/; sync; }; \
>   compsize /mnt/test/linux-6.13.tar; \
>   rm /mnt/test/linux-6.13.tar*; \
>   umount /mnt/test/; \
> done |& tee results | \
> awk '/^level/{print}/^real/{print$2}/^TOTAL/{print$3"\t"$2"  |"}' | \
> paste - - - - - - -
> 
> 			linux-6.13.tar.xz	141M	      |		linux-6.13.tar		1.4G

It does not make much sense to compare it to a .xz type of compression,
this will be detected by the heuristic as incompressible and skipped
right away.

The linux sources are highly compressible as it's a text-like source, so
this is one category. It would be good to see benchmarks on file types
commonly found on systems, with similar characteristics regarding
compressibility.

- document-like (structured binary), ie. pdf, "office type of documents"

- executable-like (/bin/*, libraries)

- (maybe more)

Anything else can be considered incompressible, all the formats with
internal compression or very compact binary format that is beyond the
capabilities of the in-kernel implementation and its limitations.

> 		copy wall time	sync wall time	usage	ratio | copy wall time	sync wall time	usage	ratio
> ==============================================================+===============================================
> level -15	0m0,261s	0m0,329s	141M	100%  |	0m2,511s	0m2,794s	598M	40%  |
> level -14	0m0,145s	0m0,291s	141M	100%  |	0m1,829s	0m2,443s	581M	39%  |
> level -13	0m0,141s	0m0,289s	141M	100%  |	0m1,832s	0m2,347s	566M	38%  |
> level -12	0m0,140s	0m0,291s	141M	100%  |	0m1,879s	0m2,246s	548M	37%  |
> level -11	0m0,133s	0m0,271s	141M	100%  |	0m1,789s	0m2,257s	530M	35%  |

I found an old mail asking ZSTD people which realtime levels are
meaningful, the -10 was mentioned as a good cut-off. The numbers above
confirm that although this is on a small sample.

> level -10	0m0,146s	0m0,318s	141M	100%  |	0m1,769s	0m2,228s	512M	34%  |
> level  -9	0m0,138s	0m0,288s	141M	100%  |	0m1,869s	0m2,304s	493M	33%  |
> level  -8	0m0,146s	0m0,294s	141M	100%  |	0m1,846s	0m2,446s	475M	32%  |
> level  -7	0m0,151s	0m0,298s	141M	100%  |	0m1,877s	0m2,319s	457M	30%  |
> level  -6	0m0,134s	0m0,271s	141M	100%  |	0m1,918s	0m2,314s	437M	29%  |
> level  -5	0m0,139s	0m0,307s	141M	100%  |	0m1,860s	0m2,254s	417M	28%  |
> level  -4	0m0,153s	0m0,295s	141M	100%  |	0m1,916s	0m2,272s	391M	26%  |
> level  -3	0m0,145s	0m0,308s	141M	100%  |	0m1,830s	0m2,369s	369M	24%  |
> level  -2	0m0,150s	0m0,294s	141M	100%  |	0m1,841s	0m2,344s	349M	23%  |
> level  -1	0m0,150s	0m0,312s	141M	100%  |	0m1,872s	0m2,487s	332M	22%  |
> level   1	0m0,142s	0m0,310s	141M	100%  |	0m1,880s	0m2,331s	290M	19%  |
> level   2	0m0,144s	0m0,286s	141M	100%  |	0m1,933s	0m2,266s	288M	19%  |
> level   3	0m0,146s	0m0,304s	141M	100%  |	0m1,966s	0m2,300s	276M	18% *|
> level   4	0m0,146s	0m0,287s	141M	100%  |	0m2,173s	0m2,496s	275M	18%  |
> level   5	0m0,146s	0m0,304s	141M	100%  |	0m2,307s	0m2,728s	261M	17%  |
> level   6	0m0,138s	0m0,267s	141M	100%  |	0m2,435s	0m3,151s	253M	17%  |
> level   7	0m0,142s	0m0,301s	141M	100%  |	0m2,274s	0m3,617s	251M	16%  |
> level   8	0m0,136s	0m0,291s	141M	100%  |	0m2,066s	0m3,913s	249M	16%  |
> level   9	0m0,134s	0m0,283s	141M	100%  |	0m2,676s	0m4,496s	247M	16%  |
> level  10	0m0,151s	0m0,297s	141M	100%  |	0m2,424s	0m5,102s	247M	16%  |
> level  11	0m0,149s	0m0,296s	141M	100%  |	0m3,485s	0m7,803s	245M	16%  |
> level  12	0m0,144s	0m0,304s	141M	100%  |	0m3,954s	0m9,067s	244M	16%  |
> level  13	0m0,148s	0m0,319s	141M	100%  |	0m5,350s	0m13,307s	247M	16%  |
> level  14	0m0,145s	0m0,296s	141M	100%  |	0m6,916s	0m18,218s	238M	16%  |
> level  15	0m0,145s	0m0,293s	141M	100%  |	0m8,304s	0m24,675s	233M	15%  |
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> Checking the ZSTD workspace memory sizes it looks like sharing
> the level 1 workspace with all the fast modes should be safe.
> >From the debug printf output:
> 
>                                  level_size  max_size
> [   11.032659] btrfs zstd ws: -15  926969  926969

Yeah the level 1 should have enough memory, I think there are some
tricks inside ZSTD to reduce the requirements on the dictionary so
almost 1MiB is quite excessive (not only for the realtime levels), as we
do only 128K at a time anyway.

> [   11.032662] btrfs zstd ws: -14  926969  926969
> [   11.032663] btrfs zstd ws: -13  926969  926969
> [   11.032664] btrfs zstd ws: -12  926969  926969
> [   11.032665] btrfs zstd ws: -11  926969  926969
> [   11.032665] btrfs zstd ws: -10  926969  926969
> [   11.032666] btrfs zstd ws:  -9  926969  926969
> [   11.032666] btrfs zstd ws:  -8  926969  926969
> [   11.032667] btrfs zstd ws:  -7  926969  926969
> [   11.032668] btrfs zstd ws:  -6  926969  926969
> [   11.032668] btrfs zstd ws:  -5  926969  926969
> [   11.032669] btrfs zstd ws:  -4  926969  926969
> [   11.032670] btrfs zstd ws:  -3  926969  926969
> [   11.032670] btrfs zstd ws:  -2  926969  926969
> [   11.032671] btrfs zstd ws:  -1  926969  926969
> [   11.032672] btrfs zstd ws:   1  943353  943353
> [   11.032673] btrfs zstd ws:   2 1041657 1041657
> [   11.032674] btrfs zstd ws:   3 1303801 1303801
> [   11.032674] btrfs zstd ws:   4 1959161 1959161
> [   11.032675] btrfs zstd ws:   5 1697017 1959161
> [   11.032676] btrfs zstd ws:   6 1697017 1959161
> [   11.032676] btrfs zstd ws:   7 1697017 1959161
> [   11.032677] btrfs zstd ws:   8 1697017 1959161
> [   11.032678] btrfs zstd ws:   9 1697017 1959161
> [   11.032679] btrfs zstd ws:  10 1697017 1959161
> [   11.032679] btrfs zstd ws:  11 1959161 1959161
> [   11.032680] btrfs zstd ws:  12 2483449 2483449
> [   11.032681] btrfs zstd ws:  13 2632633 2632633
> [   11.032681] btrfs zstd ws:  14 3277111 3277111
> [   11.032682] btrfs zstd ws:  15 3277111 3277111
> 
> Hence the implementation uses `zstd_ws_mem_sizes[0]` for all negative levels.
> 
> I also plan to update the `btrfs fi defrag` interface to be able to use
> these levels (or any levels at all).
>  
> @@ -332,8 +335,9 @@ void zstd_put_workspace(struct list_head *ws)
>  		}
>  	}
>  
> -	set_bit(workspace->level - 1, &wsm.active_map);
> -	list_add(&workspace->list, &wsm.idle_ws[workspace->level - 1]);
> +	level = max(0, workspace->level - 1);

This seems to be a quite frequent pattern how to adjust the level,
please create a helper for that so it's not the plain max() everywhere.

> +	set_bit(level, &wsm.active_map);
> +	list_add(&workspace->list, &wsm.idle_ws[level]);
>  	workspace->req_level = 0;

