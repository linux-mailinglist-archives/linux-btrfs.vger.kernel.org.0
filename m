Return-Path: <linux-btrfs+bounces-18153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1FBFA87C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 09:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E0466522
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 07:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AA2F5499;
	Wed, 22 Oct 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUZN3I8j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1E2F6175
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117894; cv=none; b=np3JdYeqD4CH1d3mpQm+aX42D2i2RUg24EH4w45VLLlkPkjMeOpSVOs7OwClgYUSlSZcGC+pdiKS8n0uYkprHhIdTWFYvv6YVJoVfk+xxcEj0ewJkflLgEyAX3fYI1jz17qqCyxWVQDuv9aw3+EkA1cW6fdsnPiV4QJn62jnl/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117894; c=relaxed/simple;
	bh=ag90Y2BR02m8CKNuLog05D1n3/0xZjpIpFdsYa+Nx4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUhP7emG9AJayN1VxEBrJ6RAmF0rqrnqaJRdg8gS2MgrWfZ0U9f+GYXTPIvTti7+udcBK58KxqVQ/odPro6FBKT81Yu+jCGu2YxoB2eL8fzdxEtNjlxOJMtZHCQLm+4hjHinJlXsVy/zEYg3mdrDcTr1BlpuskcbhESosZMVk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUZN3I8j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761117891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVwn8249pzu95SHLAVwevQUrbZWYY25ucJvMVO/KqVY=;
	b=CUZN3I8jSvoALVk0Oy283sdQnIM4MSmZ7qLEZCywkZLFbSqZrSD0NZAIPwz6SffDiI3uuQ
	eKCRNyMSXg/EDUPYw6BFfMqtv+A971kunFsb9Yw5FNZU4t82Rau34woVh9a2RtQyZtohVs
	wQ8bpC442NMoWF86RsE3OR4NMjV4274=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-g7D0xSNCNKi_GlAH0kJoaw-1; Wed, 22 Oct 2025 03:24:50 -0400
X-MC-Unique: g7D0xSNCNKi_GlAH0kJoaw-1
X-Mimecast-MFC-AGG-ID: g7D0xSNCNKi_GlAH0kJoaw_1761117889
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26983c4d708so52250565ad.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 00:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117889; x=1761722689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVwn8249pzu95SHLAVwevQUrbZWYY25ucJvMVO/KqVY=;
        b=g+ORmxSIfjVH1TXGKesV00c3ibTRMQ9TYhOA9GeflXVXFKExI+MxtnST0SDBGV0Alg
         PxKMlG2tlBI0568Idv2YGdEobvwo4eOH3tTuz7kwUY7ZlySH2yFUqA3q0oxyZcqlytQc
         FDA40fALTVYI1CqW25d0B+Q5TcHwpHvtZRDa4vBEVMVZbaG1RA8PEraGwgnVssGm58zj
         sHvkZFM2/cT04YzVwyM+8CLOynbpGAc590IA+CC3IKcQvRNHnEzwqnU0t+9kAanxbWcp
         N5MD8brBMvTP81sPPdO4uLYHDMNsBzc7ULIZbNNYEunDLipB4EGAjIfObbHYKnaEEb5M
         z56Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGA8gcTDJqm36xJq6nkn7v4wISUGVEH8JCdRDmfOwK2XCNYi4acMqZANUgV4hzPpCaxSWt6FyjPhzWkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMPdls1iH8v/5pwJLTF8ilQTw5ZdH8tqyg2GsCR0eR7byE0xu
	c8Bfc4SK9hcYW7ENpRLmgwfzpmcqhqb1SOzzK3T7pcGS15LrE0QvrFUYcDWWqB4OmYbZLUBi0lH
	vLAU4fj1BNEuskQkGnPreTDrNRhSMsRBJ7IRjgYzZEC3Q6dGyEZ/Av2nTL4/oArwd1eablzfU
X-Gm-Gg: ASbGncswfmAgXMktdw+xTLND9nprl4l925x1/CAP8B7tRXw8ED6/yjkAjA75c81bZ1m
	H3M3jQa4A52P55iOYPWsL6XadqGpDON/XZpJGrFfBr1JqiZ7vxMg6Y9zMe4qlhpS6m/QaQTplMQ
	nRQt8uQEwyLH6stWLZpE2Y6+kTz/MjepKdkAjLG4B3wcM6LQeqd8Ck9qz0UeaqWHYAAyhN6lMDU
	SO7QRKzSaZQim90YP6AmxvKp1bVuytwIGmePEtjpBoR1SB1RO+rMCtnQpaMJHFUXlWTU4Wy10hx
	TdGWN863g1mtSh48+pyu29wH6BUEMPyeytgNWNXiCFUzfX7H7p2d1h+XuoZqMAUg6ucLOoqYJeT
	b2oc/BtC+MmfKJ4TIBCpsWBnHX1rr19fMA69O1so=
X-Received: by 2002:a17:903:b90:b0:290:bd15:24a8 with SMTP id d9443c01a7336-290c9c89fa6mr246065295ad.11.1761117888696;
        Wed, 22 Oct 2025 00:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhfzMzDq6/Kjb4xQKRnci/bNMzY8Sq1xEYjglYDluf2bxV5A7B4uVljY5aO/5sMrcovajCnw==
X-Received: by 2002:a17:903:b90:b0:290:bd15:24a8 with SMTP id d9443c01a7336-290c9c89fa6mr246065045ad.11.1761117888253;
        Wed, 22 Oct 2025 00:24:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d598asm129934835ad.63.2025.10.22.00.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:24:47 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:24:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251022072442.lnu5d7chvtqn6zuj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
 <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com>
 <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com>
 <20251021144920.GH3356773@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021144920.GH3356773@frogsfrogsfrogs>

On Tue, Oct 21, 2025 at 07:49:20AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 21, 2025 at 09:33:05AM +0000, Johannes Thumshirn wrote:
> > On 10/20/25 8:21 AM, Johannes Thumshirn wrote:
> > > On 10/18/25 4:05 PM, Zorro Lang wrote:
> > >> On Sat, Oct 18, 2025 at 11:13:03AM +0000, Johannes Thumshirn wrote:
> > >>> On 10/17/25 8:56 PM, Zorro Lang wrote:
> > >>>> Does this mean the current FSTYP doesn't support zoned?
> > >>>>
> > >>>> As this's a generic test case, the FSTYP can be any other filesystems, likes
> > >>>> nfs, cifs, overlay, exfat, tmpfs and so on, can we create zloop on any of them?
> > >>>> If not, how about _notrun if current FSTYP doesn't support.
> > >>> I did that in v1 and got told that I shouldn't do this.
> > >> This's your V1, right?
> > >> https://lore.kernel.org/fstests/20251007041321.GA15727@lst.de/T/#u
> > >>
> > >> Which line is "_notrun if current FSTYP doesn't support zloop creation"? And where is
> > >> the message that told you don't to that? Could you provides more details, I'd like
> > >> to learn about more, thanks :)
> > > Ah sh*t, it was a non public 1st version. It had a check like this:
> > >
> > >
> > > _require_zoned_support()
> > > {
> > >       case "$FSTYP"
> > >       btrfs)
> > >           test -f /sys/fs/btrfs/features/zoned
> > >           ;;
> > >       f2fs)
> > >           test -f /sys/fs/f2fs/features/blkzoned
> > >           ;;
> > >       xfs)
> > >           true
> > >           ;;
> > >       *)
> > >           false
> > >           ;;
> > >       esac
> > >
> > > }
> > >
> > > But as xfs doesn't have a features sysfs entry Christoph said, it'll be
> > > better to just _try_mkfs and see if there are any errors.
> > >
> > >
> > Zorro,
> > 
> > Should I bring that helper back so all FSes but f2fs, btrfs and xfs are 
> > skipped and then still use _try_mkfs so xfs without zoned RT support is 
> > skipped?
> 
> Except for zonefs, I think you probably have to try mkfsing the zoned
> block device to decide if the fs really works because the others all had
> zone support added after the initial release.

Hi Darrick and Johannes,

Oh, I think I didn't describe my question clearly. This test case needs the FSTYP
in 2 places:

1) Create zloop dev/dir on SCRATCH_MNT:
  zloopdir="$SCRATCH_MNT/zloop"
  zloop=$(_create_zloop $zloopdir 256 2)

2) mkfs.$FSTYP on the zloop device, and use it:
  _try_mkfs_dev $zloop
  _mount $zloop $mnt
  $FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx"

As this's a generic test case, so there're 2 questions from me:
1) Can all FSTYPs (on SCRATCH_MNT) be the underlying fs of a zloop device?
2) Can all FSTYPs works on zloop device?

Currently this patch does:
  _try_mkfs_dev $zloop >> $seqres.full 2>&1 ||\
  	_notrun "cannot mkfs zoned filesystem"
It's for the 2nd question. But _try_mkfs_dev does nothing if FSTYP is nfs, overlay
and so on. I think we need the FSTYP is a "block device" fs, right? Maybe we can call
_require_block_device or any better idea?

And, how's the 1st question (before _create_zloop), if the answer is "No"?

If the 1st question is "yes", but looks like the `_try_mkfs_dev $zloop` restricts the
FSTYP from being un-localfs (e.g. nfs, cifs, afs, overlay etc:)

Thanks,
Zorro

> 
> --D
> 


