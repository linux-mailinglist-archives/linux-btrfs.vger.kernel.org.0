Return-Path: <linux-btrfs+bounces-9569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094349C6659
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 01:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2768281A9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 00:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A678171D2;
	Wed, 13 Nov 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WrAMPD0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5FCB641
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459510; cv=none; b=sLFBjrtypcd4FvQdf3ffN8a9uiMX+Djf/BOvH+8TU2pUfOW/R7fAR8Xo8+uiet++HFqriRGentFvUJXLI4WHrZRFQ5HEFbf4CRJ4FP6eTBuAgA8RBzFH1pECD5u+5FTtNtYDVI7DnpFERWrIEH6uRDJ2Renf4quosJ/bd97/kV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459510; c=relaxed/simple;
	bh=n3j6hYJca3iK+8w4R60+GpDVT4tBx8PgHWEo86e/9FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjHEcYPAoMTPmb1+2/NElaDemPEZ9sW0RgxCMjBFEetWm77pjRTcznX23m8NNeX20grGRbgXf43QJ9+m5TEdoLnww7iDE4fe+znhMBRiCmjfEXkISx3ecSp/PGbJQpWKNIHzbadxeZVoOOJWuw2gG0zyfJxbJm7umsmCStbD6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WrAMPD0h; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99f646ff1bso940097666b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731459506; x=1732064306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tJ813zBq+G2Ew0iXW8JEVhQMVvtnrBGzEzzKoVgMoc=;
        b=WrAMPD0hBykJQg5vXL1ugr1Wt/FYOZNNQoH5TUoTzUZs90nZSTTil62NlehgKVoP1u
         OUqCX1u/q9GGrE8+qVutYWvdZmZ8e4vt1YJfyrRGHxvRgU3SHzsSg626TwsYQKqWtg58
         VZ5Fa6r/A24apSR/G5ihzY1GlQx9GqKL0laeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459506; x=1732064306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tJ813zBq+G2Ew0iXW8JEVhQMVvtnrBGzEzzKoVgMoc=;
        b=Sdu2Tpb9weTDTUivt6GqICb1kUjQVUZmjbx9Ofe1t7uqsN6fY3cdCmBnJ5snviPWLU
         0livTSALxhpRWPatVBDBNOkJzsFr/HI2scim6yer16jFCO9s1oUIniBPWNsgqphpB3z2
         YqT3aHTl+RKDWulCP5Ra1OlYuRJnfKLEpRLsqfSZz/VjaCPU0SxgJb4U5Vuv8C8GFDd5
         gPTjLg6FcbK5vFPoISQFldvtLdIIxGDNVFCKF73CabZyE3wtkKeXfYduz8rK3rz/XzCq
         IlrO8a0oeNlGmlaizxMrX6VXUBx+BFH7tV0e979lgd1q+dNWdgHHlmYouvVixHcGuGXG
         ViHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnafdcfJ4ytp9Brqm553BbxlX1FuunuQECVGvaAfKu6eIMinr9pywxxAyKVxLovK8XGlPMdA9+l90WvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UAoj/cxlVYxeCt6zGm4TUv/lzVMddy2YRrQmVdxFQIH5VyjD
	llSgDTQNAlGvu1+WuhbH5m+5pKhB2fsWTDsqGuuf7dEXsQRpXbEeKfWYrBMzyYT6ivn7jxCEOdC
	I+H/iUw==
X-Google-Smtp-Source: AGHT+IE0KTm3auj0RtTtyIRN8FEq5LBOoD55kTfXmG/0RRHDkvKmhiE0rrw9JKlZ8tFyP2ExEMXjAQ==
X-Received: by 2002:a17:906:4788:b0:a9e:c446:c284 with SMTP id a640c23a62f3a-aa1c57ef392mr487090866b.55.1731459505844;
        Tue, 12 Nov 2024 16:58:25 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9efd2fe9fdsm554079366b.132.2024.11.12.16.58.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 16:58:23 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so503107166b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 16:58:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1WhQO5QXk920jr+h0lMbE/b9zMWh7OZgpRbg4TUhx3xVBUmO7eFfDnbQyptL/kIeV+Iid3CmFFm+TyQ==@vger.kernel.org
X-Received: by 2002:a17:907:1c11:b0:a9e:b08e:3de1 with SMTP id
 a640c23a62f3a-aa1b10a9779mr425956266b.36.1731459502310; Tue, 12 Nov 2024
 16:58:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com> <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgakk8pW39JkjL1Up-dGZtTDn06QAQvX8p0fVZksCzA9Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 16:58:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
Message-ID: <CAHk-=wiMy72pfXi7SQZoth5tY9bkXaA+_4vpoY_tOhqAmowvBw@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 15:41, Amir Goldstein <amir73il@gmail.com> wrote:
>
> You wrote it should be called "in the open path" - that is ambiguous.
> pre-content hook must be called without sb_writers held, so current
> (in linux-next) location of fsnotify_open_perm() is not good in case of
> O_CREATE flag, so I am not sure where a good location is.
> Easier is to drop this patch.

Dropping that patch obviously removes my objection.

But since none of the whole "return errors" is valid with a truncate
or a new file creation anyway, isn't the whole thing kind of moot?

I guess do_open() could do it, but only inside a

        if (!error && !do_truncate && !(file->f_mode & FMODE_CREATED))
                error = fsnotify_opened_old(file);

kind of thing. With a big comment about how this is a pre-read hook,
and not relevant for a new file or a truncate event since then it's
always empty anyway.

But hey, if you don't absolutely need it in the first place, not
having it is *MUCH* preferable.

It sounds like the whole point was to catch reads - not opens. So then
you should catch it at read() time, not at open() time.

                Linus

