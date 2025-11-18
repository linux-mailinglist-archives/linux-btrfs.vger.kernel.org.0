Return-Path: <linux-btrfs+bounces-19083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3CFC6A301
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DB974F3BF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90442361DCA;
	Tue, 18 Nov 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Twv8HXFO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V+4cA1Jy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9chPDrL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLP//cm/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0C361DCE
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477839; cv=none; b=D9OyjGfHF6wyenQpoIkRcTeePzeO0QE1qRbKnvjaB/sXL+h3E7BgYerC7URLJTT+d2vGvSN7vP6rSorHOzFqnnKcZ1ptFKldfiCYU39cStv5c4qs2uG64dEEx0hB7IzykVD9u/TI865Zu1DfJ1Fj/83UDGztR24guhY7YuUVj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477839; c=relaxed/simple;
	bh=5SJHCMvMHxMgFfJud82ETQZC67Zvc8OrdhJ4CkDUEzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF69yaNhOMPcuoH7N8l+rdWB5EvIHXfDyYOj0D9/Oqemm6KjS1YN9dlngajmNeqizS2kqxIU57GApv14Tet61GuaZ+XBeV2tUOXPMbBqQ3TsL1ICu6ZjXpDQ1DpjJ+s57u/ilu1iKxgvJGAsbYhr0KI8j4voU4xyF4kfOXZpSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Twv8HXFO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V+4cA1Jy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9chPDrL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLP//cm/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D81A4211C8;
	Tue, 18 Nov 2025 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763477835;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnwLdVPy22wHfZz+PCDlZq5O1GKhm8jMBoeavSZ+Nng=;
	b=Twv8HXFOHMgKRRkmPrG3vrr2WoS9zOkaxrUlWDqpJZyKyweR9OexVq6VX7zwC3KYvQV1W1
	f99jC5A4nhrkRrmuoE9MeZI9HD++LSW7jsl/hLftQt41KuHkGa8lc9iuIWU2OKqQ1YysDd
	0nsVZw0gSYemBPyu2MFdk6rKVKzIWR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763477835;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnwLdVPy22wHfZz+PCDlZq5O1GKhm8jMBoeavSZ+Nng=;
	b=V+4cA1Jyshs5MlVK/ufmbMqk6TtC7GkNywpfQR3wEFz7bSrCrfUXkzx6RE0NKAOj4uqs54
	fCIEKw6aUMN0M9AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763477834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnwLdVPy22wHfZz+PCDlZq5O1GKhm8jMBoeavSZ+Nng=;
	b=J9chPDrL2Lf+UOAuU0sVSkp0CyM990ULih3NdMuM+USk/FWtl0p8kE29z1jFPl5iTUrmhJ
	uYjIQP4VS/7Dphytgx9mjafnol+cPcDIiez3tIfs6Yc81fEFd2oxviSUR4QfH5ZYMcsI9C
	PnmP1A7I3/+BY5ybHLt8W6OTJFTXwCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763477834;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NnwLdVPy22wHfZz+PCDlZq5O1GKhm8jMBoeavSZ+Nng=;
	b=wLP//cm/9ojSXtjSbHBjeW2H/nF1Ba7hYn8sHnUhZCXYuGyjuxTiy6qqKuReLWh3Xz/bl1
	4mKWx1mh4yqgIOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAE2C3EA61;
	Tue, 18 Nov 2025 14:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M1FPLUqJHGlRHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 14:57:14 +0000
Date: Tue, 18 Nov 2025 15:56:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fallback to buffered IO if the data profile has
 duplication
Message-ID: <20251118145658.GV13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c233e29e6b011666accf3be888f61a78d7833f1b.1761954724.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c233e29e6b011666accf3be888f61a78d7833f1b.1761954724.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Sat, Nov 01, 2025 at 10:22:16AM +1030, Qu Wenruo wrote:
> [BACKGROUND]
> Inspired by a recent kernel bug report, which is related to direct IO
> buffer modification during writeback, that leads to contents mismatch of
> different RAID1 mirrors.
> 
> [CAUSE AND PROBLEMS]
> The root cause is exactly the same explained in commit 968f19c5b1b7
> ("btrfs: always fallback to buffered write if the inode requires
> checksum"), that we can not trust direct IO buffer which can be modified
> halfway during writeback.
> 
> Unlike data checksum verification, if this happened on inodes without
> data checksum but has the data has extra mirrors, it will lead to
> stealth data mismatch on different mirrors.
> 
> This will be way harder to detect without data checksum.
> 
> Furthermore for RAID56, we can even have data without checksum and data
> with checksum mixed inside the same full stripe.
> 
> In that case if the direct IO buffer got changed halfway for the
> nodatasum part, the data with checksum immediately lost its ability to
> recover, e.g.:
> 
> " " = Good old data or parity calculated using good old data
> "X" = Data modified during writeback
> 
>               0                32K                      64K
>   Data 1      |                                         |  Has csum
>   Data 2      |XXXXXXXXXXXXXXXX                         |  No csum
>   Parity      |                                         |
> 
> In above case, the parity is calculated using data 1 (has csum, from
> page cache, won't change during writeback), and old data 2 (has no csum,
> direct IO write).
> 
> After parity is calculated, but before submission to the storage, direct
> IO buffer of data 2 is modified, causing the range [0, 32K) of data 2
> has a different content.
> 
> Now all data is submitted to the storage, and the fs got fully synced.
> 
> Then the device of data 1 is lost, has to be rebuilt from data 2 and
> parity. But since the data 2 has some modified data, and the parity is
> calculated using old data, the recovered data is no the same for data 1,
> causing data checksum mismatch.
> 
> [FIX]
> Fix the problem by checking the data allocation profile.
> If our data allocation profile is either RAID0 or SINGLE, we can allow
> true zero-copy direct IO and the end user is fully responsible for any
> race.
> 
> However this is not going to fix all situations, as it's still possible
> to race with balance where the fs got a new data profile after the data
> allocation profile check.
> But this fix should still greatly reduce the window of the original bug.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This fixes some cases but also adds another exception/quirky behaviour
of direct io. At minimum we should document it in a clear way of what is
compatible and how. So far I think we have the direct io features
scattered in the documentation.

