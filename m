Return-Path: <linux-btrfs+bounces-13536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F1AA44E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 10:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D857B259D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED56213E71;
	Wed, 30 Apr 2025 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5iLQ/vZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XpZzLUxk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQM6jpKR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/h7o5oW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A12DC771
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000648; cv=none; b=aLWMyfWVO0yMtd3nmgwYNUjOkqY9iTzbKS5jcreUCCmzvnQ34HAW4B3f1Gci8VlK6YXMRNRpUj/6+XitJSKRWswxABYsEUSVUa5k8Ivs3OxYaV8X964uVO1T7Y7yim0cIbmTNwT2HWATONMoiWMzuiOtMgrVhg6lzGVC04zDLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000648; c=relaxed/simple;
	bh=kIpNaNa5e6MYSU7jIIplHc4EFS/o2wri2gqRASmOHNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJwytKupJh7jH2Fn43O+ldQ6JX7bxiz1TiRaYy8V7ffTD7UH+imCX6WJz221a+kWEoHK4f0PXlhxIR7I5AWpDOmGiUVfGS7ydEysajLyL+od2DFKIT6mEpg2Ny/JHPHuRmRWmJvWT3mCo8Qt0jIm8NPmGPis/FHPWGgDooZSjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5iLQ/vZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XpZzLUxk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQM6jpKR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/h7o5oW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF7831F7CF;
	Wed, 30 Apr 2025 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746000645;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsiRq4ZNBs/nHIvb8X/bQTyhZoKJzP3MldRac2fXF5A=;
	b=J5iLQ/vZkZQXPdc0uy0KsAYI3sGQqKGySvch4briFTk6WNJdAIKvfEjXauBU9ybLBbF/GB
	cSmea0YRps9lchE1pbkCOL/6bipOYhAMBTOzD79NgR/6FL6POqashX0Zc4ADkRUlry5H4X
	4YqxVMvRUEHfG8mKdaJjR2FYyQUtNUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746000645;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsiRq4ZNBs/nHIvb8X/bQTyhZoKJzP3MldRac2fXF5A=;
	b=XpZzLUxkdBtUQrf5daVpWTEi5BZci2JXklREA+CaElyvYSBAepLKBX/ZnYtDdE0yTtMWSh
	UpUsXHTrY5tQe6Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qQM6jpKR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="R/h7o5oW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746000644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsiRq4ZNBs/nHIvb8X/bQTyhZoKJzP3MldRac2fXF5A=;
	b=qQM6jpKRTk6z2moRfbDPJSzbSZbzFrT6bu9etLscHfO2pQ+BB3cPKqijTYV8gG61KMh+s/
	JM+if0oSJsI1xVMxUVVA6K5ZCuu5pZlXNTmfZx125AbiereTUH0wgeRYjBJfki6i5oqZne
	uxaVjj42+Ov//6Ej0SsJcbClCvpnlXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746000644;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsiRq4ZNBs/nHIvb8X/bQTyhZoKJzP3MldRac2fXF5A=;
	b=R/h7o5oWIIjmrzwJwfXRcTiF/XHbEEGCq1Clc7v7eCnel0yQ43E2Wy3JFJqWE/6cHxjD4M
	hDp+hIdECGwt6ZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BECA4139E7;
	Wed, 30 Apr 2025 08:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5TdhLgTbEWjzCgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Apr 2025 08:10:44 +0000
Date: Wed, 30 Apr 2025 10:10:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Brent Belisle <brent.belisle@verizon.net>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: btrfs reduction in disk io
Message-ID: <20250430081039.GG9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b2e58691-8912-4723-b5b4-ed9e80cbdb14.ref@verizon.net>
 <b2e58691-8912-4723-b5b4-ed9e80cbdb14@verizon.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2e58691-8912-4723-b5b4-ed9e80cbdb14@verizon.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CF7831F7CF
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[verizon.net];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[verizon.net];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On Tue, Apr 29, 2025 at 02:40:20PM -0500, Brent Belisle wrote:
> I've noticed since upgrading to the Linus 6.14 Kernel that when I Run 
> iotop -aoP, that btrfs-transaction and btrfs-cleaner Show almost Zero 
> Disk io. 'm not complaining but was just curious if indeed such changes 
> have been implemented in the 6.14 Kernel. If boot into the 6.12 LTS 
> Kernel or 6.13 Kernel (EOL) then both those Threads so IO activity in 
> iotop. I'm not a Developer, just a happy btrfs end user. My System is 
> using a Samsung 970 PRO SSD so I'm not worried  about wearing the ssd 
> out via excessive Disk io.

I'm observing similar drop in IO performance and increased latency, and
IIRC it started after 6.13 update and got worse in 6.14. So there is
something going on. I don't have numbers, it's mostly subjective and
noticeable difference in git related commands, eg. git log takes much
longer before something appears.  The cause could be in btrfs changes
and to some degree interaction with other generic changes (like
workqueues).

