Return-Path: <linux-btrfs+bounces-16601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B2B40D6F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 20:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29303B09B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 18:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CDD341ACA;
	Tue,  2 Sep 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="idMAqGmJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZLbhDFr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="idMAqGmJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZLbhDFr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858F18027
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839481; cv=none; b=IVFWD9xwbawVXejbso/4/A66iJN/PSNdn7xfvIZNFuPDm8r3jw/l9Iy374gi+EGhI66yGht/LIEC+xTNX6L9EvDTGVgjAy1DHNpC7CWZTF12W9RWBSqIZr07SlRyP40TtZ3XJYxMjO5t2VtZxZbp6zT+CcrMDk2scdDGe8rnpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839481; c=relaxed/simple;
	bh=XbpynK7PzzJ9069supgH7bFQamQvVZ4TXeLescs+Qj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv/qNPEG2lUIOflnwwr8ocfdb1PynsQ7xJAku6IRcaotO/4/hABnQV7cTve4rTO1CZ1xQpSxHOlwOZK565mcbkT9mWzEEC/o5uovszrwyKF+4JPILaYVzV1Jw5nVIPwO66VFzIEEy3vBR4phPV0sLXMYKpPj2m6I5KNt7KiQoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=idMAqGmJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZLbhDFr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=idMAqGmJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZLbhDFr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53CCE1F38A;
	Tue,  2 Sep 2025 18:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756839478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knppk8Sfcz4rpTvgLb0P0zclYCh5o0cxSK8ANZPYJ9s=;
	b=idMAqGmJxvA4o+YiQA0JnrcUtCw9rQvslxGSNQcTx/pky3O0q8H0L+TZxkrvtZLw66kXXK
	tj3789dfmKrhKQnKcnIIIp3ORr6FXnBotaSfIqpx0Iso/JliNSg2J6/+V34MXuhEpEdYhx
	fApJOnJc6mB4PRh1G2HbcqkkACs/wNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756839478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knppk8Sfcz4rpTvgLb0P0zclYCh5o0cxSK8ANZPYJ9s=;
	b=2ZLbhDFrsyu6u2g8HIidlF+MYGV7doH09fGnf/4oViVwhKzLStDwZu1lQsPIpJ2jogAOCW
	GBGlQF4/u6efXbAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756839478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knppk8Sfcz4rpTvgLb0P0zclYCh5o0cxSK8ANZPYJ9s=;
	b=idMAqGmJxvA4o+YiQA0JnrcUtCw9rQvslxGSNQcTx/pky3O0q8H0L+TZxkrvtZLw66kXXK
	tj3789dfmKrhKQnKcnIIIp3ORr6FXnBotaSfIqpx0Iso/JliNSg2J6/+V34MXuhEpEdYhx
	fApJOnJc6mB4PRh1G2HbcqkkACs/wNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756839478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Knppk8Sfcz4rpTvgLb0P0zclYCh5o0cxSK8ANZPYJ9s=;
	b=2ZLbhDFrsyu6u2g8HIidlF+MYGV7doH09fGnf/4oViVwhKzLStDwZu1lQsPIpJ2jogAOCW
	GBGlQF4/u6efXbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37C9313888;
	Tue,  2 Sep 2025 18:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nn1vDTY+t2gKbgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Sep 2025 18:57:58 +0000
Date: Tue, 2 Sep 2025 20:57:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs-progs: tests: add new mkfs test for zoned
 device
Message-ID: <20250902185757.GJ5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-4-naohiro.aota@wdc.com>
 <381793b8-e35a-4b4d-965f-8f78cdcde8a3@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381793b8-e35a-4b4d-965f-8f78cdcde8a3@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Tue, Sep 02, 2025 at 09:59:20AM +0000, Johannes Thumshirn wrote:
> On 9/2/25 6:30 AM, Naohiro Aota wrote:
> > +if [ -f "/sys/fs/btrfs/features/raid_stripe_tree" ]; then
> > +	test_mkfs_single  -d  dup     -m  single
> > +	test_mkfs_single  -d  dup     -m  dup
> > +
> > +	test_mkfs_multi   -d  raid0   -m  raid0
> > +	test_mkfs_multi   -d  raid1   -m  raid1
> > +	test_mkfs_multi   -d  raid10  -m  raid10
> > +	# RAID5/6 are not yet supported.
> > +	# test_mkfs_multi   -d  raid5   -m  raid5
> > +	# test_mkfs_multi   -d  raid6   -m  raid6
> > +	test_mkfs_multi   -d  dup     -m  dup
> > +
> > +	if [ -f "/sys/fs/btrfs/features/raid1c34" ]; then
> > +		test_mkfs_multi   -d  raid1c3 -m  raid1c3
> > +		test_mkfs_multi   -d  raid1c4 -m  raid1c4
> > +	else
> > +		_log "skip mount test, missing support for raid1c34"
> > +		test_do_mkfs -d raid1c3 -m raid1c3 ${nullb_devs[@]}
> > +		test_do_mkfs -d raid1c4 -m raid1c4 ${nullb_devs[@]}
> > +	fi
> > +
> > +	# Non-standard profile/device combinations
> > +
> > +	# Single device raid0, two device raid10 (simple mount works on older kernels too)
> > +	test_do_mkfs -d raid0 -m raid0 "$dev1"
> > +	test_get_info
> > +	test_do_mkfs -d raid10 -m raid10 "${nullb_devs[1]}" "${nullb_devs[2]}"
> > +	test_get_info
> > +fi
> Wouldn't this need to check if mkfs.btrfs supports "-O raid-stripe-tree" 
> as well?

The assumption of the environment is that kernel may not support all
features so there are the sysfs checks. For progs this assumes that it's
either a git version or the the testsuite version matches the installed
progs version.

We could possibly encode the assumptions simlar to what check_prereq()
does but for version-dependent features. I'm not sure if it's worth, so
far nobody else complained but it does make sense to make it more
robust.

