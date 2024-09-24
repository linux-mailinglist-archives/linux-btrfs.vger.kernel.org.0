Return-Path: <linux-btrfs+bounces-8181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B6983B81
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 05:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595961C22669
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 03:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C75E1A28D;
	Tue, 24 Sep 2024 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py5cph7B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BC1B85FA
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 03:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148196; cv=none; b=e/9+zfODaGiDAFbYgS2ItxkIYIYnReFaLcqXvHNROtFraxQQdb04KQVJDqxgf2VyLEMLN4WK/sl6Fk8lJ1Iw1fZB48W2fwgVXzzPuQxOMBvZC3ngnmTV6FvpIMTecD5hS619+kopWjOBKue3f63PIBGWbzrEz/t6YmVfr7cOjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148196; c=relaxed/simple;
	bh=KmnUPggPlinhrHpaweRANt4fUeWX9uQNiOl6gFv9Vbo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DokvntTnNCcHf2BGL9MgOMmq2JvmunVUGhv5TM6WuFeCnpQyka813n4cHEB62yix1W+MsjNxK7Tnw54oQK2hvO2BUjRbeGe57LaKBocks/K6pKaBxLQ+nY5B8vmk/xrewVsrAwY/cu1so4r7fiHBz3RZ6pQjzuHpxbl7FK6XYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Py5cph7B; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e5b5715607so516139eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727148194; x=1727752994; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DrMhE8l8SH7R1C7QQ91k73zg0ELZ9bnKl9hge9aUpV0=;
        b=Py5cph7BwZO6hjnB+r8jV3UB4rz4iGESFBP1CAFx3eWexh0zDqGWqbJ86bOiZCPRJT
         G2/tLbtrqMKwHuC7qxjdxkfMw2/dgRyoHpbNlUwkKWWASr2qEMIgac+iQiGtSI814Iiz
         WTq8gW09BWNYfgPVbVfbBYp+1+3OEyI+KPGXttRbTjZLzuGyJQTJg/yItXcCZPLcQIap
         pnHDfIFqg3yR5MDuJCtwcB1QHlSXbqBoZzTEzMAykYydxgRyIaQbs1G2VEaKkf4IRwWw
         9EWW4Xg+/pNTvARh4wsyAr+bp158+LxhnA/dnkarfHMpZZ+jNoT3tJ8NtQTWpfoVvgBK
         Kanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727148194; x=1727752994;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DrMhE8l8SH7R1C7QQ91k73zg0ELZ9bnKl9hge9aUpV0=;
        b=vvR9BF4YEhWXFTj77bKAIFjqHfVmGB6kmEE1lm6D4HelC/+byEeK+ECSLNSYQYSi4I
         hHflAz7KCuDxJLUThqYRDofok44AQrkyGTqzDdbGXa3o12K2CR7+rO5y2Nu1uJqe6T0S
         E1QwZGyFyigj4Mp7xtfd+yS20/PJahD9Rxv/SDNmC3/74HU7Ycex+hpSjKLiNAa0lmhA
         B/+7kT8Donr7z8jeaAuR2wMRa99SVo/W5CFvsbhPrITenMFBRJZQgmjuM4BR2a3TTlXU
         pT0dCuRowRLRnzx8odDnWFBwkPE6npcqqa7wRaRZ6X6IrxZnbOb933UTschGfwP7Wk3F
         UPxQ==
X-Gm-Message-State: AOJu0YzZSE6PEwu30gdXXDm6NCC1x0gLQBTiSr4soZGI8bLa/TqIkB7s
	2aiQ3BsXDnQXbncsNmaC+wLuQzTaDoOSheGrRPOmsxYmdcEa6O+9TghT+D2dBymCskS+eoEHHup
	LHEnbVGR8RvupdP03MTmwcjInHRF/X8VEM6g=
X-Google-Smtp-Source: AGHT+IFz7tZyOXmi/zepjDWgR5FTWCRGNp5FRKi5cEnfFUZjxn4vl74uOuD2r/sl9zua8vULQVbdkiuTwbYzkAKF7Jo=
X-Received: by 2002:a05:6820:161f:b0:5e1:cc7b:606a with SMTP id
 006d021491bc7-5e5b81af75emr1357871eaf.1.1727148193986; Mon, 23 Sep 2024
 20:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave T <davestechshop@gmail.com>
Date: Mon, 23 Sep 2024 23:23:02 -0400
Message-ID: <CAGdWbB4TvLV=6JNyk+m+R-bkec-y+GZo4MaaMK8cn=5ghf9Sgg@mail.gmail.com>
Subject: Filesystem corrupted
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. I hope you all are doing great today.

My errors, shown by dmesg, are:

    [  +0.000001] ---[ end trace 0000000000000000 ]---
    [  +0.000045] BTRFS: error (device dm-3 state A) in
__btrfs_free_extent:3213: errno=-117 Filesystem corrupted
    [  +0.000040] BTRFS info (device dm-3 state EA): forced readonly
    [  +0.000006] BTRFS info (device dm-3 state EA): leaf 253860954112
gen 33587 total ptrs 44 free space 7040 owner 2
    [  +0.000006]   item 0 key (227177136128 168 4096) itemoff 16165
itemsize 118
    [  +0.000004]           extent refs 6 gen 135 flags 1
    [  +0.000003]           ref#0: extent data backref root 490
objectid 426314 offset 0 count 1
    [  +0.000006]           ref#1: shared data backref parent
266540040192 count 1
    [  +0.000004]           ref#2: shared data backref parent
266489888768 count 1
    [  +0.000002]           ref#3: shared data backref parent
266355113984 count 1
    [  +0.000003]           ref#4: shared data backref parent
254191386624 count 1
    [  +0.000003]           ref#5: shared data backref parent
253776723968 count 1
    [  +0.000003]   item 1 key (227177140224 168 4096) itemoff 16047
itemsize 118
    [  +0.000003]           extent refs 6 gen 135 flags 1
    [  +0.000002]           ref#0: extent data backref root 490
objectid 426315 offset 0 count 1

[ many more lines similar to those ...]

1
    [  +0.000001]           ref#1: shared data backref parent
267180081152 count 1
    [  +0.000001]           ref#2: shared data backref parent
267147689984 count 1
    [  +0.000001]           ref#3: shared data backref parent
267079172096 count 1
    [  +0.000001]           ref#4: shared data backref parent
266967515136 count 1
    [  +0.000001]           ref#5: shared data backref parent
266640392192 count 1
    [  +0.000001]           ref#6: shared data backref parent
266567483392 count 1
    [  +0.000001]           ref#7: shared data backref parent
266540072960 count 1
    [  +0.000000]           ref#8: shared data backref parent
266504208384 count 1
    [  +0.000001]           ref#9: shared data backref parent
266489937920 count 1
    [  +0.000001]           ref#10: shared data backref parent
266355163136 count 1
    [  +0.000001]           ref#11: shared data backref parent
254357438464 count 1
    [  +0.000002]           ref#12: shared data backref parent
254230626304 count 1
    [  +0.000001]           ref#13: shared data backref parent
254217519104 count 1
    [  +0.000001]           ref#14: shared data backref parent
254191435776 count 1
    [  +0.000001]           ref#15: shared data backref parent
253777051648 count 1
    [  +0.000001] BTRFS critical (device dm-3 state EA): unable to
find ref byte nr 227177795584 parent 266504192000 root 490 owner>
    [  +0.000018] BTRFS error (device dm-3 state EA): failed to run
delayed ref for logical 227177795584 num_bytes 61440 type 184 a>
    [  +0.000017] BTRFS: error (device dm-3 state EA) in
btrfs_run_delayed_refs:2207: errno=-2 No such entry

The drive is a Samsung SSD 970 EVO Plus 2TB.

Overall:
    Device size:                   1.82TiB
    Device allocated:           300.04GiB
    Device unallocated:            1.53TiB
    Device missing:                  0.00B
    Device slack:                    0.00B
    Used:                        299.07GiB
    Free (estimated):              1.53TiB      (min: 1.53TiB)
    Free (statfs, df):             1.53TiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:              398.55MiB      (used: 16.00KiB)
    Multiple profiles:                  no

Data,single: Size:298.01GiB, Used:297.82GiB (99.94%)
   /dev/mapper/userluks  298.01GiB

Metadata,single: Size:2.00GiB, Used:1.25GiB (62.51%)
   /dev/mapper/userluks    2.00GiB

System,single: Size:32.00MiB, Used:48.00KiB (0.15%)
   /dev/mapper/userluks   32.00MiB

What is the recommended course of action given this error?

What other info do I need to share, if any?

Thank you!

