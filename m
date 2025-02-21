Return-Path: <linux-btrfs+bounces-11700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE54A3F7F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C0E168819
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554320A5C3;
	Fri, 21 Feb 2025 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTtk1Uwn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2C74BED
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150204; cv=none; b=c3JucUZR7hyHax1mqIg3ZA0snj+PfNQQWLvO0nlOxwZNtVunmOpMMRHUATGTS8iPAUlk58tW1BRQ6Jxsuhvn4bi/bPEMTko20cRRkmdDyhJkisoTMQQ9i7BqiKMLdu0PrgVbLNS5jBvQdNWl/xYQllaesNZvP+hJjMvuIR4cA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150204; c=relaxed/simple;
	bh=Mk+XQ8bti248KSlpnWb74h/SeuRdUh10vyv/7ine9RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+fryf+BCwHyZKRhygAroomk5J/6Rkl0LjxaFeAgzG08/c7H7tlWXXRLFSq3Rx9bw0A0UdPzrXrwNt4HgRT2TrJJz5EKWRdxJR30fhYIP9Fn5JzEbT1WWGnyoROyznkjjqp/jiqv2morlEgfQs3eIGI2nMTTSTpN2JKuk1OGN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTtk1Uwn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740150201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GCgOcalMjVvKv2fxVHDU+ht8NCCeGzsSfPCeNdFkpM=;
	b=VTtk1Uwn7rMbhaLGFRY292aKErQYb3z6SAJ81XWDQsqHNz9sa9DVGUNZz1rztGMPiZtejV
	grBKPvsUAffa/5Um6oWmukVRROTYGK6jmLD1PZD5Ykrrt3cazsBqVYvbQNNzxusUo1uEYF
	dxczv/PG82FYmx3+04tUzCWwOfAIijs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-GzDhyDNIMimHoUjX1D1kEg-1; Fri, 21 Feb 2025 10:03:20 -0500
X-MC-Unique: GzDhyDNIMimHoUjX1D1kEg-1
X-Mimecast-MFC-AGG-ID: GzDhyDNIMimHoUjX1D1kEg_1740150199
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc2fee4425so7455254a91.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 07:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150199; x=1740754999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GCgOcalMjVvKv2fxVHDU+ht8NCCeGzsSfPCeNdFkpM=;
        b=Azdv9ltYM2Tr9EPwvpptM46p4S33pkIyRTl4bk6wmqCt9xOhWRFCZizep7p2eEexrV
         4YbcTvnQ0fgjSdyfIEeLUYuTcz//S3QYgdOWfC73AnwPPLEJoklSdP17nozxXrrGtlF8
         Z6hB24NtFbQ9jgJr6BAN3J8gQmNT3baFJZKu8hDhnvTtCUwoLtU4TrnRU1H23rT1gclC
         3/ye5axUC9RyR3Wzz1vQn64Qz4YRJLRI0cW3PfLNDHVuJ0rCY+SIt5lUJhP4rDwraBSj
         ioaozFicwmHS/bG/0QW2rHXzsq5lrF1S4nD662BJmDvEg4UWdZ8MTEclS+eZfwCi1HJZ
         4a/g==
X-Forwarded-Encrypted: i=1; AJvYcCVssvkQJ6W/4eOI/1SvVGiZzIUINReZQStXS3lLK/1spnQp8maSkE6WsOYqHLBv/0u24+UYMbmRY0LloA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5cwYjCCyZNUj0K8sv2bEIEEzSzAOYpTH1NBT1CtnSxd/CpFad
	a2WhmOuJIxQtF8nZeRU3UmkPkGJWpxNpBqdDV2WPYpyQAwKm8kWnZFZyFEc5BP0W1uJDX+745tR
	Z8LkNuOusAkDvm9dzLylcG8JV5m+o5SDUmeuiINW6gEgK8HHUK/eV0IynJMVs
X-Gm-Gg: ASbGncsXTuL0/u+f+HK4ERoUO8DdwcApBLAJF81bxm2uyUeSUHqUyVeXNiCGiOgt6bU
	WX4MWspPcVcyE3b56Bq6EyFMde2WM7dnN6h7StFvGXj0PCUFhKcVc1IQL6dr4B5NNSwHeT8Jz1w
	JR07Kbgu1MLstPi48u6HgnwnSCShpP4yqEIWsN5KdMav74Fk9BXY1vwm6yXeT1tBTzlmPfZxuhB
	fWaQw6oRstjCkdp41jVJJ0JavMmrnE+GU9cz0oiih7ieHFAXkWQwxZG+wT27T/+oVLcDXrzoX14
	cO4b0SVzv4i9FZ/j0wziMZrs/4hg0On01KlwVgOiDh9Npgq+omk1xNZ0
X-Received: by 2002:a17:90b:37c7:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2fce78a97f2mr6041960a91.13.1740150198978;
        Fri, 21 Feb 2025 07:03:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsmpngk+FBsNVaalMiX2WwczN1LLAkFLI1XlFWh21qwo5zeGruJ6XQbycyJoiOYTa9L/YEJw==
X-Received: by 2002:a17:90b:37c7:b0:2ee:edae:75e with SMTP id 98e67ed59e1d1-2fce78a97f2mr6041921a91.13.1740150198641;
        Fri, 21 Feb 2025 07:03:18 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb10fb43sm1453975a91.35.2025.02.21.07.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:03:17 -0800 (PST)
Date: Fri, 21 Feb 2025 23:03:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
Message-ID: <20250221150311.eabczmxfxnvndkqk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
 <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4GgaQKTLzXzza4xKsoa22pG6MbOFYOuNhK-5J-ieZdRg@mail.gmail.com>

On Fri, Feb 21, 2025 at 12:04:32PM +0000, Filipe Manana wrote:
> On Tue, Feb 18, 2025 at 10:36 PM Anand Jain <anand.jain@oracle.com> wrote:
> >
> > From: Qu Wenruo <wqu@suse.com>
> >
> > Update comments that were previously missed.
> >
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> >  tests/btrfs/226 | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/btrfs/226 b/tests/btrfs/226
> > index 359813c4f394..ce53b7d48c49 100755
> > --- a/tests/btrfs/226
> > +++ b/tests/btrfs/226
> > @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
> >
> >  _scratch_mkfs >>$seqres.full 2>&1
> >
> > -# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
> > -# btrfs will fall back to buffered IO unconditionally to prevent data checksum
> > -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> > -# So here we have to go with nodatasum mount option.
> > +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
> > +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
> 
> Btw, this is different from what I suggested before here:
> 
> https://lore.kernel.org/fstests/68aa436b-4ddd-4ee7-ad5a-8eca55aae176@oracle.com/T/#mb2369802d2e33c9778c62fcb3c0ee47de28b773b
> 
> Which is:
> 
> # RWF_NOWAIT only works with direct IO, which requires an inode with
> nodatasum (otherwise it falls back to buffered IO).
> 
> What is being added in this patch:
> 
> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.
> 
> Is confusing because:
> 
> 1) It gives the suggestion RWF_NOWAIT requires nodatasum.
> 
> 2) The part that says "to avoid checksum mismatches", that's not
> related to RWF_NOWAIT at all.
>     That's the reason why direct IO writes against inodes without
> nodatasum fallback to buffered IO.
>     We don't have to explain that - this is not a test to exercise the
> fallback after all, all we have to say
>     is that RWF_NOWAIT needs direct IO and direct IO can only be done
> against inodes with nodatasum.
> 
> So you didn't pick my suggestion after all, you just added your own
> rephrasing which IMO is confusing.

Hi Anand, please talk with Filipe (or more btrfs folks) and make a final
decision about how to write this comment. I'll drop this patch from
patches-in-queue branch temporarily, until you reach a consensus :)

Thanks,
Zorro

> 
> 
> 
> >  _scratch_mount -o nodatasum
> >
> >  # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
> > --
> > 2.47.0
> >
> >
> 


