Return-Path: <linux-btrfs+bounces-1614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD883746E
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8BC28446D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0147A6F;
	Mon, 22 Jan 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doEgu4N6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09347A40
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956356; cv=none; b=nRRdgQfCOqUH0IGRV4N5RJ3mJtPrx14Ms0TYXs0iWYxeaq+XsbDKo5vqajhFGbpYiKbSWKZF00i/q2yDnABxmrkxeeBtKjuxoNCLh1HxabR5UOuaBFoYG2jMguU8GxeyDZ2klFVTJE5q4rAxPfoWrN1w8ApYlq/AXf9Cb152WXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956356; c=relaxed/simple;
	bh=9Unx0SRVVfUrVw2jxt8ozR2w8LQVQXKBTjB533I+oVo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MhvlHa4k8nqEC0GjXJHRBT1LqW9nQv4/ep8EkwATEmPqJZoEYJROXsTVoEgBwRVGZkpMOPLk+ZZ4coFkHFezA82KEG45CXGRI6qSDdEP/diVoKP1jkOS1Rh8uQZYgODsZKejfi/PN//QROBW59qF934Nj93d6QEH0JkomoAOsBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doEgu4N6; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4672008b2c7so2723138137.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 12:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705956353; x=1706561153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Unx0SRVVfUrVw2jxt8ozR2w8LQVQXKBTjB533I+oVo=;
        b=doEgu4N6gOxZkrcd1oFfN0cDfzG8eN8lUbGnezRnSQ8UYVjghP81eJtvY29BSLnzkv
         jFIb1oUDzq5dOsmJ59u5A6diMzQJUaCXIeKyYxN7R1RbL1Qy3Rgahy6LQyzUMvoEA5N4
         KqZMgWh2l3AouDVfltklC9rltqN6fUD7sDfaPF/IbE8NJ84Z1YcntOPUQPmnlWAkAqA/
         Dtu0SmqVD9dyfocQ9xmZQZeobQUm0Y/n/AfrW11xyNZgwBKF0N48Xsz8D//reSXL5p9F
         MkPjS/pLLjB4SRyGyFkBojdL9+lJfpqHia6jyyV38iPuIFKg2eqg6BkWwu+uCeRHw1YY
         KubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705956353; x=1706561153;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Unx0SRVVfUrVw2jxt8ozR2w8LQVQXKBTjB533I+oVo=;
        b=uXRP2aZkkcfHvh3sl7HwVOAlOSr2TcNktCdDLqCXMgdiIbImR1EvsHplchWg8Fp+Sh
         ByWy1ze11pWX3QcKBnKEq+roueEOTRbFT2XtAiCh1psrPLTNmfvIUCh66aKOwVFYqa8s
         DEjb16mFm/xC491stHkyZqC8s0N8aOpd1ybcbfIvolyujkH0m+G5cR6353jKiBWMSQSc
         hHUyGEJ1OV01HTfCBK+zooT41guBfYzhuY3c7fKEcTUgGfbj7L6Fz0UW5dQTwAue8m7g
         eZkUMSY6ZtfpLQi6IzalfHGhub2v1usEgIrBevbLhWW+GAF3RMNiTkXvk6sV4B0DpYvi
         jaNg==
X-Gm-Message-State: AOJu0YzW6d35YvsdLa7R/8UbLeHpItuk33KYOGAusI5gCsvbsoCQ7TWj
	SNS68HFn6azkL7eiAMzSgqcRjK3hiUeVShJOWN5M5x5ce4SBFAs5oCtYGK7aGNGVgDEU6kYrumj
	TjCBJTixCaul3L0ZJDFYTfNkvdI446HxlEJI=
X-Google-Smtp-Source: AGHT+IFqgEjAgsFTKYM01eBQs95gZW1tpxkpalSPu3dZv+XysfHL9LhcsNeS3NOoVb0xYzhaMgjGv8cozfiKJC18VM4=
X-Received: by 2002:a05:6102:195a:b0:469:89ba:b437 with SMTP id
 jl26-20020a056102195a00b0046989bab437mr3420667vsb.3.1705956353431; Mon, 22
 Jan 2024 12:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Klara Modin <klarasmodin@gmail.com>
Date: Mon, 22 Jan 2024 21:45:42 +0100
Message-ID: <CABq1_vj4GpUeZpVG49OHCo-3sdbe2-2ROcu_xDvUG-6-5zPRXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: zstd: fix and simplify the inline extent decompression
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org, terrelln@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, clm@fb.com
Content-Type: text/plain; charset="UTF-8"

Hi,

With this patch [1], small zstd compressed files on btrfs return
garbage when read on my x86_64 system. Reverting this on top of
next-20240122 resolves the issue for me.

From what I can see so far it only directly affects zstd and not zlib
or lzo (with their respective patches) and only when it fits within
the page size. Larger files don't seem to be affected (and does not
trigger my breakpoint on zstd_decompress).

Note that if the files are defragmented, the garbage data seems to be
used (this triggers the breakpoint on zstd_decompress) which makes it
permanent.

This patch seems to be queued for 6.8-rc2.

Please tell me if there's anything else you need.

Kind regards,
Klara Modin

[1]: https://lore.kernel.org/all/0e4ae269b3fd0caf99964c16c98bdd67dbab7150.1704704328.git.wqu@suse.com/

