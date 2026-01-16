Return-Path: <linux-btrfs+bounces-20612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59226D2DF7F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B525309758C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED732F1FED;
	Fri, 16 Jan 2026 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjC9J48w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379D6FC5
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551685; cv=pass; b=o9IuL/G0SNrElA7h+f3CphTnU5G8/RZKnRT0SHREttf5f0gWqxT0lDjbygf2sP/jq9Tqe/qZJtS5OkZOAJxyZ/ilDtLINg/djMRTobDv8ug2J/vNTB0i3r6D1bJiFmzmCf19SC2vjve3hUqNzLHayTdLBWzIKvw07b/1W/vDjz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551685; c=relaxed/simple;
	bh=8oVEbIDUEk9Gyjnp/XeZ/rXvvoOkJWJpO1ibutH9XdQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VKT7nmehTYBTnAYUsTo8y1/KFNhT86Spq0CZOY9Y0abdol8rl8GybbvqYDp51Swslb9LpnG4DebvRaQAu8RJETai2Wri2HE/mlxjQyyFYvVlF7uHArWhgBcb5NAWR6hnu1nEwKy14bGIPd9+GpvDShQf1e63lW+IJkCPFYSalnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjC9J48w; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3831c18b23bso14123621fa.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 00:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768551682; cv=none;
        d=google.com; s=arc-20240605;
        b=jkbO1xgv4lkBJV7peWn5CEH4fWzDiSrpTtbVdrVVCd/2gKjlADF9BGeAdmzETLdltT
         MY7y9jYqihETKya/CKX7f1uwvyzH9pqbg0x3tomQ5yYenXlZ/GJfCq9sA6Zy8wI3ZRYu
         YsiM6hlPkXCNDmRb90l8fx+ErcB8pJSKjgDKNIhUz8we3YjGx2+aqp3anjQLGB069cPP
         wemiuQONkOiqs3GYI5M+LaHQD0pSnhhGSeZBDFYG0Rx+Zw6FTW/t6ol4i/rMIhnmQn4X
         PKUumdHQg7letMqiSywyyVr8rTyyvHKXzRKwSImF30ZPL07ye7S6zl6oqksNjjKHMqfM
         RDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=8oVEbIDUEk9Gyjnp/XeZ/rXvvoOkJWJpO1ibutH9XdQ=;
        fh=IOI3BSFtc4S+mY5yRaEOyEQVEbaexZFmwOG7FNW1hpE=;
        b=WFXWz4gOQl5fyIxdOz1y17YkUr0cuQNZ6mkHGFEARzJekbhtkFTJhgsFAtF6q8JU8D
         poP3mIGgyP50m2sy4MnPWB6cOt/pxJfvK6sNsb4B7WNvXWfksqjwE3dlTm5uez17aCT+
         kkqqAwOxqcSJFHuFvh50/poJNsC9TRH7N2MBPgiQhLS9ajV7bf3tn1icrWGnWaXoeSJN
         k+dp3BmFflQx/MGcGgpUjcguSdtxp1zI9vpCjjqRz5Ky9spRQzcxaApPZf4zsazODplM
         gq5Nz104k30anvu6Bu0fwwI8kMHm2mMRFRBltAEUgFsMA67N15BN0ed2qqnv0oeT8rTy
         vdsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768551682; x=1769156482; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8oVEbIDUEk9Gyjnp/XeZ/rXvvoOkJWJpO1ibutH9XdQ=;
        b=RjC9J48wcjqNXvfZy9sQouVXu2AEnAbq+85dN3g1oDZ+RRCTe3QdCo+6KmqyuwfcQX
         vpP8UuHNgGeSS7BYmgNRexi6epHHvu/3Nki4HvVEK5qGvgM9lRWQaiQgFgvxrUdx/fKh
         pSL6vM+16VEu3SQUGMJgqRv0Y3fdOg9y+tlXsbxF/JgCvdNWPT50jYqGE+ud71z8J4v9
         H4NICVysrK9qw2B5h8Lgyb4deq+eQkV8dwGdvAokXxbd9D/IpG8GhHUdBG0Hk+BdTdhs
         XjG4imLcrPFdxjRaozYmfply/WJfEv5UnVIKQsvTlp3I82XJ8Z4xpXyCZqIYcmFL5JoG
         uCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768551682; x=1769156482;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oVEbIDUEk9Gyjnp/XeZ/rXvvoOkJWJpO1ibutH9XdQ=;
        b=DLXkz0TQKj+eVIRMyt+A1f+O3MYdUXQr90iEUY2SMBzzCRdFTMGR1dujmV0F5xawxp
         61S7opKPS3xyTXCXZwx1Jqkrsv3YW67/+4HbWT0aTDDaWjChDXWHD29Wsj/bnJlr1+Ea
         IK4O+yp6m85EDyKirvgaGrbUUVqJBtSexxdGsS3f5CHP+ALP84BtKaTPJEjSsgdin7wE
         GA8qjZJA0sI1LegGP4t7h/8hvLU9LweYST/RHkauhkeN25THY+5EkEgDYCbGyH4VOSM9
         u5MRo2ES2gpkJmTYekQ3G0qNHGg0xkDqNF61+qMMPYoVScpyYZChVDLIwax4r+FU4RCs
         8Czg==
X-Gm-Message-State: AOJu0YxebAELebbgDMBmhJrbGilZjFxoIx+gDpodyesjjHT2OPezj+VH
	OboOyNJYKAaAJtSOqK1r0xpFkHH3fcB0/Bkkc05FYNlNFBTHdqSJln5xN5uMFSjGwb/p6XR/W33
	6RBU0f3mPb075zIYpmgI3S1pCUL+rc3cQ4pjRL2g=
X-Gm-Gg: AY/fxX4xWWj9EkOREebnOXTOVGFGiLCSu3WxmMjQX3XRYCM4UNWMuYRromJpCH71aGv
	zpnG5P0GZ9K/X98YP+cgnYcIBZRhrfYN7XhEwh4vfqldrS1dW55Ixxstxue5BdVeNW6JR6FRl0J
	yzouEUFy0S3ledhQ9C3prurwWLaQxUwGnjvlc/26+ZH7WuWrE0LzLrxiIWfOtj/PyoaNbGyIMBI
	bwIxh9vzttSnV5hk+5jz0KutEqbCyW/pm99AOBh0bdtM99feA0RHivPM6iWDfWv7HYFI7itPLcq
	mnAI9bWK
X-Received: by 2002:a05:651c:b25:b0:383:1b7c:6d6c with SMTP id
 38308e7fff4ca-3838427c8cfmr9892781fa.27.1768551681454; Fri, 16 Jan 2026
 00:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xuancong Wang <xuancong84@gmail.com>
Date: Fri, 16 Jan 2026 16:21:09 +0800
X-Gm-Features: AZwV_Qh7m6K7ti9UmW6iG-ohvrCMD9gBxkfq6nRquXQ2PouL1ZyKJLx1grP_E24
Message-ID: <CA+prNOo6MA9rNyLLL4OP0tdU6+No74HCNtQ21R=yhFw3cu4mDg@mail.gmail.com>
Subject: Suggestion: last-mod index and journaling for handling Btrfs RAID56
 "write holes"
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Btrfs developer team,

As one who is managing a Linux server cluster, who needs to use Btrfs
RAID56 but is new to Btrfs, I asked ChatGPT about why Btrfs RAID56 is
unreliable and what are the failing scenarios. I would like to give my
suggestions here.

From ChatGPT:
```
1) The RAID5/6 =E2=80=9Cwrite hole=E2=80=9D (unclean shutdown while writing=
)

Btrfs RAID56 can leave a stripe half-old/half-new after a crash/power
loss, because it does not track which parts of a stripe made it to
disk, and it does not have a write journal for RAID56.
```

1.
To solve the half-old/half-new problem, I suggest we can add an extra
16-bit/32-bit integer counter variable to the stripe-header struct to
indicate the serial index of the last stripe-row update.

Use the following concrete example (4 disks, RAID5) to illustrate:
Assume 4 disks: A, B, C, D. Each stripe unit is 64KB. Then each full
stripe contains 3=C3=9764KB data + 1=C3=9764KB parity:
Stripe row 0: A=3Ddata0, B=3Ddata1, C=3Ddata2, D=3Dparity0
Stripe row 1: A=3Ddata3, B=3Ddata4, C=3Dparity1, D=3Ddata5
Stripe row 2: A=3Ddata6, B=3Dparity2, C=3Ddata7, D=3Ddata8
Stripe row 3: A=3Dparity3, B=3Ddata9, C=3Ddata10, D=3Ddata11

For Stripe row 0, initially the counter value (in []) is zero for all strip=
es:
A=3Ddata0 [0], B=3Ddata1 [0], C=3Ddata2 [0], D=3Dparity0 [0]

Then, after writing to B:
A=3Ddata0 [0], B=3Ddata1 [1], C=3Ddata2 [0], D=3Dparity0 [1]

Then, after writing to C:
A=3Ddata0 [0], B=3Ddata1 [1], C=3Ddata2 [2], D=3Dparity0 [2]

Then, after writing to A&B:
A=3Ddata0 [3], B=3Ddata1 [3], C=3Ddata2 [2], D=3Dparity0 [3]

If the counter overflows (exceeds 16/32-bit int limit), reset all to 0:
A=3Ddata0 [0], B=3Ddata1 [0], C=3Ddata2 [0], D=3Dparity0 [0]

In this way, you know which one is the old version (smaller counter
value) or new version (bigger counter value).

Take note that: since power loss can happen half-way through writing
the 64K block, it is possible that the counter value (located at the
beginning of the 64K block) has been updated but later parts of the
same 64K block have not been updated. So you might not always want to
stick to the version with a larger counter value. But you at least
know that those Stripes with smaller counter values (than the parity
Stripes in their respective rows) are more likely to be intact when an
inconsistency is detected in that Stripe row.

2.
To solve the "lack of journaling", we can reserve some stripes at the
beginning of every drive to serve as the journal. Append the Stripe
row indices into the journal before writing to the actual stripes.
During unmount, clear the journal. To fix unclean unmount, simply
verify those Stripe rows with indices in the journal. This check
should be done during every boot to avoid error propagation when more
data is written into the already inconsistent Stripe rows.

3.
During some massive write operation, the kernel should:
a. append to-be-written Stripe row indices to the journal;
b. write non-parity data blocks;
c. mark those Stripe row indices in the journal;
d. write parity data blocks;
This ensures that when a power failure occurs, maximum new data is
kept and recoverable. Moreover, it also tracks which parts of a stripe
have made it to the disk, i.e., upon a Stripe row inconsistency, if
the Stripe row has been semi-finalized (Step c is done), keep it and
recompute the parity; otherwise, use the parity to revert it back to
its previous version (or mark as corrupt when multiple non-parity
Stripes in that row has the same counter value higher than its parity
Stripe).

Thank you very much for your consideration and discussion!

Cheers,
Xuancong

