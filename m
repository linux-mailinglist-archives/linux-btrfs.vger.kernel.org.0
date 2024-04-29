Return-Path: <linux-btrfs+bounces-4602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D78B598F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AE71C246A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A426E5EF;
	Mon, 29 Apr 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Ojb7way6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YYXxB9Ue"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8EC127
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396267; cv=none; b=hJR11nYno2Q3x1eyuL5uP/2TkbB3f+7qX6ztQBzYeAUNvCrKeSaskZHNYlUkhDMlX6RV5wU13ADy2Ct5EqFBeM/RURpKDmqnwRWkCXxPD8i2E2Zx/vhnnuuCqlePIXTQIHaZFSKWaY2tPxQyNXe1nCV96HfqHKym3BhH/f6qGw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396267; c=relaxed/simple;
	bh=vuwpyv8k0kzId+7AU9zSemXPF6YeZpRSuTEQgF9fT+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xoebc9DDNpdo1XGlA9BYr2kDFTilTCDO0bbbs7bxsrG3L/z1c1Yn7M6oHqLOz26Qs7Zh8jd2wO+6Nel7/+PPJTrUPTJQxaZW4sQWeUWNb5GFUMRSTbkPZhh9zEbshfDXTithm6KN/6V8eDiwqhaBUqLeaUsnOgbCvoNkJAq4DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Ojb7way6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YYXxB9Ue; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 81AAD1381A3A;
	Mon, 29 Apr 2024 09:11:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2024 09:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714396260;
	 x=1714482660; bh=OkiLRRd8SH2qk1/z1zojtf9PZ6RMP1gSZk+ItcAwGJw=; b=
	Ojb7way6EokV3+jh2QCBBjTMuio/tRxP7RZ4DqgPzCfiodpSIkpq/0F3AM01mlYN
	bvV6va0dDTOarpRz6MhoJi56pX1jAzMJix0oJxyD3XBg9XHsy5yJHJ3H6AJclt2P
	HSwP6ugII0FfyzCjlccPxZtuOY1Pqj3XBecK0OIQQAAyJ93movKsNW4kFDdqyWNa
	keXuKAnvgq18U56qANLPXXaveGxnJjPxvT5BgIn2dS5hZQZEfp9DXFdl+sV6jsb2
	jYvKOPGqZauaGuqLhasdQqDDg0Y/T8dUxeMvQTaPNejnkvmaFyaYvmerP4otFjfB
	38GOLmYebJFL8mtksN8Bqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714396260; x=
	1714482660; bh=OkiLRRd8SH2qk1/z1zojtf9PZ6RMP1gSZk+ItcAwGJw=; b=Y
	YXxB9UeHq8clwEZmsbDHoCvCQ5UPvFMJUl56Rs1huAyJBr13onHmrB+sVd/xZ3nH
	CSvRkfyaUZa0NWumh9jwACFyCjb+2N8OtPyIE30hk4o/J37OIAgvh6f3xJA2zhdF
	WWCLHtwHZjIEtoE7ri1FTPXYqtnfAJIa7Mu6awaO32cU5JNGqgWgxfXm0xODzuGk
	VgTMFmqxyMsadZfPs/kJ7JzJWl+dcN/qEAzwR1thN5QeDC7w5UKUIwkviAKEoS9S
	8/w5yH3XG9plyuEgLlCBrMcCjn317lENRYzChrUB5Qy8KbFm7FBJaZ5bmBTwYAI/
	Pk81HPlXomYa/apxPT69A==
X-ME-Sender: <xms:ZJwvZut4Mb9v3Ud3B2ky1RI88xEHYIU8-an26HbwqVCTNQm4LGFNfg>
    <xme:ZJwvZje6TWVwMk9qoKEUqk_N86rtUn0SUwZeK_EXuEbBLBjP35qO-EhCbyjnRUTk-
    NFeFRtdIOjUj8RnbRE>
X-ME-Received: <xmr:ZJwvZpwLektVdT-Ofu2nmpc4iKTTCu71NOThJK8ATMajy2Ol5OTR059Cc0DdNVGc5BXSo2tFNk-VjN_zyAFqdQMTifU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:ZJwvZpOFGAowFJyPDCwsCrtG2Jo9U99i2sbBUYUb-FsWmWJscOkHVA>
    <xmx:ZJwvZu-1Oi7RB5F2cD8-EoyMqoI2YamiIOVyArcQBNLDSoDe7hdVIA>
    <xmx:ZJwvZhXNrulEkstN_xRwEoryNLVX1Gdq7WmgYs9gTpJHmpn0_oDeZg>
    <xmx:ZJwvZnfBp0OiAiRl2uQlH-qCu0odBUXs65X8TVxQPwjtnCuQD23L4Q>
    <xmx:ZJwvZiZo7R3coqb-nJ0zs9Ggnw8e22Rjkr4gxMY1RGTM2dqoFcVmydr0>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 09:10:59 -0400 (EDT)
Date: Mon, 29 Apr 2024 06:13:33 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
Message-ID: <20240429131333.GC21573@zen.localdomain>
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>

On Fri, Apr 26, 2024 at 07:21:08AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/4/25 22:04, David Sterba 写道:
> > On Thu, Apr 25, 2024 at 07:49:12AM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2024/4/24 22:11, David Sterba 写道:
> > > > On Fri, Apr 19, 2024 at 07:16:53PM +0930, Qu Wenruo wrote:
> > > > > Currently if we fully removed a subvolume (not only unlinked, but fully
> > > > > dropped its root item), its qgroup would not be removed.
> > > > > 
> > > > > Thus we have "btrfs qgroup clear-stale" to handle such 0 level qgroups.
> > > > 
> > > > There's also an option 'btrfs subvolume delete --delete-qgroup' that
> > > > does that and is going to be default in 6.9. With this kernel change it
> > > > would break the behaviour of the --no-delete-qgroup, which is there for
> > > > the case something depends on that.  For now I'd rather postpone
> > > > changing the kernel behaviour.
> > > > 
> > > 
> > > A quick glance of the --delete-qgroup shows it won't work as expected at
> > > all.
> > > 
> > > Firstly, the qgroup delete requires the qgroup numbers to be 0.
> > > Meanwhile qgroup numbers can only be 0 after 1) the full subvolume has
> > > been dropped 2) a transaction is committed to reflect the qgroup numbers.
> > 
> > The deletion option calls ioctl, so this means that 'btrfs qgroup remove'
> > will not delete it either?
> 
> Nope, at least if the subvolume is not cleaned up immediately.
> > 
> > > Both situation is only handled in my patchset, thus this means for a lot
> > > of cases it won't work at all.
> > > 
> > > Furthermore, there is the drop_subtree_threshold thing, which can mark
> > > qgroup inconsistent and skip accounting, making the target subvolume's
> > > qgroup numbers never fall back to 0 (until next rescan).
> > > 
> > > So I'm afraid the --delete-qgroup won't work until the 1/2 patch get
> > > merged (allowing deleting qgroups as long as the target subvolume is gone).
> > 
> > Ok, so for emulation of the complete removal in userspace it's
> > 
> > btrfs subvolume delete 123
> > btrfs subvolume sync 123
> > btrfs qgroup remove 0/123
> > 
> > but this needs to wait until the sync is finished and that is not
> > expected for the subvolume delete command.
> 
> That's the problem, and why doing it in user space has it limits.
> 
> Furthermore, with drop_subtree_threshold or other qgroup operations
> marking the qgroup inconsistent, you can not delete that qgroup at all,
> until the next rescan.
> 
> > It needs to be fixed but now
> > I'm not sure this can be default in 6.9 as planned.
> 
> I'd say, you should not implement this feature without really
> understanding the challenges in the first place.
> 
> And that's why I really prefer you send out non-trivial btrfs-progs for
> review, other than pushing them directly into github repo.
> 
> Thanks,
> Qu

I support the auto deletion in the kernel as you propose, I think it
just makes sense. Who wants stale, empty qgroups around that aren't
attached to any subvol? I suppose that with the drop_thresh thing, it is
possible some parent qgroup still reflects the usage until the next full
scan?

Thinking out loud -- for regular qgroups, we could avoid this all if we
do the reaping when usage goes to 0 and there is no subvol. So remove
the qgroup as a consequence of the rescan, not the subvol delete. I
imagine this is quite a bit messier, though :(

We could also just not auto-reap if that condition occurs (inconsistent
qg with a parent), but I think that may be surprising for the same
reasons that got you working on this in the first place...

Do we know of an explicit need to support --no-delete-qgroup? It feels
like it is perfectly normal for us to improve the default behavior of
the kernel or userspace tools without supporting the old behavior as a
flag forever (without a user).

Put another way, I think it would be perfectly reasonable to term the
stale qgroups a leaked memory resource and this patch a bug fix, if we
are willing to get overly philosophical about it. We don't carry around
eternal flags for bug fixes, unless it's some rather exceptional case.

If we are on the hook for supporing that flag because we already added
it to progs and don't want to deprecate it, then maybe we can think of
something compatible with default auto-reap.

Thanks,
Boris

