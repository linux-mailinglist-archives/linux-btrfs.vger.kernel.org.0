Return-Path: <linux-btrfs+bounces-9254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C6F9B67D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 16:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190CC1C21CF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BF221443B;
	Wed, 30 Oct 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R7UCFh52";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="boNEcGz0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vDxgrdLA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p1I4mEGY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BA214412;
	Wed, 30 Oct 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302122; cv=none; b=skl/Oh2n3kwmmXLslbI0D7D4t+NeigywLxjiYTwi6D+Oftv3WTafqbDK0tMvab5pfOlHFzPAAW/ECYu4vhcp1TReoyhkri8hlZK6bW7+ednQsGOv/R6DQ0rhqy8xJizvVLMbuM7vDsVVLkZ1pzBzT9NnGtCE9GkFBoUVNo9onWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302122; c=relaxed/simple;
	bh=Znr5gmwsBT5imhqR264KDdx1UCA8syExo7CZaYuoCm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngiRypWpR6OoX1tU5IiSH2AFew6l4VvN4Rs0raVFWjriUrJtvgD7MUEHi6LJM++0s+vMRBchNN/J2gVbFC7Mmo0ah5naOZNZhTxg6CA6O3TGVhgkfFPi7VZNrIxryJmJqQ0kX1c3UqQUK/cAWqtS2Ntq9ua2zEVlwb3DeiW9vlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R7UCFh52; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=boNEcGz0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vDxgrdLA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p1I4mEGY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FFB91FDE6;
	Wed, 30 Oct 2024 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730302118;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u89RvmZx6ZtlV0vBJVjyxNqmMJvFO7KZlmYZSLn8Wz0=;
	b=R7UCFh52ZBo2IahFNBBLABw1CH6fBwvGCUWokC/onQxFctl0KtMy/UiAJsMaak4EHjk9SD
	A36SazEmJ011D5nw8dHr47owxL/9FekTbkKAGqK7drnl8qkYfLb/da23tCk2LdIDVHkIP/
	Hjo6J4nd3Oq90gDsoGPI4xwL9XV11sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730302118;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u89RvmZx6ZtlV0vBJVjyxNqmMJvFO7KZlmYZSLn8Wz0=;
	b=boNEcGz0y9K4rC2B+ah/S4QFnWFiEPz9dSPFr+2wWSUZmmaO/34L/fLOeBin+UfOzMazTy
	qqHa/1hHJYV/TLBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730302117;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u89RvmZx6ZtlV0vBJVjyxNqmMJvFO7KZlmYZSLn8Wz0=;
	b=vDxgrdLAm3e0sLy2WHDYOCAwHBqTEKU7wL7gfp/W6l0yFiLWGyvCFtFstQR4WSmqumnHw8
	HIYjfP0MMR5haQDQbW8vHiyBJMYrly73ZXEki9cKkRo+YFoss2m/hXkvIjGR0IYliz8nC4
	nDht1+cx2nKASHnZ2KYFPPb8Ofxd5tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730302117;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u89RvmZx6ZtlV0vBJVjyxNqmMJvFO7KZlmYZSLn8Wz0=;
	b=p1I4mEGYYPXl6THSQJVMgnP7Ua7NNQyVPNDXdBqC3pnIGufTLxGWUHt7N2oIOgEyboHo7i
	rAmgsNuCoQhkLBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7145813AD9;
	Wed, 30 Oct 2024 15:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sWopG6VQImdQGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Oct 2024 15:28:37 +0000
Date: Wed, 30 Oct 2024 16:28:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: iamhswang@gmail.com, linux-btrfs@vger.kernel.org, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com, boris@bur.io,
	linux-kernel@vger.kernel.org, Haisu Wang <haisuwang@tencent.com>
Subject: Re: [PATCH 2/2] btrfs: simplify regions mark and keep start
 unchanged in err handling
Message-ID: <20241030152836.GA31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241025065448.3231672-1-haisuwang@tencent.com>
 <20241025065448.3231672-3-haisuwang@tencent.com>
 <4d0603d4-1503-4e8f-bfe2-ed205b598072@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d0603d4-1503-4e8f-bfe2-ed205b598072@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,toxicpanda.com,suse.com,bur.io,tencent.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Oct 30, 2024 at 01:31:15PM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/25 17:24, iamhswang@gmail.com 写道:
> > From: Haisu Wang <haisuwang@tencent.com>
> >
> > Simplify the regions mark by using cur_alloc_size only to present
> > the reserved but may failed to alloced extent. Remove the ram_size
> > as well since it is always consistent to the cur_alloc_size in the
> > context. Advanced the start mark in normal path until extent succeed
> > alloced and keep the start unchanged in error handling path.
> >
> > PASSed the fstest generic/475 test for a hundred times with quota
> > enabled. And a modified generic/475 test by removing the sleep time
> > for a hundred times. About one tenth of the tests do enter the error
> > handling path due to fail to reserve extent.
> >
> 
> Although this patch is already merged into for-next, it looks like the
> next patch will again change the error handling, mostly render the this
> one useless:
> 
> https://lore.kernel.org/linux-btrfs/2a0925f0264daf90741ed0a7ba7ed4b4888cf778.1728725060.git.wqu@suse.com/
> 
> The newer patch will change the error handling to a simpler one, so
> instead of 3 regions, there will be only 2.
> 
> There will be no change needed from your side, I will update my patches
> to solve the conflicts, just in case if you find the error handling is
> different in the future.

Please take care of that, the only request I have is that it's done by
the end of this week so we have the code in linux-next and that a fix
should come before a refactoring (due to backports). Update for-next as
you need.

