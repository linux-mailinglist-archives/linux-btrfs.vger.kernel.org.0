Return-Path: <linux-btrfs+bounces-16306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92FB32262
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789146247D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513D2BF3CF;
	Fri, 22 Aug 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1JDsGIz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvN6Wm/b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O1JDsGIz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xvN6Wm/b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C583AC1C
	for <linux-btrfs@vger.kernel.org>; Fri, 22 Aug 2025 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888357; cv=none; b=X5o989W0jtRKa6gHXW+qV+UXdgyXal+eGp9GAgrSY8+SFA6Oz83+VX/5AeRvUK8Pn0WkhIWhqkEMtfZEOSgBpdaBdbx1sKGwcYxZuw958FeWCgIVCqYqYO7H0O9ZjFqdPeqIrkM4vqCYqro2E1w0MNvYmELIfmxc2mO082coLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888357; c=relaxed/simple;
	bh=Lhh8/zVJrXTLvvq9G/h02uOlLVNWfyH9IC++2ycq/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ/zAlgpnp/Z9XNteUvAWsaoBC/nwKwgFMD5+LkWqKGsPZiYhWYW+VCp76aP6HU+40ZXtxRSsvW91kDrlktV3X+xss7oa8QhsyPImJZhh6lLDtqEThXf8R60sGmfeuy2fssQ8C7IWwf9HCr7FyT43AmmoNOr125JTHUd3voWxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1JDsGIz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvN6Wm/b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O1JDsGIz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xvN6Wm/b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE9502208A;
	Fri, 22 Aug 2025 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755888353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldevIDkCymOAVO+XFNA1UlE63JFsEjpsWCHsZsgugH4=;
	b=O1JDsGIzxJQ/oSEAkuXIGudSEC7gYs168sQkehKdUt4hJEbQYvsLdNjbeIv1/pDPZedTnA
	uxhT+2+Tg/c8thN8OyaNtuAx3la9G8uETS2FMMIlIQDwKBQD5ZEI/MkKTB6W6CKckFTXrb
	w3m70m40tr093qkJpw5ahl0YZbU1wnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755888353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldevIDkCymOAVO+XFNA1UlE63JFsEjpsWCHsZsgugH4=;
	b=xvN6Wm/bORHOwuMExp9woeHpsrav+KPsJkQ5yJbRkL7p59CB/db2cMe1uiwTroCJH0/pcO
	jV62TUCYw+TQRjBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O1JDsGIz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="xvN6Wm/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755888353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldevIDkCymOAVO+XFNA1UlE63JFsEjpsWCHsZsgugH4=;
	b=O1JDsGIzxJQ/oSEAkuXIGudSEC7gYs168sQkehKdUt4hJEbQYvsLdNjbeIv1/pDPZedTnA
	uxhT+2+Tg/c8thN8OyaNtuAx3la9G8uETS2FMMIlIQDwKBQD5ZEI/MkKTB6W6CKckFTXrb
	w3m70m40tr093qkJpw5ahl0YZbU1wnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755888353;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldevIDkCymOAVO+XFNA1UlE63JFsEjpsWCHsZsgugH4=;
	b=xvN6Wm/bORHOwuMExp9woeHpsrav+KPsJkQ5yJbRkL7p59CB/db2cMe1uiwTroCJH0/pcO
	jV62TUCYw+TQRjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ED2513931;
	Fri, 22 Aug 2025 18:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vptpIuG6qGgwUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 22 Aug 2025 18:45:53 +0000
Date: Fri, 22 Aug 2025 20:45:47 +0200
From: David Sterba <dsterba@suse.cz>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Daniel Vacek <neelx@suse.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
Message-ID: <20250822184547.GX22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
 <aKg4PcgUCvXblVCY@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKg4PcgUCvXblVCY@mozart.vkv.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AE9502208A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org,suse.com,toxicpanda.com,fb.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com]
X-Spam-Score: -4.21

On Fri, Aug 22, 2025 at 02:28:29AM -0700, Calvin Owens wrote:
> On Friday 08/22 at 17:57 +0930, Qu Wenruo wrote:
> > 在 2025/8/22 17:15, Calvin Owens 写道:
> > > The compression level is meaningless for lzo, but before commit
> > > 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
> > > it was silently ignored if passed.
> > 
> > Since LZO doesn't support compression level, why providing a level parameter
> > in the first place?
> 
> Interpreting "no level" as "level is always one" doesn't seem that
> unreasonable to me, especially since it has worked forever.

As it currently works, no level means use the default, which is defined
for all compression. For LZO it's implicit and 1.

> > I think it's time for those users to properly update their mount options.
> 
> It's a user visable regression, and fixing it has zero possible
> downside. I think you should take my patch :)

I tend to agree this is a usability regression, even if LZO is a bit odd
with levels, accepting the allowed values should work.

The mount options and level combinations that should work:

- compress=NAME   - use default level for NAME
- compress=NAME:0 - use default, while accepting the level setting
- compress=NAME:N - if N is in the allowed range for NAME then take it

The syntax is consistent for all three compressions.

