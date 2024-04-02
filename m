Return-Path: <linux-btrfs+bounces-3829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1CE895BF3
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 20:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E92282864
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A715B578;
	Tue,  2 Apr 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XQnvroyh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnhRyB3e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73115B157
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083788; cv=none; b=FqS2TwOkYbaXYJBpZATkxhzQBwEY00yB6G1u7lFwWWbX5Rqc7JZidfp3ofGIWSShZ8al8iU6mfuQ7hiD1ZKtbEV11R5mlCcLFViZm2Syj5mwn3geRuMsOPD9VXSREtXmujTKoGuBy8fRy+h/0uE11g6A1CX/knbeN/2VVX6ba/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083788; c=relaxed/simple;
	bh=PcoWnA2A9VaxN8ZJ/dqmROxWCeNWnGts3ZusTRRRqH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuncwI1xgsXpBlvnOgvNtHnkj7XgQn1WNL502MUgqyEKpuhr3OfMW9kpW5kjtJWsNKcmvh8tViM3jWH4YeXmp8im/3YKTbeW1GQp15XmtXmSzLkhSlwPXhrtFPl4a1iA8e3iexAlMqgFOUilEqjTlqYkgkLja5Umy8alsXaWk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XQnvroyh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnhRyB3e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CE135C184;
	Tue,  2 Apr 2024 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712083781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NsmLNbATIvRcjwj21QqFb/P0Tcqx48eFamEiZok6jBQ=;
	b=XQnvroyh7H5I5U/Dy2/nOxYAa8y6id5FDTocq0gjS1DzlQmVgX6jfkixgUMv4Qmg6jhyPa
	CtO4oKaG0BZkAIuSi2/HxksILd59MLQxOz6v8u0J6GBZwiWMHVwoBsFdvh5qTQpgXq+Lla
	ZjAfppy5YQlREGTicAaM+9POLfRL1rY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712083781;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NsmLNbATIvRcjwj21QqFb/P0Tcqx48eFamEiZok6jBQ=;
	b=JnhRyB3eOXTsrqwmLR4OYoTo66NlJs26kuw9slLK5+oVARQ/mls/L60I1S3d5wPfKxKzh9
	K5OeUqCTbzsU1uCQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 58F4C13357;
	Tue,  2 Apr 2024 18:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id a4YuFUVTDGbfPQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 02 Apr 2024 18:49:41 +0000
Date: Tue, 2 Apr 2024 20:42:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/6] btrfs-progs: remove unused header for tune/main.c
Message-ID: <20240402184216.GE14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1711412540.git.wqu@suse.com>
 <a7224b1e785d51d74c6bd369ee0c0f586cbdf616.1711412540.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7224b1e785d51d74c6bd369ee0c0f586cbdf616.1711412540.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-0.07 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.07)[62.78%];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -0.07
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, Mar 26, 2024 at 10:52:41AM +1030, Qu Wenruo wrote:
> My clangd LSP server reports warning that "common/parse-utils.h" is not
> utilized at all.

Please be careful about removing headers, the LSP depends on the
build flags and reports symbols or headers only for the last configured
state.

In this case removing parse-utils.h causes compilation error in
experimental mode because of

287 #if EXPERIMENTAL
288                 case GETOPT_VAL_CSUM:
289                         btrfs_warn_experimental(
290                                 "Switching checksums is experimental, do not use for valuable data!");
291                         ctree_flags |= OPEN_CTREE_SKIP_CSUM_CHECK;
292                         csum_type = parse_csum_type(optarg);
                                        ^^^^^^^^^^^^^^^^^^^^^^^

293                         btrfstune_cmd_groups[CSUM_CHANGE] = true;
294                         break;
295 #endif

Some build checks or targets could be missing so we'd lack coverage and
early warnings during development, this needs to be fixed.

Builds that change LSP state (and combinations):

- make box
- make static box.static
- various D= values and modes
- configure --experimental
- possibly different includes for glibc and musl defining a symbol
  indirectly

