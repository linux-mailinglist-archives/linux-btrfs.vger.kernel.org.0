Return-Path: <linux-btrfs+bounces-645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9568805962
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99201C21123
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1960BB1;
	Tue,  5 Dec 2023 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MDhKDnA0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gVt8g8oE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF00196
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Dec 2023 08:02:38 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E119E21D52;
	Tue,  5 Dec 2023 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701792156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kf0LZDEGEaX23QTb4FXK4jAfQ6mPmAZoEtJ2g9w96nY=;
	b=MDhKDnA0UWikiaCFa1XsY5g6ANhvw59gG4ZtfaYlD5TTyJb4AseulvhZkCzbD5HLEfQ3qH
	mkts510sN49a7EEAijeKbj75uwo9nH1J2nOfhlO17PxPkoQIEP0POoIIqPj3Lk2/Pf2qpj
	M28U3e5k9ozTEk92ArgRTb6BnNpOqCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701792156;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kf0LZDEGEaX23QTb4FXK4jAfQ6mPmAZoEtJ2g9w96nY=;
	b=gVt8g8oE3C9dhZZImmYGirMA/xYjlVMJ9+ZXyOt5owvQzAL9plTxpSi1EbCo1w7Q1eeaNY
	sftAcjVFeZjM6vDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C4CF313924;
	Tue,  5 Dec 2023 16:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cx3TL5xJb2UeJwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Dec 2023 16:02:36 +0000
Date: Tue, 5 Dec 2023 16:55:47 +0100
From: David Sterba <dsterba@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christian Brauner <brauner@kernel.org>, linux-btrfs@vger.kernel.org
Subject: Re: [linux-next:master] [btrfs]  7d59ee54f0: xfstests.btrfs.220.fail
Message-ID: <20231205155546.GH2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <202312051101.f6be0b61-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312051101.f6be0b61-oliver.sang@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [0.15 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.05)[-0.271];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.15
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 

On Tue, Dec 05, 2023 at 02:44:29PM +0800, kernel test robot wrote:
> commit: 7d59ee54f0ef2b1bc3eece201e580b70d1bba4cb ("btrfs: remove code for inode_cache and recovery mount options")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> btrfs/220       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//btrfs/220.out.bad)
>     --- tests/btrfs/220.out	2023-11-22 02:47:17.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//btrfs/220.out.bad	2023-12-04 03:57:08.228523511 +0000
>     @@ -1,2 +1,4 @@
>      QA output created by 220
>     -Silence is golden
>     +mount: /fs/scratch: wrong fs type, bad option, bad superblock on /dev/sdb2, missing codepage or helper program, or other error.
>     +mount -o norecovery,ro /dev/sdb2 /fs/scratch failed

We need an update to fstests, there are tests using the 'norecovery'
option and 'nologreplay' should be switched to 'rescue=nologreplay' too.

