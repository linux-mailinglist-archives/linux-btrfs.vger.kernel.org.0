Return-Path: <linux-btrfs+bounces-2112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E94849E99
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22324B29E58
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2D3B1B2;
	Mon,  5 Feb 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y5MKmUsj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7F2BYNP4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y5MKmUsj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7F2BYNP4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D03A1BA
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147487; cv=none; b=iKnVzet1AC5hd9M/n554GHJgG153EztFINJiEEktyEApxg++ZYW0UKbdBg6ySH/lZYYjFFVpvl87J85/f/YTPQsyGM6ZJWTqhjrJtjuCpPvsXDIuDuaqYKhh70uj+YhBhknH05k2s6oQI8rK4puLnWAS/5wfX60SOUsRaVfD6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147487; c=relaxed/simple;
	bh=I1+V44KTOvet5Rk9JHmITQnlzLS5YOtRyw3BSkfAUH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDoaKDEBc+zMnaH/4T8pmozRR1VOLdSjBO2X6Bh+cW90hbMbJvkmd/9916ulQmx1SdAQ58D139k4R3+GH/GALujk+FbAesqt7FuT7pqIb6E5d1gqgrkusj02rt31pqdn5KhZRJr9+pjcCps0+5LYCQepaJ+MmvtmEY6fnjbIOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y5MKmUsj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7F2BYNP4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y5MKmUsj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7F2BYNP4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 104DB21E42;
	Mon,  5 Feb 2024 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707147484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5NxTWpRCPany+NMH/JIZnZnUiHgqJ0ASZgUKy7pfuo=;
	b=y5MKmUsjjdZ64wTrlh4rUC1QaraHVESkoJOsA+E9eo+xDUXakQM9bWd1FGmcnvwovAmE60
	hq6N0aT9tXSZWD9yOvHpFLGRA4KB36zyc9aagM0UCOEr5x4sitkKG6qtMoZKfLLXvcttLM
	gRV1AnvEP6DzHS7fj9XY0Bf8qe8P9nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707147484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5NxTWpRCPany+NMH/JIZnZnUiHgqJ0ASZgUKy7pfuo=;
	b=7F2BYNP4lGiab+xW9H470i30DcmaRErD8g/u048uDLkNBDltOOGUXO2p4Ng6BmRBrqbGGT
	ysB1Lte1ZAgHbmAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707147484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5NxTWpRCPany+NMH/JIZnZnUiHgqJ0ASZgUKy7pfuo=;
	b=y5MKmUsjjdZ64wTrlh4rUC1QaraHVESkoJOsA+E9eo+xDUXakQM9bWd1FGmcnvwovAmE60
	hq6N0aT9tXSZWD9yOvHpFLGRA4KB36zyc9aagM0UCOEr5x4sitkKG6qtMoZKfLLXvcttLM
	gRV1AnvEP6DzHS7fj9XY0Bf8qe8P9nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707147484;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5NxTWpRCPany+NMH/JIZnZnUiHgqJ0ASZgUKy7pfuo=;
	b=7F2BYNP4lGiab+xW9H470i30DcmaRErD8g/u048uDLkNBDltOOGUXO2p4Ng6BmRBrqbGGT
	ysB1Lte1ZAgHbmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED542136F5;
	Mon,  5 Feb 2024 15:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z2i9OdsAwWXPAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 Feb 2024 15:38:03 +0000
Date: Mon, 5 Feb 2024 16:37:35 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject encoded write if inode has nodatasum flag
 set
Message-ID: <20240205153735.GG355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5e9fccf6a2c57b6bbd28427ca864fe838b43d394.1706876439.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9fccf6a2c57b6bbd28427ca864fe838b43d394.1706876439.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, Feb 02, 2024 at 12:22:53PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we allow an encoded write against inodes that have the NODATASUM
> flag set, either because they are NOCOW files or they were created while
> the filesystem was mounted with "-o nodatasum". This results in having
> compressed extents without corresponding checksums, which is a filesystem
> inconsistency reported by 'btrfs check'.
> 
> For example, running btrfs/281 with MOUNT_OPTIONS="-o nodatacow" triggers
> this and 'btrfs check' errors out with:
> 
>    [1/7] checking root items
>    [2/7] checking extents
>    [3/7] checking free space tree
>    [4/7] checking fs roots
>    root 256 inode 257 errors 1040, bad file extent, some csum missing
>    root 256 inode 258 errors 1040, bad file extent, some csum missing
>    ERROR: errors found in fs roots
>    (...)
> 
> So reject encoded writes if the target inode has NODATASUM set.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

