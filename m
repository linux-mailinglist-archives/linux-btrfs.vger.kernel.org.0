Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2BFAAD47
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbfIEUoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 16:44:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41401 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbfIEUoi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Sep 2019 16:44:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so3266342wrw.8
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2019 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KZ3J0TrDw0skFiCvodd/i66GGxi/kPxQAa+juj2ysAY=;
        b=tL5bojgYKTcY+gniJlWJGpYu+b2jkglR0Dax30V7okuyXEmVebXLql7bUrv0yRdUTr
         227DLwaC8f4dE9laMK+mxpno9tJZaLpi/ceF0LeSx6O3ehpYZnidk3GkC3+K8JRt+I7p
         GZH2Bqz1Vwxat7cPrhHF4g4E0/7bcZOYVKuwl9jPsUGDDFGtLK8qgcXpjYkJXZyxgB3Y
         weCB2bQDWCWoqaoQzgkSxt4YBc6iT/iaqUr2as6XYKVmEq1Ok6xL0zW3IiHv/m/GyeaP
         BARMzNNw+lx/pnjQ8zJEua1PrEA3OSAkZDhqdBB9GeNwuQQRHMRC1ACodbhHU48D7R/C
         y4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KZ3J0TrDw0skFiCvodd/i66GGxi/kPxQAa+juj2ysAY=;
        b=DGFx08Mx4ZD6yyc6N7B+Tq/SgpmI3uB7K2OsdAcrBjAZE4hLRhQTBTZCwRi2SMkXvQ
         ikhghoLSNxieOFkBdJEQsrcJtvN84w8r7uyqiws9fyx0v02HvYzN9lcwV/+L09zIyfA4
         WhLs5fZp3rA/3atcXI5kLUXjvOUkefpJwc8pxgEatILjxyTmCOBz/BARIHv5Aicn2C8I
         yIQYN9XpOys61H+J/p5zdMCsj+gNpp3gu1pkAX52S+DJHjm21gaTL2IqR6z6XoAktyyl
         wbirD0iT7WEgNWCC5E4nBVUXuR44ipbs5srMvQyKA38jN4fkpmLhMqi6Whxs/z/2sedK
         JnCQ==
X-Gm-Message-State: APjAAAXccmFcn02DGP/HesWjdEcj/P6y0Q9VUlkPFBNO/k+PpbQC+s6H
        yy0PQcWs5EJhoBYqcmJor/tzBBZgqkR9RNnE5GMwMR9deu4L95YiJfnpa9e5CuWss2aYwVH+hwd
        eqObVeXjco9nJrTbd
X-Google-Smtp-Source: APXvYqxphjbVZp/A3BkN3zKTk23593NNRy1y5U2SH6cVgllrEOcQv53STgTTQutXxd0bWjY4fDgYLw==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr4334158wro.288.1567716275154;
        Thu, 05 Sep 2019 13:44:35 -0700 (PDT)
Received: from [192.168.42.1] (84-112-118-202.cable.dynamic.surfer.at. [84.112.118.202])
        by smtp.gmail.com with ESMTPSA id z189sm5795949wmc.25.2019.09.05.13.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:44:34 -0700 (PDT)
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
 <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
 <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
 <51d54d67-bfd3-ee18-d612-330d07d9f714@liland.com>
 <CAJCQCtSAmCmonFBSBiMCrn+1X__WHDvHgLwWFyScvnfOGRD_4w@mail.gmail.com>
From:   Edmund Urbani <edmund.urbani@liland.com>
Message-ID: <6d535ae3-fac4-8fca-4823-2eeceb80529c@liland.com>
Date:   Thu, 5 Sep 2019 22:44:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSAmCmonFBSBiMCrn+1X__WHDvHgLwWFyScvnfOGRD_4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 05.09.2019 21:57, Chris Murphy wrote:
> On Thu, Sep 5, 2019 at 1:18 PM Edmund Urbani <edmund.urbani@liland.com> w=
rote:
>>
>> On 04.09.2019 07:36, Chris Murphy wrote:
>>>>>> I have tried all the mount / restore options listed here:
>>>>>> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=
=3Dcomments#comment-543490
>>>>> Good. Stick with ro attempts for now. Including if you want to try a
>>>>> newer kernel. If it succeeds to mount ro, my advice is to update
>>>>> backups so at least critical information isn't lost. Back up while yo=
u
>>>>> can. Any repair attempt makes changes that will risk the data being
>>>>> permanently lost. So it's important to be really deliberate about any
>>>>> changes.
>>>> I'll let you know, when I have the new kernel up and running.
>>> I think you should have all the original drives installed, and try to
>>> mount -o ro first. And if that doesn't work, try -o ro,degraded, and
>>> then we'll just have to see which drive it doesn't like.
>> Things are finally looking up. I have replaced both sdb and sdf with
>> ddrescue'd copies. sdb had some 10MB bad sectors and sdf 8KB which could
>> not be recovered.
>>
>> I am now able to mount the volume again. :)
>>
>> btrfsck /dev/sda1
>>
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda1
>> UUID: 108df6ea-2846-4a88-8a50-61aedeef92b4
>> [1/7] checking root items
>> checksum verify failed on 34958760591360 found E4E3BDB6 wanted 00000000
>> checksum verify failed on 34958760591360 found E4E3BDB6 wanted 00000000
>> parent transid verify failed on 34958760591360 wanted 3331734 found 1544=
337
>> checksum verify failed on 34958760591360 found 04DEBA71 wanted B9FBE54D
>> checksum verify failed on 34958760591360 found 04DEBA71 wanted B9FBE54D
>> bad tree block 34958760591360, bytenr mismatch, want=3D34958760591360,
>> have=3D27967614209536
>> ERROR: failed to repair root items: Input/output error
>>
>> Anyway, I am about to mount it read-only again to try and backup a few
>> things. And once I am done with that, should I run btrfs scrub?
> Did it mount with ro alone, or did you need ro,degraded?
>
> I'm a little confused by the i/o error, which I'd expect will also
> produce a message at the same time in dmesg that will hint what the
> nature of the i/o error is. That suggests some kind of hardware issue
> still exists, even if it is an uncorrectable sector read error. For
> sure rw mounted scrubs can fix those thing, if enough redundancy
> exists, and those copies aren't also corrupt. But I'm off hand not
> sure whether 'btrfs check --repair' can fixup bad sectors like scrub
> can.
>
> Anyway, I suggest 'btfs check --repair' is a last resort, no matter
> the version of btrfs-progs. 'btrfs check' alone is safe. So in order:
>
> * you've done these
>
> *dmesg
> *btrfs check --readonly  ##safe, makes no changes, maybe gives a hint
> of the problem
> *mount -o ro
> *mount -o ro,degraded
> mount -o rw  ## all devices available
> mount -o rw,degraded
>
> I'm not sure a read only scrub helps much. It might be interesting?
> What you really want is to be able to mount rw with all devices, and
> then scrub.
>
> But even rw,degraded is better, because you must be rw mounted to make
> scrub repairs, and also to do device replacements. I personally would
> not do a degraded scrub, because that scrub requires reading the whole
> volume. If you're going to read the whole volume anyway, you might as
> well rebuild the bad/missing device, so that you can more quickly get
> back to undegraded/normal RAID6 operation.
>
> If you can only mount 'rw,degraded' we need to see 'btrfs fi show' and
> the kernel messages for the failed mount and the successful degraded
> mount, so we can figure out what devices are affected, maybe why, and
> then what the next step is.
>
> Anyone know if latest kernel and progs now reliably supports 'btrfs
> replace' for RAID6? For a bit it was recommended to do it the old way,
> with 'btrfs device add' followed by 'btrfs device delete'. Main
> difference for the user is that 'replace' requires that the
> replacement drive is at least as big (in bytes) as the one being
> replaced and also that 'replace' will not resize the volume after
> replacement is finished, that has to be done manually. Otherwise I
> think it's preferred?
>
I did not need the degraded option. And so far I see no HW I/O errors in=20
dmesg. I have encountered a few errors while copying files and found=20
these in the log:

[ 3560.273634] btrfs_print_data_csum_error: 50 callbacks suppressed
[ 3560.273639] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0x98f94189 expected csum 0xcb3af09a mirror 1
[ 3560.825942] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 2
[ 3560.826588] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 3
[ 3560.827813] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 4
[ 3560.829063] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 5
[ 3560.830366] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 6
[ 3560.831559] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 7
[ 3560.832998] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 8
[ 3560.834649] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 9
[ 3560.836188] BTRFS warning (device sdg1): csum failed root 262 ino=20
1838364 off 14467072 csum 0xc0248289 expected csum 0xcb3af09a mirror 10

and also:

[ 3889.813300] btree_readpage_end_io_hook: 1860 callbacks suppressed
[ 3889.813304] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 0
[ 3889.825732] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.826375] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.828149] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.829649] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.831592] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.833436] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.835458] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.836968] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972
[ 3889.848545] BTRFS error (device sdg1): bad tree block start, want=20
34958548107264 have 12157064991241308972

I think that Input/output error btrfsck is showing is actually a=20
filesystem checksum error and not triggered by faulty hardware (not=20
anymore, I hope). If there actually are any more failing drives here, I=20
will most likely do the ddrescue thing again. Currently there are no=20
free SATA ports in that system to connect an additional drive, so I=20
cannot simply add one (at least not without also installing an=20
additional SATA controller).

Anyway, I have some peace of mind now that most of my data is accessible=20
again. Time to get some sleep...

Thank you, Chris!

Kind regards,
 =C2=A0Edmund



--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0



Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese Mail enthaelt vertrauliche und/oder=20
rechtlich geschuetzte=C2=A0Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat=20
sind oder diese Email irrtuemlich=C2=A0erhalten haben, informieren Sie bitt=
e=20
sofort den Absender und vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopi=
eren=20
sowie die unbefugte Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This=20
email may contain confidential and/or privileged information.=C2=A0
If you are=20
not the intended recipient (or have received this email in=C2=A0error) plea=
se=20
notify the sender immediately and destroy this email. Any=C2=A0unauthorised=
=20
copying, disclosure or distribution of the material in this=C2=A0email is=
=20
strictly forbidden.

