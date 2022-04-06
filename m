Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D394F6B7C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiDFUgv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiDFUgo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 16:36:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E1B37CD24
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 11:57:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g21so4055930iom.13
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzTgnMUOKzBUjynuS37OKCtMFo0K3LRYd5b8zwnBE7M=;
        b=UZmX5JVmVGMY3A3NwTkOP89M4LE1sfv6WIx5roeFPjRhw/vCPteKj+NoBKE2tX0yBK
         uNPugAoVoHoAUXb4OEOzyNIikDTbTtIMaKjvkSLuV3LViwj4Uk65xkhQpZsNXjeiOCNd
         rCkI6Gs4CBe2DHKV3s6OSLV5oUcj7J9OVWrT6Cabpl/zCW8tLdEpepSYHb2ttJJKKg88
         Cg2VnzedrFBhCSWvgYZXt1kfvAgeOLH51Y/0iIJLqEjz8uSTeVuPZH3MpPwaFza63MXp
         WJbH4gDvhjeDLP0NUfM0pE+hUoP28SPa2KlmnQoBT7pz68vDI6MeywnggU3TRRUJk0Jg
         S0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzTgnMUOKzBUjynuS37OKCtMFo0K3LRYd5b8zwnBE7M=;
        b=lkH8okG0LPtM5+i13lfRWqhgnWN6Mu2/Y41OV7bAv8v3f2cvS6Ch8Kbwg5k8n88+Ue
         R2FNZIfo+j5FByN/3u+9h/GGuxDODHmajbaDWfV0y8wgFuBRGHW2x/s+N2T+j8I/GW80
         +0mwc1pUzUS6dUBF/rBT13lRUNJs9V7hez8wUNN92VaM2i/hgVAzD9a12w+CcK+OpG+K
         w8X6d8UywhHRDs3SHFbSVQsMEQ0ihXdqE42u28ha04d86K1PXhayP0p4nHTyQ3oDyagR
         Y+6pblaoKC6wshJ5ij+Iw47KXxAXqfNYGtrvsEHsqAIVsRS3vP9KxqUpCinsQC9XeFJa
         2PbA==
X-Gm-Message-State: AOAM531ncXlnVCX+qBrwFyV3EhaPRh528SlGKtCIndXYDwi+pAYdZHWV
        IdKKVsld31JFE6tvCmrpWQOjJfhIiJzCsaZHjDU+8vWnmwM=
X-Google-Smtp-Source: ABdhPJwYz7qpUdTN8PX3GP0enA+ryTLU7d5nQBktpk/+SrKrf2jqpo0AobOzgnXBSqJONSKFZTWpeN05jJazDZgs5Jc=
X-Received: by 2002:a05:6638:b1a:b0:311:4aa1:6c36 with SMTP id
 a26-20020a0566380b1a00b003114aa16c36mr5585919jab.281.1649271434997; Wed, 06
 Apr 2022 11:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220405214309.GI28707@merlins.org> <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
 <20220405225808.GJ28707@merlins.org> <CAEzrpqdtvY7vu50-xSFpdJoySutMWF3JYsqORjMBHNzmTZ52UQ@mail.gmail.com>
 <20220406003521.GM28707@merlins.org> <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org> <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com> <20220406185431.GB14804@merlins.org>
In-Reply-To: <20220406185431.GB14804@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 6 Apr 2022 14:57:03 -0400
Message-ID: <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 6, 2022 at 2:54 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 06, 2022 at 11:20:13AM -0400, Josef Bacik wrote:
> > On Tue, Apr 5, 2022 at 11:34 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, Apr 05, 2022 at 08:12:55PM -0700, Marc MERLIN wrote:
> > > > On Tue, Apr 05, 2022 at 09:08:32PM -0400, Josef Bacik wrote:
> > > > > Also keep in mind this isn't the final fix, this is the pre-repair so
> > > > > hopefully fsck can put the rest of it back together.  Thanks,
> > > >
> > > > Done, so now I can run
> > > > btrfs check --repair /dev/mapper/dshelf1a ?
> > >
> > > Here is regular check:
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check /dev/mapper/dshelf1a
> >
> > Woo ok we're almost there, that's great.  Can you re-run the
> > btrfs-find-root and see what it spits out this time?  It should run
> > faster now that it fixed everything, I'm wondering what it wasn't able
> > to fix and if I should run the same check on all the roots.  Thanks,
>
> took a few hours to run, but it's done now. Looks like it fixed things a 2nd time?
>
> Should I run
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs check --repair /dev/mapper/dshelf1a
> now?
>

Yeah lets go for that, I saw some errors on your fs tree's earlier, I
may need to adapt this to fix that tree, or if it's a snapshot we can
just delete it.  We can burn that bridge when we get to it, thanks,

Josef
