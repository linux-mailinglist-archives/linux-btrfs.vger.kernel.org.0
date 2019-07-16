Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA486A0BB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 05:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfGPDG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 23:06:59 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44666 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfGPDG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 23:06:59 -0400
Received: by mail-wr1-f51.google.com with SMTP id p17so19143197wrf.11
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2019 20:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O1qlwcr+ZdZoWydP6VLXQ1m1ciEaqAiA/xnPq3mr/CM=;
        b=muxplhhUkNkr+bJv8o813jZKxOiryS88HxF17OOW2MMLtqm664in/cI1ROwAjEkk/8
         j8fzY6gjNdfd5my2CgyFUpVqhQHrHBjwSPiaMyhTWkBGY2CCw8EGS9jkTM01//hZJT5q
         Th/8iYpXFgwtqCEbzDOuq9GogqCvX+nBYn2oedoIJLl95h/HTxNunoXHrcFdZBpt2lIf
         DAT63M2ol5PDzYjrwUc1gI4ZfnppgSrntlVbmbFdsOdlk8nzCmUQB88CCAGYtRTqaj04
         xE3MLwbl8zBVHSD6JwMFcGWjcBW9XhCvtnVQeMktAG6x0aBCrpSz1WkEOVk4lSiHtaE0
         Vocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O1qlwcr+ZdZoWydP6VLXQ1m1ciEaqAiA/xnPq3mr/CM=;
        b=Zr99smeFsNbVWSCQ63f6Fx5a4VTVjDTuduRPnEhV9fDBP10cdKBhCHTIw92JvpsQkv
         8QSKFQjG3xSh2XUhPJb5hWrlbvVDT0AK8iL6v4sgUBeQVLU3m3wmdr2eKybsqr7j81kb
         XIO+liblM2g89rFT5NucXTeRLlIdXKfWpaCiOdQZsCa9CHwmgiZXms4rNOuTK0rSWcj0
         IkfRsWpF3Fo+iAUOTE5tYIOqBqfE859s0atH5noHRTjJy4MrnmqGASkGT7uRrPIOTfZq
         paxw+o4yrkgg8vxKT6BzhBn7qAJ+FTB6cHtB7XIq/i5FyGFm6xkXmFEcKC/VJx34SvFp
         5rdQ==
X-Gm-Message-State: APjAAAWqR0LDj0P2gPBrAly1UGA62zmMAPiMTWbTRdZQu6O45fTkA58Q
        Qf656dbMdroOfn1DxIYGwRDCWKb/VntUY2cvfIY=
X-Google-Smtp-Source: APXvYqy3M/jE8WqCcjOvttRIkN2kfRdS2NuwyR5SkSe7hqFqIF8PiERW/nlmWvwVVPYutWz/gdSIOAxz385Zoi7esP0=
X-Received: by 2002:adf:f38a:: with SMTP id m10mr31108843wro.268.1563246417797;
 Mon, 15 Jul 2019 20:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <6f5f659ce3967c7cef2c6f8f9c07e8be8e5a2a70.camel@render-wahnsinn.de>
 <fddf59e6-b4c5-307b-2cb4-fbb8e120ac61@gmx.com>
In-Reply-To: <fddf59e6-b4c5-307b-2cb4-fbb8e120ac61@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 15 Jul 2019 21:06:46 -0600
Message-ID: <CAJCQCtQZhTpbEZ_ejwmXrJOBiXxUZtb64cnkFCQTdhkzbaqxDg@mail.gmail.com>
Subject: Re: Best Practices (or stuff to avoid) with Raid5/6 ?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Robert Krig <robert.krig@render-wahnsinn.de>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 15, 2019 at 8:09 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/7/15 =E4=B8=8B=E5=8D=8811:02, Robert Krig wrote:

> > That being said, are there any recommended best practices when
> > deploying btrfs with raid5?
>
> If there is any possibility of powerloss, kernel panic, or even unstable
> cable connection, then raid5/6 feature from btrfs is not as good as
> mdraid, mostly due to the write hole problem which hasn't been addressed
> in btrfs.

In the case of any of those problems, you need to start a scrub. As
long as there's no additional failure during the scrub, it'll fix any
problems.



--=20
Chris Murphy
