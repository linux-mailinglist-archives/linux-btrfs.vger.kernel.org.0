Return-Path: <linux-btrfs+bounces-8032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF9979349
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 22:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1472A2835DB
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Sep 2024 20:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B78013D2BB;
	Sat, 14 Sep 2024 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/1thsOn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E6684D13
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Sep 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726344670; cv=none; b=MRQHmUxy+79kgDT0MfX32sLqp7I+U1+JGaBs2K5xNl97H0wrrGnN/UfHxlrSKhE98ydqeM3prjee/P36gTQex0YgExNoEO+UogoXKoc7raZMkrvwHE4repAZ9uMSXzaXbb8FebaASYlhktlx9MbfvOs6R06KrU9+Nbqf/g8x85Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726344670; c=relaxed/simple;
	bh=/8lm/VXRISAhE5jgmVX9FAfI4c15JR3dQ/kV9AmQ4s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9yfor/EDZEh1JpiT5SBldaDHYAh7NlzOpD59nPaAjzYmqHCAsD4yvBmwEKBPdAoSwmyvFsc2fBl9NfLegOng6ARcc31/nM4CqUof2Q6FpeNmYx2Z+LQ+wCCGZ1FlSEJZImbGp0NQWHxTGZzW4zYIkK1HVoWUIv9lXweWUaPhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/1thsOn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d24f98215so271541766b.1
        for <linux-btrfs@vger.kernel.org>; Sat, 14 Sep 2024 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726344666; x=1726949466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6BEqsMQwTfqIOsLh2idDV9ULwQH/It7+hyl6N9v7o0=;
        b=x/1thsOna1b4xxRCuYEkmbfSdvGV+ri2FbMkR6yMe+V2XihSzAOYHTHO84SWSA8daX
         pBErJvvsmQxv64oSaXa84BPb+FFn94bUhxKxCx47FGT0ZT1H+2ppmTD4lWbw4hpCLKbL
         1dMCCLSrLZfVXWpS5g/vmZpBNsr4oXilGAIZx1d3AEgN4XMt8zNDX//hFGbJmAU+uAFS
         +aPCJzTWeUJaEnVVXNh2VQxHd2fA1iJVolDnOAhLhIz3OIoVDk/NBItdT3qZ0JtMMB/+
         p8T4y/IBh8OlApjJm2Yvk40JJu73dxg/NEYAPL/26NRkWcbL1wwjkuXR/LL3miiuBg1d
         BTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726344666; x=1726949466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6BEqsMQwTfqIOsLh2idDV9ULwQH/It7+hyl6N9v7o0=;
        b=HgLtofZWemAdBZzdrkj/s2bIeXeCGYlBY/y9qmNfNz49u6UlpzvRsLRo8exU9gDH/5
         l9o2oiPTruTCI5qiIjGSHTgI/E0n9e0Ygyf8Si/CvjNTt2q63QAxjk0B3WBliGk1WTCg
         PLAT8mdgiNRtgYI3hZ3Z5Wyoc6ewcOyA9Hh2vDq2WVCeNAstFdYeZxvkTTAbFRAIJRp0
         pS/B7RxFclfJeixIrxme88E7KM+B2pKe+IZaD5AnprCwfGtP0O8t+5sMhk2dTD6J8VnQ
         4QVTVH1zCkSOU7WAO9Ja+qfb5apLH4zfeU3VBs9Vyz7RSSbZdayFWxI3Pt1XUiQwf967
         4lDg==
X-Forwarded-Encrypted: i=1; AJvYcCXVtmoYwN5rhaKd/GE01XSgUbtWG3hLzRNbV+KITv7N840lSyK9/ZLaxupvd6WkWqGkSvlH0e+3c97C2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6INIRZvT4ThJpTtpXIkWcbQhQRilR+H2qvEOVhyQ3hd0UtSKR
	3QqJ4GaGBOjHaJaABDo3kxZF5zUNvNrWql4ZXK9IHDbdnwpitRbOFysfxgppzBC8p4tYorW4mGa
	wRH79IAQcpWMilbUpQr+siiiETdVnKghM2aw=
X-Google-Smtp-Source: AGHT+IFs1sXaKM4VOxehK4mNhVRQjd3/gDCwMPvCwIMtQ05vol5GnMxRAUVkjsh8/C1xzMc9AivKp9raF20+AN2HOxc=
X-Received: by 2002:a17:907:7da1:b0:a86:96ca:7f54 with SMTP id
 a640c23a62f3a-a9047ca3bebmr634617166b.21.1726344665517; Sat, 14 Sep 2024
 13:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org> <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
In-Reply-To: <20240914-mgtime-v8-1-5bd872330bed@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Sat, 14 Sep 2024 13:10:54 -0700
Message-ID: <CANDhNCpaySH5HmkEb9BS738Fo+Kk=6s0_zNwB=uYtOQ63uc6xw@mail.gmail.com>
Subject: Re: [PATCH v8 01/11] timekeeping: move multigrain timestamp floor
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 10:07=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> For multigrain timestamps, we must keep track of the latest timestamp
> that has ever been handed out, and never hand out a coarse time below
> that value.
>
> Add a static singleton atomic64_t into timekeeper.c that we can use to
> keep track of the latest fine-grained time ever handed out. This is
> tracked as a monotonic ktime_t value to ensure that it isn't affected by
> clock jumps.
>
> Add two new public interfaces:
>
> - ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later of th=
e
>   coarse-grained clock and the floor time
>
> - ktime_get_real_ts64_mg() gets the fine-grained clock value, and tries
>   to swap it into the floor. A timespec64 is filled with the result.
>
> Since the floor is global, we take great pains to avoid updating it
> unless it's absolutely necessary. If we do the cmpxchg and find that the
> value has been updated since we fetched it, then we discard the
> fine-grained time that was fetched in favor of the recent update.
>
> To maximize the window of this occurring when multiple tasks are racing
> to update the floor, ktime_get_coarse_real_ts64_mg returns a cookie
> value that represents the state of the floor tracking word, and
> ktime_get_real_ts64_mg accepts a cookie value that it uses as the "old"
> value when calling cmpxchg().

This last bit seems out of date.

> ---
>  include/linux/timekeeping.h |  4 +++
>  kernel/time/timekeeping.c   | 82 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index fc12a9ba2c88..7aa85246c183 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -45,6 +45,10 @@ extern void ktime_get_real_ts64(struct timespec64 *tv)=
;
>  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
>  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
>
> +/* Multigrain timestamp interfaces */
> +extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
> +extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
> +
>  void getboottime64(struct timespec64 *ts);
>
>  /*
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 5391e4167d60..16937242b904 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -114,6 +114,13 @@ static struct tk_fast tk_fast_raw  ____cacheline_ali=
gned =3D {
>         .base[1] =3D FAST_TK_INIT,
>  };
>
> +/*
> + * This represents the latest fine-grained time that we have handed out =
as a
> + * timestamp on the system. Tracked as a monotonic ktime_t, and converte=
d to the
> + * realtime clock on an as-needed basis.
> + */
> +static __cacheline_aligned_in_smp atomic64_t mg_floor;
> +
>  static inline void tk_normalize_xtime(struct timekeeper *tk)
>  {
>         while (tk->tkr_mono.xtime_nsec >=3D ((u64)NSEC_PER_SEC << tk->tkr=
_mono.shift)) {
> @@ -2394,6 +2401,81 @@ void ktime_get_coarse_real_ts64(struct timespec64 =
*ts)
>  }
>  EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
>
> +/**
> + * ktime_get_coarse_real_ts64_mg - get later of coarse grained time or f=
loor
> + * @ts: timespec64 to be filled
> + *
> + * Adjust floor to realtime and compare it to the coarse time. Fill
> + * @ts with the latest one. Note that this is a filesystem-specific
> + * interface and should be avoided outside of that context.
> + */
> +void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
> +{
> +       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       u64 floor =3D atomic64_read(&mg_floor);
> +       ktime_t f_real, offset, coarse;
> +       unsigned int seq;
> +
> +       WARN_ON(timekeeping_suspended);
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +               *ts =3D tk_xtime(tk);
> +               offset =3D *offsets[TK_OFFS_REAL];
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +       coarse =3D timespec64_to_ktime(*ts);
> +       f_real =3D ktime_add(floor, offset);
> +       if (ktime_after(f_real, coarse))
> +               *ts =3D ktime_to_timespec64(f_real);
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_coarse_real_ts64_mg);
> +
> +/**
> + * ktime_get_real_ts64_mg - attempt to update floor value and return res=
ult
> + * @ts:                pointer to the timespec to be set
> + *
> + * Get a current monotonic fine-grained time value and attempt to swap
> + * it into the floor. @ts will be filled with the resulting floor value,
> + * regardless of the outcome of the swap. Note that this is a filesystem
> + * specific interface and should be avoided outside of that context.
> + */
> +void ktime_get_real_ts64_mg(struct timespec64 *ts, u64 cookie)

Still passing a cookie. It doesn't match the header definition, so I'm
surprised this builds.

> +{
> +       struct timekeeper *tk =3D &tk_core.timekeeper;
> +       ktime_t old =3D atomic64_read(&mg_floor);
> +       ktime_t offset, mono;
> +       unsigned int seq;
> +       u64 nsecs;
> +
> +       WARN_ON(timekeeping_suspended);
> +
> +       do {
> +               seq =3D read_seqcount_begin(&tk_core.seq);
> +
> +               ts->tv_sec =3D tk->xtime_sec;
> +               mono =3D tk->tkr_mono.base;
> +               nsecs =3D timekeeping_get_ns(&tk->tkr_mono);
> +               offset =3D *offsets[TK_OFFS_REAL];
> +       } while (read_seqcount_retry(&tk_core.seq, seq));
> +
> +       mono =3D ktime_add_ns(mono, nsecs);
> +
> +       if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
> +               ts->tv_nsec =3D 0;
> +               timespec64_add_ns(ts, nsecs);
> +       } else {
> +               /*
> +                * Something has changed mg_floor since "old" was
> +                * fetched. "old" has now been updated with the
> +                * current value of mg_floor, so use that to return
> +                * the current coarse floor value.
> +                */
> +               *ts =3D ktime_to_timespec64(ktime_add(old, offset));
> +       }
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_real_ts64_mg);

Other than those issues, I'm ok with it. Thanks again for working
through my concerns!

Since I'm traveling for LPC soon, to save the next cycle, once the
fixes above are sorted:
 Acked-by: John Stultz <jstultz@google.com>

thanks
-john

