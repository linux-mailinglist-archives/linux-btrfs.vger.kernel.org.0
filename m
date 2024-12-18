Return-Path: <linux-btrfs+bounces-10580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325FB9F6D5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 19:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A509188C845
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896EF1F63EE;
	Wed, 18 Dec 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xv0i92H8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8h4fE0h8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xv0i92H8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8h4fE0h8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6511155333
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546720; cv=none; b=IFHnnc3zMjlVkMgeKtTwMHmSHeWjj0/OxiehzfKYosqHZjZBeNieG/K2w1uhdxwolw7CP51O1pFWCtR5OkDa5CALZtWb/hxfnigq6GuXw+e2brAMQMFeq52JkJIRfjN3GkwlKh6J9fuddy26ovc6k7OCGorwyQl6c4IsiGeH36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546720; c=relaxed/simple;
	bh=NkfSKq/pGzkqd5dj4OhDNeawXh5DB9Sp1GYhzlTzYyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6sIZkky1rbBmqav2JqoOx6Ds59Xi9M6fvkyMhUqqLFbh98dmKLHv+WIuZQP+fx0pk5DBvagUab6edLpUimnWqRbrlv6jpMzG4Q5yMnXaBhmdsOlhDBF4eMQS2avkpbPEPyFXrTyn9R2/7n9kdusbWRCWo5pJWD6UcYCzt1F9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xv0i92H8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8h4fE0h8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xv0i92H8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8h4fE0h8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E43F31F396;
	Wed, 18 Dec 2024 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734546716;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TdJP0Bd2ksKvDCxxm055OgyVxm8TpASPlXh4YRfk3v0=;
	b=Xv0i92H8BTaM36RyqMpnL251H3N50rbA9PzMJIIDVJnwVmz9xivToQebEppwI14Cg8RGS7
	o1qLib6+ptjp8SbApD3goSdyvNG/DV0PKvA7Iar7gLpFwFp9YWEe4nzHL+2gR+TNt9iiyg
	/Q3jwgFARBWy0ocbKUvCyRJKo0YD64E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734546716;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TdJP0Bd2ksKvDCxxm055OgyVxm8TpASPlXh4YRfk3v0=;
	b=8h4fE0h8jgvsvuDj7sYgoKTZGzsu7B2JLxqkbun1W26yc+ulXmZEt2ljXoxGJJhEnunuhn
	gVi4rgFy77ng74Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734546716;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TdJP0Bd2ksKvDCxxm055OgyVxm8TpASPlXh4YRfk3v0=;
	b=Xv0i92H8BTaM36RyqMpnL251H3N50rbA9PzMJIIDVJnwVmz9xivToQebEppwI14Cg8RGS7
	o1qLib6+ptjp8SbApD3goSdyvNG/DV0PKvA7Iar7gLpFwFp9YWEe4nzHL+2gR+TNt9iiyg
	/Q3jwgFARBWy0ocbKUvCyRJKo0YD64E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734546716;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TdJP0Bd2ksKvDCxxm055OgyVxm8TpASPlXh4YRfk3v0=;
	b=8h4fE0h8jgvsvuDj7sYgoKTZGzsu7B2JLxqkbun1W26yc+ulXmZEt2ljXoxGJJhEnunuhn
	gVi4rgFy77ng74Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3384137CF;
	Wed, 18 Dec 2024 18:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iPJrLxwVY2f/bQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 18 Dec 2024 18:31:56 +0000
Date: Wed, 18 Dec 2024 19:31:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/18] btrfs: migrate to "block size" to describe the
Message-ID: <20241218183155.GE31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Dec 18, 2024 at 08:11:16PM +1030, Qu Wenruo wrote:
> [IMPEMENTATION]
> To reduce the confusion, this patchset will do such a huge migration in
> different steps:

With some many changes everywhere this is going to make backports even
more tedious. I think it would be best to do the conversion gradually or
selectively to code that does not change so often. As you've split it to
files we can first pick a few obvious ones (like file-item.c) or gather
stats from stable.git.

A quick and rough estimate for all 6.x.y releases counting file
backports in the individual patches in the list below. This is period of
2 years, 104 weeks (roughly matching number of releases). So if there
are 88 patches touching inode.c that's quite likely a conflict in every
backport.

This should be also correlated agains number of 'sectorsize' per file,
so it many not be that bad, for example in ioctl.c there are only 4
occurences so that's fine. The point is we can't do the renames without
some sensibility and respect to backports.

     88 inode.c
     62 disk-io.c
     61 volumes.c
     57 extent_io.c
     57 block-group.c
     56 ioctl.c
     52 extent-tree.c
     49 zoned.c
     49 qgroup.c
     37 send.c
     36 super.c
     33 ctree.c
     30 transaction.c
     29 file.c
     28 tree-log.c
     28 free-space-cache.c
     26 scrub.c
     24 ctree.h
     22 relocation.c
     19 delayed-inode.c
     17 tree-checker.c
     17 backref.c
     15 space-info.c
     14 extent_map.c
     12 free-space-tree.c
     12 disk-io.h
     11 block-group.h
     11 bio.c
     10 ordered-data.c
     10 block-rsv.c
      9 ref-verify.c
      9 file-item.c
      9 btrfs_inode.h
      8 include/uapi/linux/btrfs.h
      8 fs.h
      8 delayed-ref.c
      8 delalloc-space.c
      7 root-tree.c
      7 print-tree.c
      7 dir-item.c
      7 dev-replace.c
      7 block-rsv.h
      6 sysfs.c
      6 extent_io.h
      6 defrag.c
      6 compression.c
      5 volumes.h
      5 transaction.h
      5 qgroup.h
      5 export.c
      4 zoned.h
      4 space-info.h
      4 reflink.c
      4 inode-item.c
      4 include/trace/events/btrfs.h
      4 discard.c
      4 delayed-ref.h
      3 tree-log.h
      3 tree-defrag.c
      3 subpage.c
      3 raid56.c
      3 free-space-tree.h
      3 extent-io-tree.c
      3 extent-io-tests.c
      3 backref.h
      2 zlib.c
      2 xattr.c
      2 uuid-tree.c
      2 tree-mod-log.c
      2 tests/inode-tests.c
      2 tests/extent-map-tests.c
      2 tests/extent-buffer-tests.c
      2 root-tree.h
      2 relocation.h
      2 rcu-string.h
      2 qgroup-tests.c
      2 lzo.c
      2 locking.c
      2 inode-item.h
      2 free-space-cache.h
      2 extent-tree.h
      2 delayed-inode.h
      1 tree-checker.h
      1 tests/free-space-tree-tests.c
      1 sysfs.h
      1 props.c
      1 ordered-data.h
      1 messages.h
      1 messages.c
      1 include/uapi/linux/btrfs_tree.h
      1 fs.c
      1 file-item.h
      1 extent_map.h
      1 export.h
      1 compression.h
      1 btrfs-tests.c
      1 btrfs.h
      1 bio.h

