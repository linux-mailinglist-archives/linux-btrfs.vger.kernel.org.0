Return-Path: <linux-btrfs+bounces-3797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDC892364
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A314F1C21A4E
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Mar 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F90B3B289;
	Fri, 29 Mar 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hFjCe2Lm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1A2DF7D
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Mar 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737157; cv=none; b=GTcmjtT3YtoE8+ogwfdsWzn9LcheeDDRv3YJkc8D7kNqYKirsfHEdQICtyz2KeoquMM0D1BFTN+6Ue/x3ALZhdOgmdCEiAS5s7wp+luqCGNboJEzZM6zfTKpkbfKdA54PeslRTxFBkfSyK+P4xd4AXfxoOosScqZxjKseO7nzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737157; c=relaxed/simple;
	bh=89P8xFdwNRsQGaELkVIPuf/jqJH5tKfLG5uP3475eNU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LdE+TI8iOsjZkTzi4HEb6aMQEgnQtoqJ1LlHwm2XST7uIEigR8BrwleirN7U2MFTjCbqFkFHr+MaX7wjJeX+SMMLFq/OoYERrElyKwy9YtLLabCqC0F9brExLTRXPV8iTOYwJZINlW4OdCfIC8MHEn6+y405FYWSjlDA9d+y/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hFjCe2Lm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6ca65edc9so566661b3a.0
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Mar 2024 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711737154; x=1712341954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Tpqpd+XowKAeNmFVUx3aaouhXhfs+V2Z4XDOcPdis=;
        b=hFjCe2LmIayRK0OKDXYJl9XEEtvZbBABnd3wQLhpypjEcemRyQ01K/XezyJXqBNTLa
         bL34SiOGAFAdQ2NVTEVNIeI6c10jp/V9TTJDjZ5KlNgEhQL+L/yJDSyRRD+hkcDqZJO6
         Iv68HGqeaqsysbu+jrj2bwaxzZvUsFeoxJDWKRa6RQ1ZY2g7PceSb7+1ngrJcfov1WCg
         MulcczUq1C7bO9oFjdRc5vjLcOmubG8e/Db8XadksQbP+3dG2ZlLxz9OXWLMDdfYV5oN
         X71r7CeKax1khlCC7qKQ0LEdFV1L5Iwgl8kR48TIwfSGPxMlUSrnGl2zHuIM6t7zA68H
         uRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737154; x=1712341954;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/Tpqpd+XowKAeNmFVUx3aaouhXhfs+V2Z4XDOcPdis=;
        b=auY0DqDaCJ5axf4FjccBAf2wvrxc/tHr5tN9shPdKCV+mBDSY5wPB26qajjriRZz0c
         sdn0q9g+O4jW1RWPoigIKElmRgaSxgJwFefJrvpmPN7wUYxQiutoQNQEvSlmZGfTdF7a
         HDvwOMjQKarCwBCU56a1VP8FP1T9LdewSt82gzgH3g7E4zRo5IaAQ9slNOXaLeMWE2mq
         jFEaWcDUnWsuhBmzoZiDphasl7LWZjaJuQ/KPq0u+jjRkDRa5+oXOVG/zmXnA54mfoEx
         om3jHRY1JBV4kz9vMP+EUZ5sm1c0vJe9oWwJj03C2V4R2gkrXF1YJN9u2kqLf+mZf6rr
         H7yw==
X-Forwarded-Encrypted: i=1; AJvYcCUUNmAc4i5tFJ0iAeLjtgnpWSftSSXe/kB7UZe1vogRba6fZLUtfkMZk0lWri5r9NWAFveFRl+9O3nbs2BLOqewB1LihxPNSs2OFXI=
X-Gm-Message-State: AOJu0YxrVvIaMeE5SRw7N0igjkC7seQ1apHWGCcIieC1AvRcFDZh1JuA
	jYUOyYiVQxPKmvGyUOD+8G5MUnKJJ4CKQHd5EY1k8hDsZBrmp0v31+agje9lnK0=
X-Google-Smtp-Source: AGHT+IGSjkQXsoReNcWtU/6vP8JEFFqWZTeD1QWgK0mtAmmxGqQBkW918F/Y7oP7x2jW69IsjahdEw==
X-Received: by 2002:a17:902:c255:b0:1de:e8ce:9d7a with SMTP id 21-20020a170902c25500b001dee8ce9d7amr3120790plg.5.1711737154073;
        Fri, 29 Mar 2024 11:32:34 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:a5ff])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b001e0c956f0dcsm3748761plh.213.2024.03.29.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 11:32:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
 Matthew Sakai <msakai@redhat.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, dm-devel@lists.linux.dev, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-btrfs@vger.kernel.org
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
References: <20240328084147.2954434-1-hch@lst.de>
Subject: Re: add a bio_list_merge_init helper
Message-Id: <171173715281.870109.4128910475529577998.b4-ty@kernel.dk>
Date: Fri, 29 Mar 2024 12:32:32 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 28 Mar 2024 09:41:43 +0100, Christoph Hellwig wrote:
> the bio_list API is missing a helper that reinitializes the list
> spliced onto another one.  Add one to simplify the code similar
> to what the normal list.h can do.
> 
> Diffstat:
>  block/blk-cgroup.c            |    3 +--
>  drivers/md/dm-bio-prison-v2.c |    3 +--
>  drivers/md/dm-cache-target.c  |   12 ++++--------
>  drivers/md/dm-clone-target.c  |   14 +++++---------
>  drivers/md/dm-era-target.c    |    3 +--
>  drivers/md/dm-mpath.c         |    3 +--
>  drivers/md/dm-thin.c          |   12 +++---------
>  drivers/md/dm-vdo/data-vio.c  |    3 +--
>  drivers/md/dm-vdo/flush.c     |    3 +--
>  fs/btrfs/raid56.c             |    3 +--
>  include/linux/bio.h           |    7 +++++++
>  11 files changed, 26 insertions(+), 40 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] block: add a bio_list_merge_init helper
      commit: 872fb30bf89598781d90bd2d6522f230cdf6494d
[2/4] blk-cgroup: use bio_list_merge_init
      commit: e19efc6e5d8ed46f407737033ffc0bdfe0b8dc67
[3/4] dm: use bio_list_merge_init
      commit: d35cd999db51da5706fc4d798b69e189b998ac4f
[4/4] btrfs use bio_list_merge_init
      commit: 5d363e4ee3cf8d4c4bc68956d89dcded30bc7e0c

Best regards,
-- 
Jens Axboe




