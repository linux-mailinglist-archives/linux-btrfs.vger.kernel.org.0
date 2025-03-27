Return-Path: <linux-btrfs+bounces-12624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66AA73DFD
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 19:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471D97A6055
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39B621A928;
	Thu, 27 Mar 2025 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjCJqHJr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CaeiXBC4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TjCJqHJr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CaeiXBC4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D813F4F1
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099927; cv=none; b=ilHnnk8QY2TXNmrscLkCbHMDtbRRpCwlJ7pmFYdphNe9R6mQqs56OmQGIX2HbE5m2bvXx7LKppT3f5MT5TCC7xnTLI/PoJk4cTjwD6hOjvNAuZ9ZZR8fIG7zdfS15Su7J+NIIsxo7JwgWuVPbq931kLWtheKGqgGQlTnXEH9Ro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099927; c=relaxed/simple;
	bh=OulG0XLHl860fDu1KpdrDZ4jIsi48op/mKLO0ODW4KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmnqBlUoCl5+iPuyfDjRYzioGuLvrxy7Hoq1sWHYd1bvzd/AreLtiU9TqkfL/KwGH/Ne8ExhP+PHBx8Td1/1odlys7ZQpZG999qCKmxUHbZQqrHEB5akHwpYLfuae0nO5C+gc7nJzcVhc/g/yN9oy2blmN7oaXkXNDiMnAVb4sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjCJqHJr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CaeiXBC4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TjCJqHJr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CaeiXBC4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FEB71F449;
	Thu, 27 Mar 2025 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUCyKW2kmDHCfqlcerOqkSIiGM1Gg6BwtOUC1hJuz88=;
	b=TjCJqHJruYL0W2fhkdzFUeTGvuUPivWludlFvM1YnuE95j1/ZlyRontfQVM3YVoHhzpFPQ
	zBz+u0ofu4BjTMdXi2iiSBPkzfrY3XFZk6B+lFpGqcWE45c7eCFIuQ75G3fTBzXUxQXU6P
	nmKDm81e8OlEvm0LXt89pHF5Dvxpe7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUCyKW2kmDHCfqlcerOqkSIiGM1Gg6BwtOUC1hJuz88=;
	b=CaeiXBC4dlNBDD3k+XL6nYmBkgtr8fxKd/Pbciz8yHgVECJ4PtGTjqZedC4mzKx6VPIrnI
	5FWInIEUtDrgEiCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743099923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUCyKW2kmDHCfqlcerOqkSIiGM1Gg6BwtOUC1hJuz88=;
	b=TjCJqHJruYL0W2fhkdzFUeTGvuUPivWludlFvM1YnuE95j1/ZlyRontfQVM3YVoHhzpFPQ
	zBz+u0ofu4BjTMdXi2iiSBPkzfrY3XFZk6B+lFpGqcWE45c7eCFIuQ75G3fTBzXUxQXU6P
	nmKDm81e8OlEvm0LXt89pHF5Dvxpe7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743099923;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aUCyKW2kmDHCfqlcerOqkSIiGM1Gg6BwtOUC1hJuz88=;
	b=CaeiXBC4dlNBDD3k+XL6nYmBkgtr8fxKd/Pbciz8yHgVECJ4PtGTjqZedC4mzKx6VPIrnI
	5FWInIEUtDrgEiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CB44139D4;
	Thu, 27 Mar 2025 18:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6dTxHROY5WfaKwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 18:25:23 +0000
Date: Thu, 27 Mar 2025 19:25:18 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+bbbdd6d6efbfc5174561@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_free_fs_info (2)
Message-ID: <20250327182518.GC32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <67b8a9a8.050a0220.14d86d.057a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b8a9a8.050a0220.14d86d.057a.GAE@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[bbbdd6d6efbfc5174561];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Fri, Feb 21, 2025 at 08:28:24AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0ad2507d5d93 Linux 6.14-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=179ae898580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
> dashboard link: https://syzkaller.appspot.com/bug?extid=bbbdd6d6efbfc5174561
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6bb4d4755dce/disk-0ad2507d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/57594e8f74d9/vmlinux-0ad2507d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a4f2442a20b1/bzImage-0ad2507d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bbbdd6d6efbfc5174561@syzkaller.appspotmail.com
> 
> assertion failed: percpu_counter_sum_positive(em_counter) == 0, in fs/btrfs/disk-io.c:1266
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/disk-io.c:1266!

void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
{
        struct percpu_counter *em_counter = &fs_info->evictable_extent_maps;

        percpu_counter_destroy(&fs_info->stats_read_blocks);
        percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
        percpu_counter_destroy(&fs_info->delalloc_bytes);
        percpu_counter_destroy(&fs_info->ordered_bytes);
        if (percpu_counter_initialized(em_counter))
                ASSERT(percpu_counter_sum_positive(em_counter) == 0);

