Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36B3D4F19
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jul 2021 19:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhGYQyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Jul 2021 12:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYQyb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Jul 2021 12:54:31 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3DC061757
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 10:35:01 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id u25so8204193oiv.5
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jul 2021 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S9d1lqiXWKI0318KohFjzNnROG99hJjZ1ZMZ1I0qtkA=;
        b=IswdaY1nu6+Af9oylO/RbwCcMI5deYqWt5dxum2CYyknnvGLuvt2aMOdVh3lbmoWEW
         iqqdpfcO9usoAOvUj75z+PHSdKXAC+sSy2tTehRvOE+jpfl/UIM7CNQNxDvRa4ATJkWT
         QnyA52sJpF9uspcYwUuU/stUUNk8U7mc3IFd16YIBFBWZhEo2Qbvk0jvw3RaD/f1bKRm
         vf1ef9oxYGMXG0veIB6C42rvC1Qpni2SyQ2yaUq1ILXzUqtp/GSUwQ8GlC7rcHf2w78z
         QtTY4guDsPsX7l6yejuLM7sEemGuEhylHhHoC2sBI8UhMzNhVnu8KxmyZHtMBMBtLdn1
         hfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S9d1lqiXWKI0318KohFjzNnROG99hJjZ1ZMZ1I0qtkA=;
        b=o0RMT0Hk4BzE19dp2EcUbiRCgiN+qDZvGFsRJD/Tc43G0R7A1DenL+sLSEsE8imx5a
         ludNFfZNlF2JS/KO3wWkdsJjBOUJDgbBM5vAHrTOzpZc8FayOMg2Wph/NsCGclMDgx8Q
         eFcv/+s57+nOaapNG+cNBMNVpR+ENefa5OVq5mSvQl9NrUHaVfWIhqZdFJ2lnWJNXLiE
         4hO47d33gZwEzT6U8eDotxZ1sh7chl2c795RBe9trAPF0iBoFfM3cq7POp/ffzrUBtV/
         H4nB5Lu0mSsFrAmA3CIUxrMdrGQySByH0EoBY6UDzirbg6Xle9bWCaRPa6pzm8arpQpF
         nS2w==
X-Gm-Message-State: AOAM533tFCm3KxKfEw/DN8LRa7t22VJ8BDX6cQwQeUuONwbbLveUmhzo
        /9QfK3A0/WMoypHCQZgF34TtQZxmjn1h6votvjQ=
X-Google-Smtp-Source: ABdhPJyznJCc0Pw+B/N/8BgxlIPpXP8i1Xob//R+chS/REL2dsYUGf0tub8r5+uUFilJklUCLmv/lefzweNB6NleL6w=
X-Received: by 2002:aca:adc8:: with SMTP id w191mr8860248oie.44.1627234500583;
 Sun, 25 Jul 2021 10:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB6qxBtVc1XtSF_wOR3NyR9nGpr5_Nc5RCLGT5NK=C4iRA@mail.gmail.com>
 <3be8bba9-60cd-2cce-a05d-6c24b8895f3f@gmx.com> <CAGdWbB44nH7dgdP3qO_bFYZwbkrW37OwFEVTE2Bn+rn4d7zWiQ@mail.gmail.com>
 <43e7dc04-c862-fff1-45af-fd779206d71c@gmx.com> <CAGdWbB7Q98tSbPgHUBF+yjqYRBPZ-a42hd=xLwMZUMO46gfd0A@mail.gmail.com>
 <CAGdWbB47rKnLoSBZ7Ez+inkeKRgE+SbOAp5QEpB=VWfM_5AmRA@mail.gmail.com>
 <520a696d-d747-ef86-4560-0ec25897e0e1@suse.com> <CAGdWbB6CrFc319fwRwmkd=zrVE4jabF0GTpqZd5Jjzx2RcAo9Q@mail.gmail.com>
 <e4cc8998-fc9e-4ef3-3a49-0f6d98960a75@gmx.com> <CAGdWbB6Y0p3dc6+00eTnf1XSS1rUMbPUckQabi6VJQXdjRt2jg@mail.gmail.com>
 <88005f9b-d596-f2f9-21f0-97fc7be4c662@gmx.com> <CAGdWbB59w+5=3AoKU0uRHHkA1zeya0cRhqRn8sDYpea+hZOunA@mail.gmail.com>
 <e42fcd8e-23d4-ee98-aab6-2210e408ad3f@gmx.com> <CAGdWbB7z2Q8hCFx_VriHaV1Ve1Yg7P38Rm63hMS6QxbVR=V-jQ@mail.gmail.com>
 <6982c092-22dc-d145-edea-2d33e1a0dced@gmx.com> <CAGdWbB7XqoJaVsdbG7VkvSj78hVPt-HnZxOw_nvX7GaTziaiwg@mail.gmail.com>
 <062c20ad-ea9f-f83f-ce49-0a82668c3c6c@gmx.com>
In-Reply-To: <062c20ad-ea9f-f83f-ce49-0a82668c3c6c@gmx.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Sun, 25 Jul 2021 13:34:49 -0400
Message-ID: <CAGdWbB6KmDgsd2jKn65=H9W76aHNSVP_kZzqXMU8hV13R6seJw@mail.gmail.com>
Subject: Re: bad file extent, some csum missing - how to check that restored
 volumes are error-free?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

HI Qu. Was the information I sent helpful? Is there any final lesson I
should take away from this? Thank you.

On Fri, Jul 16, 2021 at 9:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/7/17 =E4=B8=8A=E5=8D=888:57, Dave T wrote:
> >> But before that, would you mind to run "btrfs check" again on the fs t=
o
> >> see if it reports any error?
> >
> >> I'm interested to see the result though.
> >
> > First I will send you the full output of the command I ran:
> > btrfs check --repair --init-csum-tree /dev/mapper/xyz
> > It's a lot of output - around 50MB before I zip it up.
> > How about if I send that to you as an attachment and mail it directly
> > to you, not the list?
>
> It works for me either way.
>
> >
> > Next step: I have remounted the old fs and I'm going to run a scrub on =
it.
>
> Scrub shouldn't detect much thing else, but it won't hurt anyway.
>
> >
> > Then I will unmount it and run btrfs check again and send you the
> > output. Again, I'll send it to you privately, OK?
> >
>
> That's fine to me.
>
> THanks,
> Qu
