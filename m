Return-Path: <linux-btrfs+bounces-12958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D76A86063
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 16:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920DE1BC238B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 14:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60199202F9A;
	Fri, 11 Apr 2025 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B6JjTZE7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D01F91F6
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381074; cv=none; b=IhXI0xkMSvSppXL/dqjTliyZM2v8M4uds+Z5Hq1yWdRJMBLEJ+/XpM8h8ZkmFmovHVqR4fwNghvZUpxxc8HOJ04TIZHXg2dL/2LqTN/+X/0UVLKUxJiOYE6xolI9ZGCLMHsAAK+IU6IBNw3hHi0WcyMfre7QT0hyqoSdZNuRe0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381074; c=relaxed/simple;
	bh=H62hDkZOBjg3DErlwm1FGkIlvr4b9YKyzMshgw7FFGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Px5qQ9reC1wY82pLh3vRZIFpkkZQfxaP58hEr3Lqw2m+lpPg0p2eefFRNRcZSZxcYwGfTJQGI9kogrMho8exZ16IePrmRKNVypMbeYccxvXMAnNUt8jrHfrgRStbd1+iC/GM8IwLIGE9lj9A2kK5ANDnP64hISmEBAAhUHMiYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B6JjTZE7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac298c8fa50so330922566b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744381069; x=1744985869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTqsSsP6q8mOn8ZNBlshDwf0wAfiYlzPvzrbYj6Dpj0=;
        b=B6JjTZE7YZgtAKcQIiEeuS1GQn28g5rutKg+ytuZ1cl1ODFe51PEzTGkLL/Ju9Vn4t
         PRuSMJ0iGVH7k/X2Pms6vV9+bcoan7+grZLiKxChLlCpLD2Ehc9BLfySGVApToNClF5Z
         KxZ59NK/ND3Rs0ATQ8UWXMgVKxpHHBk0wdm/L05n2LZCrTZfyUXEH5EvhsYQK4F+ruhB
         uFUzTCagtj/uTPErvksQcFO2LPhkkOEdXSni03AKC8B9Pl80/IzN8AAx2Gcq0Mzwxrdl
         S/Y682QI0G6ZsXSrBd98OB72Uu3vZmpN1hDvJr9PpFcmqyC+2l5Cqfk5jVmIq4GnQ/Ny
         heUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744381069; x=1744985869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTqsSsP6q8mOn8ZNBlshDwf0wAfiYlzPvzrbYj6Dpj0=;
        b=HL0CRsY3ez4B75z9cYiEuPdirMV2+3YwT8QGRobvU7v74wmDrM/JAh+oqpPABbFnkB
         JFN8O+/W0tUulNA2quWjoVQ0G0cB2S0VVfNpIPFBn3t+nrqYLS/vV66JL8b577I4HAvJ
         Ke8+Dk7zKMoIunziKHseOPxP6PT3aon0QObLWnBa03pGBvwfPQJSbJ2PRCTUt6uQ72/9
         CrixKaboOMVuLzHql5lHrUYTpKevBCvHpQ+G4cuLUCFCIECWdM7mR2UzrVvU1WvifBhd
         iHc9S1TfU/rtUnBHmtjrWMmxjAM9OG+kNprvFWCNoca2iE5NIUkn8Vk7PBFnXE1N72e2
         Hb5A==
X-Forwarded-Encrypted: i=1; AJvYcCWpcNT/aFHY6DWRzoEsHh3MvqDbJ1TjE37P3tz6bu4zfEoI926I0N+kygZQhomRw4G1DHcFOcxLXgbFIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVsDpGb3ClGd+ebHjWq1hZX5vZfitbuIqwhJLiaWc5opxKDsj
	jXugT98Y1LV6FwAr8vhVL8bozjVNgncFpU7KFVbNISiRzTm4vvhcttKDKY+2zQ/Nri9kZ7vgik0
	Lw8SBJyTlDUXekGVE814vjCxbrS0e1Sfb2U49Hw==
X-Gm-Gg: ASbGncuoQcO4mt9yEOOTl1S2LDkzHm2RjD9Ky78NS9Ufv/UWKgHBg3d5Bv7csnUhpgx
	3J6JKZHJAW4zahXKj8JhFHs79U3sUbLONwxmy8Ffzz8SunpjGgP9u+pJotyO81a5CGwFYXFVzK3
	nwAkFYUvBx0VYHvmymDjnU
X-Google-Smtp-Source: AGHT+IEY8cLHC7dDvBg77RvvSDDvI4LLGaIX3QkmIM0yIkHyN6pRf0ULJgjqYOmJ4HljtZuv4Durn+nqnhJRPnU6ykg=
X-Received: by 2002:a17:906:cec5:b0:aca:d63b:3ebe with SMTP id
 a640c23a62f3a-acad63b4519mr193412566b.21.1744381069560; Fri, 11 Apr 2025
 07:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411034425.173648-1-frank.li@vivo.com>
In-Reply-To: <20250411034425.173648-1-frank.li@vivo.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 11 Apr 2025 16:17:38 +0200
X-Gm-Features: ATxdqUG88XaY8FJODqlLgLrNhPx5KOZKPJlXSpwqM9rMRoPUo2MrGKKgpFmjhLk
Message-ID: <CAPjX3Fe34HVF2JUi2DEyxqShFhadxy7M7F6xTA_yVn5ywHMBhQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_truncate_inode_items()
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Apr 2025 at 05:25, Yangtao Li <frank.li@vivo.com> wrote:
>
> All cleanup paths lead to btrfs_path_free so we can define path with the
> automatic free callback.
>
> And David Sterba point out that:
>         We may still find cases worth converting, the typical pattern is
>         btrfs_path_alloc() somewhere near top of the function and
>         btrfs_free_path() called right before a return.
>
> So let's convert it.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/inode-item.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

And what about the other functions in that file? We could even get rid
of two allocations passing the path from ..._inode_ref() to
..._inode_extref().

> diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
> index 3530de0618c8..c9d37f6bb099 100644
> --- a/fs/btrfs/inode-item.c
> +++ b/fs/btrfs/inode-item.c
> @@ -456,7 +456,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>                                struct btrfs_truncate_control *control)
>  {
>         struct btrfs_fs_info *fs_info = root->fs_info;
> -       struct btrfs_path *path;
> +       BTRFS_PATH_AUTO_FREE(path);
>         struct extent_buffer *leaf;
>         struct btrfs_file_extent_item *fi;
>         struct btrfs_key key;
> @@ -743,6 +743,5 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>         if (!ret && control->last_size > new_size)
>                 control->last_size = new_size;
>
> -       btrfs_free_path(path);
>         return ret;
>  }
> --
> 2.39.0
>
>

