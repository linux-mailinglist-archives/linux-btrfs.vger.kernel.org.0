Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E5547BF0
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jun 2022 22:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiFLUGp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jun 2022 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFLUGp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jun 2022 16:06:45 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA8E0A6
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 13:06:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e80so4241397iof.3
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Jun 2022 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qM46kmE63ywK25c2DmCHG8dX8IU5SIZb4izUZKQgRE8=;
        b=R+erQifFFCfuQklJvv9voZ01qESBZ+Bj+8xEe8mz0Pu/jz+U2nD0kz+QY0WAzDoCXw
         r/a8ihV50c/M8Fd9Mv/+Fl8hqRUWfW+N5HebMr6IcsWAAa4FLycLqAYtxTGMrmKACCiz
         Igc0SO/8PhCe5cX/LrH7hpsUL1kisaQEyEH69mfoOSfzP18Ermw96J2R4MstQu0KW5jv
         ytpjd2oIRQSlqBe11NHshqwZfPSDMpN6lau/gfX6HcK1/Xv/Vi+QhZe27yXJlm7AYpNy
         VvJt+3lSkerLyLLjKb+Zj8MfSh4DswNMN/60jyve0zVMwksoibhCqgXnxDOBFUsGqK6j
         t5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qM46kmE63ywK25c2DmCHG8dX8IU5SIZb4izUZKQgRE8=;
        b=IbOzka+9o3rpcZpEcPwxNGVwK1SNsHGvI0gXhXN2L9nl0X59/kFPV2gQ5emBU+YU28
         Vq/wOYYnOMFpAnh1nc2aij3jJaI9t8VJ4MSGu0na1TsqKuaUMXnSsOIjLby0DH2+4hao
         VnHEQTQWzOkuP62+yqKrygcV7kK/tHOdZBTZ5i+KtgKSKCHFY+Sgh+K15gb5zsgI28vw
         nJ3YGOifBk6RsQEI56WLUReT4Zjnp31nMWEiNtr8NDPV2ZK99HchmhsAHH11aI/FhDWF
         x0kIijx2dSVfSOyt5F5g4l71b+fr25dENRVDYJAor+KSJJB6TKWghPqGsEeSZodrmiDi
         O/8Q==
X-Gm-Message-State: AOAM5300k1LpzRjTMCvvgITmVvxrLhdMJN5Tu8J1Y3/CCZ57C7LGbsW2
        K/OS2ifsCGrtVa8PCKxQN9IjOcqsKtyOcJ+vGDM+Yr71HIg=
X-Google-Smtp-Source: ABdhPJwop/PoRGtPxv3aGktg+VwG3qVFtOA3TmLjFkDdHWTZXkPYwz9X5gPDRinE/YQYpug0EWhwbYIvkA9q/wZmbvA=
X-Received: by 2002:a05:6602:3408:b0:669:cf03:f342 with SMTP id
 n8-20020a056602340800b00669cf03f342mr3881892ioz.166.1655064403895; Sun, 12
 Jun 2022 13:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220611001404.GM22722@merlins.org> <CAEzrpqda3=rDV8eLPsSDHbvmbyTnceecNkQUNA6mfOMmik=xDw@mail.gmail.com>
 <20220612173722.GA1843303@merlins.org>
In-Reply-To: <20220612173722.GA1843303@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 12 Jun 2022 16:06:33 -0400
Message-ID: <CAEzrpqdiOaoidWBtmbxemttKBiBwC-V6QfMint8us8-=rqpVWw@mail.gmail.com>
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

On Sun, Jun 12, 2022 at 1:37 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, Jun 11, 2022 at 10:59:15AM -0400, Josef Bacik wrote:
> > Oops, sorry about that, fixed it up.  My wife is travelling this week
> > so I'm going to be a little slower than normal, but hopefully we're
> > getting close to the end here.  Thanks,
>
> In the meantime, I'm building the new replacement filesystem. I used
> your tree to have the latest mkfs.btrfs.
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./mkfs.btrfs -m dup -L dshelf1 /dev/mapper/dshelf1n
> btrfs-progs v5.16.2
> See http://btrfs.wiki.kernel.org for more information.
>
> NOTE: several default settings have changed in version 5.15, please make sure
>       this does not affect your deployments:
>       - DUP for metadata (-m dup)
>       - enabled no-holes (-O no-holes)
>       - enabled free-space-tree (-R free-space-tree)
>
> Label:              dshelf1
> UUID:               ee91f407-39cb-41ef-bd7b-89eee4504ad5
> Node size:          16384
> Sector size:        4096
> Filesystem size:    43.66TiB
> Block group profiles:
>   Data:             single            8.00MiB
>   Metadata:         DUP               1.00GiB
>   System:           DUP               8.00MiB
> SSD detected:       no
> Zoned device:       no
> Incompat features:  extref, skinny-metadata, no-holes
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>    ID        SIZE  PATH
>     1    43.66TiB  /dev/mapper/dshelf1n
>
> Does this look ok?

Yup this is everything I want to see right now.  Here's hoping the new
setup lasts more than a couple of years between catastrophes.  Thanks,

Josef
