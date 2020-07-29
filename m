Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABDB231C95
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgG2KSu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 06:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2KSu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 06:18:50 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D862074B
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 10:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596017929;
        bh=LBhKv51dRgGep95keBcNNve1GRHnpqqTsevtBvb8Q/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OqvIauBwsItornMwyh4BblSMqK/dLhvxLt1tKzEavjith7jku947VUeWwmweqxnJp
         zn6PEgyLzpimpgqt1JXb8mxXlq5W0E/ylM85CFpSigtTSiXJ84AW6cvvZWvuTZYVRk
         RySM4+ZvbgaI8AXwMQmomqyDgVHI+Vzz6NysuOVY=
Received: by mail-ua1-f42.google.com with SMTP id y17so1358773uaq.6
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 03:18:49 -0700 (PDT)
X-Gm-Message-State: AOAM533GDjV48MoOAX4/UWcFW0ReNZLY8sJD3TiGiUPayU7uqdd0JtZq
        SW4NxvG+aMTU8Xf+iX+0xjqatrWppiNn/GUv5VU=
X-Google-Smtp-Source: ABdhPJyrZoTlGkcQkw2m9G1URbk02mR5C8+XQIdvbeDz0/pWBzjmhliR9taOY5wzkoAL4ddPKiTC3Yl3HJyQmLBOBIA=
X-Received: by 2002:ab0:22c9:: with SMTP id z9mr20922687uam.0.1596017928928;
 Wed, 29 Jul 2020 03:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200729091750.2538306-1-fdmanana@kernel.org> <SN4PR0401MB359867EB5CFA751D2643A6319B700@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB359867EB5CFA751D2643A6319B700@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 29 Jul 2020 11:18:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4mjfjLwQTPONkUR15Z_pQEksDgtt-YYC_vBe2cXctPzA@mail.gmail.com>
Message-ID: <CAL3q7H4mjfjLwQTPONkUR15Z_pQEksDgtt-YYC_vBe2cXctPzA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix memory leaks after failure to lookup checksums
 during inode logging
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 29, 2020 at 11:09 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 29/07/2020 11:18, fdmanana@kernel.org wrote:
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 20334bebcaf2..f1812f5baec4 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -4035,11 +4035,8 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
> >                                               fs_info->csum_root,
> >                                               ds + cs, ds + cs + cl - 1,
> >                                               &ordered_sums, 0);
> > -                             if (ret) {
> > -                                     btrfs_release_path(dst_path);
> > -                                     kfree(ins_data);
> > -                                     return ret;
> > -                             }
> > +                             if (ret)
> > +                                     break;
> >                       }
> >               }
> >       }
> > @@ -4052,7 +4049,6 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
> >        * we have to do this after the loop above to avoid changing the
> >        * log tree while trying to change the log tree.
> >        */
> > -     ret = 0;
> >       while (!list_empty(&ordered_sums)) {
> >               struct btrfs_ordered_sum *sums = list_entry(ordered_sums.next,
>
> Isn't there a potential that ret get overridden by this hunk:
>
>        while (!list_empty(&ordered_sums)) {
>                 struct btrfs_ordered_sum *sums = list_entry(ordered_sums.next,
>                                                    struct btrfs_ordered_sum,
>                                                    list);
>                 if (!ret)
>                         ret = log_csums(trans, inode, log, sums);
>                 list_del(&sums->list);
>                 kfree(sums);
>         }

Nop, when ret is non-zero it never gets overwritten.

>
>         return ret;
>
> and we're potentially returning 0 instead of the -ENOMEM from 'btrfs_lookup_csums_range'?

Nop, for the same reason mentioned before.

Thanks.

>
> Maybe we should do something like this:
>
>        while (!list_empty(&ordered_sums)) {
>                 struct btrfs_ordered_sum *sums = list_entry(ordered_sums.next,
>                                                    struct btrfs_ordered_sum,
>                                                    list);
>                 if (!ret)
>                         ret2 = log_csums(trans, inode, log, sums);
>                 list_del(&sums->list);
>                 kfree(sums);
>         }
>
>         return ret2 ? ret2 : ret;
>
> Thanks,
>         Johannes
