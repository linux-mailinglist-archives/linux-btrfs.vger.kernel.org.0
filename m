Return-Path: <linux-btrfs+bounces-14871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EA2AE46DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB6B4445B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CDA2505CE;
	Mon, 23 Jun 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FZiyt/ly"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4012248888
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688442; cv=none; b=H7OMUYw1JjAS19m/SXe7Tl9AcEmr2a6BL/4bvo5jtxDKgxmJt4QBYKPYYI32bRtKl7chq1mtSJKcwq4SFiBIGToLyxpQFUr69hiKq1m/XLbH9BTQ8YfscEDifaMU7rTmZvgxXQ429rZrdN99a561hYgqsqPv4jmQ4oyEFd0ms8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688442; c=relaxed/simple;
	bh=tWnCq/9mEPtHaaBmWH3pabBK55/y/KRXeuiRReG8sn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHY4n7UgUzJojJ1rYKXc/gAdNAyjfy9DL1aN58AXQR4iw4bU+PVPz7rm03NZzTo7JC7tEsdW56Mt5+TyjVJU/mmgDhF8RsRIjceYCdtMGYDQcdIs8XgBVxJBWOo3bIwb1PgvaKh1auv1BIF/ln6b4CPvvPJU8oj/UdBnVcA+Wbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FZiyt/ly; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade326e366dso782202666b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750688438; x=1751293238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ki8iTsQy4QSoINl9hERfd7wpZ5SXV40/WIWjcNeuycg=;
        b=FZiyt/ly1zko0nv4WdM2epSOYfDxq44N/93lDTx7/QIbVfnuJJ0AkZXf5Qqq2QHGGw
         svvT+mqbcda5IYoZRILJ97LD0j9kFLAiP8RIHybCIW4flOitg7FIYAAP5DYpa6LH9Gfb
         ZwrJELSEAisz2UZhx4h2eTsk1b67NmeK3Btf82xK4BAII4kfy80eRZroKVCJ2Dl/ApL9
         cj7r7qjkUK9T1WC1zsza+3/ZEEwBcNX9BJwRJGGCNfJBcjt4HzI2HA+4DUJ75tDGSgX+
         FyQjzH++3sZZakDqV7N/T0+r5TgbwIwO41smg8Y9UKc5q76DnCbaCKK7P5yyix6tFGOj
         ZMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688438; x=1751293238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki8iTsQy4QSoINl9hERfd7wpZ5SXV40/WIWjcNeuycg=;
        b=SkCJvnQpd8T1NofxdiWfQRmeTVIXHbVceRetcNtNIoLf3ScvC4AdOVVZoNBcLi/Ods
         Ts335UAOI8jipdb0FNwKSaeG1oG+wO1iUzTvC8OHQGslGxpPfzmbc/3y2Jvcai0QEIvt
         PrM3aaXfVFCdj4yxzs3ovPstgUtBh2gBFu7Hrcbl3N/Xper0DlvbgTq85ZciqXsWDDtJ
         Z+hw2tSSvDBdRMeoqmdigTV0DSyoRGPq4D48RMrDBUBuFPBjud2GFD3JPO/+Fgt2s3gq
         7svnMcm39mQfCPtfAE1y5MAd+sR1bN7bomlYtBmbP36QQYvATjx7qr/7P7ahbO8yDeSe
         o4jA==
X-Gm-Message-State: AOJu0Yx9mBxgJe//uIWqcsJQ2Go/5QpbzmuR1s8nCuYP/tsg976pmsEi
	bzgCd0qvKqaIHtRQBV8Lmx/ea5ia8Tg1j+2YAcE/WsFbhwWm3JCRe8gkCnuqy/IebfHD+fy1x7z
	yqDX8SF8fkc1eB0X/xSuQdvAt9jz8LAJYzWK2vWXFlpaXBXHgVWWW
X-Gm-Gg: ASbGncsvIJhtTmq8Z6AnY95jJ+tug+JyIF3zQm6Gjyc7IHE3AYmo3FkjjSyAr2bIOLc
	iosySYtlLx0Bs9IBscwLtqEA8EfmGXgRX8HlfCCrBSlqqm2ls2SoGrwbpcY/Y1LFT2+5eYa2/q0
	Ni4nSB5JMSLU1s12HD5OklvWzzu2twImbJU5qCfjDfrA==
X-Google-Smtp-Source: AGHT+IGsTd3FQUs8qShmMiqbL3PoCmqaqncUQQ1Wobuv2X09M+qRcYABGjnp3VnBKQarpFPGdfNao5dk75BbCUTZbRI=
X-Received: by 2002:a17:906:ef05:b0:ad8:9997:aa76 with SMTP id
 a640c23a62f3a-ae057ef77b7mr1116400766b.37.1750688438232; Mon, 23 Jun 2025
 07:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750246061.git.dsterba@suse.com>
In-Reply-To: <cover.1750246061.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 23 Jun 2025 16:20:27 +0200
X-Gm-Features: AX0GCFvDJMybSZZAEfu2XDkZ9NcuS7vcmm7EQ0KHbPHzEoKoRGP-1jJHAHodAnY
Message-ID: <CAPjX3FccM-MK2Ohfa+_1jKAwmXtv+5oCSUuDgms69NxuoCazUQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Return value name unifications
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 13:29, David Sterba <dsterba@suse.com> wrote:
>
> Use 'ret' instead of 'error'.
>
> David Sterba (5):
>   btrfs: rename error to ret in btrfs_may_delete()
>   btrfs: rename error to ret in btrfs_mksubvol()
>   btrfs: rename error to ret in btrfs_sysfs_add_fsid()
>   btrfs: rename error to ret in btrfs_sysfs_add_mounted()
>   btrfs: rename error to ret in device_list_add()

The series LGTM.

Reviewed-by: Daniel Vacek <neelx@suse.com>

>  fs/btrfs/ioctl.c   | 35 ++++++++++++++--------------
>  fs/btrfs/sysfs.c   | 57 +++++++++++++++++++++++-----------------------
>  fs/btrfs/volumes.c | 10 ++++----
>  3 files changed, 50 insertions(+), 52 deletions(-)
>
> --
> 2.49.0
>
>

