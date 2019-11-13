Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEE2FB74A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 19:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfKMSYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 13:24:50 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:39389 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKMSYt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 13:24:49 -0500
Received: by mail-wm1-f54.google.com with SMTP id t26so3135946wmi.4
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2019 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NNhfvBcNK5tNTGoR1iskXE4CXsixvZuolbZz2MZZ5WQ=;
        b=xAiTdUnlLOk90Cl/ThswWCHrznI1OyA0dmBeLNj7iloRgQMOnNwGkKa+9taPeARq5N
         ZmZLWpYnq1aGy1NRfpEiPttSynTMKD6kP05RewnxpwWJT9POEQyY0bh8Sf2XoB1d2nPo
         qWl8RyonAPjNrsi+ji8O4KYs2/cmicJ9pf+GLcmZkYO1aES1ZkSsMuss4WLO/CXy+DTm
         9qU5R/NkL7KSMIxj6zoJicK590EBwe5W4Rlii34i3FddbzIbFfjc+y0bayC0dazJ6oe2
         TAvt9ZHqRK0zk3/6LwjY3hBvnYevA4XyUTVDzbD2SaFAjIGcC/nVueD+fwDoFkRyqrSC
         fArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NNhfvBcNK5tNTGoR1iskXE4CXsixvZuolbZz2MZZ5WQ=;
        b=QZCOUmpi1xSxeRdoRrBpD8u3kd80++vnDpTU2+JuNN9ByBBCHqMQpByTKbKx9f2alV
         O8BNothyUrUcERLNDja3fKRAD6hAQJ56OgcurEGGLYzg3SAwBOGp/5If1aKQuMrVo3DD
         p1IvshruPIAN4PaZmudRsHPomgd3owM/khObVEE1zK2AEdaRj4NlvZK1PkKzHyjkByFx
         p2Y02HT0EEBTHX4lqPxitskqeINNpVSyqPn5sLcHT9U+J/Kevu8WlSVsKpZb9+spPMqc
         nxc+GG+I4E2gpCwiVHydHlgdP0YEIDUE+D69mQ5A77lCWNZHWEbP9ApTmHKUHkTKOuIG
         7UQA==
X-Gm-Message-State: APjAAAWMwMdeUfl6dCvj5lTysfzybYX1Gk5smM16ghF5jLWJUowfY7AU
        DiSMOjbbW6/Uhq5lm4/hnIylzYEa5zCm/S9nmQTb3JieouRrVA==
X-Google-Smtp-Source: APXvYqzX3DAvebicdeFwDB5sN1dIeBAjMaCueGkJnhoPCj7nrLfZMciCThkzwBMAT4S5RyXR7sNjzNNjeNIICcIswrE=
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr4050886wmb.176.1573669487746;
 Wed, 13 Nov 2019 10:24:47 -0800 (PST)
MIME-Version: 1.0
References: <1591390.YpsIS3gr9g@blindfold> <20191108220927.GR22121@hungrycats.org>
 <1374130535.78772.1573251716407.JavaMail.zimbra@nod.at> <20191108222557.GT22121@hungrycats.org>
 <1063943113.78786.1573252282368.JavaMail.zimbra@nod.at> <20191108233933.GU22121@hungrycats.org>
 <1389491920.79042.1573293642654.JavaMail.zimbra@nod.at> <CAJCQCtTeqxxO=xAw5ogLORoNCvx7E7n0NQ4uF725bYX6vab25Q@mail.gmail.com>
In-Reply-To: <CAJCQCtTeqxxO=xAw5ogLORoNCvx7E7n0NQ4uF725bYX6vab25Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 13 Nov 2019 18:24:12 +0000
Message-ID: <CAJCQCtSqVHaRKm73A0k__NpabASS-_DJ4UYFMS-jn-ZVziMmRw@mail.gmail.com>
Subject: Re: Decoding "unable to fixup (regular)" errors
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 13, 2019 at 6:17 PM Chris Murphy <lists@colorremedies.com> wrote:
>start digging
> through a hundreds of millions of lines of code

s/millions/thousands

:-P

-- 
Chris Murphy
