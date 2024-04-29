Return-Path: <linux-btrfs+bounces-4620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8D8B5BC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6C4B260C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75E80603;
	Mon, 29 Apr 2024 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bHFlRjW3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+tD3Z8Ng";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ccbs4OuD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QmAcgFgh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0A7F48C
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401934; cv=none; b=FO7MXp6P7PISDsJFdVJXmYsQmh++O6RP5DLJAtSEQ+Oi+FemfjTUNr4O5aEtQYFAdHmAiJWbGQrPKoqE+LPVdEq7pjeLHgRDGitT1ceJExhD1BrsR1MSmOP7yFHYx6phKA42H5g14xbdYaXWDAgf8YtexwWMiHL2wo2PprHGXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401934; c=relaxed/simple;
	bh=JTVwWxafa6GMirUHcqdK0dCMMIGiMbLjYqOoZc0Y27o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D04O8Xv+xrlpGHBW+OCLefjrcE0OavUgqjJhcEKIx0h25XbBCJBs+9VP2jfjFa9aFPQwKH+wuqkPdNUiwAjw+91VoNb0wmLg9D8xUk4jaUNwYMtmc8X5wSjv84N7U5pYmWWF3MFRlJy1obd28nTxfnQ8c/4xOvEt/Dh6xApR15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bHFlRjW3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+tD3Z8Ng; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ccbs4OuD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QmAcgFgh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED81921A8F;
	Mon, 29 Apr 2024 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714401931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=koiMH378bOEFqxnqJTp0ebV0i6DJRL7/m8TRh0i6K6I=;
	b=bHFlRjW3hbVJdC+ZXYiGvtb0uA0Lz/BjE7uPwCpx7SmlC6nwWyNIIugGry9HeOz++ZVXv2
	ufB6Fo/h/P/cJtra2/2NraqHHinoZdxvcAByjn5rJvevEGwPu16WsOaupt4kzFebyHCprP
	mBOKu5U/OsC7KAsTw2ZWuXMyb2hOfAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714401931;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=koiMH378bOEFqxnqJTp0ebV0i6DJRL7/m8TRh0i6K6I=;
	b=+tD3Z8Ngm65cK6TPnBdAAyWtUA68TDBgN1Ylk7ZKfRc/7379HjrqBd8zVpJnkKFUC5syd+
	lI/1lodINF3gUiCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714401930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=koiMH378bOEFqxnqJTp0ebV0i6DJRL7/m8TRh0i6K6I=;
	b=Ccbs4OuD2Zx8q/uBQdtPHU4gUsBGdjiuNFpADcPjOuhTQDaY0Cf4LqH4WvVvETSxLPwb2G
	gGusqDgZlEii/KTRg6lWHkMvBJD5FUqwtoiKtSBmrjvuSoWr+IHNziYVY43sfRIHQP1C2F
	vDggKlLJ+t3EnupMdgZcRLt5vca5spU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714401930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=koiMH378bOEFqxnqJTp0ebV0i6DJRL7/m8TRh0i6K6I=;
	b=QmAcgFghBE2wPuqMwOjzr1pJ4yqrbqgd4UtPm5d3nbXcsFhA7DG7W6OREo0DpaivC1AYwQ
	sKCXDh9nmQjHMbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC844138A7;
	Mon, 29 Apr 2024 14:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nzlkNYqyL2baDwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 14:45:30 +0000
Date: Mon, 29 Apr 2024 16:38:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/17] btrfs: handle errors in btrfs_reloc_clone_csums
 properly
Message-ID: <20240429143817.GB2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713363472.git.josef@toxicpanda.com>
 <e76b91d488261dc5a5dd3f042a55c04cdc94c7f3.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76b91d488261dc5a5dd3f042a55c04cdc94c7f3.1713363472.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Wed, Apr 17, 2024 at 10:35:45AM -0400, Josef Bacik wrote:
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3183,9 +3183,8 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
>  		 * set the mapping error, so we need to set it if we're the ones
>  		 * marking this ordered extent as failed.
>  		 */
> -		if (ret && !test_and_set_bit(BTRFS_ORDERED_IOERR,
> -					     &ordered_extent->flags))
> -			mapping_set_error(ordered_extent->inode->i_mapping, -EIO);
> +		if (ret)
> +			btrfs_mark_ordered_extent_error(ordered_extent);

This change makes the comment above the code out of sync, it explains
why the BTRFS_ORDERED_IOERR is needed, you remove it.

