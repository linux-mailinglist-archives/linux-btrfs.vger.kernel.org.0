Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805332DE234
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Dec 2020 12:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgLRLpV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Dec 2020 06:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgLRLpU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Dec 2020 06:45:20 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79CC0617B0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 03:44:40 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id h4so1667414qkk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Dec 2020 03:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=d50JyjYh368M+p9gg0W5ucVOCUocVp8FfiT3MSiu7hE=;
        b=MP79qloVOl5VkZ5hO/HuA8EjAYXCim59fCNghJ5SVPlZxcEHHacJTsqp7Ukt3O23tm
         81CwqJ9n62BLrq9pN2S+ZJ+bwNQqUVBEE+qP22aV7D9fZwr3IuCe6u7zLuN8EnQ3wPdi
         Lm8jDI/OxHrvWLe+dpmHAduN91Bk8gUr73BeP9sGN5XDQJH77zfjYYIRWfcuNXpT0SYw
         Mr9hE0WG6Kx7ae2LrRs+PhppRVGqZnDV311JbCa+zJi37JviZgfsY6U4xWsmN49/kmJ0
         w7xuCNpBNxoIGCdi38KTsJAla8cpuSYOU2B9zcs7EooBO7Sg8CVch0DGVMecAJSSGu3w
         Ai1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=d50JyjYh368M+p9gg0W5ucVOCUocVp8FfiT3MSiu7hE=;
        b=i2D+iI/WTAIhAtpFtWOvmZh/hDzztBUAs4JKx8aT01kNeM33XCy3YQL1nRkrwqfPWT
         +X2jEOx0zvzJi31X0UKDwob0go0oiLTRhTTsEZx3fb+rxZTxrLXl0AQbommzEhP1k95M
         CqVCTm5aXNGnvLd5NmtBV4F1nOvffuHFl4CejcLy6a0qlUBraHdr97X2jjFtq+RfPBmd
         +QlZDJj9ZGmMv6/ee4tmsD8RLOWo+m5N7gZmLnS4ie3T5x8hO7MZKETG68FDp7GfDUx6
         7yzlI04SQzWK1i0Vx3O6he+AUe9YUaiGlu5td1PCdqEZaNfz5KHDVAxpPqqyl8wRH8B9
         lXcw==
X-Gm-Message-State: AOAM531rWFXv/XWzs+aRZQitOSmG4kLZa65aOif1xZ7UKeRRnV5fk7q2
        9saIOeQm8ScZhAFjNlsmcssZNfKKGnXVV4xipnM=
X-Google-Smtp-Source: ABdhPJzDBm7hh5+2KCtXhIC2ktq795qQC2f638oOBD9Rn/GF1sHSVequKrQmeRw4m9SvHRf9EJM2TRUWvFak7WwLLlU=
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr4146086qkg.479.1608291879950;
 Fri, 18 Dec 2020 03:44:39 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
 <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
 <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net> <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
 <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net> <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
 <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net> <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
 <c0aa48c7db8c00efe8dd9a2c72c425ffe57df49c.camel@gmx.net> <CAL3q7H7LCaRE_28RRY0zfHiJo5G1EkDHKCuue3-052AeuXmG4w@mail.gmail.com>
 <cd8e521bcf1e8d999d39ddae61b61fc45492e2c8.camel@gmx.net>
In-Reply-To: <cd8e521bcf1e8d999d39ddae61b61fc45492e2c8.camel@gmx.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 18 Dec 2020 11:44:28 +0000
Message-ID: <CAL3q7H7EoyQ+_kf0R04TwDZHSWnDH6fojYviryYTjgPuRc4HfA@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 18, 2020 at 7:25 AM Massimo B. <massimo.b@gmx.net> wrote:
>
> On Mon, 2020-12-14 at 09:46 +0000, Filipe Manana wrote:
>
> > clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYNC/=
....pdf
> > > source offset=3D20705280 offset=3D20709376 length=3D4096
> > > clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYN=
C/....pdf
> > > source offset=3D20713472 offset=3D20713472 length=3D4096
> > > ERROR: failed to clone extents to mb/Documents.AZ/0.SYNC/....pdf: Inv=
alid
> > > argument
> >
> > It's a different problem. This one because the kernel is sending an
> > invalid clone operation - the source and destination offsets are the
> > same, which makes the receiver fail.
> > Can you tell what's the size (in bytes) of "mb/Documents.AZ/0.SYNC"
> > after the receive fails? Both in the destination and source.
>
> Hi Filipe,
>
> I already deleted the failing subvolume, now I got the issue again. Here =
are the
> detailed information about the file:
>
>
> # btrfs send /mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachines=
.20190621T140904+0200 | mbuffer -v 1 -m 2% | btrfs receive /mnt/local/data/=
snapshots/vm/
> ...
> write IE8 - Win7/IE8 - Win7-disk1.vmdk - offset=3D4742344704 length=3D409=
6
> clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-d=
isk1.vmdk source offset=3D4742184960 offset=3D4742348800 length=3D16384
> clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-d=
isk1.vmdk source offset=3D4742184960 offset=3D4742365184 length=3D28672
> clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-d=
isk1.vmdk source offset=3D4742246400 offset=3D4742393856 length=3D8192
> write IE8 - Win7/IE8 - Win7-disk1.vmdk - offset=3D4742402048 length=3D122=
88
> clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-d=
isk1.vmdk source offset=3D4742410240 offset=3D4742414336 length=3D4096
> clone IE8 - Win7/IE8 - Win7-disk1.vmdk - source=3DIE8 - Win7/IE8 - Win7-d=
isk1.vmdk source offset=3D4742418432 offset=3D4742418432 length=3D4096
> ERROR: failed to clone extents to IE8 - Win7/IE8 - Win7-disk1.vmdk: Inval=
id argument
>
> summary: 4226 MiByte in 21min 11.4sec - average of 3404 kiB/s
>
>
> # ls -al "/mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachines.20=
190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> -rw------- 1 massimo massimo 17932222464 18. Dez 2018  '/mnt/usb/mobileda=
ta/snapshots/mobalindesk/vm/VirtualMachines.20190621T140904+0200/IE8 - Win7=
/IE8 - Win7-disk1.vmdk'
>
> # ls -al "/mnt/local/data/snapshots/vm/VirtualMachines.20190621T140904+02=
00/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> -rw------- 1 root root 4742418432 18. Dez 07:37 '/mnt/local/data/snapshot=
s/vm/VirtualMachines.20190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk'
>
> # compsize "/mnt/usb/mobiledata/snapshots/mobalindesk/vm/VirtualMachines.=
20190621T140904+0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       45%      7.3G          16G          16G
> none       100%      1.9G         1.9G         2.3G
> zlib        38%      4.8G          12G          13G
> zstd        34%      536M         1.5G         727M
>
> # compsize "/mnt/local/data/snapshots/vm/VirtualMachines.20190621T140904+=
0200/IE8 - Win7/IE8 - Win7-disk1.vmdk"
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       92%      4.1G         4.4G         4.3G
> none       100%      3.8G         3.8G         3.8G
> zlib        32%      7.3M          22M          22M
> zstd        45%      264M         583M         560M
>
> Does that help you?

It confirms what I suspected and narrows down a bit the possible causes.
Are you able to run the send operation again with the following debug path?

https://pastebin.com/raw/cEEy9A6W

When the issue happens it should dump to dmesg/syslog a debug message
that starts with the marker "HERE" and right before it,
something that takes several lines to dump a metadata leaf, and with
first line being something like this:

"leaf <number> gen <number> total ptrs <number> free space <number>
owner <number>"

That way I can see the specific extent metadata layout that causes
send to issue an invalid clone operation (attempting to clone 4096
bytes from eof).

Thanks a lot Massimo!

>
> Best regards,
> Massimo
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
