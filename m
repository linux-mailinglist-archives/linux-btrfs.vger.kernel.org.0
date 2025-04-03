Return-Path: <linux-btrfs+bounces-12765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD70A79D95
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27AC3B6DF8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 08:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D639723F296;
	Thu,  3 Apr 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ry7HZv72"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDA1862
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743667293; cv=none; b=ZCeTmQsKJtYmW7mQcaMZxkN/ekXr4fxGTFhgc/hplXy7gS/IPtNp3BLglh1jQc4tsIQ96vv0TB5uEKBbe0HF8J3RgQzWtRJ2woKCOANcAa51Awy+KIox4dD0eOUQiskFQi0JM0NxGeXuq7Gb6QRlSmG2mJNT+X5JkjntC81KSZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743667293; c=relaxed/simple;
	bh=eWFNROnVGvB/k3c2iV+aobAI/qdAERciNgm2Yrk+qn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/HtiJ3sDv3/W/nq2iIsGgVvH/8wgx8dak40fxi9emyBuINg6LrnMDq254OPuOadyw25/BWIr9MqvtDCo/TIGIN8GjHsIlHzGUuI/Ce1PTglbj2Y41ysHGXeXv5OB4JbhWqGbKwq5C7PeulMCeyCfN/0s0OE6tvG0DP9cAKkRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ry7HZv72; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbb12bea54so147665966b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Apr 2025 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743667289; x=1744272089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4EKJd4neIeljnEvpbxTrYN8effm4X3TGpCQRTfHjuk=;
        b=Ry7HZv72/3MA8tmuMa8QvH0ixTI+BM9x9HBjJzUAI9CUoE3emb5Acc0Odht1MLoQ5R
         vBxI/dqKFCIPQS6kmtF/PpEU8Ohbi8zFLDcSNyEqyoZubCFOoZ9noEzACr+Nm5QkyIpS
         FnO/wVV4sQOb+nKpkWbJ0Np6OpimNeObraj8gwFaMmNdeyWxRLdqyVw39rMuCqclTTO/
         qzfdlHUnWMmKQM2A54KewvqQOSqxGWBYTvF03Bet+Zeqvl4ua5a3W1BD5y9LsxctvPXX
         el99ijp4q7DjlG3AQgA1EphCklKE5oheO0ZX3t2B/ctYi34mSAc6EYdISr1KuNbixWPT
         QrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743667289; x=1744272089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4EKJd4neIeljnEvpbxTrYN8effm4X3TGpCQRTfHjuk=;
        b=KCqnjVaZSkskFpRfqmQsk/NhMzPZSBLB54lrrVcAIy1Y2nNNLZZwiKCu5CUsUVU6Zs
         K4MalKqUcN+EbyeEm9SqjH+hMCRkCoRVeNrTgX8ie0JFBUjqPZk2QbvZ6Jdr9c9GWY/e
         mqcwc8Ty4b9oPqPs89k7hF0tPTTD2Qt/9GIvTHFeKkVX/SM6rMbCstnvmchh8BgJ7lb/
         TxgRtHKQPEQizOcLnEq65h7/e+2ZGLFypJbRIQVYRLYqs5DRwHXGSDRr1uMs8rC847HK
         bv4KL8u8qXPFGbDiksW9BAfW2ChGI2xh5ctvBBzpDlW+q3F7xEY5YfRbOVOA5NKy/GJJ
         5PiA==
X-Gm-Message-State: AOJu0Yx9sExTjBUYZK4e/ON8GoZtv1KZ3QlrSuC9wyCBSNGs7bEQr9SM
	yQpmbM9Y3m8mYGiKKEwHv4qiYele2mM6PLzLW0rz6XSoMNV3lpAQd1aHUM+YVEuRhDJSkUZGR40
	6GXP016ebGl0YoW6dK1QZyB8awF3z44KSwRZvIIX3s0R1E7h0Gxg=
X-Gm-Gg: ASbGncvMIlG0e3IPQwY3KLwWlkYyZlUDRLFDdcqIX7S13Os1c0ABqAByyjx8mhJ2BZr
	EmzRezpcRDGXEd2Fby4SOin4U3wOGGhqexrITSrv+SeCpXs+tqNy4b/mjZPogbas5/Hk3ssxk0b
	628DvEtKDzq8VYOGuQRiixKr0JwJyBow5kKBw=
X-Google-Smtp-Source: AGHT+IGX8eksl3I3M8TNjtL1zSeEDr7OxjGQnluj81flEpP3elrBmwwlmeB2sbksxexvMSQJHuMfdzOJ9AA6gtEaeMY=
X-Received: by 2002:a17:907:6d24:b0:ac6:b853:d07f with SMTP id
 a640c23a62f3a-ac7bc068b7dmr150781466b.2.1743667289277; Thu, 03 Apr 2025
 01:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1743549291.git.dsterba@suse.com>
In-Reply-To: <cover.1743549291.git.dsterba@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 3 Apr 2025 10:01:18 +0200
X-Gm-Features: AQ5f1JqhcUBXERiMavE4N8vKL9OuwWYlmnRbNSpLG74aG_HIJFNCmNyLp25BHcA
Message-ID: <CAPjX3FfOq9D6Zq2BueQZadq0iV2EwcJU=5cYc9ZUbyXhRHP+Kg@mail.gmail.com>
Subject: Re: [PATCH 0/7] More btrfs_path auto cleaning
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 01:18, David Sterba <dsterba@suse.com> wrote:
>
> A few more conversions to automatic freeing of btrfs_path, same
> separation as last time, first patch with the trivial ones and separated
> when there are goto/return conversion.
>
> David Sterba (7):
>   btrfs: do more trivial BTRFS_PATH_AUTO_FREE conversions
>   btrfs: use BTRFS_PATH_AUTO_FREE in may_destroy_subvol()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_set_inode_index_count()
>   btrfs: use BTRFS_PATH_AUTO_FREE in can_nocow_extent()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_encoded_read_inline()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_del_inode_extref()
>   btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_insert_inode_extref()

With what David mentioned for 1/7 the series looks good to me.

Reviewed-by: Daniel Vacek <neelx@suse.com>

--nX

>
>  fs/btrfs/block-group.c      |   3 +-
>  fs/btrfs/fiemap.c           |   3 +-
>  fs/btrfs/file-item.c        |   3 +-
>  fs/btrfs/file.c             |   3 +-
>  fs/btrfs/free-space-cache.c |   3 +-
>  fs/btrfs/inode-item.c       |  31 ++++-----
>  fs/btrfs/inode.c            | 123 ++++++++++++++----------------------
>  7 files changed, 65 insertions(+), 104 deletions(-)
>
> --
> 2.48.1
>
>

