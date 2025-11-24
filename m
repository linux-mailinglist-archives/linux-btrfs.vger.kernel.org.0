Return-Path: <linux-btrfs+bounces-19303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC8AC82091
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C624A349A48
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577D3191D4;
	Mon, 24 Nov 2025 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xb5/L/2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4m0i0P0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xb5/L/2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q4m0i0P0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D5317702
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007753; cv=none; b=KJL3RbLJE2kM7eaA/toBgFrgaGGHXLXrbd+b0Xw3jyQgbqgZgEKACL297PY7h655N2m9cVdtBJY5jCB0E2g6JsAjpMEi9PpE16T/fCcFfhUSn6TLWfaFhU5OquXOfmevv15CLEVe3AhsK0EK7cS9IWcaMkVRp+WvEB76iAvjs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007753; c=relaxed/simple;
	bh=+jKeJZfpPxTC2i3xf26RgLNmtF2TbOO4PZbQm7e6hFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtksozchYPNdZCeTppwyHjU3BP7RXSKNdTk7o3Nn6+sa9t+/J+wK1ODYkH0BgOAfgKEF2szKRFqBF82xFNdHv9+GxpZKGY+1eYmD5ynaT4YvlvqPce0wfZhXVHN2ipj6FQ1HywIxo/H97pDl8se5TXD9wjh3Ux+M51Ne9qPoVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xb5/L/2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4m0i0P0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xb5/L/2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q4m0i0P0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BFBB5BD7F;
	Mon, 24 Nov 2025 18:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764007749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYJceS8e1GQiXDpDXbr1qo6aKLEpp5llriDLYL5+/tI=;
	b=Xb5/L/2gjP7rJp0E30Rsr6Wn7zl7XBwXQxH5hxvO4SyiARv8EkfzlUUqpYyqa8lFh2f2tH
	PSTCqR/qOwaq+3Pm6asQeohNE0F4ye42tJmDxHcgn9QngqMD/EOvsT5heD/9Nj9p7sxfDf
	RcHUwz/dhGxsi24EzilRz79tyMS35Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764007749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYJceS8e1GQiXDpDXbr1qo6aKLEpp5llriDLYL5+/tI=;
	b=Q4m0i0P0Yxy0FQZWBs9scFbvO5JZw4JYk43YlAG8Q+4cmxzik238nDZ0xeSYe1E4uNp9vw
	IdGPiDSg7hcwkvAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764007749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYJceS8e1GQiXDpDXbr1qo6aKLEpp5llriDLYL5+/tI=;
	b=Xb5/L/2gjP7rJp0E30Rsr6Wn7zl7XBwXQxH5hxvO4SyiARv8EkfzlUUqpYyqa8lFh2f2tH
	PSTCqR/qOwaq+3Pm6asQeohNE0F4ye42tJmDxHcgn9QngqMD/EOvsT5heD/9Nj9p7sxfDf
	RcHUwz/dhGxsi24EzilRz79tyMS35Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764007749;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYJceS8e1GQiXDpDXbr1qo6aKLEpp5llriDLYL5+/tI=;
	b=Q4m0i0P0Yxy0FQZWBs9scFbvO5JZw4JYk43YlAG8Q+4cmxzik238nDZ0xeSYe1E4uNp9vw
	IdGPiDSg7hcwkvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FA6B3EA63;
	Mon, 24 Nov 2025 18:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +i0EG0WfJGkjZQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Nov 2025 18:09:09 +0000
Date: Mon, 24 Nov 2025 19:09:04 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: simplify async csum synchronization
Message-ID: <20251124180904.GR13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251113101731.2624000-1-neelx@suse.com>
 <20251118120716.GT13846@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118120716.GT13846@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: *
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 1.00

On Tue, Nov 18, 2025 at 01:07:16PM +0100, David Sterba wrote:
> On Thu, Nov 13, 2025 at 11:17:30AM +0100, Daniel Vacek wrote:
> > We don't need the redundant completion csum_done which marks the
> > csum work has been executed. We can simply flush_work() instead.
> > 
> > This way we can slim down the btrfs_bio structure by 32 bytes matching
> > it's size to what it used to be before introducing the async csums.
> > Hence not making any change with respect to the structure size.
> > ---
> > This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
> > for-next and can be squashed into it.
> > 
> > v2: metadata is not checksummed here so use the endio_workers workqueue
> >     unconditionally. Thanks to Qu Wenruo.
> 
> This looks quite useful regarding the size reduction of btrfs_bio,
> please fold it to the patch. Thanks.

The 6.19 branch is now frozen so this patch will be applied separately
later.

