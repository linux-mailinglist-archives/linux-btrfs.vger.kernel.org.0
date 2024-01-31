Return-Path: <linux-btrfs+bounces-1968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6838446ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 19:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F60B25BE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2141350CD;
	Wed, 31 Jan 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFkAp9Yf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MlwxxA2M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFkAp9Yf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MlwxxA2M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B712FF78
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724898; cv=none; b=eZgtPC3EJeOqoDVFXGX4M75iNN2AqLiXR9xZ/ju9p3xlF0nUmSIWPfl8COn/aeZ1Dxc3Y8tnH64s/TLKWfivH5c7B75FC8p9kYbATp0etgXFMYJLebh5/YymOnysXWKz2G5aa/TTt3E+tlcXlYz4doqWHoTNfHFx3bHL1t/VZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724898; c=relaxed/simple;
	bh=bDmjGmMmGj7WbaEOcFCIfQ4d3JpXvagnOHVSUCDDViQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfoZDZs7No2ACK0ByEmGu7MXbNAiU61Fr6Q30PkWhDJYN9INXshXqAFqxlvfNPl+zpMwRLodl0pEs951cVjUwqyYPliIERFFDoCP14FXeCZAR2nSbWeZYGZph5KvrQg4DU9AGlKKwJUd8NFCOKbXFNbZ9TTujPdalWVmgQNaUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFkAp9Yf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MlwxxA2M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFkAp9Yf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MlwxxA2M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EB9121ED3;
	Wed, 31 Jan 2024 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86lIsz3R32zpzvyrpwibj9Ie7rzEjEUw7K1OhXCfZoU=;
	b=HFkAp9YfRLajzkRI+LyfeKzsOYRWjLxttTPDnv5deNAEtjD0rbjg9UbAs/p2xkPzkkEYbD
	xn6tuXNV3lx2ljLnq1ws+8BMCE1xNpEJTfHnWWegwuvjuKzWpqy7GbgOLdFe4UDkb0lx5p
	yefWPYD3SeK2z28g1htCdSxivwWSRr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86lIsz3R32zpzvyrpwibj9Ie7rzEjEUw7K1OhXCfZoU=;
	b=MlwxxA2Mcn6/qHhlCJlpT63zDO+i6wtwkoNIIkMViJKfFp/Hn3LhEZ+++p4yrAtIelgylG
	Z/q6Iaad52HbWZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706724895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86lIsz3R32zpzvyrpwibj9Ie7rzEjEUw7K1OhXCfZoU=;
	b=HFkAp9YfRLajzkRI+LyfeKzsOYRWjLxttTPDnv5deNAEtjD0rbjg9UbAs/p2xkPzkkEYbD
	xn6tuXNV3lx2ljLnq1ws+8BMCE1xNpEJTfHnWWegwuvjuKzWpqy7GbgOLdFe4UDkb0lx5p
	yefWPYD3SeK2z28g1htCdSxivwWSRr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706724895;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86lIsz3R32zpzvyrpwibj9Ie7rzEjEUw7K1OhXCfZoU=;
	b=MlwxxA2Mcn6/qHhlCJlpT63zDO+i6wtwkoNIIkMViJKfFp/Hn3LhEZ+++p4yrAtIelgylG
	Z/q6Iaad52HbWZAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 74323139D9;
	Wed, 31 Jan 2024 18:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id n8w6HB+OumXzIwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 18:14:55 +0000
Date: Wed, 31 Jan 2024 19:14:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Message-ID: <20240131181429.GN31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <20240131071319.GH31555@twin.jikos.cz>
 <eba1ef68-12f8-4c57-932b-e53e0c0c059b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba1ef68-12f8-4c57-932b-e53e0c0c059b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.06
X-Spamd-Result: default: False [-1.06 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[60.82%]
X-Spam-Flag: NO

On Wed, Jan 31, 2024 at 06:37:26PM +1030, Qu Wenruo wrote:
> >> +static LIST_HEAD(locked_devices);
> >> +
> >> +/*
> >> + * This is to record flock()ed devices.
> >> + * For flock() to prevent udev races, we must lock the parent block device,
> >> + * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that case
> >> + * we should only lock "/dev/sda" once.
> >> + *
> >> + * This structure would be used to record any flocked block device (not
> >> + * the partition one), and avoid double locking.
> >> + */
> >> +struct btrfs_locked_wholedisk {
> >
> > Please pick a different name, we've been calling it devices, although
> > you can find 'disk' references but mainly for historical reasons (eg.
> > when it's in a structure). In this case it's a block device.
> >
> 
> Well, the "wholedisk" name is from the libblk, and I thought it may be
> good enough, but it's not the case.

I see, in that case we can keep it that way.

