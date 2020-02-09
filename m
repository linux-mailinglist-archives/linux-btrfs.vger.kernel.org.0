Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9589715685A
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Feb 2020 02:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBIBtf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 8 Feb 2020 20:49:35 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42713 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBIBtf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 8 Feb 2020 20:49:35 -0500
Received: by mail-vs1-f68.google.com with SMTP id b79so1977834vsd.9
        for <linux-btrfs@vger.kernel.org>; Sat, 08 Feb 2020 17:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7v7BH+eGW75XtzFthZmX2gA/eOT9DzGpa2IKNhuYF8=;
        b=IbKUaVeiccRNBv4BhNvySJyUvKf+vPIGYfoaRkbqA3Chd6j78ELrrZpq/9gC2oejTB
         d87qnGuYEQfiugcBUBzEC7WiJ40ZOtSjkxI9ozRgfxBD3DYpwwNP03MG61BBHn9237K0
         pWVBfO0+b/70ulKJbe0pyhwGISLLv4RspzxigtPgxnOL7m2GSfDYFj8jyrZQkXSPDdlO
         Gl800XZ3y/vuMeoRiPFcXAxMUdrRPwugdjM3Lxkqt5Qko2KMDguIW5jvttsCp3vPsMyv
         2SeOab6hD9NlC7ezYnwdiwj7J1/AdlFszGu7DnT88tchlePF6YCD0Xr8HH9aDV+4+wUm
         cPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7v7BH+eGW75XtzFthZmX2gA/eOT9DzGpa2IKNhuYF8=;
        b=iq1vb+1BmDqpX/IJqx6H0UjNHcVJHrXUz+P370X7miZ+iyo7LCgO2W4H5WLc9BW7wn
         pvHnjndkDYJFouB792vLNG/X8FkUAjyvSfhLLwfrJ9OrZynzNazK6hXmrBdPO2saYHn7
         kzrZWSxhQiwFyQDbGjRrmeNp5q7xrtF+Gd98xPoulxkNul8ZAVe/wtYqYWsO4w6dvqBP
         +YxJYWR6Gy7WRL/+q7dHB7QmN6vb2DhrL6I2pxQH5FCMjS6a/4aEEuOPVOUN9VgvdaLp
         dvHoy95kEGkV6TODgT6PFS5BY3nVF+g9c5WwYwNxmdot1bsYOAo7pj5XXeGOiu6pPbFz
         LRtg==
X-Gm-Message-State: APjAAAUTLIp7y5lgHFZpE0Z1KEDGwqeRWRItcm/c28k6Pb0zCR61zGNV
        e+Utx5auG8i7mJ0I9HJwC2QdXMuI25d67m+Il6o=
X-Google-Smtp-Source: APXvYqziudKcVV+FwYKxVNbySHbOKNTNZTCgEvuXTnZMCLVBKKmYiM/FvqnPoDqai3/FWoZfrlqv0I/BbGcKh8dcLyk=
X-Received: by 2002:a67:f755:: with SMTP id w21mr2975130vso.107.1581212973433;
 Sat, 08 Feb 2020 17:49:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+M2ft9zjGm7XJw1BUm364AMqGSd3a8QgsvQDCWz317qjP=o8g@mail.gmail.com>
 <CA+M2ft9ANwKT1+ENS6-w9HLtdx0MDOiVhi5RWKLucaT_WtZLkg@mail.gmail.com>
 <40b47145-f965-ec5f-2caf-68434c4fbc62@gmx.com> <CA+M2ft8zMv8nhs6VzZWnzgcP2nRasrwxLzjKgaZPnm_prtWQow@mail.gmail.com>
 <3e5f4de7-fec1-f8cd-c8b1-20b5a3f38f60@gmx.com> <CA+M2ft_6_1pkP75G79qj4dLxOjJr0bOGtATaGPTVQGn25sAo+A@mail.gmail.com>
 <CA+M2ft9dcMKKQstZVcGQ=9MREbfhPF5GG=xoMoh5Aq8MK9P8wA@mail.gmail.com>
 <75f86be2-80fe-26c1-235f-1c6d3a618eeb@gmx.com> <CA+M2ft9PjH29SY+nBqfFEapr9g7BjjMFeE_p2P0oL1q8xHGUBw@mail.gmail.com>
 <CA+M2ft9AnivVhPapsn_=bEoU5Ujw9PFo9Lbcjr5nzStdq84awg@mail.gmail.com>
 <711cfe11-be8e-566d-5fbe-55a9434fb5f5@gmx.com> <CA+M2ft-9sUpyru6yH3f=NrKnRWFph2Eg58PmU_xhCBqJCRQKCg@mail.gmail.com>
 <c3d3757e-9c63-1d5b-061a-3b74ec94678e@gmx.com>
In-Reply-To: <c3d3757e-9c63-1d5b-061a-3b74ec94678e@gmx.com>
From:   John Hendy <jw.hendy@gmail.com>
Date:   Sat, 8 Feb 2020 19:49:21 -0600
Message-ID: <CA+M2ft_+sDyD6PKFOyfegX18n8Vj_9_Vy181s0E9sX=aiASVxQ@mail.gmail.com>
Subject: Re: btrfs root fs started remounting ro
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 8, 2020 at 7:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/2/9 =E4=B8=8A=E5=8D=889:20, John Hendy wrote:
> > On Sat, Feb 8, 2020 at 7:09 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> On 2020/2/9 =E4=B8=8A=E5=8D=888:59, John Hendy wrote:
> >>> Also, if it's of interest, the zero-log trick was new to me. For my
> >>> original m2.sata nvme drive, I'd already run all of --init-csum-tree,
> >>> --init-extent-tree, and --repair (unsure on the order of the first
> >>> two, but --repair was definitely last) but could then not mount it. I
> >>> just ran `btrfs rescue zero-log` on it and here is the very brief
> >>> output from a btrfs check:
> >>>

[snip]

> > The output of btrfs check now on this drive:
> >
> > $ sudo btrfs check /dev/mapper/nvme
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/nvme
> > UUID: 488f733d-1dfd-4a0f-ab2f-ba690e095fe4
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > cache and super generation don't match, space cache will be invalidated
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 87799443456 bytes used, no error found
> > total csum bytes: 84696784
> > total tree bytes: 954220544
> > total fs tree bytes: 806535168
> > total extent tree bytes: 47710208
> > btree space waste bytes: 150766636
> > file data blocks allocated: 87780622336
> >  referenced 94255783936
>
> Just as it said, there is no error found by btrfs-check.

My apologies. I think we are circling around on which drive is which.

1) NVME, m2.sata, the original drive of this thread:
- had the ro issues, I reinstalled linux, then ro occurred again,
prompting this thread
- on my own, I did --init-csum-tree, --init-extent-tree, and --repair
but it then wouldn't boot
- you gave the zero-log trick for the *other* drive, which I then
applied to this one
- zero-log lets it mount again, and btrfs check --repair appeared to work
- btrfs check is now reporting no issues
- the --check-data-csum on 5.4 also looks good

2) The SSD, the drive which I started using after my nvme woes above
- in tracking down offending files by inode, I deleted some, another
is unable to be deleted, no matter what:

$ ls -la
ls: cannot access 'TransportSecurity': No such file or directory
total 0
drwx------ 1 jwhendy jwhendy 22 Feb  8 18:47 .
drwx------ 1 jwhendy jwhendy 18 Feb  7 22:22 ..
-????????? ? ?       ?        ?            ? TransportSecurity

- I have not been able to run --repair successfully due to segfault
- per your advice, I am about to try btrfs check --repair --mode=3Dlowmem o=
n it

In summary, thanks to your help I might have recovered the nvme drive,
but it's unclear to me where the SSD is at. The latest on the SSD
(copying from earlier thread for convenience):

Here is the output of btrfs check after the --repair attempt (which seg fau=
lted)
- https://pastebin.com/6MYRNdga

Here was the dmesg after I rebooted from that --repair attempt and it went =
ro:
- https://pastebin.com/a2z7xczy

The only thing that's happened since then is `btrfs rescue zero-log` on it.

John

> If you want to be extra safe, please run `btrfs check` again, using
> v5.4.1 (which adds an extra check for extent item generation).
>
> At this stage, at least v5.3 kernel should be able to mount it, and
> delete offending files.
>
> v5.4 is a little more strict on extent item generation. But if you
> delete the offending files using v5.3, everything should be fine.
>
> If you want to be abosultely safe, you can run `btrfs check
> --check-data-csum` to do a scrub-like check on data.
>
> Thanks,
> Qu
> >
> > How is that looking? I'll boot back into a usb drive to try --repair
> > --mode=3Dlowmem on the SSD. My continued worry is the spurious file I
> > can't delete. Is that something btrfs --repair will try to fix or is
> > there something else that needs to be done? It seems this inode is
> > tripping things up and I can't find a way to get rid of that file.
> >
> > John
> >
> >
> >>
> >> Thanks,
> >> Qu
> >>> ERROR: errors found in extent allocation tree or chunk allocation
> >>> [3/7] checking free space cache
> >>> [4/7] checking fs roots
> >>> [5/7] checking only csums items (without verifying data)
> >>> [6/7] checking root refs
> >>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>> found 87799443456 bytes used, error(s) found
> >>> total csum bytes: 84696784
> >>> total tree bytes: 954220544
> >>> total fs tree bytes: 806535168
> >>> total extent tree bytes: 47710208
> >>> btree space waste bytes: 150766636
> >>> file data blocks allocated: 87780622336
> >>>  referenced 94255783936
> >>>
> >>> If that looks promising... I'm hoping that the ssd we're currently
> >>> working on will follow suit! I'll await your recommendation for what
> >>> to do on the previous inquiries for the SSD, and if you have any
> >>> suggestions for the backref errors on the nvme drive above.
> >>>
> >>> Many thanks,
> >>> John
> >>>
> >>> On Sat, Feb 8, 2020 at 6:51 PM John Hendy <jw.hendy@gmail.com> wrote:
> >>>>
> >>>> On Sat, Feb 8, 2020 at 5:56 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2020/2/9 =E4=B8=8A=E5=8D=885:57, John Hendy wrote:
> >>>>>> On phone due to no OS, so apologies if this is in html mode. Indee=
d, I
> >>>>>> can't mount or boot any longer. I get the error:
> >>>>>>
> >>>>>> Error (device dm-0) in btrfs_replay_log:2228: errno=3D-22 unknown =
(Failed
> >>>>>> to recover log tree)
> >>>>>> BTRFS error (device dm-0): open_ctree failed
> >>>>>
> >>>>> That can be easily fixed by `btrfs rescue zero-log`.
> >>>>>
> >>>>
> >>>> Whew. This was most helpful and it is wonderful to be booting at
> >>>> least. I think the outstanding issues are:
> >>>> - what should I do about `btrfs check --repair seg` faulting?
> >>>> - how can I deal with this (probably related to seg fault) ghost fil=
e
> >>>> that cannot be deleted?
> >>>> - I'm not sure if you looked at the post --repair log, but there a t=
on
> >>>> of these errors that didn't used to be there:
> >>>>
> >>>> backpointer mismatch on [13037375488 20480]
> >>>> ref mismatch on [13037395968 892928] extent item 0, found 1
> >>>> data backref 13037395968 root 263 owner 4257169 offset 0 num_refs 0
> >>>> not found in extent tree
> >>>> incorrect local backref count on 13037395968 root 263 owner 4257169
> >>>> offset 0 found 1 wanted 0 back 0x5627f59cadc0
> >>>>
> >>>> Here is the latest btrfs check output after the zero-log operation.
> >>>> - https://pastebin.com/KWeUnk0y
> >>>>
> >>>> I'm hoping once that file is deleted, it's a matter of
> >>>> --init-csum-tree and perhaps I'm set? Or --init-extent-tree?
> >>>>
> >>>> Thanks,
> >>>> John
> >>>>
> >>>>> At least, btrfs check --repair didn't make things worse.
> >>>>>
> >>>>> Thanks,
> >>>>> Qu
> >>>>>>
> >>>>>> John
> >>>>>>
> >>>>>> On Sat, Feb 8, 2020, 1:56 PM John Hendy <jw.hendy@gmail.com
> >>>>>> <mailto:jw.hendy@gmail.com>> wrote:
> >>>>>>
> >>>>>>     This is not going so hot. Updates:
> >>>>>>
> >>>>>>     booted from arch install, pre repair btrfs check:
> >>>>>>     - https://pastebin.com/6vNaSdf2
> >>>>>>
> >>>>>>     btrfs check --mode=3Dlowmem as requested by Chris:
> >>>>>>     - https://pastebin.com/uSwSTVVY
> >>>>>>
> >>>>>>     Then I did btrfs check --repair, which seg faulted at the end.=
 I've
> >>>>>>     typed them off of pictures I took:
> >>>>>>
> >>>>>>     Starting repair.
> >>>>>>     Opening filesystem to check...
> >>>>>>     Checking filesystem on /dev/mapper/ssd
> >>>>>>     [1/7] checking root items
> >>>>>>     Fixed 0 roots.
> >>>>>>     [2/7] checking extents
> >>>>>>     parent transid verify failed on 20271138064 wanted 68719924810=
 found
> >>>>>>     448074
> >>>>>>     parent transid verify failed on 20271138064 wanted 68719924810=
 found
> >>>>>>     448074
> >>>>>>     Ignoring transid failure
> >>>>>>     # ... repeated the previous two lines maybe hundreds of times
> >>>>>>     # ended with this:
> >>>>>>     ref mismatch on [12797435904 268505088] extent item 1, found 4=
12
> >>>>>>     [1] 1814 segmentation fault (core dumped) btrfs check --repair
> >>>>>>     /dev/mapper/ssd
> >>>>>>
> >>>>>>     This was with btrfs-progs 5.4 (the install USB is maybe a mont=
h old).
> >>>>>>
> >>>>>>     Here is the output of btrfs check after the --repair attempt:
> >>>>>>     - https://pastebin.com/6MYRNdga
> >>>>>>
> >>>>>>     I rebooted to write this email given the seg fault, as I wante=
d to
> >>>>>>     make sure that I should still follow-up --repair with
> >>>>>>     --init-csum-tree. I had pictures of the --repair output, but F=
irefox
> >>>>>>     just wouldn't load imgur.com <http://imgur.com> for me to post=
 the
> >>>>>>     pics and was acting
> >>>>>>     really weird. In suspiciously checking dmesg, things have gone=
 ro on
> >>>>>>     me :(  Here is the dmesg from this session:
> >>>>>>     - https://pastebin.com/a2z7xczy
> >>>>>>
> >>>>>>     The gist is:
> >>>>>>
> >>>>>>     [   40.997935] BTRFS critical (device dm-0): corrupt leaf: roo=
t=3D7
> >>>>>>     block=3D172703744 slot=3D0, csum end range (12980568064) goes =
beyond the
> >>>>>>     start range (12980297728) of the next csum item
> >>>>>>     [   40.997941] BTRFS info (device dm-0): leaf 172703744 gen 45=
0983
> >>>>>>     total ptrs 34 free space 29 owner 7
> >>>>>>     [   40.997942]     item 0 key (18446744073709551606 128 129790=
60736)
> >>>>>>     itemoff 14811 itemsize 1472
> >>>>>>     [   40.997944]     item 1 key (18446744073709551606 128 129802=
97728)
> >>>>>>     itemoff 13895 itemsize 916
> >>>>>>     [   40.997945]     item 2 key (18446744073709551606 128 129812=
35712)
> >>>>>>     itemoff 13811 itemsize 84
> >>>>>>     # ... there's maybe 30 of these item n key lines in total
> >>>>>>     [   40.997984] BTRFS error (device dm-0): block=3D172703744 wr=
ite time
> >>>>>>     tree block corruption detected
> >>>>>>     [   41.016793] BTRFS: error (device dm-0) in
> >>>>>>     btrfs_commit_transaction:2332: errno=3D-5 IO failure (Error wh=
ile
> >>>>>>     writing out transaction)
> >>>>>>     [   41.016799] BTRFS info (device dm-0): forced readonly
> >>>>>>     [   41.016802] BTRFS warning (device dm-0): Skipping commit of=
 aborted
> >>>>>>     transaction.
> >>>>>>     [   41.016804] BTRFS: error (device dm-0) in cleanup_transacti=
on:1890:
> >>>>>>     errno=3D-5 IO failure
> >>>>>>     [   41.016807] BTRFS info (device dm-0): delayed_refs has NO e=
ntry
> >>>>>>     [   41.023473] BTRFS warning (device dm-0): Skipping commit of=
 aborted
> >>>>>>     transaction.
> >>>>>>     [   41.024297] BTRFS info (device dm-0): delayed_refs has NO e=
ntry
> >>>>>>     [   44.509418] systemd-journald[416]:
> >>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journ=
al:
> >>>>>>     Journal file corrupted, rotating.
> >>>>>>     [   44.509440] systemd-journald[416]: Failed to rotate
> >>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/system.journ=
al:
> >>>>>>     Read-only file system
> >>>>>>     [   44.509450] systemd-journald[416]: Failed to rotate
> >>>>>>     /var/log/journal/45c06c25e25f434195204efa939019ab/user-1000.jo=
urnal:
> >>>>>>     Read-only file system
> >>>>>>     [   44.509540] systemd-journald[416]: Failed to write entry (2=
3 items,
> >>>>>>     705 bytes) despite vacuuming, ignoring: Bad message
> >>>>>>     # ... then a bunch of these failed journal attempts (of note:
> >>>>>>     /var/log/journal was one of the bad inodes from btrfs check
> >>>>>>     previously)
> >>>>>>
> >>>>>>     Kindly let me know what you would recommend. I'm sadly back to=
 an
> >>>>>>     unusable system vs. a complaining/worrisome one. This is simil=
ar to
> >>>>>>     the behavior I had with the m2.sata nvme drive in my original
> >>>>>>     experience. After trying all of --repair, --init-csum-tree, an=
d
> >>>>>>     --init-extent-tree, I couldn't boot anymore. After my dm-crypt
> >>>>>>     password at boot, I just saw a bunch of [FAILED] in the text s=
plash
> >>>>>>     output. Hoping to not repeat that with this drive.
> >>>>>>
> >>>>>>     Thanks,
> >>>>>>     John
> >>>>>>
> >>>>>>
> >>>>>>     On Sat, Feb 8, 2020 at 1:29 AM Qu Wenruo <quwenruo.btrfs@gmx.c=
om
> >>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>>     >
> >>>>>>     >
> >>>>>>     >
> >>>>>>     > On 2020/2/8 =E4=B8=8B=E5=8D=8812:48, John Hendy wrote:
> >>>>>>     > > On Fri, Feb 7, 2020 at 5:42 PM Qu Wenruo <quwenruo.btrfs@g=
mx.com
> >>>>>>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
> >>>>>>     > >>
> >>>>>>     > >>
> >>>>>>     > >>
> >>>>>>     > >> On 2020/2/8 =E4=B8=8A=E5=8D=881:52, John Hendy wrote:
> >>>>>>     > >>> Greetings,
> >>>>>>     > >>>
> >>>>>>     > >>> I'm resending, as this isn't showing in the archives. Pe=
rhaps
> >>>>>>     it was
> >>>>>>     > >>> the attachments, which I've converted to pastebin links.
> >>>>>>     > >>>
> >>>>>>     > >>> As an update, I'm now running off of a different drive (=
ssd,
> >>>>>>     not the
> >>>>>>     > >>> nvme) and I got the error again! I'm now inclined to thi=
nk
> >>>>>>     this might
> >>>>>>     > >>> not be hardware after all, but something related to my s=
etup
> >>>>>>     or a bug
> >>>>>>     > >>> with chromium.
> >>>>>>     > >>>
> >>>>>>     > >>> After a reboot, chromium wouldn't start for me and demsg=
 showed
> >>>>>>     > >>> similar parent transid/csum errors to my original post b=
elow.
> >>>>>>     I used
> >>>>>>     > >>> btrfs-inspect-internal to find the inode traced to
> >>>>>>     > >>> ~/.config/chromium/History. I deleted that, and got a ne=
w set of
> >>>>>>     > >>> errors tracing to ~/.config/chromium/Cookies. After I de=
leted
> >>>>>>     that and
> >>>>>>     > >>> tried starting chromium, I found that my btrfs /home/jwh=
endy
> >>>>>>     pool was
> >>>>>>     > >>> mounted ro just like the original problem below.
> >>>>>>     > >>>
> >>>>>>     > >>> dmesg after trying to start chromium:
> >>>>>>     > >>> - https://pastebin.com/CsCEQMJa
> >>>>>>     > >>
> >>>>>>     > >> So far, it's only transid bug in your csum tree.
> >>>>>>     > >>
> >>>>>>     > >> And two backref mismatch in data backref.
> >>>>>>     > >>
> >>>>>>     > >> In theory, you can fix your problem by `btrfs check --rep=
air
> >>>>>>     > >> --init-csum-tree`.
> >>>>>>     > >>
> >>>>>>     > >
> >>>>>>     > > Now that I might be narrowing in on offending files, I'll =
wait
> >>>>>>     to see
> >>>>>>     > > what you think from my last response to Chris. I did try t=
he above
> >>>>>>     > > when I first ran into this:
> >>>>>>     > > -
> >>>>>>     https://lore.kernel.org/linux-btrfs/CA+M2ft8FpjdDQ7=3DXwMdYQaz=
hyB95aha_D4WU_n15M59QrimrRg@mail.gmail.com/
> >>>>>>     >
> >>>>>>     > That RO is caused by the missing data backref.
> >>>>>>     >
> >>>>>>     > Which can be fixed by btrfs check --repair.
> >>>>>>     >
> >>>>>>     > Then you should be able to delete offending files them. (Or =
the whole
> >>>>>>     > chromium cache, and switch to firefox if you wish :P )
> >>>>>>     >
> >>>>>>     > But also please keep in mind that, the transid mismatch look=
s
> >>>>>>     happen in
> >>>>>>     > your csum tree, which means your csum tree is no longer reli=
able, and
> >>>>>>     > may cause -EIO reading unrelated files.
> >>>>>>     >
> >>>>>>     > Thus it's recommended to re-fill the csum tree by --init-csu=
m-tree.
> >>>>>>     >
> >>>>>>     > It can be done altogether by --repair --init-csum-tree, but =
to be
> >>>>>>     safe,
> >>>>>>     > please run --repair only first, then make sure btrfs check r=
eports no
> >>>>>>     > error after that. Then go --init-csum-tree.
> >>>>>>     >
> >>>>>>     > >
> >>>>>>     > >> But I'm more interesting in how this happened.
> >>>>>>     > >
> >>>>>>     > > Me too :)
> >>>>>>     > >
> >>>>>>     > >> Have your every experienced any power loss for your NVME =
drive?
> >>>>>>     > >> I'm not say btrfs is unsafe against power loss, all fs sh=
ould
> >>>>>>     be safe
> >>>>>>     > >> against power loss, I'm just curious about if mount time =
log
> >>>>>>     replay is
> >>>>>>     > >> involved, or just regular internal log replay.
> >>>>>>     > >>
> >>>>>>     > >> From your smartctl, the drive experienced 61 unsafe shutd=
own
> >>>>>>     with 2144
> >>>>>>     > >> power cycles.
> >>>>>>     > >
> >>>>>>     > > Uhhh, hell yes, sadly. I'm a dummy running i3 and every ti=
me I get
> >>>>>>     > > caught off gaurd by low battery and instant power-off, I k=
ick myself
> >>>>>>     > > and mean to set up a script to force poweroff before that
> >>>>>>     happens. So,
> >>>>>>     > > indeed, I've lost power a ton. Surprised it was 61 times, =
but maybe
> >>>>>>     > > not over ~2 years. And actually, I mis-stated the age. I h=
aven't
> >>>>>>     > > *booted* from this drive in almost 2yrs. It's a corporate =
laptop,
> >>>>>>     > > issued every 3, so the ssd drive is more like 5 years old.
> >>>>>>     > >
> >>>>>>     > >> Not sure if it's related.
> >>>>>>     > >>
> >>>>>>     > >> Another interesting point is, did you remember what's the
> >>>>>>     oldest kernel
> >>>>>>     > >> running on this fs? v5.4 or v5.5?
> >>>>>>     > >
> >>>>>>     > > Hard to say, but arch linux maintains a package archive. T=
he nvme
> >>>>>>     > > drive is from ~May 2018. The archives only go back to Jan =
2019
> >>>>>>     and the
> >>>>>>     > > kernel/btrfs-progs was at 4.20 then:
> >>>>>>     > > - https://archive.archlinux.org/packages/l/linux/
> >>>>>>     >
> >>>>>>     > There is a known bug in v5.2.0~v5.2.14 (fixed in v5.2.15), w=
hich could
> >>>>>>     > cause metadata corruption. And the symptom is transid error,=
 which
> >>>>>>     also
> >>>>>>     > matches your problem.
> >>>>>>     >
> >>>>>>     > Thanks,
> >>>>>>     > Qu
> >>>>>>     >
> >>>>>>     > >
> >>>>>>     > > Searching my Amazon orders, the SSD was in the 2015 time f=
rame,
> >>>>>>     so the
> >>>>>>     > > kernel version would have been even older.
> >>>>>>     > >
> >>>>>>     > > Thanks for your input,
> >>>>>>     > > John
> >>>>>>     > >
> >>>>>>     > >>
> >>>>>>     > >> Thanks,
> >>>>>>     > >> Qu
> >>>>>>     > >>>
> >>>>>>     > >>> Thanks for any pointers, as it would now seem that my pu=
rchase
> >>>>>>     of a
> >>>>>>     > >>> new m2.sata may not buy my way out of this problem! Whil=
e I didn't
> >>>>>>     > >>> want to reinstall, at least new hardware is a simple fix=
. Now I'm
> >>>>>>     > >>> worried there is a deeper issue bound to recur :(
> >>>>>>     > >>>
> >>>>>>     > >>> Best regards,
> >>>>>>     > >>> John
> >>>>>>     > >>>
> >>>>>>     > >>> On Wed, Feb 5, 2020 at 10:01 AM John Hendy <jw.hendy@gma=
il.com
> >>>>>>     <mailto:jw.hendy@gmail.com>> wrote:
> >>>>>>     > >>>>
> >>>>>>     > >>>> Greetings,
> >>>>>>     > >>>>
> >>>>>>     > >>>> I've had this issue occur twice, once ~1mo ago and once=
 a
> >>>>>>     couple of
> >>>>>>     > >>>> weeks ago. Chromium suddenly quit on me, and when tryin=
g to
> >>>>>>     start it
> >>>>>>     > >>>> again, it complained about a lock file in ~. I tried to=
 delete it
> >>>>>>     > >>>> manually and was informed I was on a read-only fs! I en=
ded up
> >>>>>>     biting
> >>>>>>     > >>>> the bullet and re-installing linux due to the number of=
 dead end
> >>>>>>     > >>>> threads and slow response rates on diagnosing these iss=
ues,
> >>>>>>     and the
> >>>>>>     > >>>> issue occurred again shortly after.
> >>>>>>     > >>>>
> >>>>>>     > >>>> $ uname -a
> >>>>>>     > >>>> Linux whammy 5.5.1-arch1-1 #1 SMP PREEMPT Sat, 01 Feb 2=
020
> >>>>>>     16:38:40
> >>>>>>     > >>>> +0000 x86_64 GNU/Linux
> >>>>>>     > >>>>
> >>>>>>     > >>>> $ btrfs --version
> >>>>>>     > >>>> btrfs-progs v5.4
> >>>>>>     > >>>>
> >>>>>>     > >>>> $ btrfs fi df /mnt/misc/ # full device; normally would =
be
> >>>>>>     mounting a subvol on /
> >>>>>>     > >>>> Data, single: total=3D114.01GiB, used=3D80.88GiB
> >>>>>>     > >>>> System, single: total=3D32.00MiB, used=3D16.00KiB
> >>>>>>     > >>>> Metadata, single: total=3D2.01GiB, used=3D769.61MiB
> >>>>>>     > >>>> GlobalReserve, single: total=3D140.73MiB, used=3D0.00B
> >>>>>>     > >>>>
> >>>>>>     > >>>> This is a single device, no RAID, not on a VM. HP Zbook=
 15.
> >>>>>>     > >>>> nvme0n1                                       259:5    =
0
> >>>>>>     232.9G  0 disk
> >>>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p1                            =
       259:6    0
> >>>>>>      512M  0
> >>>>>>     > >>>> part  (/boot/efi)
> >>>>>>     > >>>> =E2=94=9C=E2=94=80nvme0n1p2                            =
       259:7    0
> >>>>>>      1G  0 part  (/boot)
> >>>>>>     > >>>> =E2=94=94=E2=94=80nvme0n1p3                            =
       259:8    0
> >>>>>>     231.4G  0 part (btrfs)
> >>>>>>     > >>>>
> >>>>>>     > >>>> I have the following subvols:
> >>>>>>     > >>>> arch: used for / when booting arch
> >>>>>>     > >>>> jwhendy: used for /home/jwhendy on arch
> >>>>>>     > >>>> vault: shared data between distros on /mnt/vault
> >>>>>>     > >>>> bionic: root when booting ubuntu bionic
> >>>>>>     > >>>>
> >>>>>>     > >>>> nvme0n1p3 is encrypted with dm-crypt/LUKS.
> >>>>>>     > >>>>
> >>>>>>     > >>>> dmesg, smartctl, btrfs check, and btrfs dev stats attac=
hed.
> >>>>>>     > >>>
> >>>>>>     > >>> Edit: links now:
> >>>>>>     > >>> - btrfs check: https://pastebin.com/nz6Bc145
> >>>>>>     > >>> - dmesg: https://pastebin.com/1GGpNiqk
> >>>>>>     > >>> - smartctl: https://pastebin.com/ADtYqfrd
> >>>>>>     > >>>
> >>>>>>     > >>> btrfs dev stats (not worth a link):
> >>>>>>     > >>>
> >>>>>>     > >>> [/dev/mapper/old].write_io_errs    0
> >>>>>>     > >>> [/dev/mapper/old].read_io_errs     0
> >>>>>>     > >>> [/dev/mapper/old].flush_io_errs    0
> >>>>>>     > >>> [/dev/mapper/old].corruption_errs  0
> >>>>>>     > >>> [/dev/mapper/old].generation_errs  0
> >>>>>>     > >>>
> >>>>>>     > >>>
> >>>>>>     > >>>> If these are of interested, here are reddit threads whe=
re I
> >>>>>>     posted the
> >>>>>>     > >>>> issue and was referred here.
> >>>>>>     > >>>> 1)
> >>>>>>     https://www.reddit.com/r/btrfs/comments/ejqhyq/any_hope_of_rec=
overing_from_various_errors_root/
> >>>>>>     > >>>> 2)
> >>>>>>     https://www.reddit.com/r/btrfs/comments/erh0f6/second_time_btr=
fs_root_started_remounting_as_ro/
> >>>>>>     > >>>>
> >>>>>>     > >>>> It has been suggested this is a hardware issue. I've al=
ready
> >>>>>>     ordered a
> >>>>>>     > >>>> replacement m2.sata, but for sanity it would be great t=
o know
> >>>>>>     > >>>> definitively this was the case. If anything stands out =
above that
> >>>>>>     > >>>> could indicate I'm not setup properly re. btrfs, that w=
ould
> >>>>>>     also be
> >>>>>>     > >>>> fantastic so I don't repeat the issue!
> >>>>>>     > >>>>
> >>>>>>     > >>>> The only thing I've stumbled on is that I have been mou=
nting with
> >>>>>>     > >>>> rd.luks.options=3Ddiscard and that manually running fst=
rim is
> >>>>>>     preferred.
> >>>>>>     > >>>>
> >>>>>>     > >>>>
> >>>>>>     > >>>> Many thanks for any input/suggestions,
> >>>>>>     > >>>> John
> >>>>>>     > >>
> >>>>>>     >
> >>>>>>
> >>>>>
> >>
>
