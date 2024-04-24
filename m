Return-Path: <linux-btrfs+bounces-4519-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0D18B0A04
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 14:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB9B265FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937B15B990;
	Wed, 24 Apr 2024 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4A8gGgL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N9HEeACT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4A8gGgL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N9HEeACT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792015B137
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962973; cv=none; b=Hal1GIAb82pBqRhzX0HoM9zRWt5aHOuwryErzrnfuqYqXR74RpAaNP/joNdv00U+XX2Mft2b3Q9JQowaPCv33eh21SPsDT2CGUw9u8u4GXhwfs/k65Ivm3tX1Bb6oD4IcmvKXDUX5YQaTvrJ7sG8U0wZAWKqdSRQkQ1+MgPYWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962973; c=relaxed/simple;
	bh=/7l9/cpSho1sQ0fvpoMdwRF9Hvas76A3xiZlLcrc5EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNfVRnpfCEU1WkvJsI7UE9qlMmPfzfDJmv6Alla4tOXuCdqzn1cNfq9cUBPtxgps/hqViWWZw+uciNL1fb/tLca07aA5fLXh/S+0BJqhgMnM2z2sHwMxkm1pVuz0O9BZmzj+V+8s78avrrc5aFcmWgOGQYjQaDzwAVoxhOLfp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4A8gGgL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N9HEeACT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4A8gGgL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N9HEeACT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74CCC3F2EB;
	Wed, 24 Apr 2024 12:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713962969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzuWoLVnobUNal9RWEArvXfVRLjo0Gh3ahxbaSkTSjw=;
	b=J4A8gGgLQQoyq5PnAMC10TG65GVtj6K9kzFxD8Wpo+Y0BUJfhbfjAVC1eeiim30OKRNdHP
	5RnIEZ82j8Qu2JZgx1U4/WyEPcgioAIn/Zv3x6zkfhQqj3NbXdOcE85QPjNV+iBPMgPc/M
	9xGYpqQAZUT2gYN0s6LD/ySxhPZ9pxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713962969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzuWoLVnobUNal9RWEArvXfVRLjo0Gh3ahxbaSkTSjw=;
	b=N9HEeACTGnoL8ny0RFbWHt2Q9R06rNQGQn8TWxKNax6Yesjt5EPaBb4RZ7Sv4NSvLcq+Se
	hYn4zlNXErs+4eDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713962969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzuWoLVnobUNal9RWEArvXfVRLjo0Gh3ahxbaSkTSjw=;
	b=J4A8gGgLQQoyq5PnAMC10TG65GVtj6K9kzFxD8Wpo+Y0BUJfhbfjAVC1eeiim30OKRNdHP
	5RnIEZ82j8Qu2JZgx1U4/WyEPcgioAIn/Zv3x6zkfhQqj3NbXdOcE85QPjNV+iBPMgPc/M
	9xGYpqQAZUT2gYN0s6LD/ySxhPZ9pxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713962969;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzuWoLVnobUNal9RWEArvXfVRLjo0Gh3ahxbaSkTSjw=;
	b=N9HEeACTGnoL8ny0RFbWHt2Q9R06rNQGQn8TWxKNax6Yesjt5EPaBb4RZ7Sv4NSvLcq+Se
	hYn4zlNXErs+4eDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F3561393C;
	Wed, 24 Apr 2024 12:49:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W2UWF9n/KGYidQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 24 Apr 2024 12:49:29 +0000
Date: Wed, 24 Apr 2024 14:41:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, boris@bur.io
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240424124156.GO3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.77 / 50.00];
	BAYES_HAM(-2.77)[98.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -3.77
X-Spam-Flag: NO

On Fri, Apr 19, 2024 at 07:16:53PM +0930, Qu Wenruo wrote:
> Currently if we fully removed a subvolume (not only unlinked, but fully
> dropped its root item), its qgroup would not be removed.
> 
> Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.

There's also an option 'btrfs subvolume delete --delete-qgroup' that
does that and is going to be default in 6.9. With this kernel change it
would break the behaviour of the --no-delete-qgroup, which is there for
the case something depends on that.  For now I'd rather postpone
changing the kernel behaviour.

