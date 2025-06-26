Return-Path: <linux-btrfs+bounces-14998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C865BAEA001
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA6F172927
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E82E7645;
	Thu, 26 Jun 2025 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KW5mFqHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="30wVw3Jb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KW5mFqHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="30wVw3Jb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854392E175E
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Jun 2025 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947122; cv=none; b=sdR0iQ8YQaOZGO/xSfwWJdoxMhPfVpYeHRuprYjRqTC5HuMsoYmK3yeYnDUAnpFCUM4USiahY/klT0rfq4k3PS/kB942P0IPQPXltd/45Wh7q9TQg9blC7A/4wMq1VtKdaB0uIMaxEqtGmhW4F0lPUZKXcZPKgDDyvbZYGUSRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947122; c=relaxed/simple;
	bh=vW7eYbK/9NNNyMZVODEauDQlGlfqejSdtHUPDCjAd9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuOecZbL9nRX2jghl/Cfe7xrso4FWuxxVR+55CkwsNd6aLk8KJgKAqzpAfrAoxD7c2gNXUGMyB5pHmST8JnvT9epmI5txxwCYDH5YDxzai5K9Cw4gXcH7jI2L21eerI8dNwSc2Nfsslvvt8wOVmedrm64KFzg6SfLfXjUdhf4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KW5mFqHw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=30wVw3Jb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KW5mFqHw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=30wVw3Jb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93B711F38D;
	Thu, 26 Jun 2025 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750947112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue6zPaRnifdtlufI3hPyxTmp3BYGU4hI4Gw9HaJTpIo=;
	b=KW5mFqHw4SDiwALS/J4NxP+flNkDt9fqm8NrOpL4VhDyfCYtujOTUx78Tnmts+cvL2Omii
	qWLe95VZPKL1MNtLheWjCiiOR2hIKpkkdNSvuCeQaIo8/+GPKXPu9fse0h309ROF0aamZz
	o5Dl41JwKuJawSUbVWLsiifa8k5hKhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750947112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue6zPaRnifdtlufI3hPyxTmp3BYGU4hI4Gw9HaJTpIo=;
	b=30wVw3JbC5I+5GGMjsTIaSbzhBYBPDhH8JLDL/TRqk5lkgyXwg2YlrMQiRq6R3g+K3eATR
	7OLRSs0foJW9M0DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KW5mFqHw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=30wVw3Jb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750947112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue6zPaRnifdtlufI3hPyxTmp3BYGU4hI4Gw9HaJTpIo=;
	b=KW5mFqHw4SDiwALS/J4NxP+flNkDt9fqm8NrOpL4VhDyfCYtujOTUx78Tnmts+cvL2Omii
	qWLe95VZPKL1MNtLheWjCiiOR2hIKpkkdNSvuCeQaIo8/+GPKXPu9fse0h309ROF0aamZz
	o5Dl41JwKuJawSUbVWLsiifa8k5hKhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750947112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ue6zPaRnifdtlufI3hPyxTmp3BYGU4hI4Gw9HaJTpIo=;
	b=30wVw3JbC5I+5GGMjsTIaSbzhBYBPDhH8JLDL/TRqk5lkgyXwg2YlrMQiRq6R3g+K3eATR
	7OLRSs0foJW9M0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 725F0138A7;
	Thu, 26 Jun 2025 14:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EmgyGyhVXWh5KAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 26 Jun 2025 14:11:52 +0000
Date: Thu, 26 Jun 2025 16:11:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: cen zhang <zzzccc427@gmail.com>, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com
Subject: Re: [BUG] btrfs: Assertion failed in btrfs_exclop_balance on balance
 ioctl
Message-ID: <20250626141151.GB31241@suse.cz>
Reply-To: dsterba@suse.cz
References: <CAFRLqsVDimnqBx0_pDF-bqEQ3epha2d3r6cKm-0b6UdzkkE42Q@mail.gmail.com>
 <bbe21da7-eed3-4fb9-afd9-6f1c70c0eaed@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbe21da7-eed3-4fb9-afd9-6f1c70c0eaed@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FREEMAIL_CC(0.00)[gmail.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 93B711F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Thu, Jun 26, 2025 at 06:50:17PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/26 17:37, cen zhang 写道:
> > Hello Btrfs maintainers,
> > 
> > I would like to report a kernel BUG, which appears to be a state
> > management issue in the balance ioctl path.
> > 
> > The kernel panics due to a failed assertion in btrfs_exclop_balance()
> > at fs/btrfs/fs.c:127. The assertion fs_info->exclusive_operation ==
> > BTRFS_EXCLOP_BALANCE_PAUSED fails, indicating that the function was
> > called with an unexpected exclusive operation state.
> > 
> > Here are the relevant details:
> > 
> > Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
> > Hardware: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996)
> 
> Reproducer please?
> 
> I guess you guys are running syzbot, then please provide the usual 
> syzbot assets.

This might be the but that was once reported, I'll try to look it up,
some edge case of the exclusive ops and the convoluted balance states.

