Return-Path: <linux-btrfs+bounces-16587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66604B3FC7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 12:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF64A18933EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82BB2820B9;
	Tue,  2 Sep 2025 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PhkrA6Ly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81172625;
	Tue,  2 Sep 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809041; cv=none; b=RFBUhA1AtqDh93ugUD3oCqfcVjRh7WSdn6G+rmClgyuPKPO7wwjANWXpH3QtXOs1ifUwYwi3Cdf2t4x54UDA/ENc07VAkIaFUe11NM/CtSzmesZ0QvJHFyE/BcCABvMWtxhElJTcXoIRGKPdMl0Hs9TUPpov+MwKqEtLm4qWcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809041; c=relaxed/simple;
	bh=QBXwT9EuZK9rICmax8vUmET5WkiJ4EuYts3gPXONU2w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OAC5Wv2Fh63ktq4XWRnxt7tMZT5J77ee8aIHjechQ118hp1koMdeQ5rXhzi1Gs3aJ5cFaaYCrsqUJoM/w+OQggJHgbqoBY+KVuo5lHyoSdwrhI+MxbVgdh9CSsWdr2PDYHhSCSP+BoO46GCyWx4FWswHDx8QyGAIzSfHfJvNsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PhkrA6Ly; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756809036; x=1757413836; i=quwenruo.btrfs@gmx.com;
	bh=BwnWX5MuJc5P9tHFSJzTDEPcW3c4t6/PUWhVDZfZnjQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PhkrA6LyRQpw8vtP1CLVnkkKvYf0tysJY99Rt9ZxCE1jg0AydDDBFY+iifW2Gi0j
	 xhJ3WXCOTXT+3Du2pXIOMUQXukdWHcK54OC8BlZnievViJwFbnMSVThuNkWP+y8A/
	 oExsJnAvWDR2n4YNy3DeApJGSyGoiodYEKTapAkep2TwOR3HMJXCEwMUX3ll0Auxo
	 doLqvTe5Vfc/lSz+ALK6dGKbCqpF8I+bEhLmhFSu9TfzkrTPHoGg4MOAEsY7VTlRV
	 7T/8V4xkui1A8oJ8cUZHtTvnXAyooSSUH3TyFqTQR4qINZt8Y0E1shcsmm5MC9N1Z
	 Xw8QlG40EH9VrJQ4dQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6Udt-1urUTS3KOH-008Usj; Tue, 02
 Sep 2025 12:30:36 +0200
Message-ID: <60b73970-9cb6-49b1-ad5f-51ab02ef2c98@gmx.com>
Date: Tue, 2 Sep 2025 20:00:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, linux-xfs@vger.kernel.org
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Golden output mismatch from generic/228, fs independent
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ufe7Ceejp3tHQvUj9zs5JxvhAkwQa0LOSBzefEUhMxPjuoVdvd4
 lOLryGb7vQKBf+z6d/tWCJcUMgZAwWSnS62563Y7u52DJgV5eipt9YyIbCPcDAa/rleZqS8
 ovJ6prSrm8xSSAkE9oLehMp/vKr6x0U0YmBD7rhVm/UXEzEuT6nmDm+Mk1FaV9v/qYkof1q
 BhbQHU8a2pXyx/NNK2sXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zl+HYcA6KY8=;wZGxOpaAO1dFO9lzuQqw/738/H7
 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

Hi,

Recently I updated my arm64 VM, and now several test cases are failing=20
due to golden output mismatch.

This time it's fs independent, and I haven't yet updated fstests itself,=
=20
so it looks like some updates in my environment is breaking the test.

E.g, generic/228 on ext4 (the same on btrfs)

FSTYP         -- ext4
PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.17.0-rc3-custom+ #132 SMP=
=20
PREEMPT_DYNAMIC Mon Sep  1 08:38:46 ACST 2025
MKFS_OPTIONS  -- -F /dev/mapper/test-scratch1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/mapper/test-scratch1 /mnt/scratch

generic/228 0s ... - output mismatch (see=20
/home/adam/xfstests-dev/results//generic/228.out.bad)
     --- tests/generic/228.out	2024-04-25 18:13:45.126552201 +0930
     +++ /home/adam/xfstests-dev/results//generic/228.out.bad	2025-09-02=
=20
19:51:22.806635177 +0930
     @@ -1,6 +1,6 @@
      QA output created by 228
      File size limit is now set to 100 MB.
      Let us try to preallocate 101 MB. This should fail.
     -File size limit exceeded
     +File size limit exceeded   $XFS_IO_PROG -f -c 'falloc 0 101m'=20
$TEST_DIR/ouch
      Let us now try to preallocate 50 MB. This should succeed.
      Test over.
     ...
     (Run 'diff -u /home/adam/xfstests-dev/tests/generic/228.out=20
/home/adam/xfstests-dev/results//generic/228.out.bad'  to see the entire=
=20
diff)
Ran: generic/228
Failures: generic/228
Failed 1 of 1 tests

Or generic/733 on btrfs:

generic/733 7s ... - output mismatch (see=20
/home/adam/xfstests-dev/results//generic/733.out.bad)
     --- tests/generic/733.out	2024-04-25 18:13:45.203549435 +0930
     +++ /home/adam/xfstests-dev/results//generic/733.out.bad	2025-09-02=
=20
19:59:07.858861039 +0930
     @@ -2,5 +2,5 @@
      Format and mount
      Create a many-block file
      Reflink the big file
     -Terminated
     +Terminated                 $here/src/t_reflink_read_race=20
"$testdir/file1" "$testdir/file2" "$testdir/outcome" &>> $seqres.full
      test completed successfully
     ...
     (Run 'diff -u /home/adam/xfstests-dev/tests/generic/733.out=20
/home/adam/xfstests-dev/results//generic/733.out.bad'  to see the entire=
=20
diff)

HINT: You _MAY_ be missing kernel fix:
       5d6f0e9890ed btrfs: stop locking the source extent range during=20
reflink


I didn't know why, but the when those commands failed, the full script=20
line triggering it is also shown.

I checked my log, bash/xfsprogs and a lot of other packages are all=20
updated, and unfortunately my distro doesn't provide older packages for=20
me to bisect...

Thanks,
Qu

