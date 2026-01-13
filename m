Return-Path: <linux-btrfs+bounces-20465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D2D1B166
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 20:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E7A3021769
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B2036C593;
	Tue, 13 Jan 2026 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="N1A1qCyL";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="K3B4jxkW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-3.smtp-out.eu-west-1.amazonses.com (a4-3.smtp-out.eu-west-1.amazonses.com [54.240.4.3])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07719644B
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333390; cv=none; b=Sp80wWMuE2oncNJlmD/8Ry0nw0p4U6U9ERj1grf7imDcv9KvNPkhhVaPwXq5H3XVFRKhGYBDszlQhwpMFd9J36FOlGA4G5GGQJUnJMjPMALrwoLBofsUEnAMhU8kmmQB/m0XWyI/VLpxlGjnLAmpyu69G4QTDHFSmpJ7od1OCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333390; c=relaxed/simple;
	bh=s1vwPOKJWULJJbhbGhstvdTdAfIOiB5eqezmSwRDlg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hExxJRkvVGTseEhK9/lYjBT0FmRPyBAUHuM+TP7E3lF6Ubs1AjHMXpZLr+g8xNBKYPirBA1Y9smxIiqva6clKz+vPm/qgswAhSXrrfTTvtYP1Sl2/fbbw/KULuE89kI8r8/L+QEAMi65GgaH9ijNEtBH/Gxe3wt1As2g5lGEAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=N1A1qCyL; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=K3B4jxkW; arc=none smtp.client-ip=54.240.4.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768333387;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s1vwPOKJWULJJbhbGhstvdTdAfIOiB5eqezmSwRDlg0=;
	b=N1A1qCyLau54+2O0o7UERD0meUdoXtyDF4dyLpJQ0hgVyCAuuBk/qSP4ZaGpJOrw
	CuahpBdH6h3/iDYK4xNGlEdWM80NtKovI6yCtcfzvtQiOKkaxqcMT7+l/Cth1QTCgmz
	y4mMoIyCUP439gkIpXzOlMxy0Z2Mtvq9BkMYsofU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768333387;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=s1vwPOKJWULJJbhbGhstvdTdAfIOiB5eqezmSwRDlg0=;
	b=K3B4jxkWwyUbkicIx8cps3XJ1sMG/vKEOn3nkAdqueiUxZyaMoi9OrS0rbMi6UrF
	zUlaCUhutAit43iaCwXmN4JhsufZfGXzFrzknk94SpHjQ8lQCYoX3sykE3LaDh7Bpcy
	sS+1oShdZZF5ubUEUQE/bGkyscdFrPBU9J/16W14=
Message-ID: <0102019bb8e22468-42ccad46-c781-4756-bb39-17ee564a15f9-000000@eu-west-1.amazonses.com>
Date: Tue, 13 Jan 2026 19:43:06 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Improve performance of find_free_extent
Content-Language: en-GB
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <0102019bb2ff554d-2be39adf-dd94-4f37-864a-69bbf700de33-000000@eu-west-1.amazonses.com>
 <20260113182523.GA972704@zen.localdomain>
From: Martin Raiber <martin@urbackup.org>
In-Reply-To: <20260113182523.GA972704@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.13-54.240.4.3

On 13/01/2026 19:25 Boris Burkov wrote:
> On Mon, Jan 12, 2026 at 04:17:16PM +0000, Martin Raiber wrote:
>> On a system with large btrfs file system and old (but many cores) CPU, I saw the throughput bottlenecked
>> by find_free_extent performance, running in parallel, e.g., by flush_delalloc and btrfs-flush.
>> While the logic in find_free_extent can probably be improved (not iterating through tens of
>> thousands of block groups), I was able to fix the immediate problem by using percpu synchronization
>> primitives and two other micro-optimizations.
> One more high level question, since I haven't worked with you on btrfs
> before. Do you have a good setup for running fstests? If not, this is a
> sweet patch series and I would be happy to help you test it, since
> setting that up can be a pain.

Thanks!

I ran it through the quick xfstests. That is working great at this point 
(no failures/flakey tests), but it was pretty slow
with the setup I had.

>
> Let me know,
> Boris
>
>> Martin Raiber (7):
>>    btrfs: Use percpu refcounting for block groups
>>    btrfs: Use percpu semaphore for space info groups_sem
>>    btrfs: Don't lock data_rwsem if space cache v1 is not used
>>    btrfs: Use percpu sem for block_group_cache_lock
>>    btrfs: Skip locking percpu semaphores on mount
>>    btrfs: Introduce fast path for checking if a block group is done
>>    btrfs: Move block group members frequently accessed together  closer
>>
>>   fs/btrfs/block-group.c | 168 +++++++++++++++++++++++------------------
>>   fs/btrfs/block-group.h |  18 +++--
>>   fs/btrfs/disk-io.c     |   6 +-
>>   fs/btrfs/extent-tree.c |  24 +++---
>>   fs/btrfs/fs.h          |   2 +-
>>   fs/btrfs/ioctl.c       |   8 +-
>>   fs/btrfs/space-info.c  |  33 +++++---
>>   fs/btrfs/space-info.h  |   4 +-
>>   fs/btrfs/sysfs.c       |   9 ++-
>>   fs/btrfs/zoned.c       |  13 ++--
>>   10 files changed, 163 insertions(+), 122 deletions(-)
>>
>> -- 
>> 2.39.5
>>


