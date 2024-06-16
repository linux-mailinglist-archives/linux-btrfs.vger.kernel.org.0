Return-Path: <linux-btrfs+bounces-5742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF49909F0D
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 20:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B78B233A5
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276B3B7A8;
	Sun, 16 Jun 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jd9V+IE3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0HSqIWW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jd9V+IE3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0HSqIWW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE74512B93
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Jun 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561864; cv=none; b=dgKqsfnwQM0l/wWEUIxwjWEKB0Go4Rvz3ar+HNKmkkJdx3iLv3lfWss4UiMDMtjjZZJcg+w7mr7lrW7dHRWY6vAkEBgu2QsBloFYzN0Vk7H5E6hEa+l3cSre25YsVLr57VZBbOtmQoo/rMuZAI+yIMtRTFEclfQOzl3B/MhtREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561864; c=relaxed/simple;
	bh=oQvCBMPTLA+nsgW4Ghhk9Z2fHngkVaVPMgE0tmfF9Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+SqeeGVkowAukb2zwFg5Y3nc4fspqCLbyAPX0hg5MP5St6MVZjuVPzqC86DPVrCWOF1ZqmchmQb+R4dKtbjQIjjRHPHtdcksf38djhe2Wrp06W+HT56/DHRGbV0vZUsK2WYJNKNxEEjmVdi+jOpPTBw9OQlaUigALGt1U6JrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jd9V+IE3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0HSqIWW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jd9V+IE3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0HSqIWW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 358EF5D54D;
	Sun, 16 Jun 2024 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718561854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdUuTHcMjmft0Pt7VUOGgfPyiJiaoGIyAJLGepQYgMk=;
	b=Jd9V+IE3rdg7CVlLyUeruR4qQIub8I1u4/JdA+PG6afceObNyA/mvj6i3xEgTYuINt22hp
	fGHiW/bApGVU1e2S0AczdHiWZyEDUNBFXG+2rkrDSy7yAfNz8Nf8Upd5FT5dib1rc886Os
	GzP7hJrEzU5RfUtJQekt8wFW6V208iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718561854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdUuTHcMjmft0Pt7VUOGgfPyiJiaoGIyAJLGepQYgMk=;
	b=B0HSqIWW0rGjFgWyimlsm2/bJXg/Co8m36S1U9PtotvRhsp+gzzh9SSTbAyKX/RARf5qS8
	951Epklnvl1lUhDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jd9V+IE3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B0HSqIWW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718561854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdUuTHcMjmft0Pt7VUOGgfPyiJiaoGIyAJLGepQYgMk=;
	b=Jd9V+IE3rdg7CVlLyUeruR4qQIub8I1u4/JdA+PG6afceObNyA/mvj6i3xEgTYuINt22hp
	fGHiW/bApGVU1e2S0AczdHiWZyEDUNBFXG+2rkrDSy7yAfNz8Nf8Upd5FT5dib1rc886Os
	GzP7hJrEzU5RfUtJQekt8wFW6V208iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718561854;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdUuTHcMjmft0Pt7VUOGgfPyiJiaoGIyAJLGepQYgMk=;
	b=B0HSqIWW0rGjFgWyimlsm2/bJXg/Co8m36S1U9PtotvRhsp+gzzh9SSTbAyKX/RARf5qS8
	951Epklnvl1lUhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D02413AA0;
	Sun, 16 Jun 2024 18:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NfGAAj4sb2YvGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sun, 16 Jun 2024 18:17:34 +0000
Date: Sun, 16 Jun 2024 20:17:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/4] btrfs: introduce new "rescue=ignoremetacsums" mount
 option
Message-ID: <20240616181724.GD25756@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718082585.git.wqu@suse.com>
 <f6b9b9037ee7912ed2081da9c4b05fd367c9e8f8.1718082585.git.wqu@suse.com>
 <20240612193821.GK18508@twin.jikos.cz>
 <ffa354b9-4315-4e29-af2a-124a697d0eef@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffa354b9-4315-4e29-af2a-124a697d0eef@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 358EF5D54D
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, Jun 14, 2024 at 06:58:20AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/6/13 05:08, David Sterba 写道:
> > On Tue, Jun 11, 2024 at 02:51:37PM +0930, Qu Wenruo wrote:
> >> This patch introduces "rescue=ignoremetacsums" to ignore metadata csums,
> >> meanwhile all the other metadata sanity checks are still kept as is.
> >>
> >> This new mount option is mostly to allow the kernel to mount an
> >> interrupted checksum conversion (at the metadata csum overwrite stage).
> >>
> >> And since the main part of metadata sanity checks is inside
> >> tree-checker, we shouldn't lose much safety, and the new mount option is
> >> rescue mount option it requires full read-only mount.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> >> --- a/fs/btrfs/disk-io.c
> >> +++ b/fs/btrfs/disk-io.c
> >> @@ -367,6 +367,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
> >>   	u8 result[BTRFS_CSUM_SIZE];
> >>   	const u8 *header_csum;
> >>   	int ret = 0;
> >> +	bool ignore_csum = btrfs_test_opt(fs_info, IGNOREMETACSUMS);
> >
> > const
> >
> >> --- a/fs/btrfs/messages.c
> >> +++ b/fs/btrfs/messages.c
> >> @@ -20,7 +20,7 @@ static const char fs_state_chars[] = {
> >>   	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
> >>   	[BTRFS_FS_STATE_DEV_REPLACING]		= 'R',
> >>   	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= 0,
> >> -	[BTRFS_FS_STATE_NO_CSUMS]		= 'C',
> >> +	[BTRFS_FS_STATE_NO_DATA_CSUMS]		= 'C',
> >
> > There should be the status also when the metadata checksums are not
> > validated, the letters are arbitrary but should reflect the state if
> > possible, I'd suggest to use 'S' here.
> 
> I'd prefer to change the NO_DATA_CSUMS one to use 'D' or 'd' (for data),
> meanwhile for metadata we go 'M' or 'm'.

Changing would break backward compatibility, now it's part of user
visible interface. It's not an ABI or API but at least we should do such
changes without considering the consequences.

> But on the other hand, I do not think data/meta csum ignoring really
> deserves a dedicated state char.
> 
> It's not really that special compared to trans aborted or dummy fs.
> (The same for dev-replacing)

The idea of the descriptors is to make it visible that the filesystem is
in some unusual state, skipping checksum verification can make a
difference when reading blocks that would normally not pass the check.

