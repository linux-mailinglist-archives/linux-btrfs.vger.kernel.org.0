Return-Path: <linux-btrfs+bounces-5367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C38D50FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 19:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A49C1F24CE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EB046450;
	Thu, 30 May 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YCE5xdtb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BpjxbCGm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nRfcLrau";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="45CPVZTe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56446444
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090023; cv=none; b=Ma2lyavNdag8MvqYiCbQBjowF7wrcgeVLNkFexouK89j2ooJ2mCU1I0eq7DHSh1hHLQM/xHamyuU2ymI6U9CLQlFarKs6ZbZfjtul6A9XyHGRjv+gR6xaOH+4ijDb4HTMTKdyv36m83yt67vSwuqhhH6EeB7YAtc09aytgQ/GXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090023; c=relaxed/simple;
	bh=A+5dxvN50kdVhKb+zRH7hw805ZjkwlbOz348EYk1QJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RihycGzromnbCtU6YCoEi5Eeefq0s/xkMhy0pTaO7qoIP99XGKw2bd/L9Qz1wsPE3Y5aZC062qjkcsx6TfzZABFt7qm1cttHK+/KSqZLnnKughUeZ2g8TC4onO7YhzYTS8v6YrN19Z+VoZwMmGMcNPSqIPMg0nvhb+7tnYDQDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YCE5xdtb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BpjxbCGm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nRfcLrau; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=45CPVZTe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA1A11F747;
	Thu, 30 May 2024 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717090019;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpmEX24gR/gFf38yXEFnw+ud3EOAE5Z1xFRnK8VvaN4=;
	b=YCE5xdtb9nqmzfmHXoIfMvJQOC+tuPLbkg/dVota5HMUSupMlbu1N/uGoYWpaGGbQ12Gnw
	HeBtJalBc5EVJdj6VTXjLxLbFwX+SHDknPYAPMJPxUq2m+bdW9++KTwshCqhr6wAgfJaEJ
	9Tyis6enseEgljDB26g2WTNeo4wVMAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717090019;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpmEX24gR/gFf38yXEFnw+ud3EOAE5Z1xFRnK8VvaN4=;
	b=BpjxbCGmQ/h/fFf0ynObmZH6EZ8rzZO/hznHAPOIe6m8PSdsSndLiHsjutdZtF7m9mKWe0
	8V2hkBHpB8oXCCAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717090017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpmEX24gR/gFf38yXEFnw+ud3EOAE5Z1xFRnK8VvaN4=;
	b=nRfcLraub079BTED8/enJ7FpTE4OKwIh8Rqa5Qx2aeqOeVNm41Lwsl3UYEr6Q6P4EvX6FT
	GZRf3FjRtH0yqyg5xNYsNMSpxkucMkoD4ACwl1B8ooN2B7xYFv7CpdJECiEG5Tamo1VfIG
	teTgQvwlMXQLkbXdvEpZ1mY5/Y+msUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717090017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpmEX24gR/gFf38yXEFnw+ud3EOAE5Z1xFRnK8VvaN4=;
	b=45CPVZTe5D4GqsP5XS2NyQuOFP48L7yE9a5Ci8gZ6oT9iCeME67oCGJAfIJRMwNOkGyBga
	8DRHMx3JCG4y1fDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A71B713A42;
	Thu, 30 May 2024 17:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QYN+KOG2WGZxHAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 May 2024 17:26:57 +0000
Date: Thu, 30 May 2024 19:26:48 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 05/10] btrfs-progs: mkfs: align byte_count with
 sectorsize and zone size
Message-ID: <20240530172648.GA25460@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
 <20240529071325.940910-6-naohiro.aota@wdc.com>
 <63ce80fe-879e-469a-8d93-49aeb8659191@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63ce80fe-879e-469a-8d93-49aeb8659191@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,wdc.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]

On Wed, May 29, 2024 at 05:15:37PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/5/29 16:43, Naohiro Aota 写道:
> > While "byte_count" is eventually rounded down to sectorsize at make_btrfs()
> > or btrfs_add_to_fs_id(), it would be better round it down first and do the
> > size checks not to confuse the things.
> >
> > Also, on a zoned device, creating a btrfs whose size is not aligned to the
> > zone boundary can be confusing. Round it down further to the zone boundary.
> >
> > The size calculation with a source directory is also tweaked to be aligned.
> > device_get_partition_size_fd_stat() must be aligned down not to exceed the
> > device size. And, btrfs_mkfs_size_dir() should have return sectorsize aligned
> > size. So, add an UASSERT for it.
> >
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> To David, since I have the write permission to btrfs-progs and reviewed
> the series, can I push it to devel branch now?

OK, go on. I'm done for now with changes to fix the LE/BE and unaligned
access. For future it would be better if you create a pull request and
mark it that you want to merge it yourself, I could miss it in replies
to patches in the middle of a series.

