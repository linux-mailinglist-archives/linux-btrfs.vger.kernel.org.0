Return-Path: <linux-btrfs+bounces-10036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CE39E240B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AAC52877DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C631FE461;
	Tue,  3 Dec 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bjhgiCq4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeJO9ESW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yOyOvQz5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLWQ+Rst"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CC1F755B;
	Tue,  3 Dec 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240528; cv=none; b=BPrAQaKScaGRK+81Q5TC0u9nHcYPx/kC5gBZNuGnirGw9nptIl0gTKZwdb4eEo6S+FMI7xqmvehNeC8uZZMqunw11nQZflNAV7qj3sqOucDa8Q8M5xPcbxC/6tmlRxq+ia6VpVtKE6AbWGafPZ7S6REX95iH2EJbxFO3sk4cbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240528; c=relaxed/simple;
	bh=MacPgtv5N8zqHdUAoZhZ7jD9yiCZi8raxiF1qVJIcmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLXKmY6MOU9cE6uW/lGNmPv0EYUlreIAoEFDhMaU0xq+gpQ9vucQNwKwpHL8+h1Vg0oPF99UGHxqoaa4gJni509DtiLD9kthe6TAOqIFKLUmfiUUUCvDBNN4CyFCsmHXJRvM+WaXvCY49HD4S3bhihblbfGiJ9fj96a1I2mllOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bjhgiCq4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeJO9ESW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yOyOvQz5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLWQ+Rst; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4A592115A;
	Tue,  3 Dec 2024 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733240525;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPBrwEZYu3sCuPaBacGzx5PUUFPqTh/NGzi1tILipek=;
	b=bjhgiCq4cGH5/eJUvTB+VHOrRYCnkFQCn85+MgsTXPeqrMDG83mfjjtaZK0ZfMPI3U5moR
	85yMuWqouzJlVs9rrHHcuD+yA8fOwcNTMNd5X4plNBUYLE7Eheh5lZie/g9dYl4YsAJcSz
	J6OVrVHED1M1m4DuaBDJnYDYKXTXnps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733240525;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPBrwEZYu3sCuPaBacGzx5PUUFPqTh/NGzi1tILipek=;
	b=UeJO9ESWfhS3pMcSnCp+BQBqb1Lr2Ffj2VlAdwAxmlUzdSNFlVM9+2ASoYeyMECZuAaiZY
	Ynx77PxyNU5cycDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733240524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPBrwEZYu3sCuPaBacGzx5PUUFPqTh/NGzi1tILipek=;
	b=yOyOvQz5B0Ek107gb5DH8BlVnkbO+2hyCwk8NRTPzseAeebmJztp+x33dbo9bxp3AiDPMF
	PxQD1GhGB2XgRId8YeobVvZBaNYfCGJlW6xh9nK123jbym+WKjKvKq3HpzVPPLBTdinLvj
	tHR8PIr8R5w0ic2qqvJLopGKPZT8ib8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733240524;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPBrwEZYu3sCuPaBacGzx5PUUFPqTh/NGzi1tILipek=;
	b=fLWQ+Rstqb+CO9QiT7x8Tx+qPkThWgQR8NVOPdvrWX3GZZICDhP0yIKLZcNoGAXjN6v5Il
	uqxUIu1bzA4dYbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2EBB13A15;
	Tue,  3 Dec 2024 15:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T88ML8wmT2ePTAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Dec 2024 15:42:04 +0000
Date: Tue, 3 Dec 2024 16:41:59 +0100
From: David Sterba <dsterba@suse.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: David Sterba <dsterba@suse.com>, stable@vger.kernel.org,
	linux-btrfs@vger.kernel.org, git@atemu.net,
	Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Re: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Message-ID: <20241203154159.GB31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20241125180729.13148-1-dsterba@suse.com>
 <2024120245-molar-antidote-e93a@gregkh>
 <20241203152756.GA31418@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203152756.GA31418@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,atemu.net,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Tue, Dec 03, 2024 at 04:27:56PM +0100, David Sterba wrote:
> On Mon, Dec 02, 2024 at 12:15:54PM +0100, Greg KH wrote:
> > On Mon, Nov 25, 2024 at 07:07:28PM +0100, David Sterba wrote:
> > > From: Luca Stefani <luca.stefani.ge1@gmail.com>
> > > 
> > > There are reports that system cannot suspend due to running trim because
> > > the task responsible for trimming the device isn't able to finish in
> > > time, especially since we have a free extent discarding phase, which can
> > > trim a lot of unallocated space. There are no limits on the trim size
> > > (unlike the block group part).
> > > 
> > > Since trime isn't a critical call it can be interrupted at any time,
> > > in such cases we stop the trim, report the amount of discarded bytes and
> > > return an error.
> > > 
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> > > Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> > > CC: stable@vger.kernel.org # 5.15+
> > > Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> > > Reviewed-by: David Sterba <dsterba@suse.com>
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > 
> > No git id?  :(
> 
> I forgot to add it but meanwhile Sasha looked up the commit and added it for me.

For the record it's 69313850dce33ce8c24b38576a279421f4c60996

