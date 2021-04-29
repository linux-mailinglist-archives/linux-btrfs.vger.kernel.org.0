Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C044F36E840
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 11:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhD2J5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhD2J5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 05:57:34 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B5C06138B;
        Thu, 29 Apr 2021 02:56:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l1so8908981qtr.12;
        Thu, 29 Apr 2021 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=fXmUi426qx1bMxJmwL1WNroTomZzrYd5WppxcaObOsk=;
        b=ranMKkYBj9QM85OiE/40vaAbo2tNT42CADC9rfQ3eZkNy28TgPKMwVG5G1SB+7TS5G
         tJM0we3OI4Ajsw6crxDX+LSYJM6/v2bOcLMsiIwg6FcEcPTpHqNJlOYcptQJSWeFrATP
         w9O0xxggZ9niwHqyMK5Co4WjGa/Z+m8VsjE1SS4V4cjrZKl/15nrV+tR+Ch9Kzc7Kqo5
         5ZnDpJwubZMrT/mvfy85BMUWdvPGgGLi+N86qp2XVuvFztPr6Oe/D0F0z7ZxGp+EgVgt
         g18jW2e3bczCuB8f+HWH+tBQX1LLU71cvMdQNw+L8YDgXMHmgq4ccAiIpqCgBblVjpWI
         j8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=fXmUi426qx1bMxJmwL1WNroTomZzrYd5WppxcaObOsk=;
        b=AqQvA84ysQ4CCx6XdTz4my+XB2DObKcl7LVxmjLm5DZjx4gl0JkSX01FF6stgfdoKj
         7xZIn/0ZlKJg0RJhXdwkM5ly9dYFGD/JhFBUvoXk7DWtI/+RmYgbvbrm0oYDRB4BQjFr
         j5S41axNBgsaY1Zh+U05VpZpb2Vd+lf4ceFWh0UGPs7FUenzpICOL2171EO7BjH1+tMP
         QW2+jXGV2NmpNyndIDEPsWOp2u2lAFmCOyO4mlf0Rhvxs/6aldG2CKncwrAAqYDvUJl5
         lqt+UpteEF0fdfBlEOQ73A5AOy/gwYoQgEBneteVnoJGJm3N3Y1vrOBbXvebzDp1Wl2F
         G+Sg==
X-Gm-Message-State: AOAM531NnF4Hk+pTHsvca2lmo4MWSLL2ccxTZdJl2pGc0Uhog4gBAkuA
        ZpjIURS7C5F73ZvAgd0LjPuPU1K1GCA3IsxrYmw=
X-Google-Smtp-Source: ABdhPJz+zlBQVXsEXFnbF/D+NDjSw69wGs84Jh/Xvi+dSG49hpkG7PHV2C+n/gqZXLwnYO6yyXoi7jZ/FTEqrVVb5R8=
X-Received: by 2002:ac8:4e24:: with SMTP id d4mr30707059qtw.213.1619690205869;
 Thu, 29 Apr 2021 02:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
 <20210428084608.21213-3-johannes.thumshirn@wdc.com> <CAL3q7H4z=eePUYbOgOVZhMCp+u8m8bbvKfU5nNqq3rd_8YNm1g@mail.gmail.com>
 <PH0PR04MB74165CF0E16A53B38FF4AEEF9B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB74165CF0E16A53B38FF4AEEF9B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 29 Apr 2021 10:56:34 +0100
Message-ID: <CAL3q7H6rQt=ecHN=Q3xh0tGsq5fmrkQaCApeusyvYYj0xDjp7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 10:44 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 28/04/2021 11:24, Filipe Manana wrote:
> > The use of _fail is usually discouraged. A simple echo would suffice he=
re.
>
>
> Need to do echo + exit here, otherwise there will be errors in the shell =
script.

Errors? I don't understand, what kind of errors?

Thanks.
>
> Everything else worked in.
>
> Thanks a lot,
>         Johannes



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
