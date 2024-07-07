Return-Path: <linux-btrfs+bounces-6264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D7929768
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 12:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9306F1C20A42
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3658A1865A;
	Sun,  7 Jul 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6fA1lvp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124ACFC01;
	Sun,  7 Jul 2024 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720347341; cv=none; b=qLikwOvTtHNg/q7zh8rfcKq9AAH77/7jksNB92roEDtZvSATp6dlh1drDsUCkWQ/QNioHtcZ8SjgGjG2soqaeD1sfNZvTOGzNA2xnSOA5ljV4VCEG10xfUE1TtXdhwlYc1AziA4syrVo++mgpjKOHrkjg6FryRkiHQHaLh8u3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720347341; c=relaxed/simple;
	bh=eUaHBQkJAwD0CVBlzSy4TwHGZRVXF4np4gopUqWhSuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbDHNM7XOEXukkpJLMvXjgrP3YTnG6a/XdNGbMJsUtXYbfMswz+nU+FcgwNsot8EvaVvyzxX0YFF6qwcNQdFiU5XlJKwbjSsBFTXzud2Sma13RmF3ubVwiZ/eAGHzvtO/0HwZmaQSr4uzg1oQMrNnD41lg8+IQX5VD9Gijf6Ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6fA1lvp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-654ce021660so12404467b3.1;
        Sun, 07 Jul 2024 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720347339; x=1720952139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=haYA8zCd232ReaEmRsfrizMCl2vTgyxLHZZOTrCvdDA=;
        b=g6fA1lvpaHj1Hair9bhW+bdwG49pmcPxRMHs5U0v1wo9T+f+nwu673SKu1aXrcwr/v
         f/e4QNnxqHjAMs7zRZnCxTptSPQnKTsvx82IeM+y5GpHVgtDSiVlRu/bZfYMrfVMnPFi
         7LhRcwPiLZTKh8B6pO8IN+Ol35atGYpS2GcMMMYG+R6PD+UD6qdE3zl9iSZ0qJwqQtZF
         jYcgYyQNHbfSGwJnXRVrVT7poBSU81TJ01uoFfdJx3CVcab1OQClbfoT2rA0oyuQQbwM
         BCg6+wiVvThLWP6lDsQ13ZhpwZ17VxvWUdDRPWQYfprdttGPCmz13IlUB4L5CynUhblt
         PO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720347339; x=1720952139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haYA8zCd232ReaEmRsfrizMCl2vTgyxLHZZOTrCvdDA=;
        b=AHfHvbf0A3QprN5TmoaXCHUtvnaoHwRxvaNvlrjpL5Gp+0j4dYh9+z45d/jB6D0vNI
         9BsvocXxSLeaT9qEL6KNtkqbomZKI5kE/e30dz/64JcTcRCKTy7FiF01/0baB1DTD5Ik
         XOB7jSAuDr2G5glRfkRy3qBZr7mXPYGrYUFfoM3zM/02QRRH1BdTdEKxHP/nDWYa/rbF
         CkPotzTiZ8AHf94NPpZiGkqQuNE22rmnD1EBkIxNQvvIgIK6JCQp0DhoMQI4EsTm/Xi4
         6/+8wabYSrwIAv1jjBmjZFVFnWoQ1YKQ07QArOmTYGyrlgc3z31BZqKOuTQ3MYwIOcWw
         /Mtg==
X-Forwarded-Encrypted: i=1; AJvYcCUBjdC5/wRL+6gghWu9nis3pOgn9DIw80PiGb1RTSvU5XHBdm9Jg/w7MMM9Ulyxwq54EItbd71Zl/mi92lYO2gLN9VmaV0rOnNAz1CXhQnAgAkQ9G+8XrycYQjodEfRjBgMToh/LpmGusk=
X-Gm-Message-State: AOJu0Yx8L6g6KwO9XHQPemInEe2OcaShkj78w/wkoVa71JGl4o0Y1sDu
	tTD5iFnJvKYNmh1FtwXWmdNUP+AhWg0aX3X6tIohV8i6tKBZo7Pt1sBP+LdM4ifZK53Nb8+Beb6
	qRUkrE4I5Hpsah7Yz3UzY/qxKC0M=
X-Google-Smtp-Source: AGHT+IGygwB884S1pzqF9++b1CZgCYr06CpDJl/pef6QW6OozNvwBcUFN8yyo0XtbETsezlH4Lp9o+7IuTv3x8oFx44=
X-Received: by 2002:a81:8312:0:b0:648:6733:e855 with SMTP id
 00721157ae682-652d5344939mr85422567b3.15.1720347338936; Sun, 07 Jul 2024
 03:15:38 -0700 (PDT)
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
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
 <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
 <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
 <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com>
 <CAK-xaQbcpzvH1uGiDa04g1NrQsBMnyH2z-FPC4CdS=GDfRCsLg@mail.gmail.com>
 <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com> <CAL3q7H5fogJTfdkj_7y8upZj7+4dz65o-tKzyGf0WfLwm3nfUw@mail.gmail.com>
In-Reply-To: <CAL3q7H5fogJTfdkj_7y8upZj7+4dz65o-tKzyGf0WfLwm3nfUw@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Sun, 7 Jul 2024 12:15:22 +0200
Message-ID: <CAK-xaQaYDg60DizL3kJ3XKU5JD3kKVi3kecb2s18Po96T9tAHg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno dom 7 lug 2024 alle ore 11:41 Filipe Manana
<fdmanana@kernel.org> ha scritto:
> > Again, this is based on 6.10-rc6 plus 3 fixes for this issue you're both having.
> >
> > Can you guys test that branch?

Used yesterday and today. Seems fine. Just in quick test, I see
sometimes PSI memory spike over 40, but - important thing - no effect
on interactivity. So I didn't investigated more.

Well, just to be sure. I compiled the latest git with -rc6 and
test3_em_shrinker_6.10. Nothing more about patches.

Anyway, just for the record:
kernel: test3
       fresh: 0:03:44 [ 241MiB/s]
       aged: 0:02:07 [ 801MiB/s]
       funny thing: next runs of aged no more than  0:03:22 [
504MiB/s] (but, as I wrote, no problem with interaction).

> I just updated the branch with a last minute change to avoid an
> unnecessary reschedule and re-lock, therefore helping reduce latency.

Ok, recompile now and test!

