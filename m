Return-Path: <linux-btrfs+bounces-2322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18DB8511F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 12:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF91C21BF6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C038DE3;
	Mon, 12 Feb 2024 11:15:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD717752;
	Mon, 12 Feb 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736525; cv=none; b=ZI0HIwa+BnddKOhRvHpUNiu5+mcBt6Pbtey32LoCHpPFwM+V7d7kojJiheHBqREk7VhKjdThCMwTLSV9hevKCueKCUvPeR33a0PsQ5aEpNOGuB8vJdcogUPLsKBrm7Y4BI7Z6cTQRjRhlACuMazUfNISav2nc0AjWmKEGf3bnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736525; c=relaxed/simple;
	bh=JMpsucFdRskS8XGAMyw49niAtH6NbsYPLDv/RJ0EHQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+1C6mgwtx7j4liXhx5yzHruN1JNVoua9a5TCvf1nDxm+WK1TO04If7jFLYnlY+nAvW6cE4XMuuWjd1+D6Ezw10zhj6RbhQcH//2UAK/KHPMKGVQHA/6h+EuU3alb1xXMt/Emtgw4YlnfsLe7VlURboG3VWQHH3c2MToMeTlUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D86921DED;
	Mon, 12 Feb 2024 11:15:22 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 512CA13212;
	Mon, 12 Feb 2024 11:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tXKXE8r9yWWLFAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 12 Feb 2024 11:15:22 +0000
Date: Mon, 12 Feb 2024 12:14:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, HAN Yuwei <hrx@bupt.moe>,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: reject zoned RW mount if sectorsize is smaller
 than page size
Message-ID: <20240212111450.GZ355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a19a500ccb297397018dac23d30106977153d62.1707714970.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6D86921DED
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Feb 12, 2024 at 03:46:15PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report that with zoned device and sectorsize is smaller
> than page size (aka, subpage), btrfs would crash with a very basic
> workload:
> 
>  # getconfig PAGESIZE
>  16384
>  # mkfs.btrfs -f $dev -s 4k
>  # mount $dev $mnt
>  # $fsstress -w -n 8 -s 1707820327 -v -d $mnt
>  # umount $mnt
> 
> The crash would look like this (with CONFIG_BTRFS_ASSERT enabled):
> 
>  assertion failed: block_start != EXTENT_MAP_HOLE, in fs/btrfs/extent_io.c:1384

This is the same as what Josef fixed in
https://github.com/btrfs/linux/commit/400bb013912dac637c7d6826407be580ea8ef9cc
"btrfs: don't drop extent_map for free space inode on write error"
but not on zoned+subpage, is it really a different error you're fixing?

[...]
> [WORKAROUND]
> A proper fix requires some big changes to delalloc workload, to allow
> extent_write_locked_range() to handle multiple different entries with
> the same @locked_page.
> 
> So for now, disable read-write support for subpage zoned btrfs.
> 
> The problem can only be solved if subpage btrfs can handle subpage
> compression, which need quite some work on the delalloc procedure for
> the @locked_page handling.

Ok, this on itself is a valid reason to disable the support.

