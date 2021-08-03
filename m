Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37B83DF511
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Aug 2021 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbhHCSzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Aug 2021 14:55:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:54333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238385AbhHCSzZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Aug 2021 14:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628016907;
        bh=oEecvV0oeHw/fM4TUI0N66b2DGAZm6lMNIVUa70X0Qs=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=XhV/wTEtlbO9EmIeCinLvSaYRy8I4DmAVNNQxQzblkh2XA5WDmu9tp+CsuWzRwL0l
         OKGeOZeY+jZW7pe7KZJ7zC/nLgDbgeO2qyUD7aStF9R4Pyp/jBasQxoiEd2Hm7eEAe
         nXQ3kE2jOgETb6l4pIO+1Ph8HHPZY55gcb5apIJg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [77.11.47.8] ([77.11.47.8]) by web-mail.gmx.net
 (3c-app-gmx-bap48.server.lan [172.19.172.118]) (via HTTP); Tue, 3 Aug 2021
 20:55:07 +0200
MIME-Version: 1.0
Message-ID: <trinity-7b251a66-4376-4938-91f7-9fae2a72c5ef-1628016907507@3c-app-gmx-bap48>
From:   telsch <telsch@gmx.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
Subject: Aw: Re: Random csum errors
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 3 Aug 2021 20:55:07 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210802233850.GO10170@hungrycats.org>
References: <trinity-59843172-879e-4efd-9b35-bbfed0ed52c6-1627914043406@3c-app-gmx-bap64>
 <20210802233850.GO10170@hungrycats.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/4Y7UM9tuLH/MYgXC/gQ0nZxIV4fV7mq8JvjIxabDXju6jWbh6RIxPDhhFqOIwshIn2VX
 UotMixde807hDiNJ7BU9iKFb2JSLn49T0abfzy8imd/9bKG+Jsa76qn1jOvbPWNkEbPZB2KUIxK6
 EyiccABpY05o7jHlYWAecbBAO4BZwQoULLdrmUKHV2X0tbuZYQy9+uFG5KklhHZIYAih4O07iLVQ
 gbQAzp2G/5FLS0YjNNoRBY/6D6LbG54JKjmPUYDKS8zxE13mpH2K74mktXeiWqtBo++aVTbkHfYP
 G4=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eGKhAwmnIE0=:NhttRT74Yk3wV9q8td2akY
 ObPdSODeUOcOijdSTy/p1aQMKT0FluFp+JLFvnYCJhQmhyu6Adkq3Sq7sYwT2M6sFGL/Ir7fg
 4NER5TeDL6axaiq7zBghTyx9yI4C72t/ObpgyRO35cnNYZXMczaWxmxZocw3/uA9KE8jaT0i2
 C2pKbC61PoIGt16mdjTKjMgQWqqvkZFVqU3O3h4p90WGlKwL1cAFx8tBLLVmy2iUdU8h+0EB/
 /xuwjfCUdzdu2+ARVAzNFvpSRm9lG8sMOaUfe8S+o+2tGSnIceWEf4MwOWEyBzi4n0VcWjtww
 krcoNgZyL/Fq+YfGwDxbiRpcpb131JkUsdMaGjeDrXuWC+HWqc8yGuATbdVHSRMTlnAz55jKE
 S2FoZhpfQiyKG/y3K/fLO8VnfG/9WrgRADhEYaoP1MLyMJI7OUKItyIj+OwnI6VkrJbUfJLHA
 wiuiF1wrxlcovnD+R0PJo+Q/duUeycVCl13g5tDuyOetJjO5ySqZ5vYtMJCt3Tlw2xr8C5rq2
 NYETHDQaDzYLW/f7o2/PCavq49n/ETlkozHxyIVcn0SvyA8Ul58+2LZUYZ96lh9gz+JcvJtJ4
 sLXlp6AXjFt2/VT/5ovh4Lacb71fWPqaR5g6zui6iX9TTSgMQQZ9fgIVQsYDDced5Y0UTK7qI
 QwiypyKcnn6Pi4k4WqC500ItgNAeH2V8NikdDmpDVFbM+DqR8MEUzTyyGHkAQj6f7We3BUFlZ
 j/OhjctursXkkz1rqudQAV6jbGDt0yNBq0Vy0TaMgJ5rmMTEll+SNXg+xLT8ByoxPY9zoInfd
 5uQTLAspmbVdDkTmNilzAEYVVyhBA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> On Mon, Aug 02, 2021 at 04:20:43PM +0200, telsch wrote:
> > Dear devs,
> >
> > since 26.07. scrub keeps reporting csum errors with random files.
> > I replaced these files from backups. Then deleted the snapshots that s=
till contained the
> > the corrupt files. Snapshot with corrupt files I have determined with =
md5sum, here I get an input/output error.
> > Following new scrub, still finds new csum errors that did not exist be=
fore.
> >
> > Beginning with Kernel 5.10.52, current 5.10.55
> > btrfs-progs 5.13
> >
> > Disk layout with problems:
> >
> > mdadm raid10 4xhdd =3D> bcache =3D> luks
> > mdadm raid6  4xhdd =3D> bcache =3D> luks
>
> Missing information:  what are the model/firmware revision of the
> devices, is the bcache in writeback or writethrough mode, how many
> SSDs are there, is there a separate bcache SSD for each HDD or are
> multiple HDDs sharing any bcache SSDs?

1 SanDisk SDSSDA120G/Firmware Version: Z22000RL
I'm using only one SSD in writearound mode for both arrays.

>
> Based on the symptoms, the most likely case is there's one SSD or a
> mdadm-mirrored pair of SSDs for bcache, and at least one SSD is failing.
> It may be a SSD that is not rated for caching use cases, or a SSD with
> firmware bugs that prevent reliable error reporting.  It's also possible
> one or more HDDs is silently corrupting data, but that is less common
> in the wild.
>
> The writeback/writethrough question informs us how recoverable the
> damage is.  Damage in writethrough mode is recoverable in some cases
> by simply removing the cache and mounting the backing drives directly.
> In writeback mode the data is already gone, and if the SSD fails before
> the bcache can be fully flushed, the filesystem will be destroyed.
>
> > Already replaced 2 old hdds with high Raw_Read_Error_Rate values.
>
> 1.  Replace all SSDs in the system, or cleanly remove the SSD devices
> from the bcache.  Silent corruption is a common early failure mode on
> SSDs, and bcache doesn't use checksums to detect it.  If you continue
> to use bcache in writeback mode with a bad SSD, it will corrupt more
> and more data until the SSD finally dies, and the filesystem will be
> unrecoverable after that.  If you're using bcache in writethrough mode,
> the corruption will only be affecting reads, and you can simply remove
> and discard the SSD without damaging the filesystem (it might even fix
> previously uncorrectable data if the copy on the backing HDDs is intact)=
.

Thanks for your explanations!
Since I am in writearound mode and the files that are corrupted were not
rewritten, I had not thought about a failing SSD and corrupted bcache read=
s.

As last step I detached the caching device, and the previous input/output
errors disapperd :) So you was right, the SSD looks faulty. Many thanks fo=
r
your help!

>
> 2.  If that doesn't solve the problem, run mdadm checkarray and look at
> /sys/block/md*/md/mismatch_cnt afterwards.  checkarray doesn't report
> non-zero mismatch_cnt, so you'll need to check for it separately.
> If the mismatch_cnt is non-zero, you'll have to figure out which
> drive is at fault somehow.  Neither mdadm nor SMART will tell you if
> one drive's cache RAM goes bad in an array:  mdadm doesn't know which
> drive is correct when they have different contents, and generally SMART
> cannot detect failures inside the disk's firmware runtime environment
> that might affect data integrity like cache DRAM failure.  You might
> be able to identify the bad drive by manually inspecting blocks with
> different data, but there's no automated way to do this.

It seems Arch Linux does not provide the checkarray script, so i run the
check manually - mismatch_cnt is still zero after.

>
> 3.  To avoid future problems, break the mdadm arrays into separate
> devices and put them all in a btrfs raid1 so in future btrfs can tell yo=
u
> immediately which device is corrupting your data.  (raid1 here to avoid
> issues with striped access through a SSD cache).  This might be tricky
> to achieve before the bad device is identified, because the bad device
> will keep injecting corrupted data that will abort btrfs resize/device
> delete operations.

On new systems i have already used btrfs raid1 instead of mdadm.

>
> > Aug 02 15:43:18 server kernel: BTRFS info (device dm-0): scrub: starte=
d on devid 1
> > Aug 02 15:46:06 server kernel: BTRFS warning (device dm-0): checksum e=
rror at logical 462380818432 on dev /dev/mapper/root, physical 31640150016=
, root 29539, inode 27412268, offset 131072, length 4096, links 1 (path: d=
ocker-volumes/mayan-edms/media/document_cache/804391c5-e3fe-4941-96dc-ecc0=
a1d5d8c9-23-1815-92bcac02c4a72586e21044c0b244b052f5747c7d2c25e6086ca89ca64=
098e3f3)
> > Aug 02 15:46:06 server kernel: BTRFS error (device dm-0): bdev /dev/ma=
pper/root errs: wr 0, rd 0, flush 0, corrupt 414, gen 0
> > Aug 02 15:46:06 server kernel: BTRFS error (device dm-0): unable to fi=
xup (regular) error at logical 462380818432 on dev /dev/mapper/root
> > Aug 02 15:47:25 server kernel: BTRFS info (device dm-0): scrub: finish=
ed on devid 1 with status: 0
>
