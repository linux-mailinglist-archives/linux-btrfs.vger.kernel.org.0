Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDA19C128
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgDBMeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 08:34:00 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44761 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgDBMeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 08:34:00 -0400
Received: by mail-vs1-f65.google.com with SMTP id e138so2111399vsc.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=X2Ug9vb15AzqWVots4Gl5Azq+u8z+m62Z4p4oz4aM/E=;
        b=Kbne1m+Qz4Tub96ckJeM0xBVuRCVSvaGy29KdFqb8KDoZO6duGnE8xzEb74+JF27o/
         R68CGtTEpicRRyzmWDX8pqnnpyNeYKnkFAi9BRy52kfGPyPyDPCZ0JP/mw/C4DBpC46A
         SWQeBdqBhnEGBC8ZfWb/qNnMltjOwZWSIyxbA2/iMTKaJK2evg7bD9/tKoJPQAgzFREs
         45KYiLatQz2Hz+PYa36CT8njxFFBsYFEl9RZ4WmXBeIMsNIqE45Tvon3MNlaif+jDlOs
         ed5OyBz0DaQOTGZ7G9ib85kw0GMH6MHSBPp/wfdDzmWDKZxhy9HLXzSZidQGA3wTELEE
         rnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=X2Ug9vb15AzqWVots4Gl5Azq+u8z+m62Z4p4oz4aM/E=;
        b=HTO+0f81nvxQZORQPJWT1fAFKJ593xGM0nAxPE3lbUYGCjUC6ANPfMDZ/8vq92Tkwl
         ZWtnll+bvEC9HaANOONBHUc8/7jHN0U3ZogfVKVFY4KyJfpRSc3weMMO5uwnT0Z5Rp8f
         82enrXBnQlssdDoXg7RWfUYtd0TYAm8ccmzOj4xj+R0tic3AqkQHc7pSjeZ9ZWF2btdu
         wmiZR1z9Rsywo5EN+R/akSrdVGlxz10sFlGqH9ZVllsVJSVbhV4ZSuSyYH3Rd+fhZEcr
         29NOujbK3Nd0TyDJqcU4yQdjFmu9J3aEq5YxPXeNI02RxWESQn4wdkl72a1BKgf5v306
         F+tg==
X-Gm-Message-State: AGi0PubAJo1cjPu5SXbxovZl1u4MCfbyubEXYEgxoXC//qUvMy+xBGRh
        VkXnfAK/XCRPd+p7Do7Xa/SFV88pX7GnFk/t1eg=
X-Google-Smtp-Source: APiQypKuHeSaVIpm7eBBGXpP9PnSDLVjeh7q3zxBFa/RhfhU7Hb0pT9XL9bAltbavXiXcc50PO9LwaYTZ5GrYDtHhuA=
X-Received: by 2002:a05:6102:2414:: with SMTP id j20mr2143298vsi.206.1585830836262;
 Thu, 02 Apr 2020 05:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
In-Reply-To: <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 2 Apr 2020 12:33:45 +0000
Message-ID: <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 2, 2020 at 12:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/4/2 =E4=B8=8B=E5=8D=887:08, Filipe Manana wrote:
> > Hi,
> >
> > Recently I was looking at why the test case btrfs/125 from fstests ofte=
n fails.
> > Typically when it fails we have something like the following in dmesg/s=
yslog:
> >
> >  (...)
> >  BTRFS error (device sdc): space cache generation (7) does not match in=
ode (9)
> >  BTRFS warning (device sdc): failed to load free space cache for block
> > group 38797312, rebuilding it now
> >  BTRFS info (device sdc): balance: start -d -m -s
> >  BTRFS info (device sdc): relocating block group 754581504 flags data|r=
aid5
> >  BTRFS error (device sdc): bad tree block start, want 39059456 have 0
> >  BTRFS info (device sdc): read error corrected: ino 0 off 39059456
> > (dev /dev/sde sector 18688)
> >  BTRFS info (device sdc): read error corrected: ino 0 off 39063552
> > (dev /dev/sde sector 18696)
> >  BTRFS info (device sdc): read error corrected: ino 0 off 39067648
> > (dev /dev/sde sector 18704)
> >  BTRFS info (device sdc): read error corrected: ino 0 off 39071744
> > (dev /dev/sde sector 18712)
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1376256
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1380352
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1445888
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1384448
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1388544
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1392640
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1396736
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1400832
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1404928
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS warning (device sdc): csum failed root -9 ino 257 off 1409024
> > csum 0x8941f998 expected csum 0x93413794 mirror 1
> >  BTRFS info (device sdc): read error corrected: ino 257 off 1380352
> > (dev /dev/sde sector 718728)
> >  BTRFS info (device sdc): read error corrected: ino 257 off 1376256
> > (dev /dev/sde sector 718720)
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS error (device sdc): bad tree block start, want 39043072 have 0
> >  BTRFS info (device sdc): balance: ended with status: -5
> >  (...)
> >
> > So I finally looked into it to figure out why that happens.
> >
> > Consider the following scenario and steps that explain how we end up
> > with a metadata extent
> > permanently corrupt and unrecoverable (when it shouldn't be possible).
> >
> > * We have a RAID5 filesystem consisting of three devices, with device
> > IDs of 1, 2 and 3;
> >
> > * The filesystem's nodesize is 16Kb (the default of mkfs.btrfs);
> >
> > * We have a single metadata block group that starts at logical offset
> > 38797312 and has a
> >   length of 715784192 bytes.
> >
> > The following steps lead to a permanent corruption of a metadata extent=
:
> >
> > 1) We make device 3 unavailable and mount the filesystem in degraded
> > mode, so only
> >    devices 1 and 2 are online;
> >
> > 2) We allocate a new extent buffer with logical address of 39043072, th=
is falls
> >    within the full stripe that starts at logical address 38928384, whic=
h is
> >    composed of 3 stripes, each with a size of 64Kb:
> >
> >    [ stripe 1, offset 38928384 ] [ stripe 2, offset 38993920 ] [
> > stripe 3, offset 39059456 ]
> >    (the offsets are logical addresses)
> >
> >    stripe 1 is in device 2
> >    stripe 2 is in device 3
> >    stripe 3 is in device 1  (this is the parity stripe)
> >
> >    Our extent buffer 39043072 falls into stripe 2, starting at page
> > with index 12
> >    of that stripe and ending at page with index 15;
> >
> > 3) When writing the new extent buffer at address 39043072 we obviously
> > don't write
> >    the second stripe since device 3 is missing and we are in degraded
> > mode. We write
> >    only the stripes for devices 1 and 2, which are enough to recover
> > stripe 2 content
> >    when it's needed to read it (by XORing stripes 1 and 3, we produce
> > the correct
> >    content of stripe 2);
> >
> > 4) We unmount the filesystem;
> >
> > 5) We make device 3 available and then mount the filesystem in
> > non-degraded mode;
> >
> > 6) Due to some write operation (such as relocation like btrfs/125
> > does), we allocate
> >    a new extent buffer at logical address 38993920. This belongs to
> > the same full
> >    stripe as the extent buffer we allocated before in degraded mode (39=
043072),
> >    and it's mapped to stripe 2 of that full stripe as well,
> > corresponding to page
> >    indexes from 0 to 3 of that stripe;
> >
> > 7) When we do the actual write of this stripe, because it's a partial
> > stripe write
> >    (we aren't writing to all the pages of all the stripes of the full
> > stripe), we
> >    need to read the remaining pages of stripe 2 (page indexes from 4 to=
 15) and
> >    all the pages of stripe 1 from disk in order to compute the content =
for the
> >    parity stripe. So we submit bios to read those pages from the corres=
ponding
> >    devices (we do this at raid56.c:raid56_rmw_stripe()). The problem is=
 that we
> >    assume whatever we read from the devices is valid - in this case wha=
t we read
> >    from device 3, to which stripe 2 is mapped, is invalid since in the =
degraded
> >    mount we haven't written extent buffer 39043072 to it - so we get
> > garbage from
> >    that device (either a stale extent, a bunch of zeroes due to trim/di=
scard or
> >    anything completely random). Then we compute the content for the
> > parity stripe
> >    based on that invalid content we read from device 3 and write the
> > parity stripe
> >    (and the other two stripes) to disk;
> >
> > 8) We later try to read extent buffer 39043072 (the one we allocated wh=
ile in
> >    degraded mode), but what we get from device 3 is invalid (this exten=
t buffer
> >    belongs to a stripe of device 3, remember step 2), so
> > btree_read_extent_buffer_pages()
> >    triggers a recovery attempt - this happens through:
> >
> >    btree_read_extent_buffer_pages() -> read_extent_buffer_pages() ->
> >      -> submit_one_bio() -> btree_submit_bio_hook() -> btrfs_map_bio() =
->
> >        -> raid56_parity_recover()
> >
> >    This attempts to rebuild stripe 2 based on stripe 1 and stripe 3 (th=
e parity
> >    stripe) by XORing the content of these last two. However the parity
> > stripe was
> >    recomputed at step 7 using invalid content from device 3 for stripe =
2, so the
> >    rebuilt stripe 2 still has invalid content for the extent buffer 390=
43072.
> >
> > This results in the impossibility to recover an extent buffer and
> > getting permanent
> > metadata corruption. If the read of the extent buffer 39043072
> > happened before the
> > write of extent buffer 38993920, we would have been able to recover it =
since the
> > parity stripe reflected correct content, it matched what was written in=
 degraded
> > mode at steps 2 and 3.
> >
> > The same type of issue happens for data extents as well.
> >
> > Since the stripe size is currently fixed at 64Kb, the issue doesn't hap=
pen only
> > if the node size and sector size are 64Kb (systems with a 64Kb page siz=
e).
> >
> > And we don't need to do writes in degraded mode and then mount in non-d=
egraded
> > mode with the previously missing device for this to happen (I gave the =
example
> > of degraded mode because that's what btrfs/125 exercises).
>
> This also means, other raid5/6 implementations are also affected by the
> same problem, right?

If so, that makes them less useful as well.
For all the other raid modes we support, which use mirrors, we don't
have this problem. If one copy is corrupt, we are able to recover it,
period.

>
> >
> > Any scenario where the on disk content for an extent changed (some bit =
flips for
> > example) can result in a permanently unrecoverable metadata or data ext=
ent if we
> > have the bad luck of having a partial stripe write happen before an att=
empt to
> > read and recover a corrupt extent in the same stripe.
> >
> > Zygo had a report some months ago where he experienced this as well:
> >
> > https://lore.kernel.org/linux-btrfs/20191119040827.GC22121@hungrycats.o=
rg/
> >
> > Haven't tried his script to reproduce, but it's very likely it's due to=
 this
> > issue caused by partial stripe writes before reads and recovery attempt=
s.
> >
> > This is a problem that has been around since raid5/6 support was added,=
 and it
> > seems to me it's something that was not thought about in the initial de=
sign.
> >
> > The validation/check of an extent (both metadata and data) happens at a=
 higher
> > layer than the raid5/6 layer, and it's the higher layer that orders the=
 lower
> > layer (raid56.{c,h}) to attempt recover/repair after it reads an extent=
 that
> > fails validation.
> >
> > I'm not seeing a reasonable way to fix this at the moment, initial thou=
ghts all
> > imply:
> >
> > 1) Attempts to validate all extents of a stripe before doing a partial =
write,
> > which not only would be a performance killer and terribly complex, ut w=
ould
> > also be very messy to organize this in respect to proper layering of
> > responsabilities;
>
> Yes, this means raid56 layer will rely on extent tree to do
> verification, and too complex.
>
> Not really worthy to me too.
>
> >
> > 2) Maybe changing the allocator to work in a special way for raid5/6 su=
ch that
> > it never allocates an extent from a stripe that already has extents tha=
t were
> > allocated by past transactions. However data extent allocation is curre=
ntly
> > done without holding a transaction open (and forgood reasons) during
> > writeback. Would need more thought to see how viable it is, but not tri=
vial
> > either.
> >
> > Any thoughts? Perhaps someone else was already aware of this problem an=
d
> > had thought about this before. Josef?
>
> What about using sector size as device stripe size?

Unfortunately that wouldn't work as well.

Say you have stripe 1 with a corrupt metadata extent. Then you do a
write to a metadata extent located at stripe 2 - this partial write
(because it doesn't cover all stripes of the full stripe), will read
the pages from the first stripe and assume they are all good, and then
use those for computing the parity stripe - based on a corrupt extent
as well. Same problem I described, but this time the corrupt extent is
in a different stripe of the same full stripe.

Thanks.

>
> It would make metadata scrubbing suffer, and would cause performance
> problems I guess, but it looks a little more feasible.
>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
