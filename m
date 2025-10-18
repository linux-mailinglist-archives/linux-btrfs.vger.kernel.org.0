Return-Path: <linux-btrfs+bounces-17992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7134ABEC8A9
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 08:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D34924E3FFC
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3302836AF;
	Sat, 18 Oct 2025 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+Ds+jDb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A4230996
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760769827; cv=none; b=jBL0yfgv0eyG6rSSQw0X/0mikEDyB7UcQ5tNftWtNILf37Bz5YXNdk6tku87POzqCC1bogAN/NGZl/yhyyAJBFeffsMcx5mVVIGFypTHrBVWkTxdRoOpxFYWpdpltKv6PAsFw5aGo0lejJF/wio+RmG/I/OCJh1kEX7KqVUc91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760769827; c=relaxed/simple;
	bh=kQimCXIYX05afXRyubFm2MBqLFmJ6zxIwq7P/+mbJ9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0E/DfzYelJvDuOa1f7469kE0Laek5hz69TMEFskBYLFDigc79hiwFJuhshShQSS7l0xczNRqSSzypSJTYV2w2q+e6APWsD2dbrVndqzsz1jPMfsD0vGZuDLFPS9EX6JUfdsF1iASkN9Ua2GpUr+VfBBGLFWrvuq/pHXE/Vf2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+Ds+jDb; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-784826b775aso2405447b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 23:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760769825; x=1761374625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQimCXIYX05afXRyubFm2MBqLFmJ6zxIwq7P/+mbJ9U=;
        b=R+Ds+jDb0tfxefcv3K/enzoTvEV96Vl6UxKqRBCqJ1HIedKpV83I7zc2blPWMFq2Is
         LbYS3tNYfVXmFTYbMxEpcXV427/b1+e3Fl0SIjJRg0ILba2ac/YLY9a28x4KJ8rZA+Tt
         JjJVSDYguh8maInYYw86Mh3GfkMlg6OHF1cjuFi5wMwKS8hWppSMkw6ClimBpqFsI8hZ
         Enhy0LaDFrtNzKgUJk2EWVqyJjF88rdiGFGOOPyX5dCn3p8F5VrZTfKpxxHNhI14oMjp
         zJ//MnlBdazOWps/clOTc44Cc0zSh2kFSCp7S8+4XfcgFxj+Mqpju+PlKSd2WwWvabHd
         OVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760769825; x=1761374625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQimCXIYX05afXRyubFm2MBqLFmJ6zxIwq7P/+mbJ9U=;
        b=iw4St26kOEJhkqBzJ5QXVtlICusl/0MzlnW/2r19iXc8h8cLVVYnY+1NYiy1pwCd9u
         GDsC411vpYwm6p6nCjX7ISFryRy18EQGOHeD067vj96YJ9D61MrsOr4gshL06Hjw1/qk
         arPFnnANKncWR1+GTpVoyd5XHzX24P9rjDeIbH4jf9WVatmQ20orvxbbxP2t4vVw0y2d
         JSYo2+pUF0RDB21PdyajpVAuP94Xo2Y9bi3rsZa7TCp6PUPiKshFYTOMRdlYYJ2gKUkf
         B7V9Dizw5vCtiQNQEKQVYgz+J6BwQ4+Hpxx5y3HcPW6zrTUc/Lphmd4F0nXI4EeU4N2G
         W6bA==
X-Gm-Message-State: AOJu0YxsL046AlDnkp0AAJHtrDJIj+9/F9a4lQa7wVidFTQpKolwuV69
	kmFdyk+2Hp44S4Bts1QAMxgPoTck+8uC6aUiB+AwIQtwev/xHQjm37AqgKwKEIwXssH5paNgc/c
	gwQY1xgz8wRW5/vOin1yh7FkdAVCr7K/7K3VUz0o=
X-Gm-Gg: ASbGnct/h+nJDackXX7AhAY5NVoVWR0aP8Q/q4hEsOCJbmWUEIFbeaIZ7WRtmfvCZlQ
	OH/MTqrFR0bobDLUgai9KUYab+aoy+CdHZ4texNCM3Wo+nqmFkf+GV/4NXYuq4B1DmFpYC0Q9Ux
	QtQh0JM+X7JMMUt0DJlfGWge9nenkIoz5f2KbgS2lnX64b8lFavcDCNThdm6BmyK8fVEsGSY6Z0
	w+9A5ht2Q+81VnX8WuPeV3vWHdH4S4lZXRjqnSSCTNg9zM2RvNpkxOxSHLEff7jHCy+ZwuH2Ss=
X-Google-Smtp-Source: AGHT+IFg8LVs9MOk9Rx3YWo7US8b9c7X3gqslFHxlvAn9kwEtRpGOsNUrkk9WcMjJ5QlqXa7pHby1TVhJFo0yT3CcTI=
X-Received: by 2002:a05:690e:1244:b0:636:1f9f:3071 with SMTP id
 956f58d0204a3-63e160ff90dmr5286901d50.15.1760769824825; Fri, 17 Oct 2025
 23:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760607566.git.wqu@suse.com> <20251018041654.1144286-1-safinaskar@gmail.com>
 <edfa6dd0-5cd5-4763-8be5-ffbd855a0ee3@suse.com>
In-Reply-To: <edfa6dd0-5cd5-4763-8be5-ffbd855a0ee3@suse.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 18 Oct 2025 09:43:08 +0300
X-Gm-Features: AS18NWBppTMQck5WZ6kWqGdN8xhxSkna7tEXj4YzuhzxSH8NSlwPRBTy05Va3FM
Message-ID: <CAPnZJGC3UVQJ=3qMhSY8-K+gwSx9bXsjgCgfbFNjenPUM6Dnyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] btrfs: scrub: enhance freezing and signal handling
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 7:26=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> Unfortunately it's not a fix, but a behavior change.
> Previously we put priority beyond pm, but not anymore.
>
> So no backport to stable.

I absolutely disagree. This is actual fix for actual bug.
Many distros use btrfs for root filesystem by default, so
this bug impacts a lot of users.

I will wait till this fix will reach mainline. Then I will directly
ask Greg KH to port
the fix to stable.

Note this comment
https://github.com/systemd/systemd/issues/33626#issuecomment-2323415732
:
> Failing suspend may not just end up in data loss but also in permanent ha=
rdware damage.
> If you close the lid of a laptop and store it in a bag expecting the lapt=
op to suspend and
> the laptop does not, in a short time it will reach crazy temperatures in =
that bag,
> that can permanently damage the screen

(That comment was not about this btrfs bug, but it still applies.)

--=20
Askar Safin

