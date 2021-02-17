Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7249431DD5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 17:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhBQQai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 11:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhBQQag (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 11:30:36 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32864C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 08:29:56 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y128so14295498ybf.10
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTNiG4GQx8RPoCWWTOI8i6pLqGCcJ3nffeXTXreCpDI=;
        b=muWWap7VbRnY1xGdUwRF8Qe8rtKIhzjnXTFKAyY5OXlf1/RK/e8Z/VZZb3oNqeqsRY
         YeW921QBVFWx39fxsdxDf5Y4kr0B2CZhkNVmbiisI5DdsnGOmA/TWUvLFxURyGnZPp73
         xqv7d0WBEiz24m+89BIuwUg/Yfh5r+IdqOcmN6gGJ1dp+SKIw1naH7VA9fBDTJSFzUbs
         eo1UNW2xnaYnky6wLmVbZFN3hhAtcEJUAt2i269aBte4E5EtG45ot0r+XzJfGuJ3DuFm
         bCX+EJ7gY9P6X0BLkHOghZEsThMw6V1ALRESyJRETUQCi+cFdIZgEgu5mtMCA6LUMW57
         aFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTNiG4GQx8RPoCWWTOI8i6pLqGCcJ3nffeXTXreCpDI=;
        b=LUqTC5cQ6LmveYs4fOzh7RLmlbCea3H9RUh9zPfC87kUHz55W4Bl76G3ZDshLX8sJY
         GtgPCFDk4e5Yervt2JjwQHl14rAHAlYyFQPD8IUYFima6ThrH/44dU/sB3DtUdHgf5vD
         YyKU3KHjjS980D9lftBt6To97URGCsCx00Un/rUUeDPjYlYvOhsQ4OIeEQrpyrhtpkCp
         uGclkIjb7s1GRZxx3/mvE0yF64bWty5uYQVn9jSY+O25o8S5pGH6x6/gDSIiwePYQuu6
         AniE1sN5dfW02zEcOxf/PmWK6NalSdQGpy7TnipF3oPr8ECL2Iu9BtyVxwtLr6NHcAA1
         HsAQ==
X-Gm-Message-State: AOAM533tcJb3vOR0r95gxv9Km67qitVhsv0vHmYe8zG/yfcqUWfz20G5
        /0bKTOU4X03t0eDFW9VFq5FJCu7bwE8EUm7Ji9o=
X-Google-Smtp-Source: ABdhPJzs3W9nwz8wmE/J1xNFXjhM+CLBcs0azfxiMYgXtO4RThcg+hhR4yrGwMN+mzXt07OgtmHwjudq/gxgfytmD0s=
X-Received: by 2002:a25:424f:: with SMTP id p76mr265403yba.109.1613579395366;
 Wed, 17 Feb 2021 08:29:55 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com> <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com> <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com> <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com> <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com>
In-Reply-To: <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 17 Feb 2021 11:29:18 -0500
Message-ID: <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000adaf9705bb8aba54"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000adaf9705bb8aba54
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/17/21 9:50 AM, Neal Gompa wrote:
> > On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.com> wr=
ote:
> >>>>
> >>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda.com> =
wrote:
> >>>>>>
> >>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpanda.co=
m> wrote:
> >>>>>>>>
> >>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>> Hey all,
> >>>>>>>>>
> >>>>>>>>> So one of my main computers recently had a disk controller fail=
ure
> >>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs refuse=
s to
> >>>>>>>>> mount. I tried to do a mount and the following errors show up i=
n the
> >>>>>>>>> journal:
> >>>>>>>>>
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3=
): disk space caching is enabled
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (device sda3=
): has skinny extents
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device =
sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, i=
nvalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda=
3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (device =
sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203657, i=
nvalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda=
3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (device s=
da3): couldn't read tree root
> >>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (device sda=
3): open_ctree failed
> >>>>>>>>>
> >>>>>>>>> I've tried to do -o recovery,ro mount and get the same issue. I=
 can't
> >>>>>>>>> seem to find any reasonably good information on how to do recov=
ery in
> >>>>>>>>> this scenario, even to just recover enough to copy data off.
> >>>>>>>>>
> >>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version 5.9.16=
 and
> >>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version 5.10.=
14. I'm
> >>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>
> >>>>>>>>> Can anyone help?
> >>>>>>>>
> >>>>>>>> Can you try
> >>>>>>>>
> >>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>
> >>>>>>>> That should fix the inode generation thing so it's sane, and the=
n the tree
> >>>>>>>> checker will allow the fs to be read, hopefully.  If not we can =
work out some
> >>>>>>>> other magic.  Thanks,
> >>>>>>>>
> >>>>>>>> Josef
> >>>>>>>
> >>>>>>> I got the same error as I did with btrfs-check --readonly...
> >>>>>>>
> >>>>>>
> >>>>>> Oh lovely, what does btrfs check --readonly --backup do?
> >>>>>>
> >>>>>
> >>>>> No dice...
> >>>>>
> >>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>> Opening filesystem to check...
> >>>>>> parent transid verify failed on 791281664 wanted 888893 found 8888=
95
> >>>>>> parent transid verify failed on 791281664 wanted 888893 found 8888=
95
> >>>>>> parent transid verify failed on 791281664 wanted 888893 found 8888=
95
> >>>>
> >>>> Hey look the block we're looking for, I wrote you some magic, just p=
ull
> >>>>
> >>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>>>
> >>>> build, and then run
> >>>>
> >>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>
> >>>> This will force us to point at the old root with (hopefully) the rig=
ht bytenr
> >>>> and gen, and then hopefully you'll be able to recover from there.  T=
his is kind
> >>>> of saucy, so yolo, but I can undo it if it makes things worse.  Than=
ks,
> >>>>
> >>>
> >>> # btrfs check --readonly /dev/sda3
> >>>> Opening filesystem to check...
> >>>> ERROR: could not setup extent tree
> >>>> ERROR: cannot open file system
> >>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>> Opening filesystem to check...
> >>>> ERROR: could not setup extent tree
> >>>> ERROR: cannot open file system
> >>>
> >>> It's better, but still no dice... :(
> >>>
> >>>
> >>
> >> Hmm it's not telling us what's wrong with the extent tree, which is an=
noying.
> >> Does mount -o rescue=3Dall,ro work now that the root tree is normal?  =
Thanks,
> >>
> >
> > Nope, I see this in the journal:
> >
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): enabl=
ing all of the rescue options
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignor=
ing data csums
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): ignor=
ing bad roots
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disab=
ling log replay at mount time
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): disk =
space caching is enabled
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3): has s=
kinny extents
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree=
 level mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): tree=
 level mismatch detected, bytenr=3D791281664 level expected=3D1 has=3D2
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda3): co=
uldn't read tree root
> >> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3): open=
_ctree failed
> >
> >
>
> Ok git pull for-neal, rebuild, then run
>
> btrfs-neal-magic /dev/sda3 791281664 888895 2
>
> I thought of this yesterday but in my head was like "naaahhhh, whats the =
chances
> that the level doesn't match??".  Thanks,
>

Tried rescue mount again after running that and got a stack trace in
the kernel, detailed in the following attached log.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

--000000000000adaf9705bb8aba54
Content-Type: text/x-log; charset="US-ASCII"; name="output-clean.log"
Content-Disposition: attachment; filename="output-clean.log"
Content-Transfer-Encoding: base64
Content-ID: <f_kl9ngzwn0>
X-Attachment-Id: f_kl9ngzwn0

RmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogQlRSRlMgaW5mbyAoZGV2aWNl
IHNkYTMpOiBlbmFibGluZyBhbGwgb2YgdGhlIHJlc2N1ZSBvcHRpb25zCkZlYiAxNyAxMToyNDoz
NSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IEJUUkZTIGluZm8gKGRldmljZSBzZGEzKTogaWdub3Jp
bmcgZGF0YSBjc3VtcwpGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBCVFJG
UyBpbmZvIChkZXZpY2Ugc2RhMyk6IGlnbm9yaW5nIGJhZCByb290cwpGZWIgMTcgMTE6MjQ6MzUg
bG9jYWxob3N0LWxpdmUga2VybmVsOiBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhMyk6IGRpc2FibGlu
ZyBsb2cgcmVwbGF5IGF0IG1vdW50IHRpbWUKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZl
IGtlcm5lbDogQlRSRlMgaW5mbyAoZGV2aWNlIHNkYTMpOiBkaXNrIHNwYWNlIGNhY2hpbmcgaXMg
ZW5hYmxlZApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBCVFJGUyBpbmZv
IChkZXZpY2Ugc2RhMyk6IGhhcyBza2lubnkgZXh0ZW50cwpGZWIgMTcgMTE6MjQ6MzUgbG9jYWxo
b3N0LWxpdmUga2VybmVsOiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFk
ZHJlc3M6IDAwMDAwMDAwMDAwMDAwMzAKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtl
cm5lbDogI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlCkZlYiAxNyAx
MToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6ICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0g
bm90LXByZXNlbnQgcGFnZQpGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBQ
R0QgMCBQNEQgMCAKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogT29wczog
MDAwMCBbIzFdIFNNUCBQVEkKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDog
Q1BVOiAwIFBJRDogNDA5NSBDb21tOiBtb3VudCBOb3QgdGFpbnRlZCA1LjExLjAtMC5yYzcuMTQ5
LmZjMzQueDg2XzY0ICMxCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IEhh
cmR3YXJlIG5hbWU6IFZNd2FyZSwgSW5jLiBWTXdhcmUgVmlydHVhbCBQbGF0Zm9ybS80NDBCWCBE
ZXNrdG9wIFJlZmVyZW5jZSBQbGF0Zm9ybSwgQklPUyA2LjAwIDA3LzIyLzIwMjAKRmViIDE3IDEx
OjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogUklQOiAwMDEwOmJ0cmZzX2RldmljZV9pbml0
X2Rldl9zdGF0cysweDRjLzB4MWYwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJu
ZWw6IENvZGU6IDAxIDAwIDAwIDUzIDQ4IDgzIGVjIDQwIDQ4IDhiIDQ3IDc4IDQ4IDhkIDU0IDI0
IDJmIGM2IDQ0IDI0IDM3IGY5IDQ4IDg5IDQ0IDI0IDM4IDQ4IDhiIDQ3IDM4IDMxIGZmIDQ4IGM3
IDQ0IDI0IDJmIDAwIDAwIDAwIDAwIDw0OD4gOGIgNzAgMzAgZTggMGIgYjQgZmIgZmYgNDEgODkg
YzUgODUgYzAgNzQgNTIgNDkgOGQgODQgMjQgNDAgMDEKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9z
dC1saXZlIGtlcm5lbDogUlNQOiAwMDE4OmZmZmZhNjAyODVmYmZiNjggRUZMQUdTOiAwMDAxMDI0
NgpGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAw
MDAwMDAgUkJYOiBmZmZmODhiODhmODA2NDk4IFJDWDogZmZmZjg4YjgyZTdhMmExMApGZWIgMTcg
MTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBSRFg6IGZmZmZhNjAyODVmYmZiOTcgUlNJ
OiBmZmZmODhiODJlN2EyYTEwIFJESTogMDAwMDAwMDAwMDAwMDAwMApGZWIgMTcgMTE6MjQ6MzUg
bG9jYWxob3N0LWxpdmUga2VybmVsOiBSQlA6IGZmZmY4OGI4OGY4MDZiM2MgUjA4OiAwMDAwMDAw
MDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0
LWxpdmUga2VybmVsOiBSMTA6IGZmZmY4OGI4MmU3YTJhMTAgUjExOiAwMDAwMDAwMDAwMDAwMDAw
IFIxMjogZmZmZjg4Yjg4ZjgwNmEwMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2Vy
bmVsOiBSMTM6IGZmZmY4OGI4OGY4MDY0NzggUjE0OiBmZmZmODhiODhmODA2YTAwIFIxNTogZmZm
Zjg4YjgyZTdhMmExMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBGUzog
IDAwMDA3ZjY5OGJlMWVjNDAoMDAwMCkgR1M6ZmZmZjg4YjkzN2UwMDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IENT
OiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKRmViIDE3IDEx
OjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogQ1IyOiAwMDAwMDAwMDAwMDAwMDMwIENSMzog
MDAwMDAwMDA5MmM5YzAwNiBDUjQ6IDAwMDAwMDAwMDAzNzA2ZjAKRmViIDE3IDExOjI0OjM1IGxv
Y2FsaG9zdC1saXZlIGtlcm5lbDogQ2FsbCBUcmFjZToKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9z
dC1saXZlIGtlcm5lbDogID8gYnRyZnNfaW5pdF9kZXZfc3RhdHMrMHgxZi8weGYwCkZlYiAxNyAx
MToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6ICBidHJmc19pbml0X2Rldl9zdGF0cysweDYy
LzB4ZjAKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogIG9wZW5fY3RyZWUr
MHgxMDE5LzB4MTVmZgpGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiAgYnRy
ZnNfbW91bnRfcm9vdC5jb2xkKzB4MTMvMHhmYQpGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxp
dmUga2VybmVsOiAgbGVnYWN5X2dldF90cmVlKzB4MjcvMHg0MApGZWIgMTcgMTE6MjQ6MzUgbG9j
YWxob3N0LWxpdmUga2VybmVsOiAgdmZzX2dldF90cmVlKzB4MjUvMHhiMApGZWIgMTcgMTE6MjQ6
MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiAgdmZzX2tlcm5fbW91bnQucGFydC4wKzB4NzEvMHhi
MApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiAgYnRyZnNfbW91bnQrMHgx
MzEvMHgzZDAKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogID8gbGVnYWN5
X2dldF90cmVlKzB4MjcvMHg0MApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVs
OiAgPyBidHJmc19zaG93X29wdGlvbnMrMHg2NDAvMHg2NDAKRmViIDE3IDExOjI0OjM1IGxvY2Fs
aG9zdC1saXZlIGtlcm5lbDogIGxlZ2FjeV9nZXRfdHJlZSsweDI3LzB4NDAKRmViIDE3IDExOjI0
OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogIHZmc19nZXRfdHJlZSsweDI1LzB4YjAKRmViIDE3
IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogIHBhdGhfbW91bnQrMHg0NDEvMHhhODAK
RmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogIF9feDY0X3N5c19tb3VudCsw
eGY0LzB4MTMwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6ICBkb19zeXNj
YWxsXzY0KzB4MzMvMHg0MApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiAg
ZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQpGZWIgMTcgMTE6MjQ6MzUg
bG9jYWxob3N0LWxpdmUga2VybmVsOiBSSVA6IDAwMzM6MHg3ZjY5OGMwNGU1MmUKRmViIDE3IDEx
OjI0OjM1IGxvY2FsaG9zdC1saXZlIGtlcm5lbDogQ29kZTogNDggOGIgMGQgNDUgMTkgMGMgMDAg
ZjcgZDggNjQgODkgMDEgNDggODMgYzggZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAg
MDAgOTAgZjMgMGYgMWUgZmEgNDkgODkgY2EgYjggYTUgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAw
MSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCAxMiAxOSAwYyAwMCBmNyBkOCA2NCA4OSAwMSA0
OApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBSU1A6IDAwMmI6MDAwMDdm
ZmRmNTJiYzUxOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMGE1CkZl
YiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IFJBWDogZmZmZmZmZmZmZmZmZmZk
YSBSQlg6IDAwMDAwMDAwMDAwMDAwMDAgUkNYOiAwMDAwN2Y2OThjMDRlNTJlCkZlYiAxNyAxMToy
NDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IFJEWDogMDAwMDU2MDNmMDY4ZTY5MCBSU0k6IDAw
MDA1NjAzZjA2OGU3MzAgUkRJOiAwMDAwNTYwM2YwNjhlNmIwCkZlYiAxNyAxMToyNDozNSBsb2Nh
bGhvc3QtbGl2ZSBrZXJuZWw6IFJCUDogMDAwMDU2MDNmMDY4ZTQ2MCBSMDg6IDAwMDA1NjAzZjA2
OGU2ZjAgUjA5OiAwMDAwN2Y2OThjMTEwYTYwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2
ZSBrZXJuZWw6IFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEy
OiAwMDAwMDAwMDAwMDAwMDAwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6
IFIxMzogMDAwMDU2MDNmMDY4ZTZiMCBSMTQ6IDAwMDA1NjAzZjA2OGU2OTAgUjE1OiAwMDAwNTYw
M2YwNjhlNDYwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IE1vZHVsZXMg
bGlua2VkIGluOiBzbmRfc2VxX2R1bW15IHNuZF9ocnRpbWVyIHVpbnB1dCBuZnRfZmliX2luZXQg
bmZ0X2ZpYl9pcHY0IG5mdF9maWJfaXB2NiBuZnRfZmliIG5mdF9yZWplY3RfaW5ldCBuZl9yZWpl
Y3RfaXB2NCBuZl9yZWplY3RfaXB2NiBuZnRfcmVqZWN0IG5mdF9jdCBuZnRfY2hhaW5fbmF0IGlw
NnRhYmxlX25hdCBpcDZ0YWJsZV9tYW5nbGUgaXA2dGFibGVfcmF3IGlwNnRhYmxlX3NlY3VyaXR5
IGlwdGFibGVfbmF0IG5mX25hdCBuZl9jb25udHJhY2sgbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFn
X2lwdjQgaXB0YWJsZV9tYW5nbGUgaXB0YWJsZV9yYXcgaXB0YWJsZV9zZWN1cml0eSBpcF9zZXQg
bmZfdGFibGVzIHJma2lsbCBuZm5ldGxpbmsgaXA2dGFibGVfZmlsdGVyIGlwNl90YWJsZXMgaXB0
YWJsZV9maWx0ZXIgdnNvY2tfbG9vcGJhY2sgdm13X3Zzb2NrX3ZpcnRpb190cmFuc3BvcnRfY29t
bW9uIHZtd192c29ja192bWNpX3RyYW5zcG9ydCB2c29jayBzbmRfc2VxX21pZGkgc25kX3NlcV9t
aWRpX2V2ZW50IHNuZF9lbnMxMzcxIHNuZF9hYzk3X2NvZGVjIGFjOTdfYnVzIHNuZF9yYXdtaWRp
IHNuZF9zZXEgc25kX3NlcV9kZXZpY2Ugc25kX3BjbSBpbnRlbF9yYXBsX21zciBzbmRfdGltZXIg
aW50ZWxfcmFwbF9jb21tb24gc25kIHBrdGNkdmQgdm13Z2Z4IHJhcGwgc291bmRjb3JlIGdhbWVw
b3J0IHR0bSBkcm1fa21zX2hlbHBlciB2bXdfYmFsbG9vbiBjZWMgcGNzcGtyIGpveWRldiB2bXdf
dm1jaSBpMmNfcGlpeDQgZHJtIHpyYW0gaXBfdGFibGVzIG5sc191dGY4IGlzb2ZzIHNxdWFzaGZz
IGNyY3QxMGRpZl9wY2xtdWwgY3JjMzJfcGNsbXVsIGNyYzMyY19pbnRlbCBnaGFzaF9jbG11bG5p
X2ludGVsIHNlcmlvX3JhdyBtcHRzcGkgbXB0c2NzaWggdm14bmV0MyBtcHRiYXNlIHNjc2lfdHJh
bnNwb3J0X3NwaSBhdGFfZ2VuZXJpYyBwYXRhX2FjcGkgc3VucnBjIGJlMmlzY3NpIGJueDJpIGNu
aWMgdWlvCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6ICBjeGdiNGkgY3hn
YjQgdGxzIGN4Z2IzaSBjeGdiMyBtZGlvIGxpYmN4Z2JpIGxpYmN4Z2IgcWxhNHh4eCBpc2NzaV9i
b290X3N5c2ZzIGlzY3NpX3RjcCBsaWJpc2NzaV90Y3AgbGliaXNjc2kgbG9vcCBmdXNlIHNjc2lf
dHJhbnNwb3J0X2lzY3NpCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IENS
MjogMDAwMDAwMDAwMDAwMDAzMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVs
OiAtLS1bIGVuZCB0cmFjZSBhOGQ5ZGRlOWE5YWZhYzZiIF0tLS0KRmViIDE3IDExOjI0OjM1IGxv
Y2FsaG9zdC1saXZlIGtlcm5lbDogUklQOiAwMDEwOmJ0cmZzX2RldmljZV9pbml0X2Rldl9zdGF0
cysweDRjLzB4MWYwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IENvZGU6
IDAxIDAwIDAwIDUzIDQ4IDgzIGVjIDQwIDQ4IDhiIDQ3IDc4IDQ4IDhkIDU0IDI0IDJmIGM2IDQ0
IDI0IDM3IGY5IDQ4IDg5IDQ0IDI0IDM4IDQ4IDhiIDQ3IDM4IDMxIGZmIDQ4IGM3IDQ0IDI0IDJm
IDAwIDAwIDAwIDAwIDw0OD4gOGIgNzAgMzAgZTggMGIgYjQgZmIgZmYgNDEgODkgYzUgODUgYzAg
NzQgNTIgNDkgOGQgODQgMjQgNDAgMDEKRmViIDE3IDExOjI0OjM1IGxvY2FsaG9zdC1saXZlIGtl
cm5lbDogUlNQOiAwMDE4OmZmZmZhNjAyODVmYmZiNjggRUZMQUdTOiAwMDAxMDI0NgpGZWIgMTcg
MTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJY
OiBmZmZmODhiODhmODA2NDk4IFJDWDogZmZmZjg4YjgyZTdhMmExMApGZWIgMTcgMTE6MjQ6MzUg
bG9jYWxob3N0LWxpdmUga2VybmVsOiBSRFg6IGZmZmZhNjAyODVmYmZiOTcgUlNJOiBmZmZmODhi
ODJlN2EyYTEwIFJESTogMDAwMDAwMDAwMDAwMDAwMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0
LWxpdmUga2VybmVsOiBSQlA6IGZmZmY4OGI4OGY4MDZiM2MgUjA4OiAwMDAwMDAwMDAwMDAwMDAw
IFIwOTogMDAwMDAwMDAwMDAwMDAwMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2Vy
bmVsOiBSMTA6IGZmZmY4OGI4MmU3YTJhMTAgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZm
Zjg4Yjg4ZjgwNmEwMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBSMTM6
IGZmZmY4OGI4OGY4MDY0NzggUjE0OiBmZmZmODhiODhmODA2YTAwIFIxNTogZmZmZjg4YjgyZTdh
MmExMApGZWIgMTcgMTE6MjQ6MzUgbG9jYWxob3N0LWxpdmUga2VybmVsOiBGUzogIDAwMDA3ZjY5
OGJlMWVjNDAoMDAwMCkgR1M6ZmZmZjg4YjkzN2UwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAw
MDAwMDAwCkZlYiAxNyAxMToyNDozNSBsb2NhbGhvc3QtbGl2ZSBrZXJuZWw6IENTOiAgMDAxMCBE
UzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKRmViIDE3IDExOjI0OjM1IGxv
Y2FsaG9zdC1saXZlIGtlcm5lbDogQ1IyOiAwMDAwMDAwMDAwMDAwMDMwIENSMzogMDAwMDAwMDA5
MmM5YzAwNiBDUjQ6IDAwMDAwMDAwMDAzNzA2ZjAKCg==
--000000000000adaf9705bb8aba54--
