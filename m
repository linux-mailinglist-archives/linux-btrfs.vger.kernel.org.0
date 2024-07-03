Return-Path: <linux-btrfs+bounces-6178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5BC92688E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 20:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDAA1C22CC2
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB514188CA5;
	Wed,  3 Jul 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0H0J71L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E699E1862A4
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032482; cv=none; b=eeU5d7k+qN/v366pHCiedml8aywwHOXYKCGZjV1ghmtqEOnvUvhRlY44OiGG/1+25Spo8xGPkhVUUP/ZTvJPeYcPcPm6sT4ddT7IFnJzpm+8FN8hmV1f53qI3UFUoyi8kGtmPP4AWFN7qQMDj0vSaOj0A5rbL7V2QBVy/UVM0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032482; c=relaxed/simple;
	bh=EgWEh/gp9yblF4UU6p7rXjRAYUOLhM6UYZrU0sadLYk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=llka2yKpADeNfHfrLUvT7A//Eqd2ga9ax7Pc/v94r8WObAcfZ+9ciCqvg9EUWdy5fk9arbBSRACmxd2R8CTok6J8ikNAiOib7Tl1MCt8095MqsUy0gdfyDfLPDwUP8zVK6nGoUu/AhPZVycAbKB2Jj56FjC5Bk/hvktxnknq56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0H0J71L; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-71884eda768so3386923a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jul 2024 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720032480; x=1720637280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lULsH2LC27QaBvYzbeAvdlpOgz7hkDvBq5RMUg8Xb+M=;
        b=M0H0J71LmOWJrfeOC3Bp/og1LwT4Wcyt1OWXz9pVd/cn51QrKmdxqqJ3TWBpUPRNDD
         n8MAtp+iLl2+ZQrxW/ygXsyu4vv3OB1DlmMokXPvsQoXkhJpblNHXzXbsZJb+euvyPir
         R7cvkhiUFnHvFDQYSHBRT74EySdV1fjaJ7mcrliQ974Wi5UdTccRrqbgUV2rRQqD29y3
         yXN/LXF1DCp5nUkq5i4Hu3kdZE1uhhEfrOwLrPJlEVlDnhQXqNUR+90UlWHhv5mZROPh
         mWFldluHT7KQj4rJPGbSEMQwNIYLowoF9y4Ta1YzCvM9PXt3EdYsMve6jWlqG07y35p9
         24cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720032480; x=1720637280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lULsH2LC27QaBvYzbeAvdlpOgz7hkDvBq5RMUg8Xb+M=;
        b=Z0OptFmijXAj+ytp0/y9gQEermMzoYCUdi8jmGMYb45jQl7NQAUwl+4HDYj2u/oHeY
         52ksRMLFR3Q3MzRe2cawi6q2F+sC630jyAGE4NTgbizu+L7Z1MmD3gjBaljRBSI02OAQ
         f4wJ0joWYyOCM4QTeb+EcsXcV9JEoPwkAyn2bgGqiRT3AWYRgcqPl1whwqSSVVIZRK6b
         LsWI1ywHSgr3cNzE3FZAvP8FHT34ObPsE02yyVPBJszi0XVY/0/w1wKpDpkV08P1dfce
         DxO5Il7fB1lH/Tj+QhhPty4RohBMsELtMoIcckyO0PFwssC3K3a/7HjYR8Hp7c834xhf
         G4UQ==
X-Gm-Message-State: AOJu0YzJ+XnUWV/vKzVo4AR6hSG+tIjuoUF9G38fXrSUjI7MMw0psUur
	XCmXxhnnLWwVDjA0h00ibuh+fN3YzrlpGFt6AX5aZbOVwDfJgcdO8tMxJoKxXSevHl1FVohb1Hw
	+zkUDhjRkkbs5tdwID9kOkQDJvYupLpK+
X-Google-Smtp-Source: AGHT+IFznNmqS9GsK+f8fqMTvbCJRJIwoHQgmdWMvua0LX9KI9aS5os0cfMwtBk0rat4X+pBGXbe3fIw1oHN70dflJc=
X-Received: by 2002:a17:90b:4b4b:b0:2c1:9892:8fb with SMTP id
 98e67ed59e1d1-2c93d6d4a44mr8014095a91.5.1720032479975; Wed, 03 Jul 2024
 11:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Ed T." <edtoml@gmail.com>
Date: Wed, 3 Jul 2024 14:47:23 -0400
Message-ID: <CAPQz975+sBtZPfUQ6RUjkY-R85f+miMcd9mD_2d4zgFakMsezw@mail.gmail.com>
Subject: [PATCH v3 0/2] btrfs: fix __folio_put refcount errors
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Filipe Manana <fdmanana@kernel.org>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/2] btrfs: fix __folio_put refcount errors
Date: Tue, 2 Jul 2024 15:41:19 +0100 [thread overview]
Message-ID: <CAL3q7H7Gu2SQV+V1WMuVsuMmffAyKVTC5miagZVeitVQps6YuA@mail.gmail=
.com>
(raw)
In-Reply-To: <cover.1719930430.git.boris@bur.io>

On Tue, Jul 2, 2024 at 3:32=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> Switching from __free_page to __folio_put introduced a bug because
> __free_page called put_page_testzero while __folio_put does not. Fix the
> two affected callers by changing to folio_put which does call
> put_folio_testzero.
> --
> Changelog:
> v3:
> - split up patches for backporting
> v2:
> - add second callsite
>
> Boris Burkov (2):
>   btrfs: fix __folio_put refcount in btrfs_do_encoded_write
>   btrfs: fix __folio_put refcount in __alloc_dummy_extent_buffer
>
>  fs/btrfs/extent_io.c | 2 +-
>  fs/btrfs/inode.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

(resent as plaintext)

For both patches:

Tested-by: Ed Tomlinson <edtoml@gmail.com>

In both 6.10-rc5 & rc6 I was seeing many 'bad page' errors in my logs
during my backups, which create, send & delete snapshots.  With these
patches applied to rc6 the logs are clean.

Thanks
Ed Tomlinson

