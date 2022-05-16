Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475C75288E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 17:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiEPPbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbiEPPbj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 11:31:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D51192A6
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:31:37 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o16so2225375ilq.8
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+TAt7I5jiezXZsDlX9A+hPwZgfvHg8D87kfGMEU/04=;
        b=hpU6ZqrYJw8zPHL/baTTw1hhR/tjd4qA3YOWX9mJZOmbLpguWHF7m7ZqDiPStdz5Hx
         8KkJntZfI0WHMqqdoGxenhBBxyISLhlsO1o3/KrCbfkTzfZVKng9ipNiWOY0wAvZhXVr
         NWupzzMxZp9vRQI+y0VAihWjC52Qtz9sTO7pzSfRcuQA5pwvdfEgYWqrvnrQnT/7qUuC
         hk3Dp/jQQY0vVSfeJMvfS2kdwlwQk2upHSiuapDSMULVUK5HOgEcYZrEEdhL+uup9uYS
         BmN/h6MIZcdw9UtqxImmiJQGHekuhYqyRcMpVASIEswtHOi7E+MtxctOUDryIJG0Ty61
         y3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+TAt7I5jiezXZsDlX9A+hPwZgfvHg8D87kfGMEU/04=;
        b=ADbHtFFgj99ROnZmdkiSypKMIdmQruUdE6TrtasdhWNUzkbyw4A0yXWFBqV5FVLdQ9
         mC4zrHM+Gi0jKKx85WaccoLJy3AK1U+zf+4CrrYoDkAt0V6MturV6IDSQctNrfa5SHvO
         l/+AyImdQJZdLmqUTpRfr6RgkkhZSDgWK8q3V4kVlH+q+xMT0ZnvKyosUfj38T8RFBB2
         81kOd6Z4x9AX6wnWSyebRSq5X6ddrj9IXsgJVfji+MWgtNsKylB/YV+WTz6LQR7gk9Yp
         /FPcXJlvve7SElJt8mg33oezCpQ44UFMKsEJtlebbNitAtJybHtjCQJEKiGxetgVjp82
         t+ow==
X-Gm-Message-State: AOAM531GvPRk7qvztrS3Psap/FFik9tvmVZK9kR4fdntPI0con58iuFm
        FgOynMnsC+ni63/Oc4lITMyP9zMsXq6XXRvrtF49BuA/J0U=
X-Google-Smtp-Source: ABdhPJyB51GooIO5Pg2qZfTwGBziz0N8P1f0+4mEqWKSOdS27heHO70jwexl9u9vgZkNgnnBXxVAaJjfu3sqBaMn1xI=
X-Received: by 2002:a05:6e02:d06:b0:2d1:2be8:df10 with SMTP id
 g6-20020a056e020d0600b002d12be8df10mr1298876ilj.127.1652715096323; Mon, 16
 May 2022 08:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcVRJFS6HN4L7=tu0Z8SA+E2GsLJzWEADRK3iJvdVy4EA@mail.gmail.com>
 <20220515153347.GA8056@merlins.org> <CAEzrpqcZQVWwt1JSDg6z44dBYKW6fmmXmOTFoXiDWpoGXxufwQ@mail.gmail.com>
 <20220515154122.GB8056@merlins.org> <CAEzrpqc6MyW0t1H9ue_GQL-1AhgpWfumBfj3MK0eGstwJ3R1aw@mail.gmail.com>
 <20220515212951.GC13006@merlins.org> <20220515230147.GD13006@merlins.org>
 <CAEzrpqdbjeTYEy16KbzJ39bBkd8rkNTHA2n53UXHG-CdeUo6xw@mail.gmail.com>
 <20220516005759.GE13006@merlins.org> <CAEzrpqfMbB-sGLZUjGHjxHt1Gga+uULGkoZTqjXHwKnzsjP5aA@mail.gmail.com>
 <20220516151653.GF13006@merlins.org>
In-Reply-To: <20220516151653.GF13006@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 16 May 2022 11:31:24 -0400
Message-ID: <CAEzrpqcbEO3JUv50E9eAojNh5yPCHjuNfdFtq9=ev5cz8GtgJA@mail.gmail.com>
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

On Mon, May 16, 2022 at 11:16 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Mon, May 16, 2022 at 10:50:42AM -0400, Josef Bacik wrote:
> > > > btrfs-corrupt-block -d "1,204,941709328384" -r 3 <device>
> > > >
> > > > and then you should be good, unless there are other dangling dev
> > > > extents that need to be removed.  Thanks,
> > >
> > > Is that bad?
> >
> > Yeah, means I don't understand my own filesystem, use -r 4 instead
> > please.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1,204,941709328384" -r4 /dev/mapper/dshelf1
> FS_INFO IS 0x55e58be9e600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55e58be9e600
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "1,204,941709328384" -r 4 /dev/mapper/dshelf1
> FS_INFO IS 0x55e239055600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55e239055600
> Error searching to node -2
>
> Means it worked?

Yeah, probably should print out a "Error: Success!" when it does
actually do something.  Thanks,

Josef
