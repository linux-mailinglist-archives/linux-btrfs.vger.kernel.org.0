Return-Path: <linux-btrfs+bounces-12473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1209AA6B674
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 09:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FE41885A9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BF1F03F8;
	Fri, 21 Mar 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Zdt4f+8I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DE1E7C10
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547428; cv=none; b=S6m4d7EywVSYLMaHOM/tCpOFC61WjqrKOMEStA+H4dWZctia5X4uhfL6DPSmcEVnYWa4K/mxho9XUR8ezYh4TLtXy9QPIin2MzGejCf05EKeAwZl1SWGrZt6MzgFvu5EOfH5t9vUkX05dZKCyt0XKbj1rkBfV2liXZlQYueAE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547428; c=relaxed/simple;
	bh=3TKFucNcOC4UaTI0j8rJfMHO8ZdfBtl88s4rsW9hTD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhY56ixgKosymFXHdXHtsau8EbkfU7kjAXFM88CXDRDAM/FJDagic1NYMTUfvfVTLQ7WV4L8pEDMaCLZDRpTe/w1BO2Wt9WFS76Z1Aeq57AsurLQOCjr6QADOe+5HUpnr+9bSXu9nDe+usALpZEVgadL+4XgOpFXBqEPR+Xc2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Zdt4f+8I; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-301cda78d48so3279855a91.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Mar 2025 01:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742547427; x=1743152227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zf8BUs+2IfPR9c9zeSZcxxZD6VQ5OkePaoHu552rQsU=;
        b=Zdt4f+8IPsjPLGPvQzTDp/2xO3CvYHWCj/s91ioqf421g7NZtVxGe2rvn7f4Hi8iSz
         RuyBNMktBaEG85oHlQH2edszmkgxQ5CFKy/Ju42Z9yKBZk0t96NXlw85IFczfTooqZuY
         V/2sPvbF17X7COaIpzp1TIKRiWqiQ/fqwg9zqXIOKkbDH3xY8NUQL98IdDvgyXJpVC7C
         hJ36SsoOrKBESaDSK6FsD/yc8h89HkKc3c1mYUGdJnz8wjy2q/Hpr98RuPaS+iLV6a/f
         7RJfhNwjFupNwXaJW8vzPdbV2IjCNjgMaQ04PvB2BJYLg0hM+G3v3VH2TNR/2ilOHVZb
         ow7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742547427; x=1743152227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf8BUs+2IfPR9c9zeSZcxxZD6VQ5OkePaoHu552rQsU=;
        b=Qk+zV+S1XQd5lAc+Yrw2xeNfwHqU0F7nBOkfmCiKzk+4B2bBOqWWilLuMKJyi4Jlm0
         WBQJsb/q5hOnGbQsVXnpxFWiZ9VGd9K1d3v8vhfDJbMyjUB3H8hramBvJAm5/Igr3oio
         5bHvVP4dqZTHR18RJw6XlIRJSxegtWg+OilkyuB0Y3XSIAQKQnHF89Gw7d0oIzHX3vRo
         sFkL4GJ4jqRdTvhBPCzihcdbnp3WJkuEccfQFCBlZqBoBbpZjPxk+ZOHX0Zza89/Qvjp
         yRjflno2Ge68/+LxgNp3wCZnlXxb5/r0mJ+EwNWOP/H6nAg5oFntW9RhjxOGKiLeSiOA
         vEog==
X-Forwarded-Encrypted: i=1; AJvYcCVNa7ErRAXDqbAK4ofee8Z5meAoBlvyJD8cKTCQLo8MZoO0dRDv/p7OzfX+UOF1w0mvRfyq7jhDLQtsjg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YhEoKf/72Rxg3RA00ZbQKaS1vGWLFIZCmWTaBS3LlEpgdW4A
	EY1B43WLe7VDkwH4w387GVoueYyuJHlYHSUHNkkPfGLHpVHak9NMz9RXMmeSUeU=
X-Gm-Gg: ASbGncu0y3z79RmTj0V4Am5C+nuMtN4ljlXktKyFAuXL9B773zA4em1vS6jNMCsLB+P
	EEvNYW9Cx9zyW2Y73WqZjBm5LBD0o+nYzEboaVjDm8AxdQ48XD8eAIC4E3sGn02YFDzs/3b85Gv
	zVuC6zHA94bG8bmupD59cZmnwrnDi3gms7qGADo9siESJAP6BGL7oH9QJiXEJxsGT42Fk7PC1ck
	940ILx0/0UUjbUaRPuFWoNcr0XguOVQ5F++EdPNWxsG5Ih+yQ81kPdjIuY/jJwntGWdQzYI7qmm
	2Z0+sVRi/hqXRxwRpXQSRV7mjaEBU7qtvylQca+SduY9aoTjacU+L3W2MMJF2vSI5t0hHqsyTVL
	eDRj9MOJ3x6ysb3fN5X7K
X-Google-Smtp-Source: AGHT+IHAM0AOw8u1TT1o26v/Dsgouc7Bq+TSPmAWGtd8H9aB3zlLx2zOui78FLVpvPokcIIc6Yb01w==
X-Received: by 2002:a17:90a:e7c4:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-3030feeadd1mr3211456a91.26.1742547426386;
        Fri, 21 Mar 2025 01:57:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301a39efc5bsm6606883a91.0.2025.03.21.01.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:57:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tvYBZ-0000000Fvtf-40BJ;
	Fri, 21 Mar 2025 19:57:01 +1100
Date: Fri, 21 Mar 2025 19:57:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Iomap buffered write short copy handling (with full folio
 uptodate)
Message-ID: <Z90p3fep5m8Lxv7d@dread.disaster.area>
References: <1f7da968-4a4c-4d3e-8014-5c2e89d65faa@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7da968-4a4c-4d3e-8014-5c2e89d65faa@gmx.com>

On Fri, Mar 21, 2025 at 06:42:25PM +1030, Qu Wenruo wrote:
> Hi,
> 
> I'm wondering if the current iomap short copy handler can handle the
> following case correctly:
> 
> The fs block size is 4K, page size is 4K, the buffered write is into
> file range [0, 4K), the fs is always doing data COW.
> 
> The folio at file offset 0 is already uptodate, and the folio size is
> also 4K.
> 
> - ops->iomap_begin() got called for the range [0, 4K) from iomap_iter()
>   The fs reserved space of one block of data, and some extra metadata
>   space.
> 
> - copy_folio_from_iter_atomic() only copied 1K bytes
> 
> - iomap_write_end() returned true
>   Since the folio is already uptodate, we can handle the short copy.
>   The folio is marked dirty and uptodate.
> 
> - __iomap_put_folio() unlocked and put the folio
> 
> - Now a writeback was triggered for that folio at file offset 0
>   The folio got properly written to disk.
> 
>   But remember we have only reserved one block of data space, and that
>   reserved space is consumed by this writeback.

This bumps the internal inode mapping generation number....

>   What's worse is, the fs can even do a snapshot of that involved inode,
>   so that the current copy of that 1K short-written block will not be
>   freed.
> 
> - copy_folio_from_iter_atomic() copied the remaining 3K bytes

No, we don't get that far. iomap_begin_write() calls
__iomap_get_folio() to get and lock the folio again, then calls
folio_ops->iomap_valid() to check that the iomap is still valid.

In the above case, the cookie in the iomap (the mapping generation
number at the time the iomap was created by ->iomap_begin) won't
match the current inode mapping generation number as it was bumped
on writeback.

Hence the iomap is marked IOMAP_F_STALE, the current write is
aborted before it starts, then iomap_write_iter() sees IOMAP_F_STALE
and restarts the write again.

We then get a new mapping from ops->iomap_begin() with a new 1 block
reservation for the remaining 3kB of data to be copied into that
block.

i.e. iomaps are cached information, and we have to validate that the
mapping has not changed once we have all the objects we are about to
modify locked and ready for modification.

>   All these happens inside the do {} while () loop of
>   iomap_write_iter(), thus no iomap_begin() callback can be triggered to
>   allocate extra space.
> 
> - __iomap_put_folio() unlocked and put the folio 0 again.
> 
> - Now a writeback got started for that folio at file offset 0 again
>   This requires another free data block from the fs.
> 
> In that case, iomap_begin() only reserved one block of data.
> But in the end, we wrote 2 blocks of data due to short copy.
> 
> I'm wondering what's the proper handling of short copy during buffered
> write.

> Is there any special locking I missed preventing the folio from being
> written back halfway?

Not locking, just state validation and IOMAP_F_STALE. i.e.
filesystems that use delalloc or cow absolutely need to implement
folio_ops->iomap_valid() to detect stale iomaps....

> Or is it just too hard to trigger such case in the real world?

Triggered it, we certainly did. It caused data corruption and took
quite some time to triage and understand.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

