Return-Path: <linux-btrfs+bounces-1829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A783E277
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 20:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2361F234E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6393A2260C;
	Fri, 26 Jan 2024 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hiPcoD9v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FC20335
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297141; cv=none; b=DdMDBrAGmlYq/TtJlCG2AZvpasoWk5aSQewMnaIAauE7a1eQ+BHzdMQwvmDuUqsIqzDCY6nXh3j2wOz5nrerNTsSt9M7gBFrQKdRP24qWdIKHWGRG0WuvJpaMskggQIfJ961Krk95XAWDWoNZo+IzA1uoY7mLXsrOikqrGBQjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297141; c=relaxed/simple;
	bh=rUiNaZKR3Iuzu1fK+xJ+TVad4AnomEYlxpttSGZqYUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN45H2ofIZQhMCSeiXHbjWdGfCxNmBM94vN0l9J1c8+8QL61Mp+zZbNbU51/LntZ89h1Z3SRk01LYEybLgpObmhJyC4UeUELQFD7+SyP2U8snk56m9mY5SSazaMiMoXcVZp9vnShFhlKo8mwC3ND8E2gW+CBC5YTJdlq7IPKeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hiPcoD9v; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5102d488da3so137142e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 11:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706297137; x=1706901937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVgLLemGUp0dKHDCBdd+B6bdetHWY79sotP32hy6/1o=;
        b=hiPcoD9vgOxA32Ms8HIo0WBEpyioIENu0tg6MfaHyINAlsUSK/bNeN6CJdztgJ3GZV
         Gj7lHTWT0kvHzhmTWbdm0yIBDNIdPBPvkIg6ECyfsgzA0bWxsDRCFm2t2HwpkJQ98Cc5
         E1LLN87wmaRunhtx5wpwe77fbYgxhjYVYnaHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297137; x=1706901937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVgLLemGUp0dKHDCBdd+B6bdetHWY79sotP32hy6/1o=;
        b=isSqUTKh2WyTrxWrEBlSjU6LQATI0C6TeTzI4hVQgYajnbbmsJoQA4fjXIy/Rm00UH
         VCHfPwmhWZi/DvssuyeJRtzdE7anlgDTKQH3NZ1lIWTA1zFH4AH48WFqeojyKdPdN3bf
         rcc2jziDvIoXVNMtULLaHCAviTiPBnKqUInrarofyHxt8Zr5rq6f6IaHyaZhEmGj5Dkx
         qNkMl71T7o6SOkimQdb1MmA1EhUiztnUd3q9Dg/Y8Bt5HLuswYtqQ0S5GTQMbYkvDPFH
         573GAuC/TuZsHFcW/xxD03vJ/PvpfNe/Ki77rVSOPDN9SLY903RIWZqJNldqUM2vAO4X
         EuSw==
X-Gm-Message-State: AOJu0YyZ9ylU61F7LY8v70vPOjXlxFTdGrz9aCLRygyADn199rqvEzfi
	sUDYLeta51WsV/VBxYgI/tuc3jmnKu9Fp1IwGy3nvxTyIuyQf3KZhr3y+1C/WP+Mz6VuB0QUPWJ
	4fx34jQ==
X-Google-Smtp-Source: AGHT+IHpKIu/X2o8JChm5U05nr0xpXga0YMOhMxcKJVsnG6p76R89TM2h54Nt4emUG80Fbv8Lq2QxA==
X-Received: by 2002:a2e:b705:0:b0:2cf:1c39:86eb with SMTP id j5-20020a2eb705000000b002cf1c3986ebmr180136ljo.31.1706297137282;
        Fri, 26 Jan 2024 11:25:37 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d9-20020a2eb049000000b002cd187bb0f1sm239294ljl.49.2024.01.26.11.25.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 11:25:36 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf354613easo7430941fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 11:25:36 -0800 (PST)
X-Received: by 2002:a2e:b8c4:0:b0:2cc:a67d:fee6 with SMTP id
 s4-20020a2eb8c4000000b002cca67dfee6mr236974ljp.39.1706297136223; Fri, 26 Jan
 2024 11:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com>
In-Reply-To: <cover.1705946889.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 11:25:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
Message-ID: <CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:34, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.8-rc1-tag

I have no idea if this is related to the new fixes, but I have never
seen it before:

  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  BTRFS critical (device dm-0): corrupted node, root=256
block=8550954455682405139 owner mismatch, have 11858205567642294356
expect [256, 18446744073709551360]
  SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
ino=5737268
  SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
ino=5737267

and it caused an actual warning to be printed for my kernel tree from 'git':

   error: failed to stat 'sound/pci/ice1712/se.c': Structure needs cleaning

(and yes, 117 is EUCLEAN, aka "Structure needs cleaning")

The problem seems to have self-corrected, because it didn't happen
when repeating the command, and that file that failed to stat looks
perfectly fine.

But it is clearly worrisome.

The "owner mismatch" check isn't new - it was added back in 5.19 in
commit 88c602ab4460 ("btrfs: tree-checker: check extent buffer owner
against owner rootid"). So something else must have changed to trigger
it.

           Linus

