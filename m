Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0828FFA8
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 12:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfHPKDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 06:03:46 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36605 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfHPKDq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 06:03:46 -0400
Received: by mail-vs1-f68.google.com with SMTP id y16so3375409vsc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ihjKLv1Fm0VAXv1Wuq8RtMuoKWw/xddBcRqqeFCoeEg=;
        b=D2WwUp6S0DjbkzZeyqk4iaovyNVAge78PVI3yT1HmKt5XFJGjXE+TF5LdaFJymSDEw
         hWQoaBmVnpj2bkbcNHZ9Ip6b0z8+9G+6IuZKlDgI2Vxio7ib3mSNllMhEBGFopxmssTH
         AQy27mndHbdLw9XwPTrI84QH2bwY2n97biHsBh5drK+8kmOqa1jU+E3u8+RnBCDeaGeS
         WKZSAqJtoi8wEuD+r3jTLU92Uv0bc6s6CIrZQ8gl2p9Ub25R1ibHqW9pnr2BdsHpkpR0
         W0TgE9dwSDeVshnxPIx0In00UZ5mEmsgW6Ntb5Ztn4tzi+Tyth7NdOppHD1mmCVlUM2P
         JBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ihjKLv1Fm0VAXv1Wuq8RtMuoKWw/xddBcRqqeFCoeEg=;
        b=IZKASjT9KeeUMQSeRns5uAxedzZhU7MvR7VL8eNSu6OLdRVr8+B8VaQX1hPERbd/zi
         WeV1MfRK6COFWV4c16HtxekLdbVu0ZFP6jF1pOlSIcFlx88Wt3GpgyoNa1MCpewrcUSm
         GCBmDJ8kaTgf0eTA4U8DGiVc6hP0OEMCcyKotx7AZMm/wj/KLmy0R91fZ9Bqj2wOb9PB
         +FPTFDXoPjyLYZq07Ywv7edmzHObDmGgANs8DtZ6t3TBfEPEbexqznU0Vc2dz3xC463L
         V0iczdciakStm2gg9CdB9B2WlfSZ+qFLA9Fibkos4JHIcFoGxxLv+HdqYxjhPnLNiwy6
         svjw==
X-Gm-Message-State: APjAAAWExfxj77euYDywyr2vO7QDkn8uEtVhxWuV7f946WF7sqTOU83t
        Gxqypu6CyY8INVvpx+4jZeHVqCC3YEc2dRNeLk0=
X-Google-Smtp-Source: APXvYqxYFp4KlwmN/KZyRUy5HtS5FFem8VyzZ7+/aAaNjAj4eazen5HgIPbK48kt6I94akMwQVPBekoxBBw0duVrP7c=
X-Received: by 2002:a67:f3d6:: with SMTP id j22mr5399128vsn.95.1565949824815;
 Fri, 16 Aug 2019 03:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190815080404.20600-1-wqu@suse.com> <CAL3q7H75=BecnH0L34OAKmQcbHPDegsO6YxVxJgg--wv_cgciA@mail.gmail.com>
 <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
In-Reply-To: <54b0adec-ce06-90f0-e0e1-8ecd7e5b4915@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 16 Aug 2019 11:03:33 +0100
Message-ID: <CAL3q7H4jM5ydhOazozLQR5kQnAi84WhPHu7uFm+k8zFy31-agQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: transaction: Commit transaction more frequently
 for BPF
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 16, 2019 at 10:53 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/8/16 =E4=B8=8B=E5=8D=885:33, Filipe Manana wrote:
> > On Thu, Aug 15, 2019 at 9:36 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Btrfs has btrfs_end_transaction_throttle() which could try to commit
> >> transaction when needed.
> >>
> >> However under most cases btrfs_end_transaction_throttle() won't really
> >> commit transaction, due to the hard timing requirement.
> >>
> >> Now introduce a new error injection point, btrfs_need_trans_pressure()=
,
> >> to allow btrfs_should_end_transaction() to return 1 and
> >> btrfs_end_transaction_throttle() to fallback to
> >> btrfs_commit_transaction().
> >>
> >> With such more aggressive transaction commit, we can dig deeper into
> >> cases like snapshot drop.
> >> Now each reference drop of btrfs_drop_snapshot() will lead to a
> >> transaction commit, allowing dm-logwrites to catch more details, other
> >> than one big transaction dropping everything.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Add comment to explain why this function is needed
> >> ---
> >>  fs/btrfs/transaction.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> >> index 3f6811cdf803..8c5471b01d03 100644
> >> --- a/fs/btrfs/transaction.c
> >> +++ b/fs/btrfs/transaction.c
> >> @@ -10,6 +10,7 @@
> >>  #include <linux/pagemap.h>
> >>  #include <linux/blkdev.h>
> >>  #include <linux/uuid.h>
> >> +#include <linux/error-injection.h>
> >>  #include "ctree.h"
> >>  #include "disk-io.h"
> >>  #include "transaction.h"
> >> @@ -749,10 +750,25 @@ void btrfs_throttle(struct btrfs_fs_info *fs_inf=
o)
> >>         wait_current_trans(fs_info);
> >>  }
> >>
> >> +/*
> >> + * This function is to allow BPF to override the return value so that=
 we can
> >> + * make btrfs to commit transaction more aggressively.
> >> + *
> >> + * It's a debug only feature, mainly used with dm-log-writes to catch=
 more details
> >> + * of transient operations like balance and subvolume drop.
> >
> > Transient? I think you mean long running operations that can span
> > multiple transactions.
>
> Nope, really transient details.
>
> E.g catching subvolume dropping for each drop_progress update. While
> under most one transaction can contain multiple drop_progress update or
> even the whole tree just get dropped in one transaction.
>
> >
> >> + */
> >> +static noinline bool btrfs_need_trans_pressure(struct btrfs_trans_han=
dle *trans)
> >> +{
> >> +       return false;
> >> +}
> >> +ALLOW_ERROR_INJECTION(btrfs_need_trans_pressure, TRUE);
> >
> > So, I'm not sure if it's really a good idea to have such specific
> > things like this.
> > Has this proven useful already? I.e., have you already found any bug us=
ing this?
>
> Not exactly.
> I have observed a case where btrfs check gives false alert on missing a
> backref of a dropped tree.

Wasn't this fixed by Josef in
https://github.com/kdave/btrfs-progs/commit/42a1aaeec47bc34ae4a923e3e8b2e55=
b59c01711
?
That's normal, the first phase of dropping a tree removes the
references in the extent tree, and then only in the second phase we
drop the leafs/nodes that pointed to the extent.

>
> Originally planned to use this feature to catch the exact update, but
> the problem is, with this pressure, we need an extra ioctl to wait the
> full subvolume drop to finish.

That, the ioctl to wait (or better, poll) for subvolume removal to
complete (either all subvolumes or just a specific one), would be
useful.

Thanks.

>
> Or we will get the fs unmounted before we really go to DROP_REFERENCE
> phase, thus dm-log-writes gets nothing interesting.
>
> Thanks,
> Qu
>
> >
> > I often add such similar things myself for testing and debugging, but
> > because they are so specific, or ugly or verbose, I keep them to
> > myself.
> >
> > Allowing the return value of should_end_transaction() to be
> > overridden, using the same approach, would be more generic for
> > example.
> >
> > Thanks.
> >
> >> +
> >>  static int should_end_transaction(struct btrfs_trans_handle *trans)
> >>  {
> >>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >>
> >> +       if (btrfs_need_trans_pressure(trans))
> >> +               return 1;
> >>         if (btrfs_check_space_for_delayed_refs(fs_info))
> >>                 return 1;
> >>
> >> @@ -813,6 +829,8 @@ static int __btrfs_end_transaction(struct btrfs_tr=
ans_handle *trans,
> >>
> >>         btrfs_trans_release_chunk_metadata(trans);
> >>
> >> +       if (throttle && btrfs_need_trans_pressure(trans))
> >> +               return btrfs_commit_transaction(trans);
> >>         if (lock && READ_ONCE(cur_trans->state) =3D=3D TRANS_STATE_BLO=
CKED) {
> >>                 if (throttle)
> >>                         return btrfs_commit_transaction(trans);
> >> --
> >> 2.22.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
