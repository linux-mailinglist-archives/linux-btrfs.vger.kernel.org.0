Return-Path: <linux-btrfs+bounces-21309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ECREUevgWn+IgMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21309-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 09:18:15 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4889ED6227
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 09:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D82373002B6B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29122FC871;
	Tue,  3 Feb 2026 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="zakrkeyE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48043939AD
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106684; cv=none; b=URJfUJHMyaiU8fGGFbGKDEKP2YyzbcKv7ezgDsrE7PxCaNW/ihS0aL4GR7ty0pXxghqwL0dSArPksX6YOYwQ1ZVDH85Ot6Y3CDliIO5Nmsw+cmuDkSc62v1nmDmNQhqoaH9YgNB9ttGpXmUBONIgeP207b0TGSanoqgGy1sxeP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106684; c=relaxed/simple;
	bh=K4THa5Xc37+H1OIZ6WXSGlvqwE3R6DRTjTV1d0e/Oak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXJSdFNTkQWTdqsGU6BrxYYHV+IiGPgNkejM2tb8kJx1++xKU3SHJ9pr6M8tvrTo6xC5faVF+HoSgwhOQxn6xe9F9XuquoTwppzVkBCfO4bo6tv56xjhJY2dIQWU+EwWZ/9gqUXyDy+8ckANf3LOTLBD8LY6NsdOMNv9LoI6CeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=zakrkeyE; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CB4B314C2D6;
	Tue,  3 Feb 2026 09:17:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1770106673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pms04QFmz52C8XabfEN6iivqS650mNkUEJRM2RkKZSw=;
	b=zakrkeyERduTM2Gcp5bAaH3K9ZChzmOL72gM7iwRV1n9AkHwWa39Ziy/i5fCIX9RfHfU6o
	4I1XezzjcZVdc/2M9XQKBjn5pdWF3Ky3RlIh7Pl6eRLvQW8xnkqqJxQd9hfu3pUOFd5RS9
	+c4A9Fv3GnvzUojDYLpUgogLNxjW29KJ5JKkP3tk3C5W1YiK+WwhPZyikkVRzuGDKMfHVx
	IDEAhK7su9cnE7DiOYLBRnKPmeekpT3RRX8yUHvz0NvIfw8XFDLGzNgbnsj+RVPzKc2Qa7
	RCWQe72ee2mgyaCZUvrsOEDOEdjAomD6htmFo8m9rzPZu9PSRX8D8/2UJRKf8A==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 44389991;
	Tue, 3 Feb 2026 08:17:50 +0000 (UTC)
Date: Tue, 3 Feb 2026 17:17:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Christoph Anton Mitterer <calestyo@scientia.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: We have a space info key for a block group that doesn't exist
Message-ID: <aYGvH2L6StMrLBOB@codewreck.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
 <aYGeghb0lkhZhDcV@codewreck.org>
 <fa4a4321-7b45-45e1-b372-9ada2ffbc8ef@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa4a4321-7b45-45e1-b372-9ada2ffbc8ef@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.com,scientia.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-21309-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4889ED6227
X-Rspamd-Action: no action

Qu Wenruo wrote on Tue, Feb 03, 2026 at 06:17:14PM +1030:
> > We're running rountine btrfsck before copying the filesystem for cloning
> > in one of our tools, and I'm starting to get user reports of errors due
> > to this error (we run an ancient 5.10 kernel but there hadn't been any
> > such report, and now we just got two in a couple of weeks so something
> > must have been backported to the stable tree...)
> > 
> > Anyway, I agree with your answer that it's safe to ignore, but it's not
> > obvious for users to decide that, so I'd like to address this somehow.
> > 
> > If it's really harmless, could it be printed as info message but not
> > change the btrfsck return code? (e.g. if that's the only error, return
> > success)
> 
> I think it's possible to change it to a warning, not an error, but we are
> going to have proper automatic kernel in v6.20 kernel.
> 
> With that said, at least for us developers a proper error will help us more,
> and prevent further similar problems.
> 
> Trading between end users complains and future proof, I still prefer to keep
> it as an error for now.

Fair enough, I understand.

> > If you think it's worth keeping as an error, would you (or someone else)
> > happen to have any idea where I should start looking?
> 
> In v6.20 kernel, the first RW mount of the fs will automatically fix the
> problem.
> 
> The patch is here:
> 
> https://lore.kernel.org/linux-btrfs/f58857f1ac741bd1fb4fa2e7ec56ed87815bb1f5.1766198159.git.wqu@suse.com/

Oh!
I only searched for the btrfsck error message so this didn't come up,
sorry.
That's great, thank you.


> And it's already in our for-next branch, heading towards v6.20 kernel.
> 
> I will backport that fix to older LTS kernels (6.6 and 6.12 planned) so that
> even older kernel users will get their fs fixed properly.

Thanks.. Unfortunately that part of the code changed greatly in 5.11
(btrfs_start_pre_rw_mount didn't even exist back in 5.10), so I'll just
give up on that one -- I just don't think it's worth the effort for our
old kernel.

However your commit message explains why we didn't see it before (it's
limited to a range of "bad" btrfs-progs version), and we've already
upgraded to btrfs-progs-6.17 so hopefully will stop seeing it as soon as
people move away from the "bad" 6.14 version that likely caused the
problem (I'll check a bit more on this)

Thank you,
-- 
Dominique Martinet | Asmadeus

