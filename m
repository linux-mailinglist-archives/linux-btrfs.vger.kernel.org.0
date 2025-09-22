Return-Path: <linux-btrfs+bounces-17052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A56B8FF0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CB07AFD34
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12AE2F5306;
	Mon, 22 Sep 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b="D5ZgbcxK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AE27F749
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535849; cv=none; b=tlfOaLQS/Xx9uhGpLYW4akNrpiiRf+U3lDi6A6dZIL4kvQJ7+yjhD+i58ipejv4p9JPq8FdJe2Ew1Q7yIRRgwUoGsw7e5hOAtcp2VUkdiFyV3y+KEVkOuWpQqRq0ptADJK6C2Vj4/5MO5yE3uVPq2OASKm0Hh9yEuyfQZwH4IPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535849; c=relaxed/simple;
	bh=UQgWsPZlvMW4O9iELiUm4yOYmh1rujSulQMFSgYk2ik=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nqqCuXsfZm2V319dMDy58984OJs180Rr82UYKShJluCd6z7ZwoN448JSKrowvmE3rTuCuK6HQe8DPP9Jt8r+E7gswI8FwDAHKaUztuzb6SfDzRTuQ6UR36I8YwWFDgNt3gSW6y05h5yTMoNgvaS1kL561E6C4ZQhH896QapcR2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cobb.uk.net; spf=pass smtp.mailfrom=cobb.uk.net; dkim=pass (2048-bit key) header.d=cobb.uk.net header.i=@cobb.uk.net header.b=D5ZgbcxK; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cobb.uk.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cobb.uk.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cobb.uk.net
	; s=mythic-beasts-k1; h=Subject:From:To:Date;
	bh=yCjL6gUW3Cym0YG0z2kD8fB7HUjg/5CWVlD+Ium8YIM=; b=D5ZgbcxKyVNhdtXo1Xdm+dAKn5
	sS+HiWjLcKG80eDjp9adnyWGQJhv9/xQpLT873lUKG69u1Y/61nqrmqpCajdN3cCXP7AqmrqRmyLk
	AZI7MiMvsVxtSZx4lHp5PsGyA8nnoEUkMw41QFlbNMaHVHZwkzowOY8ASQCAhV8I4AH5wCS2ft8oH
	AgF/C3uZTwmIali1UldQ514YPA1DzwYFB4mBa+Fj7jouAHNQKAAN2D6O2uB3ufLbCHtCQPob4og+L
	jGRU7Rl278w0VtHiH6THIf64LdDQl8+/72z4lFW5PSduyuweAnuW+mryhlnCumWiprMGLp6+vJ9/G
	fODUAfug==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <g.btrfs@cobb.uk.net>)
	id 1v0dKR-009aCh-06
	for linux-btrfs@vger.kernel.org;
	Mon, 22 Sep 2025 10:59:27 +0100
Message-ID: <cc6caa76-3b79-49cc-8757-5a6992d69d27@cobb.uk.net>
Date: Mon, 22 Sep 2025 10:59:23 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-btrfs@vger.kernel.org
From: Graham Cobb <g.btrfs@cobb.uk.net>
Content-Language: en-US
Subject: Improve progress logging for long resize?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 9

I am currently trying to shrink a btrfs device to create a bit of space 
for something else. It is a big disk (about 20TB device) and I want to 
shrink it by about 1%. I know it will take a long time.

However, I think the progress reporting could be usefully improved. Here 
is the logging to date:

Sep 19 16:35:59 black kernel: BTRFS info (device dm-6): resize device 
/dev/mapper/cryptsnap22tb--vg-backupsnapshot (devid 6) from 
21650951110656 to 21474836480000

Sep 19 16:37:36 black kernel: BTRFS info (device dm-6): resizing devid 6

Sep 19 16:37:49 black kernel: BTRFS info (device dm-6): relocating block 
group 72119527407616 flags metadata|raid1

Sep 22 04:23:28 black kernel: BTRFS info (device dm-6): found 54384 
extents, stage: move data extents

Sep 22 04:25:57 black kernel: BTRFS info (device dm-6): relocating block 
group 72118453665792 flags metadata|raid1

 From the log, I can see that I started the operation on 19 Sept at 
16:36 and at 16:37 it found the first block to move. That's fine.

Two and a half days later I get the next message - telling me the first 
block group has been moved! (Actually - is it telling me that? That 
message isn't very clear - but that is a different issue).

I'm not complaining about how long it takes - this is an old, slow 
system, I am using LVM and encryption, etc. However, it would have been 
comforting to get an occasional progress message in the log.

Would it be possible to log very long operations such as these every 
hour (say, or some other interval - 4 hours?)? Ideally reporting some 
progress (number of extents found so far, or something) - or at least 
giving some confidence the operation hasn't stuck due to some I/O 
failure or on-disk corruption. If this was part of restoring some system 
after a failure it would be nice to get a feel of how slowly it is going.

Thoughts?

Graham

