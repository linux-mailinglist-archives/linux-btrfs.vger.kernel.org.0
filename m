Return-Path: <linux-btrfs+bounces-17124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F7B96813
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 17:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5033F3AF445
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 15:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBDB25A34B;
	Tue, 23 Sep 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uMobtR8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mw929ZXc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LcBKNvMb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r6VSamP0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1D1DF247
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640287; cv=none; b=Kgrq0KNWeXJiqY/rTHrrloOQL3l/2XaRs6/rzQGdxpeqDP0I/HVShoxOH2EXkgOkrd+SO22DAdcR2OY9sL74AsEuqWI+4NyI7tKeqcoVkYvCyQBVA54KSSfIiKJBa/rCYzXz9E148Nhju33EQqQWw5d8RIn6vCNHEoU811z9FPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640287; c=relaxed/simple;
	bh=FqTm9ijMihQ2cHizL2sNRBwYDj65Jmx0pu+PyBjJud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDN5OEyP2ZIEdHyuXhydFhb6TbgIC8VMuK3IBQIRqjeRnYWV/LUOr8vo4TxQf7WC/D2q9d5o5YD8nA7jkDY2iYp5kPTG2+Q1PZD8l/MEFUUFepK2Ddh126CJY478t4n9GJS7KbqK/2lfqwM1iGRM3qe3+jhXJvH5O6GuIroDhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uMobtR8Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mw929ZXc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LcBKNvMb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r6VSamP0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A79D1F7F4;
	Tue, 23 Sep 2025 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758640282;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJHHRf4MuSIQGOe6K0pQM6YIFkwwoLqIkpozt+2N/eU=;
	b=uMobtR8Q8a19d3vokSLraQgWR1v7VQfBRglSkoUk1GZilUJnz1Dr6lmaOi4WdRFHIxHgol
	1rgJSy/ZWQjfzyEbaLNG7BC5jWIN3kghlBSSBYgXyKCorJBYdoAvj76NhXNKIU/CXZAayJ
	wAQq+PUFcG5ZPUbCSjHfHtSZrB7ZA/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758640282;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJHHRf4MuSIQGOe6K0pQM6YIFkwwoLqIkpozt+2N/eU=;
	b=Mw929ZXcVpXH8BIlCRLT7YbXV+r3k5R3UBVCgZ3/gAY5V9X/UXu2RqGytqM8tgQKnrWQO5
	weLR7Ex/IOLkMnDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LcBKNvMb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=r6VSamP0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758640281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJHHRf4MuSIQGOe6K0pQM6YIFkwwoLqIkpozt+2N/eU=;
	b=LcBKNvMbIWgvb3YRn59zMOtbKPoznkPRlooWPaiJxs7tYDe2MZfbQx8JeUBy6nhDYfjfAe
	uUYZp2AY8Zwr4OXzrAH3LPeNVp4rRSKoEQWB8/yuZ3XR3zgto1T53bNIEKYlZ4i+SDroUO
	VaJBBSxW0aGdy5ONajwa8qVUI9BaUWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758640281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJHHRf4MuSIQGOe6K0pQM6YIFkwwoLqIkpozt+2N/eU=;
	b=r6VSamP0ReORI8YRetE+LSm/cIVYVCU2NGKYoNkp4JUycZer9jBZMzhizvQkKT9s9ohKxr
	79fWw1L7JP0KO2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DFFB1388C;
	Tue, 23 Sep 2025 15:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jP7YEpm40mgUVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Sep 2025 15:11:21 +0000
Date: Tue, 23 Sep 2025 17:11:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Avoid potential out-of-bounds in btrfs_encode_fh()
Message-ID: <20250923151110.GV5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <0cc81bcf-b830-4ec3-8d5e-67afbc2e7c47@allelesecurity.com>
 <20250909224520.GC5333@twin.jikos.cz>
 <CAPhRvkzgR+8L93VF8XtZDG9P_q7O0+BSBxnHtesLY5oj6uhwmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhRvkzgR+8L93VF8XtZDG9P_q7O0+BSBxnHtesLY5oj6uhwmg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6A79D1F7F4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,suse.cz:replyto,allelesecurity.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21

On Tue, Sep 23, 2025 at 11:37:33AM -0300, Anderson Nascimento wrote:
> On Tue, Sep 9, 2025 at 7:45 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Mon, Sep 08, 2025 at 09:49:02AM -0300, Anderson Nascimento wrote:
> > > Hello all,
> > >
> > > The function btrfs_encode_fh() does not properly account for the three
> > > cases it handles.
> > >
> > > Before writing to the file handle (fh), the function only returns to the
> > > user BTRFS_FID_SIZE_NON_CONNECTABLE (5 dwords, 20 bytes) or
> > > BTRFS_FID_SIZE_CONNECTABLE (8 dwords, 32 bytes).
> > >
> > > However, when a parent exists and the root ID of the parent and the
> > > inode are different, the function writes BTRFS_FID_SIZE_CONNECTABLE_ROOT
> > > (10 dwords, 40 bytes).
> > >
> > > If *max_len is not large enough, this write goes out of bounds because
> > > BTRFS_FID_SIZE_CONNECTABLE_ROOT is greater than
> > > BTRFS_FID_SIZE_CONNECTABLE originally returned.
> > >
> > > This results in an 8-byte out-of-bounds write at
> > > fid->parent_root_objectid = parent_root_id.
> > >
> > > A previous attempt to fix this issue was made but was lost.
> > >
> > > https://lore.kernel.org/all/4CADAEEC020000780001B32C@vpn.id2.novell.com/
> > >
> > > Although this issue does not seem to be easily triggerable, it is a
> > > potential memory corruption bug that should be fixed. This patch
> > > resolves the issue by ensuring the function returns the appropriate size
> > > for all three cases and validates that *max_len is large enough before
> > > writing any data.
> > >
> > > Tested on v6.17-rc4.
> > >
> > > Fixes: be6e8dc0ba84 ("NFS support for btrfs - v3")
> > > Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> >
> > Thanks for finding the problem and the fix. It's 17 years old though the
> > other patch was sent about 2 years after btrfs merge to linux kernel.
> > I'll add it to for-next, with the minor whitespace issues fixed.
> 
> David, has it been queued somewhere? I don't see it in any of your branches.

That's strange, I thought I'd applied it the same day but the patch is
nowhere to be found. I'll add it to for-next again, sorry.

