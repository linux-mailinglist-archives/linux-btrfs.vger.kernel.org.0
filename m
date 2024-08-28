Return-Path: <linux-btrfs+bounces-7607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7907962332
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 11:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37577B21EBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FF16131A;
	Wed, 28 Aug 2024 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="ITdjLa4x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200615C15D;
	Wed, 28 Aug 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836758; cv=none; b=VRozO2COEFMQerdrMBR3WSiQIADLiCnhYCLPdw6BQaTzV2dmOG0YgYlS6jrogH0Oc9NgAxdIUBR/TNo5WIcP4MZp/uWK86faNiM+u02gkQC+3/JxBRl6u1poPkE5tdIuVUR48dNL0Rlc05Q98RNQvMnWirlXP1DQuHDiO7npuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836758; c=relaxed/simple;
	bh=LaabBlvLLT6KZ0B8OmZkexPLopnIvERBQLhZph96BS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivKSDvTS+SbAHujxjoXszWQne/LqoQt9E8EC1i7KN7ztSkhI3Sa3dcKlxQHM9p1+V51aJDCUGpMRQl1MpIquMdoL1BP/KgurFuGHOyk7yVezdKXYnb42BT2T8NV1r4L+LlAhtiDiALnrthp6Y18SXR0WQl9id/yRlYj6IVfJDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=ITdjLa4x; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 056534078528;
	Wed, 28 Aug 2024 09:19:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 056534078528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1724836749;
	bh=qmUPEynYpCptgfwjFeNKYBoz8dnFB6kmq008E/pXxSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITdjLa4x9zjpYYRGApibdm05NiZD4NO+jOr8V1K6eO1i2myRsh3uiRaLRt9utK63B
	 JAjsnMW430nhigk7J9MNxe4VmHCoybS2sgcnBvs6UG7rfBD5O0JTVyhrCQqbEfxMAM
	 xlwGl0u4Fd7aLZVq6P7/7+Gc9haZ25UYPX9nthH0=
Date: Wed, 28 Aug 2024 12:19:03 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, Boris Burkov <boris@bur.io>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: add missing extent changeset release
Message-ID: <20240828-f1dd7dd01c3f515d78bb9dfd-pchelkin@ispras.ru>
References: <20240827151243.63493-1-pchelkin@ispras.ru>
 <20240827160341.GZ25962@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827160341.GZ25962@suse.cz>

On Tue, 27. Aug 18:03, David Sterba wrote:
> On Tue, Aug 27, 2024 at 06:12:43PM +0300, Fedor Pchelkin wrote:
> > The extent changeset may have some additional memory dynamically allocated
> > for ulist in result of clear_record_extent_bits() execution.
> 
> This can happen, as clear_record_extent_bits adds more data to the
> changeset in some cases. What I don't see yet how it happens. An extent
> range must be split so that a new entry is added with different bits
> set. This is usual thing, but why does this happen with the quotas
> disabled.

In the reproducer case, qgroup_reserve_data() which sets the bits happens
just before disabling the quotas via ioctl.

Commit af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota disable")
added a call to clear_record_extent_bits() inside __btrfs_qgroup_release_data().
The changeset being passed is freshly initialized and empty. So the first call
to clear_state_bit() there will definitely create a new entry and add it to
the ulist.

If for some reason clear_state_bit() shouldn't be eventually called then,
to be honest, I don't quite understand why a call to clear_record_extent_bits()
was added in the first place without expecting it to do the real work with
clear_state_bit().

