Return-Path: <linux-btrfs+bounces-5353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504B8D3A67
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A70C28673C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC7417DE14;
	Wed, 29 May 2024 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOe45iu0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVMeEwD6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DOe45iu0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NVMeEwD6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194A15B97D
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995533; cv=none; b=r2fItbupyEh0m5Kgu59SQxsit8ITWFVQnOf7o75hBv1ZK0kXL2YdLTNg3A+8TFcqWsnXw/kz5aCCaN6nuNxeZfQJf++W/iMGUnXIlG02+JuBWzux4tbSJhYNF+X3bp6sNRl4JfrRKOTP1omxc6DVlPBOr/I1BKqp3c7ccmzrAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995533; c=relaxed/simple;
	bh=RvhXgEFqwwBgyLsSadh/Dys+P9YBOY0+duQP+dadjFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJF2gPGiPAtjzNnaLzkWj49yGEEnvdqFrdf8GrjpHv1LVt56apww4/9ju2slRZtSv6kAhbZEDRR0uAoKD4So0KfQax50uzGTHuZCwXJjsx6oeJplyu+ofLaD4aTDpkn1Or6W91foSOi8HXaPK8WtUbuXrRdmUmP9gGdmPN4yMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOe45iu0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NVMeEwD6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DOe45iu0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NVMeEwD6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2F70336C8;
	Wed, 29 May 2024 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716995528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvhXgEFqwwBgyLsSadh/Dys+P9YBOY0+duQP+dadjFI=;
	b=DOe45iu0KVnNDSK31EYBGD6MUqhYF4rfisoi+gGhvLwN9ycwwSBURa7oDLSEAMjg/0ARGI
	JOMQsUc2jFWkQmqSB0o5fm/zb7It9a92LvXuN/jGCozWnN6DODg0IuY6RZUOkaiaxvng6j
	7rGKSgjgoOQNSungLUMsjiesT+nsvrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716995528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvhXgEFqwwBgyLsSadh/Dys+P9YBOY0+duQP+dadjFI=;
	b=NVMeEwD6fi7vVjY2pQS5a34G+506Vb9UA/MJt45F0UMjvSMifuSChD+SzpNBkcCZbxHlqB
	lgC6F7ad7c0/43DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716995528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvhXgEFqwwBgyLsSadh/Dys+P9YBOY0+duQP+dadjFI=;
	b=DOe45iu0KVnNDSK31EYBGD6MUqhYF4rfisoi+gGhvLwN9ycwwSBURa7oDLSEAMjg/0ARGI
	JOMQsUc2jFWkQmqSB0o5fm/zb7It9a92LvXuN/jGCozWnN6DODg0IuY6RZUOkaiaxvng6j
	7rGKSgjgoOQNSungLUMsjiesT+nsvrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716995528;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvhXgEFqwwBgyLsSadh/Dys+P9YBOY0+duQP+dadjFI=;
	b=NVMeEwD6fi7vVjY2pQS5a34G+506Vb9UA/MJt45F0UMjvSMifuSChD+SzpNBkcCZbxHlqB
	lgC6F7ad7c0/43DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A38F13A6B;
	Wed, 29 May 2024 15:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJN6JchFV2a4bgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 29 May 2024 15:12:08 +0000
Date: Wed, 29 May 2024 17:12:07 +0200
From: David Sterba <dsterba@suse.cz>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Subject: Re: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to
 alloc structure
Message-ID: <20240529151207.GK8631@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240528062343.795139-1-sunjunchao2870@gmail.com>
 <42631f4d-97ca-4f7b-a851-c06383b35065@gmx.com>
 <CAHB1NaidZ1WjkpshMC3zWwX1_3nL3AULG46fc4gmygb9TAa82A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NaidZ1WjkpshMC3zWwX1_3nL3AULG46fc4gmygb9TAa82A@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,vger.kernel.org,fb.com,toxicpanda.com,suse.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]

On Wed, May 29, 2024 at 09:11:05PM +0800, JunChao Sun wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> 于2024年5月28日周二 14:42写道：
> >
> >
> >
> > 在 2024/5/28 15:53, Junchao Sun 写道:
> > > Generic slub works fine so far. And it's not necessary to create a
> > > dedicated kmem cache and leave it unused if quotas are disabled.
> > > So let's delete the todo line.
> > >
> > > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> >
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> >
> > My bad, at the time of writing I didn't notice that qgroup is not always
> > enabled.
> >
> > > Furthermore nowadays squota won't utilize that structure either, making
> > > it less meaningful to go kmemcache.
> Thank you for your further explanation. By the way, is there anything
> meaningful todo? I saw some in code, but I can't ensure if they are
> still meaningful. I'd like to try contributing to btrfs and improve my
> understanding of it.

You could find TODO or XXX marks in the sources but I'm against tracking
todos like that and the one you saw and all the others are from old
times. All are to be removed, though with evaluation if they apply and
are still worth to be tracked by other means.

We don't have one place to track todos also things are more like an idea
than a full fledged task with specification and agreement that this is
what we want to do. This means it's better to talk to us first if you'd
like to implement something, either privately by mail or you can join
slack.

Otherwise generic contributions are always welcome, with perhaps a
friendly warning that the code base is old and there are several people
working on it so the style and coding patterns are kind of alwyas
standing in the way. Reading code first to get the idea is recommended.

> Also, is it a meaningful to view the contents of snapshots without
> rolling them back? The company I work for is considering implementing
> it recently...

This sounds like a use case that's above the filesystem, eg. rollback of
snapshot I know of is done by snapper, what btrfs does is just to
provide the capability of snapshots. Viewing snapshots is possible,
either going to its directory or mounting it to some path and examining
it.

