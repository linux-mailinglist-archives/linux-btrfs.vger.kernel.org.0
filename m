Return-Path: <linux-btrfs+bounces-14307-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8AAC8CB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2632D4E2002
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3815220F35;
	Fri, 30 May 2025 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uE+TLZUx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnYIVdce";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uE+TLZUx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tnYIVdce"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8E374D1
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603893; cv=none; b=OJevfns1kpOsmPC3GSbY4umHDdC7/3vAagHyNFgYFL74js0foFP/nIhoJVyOgNXUo0/uPhY/JLPd5Y4oS0PL33UeldvXQGRcJQ/hoFdeNq3ob5LOop6FXM2/o7vecaTbsgC6xxTTZ7QjiPrNHw/hSS1wozMo0UXa3Vw7oRy8ZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603893; c=relaxed/simple;
	bh=3ZFKJqKtHQoiSJTzaMJtNiF9Rj2FB5mN/Xse+Ssyybw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEUIG6YtMGWkJP5OU+sTUTXa+1PL9JhYnEv5sbUc7T0qnZKrfFNyEKhUMQEHO5eifoX/MCaRVme7R0Mh5tK5WIv8pwNNQttp0bJitciWLpaR0Xgv6DSkCYKN0gXWyfH9DnBYyluEEUwdjxATNeq57eoxHqZEd0lY/BbUGdmqlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uE+TLZUx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnYIVdce; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uE+TLZUx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tnYIVdce; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B516C21A1E;
	Fri, 30 May 2025 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ee7DcsfttPBsdbQBVwyoF0+E35YPmXYz95OMjUEjwlM=;
	b=uE+TLZUx8haOlC9IKu6ES4dKLBYcfkFaNitHNPo0q3bv2YYzA9+QHTWYH8/RepRQU6tDg4
	LT0tgLbhLi9Uym7cMxvewQz8ocjcuMoqGiZs8XfSDzspB88B0zKdIs5H8XNYrSaXXRXb5o
	V/9mSMZSbmrG8ZktvAavpBNALk7xo7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ee7DcsfttPBsdbQBVwyoF0+E35YPmXYz95OMjUEjwlM=;
	b=tnYIVdceh12/gXOe3Z0EfpxF7ofI5Xx+qa4impMV523SLD5zx5MIo05OocShk8p6UytyoQ
	kVxHtpTeLYTuhiAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ee7DcsfttPBsdbQBVwyoF0+E35YPmXYz95OMjUEjwlM=;
	b=uE+TLZUx8haOlC9IKu6ES4dKLBYcfkFaNitHNPo0q3bv2YYzA9+QHTWYH8/RepRQU6tDg4
	LT0tgLbhLi9Uym7cMxvewQz8ocjcuMoqGiZs8XfSDzspB88B0zKdIs5H8XNYrSaXXRXb5o
	V/9mSMZSbmrG8ZktvAavpBNALk7xo7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603889;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ee7DcsfttPBsdbQBVwyoF0+E35YPmXYz95OMjUEjwlM=;
	b=tnYIVdceh12/gXOe3Z0EfpxF7ofI5Xx+qa4impMV523SLD5zx5MIo05OocShk8p6UytyoQ
	kVxHtpTeLYTuhiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 994B913889;
	Fri, 30 May 2025 11:18:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kho8JfGTOWhhEgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:18:09 +0000
Date: Fri, 30 May 2025 13:18:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/6] btrfs-progs: fix-data-checksum: introduce
 interactive mode
Message-ID: <20250530111808.GT4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747295965.git.wqu@suse.com>
 <c0f551f03f8d81e2a46e35a08339ef096b46984f.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f551f03f8d81e2a46e35a08339ef096b46984f.1747295965.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, May 15, 2025 at 05:30:19PM +0930, Qu Wenruo wrote:
> --- a/cmds/rescue-fix-data-checksum.c
> +++ b/cmds/rescue-fix-data-checksum.c
> @@ -14,6 +14,7 @@
>   * Boston, MA 021110-1307, USA.
>   */
>  
> +#include <ctype.h>
>  #include "kerncompat.h"

The kerncompat.h needs to be first as there are workarounds for some
system includes. This has been unified everywhere else so please stick
to the ordering.

>  #include "kernel-shared/disk-io.h"
>  #include "kernel-shared/ctree.h"
> @@ -45,6 +46,21 @@ struct corrupted_block {
>  	unsigned long *error_mirror_bitmap;
>  };
>  
> +enum fix_data_checksum_action_value {
> +	ACTION_IGNORE,
> +	ACTION_LAST,
> +};
> +
> +static const struct fix_data_checksum_action {
> +	enum fix_data_checksum_action_value value;
> +	const char *string;
> +} actions[] = {
> +	[ACTION_IGNORE] = {
> +		.value = ACTION_IGNORE,
> +		.string = "ignore",
> +	},
> +};
> +
>  static int global_repair_mode;
>  LIST_HEAD(corrupted_blocks);
>  
> @@ -241,10 +257,49 @@ next:
>  	return ret;
>  }
>  
> @@ -277,6 +332,16 @@ static void report_corrupted_blocks(struct btrfs_fs_info *fs_info)
>  			error("failed to iterate involved files: %m");
>  			break;
>  		}
> +		switch (mode) {
> +		case BTRFS_FIX_DATA_CSUMS_INTERACTIVE:
> +			action = ask_action();
> +			UASSERT(action == ACTION_IGNORE);
> +			fallthrough;
> +		case BTRFS_FIX_DATA_CSUMS_READONLY:
> +			break;
> +		default:
> +			UASSERT(0);

I haven't fixed that but please don't do the ASSERT(0), we have
INTERNAL_ERROR for runtime errors or handle it and return with a hard
exit.

> +		}
>  	}
>  }

