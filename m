Return-Path: <linux-btrfs+bounces-1623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F930837666
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 23:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D891F259E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 22:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8E5364BB;
	Mon, 22 Jan 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hKRMANR7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C8101C5
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962919; cv=none; b=qII+Z+Am61xotY45uD0bQhb6By83A0Mri0wUTPmhXEmrVmW/m2bBnpYwgdiM6wh03k47tdaiOOOx9lKW+5Hr98sGOiLJTLD5pOtm6wpp/4/d9LfQc+qvs7oMuGSAUoRjqZIf0c94H20poFL+wJOa03iRUJhUcLoLxDo2rNUVrPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962919; c=relaxed/simple;
	bh=ut2sHK1cYuimB9D9KMgHzTslY/TVKrAQ/ElwwDiRfRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0Ivm0cXeCFhNc3ayKSAh7yRQZedanlJGbMKzEfHj/lCWWu4vl8vQxykzvCggaNHmLXTOx/Q2qIy3u0ViCnrv9GCduUXN0G+hqxtFTq6Q6exdSOAwYBtrjmbMcSEwm2ZP+caHcK88UgfLKulU3GR6qFEDygCkmDT51RRWfORu5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hKRMANR7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so49371201fa.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705962911; x=1706567711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAXJjzRSHBzKnL2wNCpgqHq5fkln8HHHx4MUGY+C8nk=;
        b=hKRMANR7qZs/lo5iRScAASeFPSmtx8hcX6XR3X3v96MuhF1bHK69Qb37SfZwifT+PC
         6nNINihMchaGzSlvTJ0puG4pfot4/H50UxEdi7WoWL1OV1GZ4k9ERjx2mHpLsyp9Do3j
         T5MsBTk6jNsuyZV67pgmFzGD55jMKXDaBwZVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705962911; x=1706567711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAXJjzRSHBzKnL2wNCpgqHq5fkln8HHHx4MUGY+C8nk=;
        b=mbRLeqsnfx+VpgPKAiF7q4kB0iwh04p+iTmf0Jyemd8JkNUIayCFjifC7eLnAMSX/H
         QagX/ECB6l6X6BTQt/whjXjoJkb59SHOOxvE2hsV3Dr/PB3bntgH+ROMpARqy7HkDMwQ
         lFOt2yWVjqUreJpoj0sUQfHyFJar3p9lY3b/sBVac1uv/i9+mXDsD2GqFzgCo0DDowwO
         nBnR6xy4PdB12TDyQa4WskVwPbm6PuO/GcquEaTuHxIXLYSVDb2o2KffhoDRBRNJfN8w
         P4zUwVWYaW0jbRHvcvGtRdpMK0M/oBcNzTns73Eh1emS+dveaeZncA0ITTxeQ/eFufUR
         kn0w==
X-Gm-Message-State: AOJu0Yy8sU3Wwu+0T1QwaTSX9TTVX2wykZ3800aeSVi2et6uwxlCi4u2
	0lbIpRsvlWz0z/YQC0j1tbJnpcK1dIJBKX5K40gQNUPB0WmCGGLfXzHQZ7eKJJTKQ6iQXDYju+b
	nB5yNHA==
X-Google-Smtp-Source: AGHT+IF/kc8ATl5sFJ9icuQIwj9DAEmVZDonsmlldAB0tGV6mPddO/k3tP8HAD9jS7Mx+BAdvvQKYQ==
X-Received: by 2002:a05:651c:50c:b0:2cd:f954:2314 with SMTP id o12-20020a05651c050c00b002cdf9542314mr2379886ljp.25.1705962911577;
        Mon, 22 Jan 2024 14:35:11 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7dc0b000000b00558fc426affsm12536852edu.88.2024.01.22.14.35.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:35:11 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40eb2f3935eso4203825e9.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 14:35:10 -0800 (PST)
X-Received: by 2002:a05:600c:4755:b0:40d:609d:d65e with SMTP id
 w21-20020a05600c475500b0040d609dd65emr2785432wmo.177.1705962910573; Mon, 22
 Jan 2024 14:35:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705946889.git.dsterba@suse.com>
In-Reply-To: <cover.1705946889.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 14:34:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
Message-ID: <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:34, David Sterba <dsterba@suse.com> wrote:
>
> please pull the following fixes.

Bah. These fixes are garbage. Now my machine doesn't even boot. I'm
bisecting, but it's between

good: e94dfb7a2935 ("btrfs: pass btrfs_io_geometry into btrfs_max_io_len")

bad: f398e70dd69e ("btrfs: tree-checker: fix inline ref size in error messages")

Not ok.

               Linus

