Return-Path: <linux-btrfs+bounces-17972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54ABEB307
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89636742FF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832ED31BCAB;
	Fri, 17 Oct 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5xA+z7D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B92FFFA0
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725278; cv=none; b=trO3syN7/qSZ0n9a1WZqcgh9fBUN9m7xCNtiPKtQLCZ8At2aU01OECQd1XxDOGDBndn+qIpDh4ZOuKaqLiSWO5LNfbzxrHEwSfL6xdsBMF7wLXacd/OWPetY2dK32o6WEPgDH1BlyFd5R8+52xvDQLuWscA+z79uTwwvEWd/ra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725278; c=relaxed/simple;
	bh=7V1vGZUMugbyY3uXC6TbIVNvUYRpBHUPf3OG4A8s66k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DguWMLvgMR4BQteH7cniLnRiYvcAEphOknIIFucVcz+woVeFKmuwuIxix7jj7VTvSN/z8pdzdBLAgySotGvB0DE2UCA5vPlOI23oC64VciyJhTpezhmAbJgDugejBdkr9kRunMZX5Xvf7H3e0+zEMb6jQ85KutZjz+pXBRVYlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5xA+z7D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760725276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2b5Eht+PGQqCXGcdNOYyGJBasTFeEXQyNAzPsfbNKj4=;
	b=D5xA+z7D96TzSQVX++qIEck5cPGha/iiHarIWDyug92+/7He6StL1cnLFvgO5yRYCzynk4
	JwRW+Pcm0/qt2SE/kUa4Ae6GW97/0/Y9kbyavol7ThjU+g8ewy19yK/8araV/n3wkSYtRv
	hEwlr4nrW8XgGoGwETvL1QbtioT5cjc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-3Svesua_OA-lbhVt7tH8rQ-1; Fri, 17 Oct 2025 14:21:14 -0400
X-MC-Unique: 3Svesua_OA-lbhVt7tH8rQ-1
X-Mimecast-MFC-AGG-ID: 3Svesua_OA-lbhVt7tH8rQ_1760725273
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso1943638b3a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 11:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725272; x=1761330072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b5Eht+PGQqCXGcdNOYyGJBasTFeEXQyNAzPsfbNKj4=;
        b=QFsgZtOdiJHFOu+mFX//aIENONmvQ0XdCnfP0SJeTI56X9WZ7B6KrJqVocihdXrwmn
         fPAIDZXyN9ris2gVYxLo4PUZKLF8AoQ5afDvm5GXDNv87v+y0isiuuoapxIh75ai2rDa
         Ygdi53ikSCXVOeT7EaRCtUKVeyQ7CD7CzCI5djzxB0ZjfbjVfjnwF2o73zL5qLNO/w2v
         YhWT3ybscteh6Spb8p+bLjJ/FxbXD8I5AICFiJe4LHmoKf27XGshczW4AmzWw6TZ3pd0
         vB9LuWet2dcGF1fXPY9LlFAR0PeeTfZHZ43HtTujpcNIwRr9xz9G+qnTai2k84yuVllm
         blKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlQ7uls9kszgw5Qpy4U4TNz1ttuw0UCuIw4LYoa0hkR7M5WUCZfs60Q/IQ1KoeL1X6h0cqisneOjaqLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTIfs7TnCLWtD1RI4She9IU295LTNHHCG5luBUjDLemvtNaX2
	0Ix7aR+pxIBwYkfnAE10SYKJP/oKUTJOkEhJwsYz7EObCGfZg6NNssWfmbXRTtYH5l00JP4X2mk
	K79wu8unVfeA14OSWVVqNgznV9xeAGySfLVp19HrWvFGiHxz14IxXARw79qlJXXKn5LUL29qk
X-Gm-Gg: ASbGncvkEhwqeRbg2oKYE9Ptu/5j3lyjYeZqbcRh84v+6CFBkB6I4gmv+DIxIT8G7rG
	nPCMnd2SIuDwbVGI9lkJwRR9kxzfEY5q7e0oXREDJJ7S2bScqfINfd2/RQSFoiHaa8M7Q6sOJsM
	hHP42K8PLdfKWgjVayndgTut03/zx0PPm9f5YnrLX/jH3lJ6ORw97NqNKEFK3Ypm+Z1kpm9T8FD
	ubd0bTD1MJVHop3eMz299UAIxytMBFKE+VCZ4QVfljhAqGk8GIyNUZAKpHXED/qU9/9QcheSJhM
	VzMqYPCmTNi9I72x0L5Ja7sOXMwpBsNkkT98l6CP/UxkpSmPnOA2jBQqiaX9HByuy1hDaShim59
	HSQLYRd9yui3ZrQ5b0wlVwQT91dCXNRJBUrETdm8=
X-Received: by 2002:a05:6a20:e212:b0:334:a2ed:5fa0 with SMTP id adf61e73a8af0-334a8610906mr6437818637.28.1760725272232;
        Fri, 17 Oct 2025 11:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETRSHCSGN92yC7zInJ3ldq9DBraMV4qDWpiqi2ZbNnHTstihrlPnjlLoY1XjVFIMXYjRV9IQ==
X-Received: by 2002:a05:6a20:e212:b0:334:a2ed:5fa0 with SMTP id adf61e73a8af0-334a8610906mr6437781637.28.1760725271534;
        Fri, 17 Oct 2025 11:21:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121f96sm212076b3a.76.2025.10.17.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:21:10 -0700 (PDT)
Date: Sat, 18 Oct 2025 02:21:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Message-ID: <20251017182105.lrmx2f6ylt2jnsak@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
 <20251006132455.140149-3-johannes.thumshirn@wdc.com>
 <20251017145742.thvvkyk7qafi4aju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017145742.thvvkyk7qafi4aju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Oct 17, 2025 at 10:57:42PM +0800, Zorro Lang wrote:
> On Mon, Oct 06, 2025 at 03:24:55PM +0200, Johannes Thumshirn wrote:
> > Add a basic smoke test for filesystems that support running on zoned
> > block devices.
> > 
> > It creates a zloop device with 2 sequential and 62 sequential zones,
> > mounts it and then runs fsx on it.
> > 
> > Currently this tests supports BTRFS, F2FS and XFS.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---

Please ignore this, I checked the old version.

> >  tests/generic/772     | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/772.out |  2 ++
> >  2 files changed, 54 insertions(+)
> >  create mode 100755 tests/generic/772
> >  create mode 100644 tests/generic/772.out
> > 
> > diff --git a/tests/generic/772 b/tests/generic/772
> > new file mode 100755
> > index 00000000..412fd024
> > --- /dev/null
> > +++ b/tests/generic/772
> > @@ -0,0 +1,52 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test 772
> > +#
> > +# Smoke test for FSes with ZBD support on zloop
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto zone quick
> > +
> > +_cleanup()
> > +{
> > +	if test -b /dev/zloop$ID; then
> > +		echo "remove id=$ID" > /dev/zloop-control
> > +	fi
> > +}
> > +
> > +. ./common/zoned
> > +
> > +# Modify as appropriate.
> > +_require_scratch
> > +_require_scratch_size $((16 * 1024 * 1024)) #kB
> 
> _require_scratch_size contains _require_scratch, so you can remove _require_scratch.
> 
> Can you explain why we need 16GiB free space for these parameters?
> 
> > +_require_zloop
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +
> 
> 
> > +last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
> > +ID=$((last_id + 1))
> > +
> > +mnt="$SCRATCH_MNT/mnt"
> > +zloopdir="$SCRATCH_MNT/zloop"
> > +
> > +zloop_args="add id=$ID,zone_size_mb=256,conv_zones=2,base_dir=$zloopdir"
> > +
> > +mkdir -p "$zloopdir/$ID"
> > +mkdir -p $mnt
> > +echo "$zloop_args" > /dev/zloop-control
> > +zloop="/dev/zloop$ID"
> 
> About this part, can we have a common helper (e.g. _create_zloop_device) which
> can get a free zloop number and create a zloop dev, then output the device name
> if it's created successfully ?
> 
> > +
> > +_try_mkfs_dev $zloop 2>&1 >> $seqres.full ||\
> > +	_notrun "cannot mkfs zoned filesystem"
> 
> As this's a generic test case, I'm wondering if the zloop device can be created
> on any FSTYP? For example if FSTYP is nfs or cifs or overlay or tmpfs or exfat
> and so on.
> 
> > +_mount $zloop $mnt
> > +
> > +$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
> 
> Do you care about the return status of fsx? If so, you can use _run_fsx or run_fsx.
> 
> > +
> > +umount $mnt
> 
> Please make sure "the $mnt is unmounted" and "all zloop devices are removed"
> in _cleanup.
> 
> Thanks,
> Zorro
> 
> > +
> > +echo Silence is golden
> > +# success, all done
> > +_exit 0
> > diff --git a/tests/generic/772.out b/tests/generic/772.out
> > new file mode 100644
> > index 00000000..98c13968
> > --- /dev/null
> > +++ b/tests/generic/772.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 772
> > +Silence is golden
> > -- 
> > 2.51.0
> > 


