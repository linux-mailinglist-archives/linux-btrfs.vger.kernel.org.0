Return-Path: <linux-btrfs+bounces-4065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC7689DD55
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E4B28B957
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25B17FBD3;
	Tue,  9 Apr 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lZ8Qahqj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yDTToljg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NvZALDOD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EEhmjYGu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BFBAD4E;
	Tue,  9 Apr 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674410; cv=none; b=Tck91v+idL599VSp3E1crWQLBEaavBe7G8hHGwgLdHXolMJrEIiNInvySgx/lGe3wdggtbXG6WW/lNn4H/T0qV+GfQvXFWcw8V07GYrVsuxYcx2ublnh2DQV2/NsYPU+Qr53FQH7YQJtkluoCXG/YVzaXmH7KxaRoiBst2wyfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674410; c=relaxed/simple;
	bh=u9I4Wkh7mEQ70JzxvS+TTIV6Lw39tB7XHjjhjbnKfFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuW/LS+w6fYwQ5+4Hs+d7C18qWEnQnLfTWUUDzesP8ERvseexk+97q8CINxChAlpS+bwGlGzbew3/vSHdBGoYyGGjfQqO5e19iPIWIoNzUD9QPtjswBRrybYODpa7BDuL5LV903LNoGASnVUqtW0vS1ri/97+2Pz+CCPC8PqhGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lZ8Qahqj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yDTToljg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NvZALDOD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EEhmjYGu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CC9C20A6E;
	Tue,  9 Apr 2024 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712674406;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teQ+QAnhAhzPj516J/ykx6d0k4I3kDVxn5gHDVXyyJk=;
	b=lZ8QahqjSNiQdYbdCdh1RLT+Ld6Sh2dGFKzdakYWWxyO83617R01lI59HbVuxo9S8uLL9v
	kiviATNxPFdIi7SckgZ6xiczvDZIAayMHQCH2gZiAedmP04Teus+J8votp0wrW8Q+x5PHD
	udgayUcX6Atjv2sXAAhVQU02iQvrGZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712674406;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teQ+QAnhAhzPj516J/ykx6d0k4I3kDVxn5gHDVXyyJk=;
	b=yDTToljg37J5qSPBcNiQScyKhG960y+CU6qdKlaYH8ve1WKyQothOt08I7ow3YNR4qvUBb
	6WfOBks91n6aXhDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712674405;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teQ+QAnhAhzPj516J/ykx6d0k4I3kDVxn5gHDVXyyJk=;
	b=NvZALDODTQLOSpGkvA76AqvUH7jf6ajW2mSfCuxDolAbYIvm7m+up/tQhZNr57kxHgc5VN
	V/ij8pscaK6J1ae+tNvAADDbspXb8ayaKYn83OWHP9k8cGyiTNTtjzsl4iPNRbTdCTy1LQ
	f79dgtCXsmpOsrhbAM7Id600Qgrd6Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712674405;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teQ+QAnhAhzPj516J/ykx6d0k4I3kDVxn5gHDVXyyJk=;
	b=EEhmjYGu3fTIt18ZxYmhQV5Ly8wcklnbIEuQWiSTC134+Ej/57dRJMgpUFGS1p7aeauCeu
	i6i0MorFtehCQvCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 41F7613253;
	Tue,  9 Apr 2024 14:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZhzyD2VWFWZ4EgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 14:53:25 +0000
Date: Tue, 9 Apr 2024 16:46:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, David Sterba <dsterba@suse.cz>,
	David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
Message-ID: <20240409144600.GF3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240222095048.14211-1-dsterba@suse.com>
 <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240226113340.GA17966@suse.cz>
 <20240226180723.v4vwjts4dxndifaq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <91ff6357-7b21-49dc-93e5-14f2f4e3efab@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ff6357-7b21-49dc-93e5-14f2f4e3efab@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.99
X-Spam-Level: 
X-Spamd-Result: default: False [-3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.19)[-0.961];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto]

On Tue, Apr 09, 2024 at 10:49:12PM +0800, Anand Jain wrote:
> On 2/27/24 02:07, Zorro Lang wrote:
> > On Mon, Feb 26, 2024 at 12:33:40PM +0100, David Sterba wrote:
> >> On Sun, Feb 25, 2024 at 11:41:23PM +0800, Zorro Lang wrote:
> >>> On Thu, Feb 22, 2024 at 10:50:48AM +0100, David Sterba wrote:
> >>>> This tests if a clone source can be read but in btrfs there's an
> >>>> exclusive lock and the test always fails. The functionality might be
> >>>> implemented in btrfs in the future but for now disable the test.
> >>>>
> >>>> CC: Josef Bacik <josef@toxicpanda.com>
> >>>> Signed-off-by: David Sterba <dsterba@suse.com>
> >>>> ---
> >>>>   tests/generic/733 | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/tests/generic/733 b/tests/generic/733
> >>>> index d88d92a4705add..b26fa47dad776f 100755
> >>>> --- a/tests/generic/733
> >>>> +++ b/tests/generic/733
> >>>> @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
> >>>>   . ./common/reflink
> >>>>   
> >>>>   # real QA test starts here
> >>>> -_supported_fs generic
> >>>> +_supported_fs generic ^btrfs
> >>>
> >>> If only need a blacklist, you can write "^btrfs" directly, e.g.
> >>>
> >>>    _supported_fs ^btrfs
> >>>
> >>> then others (except btrfs) are in whitelist, don't need the "generic".
> >>
> >> Ok thanks, do I need to resend or would you update the commit?
> > 
> > I can help to change that, it's simple enough.
> > 
> 
> Applied for the PR with this changed.

The test generic/733 works after patch

https://lore.kernel.org/linux-btrfs/5fe82cceb3b6f3434172a7fb0e85a21a2f07e99c.1711199153.git.fdmanana@suse.com/

so please keep it.

