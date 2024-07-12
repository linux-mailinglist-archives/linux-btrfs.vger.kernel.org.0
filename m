Return-Path: <linux-btrfs+bounces-6432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D669C930097
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0576E1C21ADA
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 18:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4E1EB3E;
	Fri, 12 Jul 2024 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/Eo6d+4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251D18C08
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720810450; cv=none; b=CwGwY3onMz1t09mu9RY2GLGBqxmrdGQ/C3+vLbO6jgHPjvHVWe5Z0+HQjnOxCSIrAK/3vAJ7Pr3KVV7n89qNYxrulV0gQvlrJMKAWIZtwfMk0zzEJfjkzPEoiwFP4PV7dLZq/zEsLaqGJMsG5MQGIFBtEMemM7GEy39i0Synvqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720810450; c=relaxed/simple;
	bh=ffQM3vGgqr2wT79t/Fy4BxOFhUXFrbOEdmoyboX03uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4xYXhrszqmiDf1KBvNGKhIuSeXtpeKDCL1PI1nYD5ztBmodU7N7iVTWHN3858P1diS7wgFB0uGQMUx9I6JFFT8HxKZ0vD/tfT4LqErDYKB2Wmyh+SrixS8Od/dSZ10Vqn5i6X6Z5ZabWhJ8i9rbdshqTsYoyjTTBXZ5jV9YXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/Eo6d+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720810447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHN1yXsXhNTtMwBfy78FFvjn+qdaqe7touUL66E/bfQ=;
	b=g/Eo6d+46bmgSvm1VKlxI7za6pr/lzaxlD1SHwzjGNQ4I1l4Pp91LUKf3Ln1OCEWIVzJdV
	byT06S/uK3fua6n77TbN/4IiueGUptQixXJPt1+uJ5AXQRUt5LuQEHw+pXspBAVOSkc2Kg
	rQ4EZiIXMWsvnFszrhCBeCTlCpeojqs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-wTOxE6n7NzKVrdZ-S9cEDw-1; Fri, 12 Jul 2024 14:54:05 -0400
X-MC-Unique: wTOxE6n7NzKVrdZ-S9cEDw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1f6810e43e0so18559885ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2024 11:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720810445; x=1721415245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHN1yXsXhNTtMwBfy78FFvjn+qdaqe7touUL66E/bfQ=;
        b=Zgc8awKmPbdESyHGEfCsdPNrsiBF1PnW8++dKScXALZLHoCn0EpM/iRsvnrKMiw6lc
         +m7uCiCx1T1uTVdB5S8lF4B1JJRoLdWmuepERke4QDIWnhVLml3PJbGhEi+Y2L6LIpq/
         YWGOQ5hb3klUfIlQndsM+bbjDtj4OYlUpGjuvDW0N9zbC7hRbQgDT2qOnWwy/UrVKGKT
         g6xcaXxDx0NcLzkSjIe0QK7RWm0RSitiNmP2FjOKchFloJmGulZAOMu5n0hK+6oWMALE
         +uqV7cx9L9PrrGya9H66te7RS93F00vr2dXamaGV4eCCIPlPGi5S+CTp2QRte13cF0/A
         +APQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq9JFtcpvwMpjvJ/t22wWJe70xhXdQS2j0/s75bStgk+oWZA6HxnRiPra63t1lWPO/R3kveuQIPSIZs5s/r/xJOkI3pC1sm+VkgwQ=
X-Gm-Message-State: AOJu0YxNcnYOMOhsE0STcCaR9gjYvDxMHg4rcmC33cwB7dlTQzkiWnRz
	TEA0COA+U1B/s9fHsleRGM85gDpxK6V8k7CUsAQ/9QJVh/1p5JBzKcFII0J7HvaURTlBHvSXEsj
	Ge4nqjJSfNlgwPGg8Yd5qKThW67ajDaz9o2T03nI1jF6dqo2ZigxRg6oQMrB/
X-Received: by 2002:a17:902:e807:b0:1fb:53fb:2ce1 with SMTP id d9443c01a7336-1fbefb97e4bmr52468715ad.20.1720810444697;
        Fri, 12 Jul 2024 11:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7jsW8lQb6qdanHtFid3YqCp53atsXwrZRE07m3mnXkck31nNVxAWt4xiTXB/xzUEbaYO+pw==
X-Received: by 2002:a17:902:e807:b0:1fb:53fb:2ce1 with SMTP id d9443c01a7336-1fbefb97e4bmr52468495ad.20.1720810444280;
        Fri, 12 Jul 2024 11:54:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a12363sm70185245ad.39.2024.07.12.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 11:54:03 -0700 (PDT)
Date: Sat, 13 Jul 2024 02:54:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@gmail.com>, Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next v2024.07.13
Message-ID: <20240712185400.zwxazqdgjef4kmvq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240712164132.46225-1-anand.jain@oracle.com>
 <CAL3q7H4cmHXmJJP8-DoRKF-nQe_L+1rwutZ0BHGk5GMzujGAXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4cmHXmJJP8-DoRKF-nQe_L+1rwutZ0BHGk5GMzujGAXA@mail.gmail.com>

On Fri, Jul 12, 2024 at 05:48:58PM +0100, Filipe Manana wrote:
> On Fri, Jul 12, 2024 at 5:41 PM Anand Jain <anand.jain@oracle.com> wrote:
> >
> > Zorro,
> >
> > Please pull this branch, which contains a small set of fixes and a new squota testcase.
> >
> > Thank you.
> >
> > The following changes since commit 98611b1acce44dca91c4654fcb339b6f95c2c82a:
> >
> >   generic: test creating and removing symlink xattrs (2024-06-23 23:04:36 +0800)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/asj/fstests.git staged-20240713
> >
> > for you to fetch changes up to 8e0a68f2cbe9cc2698110ac85765a0c4681b290f:
> >
> >   btrfs: fix _require_btrfs_send_version to detect btrfs-progs support (2024-07-12 21:59:22 +0530)
> >
> > ----------------------------------------------------------------
> > Boris Burkov (1):
> >       btrfs: add test for subvolid reuse with squota
> >
> > Filipe Manana (1):
> >       btrfs: fix _require_btrfs_send_version to detect btrfs-progs support
> >
> > Johannes Thumshirn (1):
> >       btrfs: update golden output of RST test cases
> 
> Can you please include the following trivial and reviewed fixes too?
> 
> https://lore.kernel.org/fstests/6e7ee8ec1731b5d3d44f511b075fa2edb0b38661.1720654947.git.wqu@suse.com/
> 
> https://lore.kernel.org/fstests/bdbff9712f32fe9458d9904f82bcc7cbf9892a4b.1719594258.git.fdmanana@suse.com/

Thanks Filipe remind that :)

Hi Anand, I'll merge these two patches directly, especially the 1st one
which conflicts with another patchset I'm going to merge. So I'll deal
with them together.

Thanks,
Zorro

> 
> You reviewed the last one, but you missed it.
> 
> Thanks.
> 
> >
> >  common/btrfs        | 20 ++++++++++++++++----
> >  tests/btrfs/304.out |  9 +++------
> >  tests/btrfs/305.out | 24 ++++++++----------------
> >  tests/btrfs/306.out | 18 ++++++------------
> >  tests/btrfs/307.out | 15 +++++----------
> >  tests/btrfs/308.out | 39 +++++++++++++--------------------------
> >  tests/btrfs/331     | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/331.out |  2 ++
> >  8 files changed, 98 insertions(+), 74 deletions(-)
> >  create mode 100755 tests/btrfs/331
> >  create mode 100644 tests/btrfs/331.out
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
> 


