Return-Path: <linux-btrfs+bounces-5147-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E828CA9E9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61922281463
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339756440;
	Tue, 21 May 2024 08:26:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A754762
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280017; cv=none; b=O40hqXskL0MUei0F332NlfHI/s7LQ22BVxYFCnr0dyyh2cooCZeijFmJfXGKuqNKJopWn4FA9e8cFRFXwBoy4fCm6yO6Pdh/3sol7hqo2j58LPwQKokA3fxh4FMu+RUCz0X23ibSu9oTtPcIT+qhFANjDfKYjq8ZeCKWT3+RR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280017; c=relaxed/simple;
	bh=5c7Qy5N9vbrZofKgDQ216pF91ZJBVVqiN7i66ltrg3Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sA1JfBrcrlNEJR+sbsXFid9QftmFMn2Zo9ZKjnwuXl9pzpvtzaxmB0TeLb28gGiM9zN90neBv+oZKfzUgXa/pbvdhMr4DM8jOcFSJRUyc7g/OyHkrDdhCPjg7jM9v1pgs9zhsAHEV5ZFoeTO8cf84yMpFn9CHyv0r0rGOXv/ykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net; spf=pass smtp.mailfrom=poettering.net; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poettering.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poettering.net
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 90244E801FB;
	Tue, 21 May 2024 10:20:32 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id D69C21601B2; Tue, 21 May 2024 10:20:31 +0200 (CEST)
Date: Tue, 21 May 2024 10:20:31 +0200
From: Lennart Poettering <lennart@poettering.net>
To: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: btrfs: please undo removal of "norecovery" (userspace breakage)
Message-ID: <ZkxZT0J-z0GYvfy8@gardel-login>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi!

So we learnt the hard way that btrfs dropped support for the the
"norecovery" mount option recently (kernel 6.8).

This basically broke any released version of systemd, because this
option is what we use to ensure that btrfs images mounted off loopback
block devices do not modify the backing file (because unfortunately,
the loopback block devices allow writes go through even if marked
read-only).

I understand that the option was marked "obsolete" for a while, but
this was not visible to us.

Also why even make this obsolete at all? I mean, the functionality is
still there, so is there any value in randomly renaming this option?
In particular as the other big file systems (i.e. ext3, ext4, xfs) all
have a flag of the same name doing the same thing. So why depart from
this at all as the only outlier? Where's the value in that?

(This issue is tracked in systemd here:
https://github.com/systemd/systemd/pull/32892 – we commited a
work-around for future versions of systemd, but that doesn't fix
things if older systemd versions are used on newer kernels.)

Hence, please reconsider this, this seems to be breakage for the sake
of breakage with no real benefit at all?

I mean, I respect your right to deprecate and obsolete stuff, but in
this case this seems just entirely random and ignoring how much
userspace this will break.

It's fine to hide stuff in docs and so on you think is redundant, but
if you take the kernel developers mantra of "we never break userspace"
seriously, you should still keep the option around to be parsed,
because this *did* break userspace, quite massively. And there's so
little effort necessary to keep compat here, just treat "norecovery"
as an alias "rescue=nologreplay".

Thank you,

Lennart

