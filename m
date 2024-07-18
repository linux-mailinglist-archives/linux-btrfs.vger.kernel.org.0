Return-Path: <linux-btrfs+bounces-6563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FF09370E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 00:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC6028209B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2024 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED2146595;
	Thu, 18 Jul 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnyu006z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="52HIZLIE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtqwibBk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kbrIEumW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A626A1442E8
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343330; cv=none; b=dHkcGqtEVVy6uzmGH9ea0sPY2RJACfFegH0+1Y2qT9wMhmYQp1M9ydq5ok0n62iI0dnmQiRCqrGkJPIAD2DzMSYfIGj7QYmFYWGxJR/1Am87pDT/mo210OeLhcj+dL53Gn/FuwrKzqh+DFuy+66IqX5Doj3u7XD9439zYXFAbqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343330; c=relaxed/simple;
	bh=Pgum7Yw1Q30nuYw7c3hoLHfuP4hKXB6KWhqmRXfMYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfuv/uVim/TRPcTqTKzWWiGTeBToWjAIsCraxYiLCGFPoRP9IkOomxhlljX0Ko6frSoxe99mZOv57oWnCWwYbhlcMlPfOrjnn8zfBD2jIyLW6cs72O9xrkVonGnsmOvr4VK894q4V8AAI2ywSWTc0i/P7RK1wMeP5RNPKBWVglw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnyu006z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=52HIZLIE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtqwibBk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kbrIEumW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0DCE1F74D;
	Thu, 18 Jul 2024 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721343326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXzv+xWmuBGzcCz0ZmRLPiYO1HvRUpxDMsXCWHhzO/I=;
	b=lnyu006z3PBhb5demGcy01ZprB+02nTAXFP0xkYNrxEB8lapHk+hXLfUUrwYi+5dP52kVF
	IpMmExY/fC0UeDBVle/Y/UMmVxiwJtaw6fAjtYH8VOpcWIken46MQYhiPohneUvIj7wdil
	f9/LxmazYHrVUwxbAk5e1FVLyPgaFgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721343326;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXzv+xWmuBGzcCz0ZmRLPiYO1HvRUpxDMsXCWHhzO/I=;
	b=52HIZLIEFiyQDbfu4B3WmT2fZirSc/P0b8Aw5kkEjY4SYAPtzhMR/FakxUptfOnItv3V2O
	DHIqY4PL5zTwJEBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dtqwibBk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kbrIEumW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721343325;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXzv+xWmuBGzcCz0ZmRLPiYO1HvRUpxDMsXCWHhzO/I=;
	b=dtqwibBkI2VGn5x1/0Ew8SawNwAJ+OQx/eSwKa7QwIC3HIuwbZXl0MN/HO1UMhPOUpNH6L
	DHxhtRhhoSI/RyW+Mdzn2J7s7JQUgT9qqYp5PfXIQeLKl3E700zfLPGxSB1zy+NHiKFRx6
	wQIRKqQoLqRfEG1BmDRhc4nT4UV2dwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721343325;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXzv+xWmuBGzcCz0ZmRLPiYO1HvRUpxDMsXCWHhzO/I=;
	b=kbrIEumWeUSGqKK4XhbAs9uzvwVrpz1woX6m7H/wwmHpvl5qbQBf6ejobQ0iAqYUCy1ChW
	f9xCK39jF55Z/SDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1726136F7;
	Thu, 18 Jul 2024 22:55:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wiDoJl2dmWYCIgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Jul 2024 22:55:25 +0000
Date: Fri, 19 Jul 2024 00:55:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/4] btrfs-progs: fix the filename sanitization of
 btrfs-image
Message-ID: <20240718225524.GJ8022@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1720415116.git.wqu@suse.com>
 <b92f8d33-ff5d-4aa1-93a8-97f26f466320@suse.com>
 <20240718154703.GI8022@twin.jikos.cz>
 <87d78bde-b5aa-44bb-926d-a4eabd710c84@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d78bde-b5aa-44bb-926d-a4eabd710c84@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C0DCE1F74D
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Fri, Jul 19, 2024 at 08:08:30AM +0930, Qu Wenruo wrote:
> 在 2024/7/19 01:17, David Sterba 写道:
> > On Mon, Jul 15, 2024 at 07:39:32AM +0930, Qu Wenruo wrote:
> >> Ping?
> >>
> >> Any update on this?
> >
> > Tracked as https://github.com/kdave/btrfs-progs/pull/837
> 
> Just to mention, since the github review system is working now, do you
> prefer me to still send the updated patches to the ML?
> I'm mostly using the ML as a way to track the work...

You don't need to send it to the mailinglist if there's a PR, for
tracking purposes it's ok to send it. It would be good to keep
dicsussion at one place but I think this won't be common or we'll
manage.

