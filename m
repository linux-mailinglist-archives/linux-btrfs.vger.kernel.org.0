Return-Path: <linux-btrfs+bounces-2802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE894867AD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 16:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8261C268AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2221292ED;
	Mon, 26 Feb 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfxAHp5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CMY/fBUK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sfxAHp5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CMY/fBUK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0508592F
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962824; cv=none; b=LusqJXPYsiO3tMDFDzjGmvxCSZhH6JvcaaDbSlMdeRJuPT0obLZLvLpGj6EYFf8jYu8LqBR2SudjoXwMeswrnt4cyv6MNISZ0NdlgvW3ACR4yNinaKxu7QibI1+7WOsFuVsNSUYxJHpHqqYiZ3p2dHr6NSph1aTU4g1le3YNU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962824; c=relaxed/simple;
	bh=ZmTNrO/1Hd6lkaZavoxqYmIAcXGGWWPmcca/dJB3KoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as8Cg2w0OOSNUs1hubP7n2diiE2972QhsotZVYoaFEUh9J2a4LE4cbcuec/rj9GxMFJX4sHYSi0y4VEXnEL+tYQXoYHDVpK5HkbCNx3rpbatHftHyGxtIxuLpGTLgfFbHX/KuclnWjDCWCEBM4hTiARfzUDDsUUhtzwdnIwCd9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfxAHp5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CMY/fBUK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sfxAHp5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CMY/fBUK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DCF8225DD;
	Mon, 26 Feb 2024 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708962821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmTNrO/1Hd6lkaZavoxqYmIAcXGGWWPmcca/dJB3KoQ=;
	b=sfxAHp5TPqEXNtBVxydy8epIPTyKEI0Uy6FMJn4PjLMns43fEtJqFZz77MXU7v34m0Ysxo
	FY0H5+CGMfwtcktHYLmLkeD3TgK41SUVN+SM21uueVdcKYtbTGzyJdGlCN17lF7hJiqLGs
	QyZkpACsqdl/5ntdUGB5rHjz4wWM9p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708962821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmTNrO/1Hd6lkaZavoxqYmIAcXGGWWPmcca/dJB3KoQ=;
	b=CMY/fBUK7WfYCdDXp5dynaDt/Z1E7GbpbSQ9xFkDETW+YOR2pEiHDETZA3INRvw+xSVyDV
	sU90nj/aRfwCBSBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708962821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmTNrO/1Hd6lkaZavoxqYmIAcXGGWWPmcca/dJB3KoQ=;
	b=sfxAHp5TPqEXNtBVxydy8epIPTyKEI0Uy6FMJn4PjLMns43fEtJqFZz77MXU7v34m0Ysxo
	FY0H5+CGMfwtcktHYLmLkeD3TgK41SUVN+SM21uueVdcKYtbTGzyJdGlCN17lF7hJiqLGs
	QyZkpACsqdl/5ntdUGB5rHjz4wWM9p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708962821;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmTNrO/1Hd6lkaZavoxqYmIAcXGGWWPmcca/dJB3KoQ=;
	b=CMY/fBUK7WfYCdDXp5dynaDt/Z1E7GbpbSQ9xFkDETW+YOR2pEiHDETZA3INRvw+xSVyDV
	sU90nj/aRfwCBSBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 44CFB13A43;
	Mon, 26 Feb 2024 15:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id V4yYEAW03GU2dQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 26 Feb 2024 15:53:41 +0000
Date: Mon, 26 Feb 2024 16:53:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Tavian Barnes <tavianator@tavianator.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Corruption while bisecting (was: [PATCH] btrfs: tree-checker:
 dump the page status if hit something wrong)
Message-ID: <20240226155301.GF17966@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.10)[88.20%]
X-Spam-Flag: NO

On Sun, Feb 25, 2024 at 02:30:22PM -0500, Tavian Barnes wrote:
> Well, bad news: I started bisecting from v6.0 and after a couple
> rounds, my root fs is really corrupted:

The span of releases where you can reproduce it quite wide, 6.0 until
6.7. I think there's a possibility that you hit the new bug in 6.7 and
the error propagated to the filesystem so that now it's detectable on
any lower version too.

We have only indirect evidence here, 2 reports of the page reference
counts and all in a short window after 6.7. The lack of other reports
would point out to either one time damage or some other factor like
hardware problems.

