Return-Path: <linux-btrfs+bounces-10782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA20A0441E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 16:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B7D164CF9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0A61F2C4B;
	Tue,  7 Jan 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y3xOCa9o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fkUvfvyJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hw2XaXUo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bzsjb1q9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2AC86321;
	Tue,  7 Jan 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263249; cv=none; b=YAwqctE7zqWYKPa36uYgmwTaWikkaH4m19cH2E2LxlK7tcf+rSDY9mo/Y1MfJBN+q590/jPRJ6QevYTMQCoEcSSQzRbuaaoUfYBtkkXXzLmRV+ig3S8U39jyMAHo5VHxlEa6Vb/wZkEmfOQ4wp/CKRSZa3a88tw+yZzbV4E7bAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263249; c=relaxed/simple;
	bh=TllIWPgHHbDO0Vi8ZkoqWkf1LoFBXJFp1swdjsWWgS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfqI/aJTMVaEFlBJqEKju51ExeM0I+7R5gY+snoirRcK7EKvoS1jIhXzCmKTxDxU82Y5DF2vazH5zonj6Mm9ZgfHm8+5MKhK9n3frThJs0i4XSjDTdy9/hWmgFJqr4dvreq7V4H70l4AZtKb3fUr3CbeIBTXyERPleuWULzWTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y3xOCa9o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fkUvfvyJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hw2XaXUo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bzsjb1q9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05B851F385;
	Tue,  7 Jan 2025 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736263246;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbVmmOqueNoNtJVw3Sa0y53Jr3H5fM+JOo9oY6wHO+k=;
	b=Y3xOCa9orEqiVTIBvLBdYOV3bre7IglC0Tx2HNDK3Wmpwf7/fQ83tYnEzJy/2oCVG5qcWb
	0byJCsJhuwNfKrp/UveovVYKT8e2uE2PoFmGz/qRW+nsOqc+iQvw43JAJAf7DDjPxRIQL3
	ehTog6BDgJh8xIpYVouPBe/yuooZA6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736263246;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbVmmOqueNoNtJVw3Sa0y53Jr3H5fM+JOo9oY6wHO+k=;
	b=fkUvfvyJzxXYjAj093UWhAJFrVbydsobPao+J9uESVTobb9HkOYNjB+rSGvNFrejASYmG+
	QeQykLNdugLIb/AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736263245;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbVmmOqueNoNtJVw3Sa0y53Jr3H5fM+JOo9oY6wHO+k=;
	b=Hw2XaXUoz9WLEdsbZZK5ThGWi+ijhwYnlx6y3Jmbr/ytf9Hc/WD+Wv+YRmONg2MIIWXzTE
	L39wD63v5pSeSi48qAIZyI8+Qlk6pKPjrZiZupXe1f876QC9tjm+o7JNcfRzZWEwjmgWXg
	2W5BcSiUHWqC/on8Uli5XKHRwfwolk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736263245;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WbVmmOqueNoNtJVw3Sa0y53Jr3H5fM+JOo9oY6wHO+k=;
	b=bzsjb1q9XaNXN0NBoi7MGmeNxOZl7ejBnt7F3Sn86B7oZ6HheGj4etBFevt6kJufdsBqbH
	eNa6AwjZvK7uL0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D71A213A6A;
	Tue,  7 Jan 2025 15:20:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sGE+NExGfWeoSAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 07 Jan 2025 15:20:44 +0000
Date: Tue, 7 Jan 2025 16:20:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 00/14] btrfs: more RST delete fixes
Message-ID: <20250107152035.GG31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Jan 07, 2025 at 01:47:30PM +0100, Johannes Thumshirn wrote:
> Here's another set of fixes for the delete path on RAID stripe-tree backed
> filesystems.
> 
> Josef's CI system started tripping over a bad key order due to the usage
> of btrfs_set_item_key_safe() in btrfs_partially_delete_raid_extent() and
> while investigating what is happening there I found more bugs and not
> handled corner cases, which resulted in more fixes and test-cases.
> 
> Unfortunately I couldn't fix the bad key order problem and had to resort
> to re-creating the item in btrfs_partially_delete_raid_extent() and insert
> the new one after deleting the old.
> 
> Fstests btrfs/06* are extremely good in exhibiting these failures and
> btrfs/060 has been extensively run while developing this series.
> 
> A full CI run of v1 can be found here:
> https://github.com/btrfs/linux/actions/runs/12291668397
> 
> Changes to v1:
> - Handle extent_map lookup failure in 1/14
> - Don't use key.offset = -1 for initial search in 3/14
> - Don't break before calling btrfs_previous_item if we're on slot 0 in
>   6/14
> - Remove btrfs_mark_buffer_dirty calls
> - Remove line breaks at 80 chars if we're just a bit over
> - Fix multiple issues on comment styling
> 
> Link to v1:
> https://lore.kernel.org/linux-btrfs/cover.1733989299.git.jth@kernel.org
> 
> Note:
> I did not copy the implementation of btrfs_drop_extents() as I'd like to
> have feedback on this variant first, before putting the time and energy in
> a "completely new" implementation.
> 
> ---
> Johannes Thumshirn (14):
>       btrfs: don't try to delete RAID stripe-extents if we don't need to
>       btrfs: assert RAID stripe-extent length is always greater than 0
>       btrfs: fix search when deleting a RAID stripe-extent
>       btrfs: fix front delete range calculation for RAID stripe extents
>       btrfs: fix tail delete of RAID stripe-extents
>       btrfs: fix deletion of a range spanning parts two RAID stripe extents
>       btrfs: implement hole punching for RAID stripe extents
>       btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents
>       btrfs: selftests: check for correct return value of failed lookup
>       btrfs: selftests: don't split RAID extents in half
>       btrfs: selftests: test RAID stripe-tree deletion spanning two items
>       btrfs: selftests: add selftest for punching holes into the RAID stripe extents
>       btrfs: selftests: add test for punching a hole into 3 RAID stripe-extents
>       btrfs: selftests: add a selftest for deleting two out of three extents
> 
>  fs/btrfs/ctree.c                        |   1 +
>  fs/btrfs/raid-stripe-tree.c             | 146 ++++++-
>  fs/btrfs/tests/raid-stripe-tree-tests.c | 660 +++++++++++++++++++++++++++++++-
>  3 files changed, 776 insertions(+), 31 deletions(-)

As this is completely in RST I'm considering it safe for late merge
(ideally by the end of this week before rc7 is out).

