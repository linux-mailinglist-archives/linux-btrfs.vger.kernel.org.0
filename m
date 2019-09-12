Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D16B1648
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 00:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfILW3J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 18:29:09 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40676 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfILW3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 18:29:08 -0400
Received: by mail-wm1-f54.google.com with SMTP id m3so593331wmc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsfjRFmdLZywlWn4uTaMBsJroigg6TDzGNRcjwObCdk=;
        b=uzwMcSm1kd+xUF415vumyToC/iD69vfjVxj5g2FFhji4Oim0hQl29I5Cvco44Po1Yv
         Zbj/gGtA9Z6FQUbVKVHICu9qHz08BU7JRc8wG9RmaFP+dSLFpo2ISrx35f4svlliVLBN
         Hlc1IDlqf0XRlg7RGxirThDlzxRzQJ76jKOBbeZPENxU5myoM3fQeEcv+cL+nZHo2hwQ
         P2s5imSw3Mt0KqsM73eXc6Z6zMhIuCVaTJhqx3hL9E9M06kvARLnSrChR1Hb/h63hZLD
         N2vBWh01hgxn7RvCxCprwybSrast8+nfPGvpXSv21IqQxHCNIB9iJVSFXG89zSe1fZ0e
         MWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsfjRFmdLZywlWn4uTaMBsJroigg6TDzGNRcjwObCdk=;
        b=U+wZXQItWDt+cSjG68OBVmtCzpKSTDO5bwGFv3Oa+JRgu82zmoPgKsY1TiVi8QBtg8
         z5klHYmtMDBJSiVZ5QZ2Hb5bSEgoo8JAJZBOOAGOXNONtZ0MyTsGooJG9aSHA/T7tpX5
         8F6d9yAxCwTGJ3MPzkN45DpMK2OITlUH5wC1FzqWIPfJqnJIFD9Og+ppXDluLDn8kkDh
         c9B7yr4ifPlwDCVCdZb3bRL/R/M4da9bu/waThjylYg7w7whJKQUlh4Lu3jLPXEXb9w3
         BlS2Afxu0IZflZXcbLZJvgnYcjbqHnvYyDvAsyw+LLPHwHO1tyGhUMMKNJLovcUsakAq
         29oQ==
X-Gm-Message-State: APjAAAUzbwZKEAjkPqKOaZMLEA6rCrD1A2Lgz+uuyYJcK9AbRn2pUMgH
        QP6wmyXduNJQqOPEug4OzTJ5kOLoTbpbSgEoF1xqCw==
X-Google-Smtp-Source: APXvYqwLsTkBhD+JXuoYd0YiBJ40far/Mr1VffoGAd/nZJq0HX5zUliZoPpUOzjdEU4PFgvq3v4aP4z3f7yPSK03Ve0=
X-Received: by 2002:a1c:4886:: with SMTP id v128mr624236wma.176.1568327346726;
 Thu, 12 Sep 2019 15:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com> <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com> <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com> <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com> <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com> <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com> <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com> <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
In-Reply-To: <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 12 Sep 2019 16:28:55 -0600
Message-ID: <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     General Zed <general-zed@zedlx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 3:34 PM General Zed <general-zed@zedlx.com> wrote:
>
>
> Quoting Chris Murphy <lists@colorremedies.com>:
>
> > On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
> >>
> >> It is normal and common for defrag operation to use some disk space
> >> while it is running. I estimate that a reasonable limit would be to
> >> use up to 1% of total partition size. So, if a partition size is 100
> >> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
> >
> > The simplest case of a file with no shared extents, the minimum free
> > space should be set to the potential maximum rewrite of the file, i.e.
> > 100% of the file size. Since Btrfs is COW, the entire operation must
> > succeed or fail, no possibility of an ambiguous in between state, and
> > this does apply to defragment.
> >
> > So if you're defragging a 10GiB file, you need 10GiB minimum free
> > space to COW those extents to a new, mostly contiguous, set of exents,
>
> False.
>
> You can defragment just 1 GB of that file, and then just write out to
> disk (in new extents) an entire new version of b-trees.
> Of course, you don't really need to do all that, as usually only a
> small part of the b-trees need to be updated.

The `-l` option allows the user to choose a maximum amount to
defragment. Setting up a default defragment behavior that has a
variable outcome is not idempotent and probably not a good idea.

As for kernel behavior, it presumably could defragment in portions,
but it would have to completely update all affected metadata after
each e.g. 1GiB section, translating into 10 separate rewrites of file
metadata, all affected nodes, all the way up the tree to the super.
There is no such thing as metadata overwrites in Btrfs. You're
familiar with the wandering trees problem?


-- 
Chris Murphy
