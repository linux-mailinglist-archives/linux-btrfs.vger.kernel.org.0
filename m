Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5725F26CC57
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgIPUmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 16:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgIPREy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 13:04:54 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB22CC02C288
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 09:19:27 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t13so7015523ile.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aQMH6HcMOeYMIDsmRdWsNMfGs4etElPTyEoOfaNrlVo=;
        b=pbbci4TT+CY9sSLiKluvCxM7WFu1lKPpKwHEJIibHS/xK2byO68EhZRT1x5CNDNt/3
         3WQl/nj2wyNkfh9dBa30Nh/o2W5iyN9GzqMYe2eJspNIQwpAFcTfHsM0a6x9gqzTYrzV
         BN9wVckGe1APq+rfOR/1y+yLoIMPW+DI66Ws3mFORl0kN8o1oh/a0Zb6bInar+M5+6rr
         7YpZl4ywhULUqiUbhH8MxyWjMj82cn2RviHcTJO9NDI79rgm0NQUtu7CHHZd3XeKXeGG
         Vmd+envTo6zJ5bhefvB4NCMvbmQQaeJVLKSiLchHzv57u7CwUvuqiNROFZFimV/aJRzW
         KKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aQMH6HcMOeYMIDsmRdWsNMfGs4etElPTyEoOfaNrlVo=;
        b=YVFNsauwDLmj6/v25kYOnM+TCOkMnBmNJiUGgbtj81v2ytRqfaNCS7fwp9eSEOMIcJ
         sjOaoFLvpFgKcbTs9YyhrZRQ2DK5UO0Sd4Uls9646Q10zL/ZtYSyjzAZU6e2lE2c3IkX
         FPjHAqE395jTDuBDFMWhqsG6LS8eHjbkYna6JEBFSc6OumqA+fTWno5aTw4fojr885H3
         DQ1+NyEC2NhScQU5UIXD/p2BE2hImeRJO5i3mfJ8plj8zqeoAvSCGk5gsOCcYrB3SoMH
         SXKSVKyXZ+mDbB4b0aXOY4PzUzagKjsDe7BfhU+vdh+cb/OV6FWRtzRZ99W7dMnB8NNr
         /4bg==
X-Gm-Message-State: AOAM531bYAnOHvAZ5tSmjbu2DpHGeAo9G7tEpOqKvHMvjz7Js8qntR7x
        XEHBMZtdzOF2ILwTpPUhTR/9bRFts5dIacHzIvE=
X-Google-Smtp-Source: ABdhPJz/pu/lDahVimms/ty38atM+cdRiQjvmZ88zWwC8jsvDTqCmNFgrpd0UESX2OTS3u1KpbjBVW0qTEQbzEkbS8w=
X-Received: by 2002:a92:2e0b:: with SMTP id v11mr22405427ile.112.1600273166755;
 Wed, 16 Sep 2020 09:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200915053532.63279-1-wqu@suse.com>
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 16 Sep 2020 12:18:50 -0400
Message-ID: <CAEg-Je-y6BaXYbfDOdoeF_H85E2+PqRQ-PCJrW6KPHe9Haz6MA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] btrfs: add read-only support for subpage sector size
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 1:36 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Patches can be fetched from github:
> https://github.com/adam900710/linux/tree/subpage
>
> Currently btrfs only allows to mount fs with sectorsize =3D=3D PAGE_SIZE.
>
> That means, for 64K page size system, they can only use 64K sector size
> fs.
> This brings a big compatible problem for btrfs.
>
> This patch is going to slightly solve the problem by, allowing 64K
> system to mount 4K sectorsize fs in read-only mode.
>
> The main objective here, is to remove the blockage in the code base, and
> pave the road to full RW mount support.
>

Is there a reason we don't include a patch in here to just hardwire
the block size to 4K going forward?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
