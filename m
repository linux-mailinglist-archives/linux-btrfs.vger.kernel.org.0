Return-Path: <linux-btrfs+bounces-1985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F514844F09
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 03:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A95B1F27F05
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF1125D2;
	Thu,  1 Feb 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLjVtD/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FB3iDdYZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZLjVtD/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FB3iDdYZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E474FC10
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753541; cv=none; b=e+aNyOLN05tb0d+ISZVNfpvSVIY8+F1QARWraRc17ii6UrpS/gAbMkCBkS5HTiGaEvcwNGbLFLLF2Y0ZL6umJPd/dEvprlLEawBzqC4OL6/5PmpqjeHmfFsYcN2/5AqFfPei82vKqNET7wJVafCqeKqWDmZ4O7Iw59H+evRuT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753541; c=relaxed/simple;
	bh=x5bW4zP4tGF3OKD2I/xNQhBtf5AuGKHYj0RT7J5JvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYhqOTv8UvR2v3YvkXgLGeNilfFYYy5gr1rHX3crQG+Y/2GhWFeqszQlkR5yBIZu0S7NdssbYBW7iFcsYD7LvlyVjCHCc0GZKW4mM20Mo0dPlq7sRycf+B51L4LzCWLEYsFUkf2+QnQSGHuus73T5+XIju52vgQM/8n6FXjo73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLjVtD/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FB3iDdYZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZLjVtD/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FB3iDdYZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7013421EAF;
	Thu,  1 Feb 2024 02:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706753537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KUsD0v1oCi3ZrYplU1DcVq2WWjP3nLQfRrIzdEbioQ=;
	b=ZLjVtD/Tex/d0Lf/GcJtHrmWP85XofiKQgV93mA5OOMCLuggOeMJrPN0NT7LHtryecY+1j
	kqYKzb6OJ3d6wJAJn53Qfg4YprQ35mdnFbSjMxhRg9k7kMVPQvI3czs4NpFfWKlHRRxlUE
	be7L38Ho76eTEE9TDR1DqRrbVJBZwn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706753537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KUsD0v1oCi3ZrYplU1DcVq2WWjP3nLQfRrIzdEbioQ=;
	b=FB3iDdYZU2m7Vg07Jsc5KxGMPNulB/wYx5jeiGDPYFQdjxVzEk17NqG70FfW2X/AavLr+i
	NOqbLJqkBq6tvGAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706753537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KUsD0v1oCi3ZrYplU1DcVq2WWjP3nLQfRrIzdEbioQ=;
	b=ZLjVtD/Tex/d0Lf/GcJtHrmWP85XofiKQgV93mA5OOMCLuggOeMJrPN0NT7LHtryecY+1j
	kqYKzb6OJ3d6wJAJn53Qfg4YprQ35mdnFbSjMxhRg9k7kMVPQvI3czs4NpFfWKlHRRxlUE
	be7L38Ho76eTEE9TDR1DqRrbVJBZwn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706753537;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2KUsD0v1oCi3ZrYplU1DcVq2WWjP3nLQfRrIzdEbioQ=;
	b=FB3iDdYZU2m7Vg07Jsc5KxGMPNulB/wYx5jeiGDPYFQdjxVzEk17NqG70FfW2X/AavLr+i
	NOqbLJqkBq6tvGAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5125E138FB;
	Thu,  1 Feb 2024 02:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BSZXEwH+umX7fAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 01 Feb 2024 02:12:17 +0000
Date: Thu, 1 Feb 2024 03:11:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>,
	"clm@meta.com" <clm@meta.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Message-ID: <20240201021151.GU31555@suse.cz>
Reply-To: dsterba@suse.cz
References: <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
 <9624d589-43ff-40c6-81af-2c7b577edb22@wdc.com>
 <20240131185843.GR31555@twin.jikos.cz>
 <6ljnyrwminqxmtjmdozivtdgaiymp75xytxxvbgpkznpv3chwa@4v2r3emp5ko7>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ljnyrwminqxmtjmdozivtdgaiymp75xytxxvbgpkznpv3chwa@4v2r3emp5ko7>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ZLjVtD/T";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FB3iDdYZ
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.19%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.09
X-Rspamd-Queue-Id: 7013421EAF
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Thu, Feb 01, 2024 at 01:16:40AM +0000, Naohiro Aota wrote:
> On Wed, Jan 31, 2024 at 07:58:43PM +0100, David Sterba wrote:
> > On Wed, Jan 31, 2024 at 02:15:32PM +0000, Johannes Thumshirn wrote:
> > > On 31.01.24 08:15, Naohiro Aota wrote:
> > Yes we use the *_ONCE helpers for values set from sysfs in cases where
> > it's without bad effects to race and change the value in the middle.
> > Here it would only skip one checksum offload/sync. It's not really a
> > guard but a note that there's something special about the value.
> 
> Sure. I'll use it just in case.
> 
> Maybe, we want to convert fs_devices->read_policy as well, to prepare for
> the feature we have more read policies implemented?

Yes indeed, good catch.

