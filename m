Return-Path: <linux-btrfs+bounces-6703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9331E93CAF7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 00:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D181C213D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 22:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E8144D2B;
	Thu, 25 Jul 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfqu4pYs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FGOf8glL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPimp3zt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CV9ZtaYM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B413A40F
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947692; cv=none; b=K8Dtw4jP/EuwLhvZtkDMBGQmvJ8D7dm2MlXOxLxk7bnjj8J1g+MjP6i5Az8F4ebeENTizOHmg1OBSFPic0HUsYGJP1BaYr0SgFySF9kHZgO1Z1Jy/Ld9rtcp1jr5Y7MPhcElgqOwwgIdYG18Cznhs1zokiBhZD/3FPlLHtkKizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947692; c=relaxed/simple;
	bh=poAEBnmJENFSWXPvJ9rpRWiwGxwSj0SzxkotSq9SqBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTfNWvZVj3E3YKrPtKD+3z0ziTv3GsSghDpSAC29mx0e2w5AjDDqTN4f92g8XL+JkSH1+bneKonjZaxWl35w7XksDHpTDcbmC1wo19RP8GT8akCRNXPbaXFrA6vIiaXQli1MDBtLXASpFB8UeJUr188NJZwTetFI+vQhIrB/8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfqu4pYs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FGOf8glL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPimp3zt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CV9ZtaYM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E1BC1F83B;
	Thu, 25 Jul 2024 22:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721947688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtXRX4ZxWfZykmjZUnq6YEqQCibArPEdYA7cC0xuT1c=;
	b=yfqu4pYsxBgKRmSIwRPh5NvjdRxKkHso1Ao8B1I2d6xXbE05nQ33xri4zhJWUWR5c9HSXB
	/D862T82gi/zMYTtQQOFNWeKHLm45GeWbOC9gZiHLfa1SzFUa8W8qtFUCjNpH/OFl6/b1h
	vs1XgdHcOAdQo6FYSID+UIeivz3zPYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721947688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtXRX4ZxWfZykmjZUnq6YEqQCibArPEdYA7cC0xuT1c=;
	b=FGOf8glLrHbneoC1SRHSsdv3wXjEdt0OQ14h2YHSyjwQce4pWY7nbGasmgSCH9O3aHagAy
	7O+6EZdGWASqRdAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721947687;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtXRX4ZxWfZykmjZUnq6YEqQCibArPEdYA7cC0xuT1c=;
	b=DPimp3ztfzkjH5Ejx8R2Pj8vu+GXqJ/u5eM2p0XdWj2f16SCfkIhcsyLs3sGP1eG0+u09m
	vWQzZkXE5qoeYg4pQO80vEXCUZav7N+R1B1ayyqEKRQ9dcU6VTuT9I4ndcvHhJ+CE+BX78
	1akIigN4g2SHvdkQUccX3dyPX4f6DQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721947687;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtXRX4ZxWfZykmjZUnq6YEqQCibArPEdYA7cC0xuT1c=;
	b=CV9ZtaYMpfLqnyDd9DuocdkpWtxo/0/SwqFlMP8034geJITkbghhT4eNm9YDFyh0dl7mCr
	pndwuSti2iR+mcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A05B1368A;
	Thu, 25 Jul 2024 22:48:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6K3kASfWoma0IgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 25 Jul 2024 22:48:07 +0000
Date: Fri, 26 Jul 2024 00:47:57 +0200
From: David Sterba <dsterba@suse.cz>
To: "Emil.s" <emil@sandnabba.se>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Force remove of broken extent/subvolume? (Crash in
 btrfs_run_delayed_refs)
Message-ID: <20240725224757.GD17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu, Jul 25, 2024 at 11:06:00PM +0200, Emil.s wrote:
> Hello!
> 
> I got a corrupt filesystem due to backpointer mismatches:
> ---
> [2/7] checking extents
> data extent[780333588480, 942080] size mismatch, extent item size
> 925696 file item size 942080

This looks like a single bit flip:

>>> bin(925696)
'0b11100010000000000000'
>>> bin(942080)
'0b11100110000000000000'
>>> bin(942080 ^ 925696)
0b100000000000000'

or an off by one error, as the delta is 0x4000, 4x page which is one
node size.

> backpointer mismatch on [780333588480 925696]
> ---
> 
> However only two extents seem to be affected, in a subvolume only used
> for backups.
> 
> Since I've not been able to repair it, I thought that I could just
> delete the subvolume and recreate it.
> But now the btrfs_run_delayed_refs function crashes a while after
> mounting the filesystem. (Which is quite obvious when I think about
> it, since I guess it's trying to reclaim space, hitting the bad extent
> in the process?)
> 
> Anyhow, is it possible to force removal of these extents in any way?
> My understanding is that extents are mapped to a specific subvolume as
> well?
> 
> Here is the full crash dump:
> https://gist.github.com/sandnabba/e3ed7f57e4d32f404355fdf988fcfbff

WARNING: CPU: 3 PID: 199588 at fs/btrfs/extent-tree.c:858 lookup_inline_extent_backref+0x5c3/0x760 [btrfs]

 858         } else if (WARN_ON(ret)) {
 859                 btrfs_print_leaf(path->nodes[0]);
 860                 btrfs_err(fs_info,
 861 "extent item not found for insert, bytenr %llu num_bytes %llu parent %llu root_objectid %llu owner %llu offset %llu",
 862                           bytenr, num_bytes, parent, root_objectid, owner,
 863                           offset);
 864                 ret = -EUCLEAN;
 865                 goto out;
 866         }
 867

CPU: 3 PID: 199588 Comm: btrfs-transacti Tainted: P           OE      6.9.9-arch1-1 #1 a564e80ab10c5cd5584d6e9a0715907a10e33ca4
Hardware name: LENOVO 30B4S01W00/102F, BIOS S00KT73A 05/24/2022
RIP: 0010:lookup_inline_extent_backref+0x5c3/0x760 [btrfs]
RSP: 0018:ffffabb2cd4e3b00 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff992307d5c1c0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff992312c0d590 RDI: ffff99222faff680
RBP: 0000000000000000 R08: 00000000000000bc R09: 0000000000000001
R10: a8000000b5a8c360 R11: 0000000000000000 R12: 000000b5af81a000
R13: ffffabb2cd4e3b57 R14: 00000000000e6000 R15: ffff9927ca7551f8
FS:  0000000000000000(0000) GS:ffff992997980000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000ad404625100 CR3: 000000080ea20002 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 ? __warn.cold+0x8e/0xe8
 ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 ? report_bug+0xff/0x140
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? lookup_inline_extent_backref+0x5c3/0x760 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 ? set_extent_buffer_dirty+0x19/0x170 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 insert_inline_extent_backref+0x82/0x160 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 __btrfs_inc_extent_ref+0x9c/0x220 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 ? __btrfs_run_delayed_refs+0xf64/0xfb0 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 __btrfs_run_delayed_refs+0xaf2/0xfb0 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 btrfs_run_delayed_refs+0x3b/0xd0 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 btrfs_commit_transaction+0x6c/0xc80 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 ? start_transaction+0x22c/0x830 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]
 transaction_kthread+0x159/0x1c0 [btrfs dcbea9ede49f9413c43a944f40925c800621e78e]

followed by leaf dump with items relevant to the numbers:

      item 117 key (780331704320 168 942080) itemoff 11917 itemsize 37
              extent refs 1 gen 2245328 flags 1
              ref#0: shared data backref parent 4455386873856 count 1
      item 118 key (780332646400 168 942080) itemoff 11880 itemsize 37
              extent refs 1 gen 2245328 flags 1
              ref#0: shared data backref parent 4455386873856 count 1
      item 119 key (780333588480 168 925696) itemoff 11827 itemsize 53
                    ^^^^^^^^^^^^^^^^^^^^^^^

              extent refs 1 gen 2245328 flags 1
              ref#0: extent data backref root 2404 objectid 1141024 offset 0 count 1
      item 120 key (780334530560 168 942080) itemoff 11774 itemsize 53
              extent refs 1 gen 2245328 flags 1
              ref#0: extent data backref root 2404 objectid 1141025 offset 0 count 1
      item 121 key (780335472640 168 942080) itemoff 11721 itemsize 53
              extent refs 1 gen 2245328 flags 1
              ref#0: extent data backref root 2404 objectid 1141026 offset 0 count 1

as you can see item 119 is the problematic one and also out of sequence, the
adjacent items have the key offset 942080. Which confirms the bitlip
case.

As for any bitflip induced errors, it's hard to tell how far it got
propagated, this could be the only instance or there could be other
items referring to that one too.

We don't have any ready made tool for fixing that, the bitlips hit
random data structure groups or data, each is basically unique and would
require analysis of tree dump and look for clues how bad it is.

