Return-Path: <linux-btrfs+bounces-14304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152CEAC8CA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56D5174A0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192722A7F8;
	Fri, 30 May 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gC/IQqrP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wPc7b9DC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gC/IQqrP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wPc7b9DC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196B226D1E
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603442; cv=none; b=c/fVGf/o/th9U8eQv/8co2+67JFks0z/+EvzAR6xVQHFYRtmCa2H5H0Q0y4rBTWVMB9IAw4t5gDWCaBYlVWLcEHwTfGhwJvURNXUdJ0IhWWPCrr4EpgB+KoHXvUb+km34RIQWNIWXNA72RyXa6NOU9o+wh9a7nQDfmMBbAnm1so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603442; c=relaxed/simple;
	bh=3z1MiakHSlepl5WACJo/NjhcI5SyRjMl+wdHgmtBsZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCJUi3/t2oUt0ilPXDzgUQYS8rhzn/H9K0eHKfVaFq20WbE7EO7DguzrRE9dQe9VBt1mAF+61tWzWGRI/2usagEJfPS1Q80uTsC5xqX1WpNFhnb0Sgo2KhAsQBY8edd/N81gpJKF9TNsJqakoFyebgaNNatplqcwu3gghpp3mAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gC/IQqrP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wPc7b9DC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gC/IQqrP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wPc7b9DC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 498BD2175B;
	Fri, 30 May 2025 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLwBrQOhP1ljC9kE4fdyAm8pzBiJrYLQ7p8Ay36HO/U=;
	b=gC/IQqrPKPpWong59bZpcHLX+K/SGVWjS7k+jK7+U8QHVev0+IUdPGWIrTp3HO28dfkGcV
	mUlJcSBOaezy+JLtJ5HZy/ghLVSXyObwQr0B8ZtmCks9GR8MW6TUBnLP3BWvlxuvMdm58j
	+evORld/1tU8TmBSILDSSD1R9SiMzro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLwBrQOhP1ljC9kE4fdyAm8pzBiJrYLQ7p8Ay36HO/U=;
	b=wPc7b9DCQYgSRGItYucOxHP5tFsfcucZhb4Tnwl6eRBMcb32NiRDZ2OIj2jXOafatGjlCI
	jzAiWX0ySkhkN8Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLwBrQOhP1ljC9kE4fdyAm8pzBiJrYLQ7p8Ay36HO/U=;
	b=gC/IQqrPKPpWong59bZpcHLX+K/SGVWjS7k+jK7+U8QHVev0+IUdPGWIrTp3HO28dfkGcV
	mUlJcSBOaezy+JLtJ5HZy/ghLVSXyObwQr0B8ZtmCks9GR8MW6TUBnLP3BWvlxuvMdm58j
	+evORld/1tU8TmBSILDSSD1R9SiMzro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603439;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLwBrQOhP1ljC9kE4fdyAm8pzBiJrYLQ7p8Ay36HO/U=;
	b=wPc7b9DCQYgSRGItYucOxHP5tFsfcucZhb4Tnwl6eRBMcb32NiRDZ2OIj2jXOafatGjlCI
	jzAiWX0ySkhkN8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CB8713889;
	Fri, 30 May 2025 11:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2u5vCi+SOWhQEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:10:39 +0000
Date: Fri, 30 May 2025 13:10:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/6] btrfs-progs: introduce "btrfs rescue
 fix-data-checksum"
Message-ID: <20250530111029.GQ4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747295965.git.wqu@suse.com>
 <a91001c175a5dd38a8873c6550bf856f1f4c5cde.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a91001c175a5dd38a8873c6550bf856f1f4c5cde.1747295965.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, May 15, 2025 at 05:30:16PM +0930, Qu Wenruo wrote:
> +static void report_corrupted_blocks(void)
> +{
> +	struct corrupted_block *entry;
> +
> +	if (list_empty(&corrupted_blocks)) {
> +		printf("No data checksum mismatch found\n");

printf(...) -> pr_verbose(LOG_DEFAULT, ...) so the verbosity options are
respected. The semantics is the same as printf, so there's no implicit "\n"
and you can glue the lines as you need.

> +		return;
> +	}
> +
> +	list_for_each_entry(entry, &corrupted_blocks, list) {
> +		bool has_printed = false;
> +
> +		printf("logical=%llu corrtuped mirrors=", entry->logical);
> +		/* Poor man's bitmap print. */
> +		for (int i = 0; i < entry->num_mirrors; i++) {
> +			if (test_bit(i, entry->error_mirror_bitmap)) {
> +				if (has_printed)
> +					printf(",");
> +				/*
> +				 * Bit 0 means mirror 1, thus we need to increase
> +				 * the value by 1.
> +				 */
> +				printf("%d", i + 1);
> +				has_printed=true;
> +			}
> +		}
> +		printf("\n");
> +	}
> +}

> +static int cmd_rescue_fix_data_checksum(const struct cmd_struct *cmd,
> +					int argc, char **argv)
> +{
> +	enum btrfs_fix_data_checksum_mode mode = BTRFS_FIX_DATA_CSUMS_READONLY;
> +	int ret;
> +	optind = 0;
> +
> +	while (1) {
> +		int c;
> +		enum { GETOPT_VAL_DRYRUN = GETOPT_VAL_FIRST, };

The ending "," does not need to be there

> +		static const struct option long_options [] = {
> +			{"readonly", no_argument, NULL, 'r'},
> +			{"NULL", 0, NULL, 0},
> +		};

Missing newline

> +		c = getopt_long(argc, argv, "r", long_options, NULL);
> +		if (c < 0)
> +			break;
> +		switch (c) {
> +		case 'r':
> +			mode = BTRFS_FIX_DATA_CSUMS_READONLY;
> +			break;
> +		default:
> +			usage_unknown_option(cmd, argv);
> +		}
> +	}
> +	if (check_argc_min(argc - optind, 1))
> +		return 1;
> +	ret = btrfs_recover_fix_data_checksum(argv[optind], mode);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to fix data checksums: %m");
> +	}
> +	return !!ret;
> +}
> +static DEFINE_SIMPLE_COMMAND(rescue_fix_data_checksum, "fix-data-checksum");

