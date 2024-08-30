Return-Path: <linux-btrfs+bounces-7695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CA296690B
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 20:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC68C1C239C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2941BC07B;
	Fri, 30 Aug 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HZsEbn7k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9oY8KcRV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vi9HPxUa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0g65QdIL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA83DBB6
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043225; cv=none; b=WtPgNktkMLlM1VZIyeLxmLtqV/QQQGE2izzNxYmdWLqxfIKerNgHd47h7x5LLBrmiYbFLOWWaZYmsXhcrP+ku+MwGfVvPOq7nDGzjspQT7PSKC0s87chTWHVgIhuut7suHtaikp/cC/i6tsLSox/4oIoRqFrKGAAIXWyHy7z/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043225; c=relaxed/simple;
	bh=bAggjb80SHXBGq2q9Qbt3Jbfyvekpobr2eRlb9uy91g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEthYwyn8ESUs3CrAoTp+4HVPL3yNSDFR3DD8WVL0cYqWB3bkLObio5MuAretZEmh3L4mh00FomNFwL2Pi5SIE/1Jp4Ld7oPsYJlHOP03k2ivAou/YCZQ0PXKnPG5v+qVbqN9gkP/L2Gh1AdTh33erJ+P1ygr4NOZ3IC5b0oPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HZsEbn7k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9oY8KcRV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vi9HPxUa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0g65QdIL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A2B21F7E7;
	Fri, 30 Aug 2024 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725043221;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9iEXfI0Vp7BSJRK34wE+CapVFrYsmbLzWgwTj7aPZGQ=;
	b=HZsEbn7kyYmwR8EP6lWTQf1bDcXIoPy1NcWw8m1flDjObjL3DZ60A5KsZUMgWQW6QyN4vl
	SsIDuSouVkmzPKUgQDvtj+ZhbuPtfS1I7bAkLiX0ndrC3SLrT24nw4ROFpAu3+O4rAqhy+
	gBB5R4++R9LJEEJh9swCak5KQ6gBlvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725043221;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9iEXfI0Vp7BSJRK34wE+CapVFrYsmbLzWgwTj7aPZGQ=;
	b=9oY8KcRVinBOHm1ovmBBdx/PgmZiaYyUzOSGRFcIy6FJhTwyOSzOm9ypmxpfda+Jg4mgkE
	GD7qqH4Hr1BnN2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725043220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9iEXfI0Vp7BSJRK34wE+CapVFrYsmbLzWgwTj7aPZGQ=;
	b=Vi9HPxUaxHz185oCPuyoliKAZ2lLSC4b4K3DRYfv+c710wm4b4lYk6CzfeM7HpEgTXGMnR
	X72W0z5IYaGU8EIl8cx2LxoziiBhVfPkd+KGOvTtPufJYP60q52qz27kbYPsnhq/hVStzQ
	3d8P0FDkyjw9v2eaEPTFxVUBmeXU7oI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725043220;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9iEXfI0Vp7BSJRK34wE+CapVFrYsmbLzWgwTj7aPZGQ=;
	b=0g65QdIL7CePXbsJD6sMCDN75F9TypWiPItPMWROgZZ6G+a/4zS6vqS/0O6/kb9nbe/+MY
	myf968IZrNCLIvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F68C139D3;
	Fri, 30 Aug 2024 18:40:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cYcQBxQS0mYZMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 Aug 2024 18:40:20 +0000
Date: Fri, 30 Aug 2024 20:40:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: subpage: fix the bitmap dump which can cause
 bitmap corruption
Message-ID: <20240830184018.GV25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b93aac5fb44b46cd5391f3d5d177c0976e7d5ce0.1725001507.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93aac5fb44b46cd5391f3d5d177c0976e7d5ce0.1725001507.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 30, 2024 at 04:35:48PM +0930, Qu Wenruo wrote:
> In commit 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for
> debug") an internal macro GET_SUBPAGE_BITMAP() is introduced to grab the
> bitmap of each attribute.
> 
> But that commit is using bitmap_cut() which will do the left shift of
> the larger bitmap, causing incorrect values.
> 
> Thankfully this bitmap_cut() is only called for debug usage, and so far
> it's not yet causing problem.
> 
> Fix it to use bitmap_read() to only grab the desired sub-bitmap.
> 
> Fixes: 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for debug")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
> Changelog:
> v2:
> - Do not change the parameters of GET_SUBPAGE_BITMAP()
>   To minimal the backport needed.
> ---
>  fs/btrfs/subpage.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 663f2f953a65..ca7d2aedfa8d 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -870,9 +870,14 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct fol
>  }
>  
>  #define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
> -	bitmap_cut(dst, subpage->bitmaps, 0,				\
> -		   fs_info->sectors_per_page * btrfs_bitmap_nr_##name,	\
> -		   fs_info->sectors_per_page)
> +{									\
> +	const int sectors_per_page = fs_info->sectors_per_page;		\
> +									\
> +	ASSERT(sectors_per_page < BITS_PER_LONG);			\
> +	*dst = bitmap_read(subpage->bitmaps,				\

Eventually this can be "dst = ...", the pointer was required for
bitmap_cut, but like that it's also acceptable.

