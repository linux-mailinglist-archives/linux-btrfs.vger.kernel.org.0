Return-Path: <linux-btrfs+bounces-2606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DC985D70A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 12:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2491C22DB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Feb 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AEF4642A;
	Wed, 21 Feb 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yz9H20oK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSafmWLI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yz9H20oK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lSafmWLI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0945BE3
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Feb 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515132; cv=none; b=q2JMLYujdtnsf8Zk+uloC8tMH6gWjDwis2mgaeMuwq9ew7532yGVSobxulXTtwWwdmW1crPjeiC7L7M5GBFcQQ+ZZIJ47qQjSHWZM5ixjRNvlR376x/I7y5jDSheAGuKPrPoDM4GWnatcwGqI+QZknTZsRAbYnIb0ZKLpo91TYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515132; c=relaxed/simple;
	bh=ggG3TnccGo1J7zwyP0QI2iRnNIe6RMRX1zjBnR5dD/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbJokJ6nZlKXvhwXhz7vHijrGOjhfP7Qa3/+U9Rxq05nUo8BdRim4C7LyR9YQ0LF9HdrJ3Q+/OvRCM+2c77YF1LPg3VvP0BiY0rLII/kUmlY8JPfC9+QnCSTPRbtGVqNmAgbOIJTKkrO0uLOr3cj1D43dywyeZsybtkEjgm7L1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yz9H20oK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSafmWLI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yz9H20oK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lSafmWLI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F352A1FB50;
	Wed, 21 Feb 2024 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708515125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vUUY3D9YlDsAVxW+Qr3V5tivOCJ0akgH7vpcSRkTEk=;
	b=yz9H20oKONKuQLt7KaVbKQIw3GAyvKZYMiKrMuSsxrhVo948+CsSyMKfIdiTCUC6ZYK1rX
	sukxdDNxKC0bteKZCl/Tx2spgxFKXmRG11CQA1YFKFI8bsbS6oClE/DN1fcLsoIQ1UFBnA
	MxXTtonf4oBpmUM5to1GOL7Ecwq/gCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708515125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vUUY3D9YlDsAVxW+Qr3V5tivOCJ0akgH7vpcSRkTEk=;
	b=lSafmWLIz7EvW5xZI2tAzmP/hF0HmSNZUMUwkMO1GBa5BFPoVjsQLFP8eKXQfnWbNYLHWv
	dLS18ZnS5gb1wvCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708515125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vUUY3D9YlDsAVxW+Qr3V5tivOCJ0akgH7vpcSRkTEk=;
	b=yz9H20oKONKuQLt7KaVbKQIw3GAyvKZYMiKrMuSsxrhVo948+CsSyMKfIdiTCUC6ZYK1rX
	sukxdDNxKC0bteKZCl/Tx2spgxFKXmRG11CQA1YFKFI8bsbS6oClE/DN1fcLsoIQ1UFBnA
	MxXTtonf4oBpmUM5to1GOL7Ecwq/gCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708515125;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vUUY3D9YlDsAVxW+Qr3V5tivOCJ0akgH7vpcSRkTEk=;
	b=lSafmWLIz7EvW5xZI2tAzmP/hF0HmSNZUMUwkMO1GBa5BFPoVjsQLFP8eKXQfnWbNYLHWv
	dLS18ZnS5gb1wvCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E22CE13A25;
	Wed, 21 Feb 2024 11:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6KkFNzTf1WUOJAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 21 Feb 2024 11:32:04 +0000
Date: Wed, 21 Feb 2024 12:31:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: fix a couple KCSAN warnings
Message-ID: <20240221113127.GH355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1708429856.git.fdmanana@suse.com>
 <20240221111241.GG355@twin.jikos.cz>
 <CAL3q7H78JY7ogkGpbhEyNio2QiPOHFmT3U+d3YVcuqot2OS-0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H78JY7ogkGpbhEyNio2QiPOHFmT3U+d3YVcuqot2OS-0w@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.10 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.10)[65.62%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.10

On Wed, Feb 21, 2024 at 11:25:16AM +0000, Filipe Manana wrote:
> On Wed, Feb 21, 2024 at 11:13 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Feb 20, 2024 at 12:24:32PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > KCSAN reports a couple data races around access to block reserves.
> > > While they are very likely harmless it generates some noise and reports
> > > will keep coming, so address these.
> > >
> > > Filipe Manana (2):
> > >   btrfs: fix data races when accessing the reserved amount of block reserves
> > >   btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve
> >
> > Thre's another way to "fix" the KCSAN warnings, adding a data_race()
> > annotation to the access when it does not matter if the lock is taken or
> > not.
> >
> > In commit 748f553c3c4c "btrfs: add KCSAN annotations for unlocked access
> > to block_rsv->full" this was added for 'full', have you considered that
> > for 'reserved' too? The spin lock is also correct regarding the warning
> > but still increases the lock contention.
> 
> Yes, I have considered that, and in the change logs of the patches I
> mention why I chose to take the lock instead.

Ah sorry, I skimmed the changelogs too quickly, it's indeed there.

For both patches,

Reviewed-by: David Sterba <dsterba@suse.com>

