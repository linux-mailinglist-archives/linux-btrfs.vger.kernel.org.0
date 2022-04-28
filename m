Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED1513CF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 22:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351514AbiD1VBx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350419AbiD1VBw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 17:01:52 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123DAC0E66
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:58:36 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r27so2891673iot.1
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8EDrA6DPQAvNEWrs439+cSEEIc2RLAda36lmB4P/sk=;
        b=WQFbxU4RYkzigoykB+QKpjygripSq+Xf0lsEVHe8t/rpU4dypfbAtdtgPtZMkWddVC
         pTlcgkFLVaNzrZx6RiBFHu3cpdyQLhdwU+Hgw/mLMeee9iUaozgv03t8iXkSghEbzS/a
         dglt6reMwfDOggvkd21SnAitByZplmvbc2FsLSZMF4xaxtnynil02QtPH/oRn0WL8hsW
         AS6Z+CuZfUKDhhxL0pKmWRzaCzwAewIxmq4VrWrSL3Htwc6csmYhgY8eSl7bnE6rV4/x
         JVvbHYUqJkAMPy5f0NMbh3EYY59O8CvSDt8sN3aiShberAp0AYLi/Hy+vCTNRLQQkArh
         PtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8EDrA6DPQAvNEWrs439+cSEEIc2RLAda36lmB4P/sk=;
        b=FYMAqr/g8pLiXIupyuHzW1kK6XDkE3PWujWUVfYQAlTclvVeqQOQrWTLYoG8eDGJN8
         tsOR3m+FYzX3m/omJvZwj8z/Nq6VnVj7hD3YMRLsUUmcvAJToBoEXhZWLgi37uJ80vLX
         xtIHC5JuCAUPZXnahJRQrRcDDnSajWMZrH9rw3MSKZx2S00b0S+X/li8WRHMcdYyf6Lg
         II5/roIbYV71HIoqRVTl2KG8iWh0hA2kfL98SnzEN4NRl34z+5cufpHY9TeB5blH9Ag1
         15dXnTlTvBPTa/zQkIx0gf9WzXOP6HTWPs+HQiV/tDi6hE2hMSJ+LcVTy7/wmFrhxdVw
         rssg==
X-Gm-Message-State: AOAM5320wD2gmuU0fn7WvuCTWPgseziFY2ERVTL7adUbKNyXxBxfhWJd
        YXIHFx1Lli+Q4g47Y7cq2n/tUGTDY2uwLC8KtWIqQe3gvCg=
X-Google-Smtp-Source: ABdhPJzF2mb8MchuP6I4AMt6TczsrURmCIiPbuV4SKE5YuEJLPBa9pSDUoSauthb8eIVwg63Wd2eooNGE8klfF91BP8=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr15020664ioq.160.1651179515302; Thu, 28
 Apr 2022 13:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220428030002.GB12542@merlins.org> <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org> <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org> <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org> <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org> <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org>
In-Reply-To: <20220428205716.GU29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 16:58:24 -0400
Message-ID: <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 4:57 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 04:28:53PM -0400, Josef Bacik wrote:
> > "Make recovery tools more resilient" is definitely muuuuuch higher on
> > the team priority list that's for fucking sure.  Try again please,
> > hopefully it works this time.  Thanks,
>
> Great to hear, and obviously not just hearing, thanks for your
> persistence in this mega thread.
>
> Here's the new one:
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d
> "3700677820416,168,53248" -r 11223 /dev/mapper/dshelf1
> FS_INFO IS 0x55f248b64600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55f248b64600
> Error searching to node -2
>

-2 is enoent, it must have committed with the deleted block, which is
sort of scary but at this point I'll take it.  Go ahead and do the
init-extent-tree.  Thanks,

Josef
