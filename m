Return-Path: <linux-btrfs+bounces-20350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BF1D0BD06
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 19:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFA2F30C9366
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4436405F;
	Fri,  9 Jan 2026 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hv0tmjaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+dzjtMc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136B3321BD
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982582; cv=none; b=EdB5WOFBqrFMFsQKS0l0gn8uRXOUKUtAnd6+fPD6z8mD/tfRM8rCFmwRZQoalFFcpNBGpAltplgFmbSwwRZ1/ees8ebhKdiDfXFT5ZjVQ4mZLEfSY8RcdUwGRm39NO1JdaUj6x59+yQC7foNDwPZOGSD7nbkg0rDdO8j6m/RPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982582; c=relaxed/simple;
	bh=hJmMaFJ5SwJsMyD5tUboueQq8cviInOx7a2UCxKy0DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrcFnTTRGl75vs8YnH+zpyRjABeVV5jFpI4UZRfrZal8nvuvrY+YBjtZPVJ/6HVGBLVds1rUu3VpYIWaw9EPg5Dw58Nr82aTfZYW7kbHhk7rmfyj7BXIXGxl+f2jKxm7HQn6yTzFh5PhxV12Arjrs7Lx7hYNSW0kyB8KeTz9epA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hv0tmjaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+dzjtMc; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A53314000F1;
	Fri,  9 Jan 2026 13:16:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 13:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767982580; x=1768068980; bh=t21xzC/u+a
	OaoBgvUiL3s1tB6SxKB4vGhacWcduvIL8=; b=hv0tmjaLqkqRmTMVEEleQPYL/Z
	wxkXdaZJX4L4bIBzlM8BotEtjGNWf8jPKlVxY7jKT5pjCmWKqsfkTVKKbxul7JGo
	z6gvsezYI2b6oLRBHgZBDPBn2CIHJiEpTVHa5W0aG4UBD5Rm3oIyNcFt3pOTUQMV
	AIb6JwA7Xbu7e4HBZs5wauvqq4BHNSVzrJdw1fN7Ur4bCazcGdweZle+ueJ0LTte
	3akForhY7X0Hq00geoPFyICAAbo8w5XjIYgzUutuiaKPH4ibwkQpZ/HRX4kLWYIM
	gRA6aa/5gsOrPZXm9Kx3y6ZJgiNpVrFamwSSNVBHfN+2dT7GwfnLKKj8rewQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767982580; x=1768068980; bh=t21xzC/u+aOaoBgvUiL3s1tB6SxKB4vGhac
	WcduvIL8=; b=b+dzjtMcZ5oB7fVQDeuO2DA1frCSbJFfl0RMTt5Va6RwD2YKxk0
	YdcuOLQNfRF2s+qKRQ/N0NsBJ990nEA/sIKm8qto2vQGcqR/RF3SINyaH4TtYTux
	PLqb1XmqCQexcBOR7SgT+k2cjfB8PRhPcBWr5i65orGRELpga9jMcYw5FolPmE1I
	t2lp1EO5oRna7xYf2CYpsgFim1cOpr6IvNDfXJK79vrp9XPDtQg5Pc1LQgAcEozX
	HgDnVUAZ9We3po1V1wB35lLz3JoChFmtWwh2CIfLF5VYLiwBNisX9aqzrzz2yWgx
	TvgARa0Slw1EtkrxyNGREZXsDO6V521CAHA==
X-ME-Sender: <xms:9EVhafg8Ilr6VxbDAvZcL05kVype7rjkOj-2aO597mkwdzswsoEWCw>
    <xme:9EVhaSBljkA6gulY6MZJWQbYZVF5bAAxJCV5GVwtr9heaKOL0bHQ23AY8UQxAVpYh
    THPBZPr7R42irzIP4zh_J3DZ-kyR8CZyD-dClgaUucfNUxQtMtARas>
X-ME-Received: <xmr:9EVhacvERJkYEZ3BcLnZrlpcdoE-mySU6vtOmut4wIBOuOvQDe9NpNUCLldBmFydO70zW77W4bDZm0j-aJANCIo0V4k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9EVhaXZ1FKi3qVwJDORCFSyaxn3bWK2fQZ4ZGJYP_vV3UYtZfh-blg>
    <xmx:9EVhafWEzHh1TpjwdQJUn0F0LZIer8OSsoKvPmzCmtj3tn5Yh7UXyA>
    <xmx:9EVhab6l_NOuNvvPz6yD_-EKQlggYXqX6UnoLJKsTVC_cpp0cJiHoQ>
    <xmx:9EVhaaj4N6rNl7GyGBmGwTD6ELdbV-ouAfaFAQ3l6ArbWl30efxDqA>
    <xmx:9EVhaVu-J-66zk6TbsQEUF5ShoCaFRa0fU9SRTH0W2QjmooN4vMkxG-v>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 13:16:20 -0500 (EST)
Date: Fri, 9 Jan 2026 10:16:27 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Delayed ref root cleanups
Message-ID: <20260109181627.GB3036615@zen.localdomain>
References: <cover.1767979013.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767979013.git.dsterba@suse.com>

On Fri, Jan 09, 2026 at 06:17:39PM +0100, David Sterba wrote:
> Embed delayed root into btrfs_fs_info.

The patches all look fine to me, but I think it would be nice to give
some justification for why it is desirable to make this change besides
"it's possible". If anything, it is a regression on the size of struct
btrfs_fs_info as you mention in the first patch.

If the answer is just that it's simpler and there is no need for a
separate allocation, then fair enough. But then why not directly embed
all the one-off structures pointed to by fs_info? Like all the global
roots, for example. Are they too large? What constitutes too large?
Later, when we slowly add stuff to fs_info till it is bigger than 4k,
should we undo this patch set? Or look for other, bigger structs to
unembed first?

Thanks,
Boris

> 
> David Sterba (4):
>   btrfs: embed delayed root to struct btrfs_fs_info
>   btrfs: reorder members in btrfs_delayed_root for better packing
>   btrfs: don't use local variables for fs_info->delayed_root
>   btrfs: pass btrfs_fs_info to btrfs_first_delayed_node()
> 
>  fs/btrfs/delayed-inode.c | 49 +++++++++++++---------------------------
>  fs/btrfs/delayed-inode.h | 15 ------------
>  fs/btrfs/disk-io.c       |  8 ++-----
>  fs/btrfs/fs.h            | 18 +++++++++++++--
>  4 files changed, 34 insertions(+), 56 deletions(-)
> 
> -- 
> 2.51.1
> 

