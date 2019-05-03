Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47E712BE2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfECKxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 06:53:39 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35772 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfECKxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 May 2019 06:53:39 -0400
Received: by mail-ua1-f65.google.com with SMTP id g16so1855832uad.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2019 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xcVg8vnj5P+IyNzn5ETZl6occUn1iGo3nNWWpdWtS4o=;
        b=phmxpE4VeJsCi63GDD60kG9ylxXK3MHL0s4U807B2FFKOWkU/xwqzL3X48+ptPi2JU
         CfCVpqSAYVRO3vu4U2f0RoDmhSqacbviVITCO3Ofuwiupc0cxrkz6w2040BGu/owHolS
         4DkNscpliD7hWXJGZJb+fpHtnjoPWaGqt69Yanl5+TITo57J0ye1Rd5/rQQZWvZivjIa
         tz9FBF0/KGpk5oRErJmF4pcbzrR0lOuJhtlmO+ZHoLiyPVYj2/jduoACjDSlZTB/jeKQ
         Yvop/d/ldSCb/fhYwOJMR8dS+EDB6lPTYHZfbJx07dyPRBvLRPjwonP9ON+4dK0IpPzC
         3/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xcVg8vnj5P+IyNzn5ETZl6occUn1iGo3nNWWpdWtS4o=;
        b=hFHzzOZTK15ILIqVE+pXkN07eTilZPsYHx2nc9VXNfiuqfgWhwc3cGqNhqTTut0Ja+
         A5JoSBty8XFBwPsWfirdvzOF9jPqwoKoVREm9VFs9F720rRkWDdO9ZsBqE1lZYS4tUqq
         Mw+LeRM2JBSdk2vEPQbUTB8WimTnnpNj4YRIPSYNEUuBy2rVocjH6I4uj/m294TT2Y4W
         UNiwgEEkXCu/zlRlqOTR424do5++aBmp327993sSuKRpwrczfghvXQtJjZlwOjji9BDS
         FdDx4WM9VoWXC82bxv2gtOHqjuEZ82Vp3L9qU21l4UtN6wbk1ChhQ3G0yhDa2yQDdAf6
         TDPg==
X-Gm-Message-State: APjAAAXL/dREOkIXhX/0NZZjOJD2uZdHyBAe02oS8zd6gyKBzTGwCZSK
        I6paio3yPR7/ZU4lSOqA6JEX8lgk7oK3aVoEKTzqExsk
X-Google-Smtp-Source: APXvYqx3J2DCIIS18fDQWm/VdOMBs6HK/IZsT8K9yLDEUpdI1PiIdCgyBIVv1pvoZ153FgYGgAmIITpf+ZANgq2QTdo=
X-Received: by 2002:ab0:1e2:: with SMTP id 89mr4923351ual.0.1556880817950;
 Fri, 03 May 2019 03:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190426110922.21888-1-robbieko@synology.com>
In-Reply-To: <20190426110922.21888-1-robbieko@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 May 2019 11:53:27 +0100
Message-ID: <CAL3q7H74euwNzawfYJTv-yb_HUfUod9qrFZvb=tnFDZ+vf1jww@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: avoid allocating too many data chunks on massive
 concurrent write
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 26, 2019 at 12:10 PM robbieko <robbieko@synology.com> wrote:
>
> From: Robbie Ko <robbieko@synology.com>
>
> I found a issue when btrfs allocates much more space than it actual neede=
d
> on massive concurrent writes. That may consume all free space and when it
> need to allocate more space for metadata that result in ENOSPC.
>
> I did a test that issue by 5000 dd to do write stress concurrently.
>
> The space info after ENOSPC:
> Overall:
> Device size: 926.91GiB
> Device allocated: 926.91GiB
> Device unallocated: 1.00MiB
> Device missing: 0.00B
> Used: 211.59GiB
> Free (estimated): 714.18GiB (min: 714.18GiB)
> Data ratio: 1.00
> Metadata ratio: 2.00
> Global reserve: 512.00MiB (used: 0.00B)
>
> Data,single: Size:923.77GiB, Used:209.59GiB
> /dev/devname 923.77GiB
>
> Metadata,DUP: Size:1.50GiB, Used:1022.50MiB
> /dev/devname 3.00GiB
>
> System,DUP: Size:72.00MiB, Used:128.00KiB
> /dev/devname 144.00MiB

So can you provide more details? What parameters you gave to the dd process=
es?

I tried to reproduce that like this:

for ((i =3D 0; i < 5000; i++)); do
  dd if=3D/dev/zero of=3D/mnt/sdi/dd$i bs=3D2M oflag=3Ddsync &
  dd_pids[$i]=3D$!
done

wait ${dd_pids[@]}

But after it finished, the used data space was about the same as the
allocated data space (it was on a 200G fs).
So I didn't observe the problem you mention, even though at first
glance the patch looks ok.

Thanks.

>
> We can see that the Metadata space (1022.50MiB + 512.00MiB) is almost ful=
l.
> But Data allocated much more space (923.77GiB) than it actually needed
> (209.59GiB).
>
> When the data space is not enough, this 5000 dd process will call
> do_chunk_alloc() to allocate more space.
>
> In the while loop of do_chunk_alloc, the variable force will be changed
> to CHUNK_ALLOC_FORCE in second run and should_alloc_chunk() will always
> return true when force is CHUNK_ALLOC_FORCE. That means every concurrent
> dd process will allocate a chunk in do_chunk_alloc().
>
> Fix this by keeping original value of force and re-assign it to force in
> the end of the loop.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  fs/btrfs/extent-tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index c5880329ae37..73856f70db31 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4511,6 +4511,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle=
 *trans, u64 flags,
>         bool wait_for_alloc =3D false;
>         bool should_alloc =3D false;
>         int ret =3D 0;
> +       int orig_force =3D force;
>
>         /* Don't re-enter if we're already allocating a chunk */
>         if (trans->allocating_chunk)
> @@ -4544,6 +4545,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle=
 *trans, u64 flags,
>                          */
>                         wait_for_alloc =3D true;
>                         spin_unlock(&space_info->lock);
> +                       force =3D orig_force;
>                         mutex_lock(&fs_info->chunk_mutex);
>                         mutex_unlock(&fs_info->chunk_mutex);
>                 } else {
> --
> 2.17.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
