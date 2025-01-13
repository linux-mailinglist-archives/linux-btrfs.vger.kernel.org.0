Return-Path: <linux-btrfs+bounces-10936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9C7A0B80E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 14:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4B91634A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFE120B22;
	Mon, 13 Jan 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFLhbPPC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85717993
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774675; cv=none; b=Fc6cG/M8c6XfduCMriMv/nPsqjyO0BC5vcDdY5uWFuo1v6KCdw3dAmYQCKLTTOFijUMq5OmP6flhO4F3DsQLFqVgc1V1Y0bUkodUgmP4U6rvpp+dBjzakN5Lz7z5GWuOzvXDgQPxkXB8JINffKJRKvQ7CN0YqaT4XWpX+QIjtjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774675; c=relaxed/simple;
	bh=b6vJsQhv2fOrs/Xp6ID4EaLOyerDw6q4LHmMqhWMkP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWzvye6WrDzyBmtbX1gzD0x2pPIedmeyBcy7hr7H0/jjrvrTusVg8rAxYpLxcad7QIOpdeCW57w7Qzurxhf771Fy0Ov0fNYwLCbWSu+fdb6h+ZzrR42vJBgI1medTS63KuudwauD/5ZYEGw1Ico7BxfWVezk1fG3RDVCN7rMUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFLhbPPC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736774672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yf0rsNp3vB2Ria237LOeGIQXHqbUdQf5YPxQ8mR7Y3A=;
	b=FFLhbPPCzjt7yMVProZ/6s7pUJg/+DpxDow16d6qBU5ZkmhYTUAMqO/WdRbYfp2MNff4Cu
	wckf46osbyWluzVQ4j7aK2BlPYG8OmKP7ZdY4fqG9SEGO3Yw8qMb4Rntluc6lv+MZGrtIs
	cDD1A225/rz04NkwNATwL/H67GQYn4M=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-88g-cTIaPDOtRMLLMRRV0g-1; Mon, 13 Jan 2025 08:24:31 -0500
X-MC-Unique: 88g-cTIaPDOtRMLLMRRV0g-1
X-Mimecast-MFC-AGG-ID: 88g-cTIaPDOtRMLLMRRV0g
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216266cc0acso83995215ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 05:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736774670; x=1737379470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf0rsNp3vB2Ria237LOeGIQXHqbUdQf5YPxQ8mR7Y3A=;
        b=vNyCWR2o7qypE0YmvKfFGxNsfiCQE5sC2MurTS6uwgWnzlBDl5BEidw+4MsPER0G20
         N61p14S4xxFiRvGI139OkRHiIEhSU0/KL0IJWlNSlPQ0SjTqMkJUMrsFHwvirSgpNXH1
         VMfa/vGLDOlMdBm3WqJXJo7WYmIjOoRz53sSS6Y/12JXXQiScXsgePJqGpbr1PGDBJvh
         pFGREq/iPvvtrW2d1ku8OXKl8GrcPRqFtHUoiyq+rE4dbYYQU/RRnI9yc//4L/fV4GTk
         Ik38rOOcq2PerV0Dz55IdWQ+uj57E5WJaHGK0behyHriU9Z0M56Gt7LLCkT+0GuD20SB
         eKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzNNRU0ISeTt2yWa7lR01OrSDDlTgYq9PHEhPHk/pCYHaGWWExiAHqm+YVq0pQJJencZCsMA1359ZEUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvqgghHquMPyAXCMqU4cRVQe4y9IuIabiRKm7YC/7q6Hso7re
	wBVTj++wqLlzg2zr6uwGiUFfobvivJvA2T0ZUnx3Qdy7gRWTsCRBtZ8uXunRFoiSF2Br9X/T4en
	PZHVc+pasiY9jYhofjZByEDASM5OJJuNUHaMRhKj9C+sKV0qZ+tY4RJSulQPh
X-Gm-Gg: ASbGncs+9LQ/22RJdxTsUjKz3p4Dbf5IJc78BcWKaUqkS4UV3uS4UksrNofAF6bSoD/
	msaVHC4AgOCFcl3CjaFTBaxD0dmia0YSpWJgYXTWHY1prRHG62jWCBom2vycSouydgYDzoL9//m
	Tziq/qMwec92cXTClexuisDIkVWdirewJcKduPw9l56mT9KZN2YhDhNcS2Nz9WDJ3IH2BpAEIAg
	tzVFDUcUX1B8kCb9BNT4wMalOmgy402r6jvHafm79LiY8YGAD9vT8NM+794PppnVjai2AV2vs3i
	bl84BZwpUuzIkoBKCEifwg==
X-Received: by 2002:a05:6a00:8d8e:b0:725:4301:ed5a with SMTP id d2e1a72fcca58-72d324995b4mr25243660b3a.2.1736774669910;
        Mon, 13 Jan 2025 05:24:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkxBQhOmyi7HwPrS3cRarRyV8tRxl/8AcFFMf/x+Ywsac25U0IBSwW6qzTguYS94cznidb7Q==
X-Received: by 2002:a05:6a00:8d8e:b0:725:4301:ed5a with SMTP id d2e1a72fcca58-72d324995b4mr25243618b3a.2.1736774669410;
        Mon, 13 Jan 2025 05:24:29 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e8ecacfsm6934625a12.38.2025.01.13.05.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 05:24:28 -0800 (PST)
Date: Mon, 13 Jan 2025 21:24:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have
 clones
Message-ID: <20250113132425.fdu4udrobzfxpgrl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
 <Z2Ey4yQywOEYqEOI@infradead.org>
 <CAL3q7H4Age-k0ifGh+n4QwExC1vTgWGd3NROcX40vQXKRipBqw@mail.gmail.com>
 <20241217172223.GA6160@frogsfrogsfrogs>
 <db59d0b2-6542-41e1-abf7-0c38b91cdf4d@gmx.com>
 <20241218200927.GC6160@frogsfrogsfrogs>
 <d4c1334e-0275-453c-bdea-7878dc8c56f1@gmx.com>
 <CAL3q7H7gkd8w3mN4WV8OYMYDY_Be1SsCLcA0YezBA18U1cwkCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7gkd8w3mN4WV8OYMYDY_Be1SsCLcA0YezBA18U1cwkCA@mail.gmail.com>

On Mon, Jan 13, 2025 at 12:00:24PM +0000, Filipe Manana wrote:
> On Wed, Dec 18, 2024 at 8:19 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > 在 2024/12/19 06:39, Darrick J. Wong 写道:
> > > On Wed, Dec 18, 2024 at 09:07:26AM +1030, Qu Wenruo wrote:
> > >>
> > >>
> > >> 在 2024/12/18 03:52, Darrick J. Wong 写道:
> > >>> On Tue, Dec 17, 2024 at 08:26:33AM +0000, Filipe Manana wrote:
> > >>>> On Tue, Dec 17, 2024 at 8:14 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >>>>>
> > >>>>> On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
> > >>>>>> The test also fails sporadically on xfs and the bug was already reported
> > >>>>>> to the xfs mailing list:
> > >>>>>>
> > >>>>>>      https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> > >>>>>>
> > >>>>>
> > >>>>> This version still doesn't seem to have the fs freeze/unfreeze that Darrick
> > >>>>> asked for in that thread.
> > >>>>
> > >>>> I don't get it, what's the freeze/unfreeze for? Where should they be placed?
> > >>>> Is it some way to get around the bug on xfs?
> > >>>
> > >>> freeze kicks the background inode gc thread so that the unlinked clones
> > >>> actually get freed before the swapon call.  A less bighammer idea might
> > >>> be to call XFS_IOC_FREE_EOFBLOCKS which also kicks the garbage
> > >>> collectors.
> > >>
> > >> I'm wondering why this GC things can not be done inside XFS' swapon call?
> > >>
> > >> So that we don't need some per-fs workaround in a generic test case.
> > >
> > > I suppose one could call xfs_inodegc_flush from within swapon with the
> > > swap file's i_rwsem held, but now we're blocking swapon while we wait
> > > for some unbounded number of probably unrelated unlinked inodes to be
> > > freed on the off chance that one of them shared blocks.
> > >
> > > A better answer might be to run FALLOC_FL_UNSHARE on the file, but now
> > > we're making swapon more complex and potentially issuing a lot of IO to
> > > make that happen.  If you can convince the fsdevel/mm folks that swapon
> > > is supposed to try to correct things it doesn't like in the file mapping
> > > (instead of returning EINVAL or whatever it does now) then we could add
> > > that to the syscall definition.
> 
> So how do we proceed from here?
> 
> The btrfs fix was merged into Linus' tree sometime ago (v6.13-rc5),
> and I would hate to lose test coverage in fstests.

Sure, let's move on :)

> 
> Since the bug seems to be hard to fix on XFS, shall I make the test
> _notun on xfs, or move it tests/btrfs?

Add "_supported_fs ^xfs" and some comments to explain why skiping XFS. Let's
cover the original btrfs bug at first (if there's not a good solution from
xfs for now), then deal with the xfs problem later.

Thanks,
Zorro

> Zorro?
> 
> Thanks.
> 
> >
> > Sorry that I'm no familiar with XFS to provide any help, but the swapon
> > call on btrfs is already very complex.
> >
> > It needs to verify every extent of that file is not shared, and block
> > the subvolume from being snapshotted.
> > (The extent shareness check iteslf may already cause quite some IO)
> >
> > So at least to me, a little more extra logic and IO shouldn't be a huge
> > blockage, since we're already doing exactly that since the btrfs
> > swapfile support.
> >
> > Thanks,
> > Qu
> > >
> > > --D
> > >
> > >> Thanks,
> > >> Qu
> > >>>
> > >>> --D
> > >>>
> > >>
> > >>
> > >
> >
> 


