Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1237972C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 20:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhEJSvU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 14:51:18 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82422C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 10 May 2021 11:50:11 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 82so23024770yby.7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 May 2021 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0JFU7C78nCGsfm5+Y6gdd9I/vXJr7VfeUJXknDMXJwg=;
        b=DabLQiH3coQRPDtSQGimGH/9XbAFG1fTXEcKPisT1hOygdsccFfHuxAT+UdF/6+MIm
         F2CSc6K2PHaTqyiAV14EcRSDRONSC5X9Dx7SNfBHzUwPozhsKQ0NJNBQP8UPLzugY72L
         XmtZnof2KiUWdSObQsaTkE372IBR5qFrj68dNwX/s1mP5pCTx+NYgk3T9znLd4BCLt02
         W4j51vtfmFscT5j1mfu6AtxToBEdF04NPqkfIprm1dLHJtX+Q7mFxBVsvay/Iqy1B9N2
         howTDjMz1jEkYTa+MqWiS0sK3G+yqSYPVCoxfjJB0M4djTO57/x3lnR0/4EPBszcFFDm
         SeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0JFU7C78nCGsfm5+Y6gdd9I/vXJr7VfeUJXknDMXJwg=;
        b=LdtQeeo9WF+cBO4pMljuASeRxB3OAnj6czahfZ+BjV672j2yFjvsKsGF65r7sp3NJj
         B/W4bjGw/J6bIVXrxkmi4C7guMEWTtL81QmUjqHsDK7LJU79IlOnUl01UqbFtAEvNaL1
         l7SISWaUKlDi6RdoSA2MPYLrWXeJ6holTtB1NAP0RflGF4E2lfuj+oJU+b6/6DbuisjQ
         yEESeSqTEGqlDzBDHJHkKea9Rupld/kzass0sKEGueI+iydTmqoqNBjZA97m8Onz6SSM
         8qcEDd46CfUiWQ8hMQip0xNipTPUAVJUGN1lJmBdputxNzOci8AB53wMdTa3w1advmId
         O1Dw==
X-Gm-Message-State: AOAM532LOqF8QckEHxFyBOJ+HsXySgF+iyVabkG6F/6Xsq7zOWQ9ylJF
        MVHRRBeMIkTjQED7zc21+UCiGJBbktE+goJQynDwV2Tdvek=
X-Google-Smtp-Source: ABdhPJyHhSKHHzZEZ2/yAdDTRKx/WEseup3U9zraxC2Il19digxH9g+4lsXn2MnsxSV5C8W5PgSB4wcC5DbtM5Tndnk=
X-Received: by 2002:a25:cc5:: with SMTP id 188mr22359413ybm.59.1620672610684;
 Mon, 10 May 2021 11:50:10 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 10 May 2021 14:49:35 -0400
Message-ID: <CAEg-Je-s+9qZYFgqheW991EgUjA7OAUBM3+LvJB6px4hc15J+w@mail.gmail.com>
Subject: Fedora CI for btrfs-progs? (was Btrfs progs release 5.12)
To:     David Sterba <dsterba@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Aleksandra Fedorova <alpha@bookwar.info>,
        Davide Cavalca <dcavalca@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Continuous Integration and Continuous Delivery for
         Fedora <ci@lists.fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 10, 2021 at 11:04 AM David Sterba <dsterba@suse.com> wrote:
>
> Hi,
>
> btrfs-progs version 5.12 have been released.
>
> Notable things:
>
[...]
>
> * travis-ci integration has been disabled, I'd like to find another hoste=
d CI
>   but so far none provides a recent kernel so more tests won't pass, last=
 option
>   is to self-host some VMs and monitor git, getting just build tests work=
s but
>   we need to run the testsuite
>

This is unfortunate. However, I've been noodling around the idea of
asking the Fedora CI folks if we could add upstream CI using Fedora on
VMs. I guess now is as good of a time as any...

Aleksandra, are there any resources we could use to wire up
btrfs-progs against Fedora latest stable and Rawhide across
architectures so the code could be continually tested as changes are
landed? There's that fancy Zuul instance[1] that might be useful here.

[1]: https://softwarefactory-project.io/zuul/tenants


--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
