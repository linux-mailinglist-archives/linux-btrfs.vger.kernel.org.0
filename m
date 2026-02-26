Return-Path: <linux-btrfs+bounces-22021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEBxN4ScoGlVlAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22021-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 20:18:28 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C651AE438
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 20:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53C2B300F79D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACAD35A380;
	Thu, 26 Feb 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="bF6I4ZIm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XHONhGbG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCB2DEA93
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 19:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132959; cv=none; b=u3DBakDjlwGwsjiqhrN81u779vwVxi1c5WqVVKJuMkMDmWBP7cIVW3R4qiTyl4zGvnIszgj6lkZ8GJVoKKsQ8KIzoNI85xD9vb+mACuU4E8X8WN+Y/adzop3v/FxN/P0fyMjN5vENdWdWlS6Cufd2TpxFLfAp8VCDWZ+uCmbWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132959; c=relaxed/simple;
	bh=1ZStJMk4BQpRKWha0AmesGVXbqypaoAhQ5VCNigdqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMMv7ZB1VBAHLtYUPieM74clXthihVW7jRgLPeGaHtji/23IbueIIcIT2cmWtgmjF/SFYsRmgJgp6Uf3HZYMVyg/DscvjdhoKDT7kYN6BbcdygwPeGFcpaKHxerc6XLy09HWo1nGW2L2sOarW3EvpvbPM/00IS09KN4Y+/xQv9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=bF6I4ZIm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XHONhGbG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6858AEC05DF;
	Thu, 26 Feb 2026 14:09:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 14:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772132957; x=1772219357; bh=c4wg3HImgO
	GKV6y3q7M/O9YUKkJ0cBN0wjk0zNublIs=; b=bF6I4ZImffqiGNlvOU+aj0XGvP
	o8Z4PMifwAMzBs/FwziSun260wNWsHoR9qOFPpZB1UsyyCyKh0IkBNcHj2exNcvh
	OGzFlqGhn5+pexLfdotLDbT0h5sY+LWv/u9aC7ipBi6yvyQhnjEggOD6xm35+gEN
	aqPh4al4oCiStOpXJFHfr2EtZBCrfTIc+nB2ei2eOgbI1GGOfvNjyCFrEfz/Pb/m
	znMa3ouxs7L8SaiBIiHpU0GiXPUUUpQKHlH0s4ORR2lyr3BCSL6xMfN5odSWXbcO
	Xlp4XnOG3f2bFBGX6cmwB1YZpdo9xKlWGFm1Vu6PLvu5tnWOL05z7/XBLsMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772132957; x=1772219357; bh=c4wg3HImgOGKV6y3q7M/O9YUKkJ0cBN0wjk
	0zNublIs=; b=XHONhGbGjSdzq/SyvdwoXUcUej3ORp1r6mRRsndp4h+P+v2MRFL
	I/3U+lP7LEll4cQV4ZbNEMmQdFV+pdNMwfYT6WFYcWODzScn0TN8hOxhEu0Uaaey
	rVWyyGfndL1pRLyNR5Q/0odpW6pcU6EqKYhY66g/g06ICSEgW23NRrjb2ewb9Z4F
	hHuwm0ffaQWOApRgEVpJLozNxMiXt5wMqy9SFpJfZMt6r0sJ7NSUXoIdhphVJdp7
	ThMxAoCRmQ5sxV5YY/38m1Q+TYX6D55Rvq8BPSqSOjS2FFNVrpNbdZF58D/74KKs
	1HQrfdLRMXBl34NHeZNMQdnbR5uR9WzM3pw==
X-ME-Sender: <xms:XZqgaVyamfXSBDKIzvtP0hvGO8H4kZzhTj7HVjyCx5yNFFUaq_jJAQ>
    <xme:XZqgabQAeYCj2HwfrIhArvuQvcahIlf-75lqxWNkEdmk2tbtOqtzvA8QN7vkblD-R
    QQwcJrniJrmmjMpwDtGT25OFejD3wBL8Qh3HtUHty29ZW_pNZft6S4>
X-ME-Received: <xmr:XZqgac_6X1wvDmkGq9RfseG733VeYY_f1IkfDfzfjezRMAvGhCHIpcoLd-DeYXxSRRnOYpr2sIn7dRwvyfC93WjHKO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeikeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:XZqgaSoN4nBNyF0pwMJowtncnti3bvPsXil4HXLVw7RwzawaY-7dIQ>
    <xmx:XZqgaZnUkaCy8b9XmK-txyXTLC6rqsB1wRrSv67xZuZBVpizjltJLg>
    <xmx:XZqgaZLmvKvlUS6_sjAigr-lW_8Hhle55j8Eg-lJp6clLF3s25_jbA>
    <xmx:XZqgaewKwtySAzZ7120p7y2nrsSSZ3LFXyOmRu-ndTiVRMUc-AXiLA>
    <xmx:XZqgaQleG90RRU711hYkbDj5wJBtqrjsUBdAnwrYCgmmLGiEyxYwz-jb>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 14:09:16 -0500 (EST)
Date: Thu, 26 Feb 2026 11:10:09 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] btrfs: fix exploits that allow malicious users to
 turn fs into RO mode
Message-ID: <20260226191009.GB2996252@zen.localdomain>
References: <cover.1772105193.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772105193.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-22021-lists,linux-btrfs=lfdr.de];
	DMARC_NA(0.00)[bur.io];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,zen.localdomain:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: E7C651AE438
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 02:33:57PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We have a couple scenarios that regular users can exploit to trigger a
> transaction abort and turn a filesystem into RO mode, causing some
> disruption. The first 2 patches fix these, the remainder are just a few
> trivial and cleanups.

Bug fixes and cleanups look good. No need to abort in these cases as you
have shown.
Reviewed-by: Boris Burkov <boris@bur.io>

But on the topic of security, or malicious users:

How is this sort of attack conceptually different from simply filling
up the filesystem with fallocates then doing random metadata operations
until we ENOSPC and go readonly?

What about if the attacker also exploits the behavior of the extent
allocator to try to produce fragmentation driven metadata ENOSPCs
aborts?

Thanks,
Boris

> 
> Filipe Manana (5):
>   btrfs: fix transaction abort on file creation due to name hash collision
>   btrfs: fix transaction abort when snapshotting received subvolumes
>   btrfs: stop checking for -EEXIST return value from btrfs_uuid_tree_add()
>   btrfs: remove duplicated uuid tree existence check in btrfs_uuid_tree_add()
>   btrfs: remove pointless error check in btrfs_check_dir_item_collision()
> 
>  fs/btrfs/dir-item.c    |  4 +---
>  fs/btrfs/inode.c       | 19 +++++++++++++++++++
>  fs/btrfs/ioctl.c       |  2 +-
>  fs/btrfs/transaction.c | 18 +++++++++++++++++-
>  fs/btrfs/uuid-tree.c   |  5 +----
>  5 files changed, 39 insertions(+), 9 deletions(-)
> 
> -- 
> 2.47.2
> 

