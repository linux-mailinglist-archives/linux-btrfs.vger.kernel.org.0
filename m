Return-Path: <linux-btrfs+bounces-2323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFC851231
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 12:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A861C21D64
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B55C39AD6;
	Mon, 12 Feb 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pVagGzrQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AjOoksdz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BRBI7HFs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KfPgcak3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49739AC5
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737199; cv=none; b=Kqu1Zd2M2c4P9rjHrgFhy6twCVJbKw7v1s3ocTP+kiAN7mquFnciWFiqWQrxK3ukUWtjmqE2GDY4FYwsWsLCs8TgjqmOX/Gk0FImWNORCd31yrc9aDhEfbDI04GFMr8m8pyoQtXBr9jTniX9Oc9w519N4wxFljNnCSuqQzn8png=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737199; c=relaxed/simple;
	bh=XZktc+RHn6vo1qZn8ceLmA5uTLDTfvXnAcJChfBOjDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH2Gtoni6aCE04jN6hNUydp4LdjUTuoOwcaBF4RpFxxCVaNYztliXRCJUw+TT/tEV0hr0s16JPMvgjxXHwpX6jRoigiWshkm9QK+dXruq06dWL6zPN4hIVLWsA5LCWUleIYgtGls5xPRH7kgw2EFvTmmv1VBYHsKyROyKEyKf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pVagGzrQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AjOoksdz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BRBI7HFs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KfPgcak3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A372E21F11;
	Mon, 12 Feb 2024 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707737195;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5RwyR2gn1LkcnPhgqigi+4z1EZWow+prQBarRE1LOU=;
	b=pVagGzrQdbT5d9QkoZMD4lYW7sPUPXd9Q9i308JNvwRyOUgMirMWUOf+NpcUOResEWgLZW
	BybwxquelA6pdz3oREri4ScxWPPM2EXRe4/3Hmfk9NBUwQh1+OwmOZPW0KGiZp/YqVUNRy
	/dVlnKD0YaMz9H87xhBGl6L32UFtst4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707737195;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5RwyR2gn1LkcnPhgqigi+4z1EZWow+prQBarRE1LOU=;
	b=AjOoksdzSmkWsEx1BOcqDVKZE9M99GSgPmc4ZmopBA9PpQyvW1hrzIpjETP5e4xOVoHqKp
	IqrT04uPySlNosCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707737194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5RwyR2gn1LkcnPhgqigi+4z1EZWow+prQBarRE1LOU=;
	b=BRBI7HFswSj0IiMlZoncC2a8HOtArUNMnaVw6r/OjdfaxTkBUzhDUdJgtY43tbVSOLOPc9
	PAlNvhhsu0zcb3ohffKScbd52u7f/gp8AwWQlMfVEhGoiBEEQLUw16U6pspGeqxNrm7EIj
	jYLjpxW8uhxgS1mhwjeGqsDI7xZR9XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707737194;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5RwyR2gn1LkcnPhgqigi+4z1EZWow+prQBarRE1LOU=;
	b=KfPgcak3amT6zAReO9K0kqxaW2E0UsQnNJpFnKMolrOI0q0K5n6B9OF497T1RVVDaeB76f
	OJnNGMMjt5QdgUCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 896FE13212;
	Mon, 12 Feb 2024 11:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id haJjIWoAymVXFwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 12 Feb 2024 11:26:34 +0000
Date: Mon, 12 Feb 2024 12:26:02 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	=?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Message-ID: <20240212112602.GA355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534c381d897ad3f29948594014910310fe504bbc.1707475586.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BRBI7HFs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KfPgcak3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.05 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.03)[-0.161];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[44.58%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmx.com,wdc.com,bupt.moe];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -1.05
X-Rspamd-Queue-Id: A372E21F11
X-Spam-Flag: NO

On Fri, Feb 09, 2024 at 02:46:26AM -0800, Johannes Thumshirn wrote:
> On a zoned filesystem with conventional zones, we're skipping the block
> group profile checks for the conventional zones.
> 
> This allows converting a zoned filesystem's data block groups to RAID when
> all of the zones backing the chunk are on conventional zones.  But this
> will lead to problems, once we're trying to allocate chunks backed by
> sequential zones.

I don't remember if or to what extent the seq+zoned devices are
supported. There are many places with btrfs_is_zoned() that does not
distinguish if the sequential area is present. Some of the changes could
work on sequential but this could lead to strange problems, like in this
case.

We could support as much as is practical but now I don't see which use
cases are that.

