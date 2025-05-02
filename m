Return-Path: <linux-btrfs+bounces-13609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D892DAA6F89
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 12:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A24465D1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDA23BCE4;
	Fri,  2 May 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k9X0zSym";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q9Yc6NK7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k9X0zSym";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q9Yc6NK7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A01DB546
	for <linux-btrfs@vger.kernel.org>; Fri,  2 May 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181589; cv=none; b=AH+Kj6xzw/jRqtxIk1hwSxu7l0EXy/v1ghCWr6Z9RERQvSvU4qPt6PxYzw5Iru16Tz3P9y4L6eoFAfGnloRWLpkIW5mY6VZfe7F1sruimk6iVnsnz9OE3xWAuj2YllkNITtMW+L6UpixNlyKiA1VwfBrWqPMFPN7v7UUh/0uqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181589; c=relaxed/simple;
	bh=aK0YBDt9EqGbY8lCih4rbLQ21IEwJLi+kIxtBbph7TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9jpwHHcQbXMc1FVMlzg6730yr1D26K6C2ak1fA51GS4j7thQRGxKsWu3+SAj5P6643OAkCDBrMz7AF5fXwET/Et55dVKEI0Da6Xp88LDd0zRNh16YjVBLgVp7lbl2rYRtoZCHdTnrGvPIW4jk+TYGW0I4EnfxUXhggR9SI28Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k9X0zSym; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q9Yc6NK7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k9X0zSym; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q9Yc6NK7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95F791F385;
	Fri,  2 May 2025 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746181585;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8ch2pseSV99Rx+ambjx4TxbD5d7uX0KMGPHo9WdC0=;
	b=k9X0zSymoMlTq40aYZEyxhykrsKyPfFiU5c0Q0Jvtl5YqhhopeHX3eoSB8jbcHpdhWFYy9
	CcmF7Ij8k43aUkjLqlz0avF+f7+1/uH3x9ADUnfwzuF9t/y6DeO1HhLl+A1uJyQI1yM2fp
	PPggy0HGAFVKEjB9n/NWP/qRMy910aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746181585;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8ch2pseSV99Rx+ambjx4TxbD5d7uX0KMGPHo9WdC0=;
	b=Q9Yc6NK7LpFRrzF/GxahYJVDh5Q5rbxsZUF5oXTJ9PIxd+ToG6oJowRhq87f8xCC596HZR
	xcuc8ODzLD1oggDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=k9X0zSym;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q9Yc6NK7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746181585;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8ch2pseSV99Rx+ambjx4TxbD5d7uX0KMGPHo9WdC0=;
	b=k9X0zSymoMlTq40aYZEyxhykrsKyPfFiU5c0Q0Jvtl5YqhhopeHX3eoSB8jbcHpdhWFYy9
	CcmF7Ij8k43aUkjLqlz0avF+f7+1/uH3x9ADUnfwzuF9t/y6DeO1HhLl+A1uJyQI1yM2fp
	PPggy0HGAFVKEjB9n/NWP/qRMy910aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746181585;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8ch2pseSV99Rx+ambjx4TxbD5d7uX0KMGPHo9WdC0=;
	b=Q9Yc6NK7LpFRrzF/GxahYJVDh5Q5rbxsZUF5oXTJ9PIxd+ToG6oJowRhq87f8xCC596HZR
	xcuc8ODzLD1oggDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AFE41372E;
	Fri,  2 May 2025 10:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X9HKHdGdFGi7aAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 02 May 2025 10:26:25 +0000
Date: Fri, 2 May 2025 12:26:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: enable experimental large data folio support
Message-ID: <20250502102624.GM9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <676154e5415d8d15499fb8c02b0eabbb1c6cef26.1745403878.git.wqu@suse.com>
 <20250430143035.GJ9140@twin.jikos.cz>
 <9d1c205f-fc6e-4503-ae91-9917f5cc2eaa@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d1c205f-fc6e-4503-ae91-9917f5cc2eaa@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 95F791F385
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, May 01, 2025 at 07:28:37AM +0930, Qu Wenruo wrote:
> 在 2025/5/1 00:00, David Sterba 写道:
> > On Wed, Apr 23, 2025 at 07:54:42PM +0930, Qu Wenruo wrote:
> >> With all the preparation patches already merged, it's pretty easy to
> >> enable large data folios:
> >>
> >> - Remove the ASSERT() on folio size in btrfs_end_repair_bio()
> >>
> >> - Add a helper to properly set the max folio order
> >>    Currently due to several call sites are fetching the bitmap content
> >>    directly into an unsigned long, we can only support BITS_PER_LONG
> >>    blocks for each bitmap.
> >>
> >> - Call the helper when reading/creating an inode
> >>
> >> The support has the following limits:
> >>
> >> - No large folios for data reloc inode
> >>    The relocation code still requires page sized folio.
> >>    But it's not that hot nor common compared to regular buffered ios.
> >>
> >>    Will be improved in the future.
> >>
> >> - Requires CONFIG_BTRFS_EXPERIMENTAL
> >>
> >> Unfortunately I do not have a physical machine for performance test, but
> >> if everything goes like XFS/EXT4, it should mostly bring single digits
> >> percentage performance improvement in the real world.
> >>
> >> Although I believe there are still quite some optimizations to be done,
> >> let's focus on testing the current large data folio support first.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > This is behind the experimental build we could add it now. I'm not sure
> > if this would not interfere with the xarray conversion of extent
> > buffers, that we need to get stabilized and tested too.
> 
> At least all my previous runs with large folios are very boring.
> 
> And in theory this is only affecting data folios, not affecting metadata 
> folios.

It's still a big change, from past experience it's not good to mix more
that one in one cycle. It's good that the testing runs are boring and
uneventful, this is a good base.

> > We'd need to have a separate way to enable/disable the large folios when
> > the experimental config. A module parameter might work best and it would
> > be just for targeted testing, so off by default.
> 
> I'd prefer not go the module parameter way.

Yeah I remembered we had this discussion already, we can do sysfs, mount
options if it's really needed.

> Larger folios will eventually being enabled for end users, and when that 
> happened, QA guys needs to change their module parameters again just to 
> remove the no longer working one.
> 
> > 
> > Alternatively we can postpone it to another development cycle and leave
> > it on by default (for experimental build).
> This one is small enough and very easy to revert.
> 
> I'd prefer to give it a try. If our tests show it's really boring we can 
> continue pushing.

I understand it's easy to revert, but from testing POV I'd rather
postpone it so it's the only major thing in the release. We've had a
few subtle bugs in the folio conversions, like a56c85fa2d59ab078 or
da0386c1c70da1a01 that I remember and there may be more that are not
simple one-liners.

The problem is that we're using "somebody else's code infrastructure",
which can be already proven because it's used in other subsystems, so
we're mostly left with the integration bugs.

