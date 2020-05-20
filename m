Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452BB1DB267
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 13:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgETL4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETL4L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 07:56:11 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63338C061A0E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 04:56:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so3411412ejb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version;
        bh=+33Z29S7kX3UhAMlaTD906x0Mm1DdT4Y9F/9MSMT9Ok=;
        b=lNCqm36vvPk8gh3KOQOtZkHZYlb9AwUBNnHpwkvRsjxY/gGo7hDK2ylbv1ErdXl0WJ
         4u9Ql4OQjQ9zn41U35C8RuBnbM48AB16LSdt/Cfz7FhS7rJlm4BwpXbOlD4Zu6qrzt4s
         ELH3cvFZ/NrJ6TMtohq4LckOUTcQuB0DsMlBbcme00Rot2JZXUfqYmiFDamnFvGWUfG/
         /m7h2cXGiN+LglbmwCoeywqKiWnZRtQQb4jcuFiIQyCEgOe0jUbjc7HwIjctVSLpqgzr
         wPmCr+H8fl0uB85NA89dwq9q3OBN8eizotZrkudsfYNATbAro5WNJ3o1XX2x5s17w6js
         jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version;
        bh=+33Z29S7kX3UhAMlaTD906x0Mm1DdT4Y9F/9MSMT9Ok=;
        b=Kx96l8SCi+/clD9qkhvgyca379VxYrPsfoKdMMswWlT6wsep1O25uFoo/8zzUjxW8n
         MQCBLyD2Bu9ROjpypmXGudiB/R4gDO3BQ6m6loBGv35fcRjUejCQUcbO6Sh3/yDNisJS
         HW3tobvyeRAlrnwWHunyDwpqWRrZ/l87Wolw7OWBBPQAlicw0xrRcgL2LzKtzINeUl8K
         xC9I1L34BBWSTErgNauTp6Aw9Vd7se7iTZI9sWyCRLqtdIfCZOZW2gwUjf6MQugBsgi0
         EJqwf05AI9KVxm5je9tjEXHVVBXrAzvcFbo1meFsjFITBKAJsC/8x5Ki5iLgqCLg6xn6
         mJyw==
X-Gm-Message-State: AOAM530D0ec+7CRNYJQX7wurOhnA0RBPKR+ZZMgFsdo50ABDT1y7L1ZZ
        I5KSjyavjKslbl6fMpngp+c=
X-Google-Smtp-Source: ABdhPJxwIy4VC/dwGzj/eGL618HUh16HeJEdix4KUh+Icg/hFBUy1nuu5TX9065LibdjzpQMVLO96w==
X-Received: by 2002:a17:906:704c:: with SMTP id r12mr1518079ejj.308.1589975769929;
        Wed, 20 May 2020 04:56:09 -0700 (PDT)
Received: from [127.0.0.1] (p5796735f.dip0.t-ipconnect.de. [87.150.115.95])
        by smtp.gmail.com with ESMTPSA id se2sm1752445ejb.42.2020.05.20.04.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2020 04:56:09 -0700 (PDT)
Date:   Wed, 20 May 2020 11:56:06 +0000 (UTC)
From:   Emil Heimpel <broetchenrackete@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <343f7aa9-4cff-45b7-8635-4ca19014c4e5@localhost>
In-Reply-To: <f6d9ee8a-c0da-4b19-af3a-3c58c9c1478e@localhost>
References: <9d2d57e7-29d9-42c2-be55-fb8ee50db40e@localhost> <CAJCQCtQ9HzjjaV20txtoHAWG7tTVWaqdk6wf5QtB5v+w2p4b2Q@mail.gmail.com> <f6d9ee8a-c0da-4b19-af3a-3c58c9c1478e@localhost>
Subject: Re: Need help recovering broken RAID5 array (parent transid verify
 failed)
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_20_104875518.1589975766835"
X-Correlation-ID: <343f7aa9-4cff-45b7-8635-4ca19014c4e5@localhost>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_20_104875518.1589975766835
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi again,

I ran find-root and using the first found root (that is not in the superblo=
ck) seems to be finding data with btrfs-restore (only did a dry-run, becaus=
e I don't have the space at the moment to do a full restore). At least I go=
t warnings about folders where it stopped looping and I recognized the fold=
ers. It is still not showing any files, but maybe I misunderstood what the =
dry-run option is suppose to be doing.

Because the generation of the root is higher than expected, I don't know wh=
ich root is expected to be the best option to choose from. One that is clos=
est to the root the super thinks is the correct one (fe 30122555883520(gen:=
 116442 level: 0)) or the one with the highest generation (30122107502592(g=
en: 116502 level: 1))? To be honest I don't think I quite understand genera=
tions and levels :)

My plan would be to restore as much as possible and then try to repair the =
fs, do a scrub and then see if it managed to fix more data and do a backup =
of it. Than I would recreate the fs from scratch and restore the backup :)

You can find the output of find-root in the txt attached.

Greetings,
Emil

May 16, 2020 03:44:17 Emil Heimpel <broetchenrackete@gmail.com>:

>       Hi,=20
>     =20
> =20
>      Thanks for the answer. I attached the output of the commands you req=
uested as a txt file. Unfortunately mounting didn't work, even with the ker=
nel patch and skipbg option.=20
>     =20
> =20
>      I will try to find the journalctl from when it happened.=20
>     =20
> =20
>      Emil=20
>     =20
> =20
>      May 15, 2020 23:46:55 Chris Murphy <lists@colorremedies.com>:=20
>     =20
> =20
>      =20
>     =20
>=20
> >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On Fri, May 15, 2020 at 12:03 AM =
Emil Heimpel=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       <broetchenrackete@gmail.com> wrote:=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >      =20
> > > =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hi,=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I hope this is the right place =
to ask for help. I am unable to mount my BTRFS array and wanted to know, if=
 it is possible to recover (some) data from it.=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >      =20
> > =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 Hi, yes it is!=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >      =20
> > > =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I have a RAID1-Metadata/RAID5-D=
ata array consisting of 6 drives, 2x8TB, 5TB, 4TB and 2x3TB. It was running=
 fine for the last 3 months. Because I expanded it drive by drive I wanted =
to do a full balance the other day, when after around 40% completion (ca 1.=
5 days) I noticed, that one drive was missing from the array (If I remember=
 correctly, it was the 5TB one). I tried to cancel the balance, but even af=
ter a few hours it didn't cancel, so I tried to do a reboot. That didn't wo=
rk either, so I did a hard reset. Probably not the best idea, I know....=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >      =20
> > =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 The file system should be power fail saf=
e (with some limited data=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       loss), but the hardware can betray everything. Your configuration=
 is=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       better due to raid1 metadata.=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >      =20
> > > =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 After the reboot all drives app=
eared again but now I can't mount the array anymore, it gives me the follow=
ing error in dmesg:=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [=C2=A0 858.554594] BTRFS info =
(device sdc1): disk space caching is enabled=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        [=C2=A0 858.554596] BTRFS info (device sdc1): has skinny exten=
ts=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        [=C2=A0 858.556165] BTRFS error (device sdc1): parent transid =
verify failed on 23219912048640 wanted 116443 found 116484=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        [=C2=A0 858.556516] BTRFS error (device sdc1): parent transid =
verify failed on 23219912048640 wanted 116443=C2=A0 found 116484=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        [=C2=A0 858.556527] BTRFS error (device sdc1): failed to read =
chunk root=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        [=C2=A0 858.588332] BTRFS error (device sdc1): open_ctree fail=
ed=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >      =20
> > =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 Extent tree is damaged, but it's unexpec=
ted that a newer transid is=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       found than is wanted. Something happened out of order. Both copie=
s.=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 What do you get for:=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       # btrfs rescue super -v /dev/anydevice=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       # btrfs insp dump-s -fa /dev/anydevice=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       # btrfs insp dump-t -b 30122546839552 /dev/anydevice=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       # mount -o ro,nologreplay,degraded /dev/anydevice=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >      =20
> > > =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [bluemond@BlueQ btrfslogs]$ sud=
o btrfs check /dev/sdd1=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >      =20
> > =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 For what it's worth, btrfs check does fi=
nd all member devices, so you=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       only have to run check on any one of them. However, scrub is=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       different, you can run that individually per block device to work=
=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       around some performance problems with raid56, when running it on =
the=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       volume's mount point.=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =20
> >      =20
> >=20
> > >         =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 And how can I prevent it=
 from happening again? Would using the new multi-parity raid1 for Metadata =
help?=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >      =20
> > =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 Difficult to know yet what went wrong. D=
o you have dmesg/journalctl -k=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       for the time period the problem drive began all the way to the fo=
rced=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       power off? It might give a hint. Before doing a forced poweroff w=
hile=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       writes are happening it might help to disable the write cache on =
all=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       the drives; or alternatively always disable them.=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =20
> >      =20
> >=20
> > >         =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I'm running arch on an s=
sd.=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        [bluemond@BlueQ btrfslogs]$ uname -a=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        Linux BlueQ 5.6.12-arch1-1 #1 SMP PREEMPT Sun, 10 May 2020 10:=
43:42 +0000 x86_64 GNU/Linux=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [bluemond@BlueQ btrfslogs]$ btr=
fs --version=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        btrfs-progs v5.6=20
> > >       =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >        =C2=A0=C2=A0=C2=A0=C2=A0=20
> > >        =20
> > >      =20
> > =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 5.6.1 is current but I don't think there=
's anything in the minor=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       update that applies here.=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 Post that info and maybe a dev will have=
 time to take a look. If it=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       does mount ro,degraded, take the chance to update backups, just i=
n=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       case. Yeah, ~21TB will be really inconvenient to lose. Also, sinc=
e=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       it's over the weekend, and there's some time, it might be useful =
to=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       have a btrfs image:=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 btrfs-image -ss -c9 -t4 /dev/anydevice ~=
/problemvolume.btrfs.bin=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 This file will be roughly 1/2 the size o=
f file system metadata. I=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       guess you could have around 140G of metadata depending on nodesiz=
e=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       chosen at mkfs time, and how many small files this filesystem has=
.=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 Still another option that might make it =
possible to mount, if above=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       doesn't work; build the kernel with this patch=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D1=
70715=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 Mount using -o ro,nologreplay,rescue=3Ds=
kipbg=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 This also doesn't actually fix the probl=
em, it just might make it=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       possible to mount the file system, mainly for updating backups in=
 case=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       it's not possible to fix.=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =C2=A0=C2=A0=C2=A0=C2=A0 --=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       Chris Murphy=20
> >      =20
> > =C2=A0=C2=A0=C2=A0=C2=A0=20
> >       =20
> >       =C2=A0=C2=A0=C2=A0=20
> >       =20
> >     =20
> =20
>    =20

------=_Part_20_104875518.1589975766835
Content-Type: text/plain; charset=us-ascii; name=btrsf.findroot.txt
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=btrsf.findroot.txt

Superblock thinks the generation is 116443
Superblock thinks the level is 1
Found tree root at 30122565173248 gen 116443 level 1
Well block 30122107502592(gen: 116502 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122107666432(gen: 116501 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122106765312(gen: 116500 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122121658368(gen: 116497 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122102996992(gen: 116496 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122101309440(gen: 116495 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122100391936(gen: 116494 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122099458048(gen: 116493 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122319429632(gen: 116492 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122137387008(gen: 116491 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122497638400(gen: 116490 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122473930752(gen: 116489 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122315579392(gen: 116486 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122315563008(gen: 116486 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122304487424(gen: 116485 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122304471040(gen: 116485 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122298032128(gen: 116479 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468933632(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468917248(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468900864(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468884480(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468868096(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468802560(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468786176(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468769792(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468605952(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468589568(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468376576(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468343808(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468311040(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468294656(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468261888(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468229120(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122468212736(gen: 116469 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122293592064(gen: 116458 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555883520(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555867136(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555850752(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555621376(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555588608(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555555840(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555523072(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122555473920(gen: 116442 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122549657600(gen: 116441 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122546806784(gen: 116438 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122308403200(gen: 116433 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122308386816(gen: 116433 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122482024448(gen: 116408 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122481991680(gen: 116408 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122481958912(gen: 116408 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122491805696(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122491789312(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122486235136(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122485547008(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122482909184(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122482827264(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122482810880(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122482778112(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122482745344(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 30122482401280(gen: 116342 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280847659008(gen: 116336 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280840925184(gen: 116335 level: 1) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280834338816(gen: 116332 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280834289664(gen: 116332 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280831553536(gen: 116332 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280825786368(gen: 116332 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280797081600(gen: 116331 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280796393472(gen: 116331 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280795017216(gen: 116331 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280776388608(gen: 116330 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280757891072(gen: 116330 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019932790784(gen: 116327 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019932774400(gen: 116327 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019893288960(gen: 116327 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019857506304(gen: 116327 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019857113088(gen: 116327 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019888455680(gen: 116326 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 26387051118592(gen: 116326 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 25310236639232(gen: 116326 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 7559563935744(gen: 116326 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 7559367458816(gen: 116325 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 6692570562560(gen: 116325 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29281085046784(gen: 110860 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29281063141376(gen: 110860 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29281140408320(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280909410304(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280871923712(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280697090048(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280682033152(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279853658112(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279850364928(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279718981632(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279684329472(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279553667072(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279550570496(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279419121664(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019801653248(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 6692393353216(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 6692219633664(gen: 110859 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29281095565312(gen: 110551 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29281039679488(gen: 110468 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019988627456(gen: 110337 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28019975077888(gen: 110337 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280952942592(gen: 109937 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280627884032(gen: 109388 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280627326976(gen: 109388 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29281210564608(gen: 109385 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279846973440(gen: 109375 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279843237888(gen: 109375 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280196804608(gen: 108637 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29281185710080(gen: 108633 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280468254720(gen: 108527 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280300072960(gen: 108526 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29280017432576(gen: 108526 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279680036864(gen: 108526 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279552847872(gen: 108526 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 4923159674880(gen: 108526 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 4923153940480(gen: 108526 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279432982528(gen: 108520 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279380799488(gen: 108520 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279363055616(gen: 108520 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279355617280(gen: 108520 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 29279175802880(gen: 108520 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 5863619493888(gen: 108519 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 26386847678464(gen: 108383 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 26386468356096(gen: 108380 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 2799412903936(gen: 108325 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28020530233344(gen: 108227 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 26386416762880(gen: 108220 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 5863448657920(gen: 107686 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28020194623488(gen: 107672 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 1075667271680(gen: 107620 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28020127137792(gen: 107614 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 28020388724736(gen: 107386 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 24309878816768(gen: 107376 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 6691901718528(gen: 106867 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 24310098575360(gen: 106811 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 26387216056320(gen: 103210 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 23220080590848(gen: 102044 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 24310357229568(gen: 100795 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 24310530441216(gen: 96307 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 24310298656768(gen: 96271 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 24310293741568(gen: 96271 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 23237383012352(gen: 92298 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 23220814233600(gen: 92237 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 23220295778304(gen: 92219 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 6692060151808(gen: 91345 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 22279392444416(gen: 89503 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 6691836723200(gen: 2484 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 6691836674048(gen: 2484 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 1075344343040(gen: 505 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 1075872677888(gen: 429 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 1075771080704(gen: 403 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 1075652542464(gen: 380 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1
Well block 1075554172928(gen: 365 level: 0) seems good, but generation/level doesn't match, want gen: 116443 level: 1

------=_Part_20_104875518.1589975766835--
