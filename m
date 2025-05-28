Return-Path: <linux-btrfs+bounces-14286-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88932AC747B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 01:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9B91BC71A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F49230D0E;
	Wed, 28 May 2025 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YyQ3f07X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMH5neBl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YyQ3f07X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tMH5neBl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B421D5B8
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474725; cv=none; b=YeoXnDWn//7KTTdzSCaEtpBGafBeu3GSP0WNanKOINLHUMZ+bwTNn1XNgLBeE7BvmvcmogJ8ofN+Ku4dDd7NFrdXmk68wQ+Xw13zfXYkHoqx8u7x6Q79dLmn3P3ZD3EjoHG91Eo+Csi7Kyu5aOp8YhrsaZEr6BKFADNPSMGbSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474725; c=relaxed/simple;
	bh=fPL2a2HlxQgM4Ff+AVxbPC1N3EU8XQYvMm+lVeIK+SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kK4GlVs1+So4uDO/vo4L+jfprL+mwLlMpN0slhbAkPpxEq9eLQiJKaRw3rbS5kviU6ICxwlED8wb9rIBSak6KUFPVfuWl4vpA4oBXvb9V+w5koGRSk50MKS7kfaN6wNUrpctAkaKpOGOfmcDfxOwRf8fnJbcWx1uaxo2hciJ8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YyQ3f07X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMH5neBl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YyQ3f07X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tMH5neBl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3966A216EC;
	Wed, 28 May 2025 23:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748474722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZrBKU8+NY1WxzP5+dtPb8uBssjUIdBREbLJKGEJscA=;
	b=YyQ3f07XA8kiPWg9w6QSK+cl2RaYesKwpIGpKm1MdmLWQBSGgqm22l0uVgTAGjynQ2v7fy
	1t39r4/YNXhX3vN7FNHy8Zh3RkqSouvs6Q//bM23T/WaUJCVjmMmJzx4dh0WvyhA5lG3OI
	2eNvSi2v1zxoOAtyDXmVUPRoFFjRcYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748474722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZrBKU8+NY1WxzP5+dtPb8uBssjUIdBREbLJKGEJscA=;
	b=tMH5neBlcqTcbLqa9vruqx6O8rvXHGmKCp2NmBGk+H29i8XKpy/nSYw/+YVUIdDjWGTPMT
	mdq4YhST5g5wZyBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748474722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZrBKU8+NY1WxzP5+dtPb8uBssjUIdBREbLJKGEJscA=;
	b=YyQ3f07XA8kiPWg9w6QSK+cl2RaYesKwpIGpKm1MdmLWQBSGgqm22l0uVgTAGjynQ2v7fy
	1t39r4/YNXhX3vN7FNHy8Zh3RkqSouvs6Q//bM23T/WaUJCVjmMmJzx4dh0WvyhA5lG3OI
	2eNvSi2v1zxoOAtyDXmVUPRoFFjRcYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748474722;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZrBKU8+NY1WxzP5+dtPb8uBssjUIdBREbLJKGEJscA=;
	b=tMH5neBlcqTcbLqa9vruqx6O8rvXHGmKCp2NmBGk+H29i8XKpy/nSYw/+YVUIdDjWGTPMT
	mdq4YhST5g5wZyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A74136E0;
	Wed, 28 May 2025 23:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HfyJA2KbN2gOXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 23:25:22 +0000
Date: Thu, 29 May 2025 01:25:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Josef Bacik <josef@toxicpanda.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v5 3/3] btrfs: use buffer xarray for extent buffer
 writeback operations
Message-ID: <20250528232516.GL4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745851722.git.josef@toxicpanda.com>
 <182a186a376f40b01dea6f4cd3da9ec84b62a088.1745851722.git.josef@toxicpanda.com>
 <dkvtoqqdlx7op3ta57fefmcbcshxsgrlu64mdldlkptzsiuise@xa7ihulvyyrc>
 <97723bdc-828b-47cc-afe4-469b9afd3a22@gmx.com>
 <h7tbeznpfl762xay6d4q72ghjqeqieqrhjvq3vk53oedm27yq2@ksw6k4ggrxwn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <h7tbeznpfl762xay6d4q72ghjqeqieqrhjvq3vk53oedm27yq2@ksw6k4ggrxwn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,toxicpanda.com,vger.kernel.org,fb.com,suse.com,wdc.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Mon, May 26, 2025 at 06:53:02AM +0000, Shinichiro Kawasaki wrote:
> On May 26, 2025 / 13:50, Qu Wenruo wrote:
> > 
> > 
> > 在 2025/5/26 10:47, Shinichiro Kawasaki 写道:
> > > On Apr 28, 2025 / 10:52, Josef Bacik wrote:
> > > > Currently we have this ugly back and forth with the btree writeback
> > > > where we find the folio, find the eb associated with that folio, and
> > > > then attempt to writeback.  This results in two different paths for
> > > > subpage eb's and >= pagesize eb's.
> > > > 
> > > > Clean this up by adding our own infrastructure around looking up tag'ed
> > > > eb's and writing the eb's out directly.  This allows us to unify the
> > > > subpage and >= pagesize IO paths, resulting in a much cleaner writeback
> > > > path for extent buffers.
> > > 
> > > [...]
> > > 
> > > When I ran blktests on the for-next kernel with the tag next-20250521, I
> > > observed the test case zdd/009 failed with repeated WARNs at
> > > release_extent_buffer() [1].
> > 
> > Unfortunately that's a known bug, fixed by this patch:
> > 
> > https://lore.kernel.org/linux-btrfs/b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com/
> > 
> 
> Ah, thank you for letting me know. I confirmed that the fix avoids the failure
> on my test system.

FYI, the fix is now in master.

