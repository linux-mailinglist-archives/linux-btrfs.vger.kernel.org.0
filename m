Return-Path: <linux-btrfs+bounces-12340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F068A65545
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7134B3B4C71
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53324BC18;
	Mon, 17 Mar 2025 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mG7UqGVZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="azl7lUVr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mG7UqGVZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="azl7lUVr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FC2459FE
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224397; cv=none; b=p8XLHwo+PJskuaQCv6wapuNHRf98qKbmb1eqISnl1NXYfnpWLy3nS2AETkIrLwbbINBUk8Fj5vMr+q8pNZgTr+5313DTlsXPRoa2Cu+CrLy+HEvBut7lvKmrm7iuAyLVXH0xHuTg8ouyv9xCMcNQ7ga9Qd5IlTBbH/hqDnoEPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224397; c=relaxed/simple;
	bh=VGoZIc6+JYyuIT2lwB+7eJLTOUbWHdqM8cZVLeA6Vrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j89tJ6zGBt54nF3aRzy4Krj2xDzsosXiMnsY58AgGx7CLWvTW5CvqQITUirlRZ9BRB+5qk1cNdJf49Jehxy+CYjEeMNx23YPGUGL8BS0EisewcGK2CTRXXb4U0fMNYmkpDIjur13qDrF3aHxOqwE6luQSDm1N9/DsIVm0AEzIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mG7UqGVZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=azl7lUVr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mG7UqGVZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=azl7lUVr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0684D1F770;
	Mon, 17 Mar 2025 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742224394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKJ0o76pFzF4cyasE9l8ypMc3nCCOzv07GXIk83PeJ4=;
	b=mG7UqGVZ3AuNEfutNbAaNmDH8OG2xqtJkH99TCfN1YweVDV2vwV1fhm6UH/s1l3IqX/BC2
	Yr6hotUK1MPHEMVz+jWPBtI9Kp0z75AM44GgzJESmXpLwl7A/xoHHD2EcNZl5l3GGgiO4Z
	PHe4KMy6RbFZqU8Eo5GmZIzqymnRqCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742224394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKJ0o76pFzF4cyasE9l8ypMc3nCCOzv07GXIk83PeJ4=;
	b=azl7lUVrf8g4RqpptlivzFBBG4z1611dFDv10jII0+4PxquSFI2R978Iqnh67rMOomVAXP
	j6BkMl2xWrgw1CAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742224394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKJ0o76pFzF4cyasE9l8ypMc3nCCOzv07GXIk83PeJ4=;
	b=mG7UqGVZ3AuNEfutNbAaNmDH8OG2xqtJkH99TCfN1YweVDV2vwV1fhm6UH/s1l3IqX/BC2
	Yr6hotUK1MPHEMVz+jWPBtI9Kp0z75AM44GgzJESmXpLwl7A/xoHHD2EcNZl5l3GGgiO4Z
	PHe4KMy6RbFZqU8Eo5GmZIzqymnRqCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742224394;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rKJ0o76pFzF4cyasE9l8ypMc3nCCOzv07GXIk83PeJ4=;
	b=azl7lUVrf8g4RqpptlivzFBBG4z1611dFDv10jII0+4PxquSFI2R978Iqnh67rMOomVAXP
	j6BkMl2xWrgw1CAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCA6B139D2;
	Mon, 17 Mar 2025 15:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BiJCNQk82GctfgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 17 Mar 2025 15:13:13 +0000
Date: Mon, 17 Mar 2025 16:13:12 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/9] btrfs: remove ASSERT()s for folio_order() and
 folio_test_large()
Message-ID: <20250317151312.GZ32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742195085.git.wqu@suse.com>
 <20250317135502.GW32661@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317135502.GW32661@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Score: -3.00
X-Spam-Flag: NO

On Mon, Mar 17, 2025 at 02:55:02PM +0100, David Sterba wrote:
> On Mon, Mar 17, 2025 at 05:40:45PM +1030, Qu Wenruo wrote:
> > [CHANGELOG]
> > v3:
> > - Prepare btrfs_end_repair_bio() to support larger folios
> >   Unfortunately folio_iter structure is way too large compared to
> >   bvec_iter, thus it's not a good idea to convert bbio::saved_iter to
> >   folio_iter.
> > 
> >   Thankfully it's not that complex to grab the folio from a bio_vec.
> > 
> > - Add a new patch to prepare defrag for larger data folios
> 
> I was not expecting v3 as the series was in for-next so I did some edits
[...]

Scratch that, this is not the same series.

