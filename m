Return-Path: <linux-btrfs+bounces-13468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9EA9F411
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DDE464348
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7467279794;
	Mon, 28 Apr 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gsdyluqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bcn7cmqV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YgSrgeLY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6myG4MaH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F54E22D79F
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852692; cv=none; b=HwqEQ5umXoJxI4rbD1Sw4X/w+g8kuPgaIwbHKz7E05cYh3hlkf/ixeKAhhCUHTAT0eFEdUWPMgJzb6n5ELP6UNAf+GNXIcEfQZ8KEZkSVEUsDbqcP8akv2WQ/7Eq91GNIQMFjwBbHSjThQpOUBx2mCEv+9afQA4KCPX2y4h+tYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852692; c=relaxed/simple;
	bh=QfglUSUpuTw5eqZ3nvjBWd+fn9GS39Z3hDpR6T79JDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaJ2wTb+ZgFuIzdeWQFTVwPXziUatepSjkX9WDqq6/fujU/FFLBya/b0r+2VMRC8xqgNH+SrIZ1BQar6fvNpYuPvhFlGEV9QVj9hWemyJClKIg6xri6CvpcFjasjfXG0PrbHzacOEohyTxglBA1cBA6uGu3cXUj4c+k9QfIO8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gsdyluqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bcn7cmqV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YgSrgeLY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6myG4MaH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 969B5211F3;
	Mon, 28 Apr 2025 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745852688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sAnPEiUzntCIqYuedHPrxLs9vMpZvZ9Jq+EimkcGDk=;
	b=GsdyluqyPPF6nQ3/yJOyRKHLLpCdCULGeszl7qx8aI680/R+0OiY3Y3Y0/1XbhmGtt21AX
	SZOvEVMmpq3tIJ9uDNpEBAbFICK3OwLFzAXujJ6/Xnc/6YCwJvswvqDUGOLPv73CBwPuPY
	EkUsCoJkoVajsJnqPVzRVVpgX/8is84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745852688;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sAnPEiUzntCIqYuedHPrxLs9vMpZvZ9Jq+EimkcGDk=;
	b=bcn7cmqVoKOoQ5KiVSQ7OVHrKNrl3PtJSgRoCKKcBhFmuIA3Fb7d1MjkXKusCZNNaMyeKu
	zXqzGZ44606SKCDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745852687;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sAnPEiUzntCIqYuedHPrxLs9vMpZvZ9Jq+EimkcGDk=;
	b=YgSrgeLYIr909xNvNaaxlhdenSLkIsnbz13o3xDokVL0JrBkUk9R2ptTjHzI5Sol7JXM//
	Tjh7IuvHT75UTjG3768dUNWVw64Ci5Z9yXNqXKkBB5OjYQXzVSYHPyqcOlmCg1qQBRnals
	4Zzi7kLNVJtAE7y0hsDb0ebEy8y2UGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745852687;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/sAnPEiUzntCIqYuedHPrxLs9vMpZvZ9Jq+EimkcGDk=;
	b=6myG4MaHJ+RteryAPdkhPUUgFcXg8d2cLoDxtfKtdrxdmnJGvoWq5dfvTWhYIf2HKxZahz
	8pGGSzAQcraDxZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75D5313A25;
	Mon, 28 Apr 2025 15:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mrSBHA+ZD2igAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 28 Apr 2025 15:04:47 +0000
Date: Mon, 28 Apr 2025 17:04:46 +0200
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: correct the order of prelim_ref arguments in
 btrfs__prelim_ref
Message-ID: <20250428150446.GD7139@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <xkizy4mfcknvikvddixci24oplxxnmu2enwx6sbxqqa4czrzzy@omjt5fi4rmym>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xkizy4mfcknvikvddixci24oplxxnmu2enwx6sbxqqa4czrzzy@omjt5fi4rmym>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Fri, Apr 25, 2025 at 09:25:06AM -0400, Goldwyn Rodrigues wrote:
> btrfs_prelim_ref() calls the old and new reference variables in the
> incorrect order. This causes a NULL pointer dereference because oldref
> is passed as NULL to trace_btrfs_prelim_ref_insert(). 
> 
> Note, trace_btrfs_prelim_ref_insert() is being called with newref as
> oldref (and oldref as NULL) on purpose in order to print out
> the values of newref.
> 
> To reproduce:
> echo 1 > /sys/kernel/debug/tracing/events/btrfs/btrfs_prelim_ref_insert/enable
> 
> Perform some writeback operations.
> 
> Backtrace:
> BUG: kernel NULL pointer dereference, address: 0000000000000018
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 115949067 P4D 115949067 PUD 11594a067 PMD 0 
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 1 UID: 0 PID: 1188 Comm: fsstress Not tainted 6.15.0-rc2-tester+ #47 PREEMPT(voluntary)  7ca2cef72d5e9c600f0c7718adb6462de8149622
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:trace_event_raw_event_btrfs__prelim_ref+0x72/0x130
>  Code: e8 43 81 9f ff 48 85 c0 74 78 4d 85 e4 0f 84 8f 00 00 00 49 8b 94 24 c0 06 00 00 48 8b 0a 48 89 48 08 48 8b 52 08 48 89 50 10 <49> 8b 55 18 48 89 50 18 49 8b 55 20 48 89 50 20 41 0f b6 55 28 88
>  RSP: 0018:ffffce44820077a0 EFLAGS: 00010286
>  RAX: ffff8c6b403f9014 RBX: ffff8c6b55825730 RCX: 304994edf9cf506b
>  RDX: d8b11eb7f0fdb699 RSI: ffff8c6b403f9010 RDI: ffff8c6b403f9010
>  RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000010
>  R10: 00000000ffffffff R11: 0000000000000000 R12: ffff8c6b4e8fb000
>  R13: 0000000000000000 R14: ffffce44820077a8 R15: ffff8c6b4abd1540
>  FS:  00007f4dc6813740(0000) GS:ffff8c6c1d378000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000018 CR3: 000000010eb42000 CR4: 0000000000750ef0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   prelim_ref_insert+0x1c1/0x270
>   find_parent_nodes+0x12a6/0x1ee0
>   ? __entry_text_end+0x101f06/0x101f09
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   ? srso_alias_return_thunk+0x5/0xfbef5
>   btrfs_is_data_extent_shared+0x167/0x640
>   ? fiemap_process_hole+0xd0/0x2c0
>   extent_fiemap+0xa5c/0xbc0
>   ? __entry_text_end+0x101f05/0x101f09
>   btrfs_fiemap+0x7e/0xd0
>   do_vfs_ioctl+0x425/0x9d0
>   __x64_sys_ioctl+0x75/0xc0
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

