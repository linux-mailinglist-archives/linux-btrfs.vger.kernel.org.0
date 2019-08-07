Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3D84734
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbfHGI0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:26:43 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37613 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbfHGI0m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 04:26:42 -0400
Received: by mail-vs1-f66.google.com with SMTP id v6so60195963vsq.4
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wvxX4HnwFhFL0mVKgKf4vEO+g72YTqRJllWkh8ndkhM=;
        b=Z5u+nwwxxPV7eMpwFUsLiFvqZQgDE+4OjDF6820u9HXCTaspW1dH6BWg33kXk+nC2Q
         Hzi9ajN+YKkKxqLAwSLRdVfYmMRWEylNudXI2MmvUPAQ0b5u6SDNxlYpE+IhGVAo9ljw
         lcB7V7YT7Uvx+qNam+EBcfUZ/7AV8D0K2Mz4EXEBokHO4eD57OIAzxEZk94YVZtmVKtb
         F1l7o2MB2m1GVPl+Ix7UJlcO19x5YuiJHHvB4u4oiMqmxbdyIEOaWg4FFkh8hNRG2RAu
         J6QvI7f+WVQwwGmGcSTe+PwJ6Di/PotfC0gcOY+5YedBu+miRTYq006xVTsBGNVDQnAE
         xGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wvxX4HnwFhFL0mVKgKf4vEO+g72YTqRJllWkh8ndkhM=;
        b=Z1aS+wdLSDZxgXixksfq7plHGFzxb7vmyr30ncWvUjDQb3lshK7DFAYolTUsaVOA07
         wn1UcozfXfrGiWPnArZ4RULJfe/Id64Buow4cGs7R0WMZXdAlyUiWTnTMH1GzkTfozOQ
         fMO79KiDtrot3aj9nLebks585BE5/SM6itf25s0PxjJb0YL0QlAF+KNyClUw1pgkdms3
         FBmsiEjwm+57dtOu/onbr4DC7g4FqjClmf7+G9JmvCS2TwHXTjhkPhLWyeH351xRvWB7
         SoXxT1J++XvzdsswaO/JIWVQQJOKW4bdNh0DtePeszcKCaxvzHeRY7TygNpgQ+EDroBU
         3itA==
X-Gm-Message-State: APjAAAURjRGgBCDENJGGxri3foQAiXL7dydFrvx20dGdIAuXaKPgPuPn
        VvZrZcWCLeT0KzPuHpTrSGgnA97XRewBzmuC0hOvoA==
X-Google-Smtp-Source: APXvYqzWzJx4RBKCPa9qeCWrsMugxKj89S0FCIMrZlVC2KBRN8eCAtZdOA+Vb7BDsT17iAoxVgtdgTyN90ND2I7E2FU=
X-Received: by 2002:a67:7087:: with SMTP id l129mr4999068vsc.206.1565166401282;
 Wed, 07 Aug 2019 01:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190805144708.5432-1-nborisov@suse.com> <20190805144708.5432-3-nborisov@suse.com>
 <CAL3q7H7VnX7ez5VeYbKFk=W1s_1AeS0hYpmVPvZ4af4NJerjUw@mail.gmail.com> <df7b35d1-da0d-c99a-40dc-44c8ccd8d985@suse.com>
In-Reply-To: <df7b35d1-da0d-c99a-40dc-44c8ccd8d985@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 7 Aug 2019 09:26:30 +0100
Message-ID: <CAL3q7H4f6uutH4aWqO0nJoJ_d0p1mgCbvxVOoREVbG_DSA1yTg@mail.gmail.com>
Subject: Re: [PATCH 2/6] btrfs: Improve comments around nocow path
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 7, 2019 at 9:16 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 6.08.19 =D0=B3. 13:09 =D1=87., Filipe Manana wrote:
> > On Mon, Aug 5, 2019 at 3:48 PM Nikolay Borisov <nborisov@suse.com> wrot=
e:
>
> <snip>
>
> >> @@ -1371,23 +1376,39 @@ static noinline int run_delalloc_nocow(struct =
inode *inode,
> >>
> >>                 btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]=
);
> >>
> >> +               /* Didn't find anything for our INO */
> >>                 if (found_key.objectid > ino)
> >>                         break;
> >> +               /*
> >> +                * Found a different inode or no extents for our file,
> >> +                * goto next slot
> >
> > No. This does not mean that there are no extents for the file. If
> > there weren't any, we would break instead of iterating to the next
> > slot.
> > One example described at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D1d512cb77bdbda80f0dd0620a3b260d697fd581d
>
> I see, thanks for the pointer. How about the following :
>
> /*
>                  * Keep searching until we find an EXTENT ITEM or are
> sure
>                  * there are no more extents for this inode
>
>                  */

Yes, that's just fine.

Thanks.

>
> While it doesn't mention the race condition this check, coupled with the
> next one (where we break if type > EXTENT_DATA_KEY), it reflects reality
> close enough?
>
>
> >
> >> +                */
> >>                 if (WARN_ON_ONCE(found_key.objectid < ino) ||
> >>                     found_key.type < BTRFS_EXTENT_DATA_KEY) {
> >>                         path->slots[0]++;
> >>                         goto next_slot;
> >>                 }
> >> +
> >> +               /* Found key is not EXTENT_DATA_KEY or starts after re=
q range */
> >>                 if (found_key.type > BTRFS_EXTENT_DATA_KEY ||
> >>                     found_key.offset > end)
> >>                         break;
> >>
> >> +               /*
> >> +                * If the found extent starts after requested offset, =
then
> >> +                * adjust extent_end to be right before this extent be=
gins
> >> +                */
> >>                 if (found_key.offset > cur_offset) {
> >>                         extent_end =3D found_key.offset;
> >>                         extent_type =3D 0;
> >>                         goto out_check;
> >>                 }
> >>
> >> +
> >> +               /*
> >> +                * Found extent which begins before our range and has =
the
> >> +                * potential to intersect it.
> >> +                */
> >>                 fi =3D btrfs_item_ptr(leaf, path->slots[0],
> >>                                     struct btrfs_file_extent_item);
> >>                 extent_type =3D btrfs_file_extent_type(leaf, fi);
> <snip>



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
