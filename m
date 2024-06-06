Return-Path: <linux-btrfs+bounces-5504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F638FF2F8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AB31C20D35
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715A2198E8B;
	Thu,  6 Jun 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RIyjkBf2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B98198A31
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692741; cv=none; b=W+S7I4S00U7+gLIRDQbMHIab/ENu63CF5WzGG/AgyhsOOxa2reWKE90AQBRvaXMwQoeQJT9cL0ornR9/FgYfceX9AM9kjifu8YlxnDpN+ihTlgJHuS4IcKzcFHkDqcCRMg7uRGmtGRIEzVTNO3Gb0Lo86CdSNISh+9Cc1LfYkn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692741; c=relaxed/simple;
	bh=qkRWZa/p7jMGEpdcorJfhM3jq+n4RpCsNxL9dmUEEtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cfs4mpTAOnsYMyc87UCpPIVK7NTIW1cBxxxXwaZvu9C3//w78kd3J/K4FS8LHvYARm5QkjaPUkLTupGaPMNLJm7GqeDu4Lelw/oMHTGiPDMPV4Ap/G+YCyWxYVQUh3KOlWMc+N0L//FRrTez7be5BOrnQ7rYfsEw8VwIPw+/R0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RIyjkBf2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7951713ba08so96997985a.1
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717692738; x=1718297538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDNAZQe1nJTicychyCE3nYBkN+aPdNqxQz6WBXEV/J4=;
        b=RIyjkBf2DhdepggMFZNbVu1WcOB1Zx0xMTK71bEw4V0FzQaxfxIiH40VAWKY8qKJ4l
         tVZzIKNJfmEQhKyN03+FjetGrmhhAPWJbhhXMwzFt/jF4GrCv6GmfFyZfkIxbyluKHs+
         TLRq2Ac8ueg4b5MfUAmqfez9HPSz3PjBgXS9lwQyaFTVg+QDuxI7VsQf4tGgcEzQdcPs
         bDSII6X8sZf3YWv/e9be95VIBKth5iDjmW7C+0EKDsAxd2PDJRXjkF6OUPoVZQwH8RWe
         fx5BmIe8zeVDotNNwcNK3prrSuvphrLEX8GPBmt0k5kZJNrhOho7yMBCNrPMQMeSryw9
         tT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717692738; x=1718297538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDNAZQe1nJTicychyCE3nYBkN+aPdNqxQz6WBXEV/J4=;
        b=qdEzndjsDXzcZwGCAKn+kYzr1PmJSarqVOlsUZjAQ4aiukGY8fmbunDaNZRfXSoHpd
         84dfO+r3fDaEFeDRHGtU+Yu8kTUgtntt6ugMPHWboEsOD1PtyFiH1zv99mMyg75CgpD1
         Dtfu/g0U4+chRv3EmDLN710Ghm62RPeBQnCV/P7Ir2o0vskqIlDdhUXcG/r+BNkFATbK
         53wiI9JWdg7ABmy8DuT6aS4FPYY1YhZlowmbi8YD3/4JUnAMTyVV5AgUMQL2uButotxS
         csFpri2dvMafgvKT3FOO+IFfLZGzhCl2WvzC5XapuKHJATqTTO8kWBhYya4U6o1gsFZ6
         HQrw==
X-Gm-Message-State: AOJu0YxMEkawHl4xMFerrFP8uEhXCou0Y5i2XobnsRkxda3QkckwJZei
	d6x/KhgGmadSj5Gp3NOWtcuu6BMzOxOKRAhBkX/qp/iPg2l9W21pVCT+9y6FlkA=
X-Google-Smtp-Source: AGHT+IFNkS46Vvx1WfFGK1VSXpAOr30rVpZ0ubhwpJ4lrRD3CopcxiAH4FKIedxzWGTO1nmQU3VITQ==
X-Received: by 2002:a05:620a:8d8:b0:795:17e3:bdeb with SMTP id af79cd13be357-7953ae70fcbmr52019185a.0.1717692738357;
        Thu, 06 Jun 2024 09:52:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7953281bdd7sm76203685a.14.2024.06.06.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:52:17 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:52:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2] btrfs: fix a possible race window when allocating new
 extent buffers
Message-ID: <20240606165216.GA2529118@perftesting>
References: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>

On Thu, Jun 06, 2024 at 11:01:51AM +0930, Qu Wenruo wrote:
> [BUG]
> Since v6.8 there are rare kernel crashes hitting by different reporters,
> and most of them share the same bad page status error messages like
> this:
> 
>  BUG: Bad page state in process kswapd0  pfn:d6e840
>  page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
>  pfn:0xd6e840
>  aops:btree_aops ino:1
>  flags: 0x17ffffe0000008(uptodate|node=0|zone=2|lastcpupid=0x3fffff)
>  page_type: 0xffffffff()
>  raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
>  raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: non-NULL mapping
> 
> [CAUSE]
> Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method") changes the sequence when allocating a new
> extent buffer.
> 
> Previously we always call grab_extent_buffer() under
> mapping->i_private_lock, to ensure the safety on modification on
> folio::private (which is a pointer to extent buffer for regular
> sectorsize)
> 
> This can lead to the following race:
> 
> Thread A is trying to allocate an extent buffer at bytenr X, with 4
> 4K pages, meanwhile thread B is trying to release the page at X + 4K
> (the second page of the extent buffer at X).
> 
>            Thread A                |                 Thread B
> -----------------------------------+-------------------------------------
>                                    | btree_release_folio()
> 				   | | This is for the page at X + 4K,
> 				   | | Not page X.
> 				   | |
> alloc_extent_buffer()              | |- release_extent_buffer()
> |- filemap_add_folio() for the     | |  |- atomic_dec_and_test(eb->refs)
> |  page at bytenr X (the first     | |  |
> |  page).                          | |  |
> |  Which returned -EEXIST.         | |  |
> |                                  | |  |
> |- filemap_lock_folio()            | |  |
> |  Returned the first page locked. | |  |
> |                                  | |  |
> |- grab_extent_buffer()            | |  |
> |  |- atomic_inc_not_zero()        | |  |
> |  |  Returned false               | |  |
> |  |- folio_detach_private()       | |  |- folio_detach_private() for X
> |     |- folio_test_private()      | |     |- folio_test_private()
>       |  Returned true             | |     |  Returned true
>       |- folio_put()               |       |- folio_put()
> 
> Now this double puts on the same folio at folio X, leads to the
> refcount underflow of the folio X, and eventually causing the BUG_ON()
> on the page->mapping.
> 
> The condition is not that easy to hit:
> 
> - The release must be triggered for the middle page of an eb
>   If the release is on the same first page of an eb, page lock would kick
>   in and prevent the race.
> 
> - folio_detach_private() has a very small race window
>   It's only between folio_test_private() and folio_clear_private().
> 
> That's exactly what mapping->i_private_lock is used to prevent such race,
> and commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method") totally screwed this up.
> 
> At that time, I thought the page lock would kick in as
> filemap_release_folio() also requires the page to be locked, but forgot
> the filemap_release_folio() only locks one page, not all pages of an
> extent buffer.
> 
> [FIX]
> Move all the code requiring i_private_lock into
> attach_eb_folio_to_filemap(), so that everything is done with proper
> lock protection.
> 
> Furthermore to prevent future problems, add an extra
> lockdep_assert_locked() to ensure we're holding the proper lock.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/
> Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
> Cc: Chris Mason <clm@fb.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks everybody who helped with this,

Josef

