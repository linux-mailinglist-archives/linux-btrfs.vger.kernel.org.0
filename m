Return-Path: <linux-btrfs+bounces-10308-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C99EE0FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 09:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231F6282D68
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257F520C01E;
	Thu, 12 Dec 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AypvzCJ3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B356209F55
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991405; cv=none; b=c5hQbsZAfz1YzUOKj5jPqEQYaqjIj5caVgAvj4V2H9/MSqfmXoVcWNXaoZqxkPzM2W21+eOa/YdReNjZZ4m3CN7MEVEk1wtx/ygIy+WjM7T2bZu32nD4oS3mob6Y0cHbvCOUzJE05EsPaNb8p2K/wGMsEju/flpEnUWaN40XRoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991405; c=relaxed/simple;
	bh=x1lZfxP8tVKva+5GYnCJibgYIIJQqmt5dFmZgOgGKf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbPO16mtOWJLiztdqmFbp6LfKVBZETROYwzEtc/5SoQJ9sV9HfX0h3W84KEICvM7heD4qphEOUeLfoIi95bGdqOv8Rb6c+27CNnFl4L71rJuu/nTrIsEAqzKIVl3b8QSivJjTyvL/w4iUuI2w6F1nCqp7bh4sMmZEDQnEGa/NCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AypvzCJ3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso413990a12.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 00:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733991402; x=1734596202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1lZfxP8tVKva+5GYnCJibgYIIJQqmt5dFmZgOgGKf8=;
        b=AypvzCJ3Zi8ws7Z6xGvUcydNnVsPGERSoi3LdbhFv98P0xOnxQxWyUQGHQ43MIOQkD
         4aDgujIHP6ppxfEQf4vXVVlTk1PPqoT1PmQ/IAbEExxrRoAgDkcI7HNagXtvTxtxkY9/
         sn6KLVAQ56vnP5FbopJDr8PFNP6utWRozPfjTAZPuI3WZIofwybehOCc8qySnhZyPUS2
         VBBB6mjqo6WU7XLnZsJVWXBZdHiAzwWgMF3/z8hdMOr0C7zlWsC0dJ2cz9d6Avw9KqiG
         X2YY8VVzIAXiKzAr7EfL3ZxN5Uv9REJXw4PYi83xEMb+ryx7BWha75EcB/ASerDZ64JS
         aN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991402; x=1734596202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1lZfxP8tVKva+5GYnCJibgYIIJQqmt5dFmZgOgGKf8=;
        b=nWpee0ztmxmZq030WGDBeS5mwbfsiWHuOIRePYt6tIbqVRU0nTtgjdYcyRdNvHYlSr
         bNhdGye6pDAPpvJvm/0tqXPg9FMfiSIpsusftVq3BNyr/DKkZmFRhhvsEkK932ryCnad
         WFgBT/D+jL1ItG+1dhH8pbVYjYmej/Xb+w7XlPUHbuMhMc+cywQEOOkKpUD7rgPfrw3Q
         Hd/KCDXwZxZ3r1VT0K14S/0bdD4o6n8wojRUw666xO3NDQ0QJz3/F1QiYZA+Kbr2G4oN
         rZKj9OL3fC/pVsZUiN+ldgZ1ElCC5jFDkv5VcEFWjEMPjR4OsiB+CdA9cocvQUJjFERD
         Ddog==
X-Forwarded-Encrypted: i=1; AJvYcCVb1fxCup0JiHd8X155nhZc/Y4VykMsyzQOA+YnzRUvvhN/ZN980/Ct4oIQAdhqRRcWlFffCTkxYJ2/dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWlzdWdhcHpyF9XjNsJuXnoZYUxRsWHDSuttgqi+j1zhJAztV
	ZYnJII9b30gNiXLbBQc94ROEsUU/gagHoH25o1TaRRpxZaVMrVzXNMDxdoQ/hRYksGSh1qSm6Xm
	VcnuvlvAkbTwzaK369vUpJHNlbkYkTb+IL3HSxA==
X-Gm-Gg: ASbGnctrPrE1397faX8EjsyKVg3AOHtacqg8DqNOm0Y7pt9yxhgL97UW6PtQCvb8mkO
	rmJCkDHzMk6iMgT2TTxNdcAGKkwyttb5T0deJ
X-Google-Smtp-Source: AGHT+IHq2LiaTDAdQG1IRxOtsTssjhx6LklAJX9kMaulofgK7RHDp0nhYM9dwMoslUBNdUIH+VK7eMST4iIte9mhc84=
X-Received: by 2002:a17:906:3083:b0:aa6:8a1b:8b78 with SMTP id
 a640c23a62f3a-aa6c1ad9e4fmr273362366b.6.1733991401684; Thu, 12 Dec 2024
 00:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212075303.2538880-1-neelx@suse.com> <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
In-Reply-To: <ac4c4ae5-0890-4f47-8a85-3c4447feaa90@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Dec 2024 09:16:31 +0100
Message-ID: <CAPjX3FcS55T_qToJqSrHJ3NhMtWFU86wE-qk1Khpf++MvPqzyA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix a race in encoded read
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Omar Sandoval <osandov@fb.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Thu, Dec 12, 2024 at 9:00=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12.12.24 08:54, Daniel Vacek wrote:
> > While testing the encoded read feature the following crash was observed
> > and it can be reliably reproduced:
> >
>
>
> Hi Daniel,
>
> This suspiciously looks like '05b36b04d74a ("btrfs: fix use-after-free
> in btrfs_encoded_read_endio()")'. Do you have this patch applied to your
> kernel? IIRC it went upstream with 6.13-rc2.

Yes, I do. This one is on top of it. The crash happens with
`05b36b04d74a` applied. All the crashes were reproduced with
build of `feffde684ac2`.

Honestly, `05b36b04d74a` looks a bit suspicious to me as it really
does not look to deal correctly with the issue to me. I was a bit
surprised/puzzled.

Anyways, I could reproduce the crash in a matter of half an hour. With
this fix the torture is surviving for 22 hours atm.

--nX

