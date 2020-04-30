Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4793B1BEF84
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 07:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD3FCK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 01:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3FCJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 01:02:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E9C035494
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 22:02:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so335661wmj.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Apr 2020 22:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kXC8G6O6JixBl3JI0rRKZaf4kuq6YdVBWVGORaUzCfM=;
        b=bF5zBkkrv9RRGxXYXCRHDhGpSuqhq1NmG+QtR/GGiGwnr6reO2j6yrtjRKFrF6tk2f
         Z4Ing79cvoLOEX3r/CtnciwCnVT6WTZDh0aH4tY6G8uKGqOPw53LyPOBsMqTmfYniyS/
         ew31GjfGLGsnGt2hwDF2hJKSCskewNeoCFxw5WYtHu5C9D2SXYStTdQOmQVRRRd9h1Pu
         PgvvdQOB4GvFeiIDgpNgWZo3TrCfB2kjAvBobEdmjpZUEjDLYfmrc9riPZG7+WhXytwG
         sED8YZz/tXKLvvk9+f1jzw4Cye1nSDmGpdo2kUfxYHeNqtPc5NNGH3ZvouY+9dePPTKO
         RobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kXC8G6O6JixBl3JI0rRKZaf4kuq6YdVBWVGORaUzCfM=;
        b=ntCQKy08WygmGuICyxaV0qMQH7LeXF5VlD26WKZs9MTukTh1amw0NyYqr6YMTb0IMw
         49E6AxeG6Bl5AZ2L7M2XcPouA14VpTMTgaHydEhzscJXPMpmdpbbudMVsk65YSHhiP3l
         EIYufYolhuJ8iP963hIAry97WMGPgp3Z9NdQIO0xt2EcnCUbz/ksbOZSitHT884MWwHN
         mP5JS2Nc8jdEKfDgmWwNELChvAlKydBsZbcamqgMqpl52UAZe6DUUHpHihJw+y9UTYku
         EsYE/1Lb90t51/huZtk8s6Uxl4SDdFAg6sOaMwhzQ/YZaonvBRrfdCl6fi0Kgpq6WEYJ
         DJsQ==
X-Gm-Message-State: AGi0PuacuGL9fb2Qo0i86ujR2M1Azj8vNyNgJ8M5YPjwdCC+Zw4l8Clf
        YOY1AuAI/7F01Jq17epQcBHTIoOWY7jCQhkLTObf/h3c
X-Google-Smtp-Source: APiQypKTNioyXjihKPBUBvz3DWizLZCFCxpRKnSvoD0DyfrXqDoRUaOZLv/JoSROToN4xt9Vu3Ph8GmYZlYSP5B5ZXQ=
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr799470wmc.124.1588222927312;
 Wed, 29 Apr 2020 22:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
 <76ec883b-3e44-fcda-d981-93a9e120f56d@yandex.pl> <CAJCQCtTxGRqA4SZFnC+G+=b0bK2ahpym+9eG31pRTv9FH1_-3w@mail.gmail.com>
 <cc0b6672-a65a-5c7b-d561-21cc585ead62@gmx.com>
In-Reply-To: <cc0b6672-a65a-5c7b-d561-21cc585ead62@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 29 Apr 2020 23:01:51 -0600
Message-ID: <CAJCQCtTwH54CEhcGwv1S9P-i8JOgSHZFg3sKkQxAL1ppeG1cwQ@mail.gmail.com>
Subject: Re: many csum warning/errors on qemu guests using btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Michal Soltys <msoltyspl@yandex.pl>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 29, 2020 at 7:46 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/4/30 =E4=B8=8A=E5=8D=883:21, Chris Murphy wrote:
> > On Wed, Apr 29, 2020 at 9:45 AM Michal Soltys <msoltyspl@yandex.pl> wro=
te:
> >>
> >> Short update:
> >>
> >> 1) turned out to not be btrfs fault in any way or form, as we recreate=
d
> >> the same issue with ext4 while manually checksumming the files; so if
> >> anything, btrfs told us we have actual issues somewhere =3D)
>
> Is that related to mixing buffered write with DIO write?
>
> If so, maybe changing the qemu cache mode may help?

I thought this would only happen if the host is Btrfs? Maybe it's a
bit crazy but these days I only use Btrfs on Btrfs with cache=3Dunsafe.
I do lots of VM force quits, never see any problems. I haven't tested
it, but I think unsafe is quite unsafe if the host crashes/power fails
while the guest is active. Performance is much better though.


--=20
Chris Murphy
