Return-Path: <linux-btrfs+bounces-9625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56C39C7EB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 00:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706841F22C8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132218C923;
	Wed, 13 Nov 2024 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="St3FUaOB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7818C019
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731539281; cv=none; b=syQzxVcxfph2kA6gz0dD5XVadBwOy1EKjLfbzq8UBa+gWZPOZVPHD3uVtYk7SXojDWEi23EGcy2nLw9kOCkUSlAWWHz3Jrsc2SuNz2psx9gYsMdnuJ5fFOOeHCfotRWymkhrDwZdlHkphTPIiT9Dbv97EPkZju+RIsgHPthvlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731539281; c=relaxed/simple;
	bh=/tltkOoQpP8bcM74mMy2gPuKWTvbxMmV0LsxinTpOwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC8OOIV4TIuJ43TcQW92YO7jmGnla4jXVUrCKyLNF0EG35j3IhBfoAiDZH0oHjnsF7k5lzFxkNLuRdtV4qN5Y526EJpAFb/Qvw7k3l+bJwtAEWTQjugZL+0pMao0T9ztSVrMWRzgTQQHEDSxryqQsIAvnvz+kXnYrscZzwdA2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=St3FUaOB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cf6f7ee970so1559141a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 15:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731539277; x=1732144077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3uMAHPF1ytklJO173iJZDrJhJUNgUA50IG0+xtq7Xjg=;
        b=St3FUaOBCk1lxRqWDiTu4k4Z7650tL0EefyjPM4Uz1xTvANz5zkpfm6YOoe6+feHMI
         PjlhXHiA0r794Lqh6yfGa/N7u6mcCC4UUPMVPxsTRhz9+g770MPFUMINQDYzE4znxJWt
         BGYMdcdRRPTfLAMUdkkKA3bEz8he6aq66BQyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731539277; x=1732144077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uMAHPF1ytklJO173iJZDrJhJUNgUA50IG0+xtq7Xjg=;
        b=i1QPcneINAcw0p4q423CqFUE4a1YzhC43mPSuAyPJW4fugBrsZAp8fsFGhl1Uneily
         oyG52sFiRmk1JYJCVQGgX9liZMazY3NuugNTJeTqJRX6fiQo0OQ7ViJE+SRxzsuylXMk
         YAneZIL6xDJmKYwpdfevxRgYkGnxWQJf8NvCD3gdYiEQ7GPkfhDqizaxEdCmjJ0JVMfp
         DtxUmrkP649CXz6pp6SME3nHupbUZ9VKNdVIceC3SVPBURlN2tsKD04QQVWO/mamUZ9S
         5FSlZLc3q7q5QVhubg+rzc4nEzABn7S8EIzGtUKE0IBeGynIPuhZmL6i+G43tjnvmqFg
         6N7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWep2acrGzMKey9Vom49T/ajbRGBpJcKyjcyYx0T4oDSp2dthixmUIumnDQ3zdE0InOxNKAWeK+uOGsEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Y4VNUjsGnx4R+390COasi0c3eY8qjeFfPhK75xLIvYpQEaXC
	THB+vICBwG7B+DPnbwpyLTV9c2w5ZUMqqza8NSxKm+P4znbdyHzhytxdWjkCfLLldjO55nDxKUo
	UuOo=
X-Google-Smtp-Source: AGHT+IEyyOoNKRBfi/ThieAXc3EqXWQiKjBW3RAsmjQbM6saJKdweb2j5j7bPgm8Rw0s0HZIbwq5Ew==
X-Received: by 2002:a17:907:a4e:b0:a9e:c430:7758 with SMTP id a640c23a62f3a-aa1b1024a32mr703965766b.10.1731539277518;
        Wed, 13 Nov 2024 15:07:57 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc4b94sm942216366b.127.2024.11.13.15.07.55
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 15:07:56 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso10416924a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 15:07:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHpCXiqcr8+5dIhVawYceUXRMYyseRAwrf43lCGb6nUhdpv2z1Ix6NCJNdx9HoCdrUZEXPzlezMtu79g==@vger.kernel.org
X-Received: by 2002:a17:907:5ce:b0:a99:5234:c56c with SMTP id
 a640c23a62f3a-aa1b10a372fmr767667166b.33.1731539274832; Wed, 13 Nov 2024
 15:07:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxjQHh=fUnBw=KwuchjRt_4JbaZAqrkDd93E2_mrqv_Pkw@mail.gmail.com>
 <CAHk-=wirrmNUD9mD5OByfJ3XFb7rgept4kARNQuA+xCHTSDhyw@mail.gmail.com> <CAOQ4uxgFJX+AJbswKwQP3oFE273JDOO3UAvtxHz4r8+tVkHJnQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgFJX+AJbswKwQP3oFE273JDOO3UAvtxHz4r8+tVkHJnQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Nov 2024 15:07:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTEQ31V6HLgOJ__DEAEK4DR7HdhwfmK3jiTKM4egeONg@mail.gmail.com>
Message-ID: <CAHk-=wiTEQ31V6HLgOJ__DEAEK4DR7HdhwfmK3jiTKM4egeONg@mail.gmail.com>
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 14:35, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Sure for new hooks with new check-on-open semantics that is
> going to be easy to do. The historic reason for the heavy inlining
> is trying to optimize out indirect calls when we do not have the
> luxury of using the check-on-open semantics.

Right. I'm not asking you to fix the old cases - it would be lovely to
do, but I think that's a different story. The compiler *does* figure
out the oddities, so usually generated code doesn't look horrible, but
it's really hard for a human to understand.

And honestly, code that "the compiler can figure out, but ordinary
humans can't" isn't great code.

And hey, we have tons of "isn't great code". Stuff happens. And the
fsnotify code in particular has this really odd history of
inotify/dnotify/unification and the VFS layer also having been
modified under it and becoming much more complex.

I really wish we could just throw some of the legacy cases away. Oh well.

But because I'm very sensitive to the VFS layer core code, and partly
*because* we have this bad history of horridness here (and
particularly in the security hooks), I just want to make really sure
that the new cases do *not* use the same completely incomprehensible
model with random conditionals that make no sense.

So that's why I then react so strongly to some of this.

Put another way: I'm not expecting the fsnotify_file() and
fsnotify_parent() horror to go away. But I *am* expecting new
interfaces to not use them, and not write new code like that again.

                  Linus

