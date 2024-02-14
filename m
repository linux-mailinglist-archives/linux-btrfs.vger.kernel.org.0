Return-Path: <linux-btrfs+bounces-2376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D248543E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 09:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792BB1C22350
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0794125BB;
	Wed, 14 Feb 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InfeG19v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670E125A2
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898489; cv=none; b=CQ4gobHoQfqSVDpho4zmpH2txayhP7EEXqHMSrYiwxBFqeS6IDvVl/o6r8muM/SgwzHnUyXc6Zxzw9sN/0WkjedGkC9GZxIcWvHPSK2TxAFmb+7pAywFSVYZXQPmCAtVZCzXLZA6XJhNuZVcJ0ZQNJlitTeLqg/nTGL0PraAqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898489; c=relaxed/simple;
	bh=PRDJ+cWbKCtaF3GZyiNLftrYKZkBS718rzMsmoMSq0I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OLKq/7QLUC4BdiMtMMDyqP45QZzUtmGV6R8dADMd/9sQdLLgbaRmxgN37tuD9Us0KZQV/NEwx0M7M21rIrYwBn8xSzRQKAD/+1mFTk2okw2VFCkRnADT8ARPUKW3OVyDoWmjlCnMqFir7rgukh1t4ETJMhDvlcNQmgUT4jhXWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InfeG19v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707898486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=uaq9NTMKNFZU9RvRPgGMtW0L8oW9UmO1CeO5zzMSwww=;
	b=InfeG19v4yDAfIyN9xT8wklv7fN13/kgLj2siiJ+Mkw5oq0ZWB7NaEbd6eldsw3gSMpTmK
	Rgb2xSQ8VaiBy4Vfp8cXcJyI0wyELB6colK2XjLOiIFq+AHTkQTSdIU0Epgm5H7uG2aclz
	PMPGiWrhivWt+o5k13m4HqXg94OxEwQ=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-fHdC0xBbOMucVVe1zpSNsQ-1; Wed, 14 Feb 2024 03:14:45 -0500
X-MC-Unique: fHdC0xBbOMucVVe1zpSNsQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c031a2debdso6166867b6e.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 00:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707898484; x=1708503284;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaq9NTMKNFZU9RvRPgGMtW0L8oW9UmO1CeO5zzMSwww=;
        b=AAORend70SRM7yuA30R9U5PXhIAJevoIDXCaz2lp9K/RoYpvvauH7yqzjM+TXlYr7L
         JOUz9G29Xkmg50kAAOnLOrHI0z1LQ1c9r1VwECTcq04oM/qofrizQepFI8X2YBRRisEP
         jOjymOOf8hEyUe7cpcfo6OZliwt2tJ2ViciYhcu2Ko4Q+yjPFa7lh21WEkzVdsdwT9nO
         d93FMjkdRCKBoJUQ3ZzuzQPJqFQY+7Mj+hru9fVtPnbw68whhemfLZApLSV3W5K455qm
         4LPnTOpGWX5zu/Wf8g0BeWORub5W5ZwKqY3mPW9V0Dqk+6H503GMwj9pmfZzPqp6++re
         2S9w==
X-Gm-Message-State: AOJu0Yw+gPtD9KGRbIMegAeFjTDOtmZ0dpFp5XrT24GmrvHmbSeAsQc3
	r1USRkAgMMubxqxmeDAKrYRZQsd/I1rKN8dnf3/vvUHkF0RuMzpcUFuselPl8VnUjXH482EWYUn
	BGEuKRQ5K0MRyjUHPHOp2mYjIYQOBaYDMJplxZzWSk6Hfs4e/xVhISI1hGo3uFL8hIrFVRalkFf
	Oh8C6+WWRqLN/2dWLq/VZQvhq2pLxXzy/70YHd5A75Io4WTuLz
X-Received: by 2002:a05:6358:7f0a:b0:17a:d4c0:d59f with SMTP id p10-20020a0563587f0a00b0017ad4c0d59fmr1533510rwn.4.1707898484022;
        Wed, 14 Feb 2024 00:14:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpAMOad+9NNLTf0WMMxi7wp4TaPuL87WQwJdHQ528tg21J3YsO4+Scs6j0I8rcRtNvNzl9m4iNY6A5kTfx7Hw=
X-Received: by 2002:a05:6358:7f0a:b0:17a:d4c0:d59f with SMTP id
 p10-20020a0563587f0a00b0017ad4c0d59fmr1533494rwn.4.1707898483673; Wed, 14 Feb
 2024 00:14:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 14 Feb 2024 16:14:32 +0800
Message-ID: <CAHj4cs_UXGQMwNHgbhw12qDHq_B44bUwiNGkN4unzxc8XqfkdQ@mail.gmail.com>
Subject: [bug report] kmemleak observed during blktests nbd/009
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I found below kmemleak during blktests nbd/009 on 6.8.0-rc3+, please
help check it and let me know if you need any info/testing for it,
thanks.

[17763.119952] kmemleak: 12 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)

# ./check zbd/009
zbd/009 (test gap zone support with BTRFS)                   [passed]
    runtime  18.716s  ...  18.763s
# btrfs --version
btrfs-progs v6.7

unreferenced object 0xffff8881511c53b0 (size 192):
  comm "mount", pid 52857, jiffies 4311808306
  hex dump (first 32 bytes):
    b0 53 1c 51 81 88 ff ff 00 40 1c 51 81 88 ff ff  .S.Q.....@.Q....
    00 00 00 00 00 00 00 00 02 00 00 00 01 00 00 00  ................
  backtrace (crc dcabc4f4):
    [<0000000097edeb04>] __kmalloc+0x3e7/0x520
    [<00000000288772fe>] btrfs_alloc_chunk_map.constprop.0+0x20/0xa0
    [<0000000031efcd2f>] read_one_chunk+0x284/0xb80
    [<00000000e2b85033>] btrfs_read_sys_array+0x24c/0x3d0
    [<0000000003714897>] open_ctree+0x1b0b/0x4be0
    [<000000001f5e8ac7>] btrfs_get_tree+0x101f/0x19d0
    [<0000000088ba3feb>] vfs_get_tree+0x8d/0x350
    [<000000001f72c23c>] fc_mount+0x13/0x90
    [<00000000c75588a6>] btrfs_get_tree+0x91d/0x19d0
    [<0000000088ba3feb>] vfs_get_tree+0x8d/0x350
    [<00000000706df581>] vfs_cmd_create+0xe1/0x290
    [<000000004d6ccd48>] __do_sys_fsconfig+0x607/0xa90
    [<00000000c1740ec7>] do_syscall_64+0x9e/0x190
    [<0000000014a2c6d4>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

(gdb) l *(btrfs_create_chunk+0x11b2)
0xffffffff822bd922 is in btrfs_create_chunk (fs/btrfs/volumes.c:5544).
5539 u64 type = ctl->type;
5540 int ret;
5541 int i;
5542 int j;
5543
5544 map = btrfs_alloc_chunk_map(ctl->num_stripes, GFP_NOFS);
5545 if (!map)



-- 
Best Regards,
  Yi Zhang


