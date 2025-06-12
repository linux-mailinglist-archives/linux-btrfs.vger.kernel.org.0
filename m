Return-Path: <linux-btrfs+bounces-14626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E53ECAD7108
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AB1BC5A23
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9523A563;
	Thu, 12 Jun 2025 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dDZUi8Li"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123021E7C24
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733356; cv=none; b=dgwyfUx7lH7OSyhsazYbn0iRevf5BloXBLBpSXk23h3yYt2OCJT6fhAyhNNYMbbdYOj0Tv4jyAUkCdLCJEpMRmMBqSHNi6MQdB+GZMkxwevd4mHweUaAnspxAzHp9ZaaHgkgVRmFHYzG1oZVV1MmqGHONd+o5EgneyZPNx5LAzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733356; c=relaxed/simple;
	bh=vWGsSgWbMnq9QhXVtIXtZhIsIgMGXvmqCsE/rF2p7yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPAP3X01ew+NGHFaKbJq0YmxhrSZiYdKqSv2fszzStILJjcU1prp12V9w4mG/uTxPkprL4Q0Timwrvg5fXIPtXkh7dkTI6xr0VAR3WJm4LvtDy3gAa5pRhQJGsjD+b8fDnzq35savWTSxVYl4wY0aaiQ4ge1DrpfgCfK+98VAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dDZUi8Li; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so164247366b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749733352; x=1750338152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1MemA1QRwyzsmCE6aDnsCim9Vt3T9zO3OPs8WcHvs0Q=;
        b=dDZUi8LicG5E6hkPV68a6RjUpVZPxELyV2/eeqti1oUC51WgCOOL+ndjOm6T5m4I+S
         bdnqgtjktzyYUoVAf6LOthBwElt8soQSUZ9sf+sZyKYCupscp610p60oBnZCbbNVPE7z
         YeUJm91MT2XW4Tdv9XgSPZ73P4X7vxNoEwBITpYDhtvQ6SMpE36UzBc2YQtvPHVyWkTd
         Mbo4qLkkdsOcC0EYlyRCu2h8zVxUDlNHy+AcP3d/qIAgD2NkMHEXYQtRFNAkQ5c4jGoD
         6nFTc25imgw51c7neSFHGlIZxQixAhP0i7DSQ4QtU6mtKKF2qnTQcFzSL3Ahbp5Zd0QZ
         uR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749733352; x=1750338152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MemA1QRwyzsmCE6aDnsCim9Vt3T9zO3OPs8WcHvs0Q=;
        b=bIojRFOEYbhIZPLs2o55Sf1PzJNMz3yBbFZwN4F4aNkapxRjzci5yEMUTcdYxk8ATN
         +baqeth3xtdZW/FsjPtI2viJy0CziitdZgx4/bBmkig2Bl23AflRw/CPm4nlgdfVJiOu
         YCGumiIeR7JPKTMp4IGU3oIHX0Y2S2XvXSqrnwHn9iJLURijL/fq+bVcuzxIRx/R/9Xe
         6C8KbCSJf7GcELQIZGrzqn0iN8wL7xMhl2o9YU3FR38+xSFkS7pgiLF2ntzW/ilsR5E2
         B6znJXHADHD6Cyip64oZ/D/5v+5ewFMXfqFMiWAY3F7zj2YEmd1kjB9o11DZgchcsSsw
         RUzA==
X-Gm-Message-State: AOJu0YzKr6TeUNnmp4hOm6MpDrXvsF5SRvpKZim34SLwtBUKKh4GH/+2
	nsZHUSWyEve67vKpOb75c/+MB/wan4UyXDFflkVhmBJXtCzd66xhu26OvJ/mrdcjE6UXLxsAUl5
	ACxxc4RZ1hleOD6hwHgxRHQIQwW2Djl7cekGqcYLd4g==
X-Gm-Gg: ASbGncuygKeM4niRt+6N7+tItMAy5kKRaG5kjmP3dTrVkS8iTfdgKDrvcdujD1hntbB
	5brpyI0jZ++O2t3S4nspF7iZErkkupYs/wPFK/Miy0vwbG/lHWedFhCDCpBhJsCtUzZQAPTwfm7
	Kfqcf4rWIASIDXVWIU3W38urWhkptR9oguJxYECIe5vg==
X-Google-Smtp-Source: AGHT+IGukmzAGJHUGF8wOFEL47/jaEUmycdddnHENxPWp8YD/16YPm7j58eytWaT8uT3Jop/ztDtpLuKHihoOKqLk5E=
X-Received: by 2002:a17:906:9f8c:b0:ad2:3fa9:7511 with SMTP id
 a640c23a62f3a-adea2714baamr423306266b.41.1749733352100; Thu, 12 Jun 2025
 06:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749488829.git.dsterba@suse.com>
In-Reply-To: <cover.1749488829.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Jun 2025 15:02:20 +0200
X-Gm-Features: AX0GCFuHQwlA0MFn8DWcq4PYIwIaD2GCft9v6bHFpYP6Vvw8a7RhOTFUrp9hslI
Message-ID: <CAPjX3FeK3wnvj14noqoqV1dS-0s65M7aKkm-e5mWwAegmn_qpQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Clean up of RCU in message helpers
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Jun 2025 at 19:09, David Sterba <dsterba@suse.com> wrote:
>
> Add the RCU protection to the plain message helpers, remove the
> specialized versions, plus some related cleanups.
>
> David Sterba (11):
>   btrfs: open code rcu_string_free() and remove it
>   btrfs: remove unused rcu-string printk helpers
>   btrfs: remove unused levels of message helpers
>   btrfs: switch all message helpers to be RCU safe
>   btrfs: switch RCU helper versions to btrfs_err()
>   btrfs: switch RCU helper versions to btrfs_warn()
>   btrfs: switch RCU helper versions to btrfs_info()
>   btrfs: switch RCU helper versions to btrfs_debug()
>   btrfs: remove remaining unused message helpers
>   btrfs: simplify debug print helpers without enabled printk
>   btrf: merge btrfs_printk_ratelimited() and it's only caller

The series looks good to me.

Reviewed-by: Daniel Vacek <neelx@suse.com>


>  fs/btrfs/bio.c         |   4 +-
>  fs/btrfs/dev-replace.c |  14 +++---
>  fs/btrfs/disk-io.c     |   2 +-
>  fs/btrfs/extent-tree.c |   2 +-
>  fs/btrfs/ioctl.c       |   2 +-
>  fs/btrfs/messages.h    | 107 +++++++----------------------------------
>  fs/btrfs/rcu-string.h  |  18 -------
>  fs/btrfs/scrub.c       |  18 +++----
>  fs/btrfs/volumes.c     |  21 ++++----
>  fs/btrfs/zoned.c       |  26 +++++-----
>  10 files changed, 63 insertions(+), 151 deletions(-)
>
> --
> 2.49.0
>
>

