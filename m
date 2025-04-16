Return-Path: <linux-btrfs+bounces-13068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EFA8B660
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1953440E15
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04993238179;
	Wed, 16 Apr 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bL3EH1dg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UdVJw91v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="06qahNkR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LDu48oUJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3309235354
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798003; cv=none; b=mHFZwgS6LtQdUWIf+s6XAeVncGfSPwx+1/ecNTn1zhCz0sYOvLdDAtcg8qNcjor4VX8QZ2TJyrmRUC5TOb0x7vLwcAxrcNGGYGTVBv6HsHG4QG4w/BhZgOnZ5x8DfdqgGQqX2lmLe/bY2OcD/611zp4steKjZ9tH2lcZsAmf5+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798003; c=relaxed/simple;
	bh=W43sdgqXTheATUR1xnioTdkhPutfeDefzJfdTHToV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL9jjrFHCZxjFqkLISnOerWShmX8ehMrsuZVJreTUlHu0WJDrnR2hzx9IO0392UZ4X5szCKhHadgFIjxmbGG6Td6SBudkzqn8/7ooDWKSMNZ7DJwpPhJKbufWpDKFz47GV8WjApnZOxRPj/oQTy1oKcUQYi1p3UhMYMxYfH4zoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bL3EH1dg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UdVJw91v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=06qahNkR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LDu48oUJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C96A2211A9;
	Wed, 16 Apr 2025 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744797999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eqvmwnkNKXAjzGYgdgqGMvB0VzEfPjxj8p2HmbMKXQ=;
	b=bL3EH1dgQcINNM7gPVP/zG222MLC+LdZU8ghWj0C1mnn7tDrDsehj6MbPrLyhODb1gS4Xq
	JJsYO1w57YsmOaUkmtjqKUBqqz3ym6PYunlvm/HUtu9MrJnG9x/zLNL4XODHZ8HRnJ8CZz
	ZcCGzkryYSU+Q+tcqFJmNuOrTRmA4nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744797999;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eqvmwnkNKXAjzGYgdgqGMvB0VzEfPjxj8p2HmbMKXQ=;
	b=UdVJw91v73bwdqXkO6XBHSCKRTZA4i6rRfuTjw5dXGdJWLoP3Lv0rYacWJmbIE9xxfu50t
	eladOwJ/gqqzzRAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=06qahNkR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LDu48oUJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744797995;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eqvmwnkNKXAjzGYgdgqGMvB0VzEfPjxj8p2HmbMKXQ=;
	b=06qahNkRTslsaqSo4Zm+P2pEDVQuhiwaaV5kZznGkrHel+z78i1FqLGbbWdgmjFG8+v1FV
	zvdWNsrgoyJPXOQV4cdaaE1rAGGR8xX96ppDdn7NvubN98LBU0MUqEfv5oR2ciuB+NU17T
	jRma8ZARnJszTXZ5SMFEE2G/n8bcuJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744797995;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4eqvmwnkNKXAjzGYgdgqGMvB0VzEfPjxj8p2HmbMKXQ=;
	b=LDu48oUJjbf37y6TIWvEsR/bCzp4FVZxgOIAD6zsIBwcnJsIvs/SywNaN+/aN2hj1DRlAx
	KAiEcuDYrTT2dfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2B9A139A1;
	Wed, 16 Apr 2025 10:06:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 71RgKyuB/2dqfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 16 Apr 2025 10:06:35 +0000
Date: Wed, 16 Apr 2025 12:06:34 +0200
From: David Sterba <dsterba@suse.cz>
To: Integral <integral@archlinuxcn.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Maybe we can set default zstd compression level to 1 when SSD
 detected?
Message-ID: <20250416100634.GB13877@suse.cz>
Reply-To: dsterba@suse.cz
References: <8c2e5d04-dbda-4b12-992e-34f0e70c7218@archlinuxcn.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c2e5d04-dbda-4b12-992e-34f0e70c7218@archlinuxcn.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C96A2211A9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.21
X-Spam-Flag: NO

On Sun, Apr 13, 2025 at 12:07:26PM +0800, Integral wrote:
> Hi,
> 
> When SSD is detected, maybe we can set default zstd compression level to 1.
> 
> Current default compression level for zstd is 3, which is not optimal 
> for SSDs.
> 
> This GitHub Gist [1] can serve as a reference.

Well, while the linked gist is thorough I don't see that zstd:1 clearly
wins against zstd:3. The compression brings overhead (more extents, CPU
cost) so the preferred criteria should be space savings. The runtimes of
read and write seem to be roughly the same.

I haven't found any description or classification of the input data
(other than known to be incompressible). This is an important factor.

> An example is Fedora Workstation [2], which uses `zstd:1` as default
> compression option.
> 
> [1] Link: 
> https://gist.github.com/braindevices/fde49c6a8f6b9aaf563fb977562aafec
> 
> [2] Link: https://fedoraproject.org/wiki/Changes/BtrfsTransparentCompression

Unfortunately the Fedora evaluation disqualifies itself because it uses
/dev/urandom (practically incompressible) and /dev/zero (trivially
compressible). I would not select the default based on that benchmark
for the wole distro, it's IMHO flawed or incomplete at best.

For the evaluation I recommend some commonly found data types based on
their compressibility, like we did for the recent fast zstd levels
https://lore.kernel.org/linux-btrfs/20250128132235.1356769-1-neelx@suse.com/ .
Binaries, documentation, enwik9 (commonly used for compression
benchmarks), linux sources.

The classes are not exact but should represent files that are common
and have a chance of being considered for compression.  Already
compressed files or other hard to compress files like media are
detected and not considered by the heuristic.

Changing defaults is possible but it affects everybody and from past
experience breaks somebody's use case or negatively affects performance.

The evaluation from the gist could be enhanced with more input data
types and CPU strengths.

