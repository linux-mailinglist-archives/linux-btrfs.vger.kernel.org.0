Return-Path: <linux-btrfs+bounces-4140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30388A17AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 16:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400C81F211FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC9211187;
	Thu, 11 Apr 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QrkildVI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+aO1DBcT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QrkildVI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+aO1DBcT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1DDCA73;
	Thu, 11 Apr 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846485; cv=none; b=EN5na6bzh1TIM/HGQEPGrp1g6W8sOOartIGfGBU8GWuqwfB9AViVxXC6HTN4Wrqx8cB7T/F1VUPYpCVvDyVyaGmHP8pd+zIJPStC7VdwYLwcJ/w+4zeB+7EixZsypYavBZYbfady61/KgA0juE4TQ6sH3HQTx9l2XNEK1EHntzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846485; c=relaxed/simple;
	bh=vPgdivHYRSSd/O6IaYR6sg/jdjc8RLY8P9HV/kir/i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eww/7+tiyORK/KHmcUhnH1eHUEzapIh4t6mselvxseX5Cck6/Km99klC31g/YdoGFWLF0CNz0D7B5SyB8CZflBCT+Volwf70auavi41u2ytzVbpOmAPyKVFxRwCd6+BiHWFzV4cl55xu5tCqMxZK87Z7AAAauhTXAu0vBO0rakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QrkildVI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+aO1DBcT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QrkildVI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+aO1DBcT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73370375C4;
	Thu, 11 Apr 2024 14:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712846480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s45HoZnzBmH3Zbd1qQZJXNygT/wqotCRulnTGMhB9vs=;
	b=QrkildVIgr4FksIH9fhMXMDXPO71nPt3D5Z7irv30Fe5rEGTK0RDCEbEZU5FwhaukyLI9Y
	R3ygSIIN84V3t2oMKZF4z9VB6ib6fmQnkkF9JwXDPFGqKnQ1rQ7CQFAMTSqrNwoudJXDDV
	9ZY16X1NzPSshfJYb9MsEQmTtEJPq8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712846480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s45HoZnzBmH3Zbd1qQZJXNygT/wqotCRulnTGMhB9vs=;
	b=+aO1DBcThUzuGWiNZwOyqOusyZuFfRBuuokSPDRB85PDMHINffrRmV+6gHwD1C+Khli3HU
	5JxCpJ4SDL5o8dBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QrkildVI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+aO1DBcT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712846480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s45HoZnzBmH3Zbd1qQZJXNygT/wqotCRulnTGMhB9vs=;
	b=QrkildVIgr4FksIH9fhMXMDXPO71nPt3D5Z7irv30Fe5rEGTK0RDCEbEZU5FwhaukyLI9Y
	R3ygSIIN84V3t2oMKZF4z9VB6ib6fmQnkkF9JwXDPFGqKnQ1rQ7CQFAMTSqrNwoudJXDDV
	9ZY16X1NzPSshfJYb9MsEQmTtEJPq8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712846480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s45HoZnzBmH3Zbd1qQZJXNygT/wqotCRulnTGMhB9vs=;
	b=+aO1DBcThUzuGWiNZwOyqOusyZuFfRBuuokSPDRB85PDMHINffrRmV+6gHwD1C+Khli3HU
	5JxCpJ4SDL5o8dBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 513C313685;
	Thu, 11 Apr 2024 14:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MzysE5D2F2Y+SgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Apr 2024 14:41:20 +0000
Date: Thu, 11 Apr 2024 16:33:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs: redirect stdout of "btrfs subvolume
 snapshot" to fix output change
Message-ID: <20240411143350.GP3492@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240406051847.75347-1-wqu@suse.com>
 <8824a2ee-7325-4a14-ac64-dcedc03c14b9@oracle.com>
 <20240409111319.GA3492@twin.jikos.cz>
 <f113ab1f-58b4-453b-a6eb-7b4cce765287@oracle.com>
 <e9576dfb-c3ce-4adc-bb32-f7efa235907a@suse.com>
 <20240410162635.GN3492@suse.cz>
 <d756b8f2-5f55-4482-9a83-e2ab740e11ed@oracle.com>
 <ac9c80d0-bc78-459b-aa38-4f2b6ed34b65@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac9c80d0-bc78-459b-aa38-4f2b6ed34b65@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 73370375C4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Thu, Apr 11, 2024 at 06:19:03PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/11 18:14, Anand Jain 写道:
> >
> >
> > On 4/11/24 00:26, David Sterba wrote:
> >> On Wed, Apr 10, 2024 at 03:18:49PM +0930, Qu Wenruo wrote:
> >>>>> What past discussions favored does not seem to satisfy our needs
> >>>>> and as
> >>>>> btrfs-progs are evolving we're hitting random test breakage just
> >>>>> because
> >>>>> some message has changed. The testsuite should verify what matters,
> >>>>> ie.
> >>>>> return code, state of the filesystem etc, not exact command output.
> >>>>> There's high correlation between output and correctness, yes, but this
> >>>>> is too fragile.
> >>>>
> >>>> Agreed. So, why don't we use `_run_btrfs_util_prog subvolume
> >>>> snapshot`, which makes it consistent with the rest of the test cases,
> >>>> and also remove the golden output for this command?
> >>>
> >>> For `_run_btrfs_util_prog`, the only thing I do not like is the name
> >>> itself.
> >>>
> >>> I also do not like how fstests always go $BTRFS_UTIL_PROG neither,
> >>> however I understand it's there to make sure we do not got weird bash
> >>> function name like "btrfs()" overriding the real "btrfs".
> >>>
> >>> If we can make the name shorter like `_btrfs` or something like it, I'm
> >>> totally fine with that, and would be happy to move to the new interface.
> >>>
> >>> In fact, `_run_btrfs_util_prog` is pretty helpful to generate a debug
> >>> friendly seqres.full, which is another good point.
> >>
> >> I did not realize the _run_btrfs_util_prog helper was there and actually
> >> the run_check as well. I vaguely remember this from many years ago and
> >> this somehow landed in btrfs-progs testsuite but fstests was against it.
> >> Using such helpers sounds like a plan to me (with renames etc).
> >
> > We can do the renaming part in the separate patch. Qu, are
> > you sending the revised patch?
> 
> Sure, I can prepare them pretty soon.
> 
> Just to be noticed, if we really determine to rename
> `_run_btrfs_util_prog`, it would be pretty large as there are tons of
> such calls still there.
> 
> And I really hope we can get a good naming before doing the conversion.
> Updating it again and again for a different name may not be a good use
> of time.
> 
> My candidate is `_btrfs` or `_run_btrfs`. Any good candidates?

I'd use the one with prefix.

