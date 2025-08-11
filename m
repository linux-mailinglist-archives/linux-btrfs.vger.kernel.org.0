Return-Path: <linux-btrfs+bounces-15981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1826AB20165
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 10:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D37D189E667
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABCA2DA75A;
	Mon, 11 Aug 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCLnLDM+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950A2D94AC
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899733; cv=none; b=PcGRpCFz3P6W2obSFzPVpX5Ta3SAd+fsc9T3rXm2lsVzpcQ22VYvKkTVZ8bnR5pQMAhYqqMi7F+Xv4xPFJUV/lHqoHKsNavkrB7dqwNf1JzeiWiqeuW6zqrkvPGgRT6Nm86VHl8fU4QFAG9m90ElzuYrVQE0vX4WysFCn7tXtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899733; c=relaxed/simple;
	bh=rpTvtJ+aBE5KaD8v4BKQiA78gl7NglUmjs1yKHJHr0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7ARitSrY79TDt5sIEoEbdNNXixdueezT7brxlV/0QNePOWUhufAVygyHe4YB+jzW2oPJt9tsCYKNsy1JIGhGLzOXnSQP/H/2oRWA9SXrItKgsdxU+C0jzmHSjiCkfhy1g7pFNmWz4Zy6sI/+X2pzCcUv1gVI3yDpJc9UH16A+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCLnLDM+; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53921f6e23bso3115498e0c.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899731; x=1755504531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7TmraGnwzCIYhXS82axx2hecDr44nzexZrJZhpmVmA4=;
        b=TCLnLDM+pOMo8Qs1ta3njJSkJRsPRetLwPzFi1eiliG/xV6Uqgh5na3ZL4v+7g1lMD
         VkGKdBID5m2+YVLBa4HNTWiFMR7qu78RtrstdSOv0dzObkrsnEJ2cQFvwegYmCIzYy/s
         2PfKXJ3kIsE3CDagvCWezv6A68Z/Py4Cyj4jf/F4E5/6b7/ORH3jtbJcgUIx9xTbklYm
         PQCx/qBI+GV07pwHEh18xaklzqxGR1jmWdi08GpcRXC1JwaCHd0yb39ocf+mMFyahYIp
         4c8iVxJviogpIls36SZeH2mrbJqbCh9habU3xlaufz40lPOrXfKSTi/3glfCfYrkDAtB
         XzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899731; x=1755504531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TmraGnwzCIYhXS82axx2hecDr44nzexZrJZhpmVmA4=;
        b=wSL8NPOAZvD8OiCLryDY2YCBliP8doRrZUFtKQvxm4c8Gr2L3MyrcKnGerWrg25wVQ
         NSSIYwiowfdu5acy8PFkvK/sGMPqWEZJ4wBi7whkj/gyV0Ov92G1fgIROsQ/GdqfumZa
         9PMcWKT+fqfDKRpf5A32QekUBXzZogXFohJtHbKej1nOJIcQ8i3Gkizb7RJavT6E1wB6
         Gl0h3N+RvVjjHXjL8l+2qbqf8WaAJKM3VZg1DQrMMDbOboHXoFjp1W+MC61JHQIHnKcU
         dcYejp8G1QdCr2PjVwVXsEaogzmdnhoZ6m7dILj7RxLll7u/1X6BDk152jsI7FyC7Qog
         7cvg==
X-Forwarded-Encrypted: i=1; AJvYcCX9xa8y1ii2mqmDQDB45HjoCzGW0D8SJZpEYqnHweybMQZI42R/oFaxTEs313zIEeciDEf/rYZ9YptiFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySuN8uuDloru18mlTGSmY/Rr67PYXHwJ/NeraQz7CoebZwK2uJ
	MZTf3ap7+vcCoUvnXHq2SqGgif+9VuO4772ie65dTIYGE9Aivfik5M/RmeX302tV9D84VEI4FBD
	saNIOCGT33OZDJmCsILTzx99OF0meoQo=
X-Gm-Gg: ASbGncvnpeZriSn1ZXvCY+8VvsuJ9dm1wOmJJr3FPXkhmGfl7IoUAAMD8aAGoIZuLAi
	k/SrVQOL460094/c8IGUooQ76ezfI5PL0F0c7cWca2VGJCNEp71U9LU2MOo//5WTXJfco4jSE56
	F38Bo13xxZ/AVd6oVU8huVlHyRLH8/3Db3vkfYhv+Y0g1G1JTKo2h46W44Zftw1TGHATyFgtw9w
	iz3otw=
X-Google-Smtp-Source: AGHT+IGAhhwEXjNAwb26pmxCJ7x1mCKt51vUkOUko1TIH/8Wu4u+phZjR4dO5TOdRDjowAxqM469BU2HTXZfjrzBtB8=
X-Received: by 2002:a05:6122:46a4:b0:539:8b51:fbe8 with SMTP id
 71dfb90a1353d-53a4ac335c1mr4291919e0c.0.1754899730737; Mon, 11 Aug 2025
 01:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728020719.37318-1-sawara04.o@gmail.com> <20250808145640.GT6704@twin.jikos.cz>
In-Reply-To: <20250808145640.GT6704@twin.jikos.cz>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Mon, 11 Aug 2025 17:08:39 +0900
X-Gm-Features: Ac12FXwgdsV_KPWSGXI1cq0pQPDU78C_I72bi047BeZu3ZvK7GOPUHcKZmukrO4
Message-ID: <CAKNDObASx8Nqd85AfzbEyMAC8XubHjcgZMzDbJyC_snYV-TJpQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: restore mount option info messages during mount
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, brauner@kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > @@ -1428,7 +1430,6 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
> >  {
> >       btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> >       btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
> > -     btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
>
> Shouldn't this rather be NODATACOW? The logic around the option is the
> same as for NODATASUM, but for some reason NODATACOW is under
> btrfs_info_if_unset() call.
>
> >       btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
> >       btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
> >       btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
> > --
> > 2.50.1
> >

Thank you for your suggestion.
I'll update the code to handle NODATASUM similarly to NODATACOW.

=====
btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
btrfs_info_if_set(info, old, NODATACOW, "setting nodatacow");
...
btrfs_info_if_unset(info, old, NODATASUM, "setting datasum");
btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
=====

Let me know if there's anything else I should consider.

