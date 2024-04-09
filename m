Return-Path: <linux-btrfs+bounces-4067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE7C89DE13
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E84293DA9
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597FC129A7B;
	Tue,  9 Apr 2024 15:04:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79813B29F
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675089; cv=none; b=FH5/JJW1EEDbHGcd8Qqu8q55+455F3qCQH8NzdIHwAF0to2mg6oqLB/A4EAFBWA/GyBnwMUFoO4EINFu8Rx9Vjim3bjIzAmVvNN7CqukpHrWeR4PMg2DVLNdxe8U/S9dS9q4QCTfgW2HlTQtcVScV9XIWU3zAs1cEKMyiFoxpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675089; c=relaxed/simple;
	bh=4m8YhrLPBE8B1D/zQc4opcIwxVVsT32DBgvnve+506w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NErQvwr+yl8qsYZ9hA4E5UHn0XtSglQuO4ZoGP6KMciIbcWJ5nq64FiJHJCVz7EgdH99oso8g41bZsvFoaKRYZHmQhITRfA8e5vS190vokWp3Nph4nJprneENq4cHcKRIvSk4QIauY+YS+S4CMlvgKvNcsjmE/hZ70NMzeZFLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA3E233A5A;
	Tue,  9 Apr 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE51813253;
	Tue,  9 Apr 2024 15:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QytPLg1ZFWYEFQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 09 Apr 2024 15:04:45 +0000
Date: Tue, 9 Apr 2024 16:57:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/8] btrfs: extent-map: use disk_bytenr/offset to replace
 block_start/block_len/orig_start
Message-ID: <20240409145720.GG3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1712614770.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1712614770.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DA3E233A5A

On Tue, Apr 09, 2024 at 08:03:39AM +0930, Qu Wenruo wrote:
> [REASON FOR RFC]
> Not all sanity checks are implemented, there is a missing check for
> ram_bytes on non-compressed extent.
> Because even without this series, generic/311 can generate a file extent
> with ram_bytes larger than disk_num_bytes.
> 
> This seems harmless, but I still want to fix it and implement a full
> version of the em sanity check.
> 
> [REPO]
> https://github.com/adam900710/linux/tree/em_cleanup
> 
> Which relies on previous changes on extent maps.
> 
> This series introduce two new members (disk_bytenr/offset) to
> extent_map, and removes three old members
> (block_start/block_len/offset), finally rename one member
> (orig_block_len -> disk_num_bytes).
> 
> This should save us one u64 for extent_map.
> 
> But to make things safe to migrate, I introduce extra sanity checks for
> extent_map, and do cross check for both old and new members.
> 
> The extra sanity checks already exposed one bug (thankfully harmless)
> causing em::block_start to be incorrect.
> 
> There is another bug related to bad btrfs_file_extent_item::ram_bytes,
> which can be larger than disk_num_bytes for non-compressed file extents.
> (Generated by generic/311 test case, but it seems to be created on-disk
>  first)
> 
> But so far, the patchset is fine for default fstests run.

I've only paged through the patches, besides the renames there are so
many changes where it's hard to spot a subtle bug, but overall it looks
ok.

