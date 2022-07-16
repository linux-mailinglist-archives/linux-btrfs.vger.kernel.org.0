Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD23576E54
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 15:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGPNwY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 09:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPNwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 09:52:23 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5E1CFC4
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 06:52:22 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31cf1adbf92so70225657b3.4
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qmMH4PQDi+kzTvc97dt9KU+xITNu6SlWITZOCH4Qco=;
        b=GFhNeW33hzqtCJvtJ2cBjZwhGClSwD8eoTLoBwqcaIzl3wa8kd0MHYr576Tdxj2/r/
         GsfScPmNWGSHUFAD3gzKz49fk38NtTuYa1Xc8quNn2OkCvlaZYkiVtp653/yLVkr1fV2
         i8dJOhJ6grAfO3I7hzfPWDgLAPP9Geq/yGGqMRLWJ09qvGDSDVsa6kgKYFagMahniduY
         9GNcEkAmGl/vs/Fim3TEXoaXUm8N1FQDjY0UdmzGPReKqPc/XRzMOvtN0vlLNNowiDZN
         W2dUQkF1LrcRKublR0ihrB9y08/yY1haZo317WKtXuO4OknWdPsB3KGz5CslSfvhRVVI
         zPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qmMH4PQDi+kzTvc97dt9KU+xITNu6SlWITZOCH4Qco=;
        b=bfeuyIaE4cGjsM4mcK3oWpZQOu3nCucxCLJomw/o1E6pMJqi6bS4o4HMA4H+qxI+SS
         RThteVZZ/42z20wHKmmGw9Cao+CbGc1dTHz8V+RaKxR9FRGw65FWSeFlXzpE5BIC+o/Z
         q1yTeHA0ykLjaKQ8HKM8VVjDp4qOCZ2hYGyA26TS65e6yY7HOZALxZvQUSgca/845UGq
         0seMa22ptWfx+SI974E+AoToCf51TFld883RH8my9FqU6R1piVr3ujRgNbbb/aLOaFvm
         oFoYwMtSXr5eQL0CIQJyd+7qgp8XzQrJdkFcR8YYu3QGcgDh6uU7qKb2HyG/6+ClWmTp
         VWjA==
X-Gm-Message-State: AJIora+av0qAgQ/ZnRUA3xbSXHEOFSzKYEgjGcADV4axG7knxHs9vdD7
        1CRpzu0NPwegncysv/w9kdAVV3pPf6w2lEQHYhWZ8BpiNP8=
X-Google-Smtp-Source: AGRyM1ulrOU4QgUaIuEdN4Z2FUQ3UBFXAGPOOqdbUD8fQhKj4JwvylxTblrM9E4JHiB3PxI4YL/y0/p7nmI8NVFGWL4=
X-Received: by 2002:a81:a24b:0:b0:31c:95d5:1725 with SMTP id
 z11-20020a81a24b000000b0031c95d51725mr21230706ywg.403.1657979541611; Sat, 16
 Jul 2022 06:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com> <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com> <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com> <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com> <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com> <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it> <CAO1Y9woJUhuQ+Q2yWSvscnBJb9D5cYiBaY-WG3Re=7V=OzWVhw@mail.gmail.com>
 <1dcfecba-92fc-6f49-bdea-705896ece036@gmx.com> <928e46e3-51d2-4d7a-583a-5440f415671e@gmx.com>
In-Reply-To: <928e46e3-51d2-4d7a-583a-5440f415671e@gmx.com>
From:   Thiago Ramon <thiagoramon@gmail.com>
Date:   Sat, 16 Jul 2022 10:52:10 -0300
Message-ID: <CAO1Y9woENiZOokwqSeSbmr30w7ksw+ZkXUR9pU68Kmfm8X+K=g@mail.gmail.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     kreijack@inwind.it,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 16, 2022 at 8:12 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/7/16 08:34, Qu Wenruo wrote:
> >
> >
> > On 2022/7/16 03:08, Thiago Ramon wrote:
> >> As a user of RAID6 here, let me jump in because I think this
> >> suggestion is actually a very good compromise.
> >>
> >> With stripes written only once, we completely eliminate any possible
> >> write-hole, and even without any changes on the current disk layout
> >> and allocation,
> >
> > Unfortunately current extent allocator won't understand the requirement
> > at all.
> >
> > Currently the extent allocator although tends to use clustered free
> > space, when it can not find a clustered space, it goes where it can find
> > a free space. No matter if it's a substripe write.
> >
> >
> > Thus to full stripe only write, it's really the old idea about a new
> > extent allocator to avoid sub-stripe writes.
> >
> > Nowadays with the zoned code, I guess it is now more feasible than
> > previous.
> >
> > Now I think it's time to revive the extent allcator idea, and explore
> > the extent allocator based idea, at least it requires no on-disk format
> > change, which even write-intent still needs a on-disk format change (at
> > least needs a compat ro flag)
>
> After more consideration, I am still not confident of above extent
> allocator avoid sub-stripe write.
>
> Especially for the following ENOSPC case (I'll later try submit it as an
> future proof test case for fstests).
>
> ---
>    mkfs.btrfs -f -m raid1c3 -d raid5 $dev1 $dev2 $dev3
>    mount $dev1 $mnt
>    for (( i=0;; i+=2 )) do
>         xfs_io -f -c "pwrite 0 64k" $mnt/file.$i &> /dev/null
>         if [ $? -ne 0 ]; then
>                 break
>         fi
>         xfs_io -f -c "pwrite 0 64k" $mnt/file.$(($i + 1)) &> /dev/null
>         if [ $? -ne 0 ]; then
>                 break
>         fi
>         sync
>    done
>    rm -rf -- $mnt/file.*[02468]
>    sync
>    xfs_io -f -c "pwrite 0 4m" $mnt/new_file
> ---
>
> The core idea of above script it, fill the fs using 64K extents.
> Then delete half of them interleavely.
>
> This will make all the full stripes to have one data stripe fully
> utilize, one free, and all parity utilized.
>
> If you go extent allocator that avoid sub-stripe write, then the last
> write will fail.
>
> If you RST with regular devices and COWing P/Q, then the last write will
> also fail.
>
> To me, I don't care about performance or latency, but at least, what we
> can do before, but now if a new proposed RAID56 can not do, then to me
> it's a regression.
>
> I'm not against RST, but for RST on regular devices, we still need GC
> and reserved block groups to avoid above problems.
>
> And that's why I still prefer write-intent, it brings no possible
> regression.
While the test does fail as-is, rebalancing will recover all the
wasted space. It's a new gotcha for RAID56, but I think it's still
preferable than the write-hole, and is proper CoW.
Narrowing the stripes to 4k would waste a lot less space overall, but
there's probably code around that depends on the current 64k-tall
stripes.

>
> >
> >> there shouldn't be much wasted space (in my case, I
> >> have a 12-disk RAID6, so each full stripe holds 640kb, and discounting
> >> single-sector writes that should go into metadata space, any
> >> reasonable write should fill that buffer in a few seconds).
>
> Nope, the problem is not that simple.
>
> Consider this, you have an application doing an 64K write DIO.
>
> Then with allocator prohibiting sub-stripe write, it will take a full
> 640K stripe, wasting 90% of your space.
>
>
> Furthermore, even if you have some buffered write, merged into an 640KiB
> full stripe, but later 9 * 64K of data extents in that full stripe get
> freed.
> Then you can not use that 9 * 64K space anyway.
>
> That's why zoned device has GC and reserved zones.
>
> If we go allocator way, then we also need a non-zoned GC and reserved
> block groups.
>
> Good luck implementing that feature just for RAID56 on non-zoned devices.
DIO definitely would be a problem this way. As you mention, a separate
zone for high;y modified data would make things a lot easier (maybe a
RAID1Cx zone), but that definitely would be a huge change on the way
things are handled.
Another, easier solution would be disabling DIO altogether for RAID56,
and I'd prefer that if that's the cost of having RAID56 finally
respecting CoW and stopping modifying data shared with other files.
But as you say, it's definitely a regression if we change things this
way, and we'd need to hear from other people using RAID56 what they'd
prefer.

>
> Thanks,
> Qu
>
> >>
> >> The additional suggestion of using smaller stripe widths in case there
> >> isn't enough data to fill a whole stripe would make it very easy to
> >> reclaim the wasted space by rebalancing with a stripe count filter,
> >> which can be easily automated and run very frequently.
> >>
> >> On-disk format also wouldn't change and be fully usable by older
> >> kernels, and it should "only" require changes on the allocator to
> >> implement.
> >>
> >> On Fri, Jul 15, 2022 at 2:58 PM Goffredo Baroncelli
> >> <kreijack@libero.it> wrote:
> >>>
> >>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
> >>>> On 14.07.22 09:32, Qu Wenruo wrote:
> >>>>> [...]
> >>>>
> >>>> Again if you're doing sub-stripe size writes, you're asking stupid
> >>>> things and
> >>>> then there's no reason to not give the user stupid answers.
> >>>>
> >>>
> >>> Qu is right, if we consider only full stripe write the "raid hole"
> >>> problem
> >>> disappear, because if a "full stripe" is not fully written it is not
> >>> referenced either.
> >>>
> >>>
> >>> Personally I think that the ZFS variable stripe size, may be interesting
> >>> to evaluate. Moreover, because the BTRFS disk format is quite flexible,
> >>> we can store different BG with different number of disks. Let me to
> >>> make an
> >>> example: if we have 10 disks, we could allocate:
> >>> 1 BG RAID1
> >>> 1 BG RAID5, spread over 4 disks only
> >>> 1 BG RAID5, spread over 8 disks only
> >>> 1 BG RAID5, spread over 10 disks
> >>>
> >>> So if we have short writes, we could put the extents in the RAID1 BG;
> >>> for longer
> >>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by
> >>> length
> >>> of the data.
> >>>
> >>> Yes this would require a sort of garbage collector to move the data
> >>> to the biggest
> >>> raid5 BG, but this would avoid (or reduce) the fragmentation which
> >>> affect the
> >>> variable stripe size.
> >>>
> >>> Doing so we don't need any disk format change and it would be
> >>> backward compatible.
> >>>
> >>>
> >>> Moreover, if we could put the smaller BG in the faster disks, we
> >>> could have a
> >>> decent tiering....
> >>>
> >>>
> >>>> If a user is concerned about the write or space amplicfication of
> >>>> sub-stripe
> >>>> writes on RAID56 he/she really needs to rethink the architecture.
> >>>>
> >>>>
> >>>>
> >>>> [1]
> >>>> S. K. Mishra and P. Mohapatra,
> >>>> "Performance study of RAID-5 disk arrays with data and parity cache,"
> >>>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel
> >>>> Processing,
> >>>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
> >>>
> >>> --
> >>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> >>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> >>>
