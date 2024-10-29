Return-Path: <linux-btrfs+bounces-9213-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4859B547E
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589A11F22747
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5198208230;
	Tue, 29 Oct 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgQSF9Um";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ndcPxxE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PgQSF9Um";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ndcPxxE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB964192D9E;
	Tue, 29 Oct 2024 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235327; cv=none; b=tV/7RyPkhCiJBQU6dLmjviqOHTKQB+auNSPBPwVoDsTod51xjGTOW81l6DIujM73bcTjIXapRT5AJw+loKa8IAeu89mERje/umgqBZvjRbawI+RZuuR7IM9i33ZBeDwLIoCVgxC3GLjlzKpdeOoHe9puFWq4bW/Fe0fk7WPVaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235327; c=relaxed/simple;
	bh=zORNROIt9LLuMKdxFK3drDPJbNsLq+6ymwCBgPK4pHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4nDe/IKpN+tMai8j/rL5Y4owoUyZXCB1n1uC/M28DwEPbbWH96fLkC03echtrooBUbAq6WDdJ7NlCSBDzER7dVH4cjxXrea2wzZILjb+ym/Hn8Di7CC767DbI7cHsy6cO9ueVN2uZ/vYF77Ackxj0ZF/MqSsI9PjQC02/AKDGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgQSF9Um; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ndcPxxE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PgQSF9Um; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ndcPxxE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98CD31F388;
	Tue, 29 Oct 2024 20:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730235322;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9Sck+ZPlJiQpWiXfGp/pjl033oLyWfOfDjlVSnLv2A=;
	b=PgQSF9UmfKPFFv3lPcyWU4+5Nnqht47y1DSiviCEYQXYdQ4IZCVeb/4N5bMDQbHZTrcNmH
	cIOV1MRAEaiXsqE6kYqhC7nVB+UFSx5JC0FaenWk+YbgDL1y6HRgBHy4ffD/7h1WgQegPI
	NCcPl+7SGKuDivTfAngHRovEGlbnlN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730235322;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9Sck+ZPlJiQpWiXfGp/pjl033oLyWfOfDjlVSnLv2A=;
	b=9ndcPxxEtoF6gZTvTapVDqAJqxhZYfFGM5jd7aL3Ob67PejEKmBq8D9auhnKdSvRBe9dyQ
	/UXlTnYxiFhkANDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PgQSF9Um;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ndcPxxE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730235322;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9Sck+ZPlJiQpWiXfGp/pjl033oLyWfOfDjlVSnLv2A=;
	b=PgQSF9UmfKPFFv3lPcyWU4+5Nnqht47y1DSiviCEYQXYdQ4IZCVeb/4N5bMDQbHZTrcNmH
	cIOV1MRAEaiXsqE6kYqhC7nVB+UFSx5JC0FaenWk+YbgDL1y6HRgBHy4ffD/7h1WgQegPI
	NCcPl+7SGKuDivTfAngHRovEGlbnlN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730235322;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9Sck+ZPlJiQpWiXfGp/pjl033oLyWfOfDjlVSnLv2A=;
	b=9ndcPxxEtoF6gZTvTapVDqAJqxhZYfFGM5jd7aL3Ob67PejEKmBq8D9auhnKdSvRBe9dyQ
	/UXlTnYxiFhkANDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61371136A5;
	Tue, 29 Oct 2024 20:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UYf7FbpLIWf7agAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Oct 2024 20:55:22 +0000
Date: Tue, 29 Oct 2024 21:55:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Edward Adam Davis <eadavis@qq.com>,
	syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com, clm@fb.com,
	dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] btrfs: add a sanity check for csum root before fill the
 data csum
Message-ID: <20241029205506.GR31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
 <tencent_B5CA92105D925DA2993D4FD20DDD25BF8D07@qq.com>
 <20241025184424.GL31418@twin.jikos.cz>
 <09b446c0-0c47-4822-b14f-5df1e7e4f4de@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09b446c0-0c47-4822-b14f-5df1e7e4f4de@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 98CD31F388
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com,qq.com];
	FREEMAIL_CC(0.00)[suse.cz,qq.com,syzkaller.appspotmail.com,fb.com,suse.com,toxicpanda.com,vger.kernel.org,googlegroups.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[5d2b33d7835870519b5f];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Sat, Oct 26, 2024 at 07:45:18AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2024/10/26 05:14, David Sterba 写道:
> > On Wed, Oct 23, 2024 at 07:04:40PM +0800, Edward Adam Davis wrote:
> >> Syzbot reported a null-ptr-deref in btrfs_lookup_csums_bitmap.
> >> The btrfs info contains IGNOREDATACSUMS, which prevents the csum root from
> >> being loaded.
> >> Before filling in the csum data, check the flag BTRFS_FS_STATE_NO_DATA_CSUMS
> >> to confirm that the csum root has been loaded.
> >>
> >> Reported-and-tested-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=5d2b33d7835870519b5f
> >> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> >
> > Added to for-next, thanks.
> 
> Wait for a second, I believe LiZhi Xu's solution is better.
> 
> And sorry I didn't notice that until his patch is submitted.
> 
> The problem for this fix is, although it fixes the crash, it also gives
> a false feel of safety that scrub is finding nothing wrong.
> 
> But the truth is, there is no csum root, and everything can go wrong.
> 
> Thus I'd prefer LiZhi's solution which error out and terminate the scrub
> immediately.

Ok, I've dropped this patch from for-next. Please add "btrfs: add a
sanity check for btrfs root".

