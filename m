Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4D36622A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 00:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhDTWd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 18:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTWd5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 18:33:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21550C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 15:33:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c195so44890008ybf.9
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Apr 2021 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w2UAPqGfe/U5lQmNTSOEc5YQ326NqC4lf1YI0RJbdG0=;
        b=Dbr0eAT7CAGC/aFB24EOR/pA65StHMuPXClNUtnuCrVc/tDitPsE5MR5IcuHHmLX3X
         Ng/8tXxpNRY0gGH2NoXdiYHhoOi5vagvWOZIj9SBDDUU7a1Ot70XRlAfySne1YGdr0ks
         vLP4A/QhEOe6Td3acuKI0QWWdhhYV9WwI4UGx4vubT86UEzp1X7nHmir6T8jbEgl7HZx
         oCfOQeTPmfBHr4uCtAd4hWwSMnO26RkF3clgckWtDdGsSkM6VnqqWdJUqGwnajAwOKRu
         XsSyx9u0bws9rGLpgNN6F5rc4uXv5NGH+D3/fcGIqqNo9ZQSvme/ixh8eoqmCod7/jm4
         XGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w2UAPqGfe/U5lQmNTSOEc5YQ326NqC4lf1YI0RJbdG0=;
        b=MXakRg0/T78ViTPR8t9swjgXYZfGgngi77xe+klwWkk1u+lI/Ql8wE0RvKvqYjpbVK
         /ZFtteNamD7PrLGv4l0OP+T5DzwgH435YZT3smvWiGvCPvMYk9nuTEs58b7E7n/a/QXP
         qf10hUAvCA8AQHagBYJQ0nLASaWNxZZ0iWjpuGyTBzi5gZYjSHwSfNT6pgEX+aIDshgB
         Y361EhXMVf4QvZkg+Picn2xmTZUentju+6t3sW9EYGsjd5CBRK1YKIq2N9FZWLPWgkdm
         jYWSLt8b0/k2lMRkneVUxA9bg09QIwQNOGpsd89AA6dcnrpEMVN/G2wqI6ehonqWeADW
         S1gw==
X-Gm-Message-State: AOAM53200+PeE+9+y20Cw3uUHbjmOHp/clhGBzBG/Dw7I8ekJ7A69kCM
        M5ST8HsDsnZwbV9+GNbDYFigGRDg+LrmkqtB9MI=
X-Google-Smtp-Source: ABdhPJwNPDmK/KjEWAljEFKAK2P7eB2Cj7OuEfDr3Wnqsnmd9aqUdlSgLXn/HnOjDK6RBGUeW9Sc3QfaWs4n5mNqhVI=
X-Received: by 2002:a25:3c01:: with SMTP id j1mr29251203yba.176.1618958004294;
 Tue, 20 Apr 2021 15:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
 <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com> <SN4PR0401MB3598C82C1186CA04215145489B2C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CY4PR04MB375160CD68787A04EBB29ABCE72C0@CY4PR04MB3751.namprd04.prod.outlook.com>
In-Reply-To: <CY4PR04MB375160CD68787A04EBB29ABCE72C0@CY4PR04MB3751.namprd04.prod.outlook.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 20 Apr 2021 18:32:48 -0400
Message-ID: <CAEg-Je-YxacuE4OweeAixCBV-RAGvWzNaKXcBoEyK_P2QcG6qQ@mail.gmail.com>
Subject: Re: About the state of Btrfs RAID 5/6
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 3, 2020 at 4:50 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote=
:
>
> On 2020/09/03 16:34, Johannes Thumshirn wrote:
> > On 02/09/2020 19:37, Josef Bacik wrote:
> >> I know Johannes is working on something magical,
> >> but IDK what it is or how far out it is.
> >
> > That something is still slide-ware. I hopefully get back
> > to really working on it soonish.
> >
> > So please don't expect patches within the next say 12 months.
>
> Come on... You can do better than that :)
>
> Joke aside, once we are past the zoned block device support (new version =
coming
> this week), we will accelerate that work.
>

Now that we've got ZBD support landing with Linux 5.12 for Btrfs, any
chance this might be looked at anytime soon?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
