Return-Path: <linux-btrfs+bounces-17273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8B9BAAA77
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 23:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71883B021D
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8F24467E;
	Mon, 29 Sep 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IDafr3Mz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144B122A4DB
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181741; cv=none; b=n46MlHft11qEhjma2NktbbHcrCaptubR8YLx+pFjR9YhbVQvL+vyo6pDk3sPzqikRzSMqiOCNgQ7XnfdqCCWStp1+q0s4iJl+LVy/TUi9sO2PATesLZBxbiAIze0gTsSf3BOFxsUhZ++5YrdBEfQ0a1Qu2offS52Ut8X2u8KaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181741; c=relaxed/simple;
	bh=66+ImCS9s5O8hibzo78xGbhfxDpDVb0wuaO+c5fS7G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qstgSL2YIrFTnpXcVfJAY7wDa2fwBrdYCkJKbh9YU149d0x87wWBArJQEFkEfNlzCkLg/L8maCfuYfyXIOHsp1UJGXhOlM51BGk4FK7KoGxLFNnnASZWof1lb+ih3bChLq7LW9qrnl2gUanZwaeCqwwsotoctq3f1tpTGVwZxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IDafr3Mz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so322423566b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759181737; x=1759786537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8sA6CNO1bDnDziNleAS+cBDGZ9VDerULmylgqhGURPU=;
        b=IDafr3MzRIVvA6cKCbtL0ZkvxRMldzAWfvfbgwezku/4XZzhNKl9jahhO7dtNeeWI+
         Fv8/KN8vBPHBT3+pGXAiU2o5GCc2E4cU581vF9LSz16iGvLy/fNKH+rw0TJhEfHkkiSO
         8hcfT41OvruTSGRAQC/bGpzpTqHL7p0lKOfAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759181737; x=1759786537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sA6CNO1bDnDziNleAS+cBDGZ9VDerULmylgqhGURPU=;
        b=m1L8Pit8yP37YBaEtJWvnhn0jrz2ibgy5Ch/nSUmdNeuUfWR5enKUQS5Kw0/2VP2Wr
         Exwy1u71n9rrO/4nver4BeF58WVSYB6206mPYHG+co/ijRwYRLER37Fli4DkQBGnTMuC
         ZN1nONofS/CUVnQ5DEWEJf76/9JPp4eh1hF2w1SOhtU0ayMFBD87clDtIHpdLNY4sdXL
         WoVfgz6B0hB711e6792iT4v03HborM/4Lh8K8Li3+J8zr70eOYjvikngMtcCUYoV0UgT
         P9AklwB4bSE7Lh6Odyu78x6l3TV2FPoTxURlo/CAbJYz+kJT2qmwglhXikX40aB7WcQK
         YSmA==
X-Gm-Message-State: AOJu0Ywm502yVViPSU625XThXoaTH2+BqxtKe/5AYeplbY/TIolPyprX
	t/RIh51yGor+1Qtbp3jJMfqDK2KNMZjQcGr/DoOEZOTYM+nk2UenL0aSvKOd5VDWLSEpzyhc7Xl
	fT0Lxs9Spcg==
X-Gm-Gg: ASbGncvUMh4AZOOc3gXtPAI/5AapmPhrFdPW6g1EuoNNiUA6dLf9MZnIt7jbDABprPe
	FMq6LhTa9MTTI67bAevOLDWt+U7uqY+DwbMGDciUwXGu7wK4YCUIpg+pUioBaz5/C3cgVR9bEzQ
	v4hycak5ihP2Dt9b/g69uqHYM/ZiBhriIIIzpoAyjAYrlrUu1r4rWT73i67Sqcs2Zx3+tZb3UGd
	BBfyqP3U0UOyp0CLel7ue/TqBiuuUwqHs0YJbWIZplS+rDvS41KaIyDqxSTaw9s+AaLgN7875Uz
	JsTKUYQdGVCbmzqtxOt9nmOznu+vVnGuMKMObQf2oa+KYfi8gUsdYPur3Wdc6gkT3m3AmlPHcSy
	rXCg/20qskATsvY0f7XjVulbHI+YFEQBY4H814gGbzJe54RmcUmpad1N62926fdksPYxzTGkT1v
	xsgLM9NOnH1kORz/dUi0CHbhxZOdjh5qA=
X-Google-Smtp-Source: AGHT+IH5ORoUF17pZPx6sEUHc9Vh5jiZ28/8HuUNnO0T0E2D7sfopw5N0n0V4hghbig0bnldCEnFJA==
X-Received: by 2002:a17:906:1bf1:b0:b3b:eb5f:9f1a with SMTP id a640c23a62f3a-b3beb5fb01amr606815866b.38.1759181737162;
        Mon, 29 Sep 2025 14:35:37 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b40f9d0a652sm130091066b.33.2025.09.29.14.35.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 14:35:36 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b40f11a1027so190244466b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 14:35:36 -0700 (PDT)
X-Received: by 2002:a17:907:2d24:b0:b04:2452:e267 with SMTP id
 a640c23a62f3a-b34bc399695mr2148100466b.56.1759181736296; Mon, 29 Sep 2025
 14:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758696658.git.dsterba@suse.com>
In-Reply-To: <cover.1758696658.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Sep 2025 14:35:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuu2-7z3ALpt6v7L3Zoa_cqz+imGNGwaL=QPGLw7eKNQ@mail.gmail.com>
X-Gm-Features: AS18NWAs8zD8K7JSR_3PPFlZf-NPA9cZPs8jLwEZYioNwmDaW4kMauzEDvSDsho
Message-ID: <CAHk-=wjuu2-7z3ALpt6v7L3Zoa_cqz+imGNGwaL=QPGLw7eKNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.18
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 07:41, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag
>
> for you to fetch changes up to 45c222468d33202c07c41c113301a4b9c8451b8f:

I see the for-6.18 branch, and it matches that commit, but no for-6.8-tag.

I suspect you just forgot to push that one out,

            Linus

