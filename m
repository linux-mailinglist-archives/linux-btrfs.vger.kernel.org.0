Return-Path: <linux-btrfs+bounces-249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A267F323E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6376BB21E08
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155475677B;
	Tue, 21 Nov 2023 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CADD
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 07:23:09 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 9AD6E149E26; Tue, 21 Nov 2023 10:23:07 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: kreijack@inwind.it, Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Hirte
 <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
Subject: Re: checksum errors but files are readable and no disk errors
In-Reply-To: <a288c71f-9e42-4448-9089-fc0e3dfa8abb@libero.it>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <87ttpgz3qp.fsf@vps.thesusis.net>
 <a288c71f-9e42-4448-9089-fc0e3dfa8abb@libero.it>
Date: Tue, 21 Nov 2023 10:23:07 -0500
Message-ID: <87bkbn1678.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Goffredo Baroncelli <kreijack@libero.it> writes:

> Could you elaborate why is it "NOT ALLOWED" ?
>
> My understanding is that when the write are not sync (i.e. the program
> doesn't wait until the data are on the platter and the metadata are
> sync-ed), there is a race between the kernel that write the data
> and the user program that may modify the data. And it is possible that the
> data are a mix of the old and the new.

Right.  That's *one* problem.

> Now the problem here is *not* that the data are a mix between the old
> and new (if you want O_DIRECT, this is a price to pay); this is an
> un-avoidable cost of updating the data before checking that these
> are on the disk without using a intermediate buffer.
>
> The problem is that the csum are not aligned with the data.
> This is a specific issue of BTRFS [1], only because the other fs don't
> have the data checksummed.

The *reason* the csum is not aligned with the data is because one or
both copies of the data are an indeterminite mix of the old and new.
You still end up with indeterminite/corrupt data either way, you just
don't get told this is the case without csum.  In other words, the bug
is in the application that is causing the corruption, not in btrfs for
reporting it.

