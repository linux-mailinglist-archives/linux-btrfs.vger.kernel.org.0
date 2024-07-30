Return-Path: <linux-btrfs+bounces-6879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C66994142D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BF61F25579
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F21A2572;
	Tue, 30 Jul 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o/LTdYw+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHiLL7RA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o/LTdYw+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHiLL7RA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBE1974FA;
	Tue, 30 Jul 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349021; cv=none; b=TTdZqnEd1OIhoVZ4ufHo4BfWt2syICHzARn4yGiigv0qagkheYugsJe7xaX9t4NZOdsztJGO3xXM1Qlrrh1lZyMYh9I/qVkCn2bVOsi4SdNTfnUAMyO8qJ0De/3ADzkxDuTncgt6kZuHleaSJ2tU/P06mgXisLYalhweMOD350c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349021; c=relaxed/simple;
	bh=7m3MiQsQ9koTNx3v01eza7T9WaT/o1AEwfofP0vf5I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEEidYjvoTHzat4V47N6dvtJeouGS8ZklXKckZYrX1KKcHwlLAPA4uIquBdaXRx8pwtkNNGfY8IIfyJlcSzGA3cLL2bo1Pz3jRZQaiz9Dc0GOUpvtvmW3D0RnTDqozmSpYirhPUa4v/3nNgnF92szKZkpKcUYr8nFjUGCF9zZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o/LTdYw+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHiLL7RA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o/LTdYw+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHiLL7RA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 767C71F806;
	Tue, 30 Jul 2024 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722349017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHYgDeR+YwfXlKpC0Hd6eV+yFDzQlRWhJk68UD4pU4=;
	b=o/LTdYw+XSMqqkWaq01jJzG/hhqltXZjo6YbpZNtO89F8+319O3SCs0q1CsxHkIUCA8E37
	VOicldbUk6LrZwewjz3H4GN2HWbk8ULYsd2XjugCr3NQ4Ql3toE89+hB5RSoGsJlSc6vNX
	Io/aUMCGH2KFrilqQ4uQ/KgH0NnIwV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722349017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHYgDeR+YwfXlKpC0Hd6eV+yFDzQlRWhJk68UD4pU4=;
	b=gHiLL7RA+Db3AE5Fk9EC9ZQ/ud5sRmQv8uEIV1jrE2zEfDoCX9WXjSNannaGO4k0rGOhuS
	8OGzkDcXPiQEmEBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722349017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHYgDeR+YwfXlKpC0Hd6eV+yFDzQlRWhJk68UD4pU4=;
	b=o/LTdYw+XSMqqkWaq01jJzG/hhqltXZjo6YbpZNtO89F8+319O3SCs0q1CsxHkIUCA8E37
	VOicldbUk6LrZwewjz3H4GN2HWbk8ULYsd2XjugCr3NQ4Ql3toE89+hB5RSoGsJlSc6vNX
	Io/aUMCGH2KFrilqQ4uQ/KgH0NnIwV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722349017;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fsHYgDeR+YwfXlKpC0Hd6eV+yFDzQlRWhJk68UD4pU4=;
	b=gHiLL7RA+Db3AE5Fk9EC9ZQ/ud5sRmQv8uEIV1jrE2zEfDoCX9WXjSNannaGO4k0rGOhuS
	8OGzkDcXPiQEmEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5561F13297;
	Tue, 30 Jul 2024 14:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sc8FFNn1qGZ7aQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:16:57 +0000
Date: Tue, 30 Jul 2024 16:16:56 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+8e86db7d430e87415248@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] INFO: trying to register non-static key in
 btrfs_stop_all_workers
Message-ID: <20240730141656.GD17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000de6b81061a5938d6@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000de6b81061a5938d6@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[8e86db7d430e87415248];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30

On Fri, Jun 07, 2024 at 09:19:28PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f06ce441457d Merge tag 'loongarch-fixes-6.10-1' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=176b7026980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=998c63c06e77f5e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=8e86db7d430e87415248
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
There's only one syzbot report and the timeframe corresponds with
increased number of bogus errors caused by use-after-free of a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

