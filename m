Return-Path: <linux-btrfs+bounces-11452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E57A34EA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AF81881999
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC2245B09;
	Thu, 13 Feb 2025 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moVOXhtt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD7245B10
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476177; cv=none; b=L99fHe1ruq6ILOSkne7TmXV/Uu9BLtGRV10+KM/ozKh2sx39MZm5yGg8YT6OVPzQ1UFN9SPFfiAAthNIFk/RmjGumW73hvKaQEVV/rMjzBu0olONfH3Hf5OfQz5H1ngXgQArqwG826fkqSjceCY+zvFRcfh4PUWCuKJFdvUYQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476177; c=relaxed/simple;
	bh=47O3+yxzMsfhplQIbh1eLMHLqfSWrMNmN2gLEUFYK54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlJtokritmONhbnNiCfJ5zY3CpH27jt+kGncnTC7Rc4G8sj+OyMKmEqLnckcbXoc8jgOH5CPaybGrt96GJeNQkQoK7tRAOcmzzYSLmkM8J73ggdWO7E9wt/Q0maAOQl8/NwSt5UygZC3IkK+GYGE0XdU7C/QFxE87az7btRQ6aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moVOXhtt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c07b15ad6bso62940885a.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739476174; x=1740080974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9Octag/yHpNXBsbSKnQfTjeblETCRsrOO+dCvmJAjk=;
        b=moVOXhtt3ri4/AyH71atUZoMWHAE4Ta8g92ZyjMX4zDvCqA4kcu+Lbv+bwL0XP1RVD
         8bvX4KpLRg7BKHv5P+7hLvJmP+plBcKgJaszKdFeB7UakbDNSMsDZV5XZIlgYw6m2cKJ
         SHIUd9lSYM0yUDr2vVY6ccLsZe3ag7V4wcbp5IEY/ElRwAeEqdm70fxeAMU+HTojbHAA
         y1Ch8Z5DASWeo3ScssOBBlZFI81NuPIm5vF5VN0bMpEwk58EbCkNJBF+guA9zTaKWmBl
         mPYiuifMJkbQArrr54HcIE49Pdc9oI2qvxD8zPnr6FsVqpI92JbkUP9lxldDm5YBdMz1
         ex2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476174; x=1740080974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9Octag/yHpNXBsbSKnQfTjeblETCRsrOO+dCvmJAjk=;
        b=MMzLSlMAGyLw9OZbEhsJdVGAaB0TPNqTaJuBRB/1379MoSFdESIKG/y1GBotSnE8M1
         4JP48pwkphJvnAs8NP8+m5WNYe1tUL+WMXnZEqsShr86v6RAfK37uuyIY9n8esIrLllz
         mukNn4sW8KEt7e+g9B3YhYqkqAxsxTCVhi+3vEfV9ofc7R6KexwxG/U0AlAqLiNe7t5d
         npADxyuNfJmXJvN/9hVa+qaxal8QOGx59640ipa+HuV+1ZlDbTYSOgDqdpeFzEFvNDAS
         I5AWyzlqFLgfVUkBVMYaB2LTKzMnHBB436Z6YGRvcjj/3FfDCLE2XdSyoRWv8u61cowm
         PzkA==
X-Gm-Message-State: AOJu0YxkG+XeD+4Tb3yYdCort7KGvMt4KK3tsYD4XyXWJzSN/wMIB3Jm
	YPL7h1WLVx1+pa/5eyRY7oF5TWNv53pybL/S4xzkFHTdd1ZnXj1TNpj8gzPB3skRungxaz9MzV3
	LKvk87Bt2Ykc0sq3WFlQljC80YD6WqQVT
X-Gm-Gg: ASbGncvLots4GRLBD6+jx3izok9PlmT7KwiQEDjvs5PyegtMLneppZ8q2b1caeLOviv
	vR5D1T4b49uwgo6Z4bQ7c7SsNjT2b2HXX09W92wazp4yzAZF30J5ET4UHlXzAmfGRVAabKq8=
X-Google-Smtp-Source: AGHT+IF7FxzeGRgONXiY8PFkHy50+Zq47dVC4Hy/B12Jn6q+tgvOu6yz0ytDNNZDvQybAabku28XktcPM9OROva8NZg=
X-Received: by 2002:a05:620a:8289:b0:7c0:76b6:2ba with SMTP id
 af79cd13be357-7c076b60434mr644237785a.2.1739476174653; Thu, 13 Feb 2025
 11:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207023302.311829-1-racz.zoli@gmail.com> <20250207023302.311829-2-racz.zoli@gmail.com>
 <20250211191457.GU5777@suse.cz> <CANoGd8mhGau83LU-bWjyi-A2jnzZoAyhqzo3yuxnhC2sETpfWw@mail.gmail.com>
 <20250211234248.GW5777@suse.cz>
In-Reply-To: <20250211234248.GW5777@suse.cz>
From: Racz Zoli <racz.zoli@gmail.com>
Date: Thu, 13 Feb 2025 21:49:24 +0200
X-Gm-Features: AWEUYZkmWCCwCvR8ey-JxwNuzpkDhPmTs9SKOlVqr7DIdK3WfmdiQLTYAdiodi8
Message-ID: <CANoGd8nN+wJNtnbAo1TmE=biY2v3XtQiZASYQ+u+xMmrz2-KCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Removed redundant if/else statement
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I looked over the changes you made and I was thinking, can`t we
isolate the part which checks unit_mode, and then leave the block that
prints rate and limit unique?
Asking because this way when adding the json formatting option we
wouldn't need to repeat the print logic after.

My suggestion would be something like this:

unsigned int mode =3D UNITS_RAW;
if (unit_mode !=3D UNITS_RAW)
    mode =3D unit_mode & UNITS_BINARY ? UNITS_HUMAN_BINARY : UNITS_HUMAN_DE=
CIMAL;
...

What do you think, should i create a commit on this, and continue with
the json implementation?




On Wed, Feb 12, 2025 at 1:43=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Feb 11, 2025 at 09:31:33PM +0200, Racz Zoli wrote:
> > I simplified that if/else block because looking at it it seemed the
> > only difference between the two was that in the if block
> > pretty_size_mode received UNITS_RAW and in else it received unit_mode.
> > Didn`t know about the underlying reason you mentioned.
> > But if the second patch containing the json output implementation is
> > ok, I can rewrite it so it uses the function as it was before my
> > commit.
>
> I have fixed the unit printing and found another bug. Please base your
> commit on current devel branch. The json patch won't apply cleanly but
> it's only in the rate printing part.

