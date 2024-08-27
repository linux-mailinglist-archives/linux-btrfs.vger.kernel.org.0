Return-Path: <linux-btrfs+bounces-7596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95C961A38
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 01:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A501C22CA6
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B7C1C3F2C;
	Tue, 27 Aug 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AyuhluSz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCB199FB9
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799757; cv=none; b=ilBk19HVS1kyth4kBwCVgmJfBQuXZsKg1SR9Eoko9kv3Z9zeq8pcEGyZ0Zr6tpzVc20cz10/n+2u0NODxyTwb9gk3tOydZu++2w2tLljf1s30snlJJcjyEkFj7j2gzxwy0jnoLV2V6Tej9VWV+Uo4mWnl+luYP6GKc94yGQV+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799757; c=relaxed/simple;
	bh=vdQqDZTaroLio1ukfk11oDu5AoKLce7uMLDOp6N+EbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UOeaV98kKsbS+KbRlIUFjqQiZht7w4Hnx78KzqV3DZsxUuUE0V61ydHBvRXt1R8hCEj9qXd52NR5mtv+4K4ePaiGJtU/NPb8SD/Xh2oqlxWQgRQ1FbhEPUuo5S2G24tfdaguy5LswM+9X1s6tjqHTGHsbUXnS/1AV4JgIUKfunY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AyuhluSz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-371bb8322b2so22850f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724799754; x=1725404554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oUJL+S7jddsnnxM14vIXY9HdJTRDuzpwRs7nW6YY/fE=;
        b=AyuhluSzVjB3Nh4/7XTxVDyImwVoSSGSCs/AB1uHca/6kAO/PVdpVZW6YUdfb3D84G
         hiskbpOY3vJU94wWbk84KpIzpl3Nkp40guirr3lLnSD+Xd7mkLbeiVxbsSkmmJ6Yp50J
         RfgGYYo0ViURMiW0TaOipXpZ+k5OFSdrzOv9mX1StuQAkhAV25tawRNcXwNHP5lKWsJF
         d7gpAvj/Ne88jM5gdNb/rNyBcEPHXn86jC+ApdcVnC7Whx+HFYo4S+7JSwDFgVPsVF+v
         MKucRsYCm37nKW66W1yiimrRqCrWQU4wIfQIyr7tBW1uj/whDJjX1uK3xFzZTSIZbgCa
         6b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724799754; x=1725404554;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUJL+S7jddsnnxM14vIXY9HdJTRDuzpwRs7nW6YY/fE=;
        b=Fht/0UFJv1Ckum/4/QR510wuZiSUtIICyE2DpGBdOdhAjeKzq7caEbpGXOcfg87ABP
         A6NO4tFpwNKVyGAagrEveCDYj8Pn9ZvEnQDIOQ1KDAd4sxzCDJkMw8L3LmAxMll3wRVu
         b0gLojFl0igIw83fzY/Yce3LroC0Mo+nfL1f7NK8sXTAnMmrEfLbS5kz9ENFgh0kfSVL
         vHd6I8TDZID+6IZ28Y4tf/T34bZwWAK3+ti6qjbXB0vdM2fpuu0jIiflKHzV6Jp03RgU
         kyytu5iftl7wDeDn/tA7BFzHC0itTvN/2RMx6xzXNOh8mUKcnySUdfoAKVLOUzYpuYCs
         TrZg==
X-Forwarded-Encrypted: i=1; AJvYcCX10CxPVgQagenXIWYh1F2I5aw3vmtgjy+KsVh5lDx1R0DOwyW4FvC4j1yNqchuCZVVNcmMVaq0xz0WIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYGuEP1Pj2DGjGTLXDU68s/MRwBGAYEdQeojhpHUoHDzWg/JhL
	T2wc0RnQMEVh6nTSYKrYiyPXGQpVFoomqLPiqoUtstATtJXOZPaedQkuAPqbVfh+rUXRPfLMJkn
	Q
X-Google-Smtp-Source: AGHT+IHfeu8AqPVcwv3wYmPfqQkGpHNU/knCxCYkBPKgl4kBUSM0M5lhZS23kai3HqNMHDjbu+YiOQ==
X-Received: by 2002:a5d:6308:0:b0:371:82ed:245b with SMTP id ffacd0b85a97d-37495e917camr135879f8f.0.1724799753974;
        Tue, 27 Aug 2024 16:02:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d84467e748sm48896a91.55.2024.08.27.16.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 16:02:33 -0700 (PDT)
Message-ID: <49f29308-f177-4b42-852b-e0f6b28f5360@suse.com>
Date: Wed, 28 Aug 2024 08:32:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Renames and defrag cleanups
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1724795623.git.dsterba@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/8/28 07:25, David Sterba 写道:
> A few simple cleanups, dropping underscores and improving some code in
> defrag.
> 
> David Sterba (12):
>    btrfs: rename btrfs_submit_bio() to btrfs_submit_bbio()
>    btrfs: rename __btrfs_submit_bio() and drop double underscores
>    btrfs: rename __extent_writepage() and drop double underscores
>    btrfs: rename __compare_inode_defrag() and drop double underscores
>    btrfs: constify arguments of compare_inode_defrag()
>    btrfs: rename __need_auto_defrag() and drop double underscores
>    btrfs: rename __btrfs_add_inode_defrag() and drop double underscores
>    btrfs: rename __btrfs_run_defrag_inode() and drop double underscores
>    btrfs: clear defragmented inodes using postorder in
>      btrfs_cleanup_defrag_inodes()

This one doesn't look safe to me as the rbtree_postorder_for_each_safe() 
doesn't look like interruption safe.

The remaining ones looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>    btrfs: return void from btrfs_add_inode_defrag()
>    btrfs: drop transaction parameter from btrfs_add_inode_defrag()
>    btrfs: always pass readahead state to defrag
> 
>   fs/btrfs/bio.c               |  20 +++----
>   fs/btrfs/bio.h               |   6 +--
>   fs/btrfs/compression.c       |   4 +-
>   fs/btrfs/defrag.c            | 100 ++++++++++++++---------------------
>   fs/btrfs/defrag.h            |   3 +-
>   fs/btrfs/direct-io.c         |   2 +-
>   fs/btrfs/extent_io.c         |  34 ++++++------
>   fs/btrfs/inode.c             |   8 +--
>   fs/btrfs/scrub.c             |  10 ++--
>   fs/btrfs/subpage.c           |   4 +-
>   include/trace/events/btrfs.h |   2 +-
>   11 files changed, 86 insertions(+), 107 deletions(-)
> 

