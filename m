Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739BF26CFE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 02:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgIQAW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 20:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIQAW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 20:22:58 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:22:58 EDT
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73FDC06178C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 17:14:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u6so183223iow.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Sep 2020 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/50w6DgCOJ3/5EqKFCUb8mTb9eEt6Fp3Z4L748cy2R4=;
        b=KGmJvdIo2lphpn4mbomHqK432FUkkXyF+IRnfl7mtP+WVGwZb1+oSObdqXwCfowV57
         cUStlU+u6dTpqvBRBzd8d7W9a9Z3dniTFOH5r7HEXEgCoaclYZu+BQV3mvsK+rbTlYFl
         c36zxNG2ejeT+AyyF3aj80+dbJrL+OKGTlEy6jTqfuSwjtcfnrePyeXAgGfhRjEQKjGA
         1yT7c8Q8UhIE3x37z58HIKh2ZLtyNL4f6UA9A6fxfAT+7jxVEP2pk7cz8HpuchfavEYu
         oYVE8b4oek0umga/gz1XcAM8p6of+pe5HusIeGRwpnadAbJXTuFwhT9qVBxdywCsZyBj
         xA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/50w6DgCOJ3/5EqKFCUb8mTb9eEt6Fp3Z4L748cy2R4=;
        b=CKueAHKE9HjImnWYdRZ5taJaA6pWxVpDsHQKru64z38Tehfy5SMd8L6PSU1pjTGEYi
         JTx35eh5YQ03ofJHzetb2WDyNENnwCm/PSMT3uno7l3+WdIn8INyyCYCj6bUELdz9WT6
         eW6+cIf+26Y2mJUtBGXDdZ7yirojfGEphrLDV91zaV5jW3XlVooAQDTo3uIvg9/VEV67
         akKEgX+4APTtx8YB1m35MV6VUpRi2pfAAj+TfFutm7PgEzkFsQxMEKSaOJGrmDMD6W3I
         ye4h0INEfFxCTvPYZTY6OUDn9s7fxiz0X3eZP+TMZING7wo5MmpG8Iye1NxL5DN9AC1s
         CBGQ==
X-Gm-Message-State: AOAM533XQzAr4BvhYH3jXsoiJ3RfXiXcSZIkDamiCEQeuMMWWXbKIQmz
        0OFyJ7igFs45efOmeNV4Tz1pofj4MOJw2FMxyDLcZy3sYiwuSA==
X-Google-Smtp-Source: ABdhPJzJkrP36AETv7qYyKr06ky8rlPNG30t9tkgFzv0tsR7W4zl8C8zUs7VAv7XFKIjtWXN/MytIU9VORac0SZN7L0=
X-Received: by 2002:a6b:610d:: with SMTP id v13mr21150310iob.189.1600301670997;
 Wed, 16 Sep 2020 17:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200915053532.63279-1-wqu@suse.com> <CAEg-Je-y6BaXYbfDOdoeF_H85E2+PqRQ-PCJrW6KPHe9Haz6MA@mail.gmail.com>
 <6802c45f-16eb-90a3-4ad5-b3bb92dc4cbd@suse.com>
In-Reply-To: <6802c45f-16eb-90a3-4ad5-b3bb92dc4cbd@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 16 Sep 2020 20:13:55 -0400
Message-ID: <CAEg-Je-204GbuVRyrAK+jSYN9YPpCJf8e7CneyYz+PtRxbM1EQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] btrfs: add read-only support for subpage sector size
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 16, 2020 at 8:03 PM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2020/9/17 =E4=B8=8A=E5=8D=8812:18, Neal Gompa wrote:
> > On Tue, Sep 15, 2020 at 1:36 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Patches can be fetched from github:
> >> https://github.com/adam900710/linux/tree/subpage
> >>
> >> Currently btrfs only allows to mount fs with sectorsize =3D=3D PAGE_SI=
ZE.
> >>
> >> That means, for 64K page size system, they can only use 64K sector siz=
e
> >> fs.
> >> This brings a big compatible problem for btrfs.
> >>
> >> This patch is going to slightly solve the problem by, allowing 64K
> >> system to mount 4K sectorsize fs in read-only mode.
> >>
> >> The main objective here, is to remove the blockage in the code base, a=
nd
> >> pave the road to full RW mount support.
> >>
> >
> > Is there a reason we don't include a patch in here to just hardwire
> > the block size to 4K going forward?
> >
>
> Did you mean to make 4K sector size the hard requirement?
>
> That would make existing 64K sector size fs unable to be mounted then.
>

I mean, make the 64K variant a legacy one and force 4K for all new
filesystems. That then simplifies this work to making it mountable and
usable as a legacy filesystem format.

I guess that would be an incompat flag, no?



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
