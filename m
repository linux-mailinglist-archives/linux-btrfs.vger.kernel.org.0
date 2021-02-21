Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0A320C98
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhBUS3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Feb 2021 13:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhBUS3E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Feb 2021 13:29:04 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4816C06178B
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Feb 2021 10:28:22 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id u3so10783842ybk.6
        for <linux-btrfs@vger.kernel.org>; Sun, 21 Feb 2021 10:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gV9UOPdgYOFx34MzEmK6Bpv92omW3eilSodKamjS54=;
        b=u7uwbdj3pJLtw+2LGnx2+S5vmta8EHGvAH9oabe0NqlnI/pmw/tsPwjbod7KBxOOh7
         mBNdjkKiv2Xe1nH9zw8N/HCoEzteqhOqSpJ3XJhJv5+kkQLs5ZB/1OmKPF0kdaJoWmpe
         BIjQ0+AyjHI6HaqYioVyKK/1btK3nzdsCmhlinvJS1+/QPO1HvsCcLsESyc5VGnQRNB7
         WGG1vRHKg98oiM23ongOZg/CWeMNMb7H1FgCSdLBSn4p4A6WNzkRWKCpPTPfh8WeJFpm
         8g6DCn1S2UGKRE7IDCgFHaKslTTLXk+2NBwvzqfIjVyBZvWzF/1nRr0c2qGJ27zXDMVh
         TCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gV9UOPdgYOFx34MzEmK6Bpv92omW3eilSodKamjS54=;
        b=jVBE3Xv4SK7FOgoHq/YN7OTDjdJsytgRe0mS5t4MmHXR09bdDAgC/4Yttb2wjf9GnZ
         arNIwCmrESuzDTL5xCsVpES/ishjW6ZGdn5Hvt0fw3fzjECqSR62VkkdBH7PB6RwwZ9J
         OAao5cLTQ66l0jmM4vZdSCsXuTRftTww6bvmVoYiAqf7/PoB1DjmReP3ppPQ5glLDzuF
         XW7U0g2IbIgSE5hKD1reG6fdQJfwd8I9KmSWIDpBaPc0rbFLOJNlwTI+wAqk2caz9kMs
         36fzWeZEHKHNCllsJhBxm0e9N2YXJqUzMSrFL9W1GzoYk1RBm89WLvqNrWTOQGhVhVq6
         HSVw==
X-Gm-Message-State: AOAM531AEasrPFZpDijQ6Q+JxXbjTq38T++DEh5os042NEoV/38T1mgM
        IYLlt2cU2VTLcPNHZ9f2qr+HPdlHTGx5YRU6Xar4OVx+sYZd2w==
X-Google-Smtp-Source: ABdhPJzLWajEOfGQQWUGuH1AjUYmPOgiEzYUHJ8uXmIJ3T44h4xHtzbb6Jhn7IJ6Tpx8FVgCJaqUrT0LT1g22N3gBng=
X-Received: by 2002:a25:4f41:: with SMTP id d62mr27742454ybb.354.1613932101862;
 Sun, 21 Feb 2021 10:28:21 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com> <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com> <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com> <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com> <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com> <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com>
In-Reply-To: <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 21 Feb 2021 13:27:45 -0500
Message-ID: <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a0597f05bbdcd980"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000a0597f05bbdcd980
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/17/21 11:29 AM, Neal Gompa wrote:
> > On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> wr=
ote:
> >>>>
> >>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> =
wrote:
> >>>>>>
> >>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >>>>>>>>
> >>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.=
com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>> Hey all,
> >>>>>>>>>>>
> >>>>>>>>>>> So one of my main computers recently had a disk controller fa=
ilure
> >>>>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs refu=
ses to
> >>>>>>>>>>> mount. I tried to do a mount and the following errors show up=
 in the
> >>>>>>>>>>> journal:
> >>>>>>>>>>>
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sd=
a3): disk space caching is enabled
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sd=
a3): has skinny extents
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (devic=
e sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657,=
 invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device s=
da3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (devic=
e sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657,=
 invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device s=
da3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device=
 sda3): couldn't read tree root
> >>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device s=
da3): open_ctree failed
> >>>>>>>>>>>
> >>>>>>>>>>> I've tried to do -o recovery,ro mount and get the same issue.=
 I can't
> >>>>>>>>>>> seem to find any reasonably good information on how to do rec=
overy in
> >>>>>>>>>>> this scenario, even to just recover enough to copy data off.
> >>>>>>>>>>>
> >>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.=
16 and
> >>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.1=
0.14. I'm
> >>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>
> >>>>>>>>>>> Can anyone help?
> >>>>>>>>>>
> >>>>>>>>>> Can you try
> >>>>>>>>>>
> >>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>
> >>>>>>>>>> That should fix the inode generation thing so it's sane, and t=
hen the tree
> >>>>>>>>>> checker will allow the fs to be read, hopefully.  If not we ca=
n work out some
> >>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>
> >>>>>>>>>> Josef
> >>>>>>>>>
> >>>>>>>>> I got the same error as I did with btrfs-check --readonly...
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
> >>>>>>>>
> >>>>>>>
> >>>>>>> No dice...
> >>>>>>>
> >>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>> Opening filesystem to check...
> >>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 88=
8895
> >>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 88=
8895
> >>>>>>>> parent transid verify failed on 791281664 wanted 888893 found 88=
8895
> >>>>>>
> >>>>>> Hey look the block we're looking for, I wrote you some magic, just=
 pull
> >>>>>>
> >>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>>>>>
> >>>>>> build, and then run
> >>>>>>
> >>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>
> >>>>>> This will force us to point at the old root with (hopefully) the r=
ight bytenr
> >>>>>> and gen, and then hopefully you'll be able to recover from there. =
 This is kind
> >>>>>> of saucy, so yolo, but I can undo it if it makes things worse.  Th=
anks,
> >>>>>>
> >>>>>
> >>>>> # btrfs check --readonly /dev/sda3
> >>>>>> Opening filesystem to check...
> >>>>>> ERROR: could not setup extent tree
> >>>>>> ERROR: cannot open file system
> >>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>> Opening filesystem to check...
> >>>>>> ERROR: could not setup extent tree
> >>>>>> ERROR: cannot open file system
> >>>>>
> >>>>> It's better, but still no dice... :(
> >>>>>
> >>>>>
> >>>>
> >>>> Hmm it's not telling us what's wrong with the extent tree, which is =
annoying.
> >>>> Does mount -o rescue=3Dall,ro work now that the root tree is normal?=
  Thanks,
> >>>>
> >>>
> >>> Nope, I see this in the journal:
> >>>
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ena=
bling all of the rescue options
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ign=
oring data csums
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ign=
oring bad roots
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): dis=
abling log replay at mount time
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): dis=
k space caching is enabled
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): has=
 skinny extents
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tr=
ee level mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tr=
ee level mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3): =
couldn't read tree root
> >>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): op=
en_ctree failed
> >>>
> >>>
> >>
> >> Ok git pull for-neal, rebuild, then run
> >>
> >> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>
> >> I thought of this yesterday but in my head was like "naaahhhh, whats t=
he chances
> >> that the level doesn't match??".  Thanks,
> >>
> >
> > Tried rescue mount again after running that and got a stack trace in
> > the kernel, detailed in the following attached log.
>
> Huh I wonder how I didn't hit this when testing, I must have only tested =
with
> zero'ing the extent root and the csum root.  You're going to have to buil=
d a
> kernel with a fix for this
>
> https://paste.centos.org/view/7b48aaea
>
> and see if that gets you further.  Thanks,
>

I built a kernel build as an RPM with your patch[1] and tried it.

[root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
Killed

The log from the journal is attached.


[1]: https://download.copr.fedorainfracloud.org/results/ngompa/btrfs-progs-=
neal-magic/fedora-34-x86_64/01987802-kernel/

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

--000000000000a0597f05bbdcd980
Content-Type: text/x-log; charset="US-ASCII"; name="output-clean.log"
Content-Disposition: attachment; filename="output-clean.log"
Content-Transfer-Encoding: base64
Content-ID: <f_klfhd08a0>
X-Attachment-Id: f_klfhd08a0

RmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6IEJUUkZTIGluZm8gKGRldmljZSBzZGIzKTog
ZW5hYmxpbmcgYWxsIG9mIHRoZSByZXNjdWUgb3B0aW9ucwpGZWIgMjEgMTM6MTg6NTggZmVkb3Jh
IGtlcm5lbDogQlRSRlMgaW5mbyAoZGV2aWNlIHNkYjMpOiBpZ25vcmluZyBkYXRhIGNzdW1zCkZl
YiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiMyk6IGln
bm9yaW5nIGJhZCByb290cwpGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogQlRSRlMgaW5m
byAoZGV2aWNlIHNkYjMpOiBkaXNhYmxpbmcgbG9nIHJlcGxheSBhdCBtb3VudCB0aW1lCkZlYiAy
MSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBCVFJGUyBpbmZvIChkZXZpY2Ugc2RiMyk6IGRpc2sg
c3BhY2UgY2FjaGluZyBpcyBlbmFibGVkCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RiMyk6IGhhcyBza2lubnkgZXh0ZW50cwpGZWIgMjEgMTM6MTg6
NTggZmVkb3JhIGtlcm5lbDogQlVHOiBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBh
ZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDMwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiAj
UEY6IHN1cGVydmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKRmViIDIxIDEzOjE4OjU4
IGZlZG9yYSBrZXJuZWw6ICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFn
ZQpGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUEdEIDAgUDREIDAgCkZlYiAyMSAxMzox
ODo1OCBmZWRvcmEga2VybmVsOiBPb3BzOiAwMDAwIFsjMV0gU01QIFBUSQpGZWIgMjEgMTM6MTg6
NTggZmVkb3JhIGtlcm5lbDogQ1BVOiAxIFBJRDogMTU5MCBDb21tOiBtb3VudCBOb3QgdGFpbnRl
ZCA1LjExLjAtMTU1Lm5lYWxidHJmc3Rlc3QuZmMzNC54ODZfNjQgIzEKRmViIDIxIDEzOjE4OjU4
IGZlZG9yYSBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6IFZNd2FyZSwgSW5jLiBWTXdhcmUgVmlydHVh
bCBQbGF0Zm9ybS80NDBCWCBEZXNrdG9wIFJlZmVyZW5jZSBQbGF0Zm9ybSwgQklPUyA2LjAwIDA3
LzIyLzIwMjAKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6IFJJUDogMDAxMDpidHJmc19k
ZXZpY2VfaW5pdF9kZXZfc3RhdHMrMHgyNi8weDIxMApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtl
cm5lbDogQ29kZTogMGYgMWYgNDAgMDAgMGYgMWYgNDQgMDAgMDAgNDEgNTcgNDkgODkgZjcgNDEg
NTYgNDEgNTUgNDUgMzEgZWQgNDEgNTQgNTUgNTMgNDggODMgZWMgNDAgNDggOGIgNDcgMzggNDgg
YzcgNDQgMjQgMmYgMDAgMDAgMDAgMDAgPDQ4PiA4YiA3MCAzMCBjNiA0NCAyNCAzZiAwMCA0OCBj
NyA0NCAyNCAzNyAwMCAwMCAwMCAwMCA0OCA4NSBmNiA3NApGZWIgMjEgMTM6MTg6NTggZmVkb3Jh
IGtlcm5lbDogUlNQOiAwMDE4OmZmZmZiNDc3YzNjZTNiNjggRUZMQUdTOiAwMDAxMDI4MgpGZWIg
MjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZm
ZjhhZDMwOTRlYTA5OCBSQ1g6IDAwMDAwMDAwMDAwMDAwNzAKRmViIDIxIDEzOjE4OjU4IGZlZG9y
YSBrZXJuZWw6IFJEWDogZmZmZjhhZDMxYjcyODAwMCBSU0k6IGZmZmY4YWQzMjhjOGMyYTAgUkRJ
OiBmZmZmOGFkMzA5NGVhYzAwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBSQlA6IGZm
ZmY4YWQzMjhjOGMyYTAgUjA4OiAwMDAwMDAwMDAwMDAwMDcwIFIwOTogMDAwMDAwMDAwMDAwMDAw
MApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUjEwOiBmZmZmOGFkMzI4YzhjMmEwIFIx
MTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmY4YWQzMDk0ZWEwMDAKRmViIDIxIDEzOjE4OjU4
IGZlZG9yYSBrZXJuZWw6IFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IGZmZmY4YWQzMDk0ZWFj
MDAgUjE1OiBmZmZmOGFkMzI4YzhjMmEwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBG
UzogIDAwMDA3ZmRhNDk3OWZjNDAoMDAwMCkgR1M6ZmZmZjhhZDM3YmU0MDAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkZlYiAyMSAxMzoxODo1
OCBmZWRvcmEga2VybmVsOiBDUjI6IDAwMDAwMDAwMDAwMDAwMzAgQ1IzOiAwMDAwMDAwMDVmYWNh
MDAxIENSNDogMDAwMDAwMDAwMDM3MDZlMApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDog
Q2FsbCBUcmFjZToKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6ICA/IGJ0cmZzX2luaXRf
ZGV2X3N0YXRzKzB4MWYvMHhmMApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogIGJ0cmZz
X2luaXRfZGV2X3N0YXRzKzB4NjIvMHhmMApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDog
IG9wZW5fY3RyZWUrMHgxMDJjLzB4MTYxMApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDog
IGJ0cmZzX21vdW50X3Jvb3QuY29sZCsweDEzLzB4ZmEKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBr
ZXJuZWw6ICBsZWdhY3lfZ2V0X3RyZWUrMHgyNy8weDQwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEg
a2VybmVsOiAgdmZzX2dldF90cmVlKzB4MjUvMHhiMApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtl
cm5lbDogIHZmc19rZXJuX21vdW50LnBhcnQuMCsweDcxLzB4YjAKRmViIDIxIDEzOjE4OjU4IGZl
ZG9yYSBrZXJuZWw6ICBidHJmc19tb3VudCsweDEzMS8weDNkMApGZWIgMjEgMTM6MTg6NTggZmVk
b3JhIGtlcm5lbDogID8gbGVnYWN5X2dldF90cmVlKzB4MjcvMHg0MApGZWIgMjEgMTM6MTg6NTgg
ZmVkb3JhIGtlcm5lbDogID8gYnRyZnNfc2hvd19vcHRpb25zKzB4NjQwLzB4NjQwCkZlYiAyMSAx
MzoxODo1OCBmZWRvcmEga2VybmVsOiAgbGVnYWN5X2dldF90cmVlKzB4MjcvMHg0MApGZWIgMjEg
MTM6MTg6NTggZmVkb3JhIGtlcm5lbDogIHZmc19nZXRfdHJlZSsweDI1LzB4YjAKRmViIDIxIDEz
OjE4OjU4IGZlZG9yYSBrZXJuZWw6ICBwYXRoX21vdW50KzB4NDQxLzB4YTgwCkZlYiAyMSAxMzox
ODo1OCBmZWRvcmEga2VybmVsOiAgX194NjRfc3lzX21vdW50KzB4ZjQvMHgxMzAKRmViIDIxIDEz
OjE4OjU4IGZlZG9yYSBrZXJuZWw6ICBkb19zeXNjYWxsXzY0KzB4MzMvMHg0MApGZWIgMjEgMTM6
MTg6NTggZmVkb3JhIGtlcm5lbDogIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ0
LzB4YTkKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6IFJJUDogMDAzMzoweDdmZGE0OTlj
ZjUyZQpGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogQ29kZTogNDggOGIgMGQgNDUgMTkg
MGMgMDAgZjcgZDggNjQgODkgMDEgNDggODMgYzggZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAg
MDAgMDAgMDAgOTAgZjMgMGYgMWUgZmEgNDkgODkgY2EgYjggYTUgMDAgMDAgMDAgMGYgMDUgPDQ4
PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCAxMiAxOSAwYyAwMCBmNyBkOCA2NCA4
OSAwMSA0OApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUlNQOiAwMDJiOjAwMDA3ZmZj
MTJkZmY2ODggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBhNQpGZWIg
MjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAw
MDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDA3ZmRhNDk5Y2Y1MmUKRmViIDIxIDEzOjE4OjU4IGZlZG9y
YSBrZXJuZWw6IFJEWDogMDAwMDU1ZTJmYzZmMzY5MCBSU0k6IDAwMDA1NWUyZmM2ZjM3MzAgUkRJ
OiAwMDAwNTVlMmZjNmYzNmIwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBSQlA6IDAw
MDA1NWUyZmM2ZjM0NjAgUjA4OiAwMDAwNTVlMmZjNmYzNmYwIFIwOTogMDAwMDdmZGE0OWE5MWE2
MApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIx
MTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDAKRmViIDIxIDEzOjE4OjU4
IGZlZG9yYSBrZXJuZWw6IFIxMzogMDAwMDU1ZTJmYzZmMzZiMCBSMTQ6IDAwMDA1NWUyZmM2ZjM2
OTAgUjE1OiAwMDAwNTVlMmZjNmYzNDYwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBN
b2R1bGVzIGxpbmtlZCBpbjogYm5lcCBzbmRfc2VxX2R1bW15IHNuZF9ocnRpbWVyIGJsdWV0b290
aCBlY2RoX2dlbmVyaWMgZWNjIG5mdF9maWJfaW5ldCBuZnRfZmliX2lwdjQgbmZ0X2ZpYl9pcHY2
IG5mdF9maWIgbmZ0X3JlamVjdF9pbmV0IG5mX3JlamVjdF9pcHY0IG5mX3JlamVjdF9pcHY2IG5m
dF9yZWplY3QgbmZ0X2N0IG5mdF9jaGFpbl9uYXQgaXA2dGFibGVfbmF0IGlwNnRhYmxlX21hbmds
ZSBpcDZ0YWJsZV9yYXcgaXA2dGFibGVfc2VjdXJpdHkgaXB0YWJsZV9uYXQgbmZfbmF0IG5mX2Nv
bm50cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdfaXB2NCBpcHRhYmxlX21hbmdsZSBpcHRh
YmxlX3JhdyBpcHRhYmxlX3NlY3VyaXR5IGlwX3NldCBuZl90YWJsZXMgcmZraWxsIG5mbmV0bGlu
ayBpcDZ0YWJsZV9maWx0ZXIgaXA2X3RhYmxlcyBpcHRhYmxlX2ZpbHRlciB2c29ja19sb29wYmFj
ayB2bXdfdnNvY2tfdmlydGlvX3RyYW5zcG9ydF9jb21tb24gc25kX3NlcV9taWRpIHNuZF9zZXFf
bWlkaV9ldmVudCB2bXdfdnNvY2tfdm1jaV90cmFuc3BvcnQgdnNvY2sgc3VucnBjIGludGVsX3Jh
cGxfbXNyIGludGVsX3JhcGxfY29tbW9uIHJhcGwgdm13X2JhbGxvb24gc25kX2VuczEzNzEgc25k
X2FjOTdfY29kZWMgYWM5N19idXMgc25kX3Jhd21pZGkgc25kX3NlcSBzbmRfc2VxX2RldmljZSBz
bmRfcGNtIGpveWRldiBwY3Nwa3Igc25kX3RpbWVyIHNuZCBzb3VuZGNvcmUgZ2FtZXBvcnQgdm13
X3ZtY2kgaTJjX3BpaXg0IHpyYW0gaXBfdGFibGVzIGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNs
bXVsIHZtd2dmeCBjcmMzMmNfaW50ZWwgZHJtX2ttc19oZWxwZXIgZ2hhc2hfY2xtdWxuaV9pbnRl
bCBtcHRzcGkgZTEwMDAgY2VjIHR0bSBzY3NpX3RyYW5zcG9ydF9zcGkgc2VyaW9fcmF3IGRybSBt
cHRzY3NpaCBtcHRiYXNlIGF0YV9nZW5lcmljIHBhdGFfYWNwaSBmdXNlCkZlYiAyMSAxMzoxODo1
OCBmZWRvcmEga2VybmVsOiBDUjI6IDAwMDAwMDAwMDAwMDAwMzAKRmViIDIxIDEzOjE4OjU4IGZl
ZG9yYSBrZXJuZWw6IC0tLVsgZW5kIHRyYWNlIDg3YWM5NGY4ODdlYWJiNjcgXS0tLQpGZWIgMjEg
MTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUklQOiAwMDEwOmJ0cmZzX2RldmljZV9pbml0X2Rldl9z
dGF0cysweDI2LzB4MjEwCkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBDb2RlOiAwZiAx
ZiA0MCAwMCAwZiAxZiA0NCAwMCAwMCA0MSA1NyA0OSA4OSBmNyA0MSA1NiA0MSA1NSA0NSAzMSBl
ZCA0MSA1NCA1NSA1MyA0OCA4MyBlYyA0MCA0OCA4YiA0NyAzOCA0OCBjNyA0NCAyNCAyZiAwMCAw
MCAwMCAwMCA8NDg+IDhiIDcwIDMwIGM2IDQ0IDI0IDNmIDAwIDQ4IGM3IDQ0IDI0IDM3IDAwIDAw
IDAwIDAwIDQ4IDg1IGY2IDc0CkZlYiAyMSAxMzoxODo1OCBmZWRvcmEga2VybmVsOiBSU1A6IDAw
MTg6ZmZmZmI0NzdjM2NlM2I2OCBFRkxBR1M6IDAwMDEwMjgyCkZlYiAyMSAxMzoxODo1OCBmZWRv
cmEga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmOGFkMzA5NGVhMDk4IFJD
WDogMDAwMDAwMDAwMDAwMDA3MApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDogUkRYOiBm
ZmZmOGFkMzFiNzI4MDAwIFJTSTogZmZmZjhhZDMyOGM4YzJhMCBSREk6IGZmZmY4YWQzMDk0ZWFj
MDAKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6IFJCUDogZmZmZjhhZDMyOGM4YzJhMCBS
MDg6IDAwMDAwMDAwMDAwMDAwNzAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwCkZlYiAyMSAxMzoxODo1
OCBmZWRvcmEga2VybmVsOiBSMTA6IGZmZmY4YWQzMjhjOGMyYTAgUjExOiAwMDAwMDAwMDAwMDAw
MDAwIFIxMjogZmZmZjhhZDMwOTRlYTAwMApGZWIgMjEgMTM6MTg6NTggZmVkb3JhIGtlcm5lbDog
UjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjhhZDMwOTRlYWMwMCBSMTU6IGZmZmY4YWQz
MjhjOGMyYTAKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6IEZTOiAgMDAwMDdmZGE0OTc5
ZmM0MCgwMDAwKSBHUzpmZmZmOGFkMzdiZTQwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAw
MDAKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6IENTOiAgMDAxMCBEUzogMDAwMCBFUzog
MDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKRmViIDIxIDEzOjE4OjU4IGZlZG9yYSBrZXJuZWw6
IENSMjogMDAwMDAwMDAwMDAwMDAzMCBDUjM6IDAwMDAwMDAwNWZhY2EwMDEgQ1I0OiAwMDAwMDAw
MDAwMzcwNmUwCkZlYiAyMSAxMzoxODo1OSBmZWRvcmEgYWJydC1kdW1wLWpvdXJuYWwtb29wc1s3
MDBdOiBhYnJ0LWR1bXAtam91cm5hbC1vb3BzOiBGb3VuZCBvb3BzZXM6IDEKRmViIDIxIDEzOjE4
OjU5IGZlZG9yYSBhYnJ0LWR1bXAtam91cm5hbC1vb3BzWzcwMF06IGFicnQtZHVtcC1qb3VybmFs
LW9vcHM6IENyZWF0aW5nIHByb2JsZW0gZGlyZWN0b3JpZXMKRmViIDIxIDEzOjE5OjAwIGZlZG9y
YSBhYnJ0LW5vdGlmaWNhdGlvblsxNjMxXTogU3lzdGVtIGVuY291bnRlcmVkIGEgbm9uLWZhdGFs
IGVycm9yIGluIGJ0cmZzX2luaXRfZGV2X3N0YXRzKCkKRmViIDIxIDEzOjE5OjAwIGZlZG9yYSBh
YnJ0LWR1bXAtam91cm5hbC1vb3BzWzcwMF06IFJlcG9ydGVkIDEga2VybmVsIG9vcHNlcyB0byBB
YnJ0Cg==
--000000000000a0597f05bbdcd980--
