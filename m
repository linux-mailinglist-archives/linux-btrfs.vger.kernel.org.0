Return-Path: <linux-btrfs+bounces-17318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769C0BB1B4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 01 Oct 2025 22:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4721A3B1A79
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Oct 2025 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A572F2D7384;
	Wed,  1 Oct 2025 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FX6q/nzr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09202882AA
	for <linux-btrfs@vger.kernel.org>; Wed,  1 Oct 2025 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351822; cv=none; b=WrNJGnigr2NJNlMKpklZU/jz/vkZOnfUlIlsXGiRVRBM6ROqVJOniiEKoMxYP9FrDsuPoSLvHUp9j/KUabPMxPUMB9obLOQUAnrKMh00K6JgJXWBh88trcQ3dOh73faEwdywWOPhfvv71Dw97pXLqUiXoGkJrqij9r5GCIFbfq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351822; c=relaxed/simple;
	bh=gBW9n3UmTPGAQUDi+gbNyfb55lgWozTxwk93rb0G4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1tMGGJrEzOZ+jys+l9T53klIk7VxKS1VhQBnxdFa3JfigqGgXOXuY+AzXoJLj8NMn+brNeTA9/cm/hhoK596zVOuhH15AWiiGEgBeZLFHzVAfFS4DtSxG7HbuTDkban8js5cIBQZzpD27Un3M8iNOLaPz5wHLPlR0lB1LgAmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FX6q/nzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759351819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU4OUGmDueHDubH6UYEl/dqcmZLyHQrJAoBxNBC66X4=;
	b=FX6q/nzrMuhKjJlxblMX0NvdLTrNbB5TOmKtCropl+/d/WXkC5WddOmmkCZGsFKnTbSQdS
	axeqYrjaj3BAnAZUmmQ2ovOtzzkxTj+18Vw8kbxyonqiQoZGk5lJxnMglIMQcQOjTsIsmK
	5/GZkFkaepd95KLrMnwX4qbjiDTqrcc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-DBF2nbfmMQO6nHaEFjAB0g-1; Wed, 01 Oct 2025 16:50:17 -0400
X-MC-Unique: DBF2nbfmMQO6nHaEFjAB0g-1
X-Mimecast-MFC-AGG-ID: DBF2nbfmMQO6nHaEFjAB0g_1759351817
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810289cd5eso537311b3a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Oct 2025 13:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759351817; x=1759956617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU4OUGmDueHDubH6UYEl/dqcmZLyHQrJAoBxNBC66X4=;
        b=EHuP4BRBo9swcChijfoELjLxHV0cAlSo1lrlcAEhQG+TprfmIBBrbK4aekV3eKffwO
         MB7zCrvc63YXDwd0OLTqgzPQjUkGbF5D0ex9Tkw7k3UVhXf0ejsy3Fh0vQifxOwr255Q
         nVoEjrJUn8jTTiKbT5StSxYmHhWx4GvjcBmp8qszw6nVkepTQVW7pDU/ZfvaEx4V6M2O
         hf2KNCNkBsjyV3YbE+tZb8qjwko/lXRre1aO4KIEvDgp5ZbE+h8uZ7Jt3/1TjPeDmikR
         BlpwdvoZAf37lvNZnkuvNBV+3pN5/aMjeGokUGSwgwVO85zaOFNl4lvdE6+Gr5ZqxZAh
         O7rg==
X-Forwarded-Encrypted: i=1; AJvYcCVsOnCREo/Jy0zg2W9NSw94PWubDqS8WTk/9plHF3jQPDFPDVU9xboJpsmlhAYFOdD9RYlKTKEYLkj1SQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/t53pXR6Hvne524FfQzRbAVSHPaeyRRndYM4qElIthQgVGv2T
	h8QQO/k38Nk447G9oRGY3WbdguPYMacmVsLKhPx+/u8ZE1gTI9Qnh+jXm+04lRMLolojYI47ONJ
	YIjphKfLygEEF69GU+Jgv7YYQmOXBJKNCTZ6Df5bjcQxC4GTn53JC0wvwP+bEAu7a
X-Gm-Gg: ASbGncu3ME2E66N8DJkrf9t7anVmqADKQ0kmjD1EBE0ZbROo8/K+8qc5KlZCndiFR0p
	8OPIsw+cOVoywHe8iSltZVBdmNIplkNxt2eZmAHC+pLOw6lkB7cW/tpNSiYRvI2j8Q1/DbEaPUC
	+ySG5S5UhAg5OTxk3UnAB53VowXoWfKKV+KXc+vD7dqjIM/WFYh/bTnIdlYwoMcUwDV5uepjh9S
	A2KQ/x1X/dTMrktFggbrRzNAeRud2sHSwciJI8Uuhv7gmqkKRmODVXLSupYp0GdNFKAf3VvwTCj
	3cXKvm+QRGewMupYYwCvWLFab2EOMSEpGpliebX1LYbn+5RDniTBmmDe6Pzt3/PittHfrWomvgp
	V5GrDveqV8Q==
X-Received: by 2002:a05:6a20:9143:b0:246:7032:2c1d with SMTP id adf61e73a8af0-321d1e6274bmr7130198637.23.1759351816468;
        Wed, 01 Oct 2025 13:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGod+bCznb818N+m/C20fkkTWwDBMqUXtmxkwzz5AMzxnmucX2zTYVkikM9vyHpeXECWzMLdA==
X-Received: by 2002:a05:6a20:9143:b0:246:7032:2c1d with SMTP id adf61e73a8af0-321d1e6274bmr7130165637.23.1759351815891;
        Wed, 01 Oct 2025 13:50:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4cfbesm375872a12.28.2025.10.01.13.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:50:15 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:50:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't
 support the block size
Message-ID: <20251001205011.dgi6w3fr5udkcx55@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-2-wqu@suse.com>
 <20250928145453.wyztv2kvfpgmlw3k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <471b4e77-a89a-4cc2-aafe-0c04e36036c9@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <471b4e77-a89a-4cc2-aafe-0c04e36036c9@gmx.com>

On Mon, Sep 29, 2025 at 06:12:17AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/9/29 00:24, Zorro Lang 写道:
> > On Fri, Sep 19, 2025 at 08:13:25AM +0930, Qu Wenruo wrote:
> > > [FALSE ALERT]
> > > When testing btrfs bs > ps support, the test cases btrfs/012 and
> > > btrfs/136 fail like the following:
> > > 
> > >   FSTYP         -- btrfs
> > >   PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #285 SMP PREEMPT_DYNAMIC Mon Sep 15 14:40:01 ACST 2025
> > >   MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> > >   MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> > > 
> > >   btrfs/012       [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/012.out.bad)
> > >       --- tests/btrfs/012.out	2024-07-17 16:27:18.790000343 +0930
> > >       +++ /home/adam/xfstests/results//btrfs/012.out.bad	2025-09-15 16:32:55.185922173 +0930
> > >       @@ -1,7 +1,11 @@
> > >        QA output created by 012
> > >       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
> > >       +       dmesg(1) may have more information after failed mount system call.
> > >       +mkdir: cannot create directory '/mnt/scratch/stressdir': File exists
> > >       +umount: /mnt/scratch: not mounted.
> > >        Checking converted btrfs against the original one:
> > >       -OK
> > >       ...
> > >       (Run 'diff -u /home/adam/xfstests/tests/btrfs/012.out /home/adam/xfstests/results//btrfs/012.out.bad'  to see the entire diff)
> > > 
> > >   btrfs/136 3s ... - output mismatch (see /home/adam/xfstests/results//btrfs/136.out.bad)
> > >       --- tests/btrfs/136.out	2022-05-11 11:25:30.743333331 +0930
> > >       +++ /home/adam/xfstests/results//btrfs/136.out.bad	2025-09-19 07:00:00.395280850 +0930
> > >       @@ -1,2 +1,10 @@
> > >        QA output created by 136
> > >       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
> > >       +       dmesg(1) may have more information after failed mount system call.
> > >       +umount: /mnt/scratch: not mounted.
> > >       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
> > >       +       dmesg(1) may have more information after failed mount system call.
> > >       +umount: /mnt/scratch: not mounted.
> > >       ...
> > >       (Run 'diff -u /home/adam/xfstests/tests/btrfs/136.out /home/adam/xfstests/results//btrfs/136.out.bad'  to see the entire diff)
> > > 
> > > [CAUSE]
> > > Currently ext* doesn't support block size larger than page size, thus
> > > at mkfs time it will output the following warning:
> > > 
> > >   Warning: blocksize 8192 not usable on most systems.
> > >   mke2fs 1.47.3 (8-Jul-2025)
> > >   Warning: 8192-byte blocks too big for system (max 4096), forced to continue
> > > 
> > > Furthermore at ext* mount time it will fail with the following dmesg:
> > > 
> > >   EXT4-fs (loop0): bad block size 8192
> > > 
> > > [FIX]
> > > Check if the mount of the newly created ext* succeeded.
> > > 
> > > If not, since the only extra parameter for mkfs is the block size, we
> > > know it's some block size ext* not yet supported, and skip the test
> > > case.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/012 | 3 +++
> > >   tests/btrfs/136 | 3 +++
> > >   2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > > index f41d7e4e..665831b9 100755
> > > --- a/tests/btrfs/012
> > > +++ b/tests/btrfs/012
> > > @@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
> > >   	_notrun "Could not create ext4 filesystem"
> > >   # Manual mount so we don't use -t btrfs or selinux context
> > >   mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> > > +if [ $? -ne 0 ]; then
> > > +	_notrun "block size $BLOCK_SIZE is not supported by ext4"
> > > +fi
> > 
> > Hmm... the mount failure maybe not caused by the "$BLOCK_SIZE is not supported",
> > I'm wondering if this _notrun might ignore real bug. How about check the
> > "blocksize < pagesize" at least?
> 
> The only extra parameter passed to mkfs.ext* is "-b $BLOCKSIZE", and if it's
> really some bug inside e2fsprog and it only affects bs > ps, we're still
> going to miss the bug.
> 
> Is there any proper way to reliably check the supported block size of ext*?
> Like some sysfs knobs?

If there's not a proper way to check ext4 supports LBS, how about check
blocksize < pagesize" before _notrun directly, e.g:

  pz=$(_get_page_size)
  if [ $? -ne 0 -a $BLOCKSIZE -gt $pz ]

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > >   echo "populating the initial ext fs:" >> $seqres.full
> > >   mkdir "$SCRATCH_MNT/$BASENAME"
> > > diff --git a/tests/btrfs/136 b/tests/btrfs/136
> > > index 65bbcf51..6b4b52e4 100755
> > > --- a/tests/btrfs/136
> > > +++ b/tests/btrfs/136
> > > @@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
> > >   # mount and populate non-extent file
> > >   mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
> > > +if [ $? -ne 0 ]; then
> > > +	_notrun "block size $BLOCK_SIZE is not supported by ext3"
> > > +fi
> > >   populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
> > >   _scratch_unmount
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> > 
> 


