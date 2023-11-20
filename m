Return-Path: <linux-btrfs+bounces-199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606EA7F1C2B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 19:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A53A282554
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 18:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609530670;
	Mon, 20 Nov 2023 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D386BC
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 10:19:59 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id C3B73149975; Mon, 20 Nov 2023 13:19:58 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Hirte
 <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
Subject: Re: checksum errors but files are readable and no disk errors
In-Reply-To: <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
Date: Mon, 20 Nov 2023 13:19:58 -0500
Message-ID: <87ttpgz3qp.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Qu Wenruo <quwenruo.btrfs@gmx.com> writes:

> For the cause of the error, the most common one is page modification
> during writeback, which is super common doing DirectIO while modify the
> page half way.
> (Which I guess is common for some VM workload? As I have seen several
> reports like this)

How is it common for applications to modify the page during directIO,
which is explicitly NOT ALLOWED and will result in bad things happening
no matter what FS you are using or if you are using md.  Even with md,
if you modify the page under direct write, the original may have already
been written to one disk, then the other disk gets the (partially)
updated version, and md has no way of knowing this.  It will detect it
if you do a scrub I guess, but it doesn't know which is the "good"
copy.  At least with btrfs csums one disk might contain the original,
uncorrupted data with the good csum and then that will be used.

Even with ext4 on a single disk, this behavior will result in a corrupt
file that is neither the original, nor fully modified version.  If qemu
is doing this, then that's a bug in qemu that needs to be fixed.  Then
again, if qemu is submitting a block for write to disk while the guest
OS modifies it, then maybe the bug is in the guest OS, as it should not
be modifying a page that is under write.

