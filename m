Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F077B41611B
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbhIWOgf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbhIWOgf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 10:36:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D4EC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 07:35:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m3so27733578lfu.2
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X+DS4kD/yIa42vShpTD6YdFRyYdvzTgg+IaLOgYY+do=;
        b=SZJ0x081Xh+mRTzqbziTY3OeBbPo++bPsCJl3sJuITntaU1iQA8FJHVujJJGZpt8WC
         Zp7fQhRp6K0ej3lMtIdbgxP4CUTqYN2WR94NNbPDC0ZwNVJ0lVVZPDlVikYG6v6xQHrH
         oh1YOoJKLN1yf16FHTFZ7N/1Y3NmpJjuMKy2y+tPVKr35V3wWS/4++FctAcCRxbBGEbJ
         xH6qtH+OoolQSSpLLMIq12pbL9OHXa7S9dVD7Seo7I/sqW2vBpXT4ZdDv8284HTuBL3l
         +Y2d6gI2wvhQkbLKaPWhVMHYZmbUntCK/MCKVLeDk/zLGVAaB5GH355Ur0uWuVNnzb/C
         6uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X+DS4kD/yIa42vShpTD6YdFRyYdvzTgg+IaLOgYY+do=;
        b=QWy/wjQDhCNoQni7eVY2Wt1wevd+tGf7NysR7I51mHZjuAITS4bwCQg7hEZhWvpCLt
         xZrmpYSVVN1I9BYt9L0B4m2lUJwO+9ZPnzsw4+VwZEMpoyhmUSIip8Tl3NIBHHwIrEWp
         huMxx3zmkk/9JgmgruT45u1KJCVxt0SNhc0xxt7OUdvPHonvGBNzJyopmF9S5HNW4eLU
         lLQ4ZmjIlP6G7sprUYUjtKkk0i1B+sNc2MMWTI8+SKFTv/jfJVkjnOwIaDf0FMGB03gp
         gyojuzbBL1C2yd0D8LNQj61eqLquv1a7JDkfi8x/Qp3NKZNC8GVSLhsoFFbKvpFozGIU
         7beA==
X-Gm-Message-State: AOAM530e/rVTR5D/CcxGysfo8XjLJb/F7Dpfa5+WkxapYoyrpIBh8C0p
        u2BY52iFDVD4m4n1G8ZaZwHA1DUZ2veyaao2ifJw4C/peDzfflsf
X-Google-Smtp-Source: ABdhPJxXhZnl0kw4F2NBEqcvOTI/9U6+i4n8pfHKLLQoWH5KTpiqJDzSCgdVBJVXel+1vmP+ROL1msYX+ZO+s46t9x0=
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr4320826lfu.324.1632407698772;
 Thu, 23 Sep 2021 07:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <1632330390-29793-1-git-send-email-zhanglikernel@gmail.com>
 <5679da1e-2422-69c5-b4f8-326802363f7c@suse.com> <CAAa-AGmnKSDm=9my5+qi3OqOaB7BZqmGrGjoctm60Cfs6-9agg@mail.gmail.com>
 <d05d52fe-db30-5eb2-f42d-33d7852ba3bb@suse.com>
In-Reply-To: <d05d52fe-db30-5eb2-f42d-33d7852ba3bb@suse.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Thu, 23 Sep 2021 22:34:47 +0800
Message-ID: <CAAa-AGnvkDcbcW+DOrVKAxzk2KgWtRx4-yrBNPTfheayg+afew@mail.gmail.com>
Subject: Re: [PATCH] clear_bit BTRFS_DEV_STATE_MISSING if the device->bdev is
 not NULL During mount.
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Got it.

Nikolay Borisov <nborisov@suse.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:53=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 23.09.21 =D0=B3. 13:10, li zhang wrote:
> > Sure, I would love to do it.
> >
> > To avoid ambiguity, Should I and write a test
> > case to detect whether clear the BTRFS_DEV_STATE_MISSING
> > if filesystem found a device, but it was marked to
> > BTRFS_DEV_STATE_MISSING.
>
> Yes, basically the idea is for the test case to fail without your patch
> and pass with your patch. That way we'll ensure this won't regress in
> the future.
