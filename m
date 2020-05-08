Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3F1CA1FF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 06:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgEHEYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 00:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgEHEYL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 00:24:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BEC05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 21:24:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so211700ljj.11
        for <linux-btrfs@vger.kernel.org>; Thu, 07 May 2020 21:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LoUmgEtZJdrjoNLyJFa8h6audUjbv7ZdWTuulKb5sxs=;
        b=Slpl9GZEYg9wWmxefU3UvVCBvzp3Epcht+b1tZW1d0+/oB+SuN3f8WNaGQsXazQklT
         Sci53hZs9ILfh1nrs8xQKglyD2Ijwrvb6EtrQ5C27KpXX9ET1jyfFqtnFdT9IZS0MbJw
         XEfuhhGNwhCfOXgkuJV9Ac/KedgHWEx9jvivw54UL1K3f1CMi99C7yTXaPZW1SeqEjo9
         hN8vQZzbVQb5ConL7re+HzgrMPri4Pj0mA4vtOSUJdU1WkHgQJmMqkCkKImCiBe71KwV
         cGULlvCiM8eGU0A89vQvBOfM4sl62Yv1C/cnv0SCOWlLyFahup7W833+ctOaj/eqSDy+
         oXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LoUmgEtZJdrjoNLyJFa8h6audUjbv7ZdWTuulKb5sxs=;
        b=kyv4uM9bDLU+kRdDCinl8pKOsltFREpVkFbOXiolzKkV/enKE4zTnU5Y4cpAljZUNr
         dcW7GpeYQl9LKNA9MMm1/vgn7lPQsKCPxF93hnt3Ple0hXRdYYRYo8mSrCkp5POn/6BG
         g5JPcIsRNu2sh0n/HE9QUng7PHcnh4tyEXgRwS734bEDtvC+FZ7FFUAMGJJjGsgheneu
         9m09fR1ALJP+SNpzov+EVpVvrMZLJOBeiPw6FcT3pYJTyi0N8fmcao2OiaIY4rFRHZ9k
         Src7uHLKeVZupOUya5gVYVjQKfRP1BZqyZ7vhY+DT3Xrt3FCLvmuN5WjKGcl5GexKdaf
         MCdQ==
X-Gm-Message-State: AOAM533TdRIupdUX1jQy2SU1VUArxWemd2/mIQ5yRaEoifDU3IFGVnFi
        l0or7WUYPSm+L88qyVSZ1qp2lYWfAiF42FUKV6FXDQ/E
X-Google-Smtp-Source: ABdhPJwEW5ic+6772qCfByTa1Fwzv7Sj1QomSUh8gyvXMV+jvTR5PlwTuz7TfbRPKgltqJx4JBDyD45zoTW4wsiNGxo=
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr349701ljp.186.1588911848365;
 Thu, 07 May 2020 21:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com>
 <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com> <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
 <CAJheHN18TmG7g=-Sgi36hVmWka4z99rQRfaf=3FCRvat07C8pg@mail.gmail.com>
 <bbd08948-6672-4fb1-0e84-802482da7228@gmx.com> <CAJheHN3qgr+FNq+N3DiAQaPkbdcmV+1O8TetAX_HLU5V304Phw@mail.gmail.com>
 <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com>
In-Reply-To: <155abe60-8970-c345-5f28-b4c2713d0c1e@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Fri, 8 May 2020 00:23:56 -0400
Message-ID: <CAJheHN0EOPu9CuTT2hg=5HZskaC-yB2V5LSwNkrhP4XYYyv5+A@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Something went wrong:

Reinitialize checksum tree
Unable to find block group for 0
Unable to find block group for 0
Unable to find block group for 0
ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
btrfs(+0x6dd94)[0x55a933af7d94]
btrfs(+0x71b94)[0x55a933afbb94]
btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
btrfs(+0x360b2)[0x55a933ac00b2]
btrfs(+0x46a3e)[0x55a933ad0a3e]
btrfs(main+0x98)[0x55a933a9fe88]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed550b3]
btrfs(_start+0x2e)[0x55a933a9fa0e]
Aborted

I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
available. I'll let that try overnight?

On Thu, May 7, 2020 at 8:11 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/5/7 =E4=B8=8B=E5=8D=8811:52, Tyler Richmond wrote:
> > Thank you for helping. The end result of the scan was:
> >
> >
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
>
> Good news is, your fs is still mostly fine.
>
> > [5/7] checking only csums items (without verifying data)
> > there are no extents for csum range 0-69632
> > csum exists for 0-69632 but there is no extent record
> > ...
> > ...
> > there are no extents for csum range 946692096-946827264
> > csum exists for 946692096-946827264 but there is no extent record
> > there are no extents for csum range 946831360-947912704
> > csum exists for 946831360-947912704 but there is no extent record
> > ERROR: errors found in csum tree
>
> Only extent tree is corrupted.
>
> Normally btrfs check --init-csum-tree should be able to handle it.
>
> But still, please be sure you're using the latest btrfs-progs to fix it.
>
> Thanks,
> Qu
>
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 44157956026368 bytes used, error(s) found
> > total csum bytes: 42038602716
> > total tree bytes: 49688616960
> > total fs tree bytes: 1256427520
> > total extent tree bytes: 1709105152
> > btree space waste bytes: 3172727316
> > file data blocks allocated: 261625653436416
> >  referenced 47477768499200
> >
> > What do I need to do to fix all of this?
> >
> > On Thu, May 7, 2020 at 1:52 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2020/5/7 =E4=B8=8B=E5=8D=881:43, Tyler Richmond wrote:
> >>> Well, the repair doesn't look terribly successful.
> >>>
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>
> >> This means there are more problems, not only the hash name mismatch.
> >>
> >> This means the fs is already corrupted, the name hash is just one
> >> unrelated symptom.
> >>
> >> The only good news is, btrfs-progs abort the transaction, thus no
> >> further damage to the fs.
> >>
> >> Please run a plain btrfs-check to show what's the problem first.
> >>
> >> Thanks,
> >> Qu
> >>
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> parent transid verify failed on 218620880703488 wanted 6875841 found =
6876224
> >>> Ignoring transid failure
> >>> ERROR: child eb corrupted: parent bytenr=3D225049956061184 item=3D84
> >>> parent level=3D1
> >>>                                             child level=3D4
> >>> ERROR: failed to zero log tree: -17
> >>> ERROR: attempt to start transaction over already running one
> >>> WARNING: reserved space leaked, flag=3D0x4 bytes_reserved=3D4096
> >>> extent buffer leak: start 225049066086400 len 4096
> >>> extent buffer leak: start 225049066086400 len 4096
> >>> WARNING: dirty eb leak (aborted trans): start 225049066086400 len 409=
6
> >>> extent buffer leak: start 225049066094592 len 4096
> >>> extent buffer leak: start 225049066094592 len 4096
> >>> WARNING: dirty eb leak (aborted trans): start 225049066094592 len 409=
6
> >>> extent buffer leak: start 225049066102784 len 4096
> >>> extent buffer leak: start 225049066102784 len 4096
> >>> WARNING: dirty eb leak (aborted trans): start 225049066102784 len 409=
6
> >>> extent buffer leak: start 225049066131456 len 4096
> >>> extent buffer leak: start 225049066131456 len 4096
> >>> WARNING: dirty eb leak (aborted trans): start 225049066131456 len 409=
6
> >>>
> >>> What is going on?
> >>>
> >>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond <t.d.richmond@gmail.com=
> wrote:
> >>>>
> >>>> Chris, I had used the correct mountpoint in the command. I just edit=
ed
> >>>> it in the email to be /mountpoint for consistency.
> >>>>
> >>>> Qu, I'll try the repair. Fingers crossed!
> >>>>
> >>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> I looked up this error and it basically says ask a developer to
> >>>>>> determine if it's a false error or not. I just started getting som=
e
> >>>>>> slow response times, and looked at the dmesg log to find a ton of
> >>>>>> these errors.
> >>>>>>
> >>>>>> [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
> >>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gene=
ration:
> >>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>> [192088.449823] BTRFS error (device sdh): block=3D203510940835840 =
read
> >>>>>> time tree block corruption detected
> >>>>>> [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
> >>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gene=
ration:
> >>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>> [192088.462773] BTRFS error (device sdh): block=3D203510940835840 =
read
> >>>>>> time tree block corruption detected
> >>>>>> [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D=
5
> >>>>>> block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode gene=
ration:
> >>>>>> has 18446744073709551492 expect [0, 6875827]
> >>>>>> [192088.468457] BTRFS error (device sdh): block=3D203510940835840 =
read
> >>>>>> time tree block corruption detected
> >>>>>>
> >>>>>> btrfs device stats, however, doesn't show any errors.
> >>>>>>
> >>>>>> Is there anything I should do about this, or should I just continu=
e
> >>>>>> using my array as normal?
> >>>>>
> >>>>> This is caused by older kernel underflow inode generation.
> >>>>>
> >>>>> Latest btrfs-progs can fix it, using btrfs check --repair.
> >>>>>
> >>>>> Or you can go safer, by manually locating the inode using its inode
> >>>>> number (1311670), and copy it to some new location using previous
> >>>>> working kernel, then delete the old file, copy the new one back to =
fix it.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>
> >>>>>>
> >>>>>> Thank you!
> >>>>>>
> >>>>>
> >>
>
