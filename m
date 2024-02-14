Return-Path: <linux-btrfs+bounces-2378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD350854411
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 09:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287BE1F22746
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD76FAD;
	Wed, 14 Feb 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mXjdhDwn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roYrC20V";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mXjdhDwn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="roYrC20V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DF5CBD
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899546; cv=none; b=UB7igVw2PaJe8sIPV9t+O6YWgPVu3X5HoWsbm+CpJAV8DGgxy3apTsKpHbhpxNv+gEngd/RT2Jt5UAjFM6QFn8RYleKOcL8rNcOXQag+YWMv2nwgHKrpRkQGOC3b2+DQmmxyGrRGhkziGYoWXRjUSgQG+9hQRF63cuq6FFMKdOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899546; c=relaxed/simple;
	bh=yl8U+0T75EVWYZiYujtYE5Un/3oozV82VpMOdH5VdEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CumKFQUtbHgMbdRja76lRUdQvMamVfztks+NHOiMGURn6Kw1Z7jWci9bmAhenKsud4HkAsRNADKAwriSmySms17pOMHev2pYAe7TtFdRe3O0cBbW4xsBmQQp7KaE8m13uL3ao9we65Go/mTYiOhtaWmokQFIgfWTl4knTFwEY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mXjdhDwn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=roYrC20V; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mXjdhDwn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=roYrC20V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 038801F7E4;
	Wed, 14 Feb 2024 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707899543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+UjBQqkYexEiUxiamG/5MgaW7ddPMpPjRma+S4CEMo=;
	b=mXjdhDwnPZ9iLb2wkMm1lh60R0ENSMQwg7iHHiW9+BHBG1Ot+iNC4CQZ28hBE0s+Xieq0O
	Z3jwdxS5Rmal9j6fm56wpu7cbpSOTjdmk8c3pVWYr9TZCMOKHausuTEnFxyGLyJtFU+XQ7
	SX9gqCrH5OQqPL0rGfjwdsFeOmvlgTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707899543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+UjBQqkYexEiUxiamG/5MgaW7ddPMpPjRma+S4CEMo=;
	b=roYrC20VMav83srPa16iZYEYCzORZP9AWSvegwKPDs0EpUek/G0If2mEf/4YmtBtS6FAlp
	A4AbYJobRs7qvvAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707899543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+UjBQqkYexEiUxiamG/5MgaW7ddPMpPjRma+S4CEMo=;
	b=mXjdhDwnPZ9iLb2wkMm1lh60R0ENSMQwg7iHHiW9+BHBG1Ot+iNC4CQZ28hBE0s+Xieq0O
	Z3jwdxS5Rmal9j6fm56wpu7cbpSOTjdmk8c3pVWYr9TZCMOKHausuTEnFxyGLyJtFU+XQ7
	SX9gqCrH5OQqPL0rGfjwdsFeOmvlgTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707899543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+UjBQqkYexEiUxiamG/5MgaW7ddPMpPjRma+S4CEMo=;
	b=roYrC20VMav83srPa16iZYEYCzORZP9AWSvegwKPDs0EpUek/G0If2mEf/4YmtBtS6FAlp
	A4AbYJobRs7qvvAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DC14013A0B;
	Wed, 14 Feb 2024 08:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id toGGNZZ6zGWjOgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 14 Feb 2024 08:32:22 +0000
Date: Wed, 14 Feb 2024 09:31:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [bug report] kmemleak observed during blktests nbd/009
Message-ID: <20240214083149.GP355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAHj4cs_UXGQMwNHgbhw12qDHq_B44bUwiNGkN4unzxc8XqfkdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_UXGQMwNHgbhw12qDHq_B44bUwiNGkN4unzxc8XqfkdQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
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
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[11.38%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Wed, Feb 14, 2024 at 04:14:32PM +0800, Yi Zhang wrote:
> Hi
> 
> I found below kmemleak during blktests nbd/009 on 6.8.0-rc3+, please
> help check it and let me know if you need any info/testing for it,
> thanks.
> 
> [17763.119952] kmemleak: 12 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> 
> # ./check zbd/009
> zbd/009 (test gap zone support with BTRFS)                   [passed]
>     runtime  18.716s  ...  18.763s
> # btrfs --version
> btrfs-progs v6.7
> 
> unreferenced object 0xffff8881511c53b0 (size 192):
>   comm "mount", pid 52857, jiffies 4311808306
>   hex dump (first 32 bytes):
>     b0 53 1c 51 81 88 ff ff 00 40 1c 51 81 88 ff ff  .S.Q.....@.Q....
>     00 00 00 00 00 00 00 00 02 00 00 00 01 00 00 00  ................
>   backtrace (crc dcabc4f4):
>     [<0000000097edeb04>] __kmalloc+0x3e7/0x520
>     [<00000000288772fe>] btrfs_alloc_chunk_map.constprop.0+0x20/0xa0
>     [<0000000031efcd2f>] read_one_chunk+0x284/0xb80
>     [<00000000e2b85033>] btrfs_read_sys_array+0x24c/0x3d0
>     [<0000000003714897>] open_ctree+0x1b0b/0x4be0
>     [<000000001f5e8ac7>] btrfs_get_tree+0x101f/0x19d0
>     [<0000000088ba3feb>] vfs_get_tree+0x8d/0x350
>     [<000000001f72c23c>] fc_mount+0x13/0x90
>     [<00000000c75588a6>] btrfs_get_tree+0x91d/0x19d0
>     [<0000000088ba3feb>] vfs_get_tree+0x8d/0x350
>     [<00000000706df581>] vfs_cmd_create+0xe1/0x290
>     [<000000004d6ccd48>] __do_sys_fsconfig+0x607/0xa90
>     [<00000000c1740ec7>] do_syscall_64+0x9e/0x190
>     [<0000000014a2c6d4>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

Thanks for the report, fixed by
https://lore.kernel.org/linux-btrfs/0bdc61c9216d238eaa4abb6edfb1c5d9c8e86c52.1707775003.git.fdmanana@suse.com/

