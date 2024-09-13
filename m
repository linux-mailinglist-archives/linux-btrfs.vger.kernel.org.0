Return-Path: <linux-btrfs+bounces-8010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C19788B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B4D1F224DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4499F14831E;
	Fri, 13 Sep 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkZGX+pb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256513E8AE
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255063; cv=none; b=aRgAvJ7PN8Xl5mWbxOabfZOLWY8nJYKGiilpnQdpS4aNDlexe+CUKxr4A8k5C+wzjrFA81+ehvURnCSvjBJVFkA/NbrUchHf73xgdE+UkLSqsmfDijmiYbHUMrL5SrcMnfdtXFZ6Fm3FNGxIKnyQe2wjnQZRrTg1QWVytE7MiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255063; c=relaxed/simple;
	bh=exqxgPF0UdQfaGbZs7b/izy4FYKifj1m0sHOrBIOdKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lChgaEFXOBViYmQGoznVYtKF5B6L7/205pOK2F8k9JcvX/N+XbBmnG/r8IeErxLWmb/6ziUc6IztnX2FSqnrTlzLbubAoQARbR5rnUm/nWyYYD02AlzjeUL0tKAiFm6svDnyvDr2/QtITNoOhmGe8CprzajHome28yYiA9MDPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tkZGX+pb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso295780766b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726255060; x=1726859860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEBBs3ZiKkkyF3FXeUJY6bD8zJrCWtH/rjqnceHaQ0Y=;
        b=tkZGX+pblNhUp7hX0wYoxhvsjZMhTceLEI0xdJKqcjvjnGD9/RUb2rEayaYURlm5Wi
         i/jppDwIA/4oSKMWyQgGxL9gilEXA6iMhP13K53c00UA4eQarvc99EeDt1b6W7joPa/v
         +3zRpO/0XMdVEGKzuTEQU9H2dfdvV1TsOMZVkikItinUj9mR5dMYAclq5AzZPVJ5aC4b
         yVaz8p2ue0sbsqoKQfUK5UCKzeY7kuP85dPJ/gnd3yNpIVc2UEQSMwfEAgPR2Hl5VQKm
         jJUAhw2s8dtCi/5sF8y+NaQPsmkgjK47H4KXdw2rUlJe7UT/P7ZSH+OyzH30AmI69K+Z
         b9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255060; x=1726859860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEBBs3ZiKkkyF3FXeUJY6bD8zJrCWtH/rjqnceHaQ0Y=;
        b=bxkl9ckSXywr+EDLcxZgtb4p7LtFQI5gNFQ/X1/akuOQRyUnVAZBAemNBegO4AsH76
         IHeutMgEwnaORZG7hjkxHZzrayisFEWP0FhlM9dUOzjYdSeu2AJMlxPRyVZlaRk43k5m
         EWcQRsdbyyj0Cc7ewld5Kh9mVoJhhLiokiMRwmMvHHUP8WV6+J/cLk8kcszuQIQ26Ync
         zfpeWDBqRSpCwTN7yVHe+wdiLQXp2fisWCNB255BeoNBHqo+MkagmcHGtAL641kAp0Kd
         X3gAqqBXquEyIRC3GSBjf7Oz9SSxtC3aE/yExznmmjkxZVpnQKiEadqewOP7Oh12iubW
         J8IA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4/yprkPfWYfdbB2OwdRCrDCVv2OPUXqAkoNNEJgu2nJed7usr5aXGxjHYZmGeJemPNu4rk3o/iVKLw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1sK0ClNAH6A1rRRJzmOXB0Q2CtIQwDdJ6J3MXy66q6M/cNReN
	OhnKtDBFfYGeAEU7+qZwnYd+/OqurQWvx/hJ0SGsFg8sX76AjXlhJsp+cVEHQf9T9YRNI/q4nAp
	3DEm4mnBpHDQA90JiTwJJrp0yHrfhBvN0uXc=
X-Google-Smtp-Source: AGHT+IHWtZ8oBZ/r75IG/ZCzOt2Io2yL14++IpNnUCKri/jsmh7LErkKNbEwqZih9dC/IIe59HK21E10WSAVnPAmuFA=
X-Received: by 2002:a17:907:1b20:b0:a86:9c41:cfc1 with SMTP id
 a640c23a62f3a-a90293dab74mr710886366b.8.1726255059557; Fri, 13 Sep 2024
 12:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org> <20240913-mgtime-v7-1-92d4020e3b00@kernel.org>
 <CANDhNCof7+q+-XzQoP=w0pcrS_-ifH9pmAmtq8H++tbognBv1A@mail.gmail.com> <8756a43fe0b7c3f418b351adb05e7a146d33bdfe.camel@kernel.org>
In-Reply-To: <8756a43fe0b7c3f418b351adb05e7a146d33bdfe.camel@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 12:17:26 -0700
Message-ID: <CANDhNCpPr-MvQhV7P6at9fQ-UpM_Q9R+S9oVqjHyguOgzrrZZQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/11] timekeeping: move multigrain timestamp floor
 handling into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 12:06=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> On Fri, 2024-09-13 at 11:59 -0700, John Stultz wrote:
> > > +/**
> > > + * ktime_get_real_ts64_mg - attempt to update floor value and return=
 result
> > > + * @ts:                pointer to the timespec to be set
> > > + * @cookie:    opaque cookie from earlier call to ktime_get_coarse_r=
eal_ts64_mg()
> > > + *
> > > + * Get a current monotonic fine-grained time value and attempt to sw=
ap
> > > + * it into the floor using @cookie as the "old" value. @ts will be
> > > + * filled with the resulting floor value, regardless of the outcome =
of
> > > + * the swap.
> >
> > I'd add more detail here to clarify that this can return a coarse
> > floor value if the cookie is stale.
> >
>
> Sure, or I can just drop the cookie, if that's better.

That seems like the simpler approach, but I don't have a sense of the
actual performance impact, so I'll leave that decision to you.

thanks
-john

