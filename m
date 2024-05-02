Return-Path: <linux-btrfs+bounces-4674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE68B9D16
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9911C21CD1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F915AACA;
	Thu,  2 May 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="spGmfh0g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYdI/Db/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="spGmfh0g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYdI/Db/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BA1EB37
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662651; cv=none; b=rwhQsyASwX9zQ+uhaReNReK2ikXBP/zfebPh072YoyMc9LQ9USrgcHp9gvdqjNkKZb3C+qNXcNGZUEReZ+h4tSrRiysjQf3NVfSXTyPVoOoUTPwPo1NIUcurthwcWuY0rzMKoYain0ADpz1HxEPsPVBPPG22kkr9exLWUnrI2n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662651; c=relaxed/simple;
	bh=fpwJ8aNM8cKdz0fWVdiY5tjqvZNAFp74wGOidlfiHRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqQqHLYcHOVWyG8aRTdb4laffVQXuLjCMg3j40SuLUmMQO3NRf5dQSCshqIsFEZybP1Z10Md/zvAFooku6/ZMn9vkDzeahJ4kTbEQPQjeWrbmBwGHTnae3sMKurzNuWHYANxi4Y931y4cv/sXhImjuwj3vw4hnAbVoFNOVKD+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=spGmfh0g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYdI/Db/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=spGmfh0g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYdI/Db/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A37A1FB96;
	Thu,  2 May 2024 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714662648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klLySDzgMXO9MZvKOF5yBzeAqmnEF2mnVnS1Nl733ho=;
	b=spGmfh0gqfXIsrrdKCCrmgbvyUIZ6zV78rYdXIEF7BVrON41vbkxm3nVDEw9safNdatvy6
	LULbHNUAG7h1kpJ0rwt/t9msBPvnl4R9IAXcRK+P+AmuPY9dzutqZXhEnvjrg1zKbJodXJ
	KjsLojfa2CUPF3Wf/4LB75sGT20S0Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714662648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klLySDzgMXO9MZvKOF5yBzeAqmnEF2mnVnS1Nl733ho=;
	b=WYdI/Db/8It47cVJzor+okOJaFRKZHZieGbQtoC5eOO1JPdMUEB/njy/npBwQPhclk0LwI
	EX0Y0aTzwzNVPUBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714662648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klLySDzgMXO9MZvKOF5yBzeAqmnEF2mnVnS1Nl733ho=;
	b=spGmfh0gqfXIsrrdKCCrmgbvyUIZ6zV78rYdXIEF7BVrON41vbkxm3nVDEw9safNdatvy6
	LULbHNUAG7h1kpJ0rwt/t9msBPvnl4R9IAXcRK+P+AmuPY9dzutqZXhEnvjrg1zKbJodXJ
	KjsLojfa2CUPF3Wf/4LB75sGT20S0Q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714662648;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klLySDzgMXO9MZvKOF5yBzeAqmnEF2mnVnS1Nl733ho=;
	b=WYdI/Db/8It47cVJzor+okOJaFRKZHZieGbQtoC5eOO1JPdMUEB/njy/npBwQPhclk0LwI
	EX0Y0aTzwzNVPUBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2679D1386E;
	Thu,  2 May 2024 15:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AbU8CfisM2aOcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 May 2024 15:10:48 +0000
Date: Thu, 2 May 2024 17:03:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Boris Burkov <boris@bur.io>, dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240502150332.GS2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain>
 <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
 <20240430221839.GA51927@zen.localdomain>
 <d49e13f2-59ff-49ef-b81c-8c2c96d8284b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d49e13f2-59ff-49ef-b81c-8c2c96d8284b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 01, 2024 at 07:57:08AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/5/1 07:48, Boris Burkov 写道:
> > On Wed, May 01, 2024 at 07:35:09AM +0930, Qu Wenruo wrote:
> [...]
> >>>
> >>> I don't see how a compat bit would work here, we use them for feature
> >>> compatibility and for general access to data (full or read-only). What
> >>> we do with individual behavioral changes are sysfs files. They're
> >>> detectable by scripts and can be also used for configuration. In this
> >>> case enabling/disabling autoclean of the qgroups.
> >
> > This was my initial thought too, but your compat bit idea is interesting
> > since it persists? I vote sysfs since it has good
> > infrastructure/momentum already for similar config.
> 
> Sysfs is another way which we are already utilizing for qgroups, like
> drop_subtree_threshold.
> 
> The problem is as mentioned already, it's not persistent, thus it needs
> a user space daemon to set it for every fs after mount.

My idea of using sysfs is to export the information that the
autocleaning feature is present and if we make it on by default then
there's no need for additional step to enable it. The feedback about
that was that it should have been default so we're going to make that
change, but with sysfs export also provide a fallback to disable it in
case it breaks things for somebody.

> I'm totally fine to go sysfs for now, but I really hope to a persistent
> solution.
> Maybe a dedicated config tree?

No, we already have a way to store data in the trees or in the
properties so no new tree.

