Return-Path: <linux-btrfs+bounces-6089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCC991E053
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1D0284185
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CE315B542;
	Mon,  1 Jul 2024 13:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FpvwXNDK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ihtUORu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NPyCI3bL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PRNT9Q06"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A921EB2A
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839570; cv=none; b=mq+BbAhO40SQronqRP/xlmKkAgA7V6P/XKYwucmMFj6QZtZjtkDt3ItqW4kgThIzF3hTuvFvS9/7i8rQhEulKfQM/jT+z5+Fyr1VZB2kHOKC3x/g/WwfmY8FmPv0Rq77nngmUjclRyAfjUiWB7Wumprstkn0BuuxQOlTSEZwkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839570; c=relaxed/simple;
	bh=MTx6zEUzqSR9xHkvdXhDJr+WfUve9RFq3Lfo1VsfSdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/Q0/zWnx2d37o3yaAHfZXPRipjsUDk0mpBNFDZfq6WnjpGuN1TKlAVS60JglFWNEkKoU4uHrZ7q89ewmdYlmVn2IcnpyYHFxUqqaHSq7Q7mr8pAShKRV0ePZsI2k3phUzsk5kmjgiBlrqGRsskSrL1svxDyCXDcCQxFBhjnHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FpvwXNDK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ihtUORu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NPyCI3bL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PRNT9Q06; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F3E9E1FB46;
	Mon,  1 Jul 2024 13:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719839567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF9M0oUqXEtn9c/qQwJRMv6nK+Wd8TeIvXcLe0jGRcA=;
	b=FpvwXNDK8KgnuIRzKf9p7k7S2sejQlWIcZLKWG2PLbIE+xBaASvZLy2kSgGXS3lUTGuBVs
	qAaKG9a2ylxa2FwxisBzpWWWNobXHq6d59x7tpwEHETwxgDNzbWZ9eLx3thcDa4gsbDbHG
	E0JlCWkVKACvTJNh2JzL+rQbAbK6lT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719839567;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF9M0oUqXEtn9c/qQwJRMv6nK+Wd8TeIvXcLe0jGRcA=;
	b=9ihtUORu3useQuBnReOTf2H3iND5OSBWmq4C72CQyp6IF/xYZZbxUUwQG6SRJoiMMmGmA+
	k5FuZDp6uHz9b3DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719839566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF9M0oUqXEtn9c/qQwJRMv6nK+Wd8TeIvXcLe0jGRcA=;
	b=NPyCI3bL16d6tAjdFVDb05fYrIUM3OkQ8u4BIFRXWNY0bIghVePdv64TSwRzsGfwpAoW8/
	XS0JjGS2N7Z3OdmHFMuQHgaCnxCuLBf72gwBvzHSr1Y/tUwmjqIkLZEhypoG1j6fmwR1WU
	mt4K58r9wP+p414rXxM2PUJpQlY0H7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719839566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NF9M0oUqXEtn9c/qQwJRMv6nK+Wd8TeIvXcLe0jGRcA=;
	b=PRNT9Q06cp+s62dOH62SZ+abpleG4gjWXEkZu3oIqsejnWsWMgK7CvJQtjm3wk/jicr3PX
	H39qzKFEoKNTTHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7FD0139C2;
	Mon,  1 Jul 2024 13:12:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CgZ9NE2rgma5VwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 01 Jul 2024 13:12:45 +0000
Date: Mon, 1 Jul 2024 15:12:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
Message-ID: <20240701131244.GB21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]

On Fri, Jun 28, 2024 at 01:32:24PM +0900, Naohiro Aota wrote:
> There is a potential parallel list adding for retrying in
> btrfs_reclaim_bgs_work and adding to the unused list. Since the block
> group is removed from the reclaim list and it is on a relocation work,
> it can be added into the unused list in parallel. When that happens,
> adding it to the reclaim list will corrupt the list head and trigger
> list corruption like below.
> 
> Fix it by taking fs_info->unused_bgs_lock.
> 
> [27177.504101][T2585409] BTRFS error (device nullb1): error relocating ch= unk 2415919104
> [27177.514722][T2585409] list_del corruption. next->prev should be ff1100= 0344b119c0, but was ff11000377e87c70. (next=3Dff110002390cd9c0)
> [27177.529789][T2585409] ------------[ cut here ]------------
> [27177.537690][T2585409] kernel BUG at lib/list_debug.c:65!
> [27177.545548][T2585409] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> [27177.555466][T2585409] CPU: 9 PID: 2585409 Comm: kworker/u128:2 Tainted: G        W          6.10.0-rc5-kts #1
> [27177.568502][T2585409] Hardware name: Supermicro SYS-520P-WTR/X12SPW-TF, BIOS 1.2 02/14/2022
> [27177.579784][T2585409] Workqueue: events_unbound btrfs_reclaim_bgs_work[btrfs]
> [27177.589946][T2585409] RIP: 0010:__list_del_entry_valid_or_report.cold+0x70/0x72
> [27177.600088][T2585409] Code: fa ff 0f 0b 4c 89 e2 48 89 de 48 c7 c7 c0
> 8c 3b 93 e8 ab 8e fa ff 0f 0b 4c 89 e1 48 89 de 48 c7 c7 00 8e 3b 93 e8
> 97 8e fa ff <0f> 0b 48 63 d1 4c 89 f6 48 c7 c7 e0 56 67 94 89 4c 24 04
> e8 ff f2
> [27177.624173][T2585409] RSP: 0018:ff11000377e87a70 EFLAGS: 00010286
> [27177.633052][T2585409] RAX: 000000000000006d RBX: ff11000344b119c0 RCX:0000000000000000
> [27177.644059][T2585409] RDX: 000000000000006d RSI: 0000000000000008 RDI:ffe21c006efd0f40
> [27177.655030][T2585409] RBP: ff110002e0509f78 R08: 0000000000000001 R09:ffe21c006efd0f08
> [27177.665992][T2585409] R10: ff11000377e87847 R11: 0000000000000000 R12:ff110002390cd9c0
> [27177.676964][T2585409] R13: ff11000344b119c0 R14: ff110002e0508000 R15:dffffc0000000000
> [27177.687938][T2585409] FS:  0000000000000000(0000) GS:ff11000fec880000(0000) knlGS:0000000000000000
> [27177.700006][T2585409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [27177.709431][T2585409] CR2: 00007f06bc7b1978 CR3: 0000001021e86005 CR4:0000000000771ef0
> [27177.720402][T2585409] DR0: 0000000000000000 DR1: 0000000000000000 DR2:0000000000000000
> [27177.731337][T2585409] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:0000000000000400
> [27177.742252][T2585409] PKRU: 55555554
> [27177.748207][T2585409] Call Trace:
> [27177.753850][T2585409]  <TASK>
> [27177.759103][T2585409]  ? __die_body.cold+0x19/0x27
> [27177.766405][T2585409]  ? die+0x2e/0x50
> [27177.772498][T2585409]  ? do_trap+0x1ea/0x2d0
> [27177.779139][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
> [27177.788518][T2585409]  ? do_error_trap+0xa3/0x160
> [27177.795649][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
> [27177.805045][T2585409]  ? handle_invalid_op+0x2c/0x40
> [27177.812022][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
> [27177.820947][T2585409]  ? exc_invalid_op+0x2d/0x40
> [27177.827608][T2585409]  ? asm_exc_invalid_op+0x1a/0x20
> [27177.834637][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/0x72
> [27177.843519][T2585409]  btrfs_delete_unused_bgs+0x3d9/0x14c0 [btrfs]
> 
> There is a similar retry_list code in btrfs_delete_unused_bgs(), but it is
> safe, AFAIC. Since the block group was in the unused list, the used bytes
> should be 0 when it was added to the unused list. Then, it checks
> block_group->{used,resereved,pinned} are still 0 under the
> block_group->lock. So, they should be still eligible for the unused list,
> not the reclaim list.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Fixes: 4eb4e85c4f81 ("btrfs: retry block group reclaim without infinite loop")

This commit has landed in several stable trees so we need to get this
fixup out quickly. How hard is to hit the problem? It's caught by list
corruption detection but this is most likely not enabled on distro
kernels so it might go unnoticed.

