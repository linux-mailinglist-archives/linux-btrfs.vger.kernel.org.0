Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 847EEF8E9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLLa4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 06:30:56 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39023 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLLa4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 06:30:56 -0500
Received: by mail-wr1-f53.google.com with SMTP id l7so6536163wrp.6
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2019 03:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=all8iTt1bJ40YIU9t9hATwc+eK6Ao3wLEZqsXOrE94I=;
        b=H2izz/cX5TJiuZFH6K+oDkcm0CLLSObGrwKiA+Kb6kFpC2wPBEGSLSubdHhj0E8n7z
         GkrNBax1tCRTfHtzQu36wCD/LHJb3V1X+2/S/D+nIKCI5PtN2QUWNQcWXiTMOUhEVFKk
         It7hcs8LATC2X3B7gx2BWg2ZPOpRNJ5jYEyYuiL325xneizjqbssjLMkBKzMX5qQL3oF
         gJxzbcGUSqnrLuR83GDbUllknBj0aV4wKudPcqzRA5VqF/tuxiBvLne9D6B5Kocy59HK
         9oZ3Ue/YPGZqqIZdwzhHj/vd1qJBkmOIKPJmPJ+YjFYfWN07hWbLiHhtF7xaDjcvmlu4
         ROPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=all8iTt1bJ40YIU9t9hATwc+eK6Ao3wLEZqsXOrE94I=;
        b=QkT/sIpnZVE1SIFpAbFrw/z1EY+V9WFtElYDgKJKrtMTJPX7GxLp/coJ9rwUI70p4t
         6Jzp43yNbHVbby+uPReuTolFscxotfSnyyKPjR30GP3NxMz47SSTCnFEuU/Ujs62yUqM
         sW3iFYfkSTVAVRd0KydCdqmjWT4MiEtLuhv3047ueYuWgDaOFNBxjFH0BOf0824H5M7r
         dmP068FyXt2KtiIsHzPcorNRdVYL04P5CW7mKk7sEvr8DOp8hZxAbp3qZd+NOE0EIwcQ
         44B7amUc13WZcCc1NFRqxV8OydSeiZHAzfHaMCzDdIXoJ4aiT2vVVvIWyhoA7Rx3gtfz
         y1LA==
X-Gm-Message-State: APjAAAVuqn/MxthZOaSyym5P9rBq9rOZMy1eCwaQKnEIyx7QuDdbodt8
        Zk8tdXzca1+JSAaly+WiUHojaN1Zd+x/SD/98OLnxA==
X-Google-Smtp-Source: APXvYqy07EA7elPWox2vhqSJsbckkKHcZ1XWyS+JO6Qis3zp0nsDwjn8CM1C2a2gX8QzLIqD9h0Y9Nz9WoSEg46G2OA=
X-Received: by 2002:adf:9344:: with SMTP id 62mr26620082wro.262.1573558251259;
 Tue, 12 Nov 2019 03:30:51 -0800 (PST)
MIME-Version: 1.0
References: <344827358.67114.1573338809278.JavaMail.zimbra@raptorengineeringinc.com>
 <5d2a48c3-b0ea-1da8-bf53-fb27de45b3c6@gmx.com> <1848426246.125326.1573368477888.JavaMail.zimbra@raptorengineeringinc.com>
 <64be1293-5845-4054-8d5f-b9ff79168a17@gmx.com> <1503948411.128656.1573370293214.JavaMail.zimbra@raptorengineeringinc.com>
 <4c5b062b-30c7-2707-2bef-0ea5f18265c5@gmx.com> <741683181.533799.1573514917384.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <741683181.533799.1573514917384.JavaMail.zimbra@raptorengineeringinc.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 12 Nov 2019 11:30:17 +0000
Message-ID: <CAJCQCtRxAyUPeTvZFKSi-GGdFpQGKAOz5pUEaj43xeT7xhO4eg@mail.gmail.com>
Subject: Re: Unusual crash -- data rolled back ~2 weeks?
To:     Timothy Pearson <tpearson@raptorengineering.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 11:28 PM Timothy Pearson
<tpearson@raptorengineering.com> wrote:
>
> Here's the final information we gleaned from the disk image -- that is no=
w being archived and we're moving on from this failure.
>
> It doesn't look like a general commit failure, it looks like somehow spec=
ific directories were corrupted / automatically rolled back.  Again I wonde=
r how much of this is due to the online resize; needless to say, we won't b=
e doing that again -- future procedure will be to isolate the existing arra=
y, format a new array, transfer files, then restart the services.

I'm skeptical of resize being involved for a couple reasons:
a) it should have resulted in immediate problems, not days later
b) resize involves the same code as balance and device removal, the
first step is to identify any chunks in physical areas that will no
longer exist after the resize and moving those chunks to areas with
free space that will continue to exist, and updating all the metadata
that points to those chunks. It's essentially identical to a filtered
balance.

Therefore, if there's a bug in resize, there's also a bug in balance
and device removal. And if that's true I think we'd have other people
running into it.



>
> btrfs-find-root returned the following:
>
> =3D=3D=3D=3D=3D
> These generations showed the missing files and also contained files from =
after the crash and restart:
> Well block 114904137728(gen: 295060 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1

That's really suspicious that it wants a LOWER generation number than
what it has. And it's not a huge difference, just 151 generations,
which isn't likely weeks. For a system root, that's maybe an hour or
two of time? Or if not used that much it could be a couple days.


> Well block 114679480320(gen: 295059 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
> Well block 114592710656(gen: 295058 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
> Well block 114092670976(gen: 295057 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
> Well block 114844827648(gen: 295056 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
> Well block 114618925056(gen: 295055 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
> Well block 923598848(gen: 294112 level: 1) seems good, but generation/lev=
el doesn't match, want gen: 294909 level: 1
> Well block 495386624(gen: 294111 level: 1) seems good, but generation/lev=
el doesn't match, want gen: 294909 level: 1
>
> =3D=3D=3D=3D=3D
> This generation failed to recover any data whatsoever:
> Well block 92602368(gen: 294008 level: 1) seems good, but generation/leve=
l doesn't match, want gen: 294909 level: 1

And that's 901 generations, could be a day with average use, or more
days with light use.

What are the mount options for this file system?

>
> =3D=3D=3D=3D=3D
> Generations below do not show files created after the crash and restart, =
but the directories that would have contained the ~2 weeks of files are cor=
rupted badly enough that they cannot be recovered.  Lots of "leaf parent ke=
y incorrect" on those directories; unknown if this is because of corruption=
 that occurred prior to the crash or if this data was simply overwritten af=
ter remount and file restore.
>
> Well block 299955716096(gen: 293446 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
> Well block 299916853248(gen: 293446 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
> Well block 299787747328(gen: 293445 level: 1) seems good, but generation/=
level doesn't match, want gen: 294909 level: 1
>
> My confidence still isn't great here that we don't have an underlying bug=
 of some sort still present in btrfs, but all we can really do is keep an e=
ye on it and increase backup frequency at this point.
>
> Thanks!

There isn't a lot to go on. Have you gone through the logs looking for
non-Btrfs related errors? Like SCSI or libata link resets, or doing a
grep -i 'fail\|error' and so on? Each drive has its own log, exposed
by 'smartctl -x' and also useful is to know what the SCT ERC is,
'smartctl -l scterc' for each drive in the volume. Somewhere something
got dropped.


--=20
Chris Murphy
