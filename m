Return-Path: <linux-btrfs+bounces-15111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8618AEE1FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E681884354
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 15:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782428DB74;
	Mon, 30 Jun 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPnrti+6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F7283686
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296019; cv=none; b=d8MmzKo8BVA1CnVdeWPLtlmx9XmLCXlPwNPkLtmdlUjskyr9RIyMN3N9ndThFwjMn6i8kEddkNWY98+fipZ9iFfPYNEjG2lkgY0JqB+S93a685e+cXhR/L9OQjpwkXYzKonljCM+ibH4WAa0K/LRQ1HEl1DU09bDZUSKsWHuLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296019; c=relaxed/simple;
	bh=0WOGFQxCoixkUdLoUWkgUJodoWCdCsv0bEBqIaNpL3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3jxWZv5088xJIf+SJRT3MKEeI5cKU7EJ1BAVa1aHlXt4jp9HrpUGbxMKsKiVQdbf1VkHVh4TkdFo1jqkfjVzV5vpclhRtIUjx9CjKh61XR+vwLGJJlNyCZkYFruGpxBfTVEg9Hc03D91lvOk40LwapmDORN5PN/8esDJLKf4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPnrti+6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so8757996a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751296015; x=1751900815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGjcwKQYSNXYeJ0OA7fX6Sgli4WFH2P0/K78N0NNk9s=;
        b=MPnrti+6chywBxc9rKfwc9sApZWmAQIbUQW6yITMU7khaO9o//A/ouCXyxWwd8IpvH
         4uE/toT5fnGKT4uBoKqFh1lI2448N86jor1KQICpBPZSY/huBoyp0Rj6XjTMJ09WbMyt
         Uugu/f1ZT08E6aMvDOCn4ubn1WWruj2RWToQi/RKpmNC5OgFLt6O/8uMeJgSiQ3c2KY/
         L0UwNzOE2RGeVcQ8IeGNzo0qUQpBUHYeMw/U0tjbAsX5mgg3qKUhf6x7ERlLLp+aAdLD
         UPdvHrUXf6EmRnM918iQKMoLasMJtmxfk5d3lxWBiVwm3Y8MNcUIQ+IEU1DrJlHDnpe3
         wwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296015; x=1751900815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGjcwKQYSNXYeJ0OA7fX6Sgli4WFH2P0/K78N0NNk9s=;
        b=lMz//9SN5952k60x9zSouapMkBfFTpzGYgKzccFc4aPBUM9/DVO2xG0g1YzEugyNlK
         S3Bm9H8iZS5s5Zt9lgC5tOSBFfPRlHNHz+1ea0po2TcKMLLYRgp5Vt47SmnVtouGYJGo
         7ti/9Aai94vAT7ayRKGOgToMvsPd3WGmopoQU74Eg1bHUyAHfl9VymghdjmNPcxvuhMl
         6M6SnWr75nAzsPNA7CMX/Bkd+UDB6BHMUovbEYBNqI+uIJlkOY/i5aE+YLHmHjVBLMmX
         UPIkN7lUJBFSU/hE4eEtH4XHU34wLGi1GcduzFCEQRHUxw0/+wfN1XaO9kVMgtmieI6D
         KBXA==
X-Gm-Message-State: AOJu0YzjWgagPdkPlqkeG+gxj2m7WQyBV0dp0XtlOzDI2ArOmY6RijkR
	5TpWOzqGM9xMlfNDADR9ooORKaZC2TgQxffFBHLtluG5CiscDAAjzLEgFsRYZegKw7SFTcgC3VJ
	54J87+kSCVp/B1fbnp30dUljIbUbEI0mPTWzvfvb17w==
X-Gm-Gg: ASbGncs9A4olXMgNRHExE7vkrjrLMJTqjnJ0I5bS4UYq3I4XhFKc0eDpq7F6mKK6JRu
	OjB7PvgJEoCZpodiAlVOCYyAOGV6WZcP+WirGow2LntwqZWlm2R+Yw6EsFTOSTzeq5b4pwTgj/H
	eTAnpJelmvj1qDGOjNOj+gfdKRcVDJQgEHzg8vo436kA==
X-Google-Smtp-Source: AGHT+IFvJzFEhq7iQE2wOrlV5RZvubHpHIEUb8rf0VyPkOiVXEMOiJOmNd/rtIY6H73PVomaGGRKkD5G/fIee+O0ONk=
X-Received: by 2002:a17:907:9408:b0:ad8:9466:3344 with SMTP id
 a640c23a62f3a-ae35017d657mr1450242266b.43.1751296015373; Mon, 30 Jun 2025
 08:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630144735.224222-1-jth@kernel.org>
In-Reply-To: <20250630144735.224222-1-jth@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 30 Jun 2025 17:06:44 +0200
X-Gm-Features: Ac12FXy7QLh7UV4Vfl8wWmV84lN0Qg5QCnwprEmPADeb2-mWolel5Fu5RFZFNWI
Message-ID: <CAPjX3FdfQHhs6imky3g76+PNdZkxgj0U+CSa2Grem4eZ3Dursg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: change dump_block_groups in btrfs_dump_space_info
 from int to bool
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 16:48, Johannes Thumshirn <jth@kernel.org> wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> btrfs_dump_space_info()'s parameter dump_block_groups is used as a boolean
> although it is defined as an integer.
>
> Change it from int to bool.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

One nit below. Otherwise looks good to me.

Reviewed-by: Daniel Vacek <neelx@suse.com>

> ---
>  fs/btrfs/block-group.c | 8 ++++----
>  fs/btrfs/space-info.c  | 7 ++++---
>  fs/btrfs/space-info.h  | 2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 4259d955e70f..dc0b29ed46c0 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1417,7 +1417,7 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>         if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
>                 btrfs_info(cache->fs_info,
>                         "unable to make block group %llu ro", cache->start);
> -               btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
> +               btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, false);
>         }
>         return ret;
>  }
> @@ -4315,7 +4315,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
>         if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
>                 btrfs_info(fs_info, "left=%llu, need=%llu, flags=%llu",
>                            left, bytes, type);
> -               btrfs_dump_space_info(fs_info, info, 0, 0);
> +               btrfs_dump_space_info(fs_info, info, 0, false);
>         }
>
>         if (left < bytes) {
> @@ -4460,7 +4460,7 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
>          * indicates a real bug if this happens.
>          */
>         if (WARN_ON(space_info->bytes_pinned > 0 || space_info->bytes_may_use > 0))
> -               btrfs_dump_space_info(info, space_info, 0, 0);
> +               btrfs_dump_space_info(info, space_info, 0, false);
>
>         /*
>          * If there was a failure to cleanup a log tree, very likely due to an
> @@ -4471,7 +4471,7 @@ static void check_removing_space_info(struct btrfs_space_info *space_info)
>         if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA) ||
>             !BTRFS_FS_LOG_CLEANUP_ERROR(info)) {
>                 if (WARN_ON(space_info->bytes_reserved > 0))
> -                       btrfs_dump_space_info(info, space_info, 0, 0);
> +                       btrfs_dump_space_info(info, space_info, 0, false);
>         }
>
>         WARN_ON(space_info->reclaim_size > 0);
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 102fcc34ffe2..65cc36ef3f75 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -615,7 +615,7 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
>
>  void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>                            struct btrfs_space_info *info, u64 bytes,
> -                          int dump_block_groups)
> +                          bool dump_block_groups)
>  {
>         struct btrfs_block_group *cache;
>         u64 total_avail = 0;
> @@ -1890,7 +1890,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
>                                               space_info->flags, orig_bytes, 1);
>
>                 if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> -                       btrfs_dump_space_info(fs_info, space_info, orig_bytes, 0);
> +                       btrfs_dump_space_info(fs_info, space_info, orig_bytes,
> +                                             false);

This would still fit on one line pretty comfortably.

>         }
>         return ret;
>  }
> @@ -1921,7 +1922,7 @@ int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
>                 trace_btrfs_space_reservation(fs_info, "space_info:enospc",
>                                               space_info->flags, bytes, 1);
>                 if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> -                       btrfs_dump_space_info(fs_info, space_info, bytes, 0);
> +                       btrfs_dump_space_info(fs_info, space_info, bytes, false);
>         }
>         return ret;
>  }
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 7de31541ab45..679f22efb407 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -278,7 +278,7 @@ u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
>  void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
>  void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>                            struct btrfs_space_info *info, u64 bytes,
> -                          int dump_block_groups);
> +                          bool dump_block_groups);
>  int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
>                                  struct btrfs_space_info *space_info,
>                                  u64 orig_bytes,
> --
> 2.49.0
>
>

