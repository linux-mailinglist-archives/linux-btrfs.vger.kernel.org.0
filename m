Return-Path: <linux-btrfs+bounces-12344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0670A65EDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3033B70DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA91EB5FB;
	Mon, 17 Mar 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sRxF9Dte";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+TS3vmTn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sRxF9Dte";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+TS3vmTn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813E188907
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242328; cv=none; b=h+nnKoOTI9iJs6dxwlX80BIBRRasrxlsPFFIYz1DeN1cfgliUi8NeJMFWo957+RbAGWcQn4EYCkwr/+8bPAvvvjd9Y0mZFBUyFlUQpv0c32FC9M6kpVcSUDiwpVDsR8pyyC352gsgwndjMePhQut2kSiymtbPyu7GwR0C7b1FGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242328; c=relaxed/simple;
	bh=XScaHU5/42Q5tzew/hiRBeKhHbpETz6aAVdYabz4D6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j97nJFwWqXYf5kChyZ1M7mfl8b5N2krRgTeKaopyLmWkNW1IRmp20xLW1jz0hT8cLMQGwwGfssDOPm8dRVAG9o4Ac/5Isp+O2Mr+sLudGHILdXnhPYO1o1zU4H8gn/Nx7C15kGx7G1o5p7yFeMThtjtHuuGy5zU0LNiqvv08ecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sRxF9Dte; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+TS3vmTn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sRxF9Dte; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+TS3vmTn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5E1A21979;
	Mon, 17 Mar 2025 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742242324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XO3iID/GG/O4CrRLhmiHvQHsh8amBHfH1TngfgPK3zY=;
	b=sRxF9Dte0HJ3LLYvBak78mThxj8BnbR25X0S7gApDcSfeOiwdz8jbEI9p3ZiwNI93AE8eo
	LV8mMkD0RZKCbYv9K+XJng63Hj3Kuj64azPSbGmgd0z6oaXXz+PAK/UEw920ul8HOYQZMJ
	nIx3P3s1yA28bB5d+PhuQqAisMSJGCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742242324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XO3iID/GG/O4CrRLhmiHvQHsh8amBHfH1TngfgPK3zY=;
	b=+TS3vmTnkfzxulimq9la2fQDs5QHN1VtYM45Gb9jIGftgOGj8kplCXzyi/7L3v6AlJr1Eo
	mR2JP1lbj8hATNBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sRxF9Dte;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+TS3vmTn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742242324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XO3iID/GG/O4CrRLhmiHvQHsh8amBHfH1TngfgPK3zY=;
	b=sRxF9Dte0HJ3LLYvBak78mThxj8BnbR25X0S7gApDcSfeOiwdz8jbEI9p3ZiwNI93AE8eo
	LV8mMkD0RZKCbYv9K+XJng63Hj3Kuj64azPSbGmgd0z6oaXXz+PAK/UEw920ul8HOYQZMJ
	nIx3P3s1yA28bB5d+PhuQqAisMSJGCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742242324;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XO3iID/GG/O4CrRLhmiHvQHsh8amBHfH1TngfgPK3zY=;
	b=+TS3vmTnkfzxulimq9la2fQDs5QHN1VtYM45Gb9jIGftgOGj8kplCXzyi/7L3v6AlJr1Eo
	mR2JP1lbj8hATNBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E353132CF;
	Mon, 17 Mar 2025 20:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e3BzIhSC2GcdVgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Mar 2025 20:12:04 +0000
Date: Mon, 17 Mar 2025 21:11:55 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Ioctl to clear unused space in various ways
Message-ID: <20250317201154.GB32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1741777050.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741777050.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: A5E1A21979
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 12, 2025 at 12:12:10PM +0100, David Sterba wrote:
> Add ioctl that is similar to FITRIM and in addition to trim can do also
> zeroing (either plain overwrite, or unmap the blocks if the device
> supports it) and secure erase.
> 
> This can be used to zero the unused space in e.g. VM images (when run
> from inside the guest, if fstrim is not supported) or free space on
> thin-provisioned devices.
> 
> The secure erase is provided by blkdiscard command but I'm not aware of
> equivalent that can be run on a filesystem, so this is for parity.

I've found more things to add to the API to support more use cases so
this will be moved to another major release.  For example physical
ranges rather than logical (current FITRIM deficiency wrt btrfs),
per-device clearing. Also the cache dropping can be adjusted for a
device or range.

