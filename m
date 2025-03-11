Return-Path: <linux-btrfs+bounces-12206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E232A5D1B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 22:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99A6189E038
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 21:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A1263C77;
	Tue, 11 Mar 2025 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RjOhHPqX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e0WR1VkZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RjOhHPqX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e0WR1VkZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFA199FBA
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728305; cv=none; b=Vym9YYqDNVRhAZhAPvN/yNbCLWKO5xdGtKeja0pUcErvXgxOe8xIubEkg0VGKiDP1CX1+okwdQItOdB/PNq7j7ipUdiS2E7C4d8fn58fZgQMFcABca2BckQedVrzSg+2UtBft5NwyqDQBtPddvyQ9ds/e/5Mnpn6KkTRcX2Mh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728305; c=relaxed/simple;
	bh=AbC0Eh/bCO8bkgzKuJhSqs2/byJ0XcqV4f/kw2cCRqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp0gSRen2p/XQP9OFkOhjY+rttlORKJeW6WGT/6IpwDDOhlruSXGifEd9/Ad+tQs6ME5g7Lwgub/EFyzThItSb0ytRFASrwwjHzBbqanzL786KOjbpTWxJ+FhZtAGX+xf3qn2zYU+wFLl4q4u0d1lperkosIP0AOUzWpy2PVt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RjOhHPqX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e0WR1VkZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RjOhHPqX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e0WR1VkZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E65521185;
	Tue, 11 Mar 2025 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741728301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7cw3j71tIexoGgspK07YE7GeKf5/fir9IDO8paMXAc=;
	b=RjOhHPqX379PvvuYDo8TUIv9lqu/K/CxZXVMICeaNf9xhVbkKiwLqmZbR4yp8E9WEOK7i9
	N3R4csY0wDkX+P2+X1KLQSgNLsLLPbANSzbHRPmt/NQwBqXO4I5htFCAMCJQf1KRGzrXFj
	HO4Sqm+FrFb6S6r+yGZlQnee+70brco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741728301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7cw3j71tIexoGgspK07YE7GeKf5/fir9IDO8paMXAc=;
	b=e0WR1VkZABY5hitPh1in3EbUFlmwhSiJTxHX+06e8b82A7I7cLbGveu4dBv7D30NwPj4fh
	7iYE/fkR6+H+UlBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RjOhHPqX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e0WR1VkZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741728301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7cw3j71tIexoGgspK07YE7GeKf5/fir9IDO8paMXAc=;
	b=RjOhHPqX379PvvuYDo8TUIv9lqu/K/CxZXVMICeaNf9xhVbkKiwLqmZbR4yp8E9WEOK7i9
	N3R4csY0wDkX+P2+X1KLQSgNLsLLPbANSzbHRPmt/NQwBqXO4I5htFCAMCJQf1KRGzrXFj
	HO4Sqm+FrFb6S6r+yGZlQnee+70brco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741728301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7cw3j71tIexoGgspK07YE7GeKf5/fir9IDO8paMXAc=;
	b=e0WR1VkZABY5hitPh1in3EbUFlmwhSiJTxHX+06e8b82A7I7cLbGveu4dBv7D30NwPj4fh
	7iYE/fkR6+H+UlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EF80134A0;
	Tue, 11 Mar 2025 21:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JdWnDi2q0GdBUwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 11 Mar 2025 21:25:01 +0000
Date: Tue, 11 Mar 2025 22:24:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add slack space for mkfs --shrink
Message-ID: <20250311212452.GL32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fbe3a75e21a89d8fb3013c55468de7fd03b5027e.1741651032.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe3a75e21a89d8fb3013c55468de7fd03b5027e.1741651032.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6E65521185
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Mar 10, 2025 at 05:10:31PM -0700, Leo Martins wrote:
> This patch adds an optional argument to the 'mkfs --shrink' option
                     ^^^^^^^^^^^^^^^^^
I'd rather avoid optional parameters, it's a bit better for long options
but still can be confusing. Definitely no optional parameters for short
options.  New long option is fine in this case.

> allowing users to specify slack when shrinking the filesystem.
> Previously if you wanted to use --shrink and include extra space in the
> filesystem you would need to use btrfs resize, however, this requires
> mounting the filesystem which requires CAP_SYS_ADMIN.

The use case makes sense.

> The new syntax is:
> mkfs.btrfs --shrink[=SLACK SIZE]
> 
> Where [SLACK SIZE] is an optional argument specifying the desired
> slack size. If not provided, the default slack size is 0.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  mkfs/main.c    | 15 +++++++++++----
>  mkfs/rootdir.c | 15 ++++++++++++---
>  mkfs/rootdir.h |  2 +-
>  3 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index dc73de47..11a5a4a9 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -460,7 +460,7 @@ static const char * const mkfs_usage[] = {
>  	OPTLINE("", "- ro - create the subvolume as read-only"),
>  	OPTLINE("", "- default - the SUBDIR will be a subvolume and also set as default (can be specified only once)"),
>  	OPTLINE("", "- default-ro - like 'default' and is created as read-only subvolume (can be specified only once)"),
> -	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
> +	OPTLINE("--shrink[=SLACK SIZE]", "(with --rootdir) shrink the filled filesystem to minimal size, optionally include extra slack space after shrinking (default 0)"),
>  	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
>  	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
>  	"",
> @@ -1176,6 +1176,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  	u64 source_dir_size = 0;
>  	u64 min_dev_size;
>  	u64 shrink_size;
> +	u64 shrink_slack_size = 0;
>  	int device_count = 0;
>  	int saved_optind;
>  	pthread_t *t_prepare = NULL;
> @@ -1246,7 +1247,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  				GETOPT_VAL_DEVICE_UUID },
>  			{ "quiet", 0, NULL, 'q' },
>  			{ "verbose", 0, NULL, 'v' },
> -			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
> +			{ "shrink", optional_argument, NULL, GETOPT_VAL_SHRINK },
>  			{ "compress", required_argument, NULL,
>  				GETOPT_VAL_COMPRESS },
>  #if EXPERIMENTAL
> @@ -1381,6 +1382,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  				strncpy_null(dev_uuid, optarg, BTRFS_UUID_UNPARSED_SIZE);
>  				break;
>  			case GETOPT_VAL_SHRINK:
> +				shrink_slack_size = optarg == NULL ? 0 : arg_strtou64_with_suffix(optarg);

The value need to be validated and checked for alignment, something
close to what would work for resize.

>  				shrink_rootdir = true;
>  				break;
>  			case GETOPT_VAL_CHECKSUM:
> @@ -2107,9 +2109,14 @@ raid_groups:
>  		}
>  
>  		if (shrink_rootdir) {
> -			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
> +			pr_verbose(
> +				LOG_DEFAULT,
> +				"  Shrink:           yes          (slack size: %s)\n",

Please put it on a separate line if slack is > 0.

> +				pretty_size(shrink_slack_size));
>  			ret = btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
> -						   shrink_rootdir);
> +						   shrink_rootdir,
> +						   shrink_slack_size);
> +
>  			if (ret < 0) {
>  				errno = -ret;
>  				error("error while shrinking filesystem: %m");
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 19273947..176e6528 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -1924,7 +1924,7 @@ err:
>  }
>  
> @@ -1948,14 +1948,23 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
>  		return ret;
>  	}
>  
> +	device = list_entry(fs_info->fs_devices->devices.next,
> +			   struct btrfs_device, dev_list);
> +
> +	new_size += slack_size;
> +	if (new_size > device->total_bytes) {
> +		warning("fs size with slack: %llu (%s) is larger than device size: %llu (%s)\n"
> +			"         consider decreasing slack size or increasing device size",

Please use "\t..." on the continuation line.

> +			new_size, pretty_size(new_size), device->total_bytes,
> +			pretty_size(device->total_bytes));
> +	}
> +
>  	if (!IS_ALIGNED(new_size, fs_info->sectorsize)) {
>  		error("shrunk filesystem size %llu not aligned to %u",
>  				new_size, fs_info->sectorsize);
>  		return -EUCLEAN;
>  	}
>  
> -	device = list_entry(fs_info->fs_devices->devices.next,
> -			   struct btrfs_device, dev_list);
>  	ret = set_device_size(fs_info, device, new_size);
>  	if (ret < 0)
>  		return ret;

