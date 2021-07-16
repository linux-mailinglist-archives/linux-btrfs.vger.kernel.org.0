Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F583CB97A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 17:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbhGPPQe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhGPPQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 11:16:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F77C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 08:13:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso1012115pjg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuEW9DeYd0At1IOl+goEYOr2A/qTv/dsYWYpSCNhIsk=;
        b=O2f+6UFQSdLp9re61diXDehxn+oZRTCZOykxyS/+h29RUZCs9V/bNMKNN41fXky8cw
         dQI2gX4amMbyTpiXw+hcGYIv5SC4Log8H0RTZ3GKSQM+EjdEsgIrLYIqU22BDz+S3lNY
         Mi4z3s8pkuUVnHgcjQ5vmG04gyyZgQx6TDggYRVdIoiWkEdOJrUJMBAeVTn9pa+MG1Fz
         porMVQfWSbcbwNEGiNnoFnMfeXExX6+uPqaKXWuIT+alFoa15gmbTHVEw38gkRZTOg15
         yRtK90rV9OF8bCYB9BJy4ZM+kys2aOU/T3SdgGOZ9F1ho9R8/encsHPDnptbKMICHwCm
         MxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuEW9DeYd0At1IOl+goEYOr2A/qTv/dsYWYpSCNhIsk=;
        b=Dxl0Lsdk82ZmITST4U1+zeVw2/y2Dw1oqzZOklnw9I1FhgfnzWtPwQAsDgqon7cKGS
         CsoV+rL+YjaSDsYXmDq2HEgRrH/Ey3KF+Sx4V7eUZXv6f0gTGa/RY2oydbFNRmPJ/1xo
         7uRoeKb+XCunv4eSRP2RjXa0/+S2nW9ACPVV1Y2RQN3DmBpnKs1aAokysFtv3PYNXmog
         JmXL5oqxnELBDT5rBz3W+fbSRIRPL3Mp3dJHiuQA0vsqKjbuEGs19SMXDTyJ0Cp+1g+I
         FBQ6mKTVAeqfqi6NUfEH/FedBtuTfVAVS4UogmhZ0DPFR4A9TytzLThGN7KQ68WhGwgf
         Ck6g==
X-Gm-Message-State: AOAM533C01sfJpUdIWTChHRp5EeduiymgHPm8TgborFFm6mRvzDFYkuD
        XAXEctMFfEZ8F1ruWQ84ITMfONqyIQj8CTMCWYE=
X-Google-Smtp-Source: ABdhPJycNn+fJrz9v1Qi5YoFGBivrCRIcp0pGkEYniWJHblwr1Tjz1gMmvZabXoStGR9n4ebtKTwYRLufKcMMubJlPM=
X-Received: by 2002:a17:90a:ce18:: with SMTP id f24mr10323946pju.82.1626448417947;
 Fri, 16 Jul 2021 08:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAKqYf_KZ_fWN55adSCsf6VuaaYa3FSz4XVmE8gL7N45DDO+CBA@mail.gmail.com>
 <98b97dff-c165-92f6-9392-ebea55387814@gmx.com>
In-Reply-To: <98b97dff-c165-92f6-9392-ebea55387814@gmx.com>
From:   bw <bwakkie@gmail.com>
Date:   Fri, 16 Jul 2021 17:13:27 +0200
Message-ID: <CAKqYf_+cyjnhFxpqdx1CU=0mGdagZu_bwOeW7ZesgkF29TTvqQ@mail.gmail.com>
Subject: Re: cannot mount after freeze
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000330fce05c73f08c4"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--000000000000330fce05c73f08c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jul 2021 at 14:26, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/7/16 =E4=B8=8B=E5=8D=887:12, bw wrote:
> > Hello,
> >
> > My raid1 with 3 hdd's that contain /home and /data cannot be mounted
> > after a freeze/restart on the 14 of juli
> >
> > My root / (ubuntu 20.10) is on a raid with 2 ssd's so I can boot but I
> > always end up in rescue mode atm. When disabling the two mounts (/data
> > and /home) in fstab i can log in as root. (had to first change the
> > root password via a rescue usb in order to log in)
>
> /dev/sde has corrupted chunk root, which is pretty rare.
>
> [    8.175417] BTRFS error (device sde): parent transid verify failed on
> 5028524228608 wanted 1427600 found 1429491
> [    8.175729] BTRFS error (device sde): bad tree block start, want
> 5028524228608 have 0
> [    8.175771] BTRFS error (device sde): failed to read chunk root
>
> Chunk tree is the very essential tree, handling the logical bytenr ->
> physical device mapping.
>
> If it has something wrong, it's a big problem.
>
> But normally, such transid error indicates the HDD or the hardware RAID
> controller has something wrong handling barrier/flush command.
> Mostly it means the disk or the hardware controller is lying about its
> FLUSH command.
>
>
> You can try "btrfs rescue chunk-recovery" but I doubt the chance of
> success, as such transid error never just show up in one tree.

For a long time the command was chunk-ing away and had hopes when it
was reporting DONE in two places but then came an error:
~# btrfs rescue chunk-recover /dev/sde
Scanning: DONE in dev0, DONE in dev1, DONE in dev2
parent transid verify failed on 4146261671936 wanted 1427658 found 1439315
parent transid verify failed on 4146261721088 wanted 1427658 found 1439317
parent transid verify failed on 4146236669952 wanted 1427658 found 1439310
parent transid verify failed on 4146174771200 wanted 1427600 found 1439310
parent transid verify failed on 4146258919424 wanted 1427656 found 1439317
parent transid verify failed on 4146238095360 wanted 1427658 found 1439317
parent transid verify failed on 4146260951040 wanted 1427656 found 1439317
parent transid verify failed on 4146266193920 wanted 1427656 found 1439065
parent transid verify failed on 4146067701760 wanted 1427599 found 1439304
parent transid verify failed on 4146246123520 wanted 1427599 found 1439316
parent transid verify failed on 4146246139904 wanted 1427599 found 1439312
parent transid verify failed on 4146246238208 wanted 1427599 found 1439317
parent transid verify failed on 4146246254592 wanted 1427599 found 1439317
parent transid verify failed on 4146246303744 wanted 1427599 found 1439317
parent transid verify failed on 4146246320128 wanted 1427599 found 1439317
parent transid verify failed on 4146246336512 wanted 1427599 found 1439317
parent transid verify failed on 4146246352896 wanted 1427599 found 1438647
parent transid verify failed on 4146246369280 wanted 1427599 found 1439312
parent transid verify failed on 4146237063168 wanted 1427604 found 1439314
parent transid verify failed on 4146236637184 wanted 1427603 found 1439316
parent transid verify failed on 4146260754432 wanted 1427604 found 1439317
parent transid verify failed on 4146246516736 wanted 1427599 found 1439317
parent transid verify failed on 4146246533120 wanted 1427599 found 1439065
parent transid verify failed on 4146268749824 wanted 1427602 found 1439316
parent transid verify failed on 5141904293888 wanted 1419828 found 1439215
parent transid verify failed on 5141904293888 wanted 1419828 found 1439215
parent transid verify failed on 5141904293888 wanted 1419828 found 1439215
Ignoring transid failure
leaf parent key incorrect 5141904293888
ERROR: failed to read block groups: Operation not permitted
open with broken chunk error
Chunk tree recovery failed

... and attached a couple of btrfs checks without doing any dangerous optio=
n


>
>
> Now let's talk about the other device, /dev/sdb.
>
> This is more straightforward:
>
> [    3.165790] ata2.00: exception Emask 0x10 SAct 0x10000 SErr 0x680101
> action 0x6 frozen
> [    3.165846] ata2.00: irq_stat 0x08000000, interface fatal error
> [    3.165892] ata2: SError: { RecovData UnrecovData 10B8B BadCRC Handshk=
 }
> [    3.165940] ata2.00: failed command: READ FPDMA QUEUED
> [    3.165987] ata2.00: cmd 60/f8:80:08:01:00/00:00:00:00:00/40 tag 16
> ncq dma 126976 in
>                          res 40/00:80:08:01:00/00:00:00:00:00/40 Emask
> 0x10 (ATA bus error)
> [    3.166055] ata2.00: status: { DRDY }
>
> Read command just failed, with hardware reporting internal checksum error=
.
>
> This definitely means the device is not working properly.
>
>
> And later we got the even stranger error message:
>
> [    3.571793] sd 1:0:0:0: [sdb] tag#16 FAILED Result: hostbyte=3DDID_OK
> driverbyte=3DDRIVER_SENSE cmd_age=3D0s
> [    3.571848] sd 1:0:0:0: [sdb] tag#16 Sense Key : Illegal Request
> [current]
> [    3.571895] sd 1:0:0:0: [sdb] tag#16 Add. Sense: Unaligned write comma=
nd
> [    3.571943] sd 1:0:0:0: [sdb] tag#16 CDB: Read(10) 28 00 00 00 01 08
> 00 00 f8 00
> [    3.571996] blk_update_request: I/O error, dev sdb, sector 264 op
> 0x0:(READ) flags 0x80700 phys_seg 30 prio class 0
>
> The disk reports it got some unaligned write, but the block layer says
> the operation failed is a READ.
>
> Not sure if the device is really sane.
>
>
> All these disks are the same model, ST2000DM008, I think it should more
> or less indicate there is something wrong in the model...
>
> Recently I have got at least two friends reporting Seagate HDDs have
> various problems.
> Not sure if they are using the same model.
>
> >
> > smartctl seam to say the disks are ok but i'm still unable to mount.
> > scrub doesnt see any errors
>
> Well, you already have /dev/sdb report internal checksum error, aka data
> corruption inside the disk, and your smartctl is report everything fine.
>
> Then I guess the disk is lying again on the smart info.
> (Now I'm more convinced the disk is lying about FLUSH or at least has
> something wrong doing FLUSH).
>
> >
> > I have installed btrfsmaintanance btw.
> >
> > Can anyone advice me which steps to take in order to save the data?
> > There is no backup (yes I'm a fool but was under the impression that
> > with a copy of each file on 2 different disks I'll survive)
>
> For /dev/sdb, I have no idea at all, as we failed to read something from
> the disk, it's a completely disk failure.
>
> For /dev/sde, as mentioned, you can try "btrfs rescue chunk-recovery",
> and then let "btrfs check" to find out what's wrong.
>
> And I'm pretty sure you won't buy the same disks from Seagate next time.
>
> Thanks,
> Qu
> >
> > Attached all(?) important files + a history of my attempts the past
> > days. My attempts from the system rescue usb are not in though.
> >
> > kind regards,
> > Bastiaan
> >

thx,
Bastiaan

--000000000000330fce05c73f08c4
Content-Type: application/octet-stream; name=btrfs_check-Q
Content-Disposition: attachment; filename=btrfs_check-Q
Content-Transfer-Encoding: base64
Content-ID: <f_kr6hcqyg0>
X-Attachment-Id: f_kr6hcqyg0

U2NyaXB0IHN0YXJ0ZWQgb24gMjAyMS0wNy0xNiAxNjo1ODo0OCswMjowMCBbVEVSTT0ibGludXgi
IFRUWT0iL2Rldi90dHkzIiBDT0xVTU5TPSIyMTAiIExJTkVTPSI2NSJdCk9wZW5pbmcgZmlsZXN5
c3RlbSB0byBjaGVjay4uLg0KY2hlY2tzdW0gdmVyaWZ5IGZhaWxlZCBvbiA1MDI4NTI0MjI4NjA4
IGZvdW5kIDAwMDAwMEI2IHdhbnRlZCAwMDAwMDAwMA0KcGFyZW50IHRyYW5zaWQgdmVyaWZ5IGZh
aWxlZCBvbiA1MDI4NTI0MjI4NjA4IHdhbnRlZCAxNDI3NjAwIGZvdW5kIDE0Mjk0OTENCnBhcmVu
dCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gNTAyODUyNDIyODYwOCB3YW50ZWQgMTQyNzYwMCBm
b3VuZCAxNDI5NDkxDQpJZ25vcmluZyB0cmFuc2lkIGZhaWx1cmUNCmNoZWNrc3VtIHZlcmlmeSBm
YWlsZWQgb24gNTAyODUyNDI2MTM3NiBmb3VuZCAwMDAwMDBCNiB3YW50ZWQgMDAwMDAwMDANCmNo
ZWNrc3VtIHZlcmlmeSBmYWlsZWQgb24gNTAyODUyNDI3Nzc2MCBmb3VuZCAwMDAwMDBCNiB3YW50
ZWQgMDAwMDAwMDANCnBhcmVudCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gNTE0MTkwNDI5Mzg4
OCB3YW50ZWQgMTQxOTgyOCBmb3VuZCAxNDM5MjE1DQpwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFp
bGVkIG9uIDUxNDE5MDQyOTM4ODggd2FudGVkIDE0MTk4MjggZm91bmQgMTQzOTIxNQ0KcGFyZW50
IHRyYW5zaWQgdmVyaWZ5IGZhaWxlZCBvbiA1MTQxOTA0MjkzODg4IHdhbnRlZCAxNDE5ODI4IGZv
dW5kIDE0MzkyMTUNCklnbm9yaW5nIHRyYW5zaWQgZmFpbHVyZQ0KbGVhZiBwYXJlbnQga2V5IGlu
Y29ycmVjdCA1MTQxOTA0MjkzODg4DQpFUlJPUjogZmFpbGVkIHRvIHJlYWQgYmxvY2sgZ3JvdXBz
OiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KRVJST1I6IGNhbm5vdCBvcGVuIGZpbGUgc3lzdGVt
DQoKU2NyaXB0IGRvbmUgb24gMjAyMS0wNy0xNiAxNjo1ODo0OCswMjowMCBbQ09NTUFORF9FWElU
X0NPREU9IjEiXQo=
--000000000000330fce05c73f08c4
Content-Type: application/octet-stream; name=btrfs_check-b
Content-Disposition: attachment; filename=btrfs_check-b
Content-Transfer-Encoding: base64
Content-ID: <f_kr6hd2rl1>
X-Attachment-Id: f_kr6hd2rl1

U2NyaXB0IHN0YXJ0ZWQgb24gMjAyMS0wNy0xNiAxNjo1NjoxMCswMjowMCBbVEVSTT0ibGludXgi
IFRUWT0iL2Rldi90dHkzIiBDT0xVTU5TPSIyMTAiIExJTkVTPSI2NSJdCk9wZW5pbmcgZmlsZXN5
c3RlbSB0byBjaGVjay4uLg0KY2hlY2tzdW0gdmVyaWZ5IGZhaWxlZCBvbiA1MDI4NTI0MjI4NjA4
IGZvdW5kIDAwMDAwMEI2IHdhbnRlZCAwMDAwMDAwMA0KcGFyZW50IHRyYW5zaWQgdmVyaWZ5IGZh
aWxlZCBvbiA1MDI4NTI0MjI4NjA4IHdhbnRlZCAxNDI3NjAwIGZvdW5kIDE0Mjk0OTENCnBhcmVu
dCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gNTAyODUyNDIyODYwOCB3YW50ZWQgMTQyNzYwMCBm
b3VuZCAxNDI5NDkxDQpJZ25vcmluZyB0cmFuc2lkIGZhaWx1cmUNCmNoZWNrc3VtIHZlcmlmeSBm
YWlsZWQgb24gNTAyODUyNDI2MTM3NiBmb3VuZCAwMDAwMDBCNiB3YW50ZWQgMDAwMDAwMDANCmNo
ZWNrc3VtIHZlcmlmeSBmYWlsZWQgb24gNTAyODUyNDI3Nzc2MCBmb3VuZCAwMDAwMDBCNiB3YW50
ZWQgMDAwMDAwMDANCnBhcmVudCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gNTE0MTkwNDI5Mzg4
OCB3YW50ZWQgMTQxOTgyOCBmb3VuZCAxNDM5MjE1DQpwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFp
bGVkIG9uIDUxNDE5MDQyOTM4ODggd2FudGVkIDE0MTk4MjggZm91bmQgMTQzOTIxNQ0KcGFyZW50
IHRyYW5zaWQgdmVyaWZ5IGZhaWxlZCBvbiA1MTQxOTA0MjkzODg4IHdhbnRlZCAxNDE5ODI4IGZv
dW5kIDE0MzkyMTUNCklnbm9yaW5nIHRyYW5zaWQgZmFpbHVyZQ0KbGVhZiBwYXJlbnQga2V5IGlu
Y29ycmVjdCA1MTQxOTA0MjkzODg4DQpFUlJPUjogZmFpbGVkIHRvIHJlYWQgYmxvY2sgZ3JvdXBz
OiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KRVJST1I6IGNhbm5vdCBvcGVuIGZpbGUgc3lzdGVt
DQoKU2NyaXB0IGRvbmUgb24gMjAyMS0wNy0xNiAxNjo1NjoxMSswMjowMCBbQ09NTUFORF9FWElU
X0NPREU9IjEiXQo=
--000000000000330fce05c73f08c4
Content-Type: application/octet-stream; name=btrfs_check-data-csum
Content-Disposition: attachment; filename=btrfs_check-data-csum
Content-Transfer-Encoding: base64
Content-ID: <f_kr6hd2ru2>
X-Attachment-Id: f_kr6hd2ru2

U2NyaXB0IHN0YXJ0ZWQgb24gMjAyMS0wNy0xNiAxNjo1NzowOCswMjowMCBbVEVSTT0ibGludXgi
IFRUWT0iL2Rldi90dHkzIiBDT0xVTU5TPSIyMTAiIExJTkVTPSI2NSJdCk9wZW5pbmcgZmlsZXN5
c3RlbSB0byBjaGVjay4uLg0KY2hlY2tzdW0gdmVyaWZ5IGZhaWxlZCBvbiA1MDI4NTI0MjI4NjA4
IGZvdW5kIDAwMDAwMEI2IHdhbnRlZCAwMDAwMDAwMA0KcGFyZW50IHRyYW5zaWQgdmVyaWZ5IGZh
aWxlZCBvbiA1MDI4NTI0MjI4NjA4IHdhbnRlZCAxNDI3NjAwIGZvdW5kIDE0Mjk0OTENCnBhcmVu
dCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gNTAyODUyNDIyODYwOCB3YW50ZWQgMTQyNzYwMCBm
b3VuZCAxNDI5NDkxDQpJZ25vcmluZyB0cmFuc2lkIGZhaWx1cmUNCmNoZWNrc3VtIHZlcmlmeSBm
YWlsZWQgb24gNTAyODUyNDI2MTM3NiBmb3VuZCAwMDAwMDBCNiB3YW50ZWQgMDAwMDAwMDANCmNo
ZWNrc3VtIHZlcmlmeSBmYWlsZWQgb24gNTAyODUyNDI3Nzc2MCBmb3VuZCAwMDAwMDBCNiB3YW50
ZWQgMDAwMDAwMDANCnBhcmVudCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gNTE0MTkwNDI5Mzg4
OCB3YW50ZWQgMTQxOTgyOCBmb3VuZCAxNDM5MjE1DQpwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFp
bGVkIG9uIDUxNDE5MDQyOTM4ODggd2FudGVkIDE0MTk4MjggZm91bmQgMTQzOTIxNQ0KcGFyZW50
IHRyYW5zaWQgdmVyaWZ5IGZhaWxlZCBvbiA1MTQxOTA0MjkzODg4IHdhbnRlZCAxNDE5ODI4IGZv
dW5kIDE0MzkyMTUNCklnbm9yaW5nIHRyYW5zaWQgZmFpbHVyZQ0KbGVhZiBwYXJlbnQga2V5IGlu
Y29ycmVjdCA1MTQxOTA0MjkzODg4DQpFUlJPUjogZmFpbGVkIHRvIHJlYWQgYmxvY2sgZ3JvdXBz
OiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KRVJST1I6IGNhbm5vdCBvcGVuIGZpbGUgc3lzdGVt
DQoKU2NyaXB0IGRvbmUgb24gMjAyMS0wNy0xNiAxNjo1NzowOSswMjowMCBbQ09NTUFORF9FWElU
X0NPREU9IjEiXQo=
--000000000000330fce05c73f08c4
Content-Type: application/octet-stream; name=btrfs_check-s
Content-Disposition: attachment; filename=btrfs_check-s
Content-Transfer-Encoding: base64
Content-ID: <f_kr6hd2sh4>
X-Attachment-Id: f_kr6hd2sh4

U2NyaXB0IHN0YXJ0ZWQgb24gMjAyMS0wNy0xNiAxNjo1OTo0NiswMjowMCBbVEVSTT0ibGludXgi
IFRUWT0iL2Rldi90dHkzIiBDT0xVTU5TPSIyMTAiIExJTkVTPSI2NSJdCnVzaW5nIFNCIGNvcHkg
MiwgYnl0ZW5yIDI3NDg3NzkwNjk0NA0KT3BlbmluZyBmaWxlc3lzdGVtIHRvIGNoZWNrLi4uDQpj
aGVja3N1bSB2ZXJpZnkgZmFpbGVkIG9uIDUwMjg1MjQyMjg2MDggZm91bmQgMDAwMDAwQjYgd2Fu
dGVkIDAwMDAwMDAwDQpwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFpbGVkIG9uIDUwMjg1MjQyMjg2
MDggd2FudGVkIDE0Mjc2MDAgZm91bmQgMTQyOTQ5MQ0KcGFyZW50IHRyYW5zaWQgdmVyaWZ5IGZh
aWxlZCBvbiA1MDI4NTI0MjI4NjA4IHdhbnRlZCAxNDI3NjAwIGZvdW5kIDE0Mjk0OTENCklnbm9y
aW5nIHRyYW5zaWQgZmFpbHVyZQ0KY2hlY2tzdW0gdmVyaWZ5IGZhaWxlZCBvbiA1MDI4NTI0MjYx
Mzc2IGZvdW5kIDAwMDAwMEI2IHdhbnRlZCAwMDAwMDAwMA0KY2hlY2tzdW0gdmVyaWZ5IGZhaWxl
ZCBvbiA1MDI4NTI0Mjc3NzYwIGZvdW5kIDAwMDAwMEI2IHdhbnRlZCAwMDAwMDAwMA0KcGFyZW50
IHRyYW5zaWQgdmVyaWZ5IGZhaWxlZCBvbiA1MTQxOTA0MjkzODg4IHdhbnRlZCAxNDE5ODI4IGZv
dW5kIDE0MzkyMTUNCnBhcmVudCB0cmFuc2lkIHZlcmlmeSBmYWlsZWQgb24gNTE0MTkwNDI5Mzg4
OCB3YW50ZWQgMTQxOTgyOCBmb3VuZCAxNDM5MjE1DQpwYXJlbnQgdHJhbnNpZCB2ZXJpZnkgZmFp
bGVkIG9uIDUxNDE5MDQyOTM4ODggd2FudGVkIDE0MTk4MjggZm91bmQgMTQzOTIxNQ0KSWdub3Jp
bmcgdHJhbnNpZCBmYWlsdXJlDQpsZWFmIHBhcmVudCBrZXkgaW5jb3JyZWN0IDUxNDE5MDQyOTM4
ODgNCkVSUk9SOiBmYWlsZWQgdG8gcmVhZCBibG9jayBncm91cHM6IE9wZXJhdGlvbiBub3QgcGVy
bWl0dGVkDQpFUlJPUjogY2Fubm90IG9wZW4gZmlsZSBzeXN0ZW0NCgpTY3JpcHQgZG9uZSBvbiAy
MDIxLTA3LTE2IDE2OjU5OjQ2KzAyOjAwIFtDT01NQU5EX0VYSVRfQ09ERT0iMSJdCg==
--000000000000330fce05c73f08c4
Content-Type: application/octet-stream; name=btrfs_check-r
Content-Disposition: attachment; filename=btrfs_check-r
Content-Transfer-Encoding: base64
Content-ID: <f_kr6hd2s53>
X-Attachment-Id: f_kr6hd2s53

U2NyaXB0IHN0YXJ0ZWQgb24gMjAyMS0wNy0xNiAxNjo1ODoyMyswMjowMCBbVEVSTT0ibGludXgi
IFRUWT0iL2Rldi90dHkzIiBDT0xVTU5TPSIyMTAiIExJTkVTPSI2NSJdCkVSUk9SOiAvZGV2L3Nk
ZSBpcyBub3QgYSB2YWxpZCBudW1lcmljIHZhbHVlLg0KClNjcmlwdCBkb25lIG9uIDIwMjEtMDct
MTYgMTY6NTg6MjMrMDI6MDAgW0NPTU1BTkRfRVhJVF9DT0RFPSIxIl0K
--000000000000330fce05c73f08c4--
