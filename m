Return-Path: <linux-btrfs+bounces-21248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIq3HjLofGlTPQIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21248-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 18:19:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A1BCF81
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AC22301E7D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jan 2026 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5693590AE;
	Fri, 30 Jan 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2wNirtt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF72F7ACA
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793563; cv=none; b=syVF/9s2xe3lI/FZJvqs1GaIYHc2CpptQ/vZ+GWYCzaeXVvL/r6ZwzY97xgoQaUD5llJev5ZdmRrWHJRLm8DdDkhYQ0YsgEevLQwzTg00n6aBnFPTQG3TK2NB6cMkHdO+M001IHyj+xq3aoB4qxUCWWh+lqsLyPQe8V+z2OZGdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793563; c=relaxed/simple;
	bh=kFPli40Ax/CQVM82pmNJZpwN0Zz1EXPd4v/UFK+9Rl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioAwmXvCYIfDQUAtxv716NyBH9nslKmh4kG4hG1XspKjFAu5OyRR/XAzIMtfZWncWDTV2LKmKYMsL4h2YB7EKkysJlPIufqbpncem+d03UclIsTVJnegoMjliShgOO/WDCBeXPfj/SlLDOPZx6Yiovxl8joXLvE9Fz65mI8yCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2wNirtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01378C4CEF7
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769793563;
	bh=kFPli40Ax/CQVM82pmNJZpwN0Zz1EXPd4v/UFK+9Rl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L2wNirttgai5gNpfe7p24u0+4rNkA8P8cFBLnJOCM3oa8ROfXahjuRuPjifqTcSUe
	 rABWDIeVj4zP+Ntwb4NEwNAASdHIpl8oTNDhty6a7MbR7TOo4TtlQQF9nsnmb/asPj
	 bdFwtlPTbx/jgwxwhkbnxSFIci8B7vx85D5wlxzFXmwqXjLS3ljq/Ml/i7W5RKATHY
	 1Zgv88i/j3DDcB1UffE6uRognGn/Qoq0hzerQ/c555Te3LnvUrKCGJy8FskETij2BY
	 UcJKskw/dSGwE+IR9gZ1oPobLVyQvr2rK71ghKYuqNBQC4Nz6VpOlZEFmd7V3w6rjF
	 Op/8qS6dI/j9A==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso3238446a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jan 2026 09:19:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3YC7kWmp5p8n8n2ofWyYZwFlMrrVegGX5MWvyu21bG94o1oqsivm/IHWvNIa8bGDc8e0nowiYhrJHjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyR064jJsAVL9+fYQe9Ts57ZnJW9warFVdFInJ7U86pujGVMT33
	dNNyaESNgg34e4Dj0kRXZ/+GV13M5WnQUo+r7QP53T8x5k6xLfmx+WTveihHVLpBfFskeK2VAuP
	J+8CKKIVZcokZf6hnH17is/AsMgpFOPs=
X-Received: by 2002:a17:907:961d:b0:b87:b87:cdb7 with SMTP id
 a640c23a62f3a-b8dff8ed33emr151443366b.64.1769793561571; Fri, 30 Jan 2026
 09:19:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126045315.GA31641@lst.de>
In-Reply-To: <20260126045315.GA31641@lst.de>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 30 Jan 2026 17:18:44 +0000
X-Gmail-Original-Message-ID: <CAL3q7H473CV4VcgYgHXRv7tX+ODC0Lg4tYY4UtQBfTdoJ+yVVQ@mail.gmail.com>
X-Gm-Features: AZwV_QgG_msdmt6nUlpK4nLnEmMHvCjcwUwS1J2ZmLA8cib0xAPD8a8I_BPM5kU
Message-ID: <CAL3q7H473CV4VcgYgHXRv7tX+ODC0Lg4tYY4UtQBfTdoJ+yVVQ@mail.gmail.com>
Subject: Re: memory leaks in btrfs raid code in 6.19-rc?
To: Christoph Hellwig <hch@lst.de>
Cc: David Sterba <dsterba@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmx.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21248-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 360A1BCF81
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 4:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> When running xfstests on btrfs with a SCRATCH_DEV_POOL and kmemleak
> enabled I see a lot of these kmemleak reports, start with btrfs/060,
> but affecting basically all tests exercising the RAID code:
>
> unreferenced object 0xffff888111f61890 (size 16):
>   comm "fsstress", pid 5252, jiffies 4294898624
>   hex dump (first 16 bytes):
>     ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>   backtrace (crc d3088d4f):
>     __kmalloc_noprof+0x3c8/0x510
>     alloc_rbio.isra.0+0x127/0x390
>     raid56_parity_write+0x2b/0x180
>     btrfs_submit_bbio+0x26d/0x870
>     submit_one_bio+0x7a/0xb0
>     submit_extent_folio+0x163/0x320
>     extent_writepage_io+0x2c9/0x4d0
>     extent_write_cache_pages+0x396/0x9d0
>     btrfs_writepages+0x70/0x120
>     do_writepages+0xc8/0x160
>     filemap_writeback+0xb3/0xe0
>     btrfs_fdatawrite_range+0x22/0x60
>     btrfs_wait_ordered_range+0x47/0x110
>     btrfs_fallocate+0x193/0x11a0
>     vfs_fallocate+0x160/0x3c0
>     __x64_sys_fallocate+0x44/0xa0

This fixes it:

https://lore.kernel.org/linux-btrfs/140aedc1e1af2866bb838d29b742c2015d55d91=
e.1769793280.git.fdmanana@suse.com/

Thanks.
>
>

