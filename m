Return-Path: <linux-btrfs+bounces-3018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84D8723E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D049FB2637C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33445128801;
	Tue,  5 Mar 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f4uNRUMu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jXDS3lvp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZxrQ5eH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JrcIaYQQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC432128377
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655152; cv=none; b=TC4/A0t9lcQ9eZqjrASs1na6iUWIKa570zQyoSX9YBg7hoHo3qQvK5fu98+R0mae5amfwr2JMm9q5/kmpv968AMPeLetw0zwdmkJVa8kujN/Fd+UuptR973PZqj4IqgvSoJJhIr+qOcRtNzQB7BAmCsYU7T9ZNDR/BthwxrE1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655152; c=relaxed/simple;
	bh=4vzj1E/32sv1RJ8S1qnFwoO999HquMcfGFJOXqOlBig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKtlh+a3DmRcQldnLpj6dU4LqZdyrAHCuEAD4J4Nngm6iyJskpYC1XBXyncvJmwQJrZHGL4Vw3oz8FjRDfSucFUSo1fBJYiDLF6aZhPzoVgxDblucPFP1lUkd4zpDLBS8ud+/9fwTtrOm7MzDw/muRoIXmhOrfkxqsGfX5E7wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f4uNRUMu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jXDS3lvp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZxrQ5eH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JrcIaYQQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D755E410C;
	Tue,  5 Mar 2024 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709655149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtBTEfLKN3dh0fsfjGj5abxm53n838/ZKVMJZqfS52Y=;
	b=f4uNRUMumyJCLINkwW7K4NLWicnzFtbWgm7CrewYFl77EfuDcB6jywc13BiPjpsbXLFD0o
	J0S6kp5MTjNSfBttf7SLoF+F7sDol9ANfkAjsrDJT8yB4mNJ8EvPRi65LVEv5+zlegcoFC
	TErWo7t7nNVW+yr2ZrHrD7+LJP+r7uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709655149;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtBTEfLKN3dh0fsfjGj5abxm53n838/ZKVMJZqfS52Y=;
	b=jXDS3lvpL0RzIyd0MX11Srx30TVGz7fELX0Vt7D7CaJe6CMIZBTN4udJ4gypwfWtT2ksRZ
	voAMsTSpMe3McBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709655148;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtBTEfLKN3dh0fsfjGj5abxm53n838/ZKVMJZqfS52Y=;
	b=NZxrQ5eH72RxObHbraxcGQX/uEDln9+sVDJt7UjmNQA1VbqDY4/4PYP1kgcSJgC4TqbKB9
	H2c3gnew3SLE4DN4nyJWJzUZqls+qI5/FcSbWhajVpq4tC+J1hMYfQK1gSdlnWffSvJCib
	HI8juEwwPZ9porrifWhzjXi2W080mvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709655148;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VtBTEfLKN3dh0fsfjGj5abxm53n838/ZKVMJZqfS52Y=;
	b=JrcIaYQQe/8PaEINuI4Fv6SWkWiLNya7NY1G1b/qNQhO+YuB911Lb44P+5HL8BKmB0RYg/
	3qqSkvG/B67U5qCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE1C413A5D;
	Tue,  5 Mar 2024 16:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id n35CLmxE52X/YAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 05 Mar 2024 16:12:28 +0000
Date: Tue, 5 Mar 2024 17:05:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: fix memory leak in btrfs_read_folio
Message-ID: <20240305160522.GQ2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.17
X-Spamd-Result: default: False [-1.17 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.993];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.18)[70.10%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue, Mar 05, 2024 at 09:53:35AM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> A recent fstests run with enabled kmemleak revealed the following splat:
> 
>   unreferenced object 0xffff88810276bf80 (size 128):
>     comm "fssum", pid 2428, jiffies 4294909974
>     hex dump (first 32 bytes):
>       80 bf 76 02 81 88 ff ff 00 00 00 00 00 00 00 00  ..v.............
>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     backtrace (crc 1d0b936a):
>       [<000000000fe42cf8>] kmem_cache_alloc+0x196/0x310
>       [<00000000adb72ffd>] alloc_extent_map+0x15/0x40
>       [<000000008d9259d5>] btrfs_get_extent+0xa3/0x8e0
>       [<0000000015a05e9a>] btrfs_do_readpage+0x1a5/0x730
>       [<0000000060fddacb>] btrfs_read_folio+0x77/0x90
>       [<00000000509dda36>] filemap_read_folio+0x24/0x1e0
>       [<00000000dee3c1b4>] do_read_cache_folio+0x79/0x2c0
>       [<00000000bf294762>] read_cache_page+0x14/0x40
>       [<0000000048653172>] page_get_link+0x25/0xe0
>       [<0000000094b5d096>] vfs_readlink+0x86/0xf0
>       [<00000000698ab966>] do_readlinkat+0x97/0xf0
>       [<00000000a55a2b4c>] __x64_sys_readlink+0x19/0x20
>       [<000000006e1b608e>] do_syscall_64+0x77/0x150
>       [<000000008fcc6e49>] entry_SYSCALL_64_afer_hwframe+0x6e/0x76
> 
> This leaked object is the 'em_cached' extent map, which will not be freed
> when btrfs_read_folio() finishes if it is set.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

As Filipe noted it's from my patch "btrfs: pass a valid extent map cache
pointer to __get_extent_map()", I'd rather fold the fix than to add the
fixup commit.

