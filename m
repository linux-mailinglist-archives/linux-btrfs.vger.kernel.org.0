Return-Path: <linux-btrfs+bounces-6194-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA19274CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 13:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7791F21B9D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C91AC25D;
	Thu,  4 Jul 2024 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrLyJkrz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD831AC239;
	Thu,  4 Jul 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091945; cv=none; b=q4NOqj2QYigjVRO+PJKkGjbk/eGiK+B0SDc1TyNIywwywQq8abJlMmywt6Ie7KOR1tiRwprVUvJG4FSOB2KUwr5c7eFZYoByADboA70AHNNhDeYTKSVLpbpUrbl28S+QyScSmtZgYP4qF1aV1TPiMLO4T1xlnHc+DKXWLokhKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091945; c=relaxed/simple;
	bh=GCT0mvqtioHryCpvymDplb3ffd2k3pxu02LXeW77bLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuNqL1V+lCOgzqXXxKwCORYJBQtI6bhGqii4IV/nKIpLZpBhFeGamGAMjPSBPjZREP1H1xXONkVIXByEMcP7kaRSpSJlpG2adhMmKBGyD5uAN1iACEMd+DASf2i3SYNlDi3Grn3GAmuk2fNN7Qp+NyAqghJEYQvADfdh4SG+W6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrLyJkrz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-643f3130ed1so4915617b3.2;
        Thu, 04 Jul 2024 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720091943; x=1720696743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fNCmxKLZEKdnaIo1lzCkGEq0IJ2TD99MH/XAb7ZGOQc=;
        b=jrLyJkrz/0hi1HTB8w3bNOIF8jNPyqf4totEL3IuRADWQUzz063vu82/vyHrcetI8y
         XJ0UV4Mbyi8dBDDpCw4fGtKxxHqBhQkIajjO88f28uh3+GBK6Vf4cYTLO/ExDi/GIM7a
         LDai3zpxxSI7Isglb9h+TnEwnNiQUsyga2xn7Er1Z53Grwj3ZihuIVLuqhoN7T2Nmf5f
         ev0sAtmXhgyAHekqMBemkzKfQ5Fu1kPPedhLEPDmg1j2GBZ8GACLn/SSrWUauZagvY3S
         +SE30BIAc2dTFRmdij8wzVkbs2u3pLyljZzzMVXC0qQmBcUEuSkFrGNkiDeYSryTcHwg
         3sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720091943; x=1720696743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNCmxKLZEKdnaIo1lzCkGEq0IJ2TD99MH/XAb7ZGOQc=;
        b=ESik7uAJ9rq+WiTahK+GS/LSIGHuB247Mq/xP4y3cPcpBtk5XN/wD0atHcP7uPQq90
         v0KqkOCEzE8aO1Ud0HUYpMJFtx0TrznoXmDnss3toyYYHZdDhcTMX42Nn8jE4/2PY68b
         aHi7CIWmJoECjDxV0mztoemctSJyPLOTryxBkGeOUzBQpSnQ5YCGaPcwnucCcDUg8W9V
         2UDYm9vMjh6oA7F0bvBcMdYotacxkwz5DyXXW6aiSwYsrHqn0yL0wAwc5k4zIyvJMWMv
         li262btrdFWjWIGj0dawEs0Mrx2urwnFESBqsYcThhuwbm6f++c8cFvtqCcJh+Ino5Zw
         Joiw==
X-Forwarded-Encrypted: i=1; AJvYcCV7C7cR2Eevyqawuf+Ju72vc5gJwCT6F69GDpsUqkbxkyNqdHp9Y/s8Zxd/8UArRLSBniIP42z00lfzUMArVZofwSrSS/eIXFdiJoL/aYvBsXh4lYJKhatNJkp0mexu+HHIQVEOFXUYlB4=
X-Gm-Message-State: AOJu0Yw4zdDvpPJ3A2Wo57bik5ou3mCrp87OwVc15pMejm+g4ZMXm1gd
	jUrULMRL7KS/76NP/b6Y0AvjCi5E+HKXEJO7csDYZC4AWYWJBWLYPAuH2ZvPqCJ7HF/G3pooPIO
	rb958dgm6/kQqoI49YN3vLwXx87M=
X-Google-Smtp-Source: AGHT+IF2+QptZ2rBGc+sGQL3cR8V9h89I+bSi+rn6CRax7iFo5NdO1YA6DZd3WbbDoPf4L2Oi2e81nz0cOU2hWQjIqg=
X-Received: by 2002:a0d:e605:0:b0:64b:a57:8441 with SMTP id
 00721157ae682-652d67c500bmr11259537b3.19.1720091943252; Thu, 04 Jul 2024
 04:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com> <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
In-Reply-To: <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Thu, 4 Jul 2024 13:18:46 +0200
Message-ID: <CAK-xaQagqS0kePozkim7sB_Zi+8NrDRnbqFuLVQ3s4F+0WZ+DQ@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 4 lug 2024 alle ore 11:49 Filipe Manana
<fdmanana@kernel.org> ha scritto:
> I'll try that soon and see if I can reproduce.

I'm creating a qcow installation with everything, to replicate this.
Sorry, it takes time.

By the way, it's just me? (latest git master btrfs-progs)
 btrfs-image /dev/blah-blah loop.dd
works perfectly, but
  btrfs-image -s  /dev/blah-blah loop.dd
generate an image impossible to mount:
[gio lug  4 11:20:05 2024] BTRFS info (device loop40): first mount of
filesystem 496b800d-2f32-46bb-b8d0-03d6f71cf4b2
[gio lug  4 11:20:05 2024] BTRFS info (device loop40): using crc32c
(crc32c-intel) checksum algorithm
[gio lug  4 11:20:05 2024] BTRFS info (device loop40): using free space tree
[gio lug  4 11:20:05 2024] BTRFS critical (device loop40): corrupt
leaf: root=1 block=40297906176 slot=6 ino=6, name hash mismatch with
key,
have 0x00000000365ce506 expect 0x000000008dbfc2d2
[gio lug  4 11:20:05 2024] BTRFS error (device loop40): read time tree
block corruption detected on logical 40297906176 mirror 1
[gio lug  4 11:20:05 2024] BTRFS critical (device loop40): corrupt
leaf: root=1 block=40297906176 slot=6 ino=6, name hash mismatch with
key,
have 0x00000000365ce506 expect 0x000000008dbfc2d2
[gio lug  4 11:20:05 2024] BTRFS error (device loop40): read time tree
block corruption detected on logical 40297906176 mirror 2
[gio lug  4 11:20:05 2024] BTRFS warning (device loop40): couldn't
read tree root
[gio lug  4 11:20:05 2024] BTRFS error (device loop40): open_ctree failed

> In the meanwhile, just curious: are you using swapfiles on btrfs?

never used on BTRFS (i have a dedicated nvme partition).

Same effect also disabling the swap, btw, and thp.

