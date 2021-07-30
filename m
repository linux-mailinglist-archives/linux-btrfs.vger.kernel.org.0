Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D619B3DBCF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhG3QSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 12:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhG3QSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 12:18:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BE3C061765
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 09:18:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id a93so16885139ybi.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bg9jgjyTK1xMe0vVMAOXE0rqFsVHmuI2rjA1f7MSsBo=;
        b=CU5O+LWatvmqwOLHVLZ1VKaMQIg8tSRKnjTOEU9OSOcokuZK0U0XrHg4I2I88cRNsn
         qvvgoDjuz1PH9tRqWYocEdwKPxbRMtJxTcE4D0dvHHM+lRu74mHWqBsWgszvDAUKfjAe
         E/61vC8uAi1ao6YzhKV1kz5mfh0a+UGI3/f8xgDff2AwTm1Yow+0hfZJz0V5eU7N2el2
         bLK1ZWhLmq7DOeZfm59aGK89R0/08Rn+qHs4NIQVWvcTzVBZdc4v0Qx7j19uDKnzRu9o
         Mv6LMIGn3/lR2rbrDjEThp8ABExKN3CbSLyVYycM3wwlYlK/g1sTonP0qVR+fR8HJkie
         NG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bg9jgjyTK1xMe0vVMAOXE0rqFsVHmuI2rjA1f7MSsBo=;
        b=qgTWZmvRQYUUTiJ26beiPQmLM6laJNYm8D5D5P5+NhZSffxzQD3cIg1Tsk5XuTafMW
         rFlksNt/MvWqcvXbMcJpFKhBvg+Y0g3C6crAlsMgCkWiYt09F9+N6gADcTsWRm8pZP7j
         vErG3PisFMgqQfDxm/msE45QucVSSliZKJ82NfEukjMmM1cS++ecGuYdXKrbeQ8KGrBF
         XoOvpae8yoZT5qssTCihMsueRWOPNeSLpypKaDusGsofE6drrSIc9wKQidF8nzMBB7Ah
         BENlB5VXkSny+5AT+izU9jharLjSXYaBt1+Mpm2x5oXSpG++t+pKshR5PpEqI0EdoOAH
         s4dQ==
X-Gm-Message-State: AOAM530WibtGIlDPvDQ9euFhUBU9HGwCADf0681lpu3Y228zi8v340T2
        PgRmUf8JRyGZmUjP7wS7cCCfEQMtfMVBB494zXs=
X-Google-Smtp-Source: ABdhPJzwC1ZqG/X6nuelwcyxAFWqY+llxUewjT6StcHAZCrG2MFrO2jSIu8FIDOQKdC9jE8TEFpt34GNiNqjFxXmY6U=
X-Received: by 2002:a25:9201:: with SMTP id b1mr4040492ybo.354.1627661912430;
 Fri, 30 Jul 2021 09:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210730141837.30571-1-dsterba@suse.com>
In-Reply-To: <20210730141837.30571-1-dsterba@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 30 Jul 2021 12:17:56 -0400
Message-ID: <CAEg-Je9n-W1iMW6NPNJ+Leax77XW483Y0if+BKOqj8v9TBXZGA@mail.gmail.com>
Subject: Re: Btrfs progs release 5.13.1
To:     David Sterba <dsterba@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 30, 2021 at 10:23 AM David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> btrfs-progs version 5.12.1 have been released. This is a bugfix release.
>

Don't you mean 5.13.1? :)


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
