Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA44A245ABA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 04:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHQCZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Aug 2020 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHQCZ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Aug 2020 22:25:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE151C061786
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Aug 2020 19:25:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a5so13381492wrm.6
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Aug 2020 19:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jEUZaEDUQSTSf7C7lHF7Aln1Z01sgdgXROVZF8Zr6Wo=;
        b=C+ShFzzktpoiKJP5l08IRxpwXGamt57YLE58yQY2IFb/0i1+rOsRnVB7JIQk9xS2cZ
         4WHTfj17bwDBxr2SvAyf9UNEfIe7wbSSSVRVsBNc/ZwhA9PIy2pwBnHOt5HfFtHdGwiv
         SfSu7cfZTe8OQtkt6sIB9VwNuQ6mhLWf0Qp+afy87w3vLsQaafUGc4Z11s7i04LN696o
         tSAEqfx81NNx7AoT8PfqmSIDm1Q1cVtiypLk7VukQtYOwjQD/TWVkfffwUQC4q6GdhrN
         l6BhHPO8J1ledemiVdBvTLIIvMUiQRbdxE5Gq639NtdzXjdH/bnUMA8d6XNxDSOJFx83
         HlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jEUZaEDUQSTSf7C7lHF7Aln1Z01sgdgXROVZF8Zr6Wo=;
        b=jDPS7RaJkDSm3ZimHHZBzUddoytM1VfPaFtrOXprrDjdHQvwHeEP/La5Bz0onlXTqa
         cGlHh6UoRaICCzlhcI/P6AMMl22tOfKTXb8Yq2QSXJpXwQrXqb1c7ywcIU/mrv8YUzmQ
         cebsNHmyr6z4tluVZea3m36dhpjEyJTu/5xSkcw+92EmkdQQTbIqmHxAXvmFYQZdgwkx
         S04o8lDn99EvdnXollvjcYR4x0WtqeiBR7jPiby7ptkuhX1BYjGqR7J/hxYinP73gxGs
         YFj5X8Rs0IDFeOF6cS0KkwhR9AZ5LMvmDryo5C8xMDZLNUi7LqO1wOr1+RlqY3hSG/PJ
         GofA==
X-Gm-Message-State: AOAM530R/dro8xsJWRuZh3trVOXF91dfAjPqtVNa9AR4Kzqmo59VKgQM
        a2hGPxGWx9T8BPE7rfkY1hI/2S1GMM5vr+8s7lpk7K3/KZTI/OBQ
X-Google-Smtp-Source: ABdhPJyODOT126J9zB+M3HuawIQ+ijXrdp7iEI0ebk8QHz7ElAS5tt0hNVdmH7hGCkCJ1bBKVjdlfA/3cxuB3ThSQgc=
X-Received: by 2002:adf:a19e:: with SMTP id u30mr12705989wru.274.1597631154745;
 Sun, 16 Aug 2020 19:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <004201d670c9$c69b9230$53d2b690$@gmx.net> <facaa4ae-5001-13e7-3ea1-26d514f73848@gmx.com>
 <000801d670fd$bb2f62d0$318e2870$@gmx.net> <940c43d7-b7e0-82fa-d5a5-b81e672b85a9@gmx.com>
 <000301d671b4$fc4a0650$f4de12f0$@gmx.net> <0839617b-8d4b-c252-1c74-4a3ff941ba6f@gmx.com>
 <003301d6726d$de5cbe30$9b163a90$@gmx.net> <13619e31-627f-92a7-6d11-1f8bbd6d7d6a@gmx.com>
In-Reply-To: <13619e31-627f-92a7-6d11-1f8bbd6d7d6a@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 16 Aug 2020 20:25:20 -0600
Message-ID: <CAJCQCtQo4yj=DSbH4JQZ0EiN5huXQwf1b7g0Bo826r53gSrWEg@mail.gmail.com>
Subject: Re: AW: AW: AW: Tree-checker Issue / Corrupt FS after upgrade ?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     benjamin.haendel@gmx.net,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 14, 2020 at 5:06 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/8/15 =E4=B8=8A=E5=8D=883:05, benjamin.haendel@gmx.net wrote:

> > 1. I am missing some folders and files
> > 2. Some folders are there but no files in them
> > 3. i can only access the drive via the samba share - not on the server =
directly
> > 4. In Windows it shows "28TB of usage" but when i mark all data and hit=
 alt+enter it counts to 21.1 TB only
>
> Windows? Why it's related to Windows then?
> We're talking about btrfs, right?
>

Suggests the file system is being used with WinBtrfs.

https://github.com/maharmstone/btrfs


--=20
Chris Murphy
