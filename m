Return-Path: <linux-btrfs+bounces-19088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8387C6A682
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30E0A4F14F0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D09C36826D;
	Tue, 18 Nov 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Acq7FeXy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5F302742
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480759; cv=none; b=pkB83URjOKMAIzTnqt74+ziaiM/KxOqY5hzqGerGh7nbO1E7wY5P6It7Coy4KIDnT2UlEhltcHFosmqRW0GMXjbcdHWnYLOg14BQbTCU/hZoZNqQIyNW3imTcAkhvNJSrHDFgRPLOzvbUeYACEWEF8TWveV073WH1yxt9VgK8Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480759; c=relaxed/simple;
	bh=NlACXgndMKhrWLW/tjKFuuiK3NbbYsyqY+bgNGOJac0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ2gDpeBAPyE21ash8OV+eT0P1J3RHD6O6IyDdCCpS8Ai94itBMOi7KHMFhueZUfW/ha7wkkGFiqQUH6PHr8tAqCVrMb19Ai0RtDD7ch3MbZzzxpala9b2MbdGKmF6m86/F7j2H3RX5qD79jePXTgQi1XcIi8AE4dxa5UEac09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Acq7FeXy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42bb288c219so2584667f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763480755; x=1764085555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GrYYI/OqTXala7TyLIbKfkI0NbW4GGCLNByjsQ30o+4=;
        b=Acq7FeXytrjJOhLUIIkta0YYqLVbGfaT33F123Z8kzLjGVIxubFtWuPn6idI8miiY+
         aPqE3th5Ibencoca/zsxkeP9YOiFhGR7POPc8TclR08drVp9oOW8LBsAh+GhLjP05DEH
         77ZQ7Lph8WDqi3wCAI4i0GNRP+cE2i+FifnIA53WjQd4zE8vuLrmwuJ6iGEESqNnyhdr
         zBnzFhnXT9ijGSKRWWTAfTdHDqR9IB75pQrI5ebHcMCEhzi9Usgv9UWICGsvb7XcEr4e
         FmP+A/X0vh1YS2T6aTzW0tUA/1XbJLJDjJC1FM35CG5Vpj+ouxr/o1qODPYLuiiPbRO8
         I4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763480755; x=1764085555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrYYI/OqTXala7TyLIbKfkI0NbW4GGCLNByjsQ30o+4=;
        b=G/JKWq8usVsfAxhoUYhZD5r6P9A4MJsLZMTFEhkJTrOY7h0uaIGpr7waHypiUh3sTK
         VHea+pOgpO1mYtUeAE9lJ66reGjzdnJSBrVJ9lyxVMeaA5oWUOORU/N0xhAGxIjPgWoy
         c4ZL7+v6kLjq6O+L/qSud9rPQTkMEIyOgZXzafFWPbjy63K6e4VX/2Cuqw/7xGmza2jc
         3T9g4fBOZN0BX6pkIKayYMzSfb1XydbnMwOjVXL92VE+3eK2STVTLH5lbcSpFAtVQtd/
         uAUxmbyFVOw9AQ5qdFo09qEUeoqh5iZJ2cawlWbJyk0CZEp5y8cgnTQ6Raw+1q4zsYua
         3clA==
X-Forwarded-Encrypted: i=1; AJvYcCVC/GelynB6R40hW9YMYJ8JCKeQgN7bl0Tyxuk8naN6gp+nyLICFSYQU4OIqf7MHhhEn5iH/p5f+Sgevw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2eyU7qfajSeUlku8/96Dd9jWeRtGYCuo/1cm1f1Un8MU/bT7
	COi9qYlsxTIkJccMInBkIpaevQb6hHxZpkYfYZ+KeBGflCdCqdI+G5dgLp3V41OHTHuSZtUB8CL
	z9uLNgfXEOhob6F+Iyzq1qmiZ706wnRt9JJYCZhL92w==
X-Gm-Gg: ASbGncuiXiVAn/twXfsYd6HxjCRRNWazX0ReJMVnq8pv+95PYep9/1iN230TAYxEucm
	HdCPuhQKYVVDrnWc9K5tILEny60SCeoJs8zaN9brt4uftcBCV+YWELBEhu2Zfi3eYdnxVyC4Kst
	O2LqDL07ScuofXiMnY19qxwAwYYHSTsevxJ2qzMNestxnLZhDVCbVvID2r2abIgFOQuhNg2ir8h
	f4sWLcjWzqkVuJfHXgC8aNn8YccPEIZ+USLtGrJQCat0xTYtiQ5KXbjPT5/9KaYRdJvndafGglY
	oumVSJ6sNg+jvAw0ndv/0GIEc7UxmGe1BCeO9z+Yiw4rDJ0HK+d/ysyy0bXG4pqKMtng
X-Google-Smtp-Source: AGHT+IHy704c7tC+YfC/nBvJ8eOjLCkRoLMk4LX9Tw1N7w2CxtTZ+9Ah9HjeRlbdpT4hPzuhpwiu/GEFntqtiiPIcdI=
X-Received: by 2002:a05:6000:2310:b0:42b:3131:5435 with SMTP id
 ffacd0b85a97d-42b5933e378mr16901065f8f.2.1763480754683; Tue, 18 Nov 2025
 07:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112193611.2536093-1-neelx@suse.com> <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com> <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com> <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
 <aRyL6aw9rxqdVssl@infradead.org>
In-Reply-To: <aRyL6aw9rxqdVssl@infradead.org>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Nov 2025 16:45:43 +0100
X-Gm-Features: AWmQ_blXbO-tF6Zo_JyePS1MRCxf5iH0SVXmSG5pqHI2K2evPa8w2PicAXz0C44
Message-ID: <CAPjX3Fc2p4bU5iWBcb6iyUgLdq3XHuf159GfM0szXbb5idNzqQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Nov 2025 at 16:08, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Nov 18, 2025 at 03:05:25PM +0100, Daniel Vacek wrote:
> > But giving it another thought and checking the related fscrypt code,
> > the encrypted bio is allocated in  blk_crypto_fallback_encrypt_bio()
> > and freed in blk_crypto_fallback_encrypt_endio() before calling
> > bio_endio() on our original plaintext bio.
>
> That code is getting major refactoring right now, and allowing the
> file system to hook into the submission is a possibility.
>
> The problem is that I have no idea what you're trying to do as the
> context is missing.
>
> In general prep series should be self contained and at least borderline
> useful by themselves.  Adding random dead code checks or weird arguments
> as done here are not useful in a prep series without context, they
> should be close to the code making use of them to be understandable.

Yeah, agreed. It would be better to send this one together with the
fscrypt changes later. I was suggested by Dave to pick this one ahead
and I did not argue while I probably should have.

--nX

On Tue, 18 Nov 2025 at 16:08, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Nov 18, 2025 at 03:05:25PM +0100, Daniel Vacek wrote:
> > But giving it another thought and checking the related fscrypt code,
> > the encrypted bio is allocated in  blk_crypto_fallback_encrypt_bio()
> > and freed in blk_crypto_fallback_encrypt_endio() before calling
> > bio_endio() on our original plaintext bio.
>
> That code is getting major refactoring right now, and allowing the
> file system to hook into the submission is a possibility.
>
> The problem is that I have no idea what you're trying to do as the
> context is missing.
>
> In general prep serious should be self contained and at least borderline
> useful by themselves.  Adding random dead code checks or weird arguments
> as done here are not useful in a prep series without context, they
> should be close to the code making use of them to be understandable.

