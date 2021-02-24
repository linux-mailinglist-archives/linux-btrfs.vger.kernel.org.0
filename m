Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421F93240DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 16:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbhBXPcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 10:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbhBXOYx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 09:24:53 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC15C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 06:23:50 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id m9so1992256ybk.8
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 06:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5d19svuVAOdOc5Ry8cy+lRQcs+7ySphJoQ8OePYdpk=;
        b=QOKUHRhSUilg4gmZHKuWgEKPv539iuk4BwPk6uRg6cBuB8vLQ/Dv18+FW0KJeisBsA
         SyuWWYA/hI/0uciXmhp0uQVUVLcvwNHFwsmV/ozH5tEbQ/ZqHVuBRmA2oNbrZhrPDVRt
         AmzNA5oV1E8JQMIUKtdlbPg/Smv/FVlYS6W2JtRkM6hB995vbJ0PxqYzex/iklZ1V8o8
         Itg7XzyO0LYIEP8TzPNVCtQrId7jbwZo9qCviq7C+8Zvl23FLxwdMlTczoOtsPFgRaCA
         yNpBGRC/VzTX/QrPLlThVGkkVDOVqB2LjMjVEFmXMnJvTVgOQpcFbZb8aigx7k8ykJx2
         IfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5d19svuVAOdOc5Ry8cy+lRQcs+7ySphJoQ8OePYdpk=;
        b=HPNaddK9XGqA/SlzRbayuW34MS+ZdhsTlkVU54imzuNbUcoIAvzdMDRZwQvEmzWOmP
         c29jYyqSawKgkfXWoLtykjNz7yCqFe053JLT5ePcSmao9FQmDWaFRjEHXSTIUvKq37Jp
         KWTslTdi2TugRXbj6TcXqj9FTThnFwhz6vQZsPo1Y8smf5E/hrBsRi1uoVETsNUM6vcm
         hJ3WWsbrhbh4KgMx5G7YuAE1s707ihg4TRohTv9ZbQcIDNKI77jiVZ9ShJl5tAy38Cu+
         HY6JwraMzPv/R0vrPHa1RmJCw4is+RrtDnKIMALPC/T+OcAX9I8kmBdEyy+T6w1xL0F6
         qWDw==
X-Gm-Message-State: AOAM532PN2ceu5viPXVkZAPW5sUE/pKvzDfoXAVt0Zvu54mMiu0WokLc
        TNv8W5Z564PUq3Aioo58/Xcqz0J3+RTr+E40+QE=
X-Google-Smtp-Source: ABdhPJxfhm6whgMlxESQQ4i79+5fv6ZYkCVNlCDrHP2BUDax3Ywu2sGHniI1tXIggQ4k3+3peGfpOTnK5sDFJ2vzgF8=
X-Received: by 2002:a5b:847:: with SMTP id v7mr18282828ybq.354.1614176628994;
 Wed, 24 Feb 2021 06:23:48 -0800 (PST)
MIME-Version: 1.0
References: <CAEg-Je-DJW3saYKA2OBLwgyLU6j0JOF7NzXzECi0HJ5hft_5=A@mail.gmail.com>
 <0c4701b2-23ef-fd7a-d198-258b49eedea8@toxicpanda.com> <CAEg-Je9NGV0Mvhw7v8CwcyAZ9zd9T5Fmk2iQyZ1PFWVUOXaP+Q@mail.gmail.com>
 <90da9117-6b02-3c27-17a0-ff497eb04496@toxicpanda.com> <CAEg-Je-zRWrkKOQM-Y_Y17eHhUrJe+d1_H9iLzQB4w7T+Een=w@mail.gmail.com>
 <74ca64e1-3933-c12b-644a-21745cf2d849@toxicpanda.com> <CAEg-Je9FZhLMx0MuxhyhTDUsRzfbi2_VZsHa3Bs+46jY8F82ZA@mail.gmail.com>
 <ab38ba5a-f684-0634-c5d8-d317541e37b9@toxicpanda.com> <CAEg-Je-cxaM3SuoLfHL6cGv0-0r7s-hccS4ixs66oO6YYOtbwg@mail.gmail.com>
 <56747283-fe34-51c5-9dbf-930bdafffaed@toxicpanda.com> <CAEg-Je_=jUMJfAqwtuZwcPE4+HOAJB7JC5gKSw4EeZrutxk5kA@mail.gmail.com>
 <58f4fe54-a462-b256-df60-17b1084235f6@toxicpanda.com> <CAEg-Je-_r3_AsLHa_HDDOUwVs+Jtty5roFvEyF4K-T2D7oEayA@mail.gmail.com>
 <58246f4c-4e26-c89c-a589-376cfe23d783@toxicpanda.com> <CAEg-Je-yPqueyW3JqSWrAE_9ckc1KTyaNoFwjbozNLrvb7_tEg@mail.gmail.com>
 <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com>
In-Reply-To: <a9561d44-24a3-fa87-e292-98feb4846ab9@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 24 Feb 2021 09:23:12 -0500
Message-ID: <CAEg-Je8o2GiAH2wC9DXiMdMSCFnAjeV6UH-qaobk_0qYLNsPsQ@mail.gmail.com>
Subject: Re: Recovering Btrfs from a freak failure of the disk controller
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000939a8b05bc15c88e"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000939a8b05bc15c88e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 10:05 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/22/21 11:03 PM, Neal Gompa wrote:
> > On Mon, Feb 22, 2021 at 2:34 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> On 2/21/21 1:27 PM, Neal Gompa wrote:
> >>> On Wed, Feb 17, 2021 at 11:44 AM Josef Bacik <josef@toxicpanda.com> w=
rote:
> >>>>
> >>>> On 2/17/21 11:29 AM, Neal Gompa wrote:
> >>>>> On Wed, Feb 17, 2021 at 9:59 AM Josef Bacik <josef@toxicpanda.com> =
wrote:
> >>>>>>
> >>>>>> On 2/17/21 9:50 AM, Neal Gompa wrote:
> >>>>>>> On Wed, Feb 17, 2021 at 9:36 AM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >>>>>>>>
> >>>>>>>> On 2/16/21 9:05 PM, Neal Gompa wrote:
> >>>>>>>>> On Tue, Feb 16, 2021 at 4:24 PM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2/16/21 3:29 PM, Neal Gompa wrote:
> >>>>>>>>>>> On Tue, Feb 16, 2021 at 1:11 PM Josef Bacik <josef@toxicpanda=
.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2/16/21 11:27 AM, Neal Gompa wrote:
> >>>>>>>>>>>>> On Tue, Feb 16, 2021 at 10:19 AM Josef Bacik <josef@toxicpa=
nda.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2/14/21 3:25 PM, Neal Gompa wrote:
> >>>>>>>>>>>>>>> Hey all,
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> So one of my main computers recently had a disk controlle=
r failure
> >>>>>>>>>>>>>>> that caused my machine to freeze. After rebooting, Btrfs =
refuses to
> >>>>>>>>>>>>>>> mount. I tried to do a mount and the following errors sho=
w up in the
> >>>>>>>>>>>>>>> journal:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (devic=
e sda3): disk space caching is enabled
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS info (devic=
e sda3): has skinny extents
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (d=
evice sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203=
657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (devi=
ce sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS critical (d=
evice sda3): corrupt leaf: root=3D401 block=3D796082176 slot=3D15 ino=3D203=
657, invalid inode transid: has 888896 expect [0, 888895]
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (devi=
ce sda3): block=3D796082176 read time tree block corruption detected
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS warning (de=
vice sda3): couldn't read tree root
> >>>>>>>>>>>>>>>> Feb 14 15:20:49 localhost-live kernel: BTRFS error (devi=
ce sda3): open_ctree failed
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I've tried to do -o recovery,ro mount and get the same is=
sue. I can't
> >>>>>>>>>>>>>>> seem to find any reasonably good information on how to do=
 recovery in
> >>>>>>>>>>>>>>> this scenario, even to just recover enough to copy data o=
ff.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> I'm on Fedora 33, the system was on Linux kernel version =
5.9.16 and
> >>>>>>>>>>>>>>> the Fedora 33 live ISO I'm using has Linux kernel version=
 5.10.14. I'm
> >>>>>>>>>>>>>>> using btrfs-progs v5.10.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Can anyone help?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Can you try
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> btrfs check --clear-space-cache v1 /dev/whatever
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> That should fix the inode generation thing so it's sane, a=
nd then the tree
> >>>>>>>>>>>>>> checker will allow the fs to be read, hopefully.  If not w=
e can work out some
> >>>>>>>>>>>>>> other magic.  Thanks,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Josef
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I got the same error as I did with btrfs-check --readonly..=
.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Oh lovely, what does btrfs check --readonly --backup do?
> >>>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> No dice...
> >>>>>>>>>>>
> >>>>>>>>>>> # btrfs check --readonly --backup /dev/sda3
> >>>>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 foun=
d 888895
> >>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 foun=
d 888895
> >>>>>>>>>>>> parent transid verify failed on 791281664 wanted 888893 foun=
d 888895
> >>>>>>>>>>
> >>>>>>>>>> Hey look the block we're looking for, I wrote you some magic, =
just pull
> >>>>>>>>>>
> >>>>>>>>>> https://github.com/josefbacik/btrfs-progs/tree/for-neal
> >>>>>>>>>>
> >>>>>>>>>> build, and then run
> >>>>>>>>>>
> >>>>>>>>>> btrfs-neal-magic /dev/sda3 791281664 888895
> >>>>>>>>>>
> >>>>>>>>>> This will force us to point at the old root with (hopefully) t=
he right bytenr
> >>>>>>>>>> and gen, and then hopefully you'll be able to recover from the=
re.  This is kind
> >>>>>>>>>> of saucy, so yolo, but I can undo it if it makes things worse.=
  Thanks,
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> # btrfs check --readonly /dev/sda3
> >>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>> # btrfs check --clear-space-cache v1 /dev/sda3
> >>>>>>>>>> Opening filesystem to check...
> >>>>>>>>>> ERROR: could not setup extent tree
> >>>>>>>>>> ERROR: cannot open file system
> >>>>>>>>>
> >>>>>>>>> It's better, but still no dice... :(
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Hmm it's not telling us what's wrong with the extent tree, which=
 is annoying.
> >>>>>>>> Does mount -o rescue=3Dall,ro work now that the root tree is nor=
mal?  Thanks,
> >>>>>>>>
> >>>>>>>
> >>>>>>> Nope, I see this in the journal:
> >>>>>>>
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3):=
 enabling all of the rescue options
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3):=
 ignoring data csums
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3):=
 ignoring bad roots
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3):=
 disabling log replay at mount time
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3):=
 disk space caching is enabled
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS info (device sda3):=
 has skinny extents
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3)=
: tree level mismatch detected, bytenr=3D791281664 level expected=3D1 has=
=3D2
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3)=
: tree level mismatch detected, bytenr=3D791281664 level expected=3D1 has=
=3D2
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS warning (device sda=
3): couldn't read tree root
> >>>>>>>> Feb 17 09:49:40 localhost-live kernel: BTRFS error (device sda3)=
: open_ctree failed
> >>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>> Ok git pull for-neal, rebuild, then run
> >>>>>>
> >>>>>> btrfs-neal-magic /dev/sda3 791281664 888895 2
> >>>>>>
> >>>>>> I thought of this yesterday but in my head was like "naaahhhh, wha=
ts the chances
> >>>>>> that the level doesn't match??".  Thanks,
> >>>>>>
> >>>>>
> >>>>> Tried rescue mount again after running that and got a stack trace i=
n
> >>>>> the kernel, detailed in the following attached log.
> >>>>
> >>>> Huh I wonder how I didn't hit this when testing, I must have only te=
sted with
> >>>> zero'ing the extent root and the csum root.  You're going to have to=
 build a
> >>>> kernel with a fix for this
> >>>>
> >>>> https://paste.centos.org/view/7b48aaea
> >>>>
> >>>> and see if that gets you further.  Thanks,
> >>>>
> >>>
> >>> I built a kernel build as an RPM with your patch[1] and tried it.
> >>>
> >>> [root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sdb3 /mnt
> >>> Killed
> >>>
> >>> The log from the journal is attached.
> >>
> >>
> >> Ahh crud my bad, this should do it
> >>
> >> https://paste.centos.org/view/ac2e61ef
> >>
> >
> > Patch doesn't apply (note it is patch 667 below):
>
> Ah sorry, should have just sent you an iterative patch.  You can take the=
 above
> patch and just delete the hunk from volumes.c as you already have that ap=
plied
> and then it'll work.  Thanks,
>

Failed with a weird error...?

[root@fedora ~]# mount -t btrfs -o rescue=3Dall,ro /dev/sda3 /mnt
mount: /mnt: mount(2) system call failed: No such file or directory.

Journal log with traceback attached.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

--000000000000939a8b05bc15c88e
Content-Type: text/x-log; charset="US-ASCII"; name="output-clean2.log"
Content-Disposition: attachment; filename="output-clean2.log"
Content-Transfer-Encoding: base64
Content-ID: <f_kljj1u6f0>
X-Attachment-Id: f_kljj1u6f0

RmViIDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6IEJUUkZTIGluZm8gKGRldmljZSBzZGEzKTog
ZW5hYmxpbmcgYWxsIG9mIHRoZSByZXNjdWUgb3B0aW9ucwpGZWIgMjQgMDk6MTI6NDEgZmVkb3Jh
IGtlcm5lbDogQlRSRlMgaW5mbyAoZGV2aWNlIHNkYTMpOiBpZ25vcmluZyBkYXRhIGNzdW1zCkZl
YiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhMyk6IGln
bm9yaW5nIGJhZCByb290cwpGZWIgMjQgMDk6MTI6NDEgZmVkb3JhIGtlcm5lbDogQlRSRlMgaW5m
byAoZGV2aWNlIHNkYTMpOiBkaXNhYmxpbmcgbG9nIHJlcGxheSBhdCBtb3VudCB0aW1lCkZlYiAy
NCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiBCVFJGUyBpbmZvIChkZXZpY2Ugc2RhMyk6IGRpc2sg
c3BhY2UgY2FjaGluZyBpcyBlbmFibGVkCkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiBC
VFJGUyBpbmZvIChkZXZpY2Ugc2RhMyk6IGhhcyBza2lubnkgZXh0ZW50cwpGZWIgMjQgMDk6MTI6
NDEgZmVkb3JhIGtlcm5lbDogd2UgdHJpZWQgdG8gc2VhcmNoIHdpdGggYSBOVUxMIHJvb3QKRmVi
IDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6IENQVTogMCBQSUQ6IDE3NjAgQ29tbTogbW91bnQg
Tm90IHRhaW50ZWQgNS4xMS4wLTE1NS5uZWFsYnRyZnN0ZXN0LjEuZmMzNC54ODZfNjQgIzEKRmVi
IDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6IEhhcmR3YXJlIG5hbWU6IFZNd2FyZSwgSW5jLiBW
TXdhcmUgVmlydHVhbCBQbGF0Zm9ybS80NDBCWCBEZXNrdG9wIFJlZmVyZW5jZSBQbGF0Zm9ybSwg
QklPUyA2LjAwIDA3LzIyLzIwMjAKRmViIDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6IENhbGwg
VHJhY2U6CkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiAgZHVtcF9zdGFjaysweDZiLzB4
ODMKRmViIDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6ICBidHJmc19zZWFyY2hfc2xvdC5jb2xk
KzB4MTEvMHgxYgpGZWIgMjQgMDk6MTI6NDEgZmVkb3JhIGtlcm5lbDogID8gYnRyZnNfaW5pdF9k
ZXZfcmVwbGFjZSsweDM2LzB4NDUwCkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiAgYnRy
ZnNfaW5pdF9kZXZfcmVwbGFjZSsweDcxLzB4NDUwCkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2Vy
bmVsOiAgb3Blbl9jdHJlZSsweDEwNTQvMHgxNjEwCkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2Vy
bmVsOiAgYnRyZnNfbW91bnRfcm9vdC5jb2xkKzB4MTMvMHhmYQpGZWIgMjQgMDk6MTI6NDEgZmVk
b3JhIGtlcm5lbDogIGxlZ2FjeV9nZXRfdHJlZSsweDI3LzB4NDAKRmViIDI0IDA5OjEyOjQxIGZl
ZG9yYSBrZXJuZWw6ICB2ZnNfZ2V0X3RyZWUrMHgyNS8weGIwCkZlYiAyNCAwOToxMjo0MSBmZWRv
cmEga2VybmVsOiAgdmZzX2tlcm5fbW91bnQucGFydC4wKzB4NzEvMHhiMApGZWIgMjQgMDk6MTI6
NDEgZmVkb3JhIGtlcm5lbDogIGJ0cmZzX21vdW50KzB4MTMxLzB4M2QwCkZlYiAyNCAwOToxMjo0
MSBmZWRvcmEga2VybmVsOiAgPyBsZWdhY3lfZ2V0X3RyZWUrMHgyNy8weDQwCkZlYiAyNCAwOTox
Mjo0MSBmZWRvcmEga2VybmVsOiAgPyBidHJmc19zaG93X29wdGlvbnMrMHg2NDAvMHg2NDAKRmVi
IDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6ICBsZWdhY3lfZ2V0X3RyZWUrMHgyNy8weDQwCkZl
YiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiAgdmZzX2dldF90cmVlKzB4MjUvMHhiMApGZWIg
MjQgMDk6MTI6NDEgZmVkb3JhIGtlcm5lbDogIHBhdGhfbW91bnQrMHg0NDEvMHhhODAKRmViIDI0
IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6ICBfX3g2NF9zeXNfbW91bnQrMHhmNC8weDEzMApGZWIg
MjQgMDk6MTI6NDEgZmVkb3JhIGtlcm5lbDogIGRvX3N5c2NhbGxfNjQrMHgzMy8weDQwCkZlYiAy
NCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NDQvMHhhOQpGZWIgMjQgMDk6MTI6NDEgZmVkb3JhIGtlcm5lbDogUklQOiAwMDMzOjB4N2Y2
NDQ3MzAzNTJlCkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiBDb2RlOiA0OCA4YiAwZCA0
NSAxOSAwYyAwMCBmNyBkOCA2NCA4OSAwMSA0OCA4MyBjOCBmZiBjMyA2NiAyZSAwZiAxZiA4NCAw
MCAwMCAwMCAwMCAwMCA5MCBmMyAwZiAxZSBmYSA0OSA4OSBjYSBiOCBhNSAwMCAwMCAwMCAwZiAw
NSA8NDg+IDNkIDAxIGYwIGZmIGZmIDczIDAxIGMzIDQ4IDhiIDBkIDEyIDE5IDBjIDAwIGY3IGQ4
IDY0IDg5IDAxIDQ4CkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiBSU1A6IDAwMmI6MDAw
MDdmZmQzMzhiZmFjOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMGE1
CkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJY
OiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDdmNjQ0NzMwMzUyZQpGZWIgMjQgMDk6MTI6NDEg
ZmVkb3JhIGtlcm5lbDogUkRYOiAwMDAwNTVkNGM2OTgzNjkwIFJTSTogMDAwMDU1ZDRjNjk4Mzcz
MCBSREk6IDAwMDA1NWQ0YzY5ODM2YjAKRmViIDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6IFJC
UDogMDAwMDU1ZDRjNjk4MzQ2MCBSMDg6IDAwMDA1NWQ0YzY5ODM2ZjAgUjA5OiAwMDAwN2Y2NDQ3
M2M1YTYwCkZlYiAyNCAwOToxMjo0MSBmZWRvcmEga2VybmVsOiBSMTA6IDAwMDAwMDAwMDAwMDAw
MDEgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDAwMDAwMDAwMDAwMApGZWIgMjQgMDk6
MTI6NDEgZmVkb3JhIGtlcm5lbDogUjEzOiAwMDAwNTVkNGM2OTgzNmIwIFIxNDogMDAwMDU1ZDRj
Njk4MzY5MCBSMTU6IDAwMDA1NWQ0YzY5ODM0NjAKRmViIDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJu
ZWw6IEJUUkZTIHdhcm5pbmcgKGRldmljZSBzZGEzKTogZmFpbGVkIHRvIHJlYWQgZnMgdHJlZTog
LTIKRmViIDI0IDA5OjEyOjQxIGZlZG9yYSBrZXJuZWw6IEJUUkZTIGVycm9yIChkZXZpY2Ugc2Rh
Myk6IG9wZW5fY3RyZWUgZmFpbGVkCgo=
--000000000000939a8b05bc15c88e--
