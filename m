Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD841BBF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 02:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbhI2A6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 20:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243530AbhI2A6H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 20:58:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD9C06161C;
        Tue, 28 Sep 2021 17:56:27 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f133so1562905yba.11;
        Tue, 28 Sep 2021 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JnBQzRHZjX1jX9ZbaPy19bZuVBx4MFAmGk8JgFG5HPw=;
        b=VJ4hiovrOYc7P9u3DdHn+eFVOFUOVStsOQJQwKvE9R6kVwt5k1RF4RfVAZg+cz4vzp
         5NMev1uO3W2x4W59M8BF99xExe6FrqZZUzjbSgFfSkTeEXpy5QWtgvU3O0nFWKeg/kqz
         G25wXrMLeI2NLEkf/osfe223+XWHLwHyuP+EWYRzbQTrno5UvL/2RvReCNdpmffp2Btr
         vNdHgm0VhpikRifXuWjOTgRfgHFMjDyu3qWsomrp2veRMSPRb4/QdDbwC/RCTY5dmjlZ
         W7ozAnuZpGssPxXb9fGxacbySUmLgEMceCSOf1RLm8C/Ou0SNy9p1zAaQeyr+zCefU2s
         PY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JnBQzRHZjX1jX9ZbaPy19bZuVBx4MFAmGk8JgFG5HPw=;
        b=rIGzI1JsS9KeSzoBWocbZLnbaKawYleChV/FgEEU8suW6GJglAx3Yy7FCL2xH9Wtf0
         AciwCb4pV/aMdmxWZKgcm/x2wenIOIgyfFGQUC4aSPq23JDXQ2DIErU0lYxA030ESOrP
         5LEzgQeEzbsgzCXoIky49CqzQ9lj3LI2H6S/Njcaas0yTYrWlp+0t4GrjGa+ZSo5WnvH
         1Qf+DjlBdso5jp2r6qNmKxMXp9iy5X0YXNCqbVK/dvhQ4sSXYX5aFbQlEMSER3lyWHTu
         9nRJ+pLAbH0Tiwjwp0TeTdyYRB7eGEx7iY5DZIFYv4+43DdhjlwyWUyNcWxAUUnKZ6dN
         TiUQ==
X-Gm-Message-State: AOAM530JB0JU6pTdxy80gkcL2Ax7Ye5cNPMXxyp0UZxaG1Y0CSiH2QMC
        G3+u7v0fceuiEwQqVv4EBs6SuX76b2tRTLsfVncPZoSIv88=
X-Google-Smtp-Source: ABdhPJzTkzx02hXT1Mb5vSin3ht3uGdDzRgjkWEWzVfn06Zb2X6N/A1DGvNDAFEGOt6rjvODfDLEbQDjRQd9Tiv6lZo=
X-Received: by 2002:a25:2255:: with SMTP id i82mr9736362ybi.203.1632876986478;
 Tue, 28 Sep 2021 17:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
In-Reply-To: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 28 Sep 2021 20:55:50 -0400
Message-ID: <CAEg-Je95-T6AGodk7tyUnN8sw+sdVbHd18w1AnY-6hdBJ+5wtw@mail.gmail.com>
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
To:     B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 28, 2021 at 8:24 PM Tom Seewald <tseewald@gmail.com> wrote:
>
> Hi,
>
> Has this been abandoned or will there be future attempts at syncing the
> in-kernel zstd with the upstream project?
>

With the kind of crap that Nick has been getting from everyone, I'd be
surprised if he takes it up again anytime soon. As a bystander, I've been
incredibly disappointed with how this has "progressed" (read: stalled)
even though Nick is the developer and maintainer of zstd code.




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
