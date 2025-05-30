Return-Path: <linux-btrfs+bounces-14309-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B2DAC8CEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD554A78E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845CA225A2D;
	Fri, 30 May 2025 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gIl+Qpw8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j9IWuvFE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0v75Bba";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MxxCv1La"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D61C84A5
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604404; cv=none; b=Vq8kIUcdxvF4fhozmGYcrz3i+EWdRiHL82v8caK9PjvO4YO9+tCmaYjE80U2cDc9QQJzXzw7Bic1sNgjCM6QEdEqMLyMie+KzYjSiA3vLzCiv4rQ+2Q+gu9Gjy540+c5Y0DQmESxLOiO/9wG+6k2N8vlzzihzE6miSwmjV7mn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604404; c=relaxed/simple;
	bh=Y3mel1GHwCaKVgAg1ziMn9TYKGlUkd5wZKBWpcVo+xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1whTErEWzKSVv8c6jUFljqN9GM2Ish/0EhdZD0RN0bIilcXNeupMLN5w5yrqgF5SEJ0TStkO6+iCcJlx5m5TsvKoaaxq6LDiP877KPPuUE76Wb4b2QnUMOx/AjYUYljry6gpvy0g2eVCN1GDk2+iUtrvwoSq3cu1TYSNJfKzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gIl+Qpw8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j9IWuvFE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0v75Bba; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MxxCv1La; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 026A81F8D5;
	Fri, 30 May 2025 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748604400;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dM0IWpbz3HBfaDX3UHJ1Y9gBhVhbv6SRwXpnXMwMJOE=;
	b=gIl+Qpw8WeRagAwtQnKTOGBXmFVinMOhidQZMLp7pgauT3f/BFQ7g37oan2KVng41An6n7
	TzkEFp+1C9kUgypXUFIqfriGFKjKk6NJGhWYRdZO9Cn9r1JJ8ru3V5EOA4ezH4dGTuQxLX
	qEWUsd8r9Iw++38wXu1pHzT6nTZY4ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748604400;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dM0IWpbz3HBfaDX3UHJ1Y9gBhVhbv6SRwXpnXMwMJOE=;
	b=j9IWuvFE9+nVs/+6s46ZDb4HGgHw2/T5wQGboVAaQbPXvzqWw7co6sH71PROy3Q3xqIFL/
	Jj9ow/rNoVJL5NBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v0v75Bba;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MxxCv1La
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748604399;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dM0IWpbz3HBfaDX3UHJ1Y9gBhVhbv6SRwXpnXMwMJOE=;
	b=v0v75Bbaiwihx15mNs3Oy1FaT9UUhcSUH/h6clTEoFDwtfXMjjm05Qpa5St5pC4vyZ3J85
	c3U/aH1f+98bor+sETSH4LiuEi0yzWRqkTe+9LLLCUM8ne68Ns3TgPvNGsl0vdENBjVeGX
	Mn5L69iUePJjTyJTeZG/3tTei/biaxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748604399;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dM0IWpbz3HBfaDX3UHJ1Y9gBhVhbv6SRwXpnXMwMJOE=;
	b=MxxCv1LaLd4S36GxA2/YLtkJiSiCISuuqnYYn5gvPJbvXX6pgLJH3XxO8KKgtkxdULmF92
	5WxiT1l47JHrVuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC3E7132D8;
	Fri, 30 May 2025 11:26:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n+2tMe6VOWjGFAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:26:38 +0000
Date: Fri, 30 May 2025 13:26:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: fsck-tests: fix an image which has
 incorrect super dev item
Message-ID: <20250530112629.GV4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <970338fc51c549878d5499c31634245120686299.1748485114.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970338fc51c549878d5499c31634245120686299.1748485114.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 026A81F8D5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.21

On Thu, May 29, 2025 at 11:48:37AM +0930, Qu Wenruo wrote:
> [CI FAILURE]
> With Mark's incoming fsck enhancement on super block device item, it
> exposed the following fs corruption on an existing image dump:
> 
>   restoring image keyed_data_ref_with_reloc_leaf.img
>   ====== RUN CHECK /home/runner/work/btrfs-progs/btrfs-progs/btrfs check ./keyed_data_ref_with_reloc_leaf.img.restored
>   [1/8] checking log skipped (none written)
>   [2/8] checking root items
>   [3/8] checking extents
>   device 1's bytes_used was 55181312 in tree but 59375616 in superblock
>   ERROR: errors found in extent allocation tree or chunk allocation
>   [4/8] checking free space cache
>   [5/8] checking fs roots
>   [6/8] checking only csums items (without verifying data)
>   [7/8] checking root refs
>   [8/8] checking quota groups skipped (not enabled on this FS)
>   Opening filesystem to check...
>   Checking filesystem on ./keyed_data_ref_with_reloc_leaf.img.restored
>   UUID: ca3568a3-d9d8-4901-b4dd-b180a437a07f
>   found 1175552 bytes used, error(s) found
>   total csum bytes: 512
>   total tree bytes: 651264
>   total fs tree bytes: 606208
>   total extent tree bytes: 16384
>   btree space waste bytes: 291631
>   file data blocks allocated: 67633152
>    referenced 1048576
> 
> [CAUSE]
> The image has the following device item in the super block:
> 
>   dev_item.uuid		5a1c9f96-b581-4fd3-a73a-5cfd789c3c84
>   dev_item.fsid		ca3568a3-d9d8-4901-b4dd-b180a437a07f [match]
>   dev_item.type		0
>   dev_item.total_bytes	67108864
>   dev_item.bytes_used	59375616
> 
> Meanwhile the tree dump shows the following device item in the chunk
> tree:
> 
> 	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 3897 itemsize 98
> 		devid 1 total_bytes 67108864 bytes_used 55181312
> 		io_align 4096 io_width 4096 sector_size 4096 type 0
> 
> The bytes_used value does not match and triggered the fsck failure.
> 
> The root cause of such a mismatch is that, there was a bug in the kernel
> that resulted incorrect byte_used number.
> The kernel bug is fixed by commit: ce7213c70c37 ("Btrfs: fix wrong device
> bytes_used in the super block").
> 
> However that fix doesn't have any fixes tag, thus not automatically
> backported to older stable kernels.
> 
> And the image seems to be created by an older stable kernel, thus
> missing the fix and caused the above mismatch.
> 
> [FIX]
> Re-generate the image with the latest kernel so that the mismatch won't
> happen.
> 
> Furthermore for future updates, here is the needed steps to create the
> image.
> 
> - Modify the kernel btrfs module to commit transaction more frequently
>   The idea is to replace the btrfs_end_transaction_throttle() call
>   inside the while() loop of relocate_block_group().
> 
>   So that every time a tree block is relocated, the fs will be
>   committed.
> 
> - Use the following script to populate the fs with log-writes
>   This requries CONFIG_DM_LOG_WRITES to be enabled.
> 
> ```
> 
> dev_src="/dev/test/scratch1"
> dev_log="/dev/test/log"
> dev="/dev/mapper/log"
> mnt="/mnt/btrfs/"
> table="0 $(blockdev --getsz $dev_src) log-writes $dev_src $dev_log"
> 
> fail()
> {
> 	echo "!!! FAILED !!!"
> 	exit 1
> }
> 
> umount $dev &> /dev/null
> umount $mnt &> /dev/null
> 
> dmsetup create log --table "$table" || fail
> mkfs.btrfs -b 1G -n 4k -f -m single $dev
> mount $dev $mnt
> 
> xfs_io -f -c "pwrite 0 512k" $mnt/src > /dev/null
> sync
> 
> for ((i = 0; i < 128; i++)); do
> 	xfs_io -f -c "reflink $mnt/src $(($i * 4096)) $(($i * 4096)) 4K" $mnt/file1 > /dev/null || fail
> done
> for ((i = 0; i < 128; i++)); do
> 	xfs_io -f -c "pwrite 0 2k" $mnt/inline_$i > /dev/null || fail
> done
> sync
> dmsetup message log 0 mark init
> btrfs balance start -m $mnt
> umount $mnt
> dmsetup remove log
> ```
> 
> - Replay the log and run "btrfs dump-tree -t extent" for each fua
>   And there will be one with the following contents for the data extent
>   item, with mixed keyed and shared backref.
> 
>           item 22 key (13631488 EXTENT_ITEM 524288) itemoff 3161 itemsize 108
>                 refs 180 gen 9 flags DATA
>                 (178 0xdfb591fbbf5f519) extent data backref root FS_TREE objectid 258 offset 0 count 77
>                 (178 0xdfb591fa80d95ea) extent data backref root FS_TREE objectid 257 offset 0 count 1
>                 (184 0x151e000) shared data backref parent 22142976 count 51
>                 (184 0x512000) shared data backref parent 5316608 count 51
> 
> - Take the image of that fs
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thank you for recreating the image and noting the steps.

