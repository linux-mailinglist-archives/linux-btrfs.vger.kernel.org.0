Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12668535427
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245671AbiEZTzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiEZTzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 15:55:42 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AE880E5
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 12:55:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i74so2644851ioa.4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zj+lvpat17Ta0oh6tMyrS55FK0MQojB5Jj1jnPxcWlQ=;
        b=xdsdmUM/03kSZbxYgBkpGUwdOt4ny1kzjuYwLCPh5YbEJyqvrTBVe4O6UZB7j3NI5l
         WUyD1GLCakE7TF3ATA94BG89KpHfSpXaLkkiikHRVjZu1DbXwqoBwQeT8Ei/yc4FWMD6
         NBMEkWNdKCXzb+z68dlxp9HAwtU2eRaM8YdrziVCw8ed1bmHxzZ8/GZ+T9iKUp0P0L/9
         +aHe50Zl1aXOx9MuKcqQcMgaPBYPH4FfYkjznTjIOxkLzvapEwsH6pGhTomvA7eY6lO5
         VtHzWO0I8RGzXx9IcP+BHLiK2pz1706s7RHEw8JVrQmBcfBFLUnENOou/9gWzhyh5ADE
         HY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zj+lvpat17Ta0oh6tMyrS55FK0MQojB5Jj1jnPxcWlQ=;
        b=2W2Yumww6bNUcIZnROmEnN8jWrexwC16XK84RqoWkU7iY2PH6uMmmReBK+VsrXDJ8O
         Ax2v//HzMMIBlxDlOY9vfxNLjrLXaZHGBOIau/By8+7iwoJtroAGf8vLIvBOSWryzSnf
         2xXo2/xs6yglcyRvtLqpPQPO/44yxIZ4VX5Sh5iCjoGZlBnS07p5U+JQ7ORhal0cadSd
         jLMXqgzr920sEjnd1QE7EQOlQhiqfsZKsD4TVjXmIfl24w3vCflxrUtEF30kXbmYDDOe
         EQl6Xyi9/wOtmq4fkYuFcsug6MBdOscXbdEaf0SfVrciOy7sHBDHq+EL2esMq3QJ1N+p
         3Xag==
X-Gm-Message-State: AOAM531JTmEK3h6wGNPDvQLl5sK4yBUtR0GajpdBXrUqWXgpvyOiSDsB
        spA84v3mtMhLPsj7nf6Ep6ZMtPxIaRkSCv6lQcuBKq3UGsc=
X-Google-Smtp-Source: ABdhPJyUvL8DnSSp0/0ZQmryQ07whuOKyXhnfuME9F+PrJ/fpSh9FiKsgARYs0Fk2VFUIbWLIOdYtR1XS9NhuTW3d8s=
X-Received: by 2002:a02:9984:0:b0:32d:aeff:c592 with SMTP id
 a4-20020a029984000000b0032daeffc592mr20085943jal.46.1653594941097; Thu, 26
 May 2022 12:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220524011348.GR13006@merlins.org> <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
 <20220524191345.GA1751747@merlins.org> <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org> <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
 <20220526173119.GC1751747@merlins.org> <CAEzrpqemPU_=VTxGEQS2WtGiaGbHy+ssnj5MKyh=8JC36uyZ6Q@mail.gmail.com>
 <20220526181246.GA28329@merlins.org> <CAEzrpqfEmm0qGZkkdTgFYNjVvSn6SZwbdDUYLO2E3jV4DYELFQ@mail.gmail.com>
 <20220526191512.GE28329@merlins.org>
In-Reply-To: <20220526191512.GE28329@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 26 May 2022 15:55:29 -0400
Message-ID: <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 26, 2022 at 3:15 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, May 26, 2022 at 02:54:47PM -0400, Josef Bacik wrote:
> > > Do I do
> > > ./btrfs rescue tree-recover --init-extent-tree /dev/mapper/dshelf1
> > > or
> > > ./btrfs rescue tree-recover /dev/mapper/dshelf1
> >
> > Tree-recover first, lord I'm tired of our tools randomly not updating
> > root pointers.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> ERROR: cannot read chunk root
> WTF???
> ERROR: open ctree failed
> Tree recover failed

Sigh, I've pushed new code, build and run

./btrfs-find-root -o 3 <device>

and let me know what it says.  Thanks,

Josef
