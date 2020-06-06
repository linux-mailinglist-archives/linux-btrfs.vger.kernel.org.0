Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5821F07E0
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jun 2020 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgFFQRE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Jun 2020 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgFFQRD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Jun 2020 12:17:03 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC08C03E96A
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Jun 2020 09:17:03 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id v26so1606892oof.7
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jun 2020 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTdfmwoUywmWvPOB4eOqMK1Ot/GbVityD72WKBuM+Lg=;
        b=AO7PDw20LeYCdpIJitwlLb/iG9YA3FZFoxpy2eT2BfUjZ7D+Ut5nLSC+DN2NaVip7B
         S5G8rOo/2J7BEkXu8AAwzoGedg6LuC1k8hxzF84rvtnLeShHX9UZFEDjwNpib81sdhRt
         NW9P5oprPz01ED+tMb/xXk1JKG7g3toy152Pmy2Ho/JmqQt05zwHE+r9ecxDAwtX4u6W
         4YdeiyMEIoP6ZdJawTHd4VxXSlbIO4+0Z4CIulNU7JWG2z3umUp2LNRDCrtOk0H3iTw3
         CAelgN3eHXI9K9QljttzP2VtADp7U8yy9z/kQA/92OgNSxOp2VL8ECKIkZdm64Zhq+SW
         +leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTdfmwoUywmWvPOB4eOqMK1Ot/GbVityD72WKBuM+Lg=;
        b=TXJMl/N9s7YIRZv9zqk6Y4ZUKPQxXsq+FYbrd8J1ra4hF8YH1fELbU6YnoajZ1U5oP
         TPvJsO4JElaMG610+PZue3PTypnxGv8lDaaiHGjSozWqzQvHi9RZDSWWWz1W8XdU2MWn
         pd7ZIPMlWwhCK2wc3AQpGTipVClWjXdkBw9gAgW6xhDMxthaZ6p/dv8aptKbX0tGgdSJ
         hWDSxDSraTpTTDxGoOV32RE7zwLSyT9Nt60soLiuSgJUF5bMMOLs71iYF7wEOsnu2Dde
         A+orhF3kxdgTMbQnij2dn2HT3NTUh+DIFjcFL4exmr9NelxfWtVXfjvoJjIrtcpVSZKT
         XSNQ==
X-Gm-Message-State: AOAM533ckbNB/adaRyR+nzJ840MXn5OEfqix4lCXusbNwh0kc5cAmgDW
        AV0Y7AGw2mGPX+fnbmmTvYIFYMF3/LJn7oKxCduhcUNJci0=
X-Google-Smtp-Source: ABdhPJxUj6eHlBkfxMNWUUCRLowMAtS7hRLEbGam3HpGIZcGjeGaOKq0foj7WCwUw4MZjOArKfFE4Ka4UYS089Chovc=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr11858887ool.20.1591460222654;
 Sat, 06 Jun 2020 09:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTp+DJ3LQhfLhFh0eFBPvksrCWyDi9_KiWxM_wk+i=45w@mail.gmail.com>
 <CAJCQCtSJWBy23rU2L8Kbo0GgmNXHTZxaE2ewY1yODEF+SKe-QA@mail.gmail.com>
 <2ae5353b-461b-6a87-227c-f13b0c2ccfe2@suse.com> <CAJCQCtT6rnH75f8wC8uf+-NnxEsZtmoRhM9cE37QTR0TF6xqJQ@mail.gmail.com>
 <CAJCQCtSCzD-RtGH1tJjNN=PBgUfJARy0r1p1Ln0pU1eRNTmR9w@mail.gmail.com>
 <CAJCQCtQu4ffJYuOUWkhV_wR7L0ya7mTyt0tuLqbko-O8S+1fmg@mail.gmail.com>
 <CAJCQCtT=rStKTwUc86FyAp8C0D8eoRvgKHWYC3+e=fLJxJNUZA@mail.gmail.com>
 <CAJCQCtT6zXdNOeTh1YTrWwji_QtK00hhiAP96ysrHdeg-DU3bw@mail.gmail.com>
 <CAHzMYBRMqYK4tX5eqoO95=OwZb=uqzWrUE8ngvA1rO2_gqf+Dg@mail.gmail.com> <62395bb.90271dad.172426a118f@lechevalier.se>
In-Reply-To: <62395bb.90271dad.172426a118f@lechevalier.se>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Sat, 6 Jun 2020 17:16:53 +0100
Message-ID: <CAHzMYBTpuEHRBuNNB0seKLL7D+vAdvejdT+JGTjm9c_QyrFwQw@mail.gmail.com>
Subject: Re: 5.6, slow send/receive, < 1MB/s
To:     A L <mail@lechevalier.se>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi there,

Happy to report my issue is not related to btrfs, since I remembered
reading this post and noticed performance issues after upgrading to
kernel 5.6 wrongly assumed it was related, my issue is caused by pv,
for some reason sometimes it starts using a lot of CPU and the
send/receive barely crawls along, but it's not always, i.e.same
send/receive can go at 250MB/s one time and the next time it will
transfer at less than 10Mb/s, anyway sorry to waste everyone's time.

Regards,
Jorge Bastos
