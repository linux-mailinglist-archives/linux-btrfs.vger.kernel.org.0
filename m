Return-Path: <linux-btrfs+bounces-6180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E899269FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C31B212E5
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA11946A0;
	Wed,  3 Jul 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPo7lfwE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6F186E2D;
	Wed,  3 Jul 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040857; cv=none; b=TvD+Ybd2nQty/wbp+SqyqDfDjIM4fZAyQbOmDM9W/5UEcGiim59UKyW0Oaoc/UQN9cSOIWh03QNMIiFdy4nQub9slMasHqtV9AbtqlEz+qD5RQs2Q3S5+RayjSmQz2FrDIdyZwBY7M3kNOUKxbg4GQgVC/pCRX7V59f/tOwnb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040857; c=relaxed/simple;
	bh=d3j3Jt+5xROvPvBtgHKISgptkKKHnFIIctEGnJooIDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXSBJABV3fxpJIYM/0pkjb1ZtpT998GbcdLlAcz9z8m7ZbsZLKMEl6JE8VVP0yy0AUFtcOaOqesMkAiB8IN+rCIm1wfeOji3hiriwn0a2Yv3whaan05ui0R7gqIvgnpKRatnPphzMHHbt8XApiURYuMpBzGATpijdwwfBQ2QXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPo7lfwE; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6512866fa87so14590967b3.2;
        Wed, 03 Jul 2024 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040854; x=1720645654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0SnXlEOPg3pOmAN6QKmu6lQOCIYqazBXlDQ6+OJY8hk=;
        b=fPo7lfwElNVj9Ila6pabAm8K53CKJWCU72QtYMYMqwiKn4+5zQA78oBwXTyMJCYUIB
         GEioPIxUaud/+kNk/esRiNg8sQqtQQ1tX+Ls/RjjF3RWfa/vHpIoMXbS692W4eO1mxin
         PvxMODYcPw3SCRVXo0ZUX6o3U4sOdeGA/kBI+/5BeV4hRMTMfcixjlTWDxMqLVbJsG26
         a7akB7VHBix37JbOrPYa2WoFbX0XuGPqXxIFUvaaiAVrfsPZ9Xu9Lq10rnzW9lf4BANk
         TfAPgpmhJv9Mwjicpg9IrP0brWvYgpY5V5ZnIwEpx673WDD0eUwX2LGKudlt4VUapiDU
         N2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040854; x=1720645654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SnXlEOPg3pOmAN6QKmu6lQOCIYqazBXlDQ6+OJY8hk=;
        b=tn2waq/qrd8WCGtcBVEmKbv7TgNXXLnz15slQHm2rce2gHDVysrR0d34w0YjdBUk1y
         MQyYSLFTFJTx/qgdBJiTGI5E+31cSM5p81UMT/drCYh2CDLU85u45usYT6AZJUMCuql0
         LddnJRo1iuerHnQrx+5lYDuCLhudWktEA72UlJc3fLnV/L/y2XDxr+Nd57bKbZYpVfef
         7TJu9Ir5x0K5XfG9k+FXGRDvLhXpoSxCHmP2ThKXXTet9EKb7wCLgT3MdnJlylEjhiUg
         fLdq//GOWeTSiJLXtiXj3kkjJntEE/V0nq3k3l6ishDx/+hM1Nghzm7gVn0GKwFPsUTT
         Qx6g==
X-Forwarded-Encrypted: i=1; AJvYcCV/R9UlhX5v9KolOoI9/BrrXEadrW/6oLmZa8K1bNHQk4Iah57FjhR4mPOrzTmre4DXwL2LBoAZus6yuPfrdSvljLKjblSZ63SUdHJ+Pdz9qTNKFyL7JG99UsZOpNlXAM75A+0zCZSvIlM=
X-Gm-Message-State: AOJu0YwvPzPlDLGMJ+3g/HA1z8MZBq36oOOIh7zyjzXYahP3qBkPBhnm
	3IJ2nJn3q8HrKV6xgpNEDat9Kt8SvNvEa8BR8Kxqiiun9FUYt78qCDZUP7mKTVrnruBtmSwssQk
	SnRZhxcccFZNic98mB4XZeUtZBIYyzyqE
X-Google-Smtp-Source: AGHT+IHRgvANBePYdyGn36Qed6OqdXiePmvi5R5cRU25K/Y8UM3ov1wQca6P6l6iyyoSORmTD27KWeJ38mnlX6Y1Yno=
X-Received: by 2002:a05:690c:d95:b0:64b:44f2:70fb with SMTP id
 00721157ae682-64c7350dad9mr141355007b3.41.1720040854422; Wed, 03 Jul 2024
 14:07:34 -0700 (PDT)
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
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com> <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Wed, 3 Jul 2024 23:07:17 +0200
Message-ID: <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 3 lug 2024 alle ore 13:59 Filipe Manana
<fdmanana@kernel.org> ha scritto:
>
> I'm collecting all the patches in this branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=em_shrinker_6.10
>
> They apply cleanly to 6.10-rc.

Yeap, as I wrote before, same problem here.
I tried the branch over today Linus git (master), and nothing changed.
But, good news, I can provide a few more details.

So, no need to use restic. On my laptop (nvme + ssd, 32GB RAM, Lenovo T480):
a) boot up;
b) just open Window Maker and two Konsole, one with htop (with a few
tricks to view PSI and so on);
c) on one terminal run: tar cp /home/ | pv > /dev/null
d) wait less than one minutes, and I see "PSI full memory" increase
more than 50, memory pressure on swap, and two CPU threads (out of
eight) busy at  100%;
e) system get sluggish (on htop I see no process eating CPU);
f) if I kill tar, PSI memory keeps going up and down, so the threads.
After lots of minutes, everything get back to no activity. In these
minutes I see by iotop there's no activity nor on ssd or nvme. Until
the end, the system is unresponsive, oh well, really slow.

My / is BTRFS. Not many years of aging. Usually with daily snapshots
and forced compression.

Less than 4.000.000 files on the system. Usually .git and source code.

root@glen:/home/gelma# btrfs filesystem usage /
Overall:
   Device size:                   3.54TiB
   Device allocated:              2.14TiB
   Device unallocated:            1.40TiB
   Device missing:                  0.00B
   Device slack:                    0.00B
   Used:                          2.03TiB
   Free (estimated):              1.50TiB      (min: 1.50TiB)
   Free (statfs, df):             1.50TiB
   Data ratio:                       1.00
   Metadata ratio:                   1.00
   Global reserve:              512.00MiB      (used: 0.00B)
   Multiple profiles:                  no

Data,single: Size:2.12TiB, Used:2.02TiB (95.09%)
  /dev/mapper/sda6_crypt          2.12TiB

Metadata,single: Size:16.00GiB, Used:14.73GiB (92.04%)
  /dev/mapper/sda6_crypt         16.00GiB

System,single: Size:32.00MiB, Used:320.00KiB (0.98%)
  /dev/mapper/sda6_crypt         32.00MiB

Unallocated:
  /dev/mapper/sda6_crypt          1.40TiB

