Return-Path: <linux-btrfs+bounces-11379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C699A31588
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 20:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105893A5E55
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065326E62B;
	Tue, 11 Feb 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AF7TqaOm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gO9wnHFn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AF7TqaOm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gO9wnHFn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8570B26E62C
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302908; cv=none; b=laqEzDJhRRlwE3syj338eJ2HA+WVmy//twA4galEXY9k6ueb2SFBdjuU65bZovW0V6MLJFyQripcqkoqhhUFAGKhN6Flfl91iRuagc/txnIYebzN73M+rajbb8v6DAvgz1ITMNoq5JDxCyPmaxnjxX/kmsgjE4eeB3SQEGpRYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302908; c=relaxed/simple;
	bh=Dvtd3K7UbBVjhbW5zRDjZjQJ+kRoDICnW46E8u/dBx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjZhTf02a1duaATo1aK81/UsCx8NRoUTDUGy3n3AbGlA14wSmYM6kiUatgYJi4F0AjNS0GPJPRy+GcOWPtKsEBZ182jeRKWg1C2QJRYtMpD/v2zaIQcHNcRHlZkFaCszoaRfd4r1xzEDswLkdwYAXh24UPU7sg/ll+djzoFBgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AF7TqaOm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gO9wnHFn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AF7TqaOm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gO9wnHFn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F77B21B03;
	Tue, 11 Feb 2025 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739302904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6ANaGhA7TLo5KTM+6J7c85xilzIJpnaoXcvYHjo6eU=;
	b=AF7TqaOmJ6YP0gY2GdpAMfKAIZ4sv1iohlc9oiiRsZDHOsRz+0P6bfIiwOW3ksT5b/42XD
	wR+w44/n+jNOYqAEnODwAMdDbYhCxBoEzYeoGt3ZtOlXjG2NjzEK1elvXa3IvVzOuQeaI/
	iFXr1z3YNTky9LgkWBu6tv/Jb2aBjDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739302904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6ANaGhA7TLo5KTM+6J7c85xilzIJpnaoXcvYHjo6eU=;
	b=gO9wnHFn5QMxiBOiRgKNasGZtGe31gw/WgHOT0tWAV9ZhUN3t3jpNXsEzKnFZ6flOiS80N
	hZmQX/AltqPIZTAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739302904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6ANaGhA7TLo5KTM+6J7c85xilzIJpnaoXcvYHjo6eU=;
	b=AF7TqaOmJ6YP0gY2GdpAMfKAIZ4sv1iohlc9oiiRsZDHOsRz+0P6bfIiwOW3ksT5b/42XD
	wR+w44/n+jNOYqAEnODwAMdDbYhCxBoEzYeoGt3ZtOlXjG2NjzEK1elvXa3IvVzOuQeaI/
	iFXr1z3YNTky9LgkWBu6tv/Jb2aBjDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739302904;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h6ANaGhA7TLo5KTM+6J7c85xilzIJpnaoXcvYHjo6eU=;
	b=gO9wnHFn5QMxiBOiRgKNasGZtGe31gw/WgHOT0tWAV9ZhUN3t3jpNXsEzKnFZ6flOiS80N
	hZmQX/AltqPIZTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 779C813AA6;
	Tue, 11 Feb 2025 19:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SiiiHPinq2dMNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Feb 2025 19:41:44 +0000
Date: Tue, 11 Feb 2025 20:41:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Racz Zoltan <racz.zoli@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] scrub status: add json output format
Message-ID: <20250211194135.GV5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250207023302.311829-1-racz.zoli@gmail.com>
 <20250207023302.311829-3-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207023302.311829-3-racz.zoli@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Feb 07, 2025 at 04:33:02AM +0200, Racz Zoltan wrote:
> This patch adds support for json formatting of the "scrub status"
> command. Please not that in the info section the started-at key in
> 02:00:00 1970 because i bypassed the "no stats available" so I can make
> sure those stats are correctly formatted in the output as well. 
> 
> Example usage:
> 1. btrfs --format json scrub status /

Thanks. The status in json is useful and it found a few things than may
be missing in the json formatting. The most obvious one is that there's
too much duplication of the code in plain vs json output. The ideal
version is that there's only rowspec definition of all the keys and only
fmt_print for each one, it'll get formatted properly given the selected
output format.

But there are already exceptions in other code that prints both json and
plain text due to the requirements that can't be done with fmt_ but we
need to keep the visual output.


> +static const struct rowspec scrub_status_rowspec[] = {
> +	{ .key = "uuid", .fmt = "%s", .out_json = "uuid"},
> +	{ .key = "status", .fmt = "%s", .out_json = "status"},
> +	{ .key = "duration", .fmt = "%u:%s", .out_json = "duration"},

We'll need a new internal json type for dration, so the value is number
of seconds and formatted automatically. The .fmt can be any proper
printf formatter but it's left for flexibility until we find a reason to
make a separate type for that to avoid code repetition or differences
how the same type of information is formatted.

> +	{ .key = "started_at", .fmt = "%s", .out_json = "started-at"},

And another type for timestamp, input in seconds, formatted as some
standard human readable format that can be parsed back eventually.

> +	{ .key = "resumed_at", .fmt = "%s", .out_json = "resumed-at"},
> +	{ .key = "data_extents_scrubbed", .fmt = "%lld", .out_json = "data-extents-scrubbed"},

The keys are internal, I'd prefer to use "-" as separator.

> +	{ .key = "tree_extents_scrubbed", .fmt = "%lld", .out_json = "tree-extents-scrubbed"},
> +	{ .key = "data_bytes_scrubbed", .fmt = "%lld", .out_json = "data-bytes-scrubbed"},
> +	{ .key = "tree_bytes_scrubbed", .fmt = "%lld", .out_json = "tree-bytes-scrubbed"},
> +	{ .key = "read_errors", .fmt = "%lld", .out_json = "read-errors"},
> +	{ .key = "csum_errors", .fmt = "%lld", .out_json = "csum-errors"},
> +	{ .key = "verify_errors", .fmt = "%lld", .out_json = "verify-errors"},
> +	{ .key = "no_csum", .fmt = "%lld", .out_json = "no-csum"},
> +	{ .key = "csum_discards", .fmt = "%lld", .out_json = "csum-discards"},
> +	{ .key = "super_errors", .fmt = "%lld", .out_json = "super-errors"},
> +	{ .key = "malloc_errors", .fmt = "%lld", .out_json = "malloc-errors"},
> +	{ .key = "uncorrectable_errors", .fmt = "%lld", .out_json = "uncorrectable-errors"},
> +	{ .key = "unverified_errors", .fmt = "%lld", .out_json = "unverified-errors"},
> +	{ .key = "corrected_errors", .fmt = "%lld", .out_json = "corrected-errors"},
> +	{ .key = "last_physical", .fmt = "%lld", .out_json = "last-physical"},

All the numbers seem to be u64, so %llu format should be there but it's
wrong in current version already. This would be nice to fix first (in a
separate patch).

> +	{ .key = "time_left", .fmt = "%llu:%02llu:%02llu", .out_json = "time-left"},

Duration again, also it may need to be formatted with days taken into
account. With a filesystem it's not impossible.

> +	{ .key = "eta", .fmt = "%s", .out_json = "eta"},

Timestamp type.

> +	{ .key = "total_bytes_to_scrub", .fmt = "%lld", .out_json = "total-bytes-to-scrub"},
> +	{ .key = "bytes_scrubbed", .fmt = "%lld", .out_json = "bytes-scrubbed"},
> +	{ .key = "rate", .fmt = "%lld", .out_json = "rate"},
> +	{ .key = "limit", .fmt = "%lld", .out_json = "limit"},
> +
> +	ROWSPEC_END
> +};

So the plan for now is to first update the formatter and then use it for
scrub status in json. Let me know if you're up for it. Adding the types
should be easy, it's in fmt_print().

