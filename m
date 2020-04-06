Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CB519FA10
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgDFQZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 12:25:17 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:35584 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgDFQZR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Apr 2020 12:25:17 -0400
Received: by mail-ua1-f53.google.com with SMTP id a6so161233uao.2
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Apr 2020 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=l958nbWsgauAQDP0r7TTCxcI2Ex87I2vuVUfo3Tm8hI=;
        b=pbWtqWAgcB0m8azgJf7+gm/iy3kql2yFLcSTvhOZmBowm76eKoUgsxOz/01FDESw/g
         9CWtioHkRFq9bTcObe4KVIqKO9BRfwt+a1lNsbnUsEmJmurKGN7FfgvirvNJWLcF3znv
         HlR73fASWbU1V1oI6YdQI4aLHtkgOT7xsNYMlqdlPVbX6cnIRQJ6+ySX8eStZFgl4D8K
         AXOBv84NYtyAbl/mnxS1XH1zLJ7RUoII6v86B4SqbFH65QkxcsUcMLzWH0Eawn3LZyaI
         6wtealvNYnt3gUBC0USE/SN1k2jxh88iMQ+cR1+vX899+o8MPXOpiZZcSy6BhxAgt2Et
         l9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=l958nbWsgauAQDP0r7TTCxcI2Ex87I2vuVUfo3Tm8hI=;
        b=WnJFXGpG9p7aeLdthEgqIWQYkrme07ERBbYfTGjkB97HeAPXBI8ZYJE9OG9kyegKL1
         oT5cmXndPovmdRTbxbtDe9Hv8+dghXGUUeu8GXuu7/FL1n8CjBr//xnhNaT3WZSKUs78
         0BWGECpWEKqc7bvXW/k+cRXP34lFtfgnM5nFtJl6R937x9WLm6RqhIVZ1t6Cgjb1Fj70
         uB4FB+rHVy0miF+Gv0OLDYDsHb+K3oImEOHJuwciLpGeAyEsR3iHvpGK/T1s+R0nTn4p
         QcIQjkM/L6Rm4cRh2G01wD4byeJMN5QnPAuNMk83tKyWxZ6HW3I+y95CnLQ6WuEPd7tS
         ZxBA==
X-Gm-Message-State: AGi0PuYrkMHOqXi/2mIWMRaWCbhPWzfOB191VXmpy8e0qRf1R5f5eG4U
        l2LHsJaU8Lr0OdthWkh7R+yQG9L5MeIiW8e82tIPe/uK
X-Google-Smtp-Source: APiQypIt7G4dic8+zLspfkR/DXapnV7IaL/eV35aT4PzYnw0V9ghCbgpknbxsyrJAY8UFD0uRtNrQ2m8pZDupk+1Jow=
X-Received: by 2002:ab0:5bcc:: with SMTP id z12mr219027uae.135.1586190315514;
 Mon, 06 Apr 2020 09:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <636dfbc5-32a7-bdf3-b83b-93e65901aa43@oracle.com>
In-Reply-To: <636dfbc5-32a7-bdf3-b83b-93e65901aa43@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 6 Apr 2020 17:25:04 +0100
Message-ID: <CAL3q7H5r9tjzBzLK7iG5uLztujm=s7rZvuT=TYCUhr61OG-brQ@mail.gmail.com>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 6, 2020 at 1:13 PM Anand Jain <anand.jain@oracle.com> wrote:
>
>
>
> > 7) When we do the actual write of this stripe, because it's a partial
> > stripe write
> >     (we aren't writing to all the pages of all the stripes of the full
> > stripe), we
> >     need to read the remaining pages of stripe 2 (page indexes from 4 t=
o 15) and
> >     all the pages of stripe 1 from disk in order to compute the content=
 for the
> >     parity stripe. So we submit bios to read those pages from the corre=
sponding
> >     devices (we do this at raid56.c:raid56_rmw_stripe()).
>
>
> > The problem is that we
> >     assume whatever we read from the devices is valid -
>
>    Any idea why we have to assume here, shouldn't the csum / parent
>    transit id verification fail at this stage?

I think we're not on the same page. Have you read the whole e-mail?

At that stage, or any other stage during a partial stripe write,
there's no verification, that's the problem.
The raid5/6 layer has no information about which other parts of a
stripe may be allocated to an extent (which can be either metadata or
data).

Getting such information and then doing the checks is expensive and
complex. We do validate an extent from a higher level (not in
raid56.c) when we read the extent (at btree_readpage_end_io_hook() and
btree_read_extent_buffer_pages()), and then if something is wrong with
it we attempt the recovery - in the case of raid56, by rebuilding the
stripe based on the remaining stripes. But if a write into another
extent of the same stripe happens before we attempt to read the
corrupt extent, we end up not being able to recover the extent, and
permanently corrupt destroy that possibility by overwriting the parity
stripe with content that was computed based on a corrupt extent.

That's why I was asking for suggestions, because it's nor trivial to
do it without having a significant impact on performance and
complexity.

About why we don't do it, I suppose the original author of our raid5/6
implementation never thought about that it could lead to a permanent
corruption.

>
>    There is raid1 test case [1] which is more consistent to reproduce.
>      [1] https://patchwork.kernel.org/patch/11475417/
>    looks like its result of avoiding update to the generation for nocsum
>    file data modifications.

Sorry, I don't see what's the relation.
The problem I'm exposing is exclusive to raid5/6, it's about partial
stripes writes, raid1 is not stripped.
Plus it's not about nodatacow/nodatacsum either, it affects both cow
and nocow, and metadata as well.

Thanks.

>
> Thanks, Anand
>
>
> > in this case what we read
> >     from device 3, to which stripe 2 is mapped, is invalid since in the=
 degraded
> >     mount we haven't written extent buffer 39043072 to it - so we get
> > garbage from
> >     that device (either a stale extent, a bunch of zeroes due to trim/d=
iscard or
> >     anything completely random).
> >
> > Then we compute the content for the
> > parity stripe
> >     based on that invalid content we read from device 3 and write the
> > parity stripe
> >     (and the other two stripes) to disk;
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
