Return-Path: <linux-btrfs+bounces-11377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B0EA314CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 20:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A96D167FC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6AF262D28;
	Tue, 11 Feb 2025 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wg1KJHIL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hY2wmp8J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wg1KJHIL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hY2wmp8J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0E1E231F
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301310; cv=none; b=g+svhlCelNdJ7geZWtS3beZzCQQ34AYFmouUr2btAx0NxupvTWTHhuucHH+oiqMVrXd71xj+HQ1Zyh6eeKuwKHbekzcAe4XCqMq6xsQkW6+lTTsy6GO2EoZMqw3kCG3kCNgRvw7UDcF0h5gxxMOoSPYbID8GgxBMOuWuSmvFO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301310; c=relaxed/simple;
	bh=lYVGGNoZj4AX9yDqiFySwgcozXqIkIQh906JNM49PQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLH1Uq+97lu1Ad6PLmO9Lb7gmL9v9LCBODP2p2NFSmDtAGeFbKHGycq2poXnnG96IGdd3J6BMsgjKLbKzFiYjT3cC0HtkSy6k8lByBywcrYmDTIHVIEui8SODRngnhXAODzsQv5n67rII20w4LQhi5F1NgR7RX/TzmWUL/HQ9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wg1KJHIL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hY2wmp8J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wg1KJHIL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hY2wmp8J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E1EE1F7E1;
	Tue, 11 Feb 2025 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739301306;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B63nKHEO3/96uCSPYzVfnpdvBR6zgm2QYR4ab6wozhU=;
	b=Wg1KJHILiGTcOXP/iO2dOA+HtzTPFGwyT03mSJ9mceKtGOAz2Yss9xzvc7rlr1aT3IjDfF
	ywVzysalHzoe1IWQyKH2BY07xHaBjeVoDs2QSmE+yDll6E9ZQ3iaUsvx/ltggtxXqNvdME
	EGXgx6zDCyDorPqxj07K7/rOHZCiZJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739301306;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B63nKHEO3/96uCSPYzVfnpdvBR6zgm2QYR4ab6wozhU=;
	b=hY2wmp8JNTVOGKPRP567XlOeGxjBGWK72uKlbVCD4xv0AM2pYrJiRoKykmUHslKk78Gm0+
	saMHcT/WK8TkYuBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739301306;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B63nKHEO3/96uCSPYzVfnpdvBR6zgm2QYR4ab6wozhU=;
	b=Wg1KJHILiGTcOXP/iO2dOA+HtzTPFGwyT03mSJ9mceKtGOAz2Yss9xzvc7rlr1aT3IjDfF
	ywVzysalHzoe1IWQyKH2BY07xHaBjeVoDs2QSmE+yDll6E9ZQ3iaUsvx/ltggtxXqNvdME
	EGXgx6zDCyDorPqxj07K7/rOHZCiZJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739301306;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B63nKHEO3/96uCSPYzVfnpdvBR6zgm2QYR4ab6wozhU=;
	b=hY2wmp8JNTVOGKPRP567XlOeGxjBGWK72uKlbVCD4xv0AM2pYrJiRoKykmUHslKk78Gm0+
	saMHcT/WK8TkYuBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A53613782;
	Tue, 11 Feb 2025 19:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f8DTFbqhq2cWLQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Feb 2025 19:15:06 +0000
Date: Tue, 11 Feb 2025 20:14:57 +0100
From: David Sterba <dsterba@suse.cz>
To: Racz Zoltan <racz.zoli@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Removed redundant if/else statement
Message-ID: <20250211191457.GU5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250207023302.311829-1-racz.zoli@gmail.com>
 <20250207023302.311829-2-racz.zoli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207023302.311829-2-racz.zoli@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Feb 07, 2025 at 04:33:01AM +0200, Racz Zoltan wrote:
> Removed unnecesary if/else statement in the print_scrub_summary
> function. If unit_mode == UNITS_RAW, bytes_per_sec and limit get converted to
> UNITS_RAW, otherwise to unit_mode, but in both cases the exact same message is 
> written to the output
> 
>  cmds/scrub.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/cmds/scrub.c b/cmds/scrub.c
> index b2cdc924..3507c9d8 100644
> --- a/cmds/scrub.c
> +++ b/cmds/scrub.c
> @@ -207,25 +207,15 @@ static void print_scrub_summary(struct btrfs_scrub_progress *p, struct scrub_sta
>  	 * Rate and size units are disproportionate so they are affected only
>  	 * by --raw, otherwise it's human readable
>  	 */
> -	if (unit_mode == UNITS_RAW) {
> -		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
> -			pretty_size_mode(bytes_per_sec, UNITS_RAW));
> -		if (limit > 1)
> -			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
> -				   pretty_size_mode(limit, UNITS_RAW));
> -		else if (limit == 1)
> -			pr_verbose(LOG_DEFAULT, " (some device limits set)");
> -		pr_verbose(LOG_DEFAULT, "\n");
> -	} else {
> -		pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
> -			pretty_size_mode(bytes_per_sec, unit_mode));
> -		if (limit > 1)
> -			pr_verbose(LOG_DEFAULT, " (limit %s/s)",
> -				   pretty_size_mode(limit, unit_mode));
> -		else if (limit == 1)
> -			pr_verbose(LOG_DEFAULT, " (some device limits set)");
> -		pr_verbose(LOG_DEFAULT, "\n");
> -	}
> +	
> +	pr_verbose(LOG_DEFAULT, "Rate:             %s/s",
> +		pretty_size_mode(bytes_per_sec, unit_mode));
> +	if (limit > 1)
> +		pr_verbose(LOG_DEFAULT, " (limit %s/s)",
> +			pretty_size_mode(limit, unit_mode));
> +	else if (limit == 1)
> +		pr_verbose(LOG_DEFAULT, " (some device limits set)");
> +	pr_verbose(LOG_DEFAULT, "\n");

It's true that the branch is redundant and it's been like since the
first commit d60d48fce5d32a ("btrfs-progs: scrub status: add unit mode
options") where I added. The idea is to separate the other size options
from the rate, e.g. a 20TB sized device may not give more than 200MB/s
of rate and selecting --tbytes as size option will print number like
0.000MB/s

How it works now:

$ sudo btrfs scrub status /data
...
Total to scrub:   5.14TiB
Bytes scrubbed:   7.08GiB  (0.13%)
Rate:             207.07MiB/s
...


$ sudo btrfs scrub status --tbytes /data
...
Total to scrub:   5.14TiB
Bytes scrubbed:   0.00TiB  (0.09%)
Rate:             0.00TiB/s
...

but scrub is still running so the Rate is really not 0. The point is to
print sensible numbers for Rate regardless of the other options but with
the exception of --raw that will always print the raw numbers.

Digging in the log it seems it got broken in ec3c8428590e90
("btrfs-progs: scrub status: with --si, show rate in metric units"), the
fix should have been to add the SI modifier to the units, not forcing
the unit_mode from the command line.

