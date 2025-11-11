Return-Path: <linux-btrfs+bounces-18855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF993C4B2A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 03:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C2A3BC16B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 01:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD70266EFC;
	Tue, 11 Nov 2025 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYlk+tgn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL9Fbzvb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD67C253944
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826028; cv=none; b=nTRfnrlcvB7amcsJmoMsjUR/OIk2Qpkb18QmAR2eHHrscBu4Z4RPpQaA10LfMCUbv2DbJFjju4aJOOkDbaRrv4PruwmaYvp5hsaUbPEQqt7cAWfQKqwXlYxdMvty9hXYKCRNAflXgoxxnTnWD15ExRM0URpwrhxMB1NWSSs+8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826028; c=relaxed/simple;
	bh=SPfbF1enqcwOJRfEotXqWEZmbDB6l5+fT/yGsufoUc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfSg4InTr0fRbaDjC0+WImWOk1D07iVQpPt9MnSnnx7eqWORw8ZHq182ILrfdGhsWqSynXcx61F7xckudi8oW+tgyCmq49prb24OuLbNmw0BtX27w/bK7Du5YaKtbiCVGwIeE/ku99y7FHMQinC5fStVmUc68ekCN5lGfI8JU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYlk+tgn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL9Fbzvb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762826025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
	b=FYlk+tgnKDJKHnj1OV1tCaHlh3m6nVajp7/SBHiSVgBsoSJgUm6TUM8Z9f0Tlng6ESQO3T
	YT/tXrayFPkANluYuakyBuKxXXEPO+RK+SI4ZuqoipkCT0S6g3gzDeTV8jucboAkVkch+e
	RvUEAgohzYeCCYAWhxrp0i7dx15m+mk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-xy2JCz_4NLiKrQCB7vOuvA-1; Mon, 10 Nov 2025 20:53:44 -0500
X-MC-Unique: xy2JCz_4NLiKrQCB7vOuvA-1
X-Mimecast-MFC-AGG-ID: xy2JCz_4NLiKrQCB7vOuvA_1762826023
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297dde580c8so67866285ad.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 17:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762826023; x=1763430823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
        b=fL9FbzvbaqQlZgdGTSUL6DDDXPNyHSYyL8Xs4JHrR7OupVSeqNkEbfL1UOkgSelAF2
         PXkAzl8jp9Qj1f9jtt+6jOrw9ZProDxE2QEpq5GbIXY/UWjGUtyI8AUzw/TDHOXBjGeT
         NMCFB66tDZ3k1xwtjXCj4nI072ZF03krBY2HBKydRAqteKQlYIxImAhZcbJNtbTZYbT/
         x11xvSeyyZpQBWZXV/M3bNOZXQ7il9p3bFunbPpdGs2QfTWQ5By7/hI6j0JuoR6T7Bg2
         Y+N0WtnAhK2wttJ31oXi2UM2eFcStUkXfSzDMsLGvGCq1uk8msFFvFLvo9wZTKI4Taf4
         yEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762826023; x=1763430823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3XklV9O6JekcN95bHXyedJHLFaMcI+Z8eQK/xCQbnU=;
        b=EBfPdE7LPEaL6GhV8E+5FOhf5gUOmVuGEqSUm4GQ70NXEyLJe+cauEOPsVjtkc74PF
         Y7svZ4fCAzS8SqUgbIVmCd5A1v4LdQXly1Z018BDzPS5JK4F/i7vd+sT1e+p0YCYh9H+
         vDunZzhIMp896r0UN1fvvtQQHyTdoWiODn3aRBzC0MONFkAfQSR9zmpVyZtzZkBvviIW
         2pLeijsUvI8U6K4wu8YydPYX94RZHJuS6WvUIP+xSsmtSOU/ie/gZ7PgndIs2xrCyb10
         FufPyqxygWjsqK4LlS20mnAdAt+a1zET4KctsQoaA42TdPGIzgV2PNyBPQU+Mk5fj6vH
         v2xw==
X-Forwarded-Encrypted: i=1; AJvYcCVEzqX7DoaXdIRycdK572mhxvkpGXbaYbSE4YNiOp1H5HHLaxWnkReIHZXA7OkUJp+7tU3ZSEs0LwMRJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhTfcHsiet4Lo2Q0Z9Z9nB9PYGqScE+2OZW4+aHcEkjlaiFxlx
	x/d37qC50+KsNDetIIUFfNbdDzvMNjo6LZ6kJ7WR3vjKsdMyxI3XVOHW4ocMEShbAI1FpmQYitz
	PBT+9j022NBQLq86FZ8V7A8sL0AEWRO4tNhFRPipyy95ifCduaUPbYrelmYrp3uDz
X-Gm-Gg: ASbGncuQ7NaGm9PsWoQ3+D50dEYaa3TYMkE77ONEmWQqRCYeGQC9N9SIUNcZHFIwjKL
	zVmcV76f9Y7GvjMSfH9ff05+AJI9cSAiJOfLcQJOK2dHfLIDDZnBvdf0r8XSew8c9KkMPq0MiWb
	FFdogKchGmUUh4VkACnxRxKEFWiL06NqCSEkjZbx7IlG8VGRo56eiV/nolnQcY/tbHThKFUvkdc
	OWzOGtZREj6k5oaoMABPtAeEb258U171cf9ODjsyaqQubHNm1LRvN0Dqhfo1ORtK9BgyMZRMMDi
	MWrOVJT03M9KU8zGS4ZDVQsN0YnyfkmJ8w1bF51otdwqMZA6bBsUwFzWu5nTHnEOL5yo+wX77JU
	dCqpLAJNw9Nfg5NEBkNsUEWKo5KufNnZkpf5lLdg=
X-Received: by 2002:a17:902:f605:b0:298:68e:4043 with SMTP id d9443c01a7336-298068e42e5mr92058415ad.14.1762826023004;
        Mon, 10 Nov 2025 17:53:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGw9L6g4D6sX0IvAjppdudhuXGvA+ISsah2FfrH2akNkOHl0K3UoiaaaRBuHYOdHlzQV1taQ==
X-Received: by 2002:a17:902:f605:b0:298:68e:4043 with SMTP id d9443c01a7336-298068e42e5mr92058065ad.14.1762826022554;
        Mon, 10 Nov 2025 17:53:42 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8f4sm160191885ad.10.2025.11.10.17.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:53:41 -0800 (PST)
Date: Tue, 11 Nov 2025 09:53:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"wqu@suse.com" <wqu@suse.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] Why generic/073 is generic but not btrfs specific?
Message-ID: <20251111015336.dz6um6vqpp3qxn3h@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
 <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
 <ee43d81115d91ceb359f697162f21ce50cee29ff.camel@ibm.com>
 <20251108140116.GB2988753@mit.edu>
 <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcf903f52393132c98a79726d9b5f51696e736d.camel@ibm.com>

On Mon, Nov 10, 2025 at 07:41:40PM +0000, Viacheslav Dubeyko wrote:
> On Sat, 2025-11-08 at 09:01 -0500, Theodore Ts'o wrote:
> > On Thu, Nov 06, 2025 at 10:29:46PM +0000, Viacheslav Dubeyko wrote:
> > > > > Technically speaking, HFS+ is journaling file system in Apple implementation.
> > > > > But we don't have this functionality implemented and fully supported on Linux
> > > > > kernel side. Potentially, it can be done but currently we haven't such
> > > > > functionality yet. So, HFS/HFS+ doesn't use journaling on Linux kernel side  and
> > > > > no journal replay could happen. :)
> > 
> > If the implementation of HJFJS+ in Linux doesn't support metadata
> > consistency after a crash, I'd suggest adding HFS+ to
> > _has_metadat_journalling().  This will suppress a number of test
> > failures so you can focus on other issues which arguably is probably
> > higher priority for you to fix.
> > 
> > After you get HFS+ to run clean with the journalling tesets skipped,
> > then you can focus on adding that guarantee at that point, perhaps?
> > 
> > 
> 
> Yes, it makes sense. It's really good strategy. But I've decided to spend couple
> of days on the fix of this issue. If I am not lucky to find the quick fix, then
> I'll follow this strategy. :)

Hi Slava,

fstests doesn't have an offical HFS+ supporting report (refer to README), so if you
find some helpers/cases can't work on hfs/hfsplus well, please feel free to modify
them to support hfs/hfsplus, then add hfs/hfsplus to the supporting list (in README)
after we make sure it works :)

Thanks,
Zorro

> 
> Thanks,
> Slava.


