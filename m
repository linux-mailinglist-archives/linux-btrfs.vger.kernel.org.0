Return-Path: <linux-btrfs+bounces-15631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D6B0D752
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 12:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76929AA1DFD
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E96B2E0917;
	Tue, 22 Jul 2025 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pz2ofdMc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29D288528;
	Tue, 22 Jul 2025 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180095; cv=none; b=NLgwkcBDSz+98B9K7pTlAux/DHyO0wCfh1AjqJDqHDDVjlmuQJc80HLZCVVILr/n2sDiGWrCZCRHU24YngFEM0ZZ/RhlwpIjZ9KuLFkMidg0C8aCXzOwC0Xuvkp/NPYO9lzReCV4v0VKKoR7nQzi0ZhVzMtAPpe73eeVV26qvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180095; c=relaxed/simple;
	bh=wAQp4UJPt1k6OlL+SfPFcrPM2o5kvsPngTLM2IfRLuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldvMcn/kOOmRDTHMSoVJOhHLKB9Nv5P1TNp3DoqonwIc/YR5VmTBaRv7GqBMOXaqqswHdXeXsiXwKhuFpPyUezCa7eUsjZXlpjVbqDt1JtSPd6OEj3SBkk9HP6btJboHJCG+oZvs2IEiXFdqBd+Q5b8sAg9Mhlh+AhqTlOrVVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pz2ofdMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CA7C4CEF4;
	Tue, 22 Jul 2025 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753180094;
	bh=wAQp4UJPt1k6OlL+SfPFcrPM2o5kvsPngTLM2IfRLuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pz2ofdMcxzqXDXtUkVA5VQRbKINhlIbS0XGYcxEunv+nFo3g09ayCftjR+vpoKfVv
	 M1U+Ovd2RSxrVRJsBUxNNj7tZ3YK0tx5tFjf+lmjkBAwDjdfGzPFe+FRpjmViHHoAQ
	 bVgiMun94vA40pPWYFWEqpI+tdCoiL9uh9wWz9GKxYJYNAQ76KMC6ufngY6BzS3CUE
	 o8wnsO1NVemhCr66N+H2R1JtESDaYLxvIhWaaHZZ9ctN1XJ8Rl0DDUujtLaimmQ/t2
	 HLKGa+YS0EyTrIDqWYGopnO/sgfTOway4i0upV+rdmVOuXLj2/ZOEZ3uGdMrTyAX+O
	 kPfrW2WHcALjg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so8294472a12.3;
        Tue, 22 Jul 2025 03:28:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHe6q0I+RM963sAuWl9w/jWVVu/b/HKK5QH+Ldl4VoH0MBkiTw03fZY4R0/qEcLsM1tPy7DqHVYSrn@vger.kernel.org, AJvYcCWsz3aeb3nop2+5XzmANBoJ1tMa0bqdP+NQQrIGaDtaKA/h2Jn7c8K1tcYy9cv/aMI0IrDY0r97Xh4XBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwauVXg6bt6dl3ZJYte1b8oF6DTew4plmz3u8uJ7EeAwq2uuXRR
	kVJtPpp/bV6K9wLrWgkTEuusaygXWShXAb7XuwJjsExVdETt9YsNiZGZjciyw5EFwub6Ejf3PzE
	AHruLWJ7KQ/r3ok2BURSDGpO3wnqr2mk=
X-Google-Smtp-Source: AGHT+IEPSjUrslGSRpOWvpB1GW/LCK/sbMGWwMUpcChwJ3pu+iv1FYXXHDi1+GVwsbFQKOIypBLCYViInLQpRAHb/IY=
X-Received: by 2002:a17:907:9617:b0:ae0:ca8e:5561 with SMTP id
 a640c23a62f3a-ae9c998730cmr2209096066b.13.1753180092691; Tue, 22 Jul 2025
 03:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com> <aH81_3bxZZrG4R2b@infradead.org>
In-Reply-To: <aH81_3bxZZrG4R2b@infradead.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 22 Jul 2025 11:27:35 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4_Pc8F6QA4qY420MZzpF8gyEXsr8Dg83UksSBG2mmWCw@mail.gmail.com>
X-Gm-Features: Ac12FXzq_Sj-K7fr1Dp3rldndlCEdCE0U4TWo9FctGqXM0uq9DMTzNZdRyFwnOs
Message-ID: <CAL3q7H4_Pc8F6QA4qY420MZzpF8gyEXsr8Dg83UksSBG2mmWCw@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test overwriting file with mmap on a full filesystem
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, linux-xfs@vger.kernel.org, johannes.thumshirn@wdc.com, 
	naohiro.aota@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 7:56=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> I just noticed this test failing on zoned xfs in current for-next.
>
> That's because for out of place overwrite file systems writing at
> ENOSPC will obviously fail, and I think the test acknowledges that
> by forcing nocow for btrfs.
>
> But that leaves "real" out of place write file systems affected, which
> should also include zone btrfs, but the test actually fails there
> in mkfs already due to some reason.

If the mkfs fails, it's probably _small_fs_size_mb that needs to be
updated with a sane size for zoned btrfs.
Johannes at Aota could give some advice there.

>
> Can you please rework the patch to see that setting the nocow flag
> works first and only try with that or something like that?

Reworking it is late as it's already in for-next, but we can add a
patch to skip it on zoned xfs:

1) The quickest way would be to add to the test:
_require_non_zoned_device $SCRATCH_DEV

2) Or add a "_require_nocow_data_writes" helper to check we can write
in place and skip the test if not, as you suggest, as it's more
generic in case there are other filesystems or configurations where
data writes are always COWed.

