Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 096BE139A7D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2020 21:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgAMUD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 15:03:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40195 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgAMUD3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 15:03:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so11122516wmi.5
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 12:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wQS03/dPKrhyDsPCI5gPDO5jt9zZtZ29V9Pnu7+YGoI=;
        b=j8i+VW40gPrOrbDFSBrei5ME+cKaD+LbRJjsVopeRFUbHsQT0fnqPqpuoc+6q7kk/Y
         Gcm22QGqdqyWydhuhLHIzUkptpzfpmASkh1lc22KYQaL0FDeHlK4A9RG+jNUwAB4+skq
         o52Fw9NpMPM2QshhcguPtcAU8lEZrYCs9Id5qPkNCqe/OU1Gh8EQ6bYswIH4SCK1i2w2
         STMYDfQXVOtdaGFmlGdU4a3ThIA9iD3ADMeOkGI5VGfXbSr5trmlT1SR2CDLYmzeUcK1
         b6IwOwJAzkqAqtHRiX0ftYTiw9AffBgGpeiUANEf0+xCsbs7jy/f24sb64vL6wsSIxYM
         mtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wQS03/dPKrhyDsPCI5gPDO5jt9zZtZ29V9Pnu7+YGoI=;
        b=J+y4TkJUT36jlgdWF+1ZNQ+Mc3xolY4OyBMFcCh7m921AKfATa3Hr3V9Bht2Gt+bcp
         mmFKD3MtRShmoxhQa8iCq2rhb5/Db0Un3yyitl81lKXsF0em98AKwaoddqd9zHLeAjFV
         Uamjz4NnP+DVrN8ZimDGefeO6BBv3vOKKum7Xh1ixn/B10M7r4ozPZSJTZjmYclLjxka
         6M5mfgrTpAXlJ/IM2HRJ0L6eu/eEjPl59QddDn/R6kkYxtEVZHfG63yfEVwNDBft8Y6/
         PAqECnt7NSJehWFdgcnY/Bsp8frE2R6ctkWHwjqTdKjc+5T24PKwkJ61wSrlhwXvphGW
         oOqA==
X-Gm-Message-State: APjAAAWNTpJmoAbQBswJq2cM+eGI4/jomvvrOPU18Hb2fl6GIhY3zpvp
        2WROydtdOcbfAIJ+iPAilpYjAjtYs5boP5BmTV4qcA==
X-Google-Smtp-Source: APXvYqzK3UB2i8nmqqkV9OmlgDzJExCluqKYvPrUtqH72fE3xrrltKR77cusCRDmQWDVFPsib0pzaEdR/9MAwVe2qBY=
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr22448829wmh.164.1578945806712;
 Mon, 13 Jan 2020 12:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com> <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com> <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com> <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com> <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
 <86147601-37F0-49C0-B6F8-0F5245750450@icloud.com> <CAJCQCtRkZPq-k6pX3bCJmj25HY4eDdAEUcgLwGSh_Mi6VEqdiQ@mail.gmail.com>
 <5EFA3F48-29DA-4D02-BF14-803DBEEB6BB2@icloud.com>
In-Reply-To: <5EFA3F48-29DA-4D02-BF14-803DBEEB6BB2@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 13 Jan 2020 13:03:10 -0700
Message-ID: <CAJCQCtRyr17kdSdozU4_ZxJL_VdCWZe7DCCuUuz0cy2AiJs3=A@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again (fourth time)
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 13, 2020 at 12:41 PM Christian Wimmer
<telefonchris@icloud.com> wrote:
>
> Hi guys,
>
> just to update you.
>
> I tried a 4th time with a brand new 12 TB archive and right after setting=
 up everything and putting some data on it I performed a controlled suspend=
 and restore and so on and yes, it broke again with that terrible messages =
that it can not mount any more the file system.
>
> Then I decided to create only 2TB archives (hard disks) as the slider in =
the Parallels VM suggests to do.
> I created 4 x 2TB files, one with persistent size and three expandable.
> I filled up all hard discs with data and rebooted 5 times (even when writ=
ing data to it) and everything runs very stable.
>
> So to resume, the Parallels Virtual machine has a problem when the virtua=
l disk is being selected bigger than 2TB. There is (and was) never a proble=
m with the btrfs files system I think.
>
> Sorry for bothering you all the time with my bad setup.
>
> Thanks a lot for all your help!

Yeah it's no problem. I mean, there's no way to know in advance that
the setup is bad, it has to be proven. And with any complicated setup,
it's really tedious to find out where the problem is happening. And
even still it's not certain if this is some bug flushing to Parallels,
or if it's getting the flush and not doing it completely for very
large backing files, or if the host OS file system or block device
drive is dropping something.

There are definitely bugs in Btrfs too so you can't absolutely exclude
the possibility, but those look different. They tend to be pernicious.
Whereas in your case these problems appeared quickly, back to back.
But also it's super complicated, multiple layers have to all work
exactly right or there will be problems. I would be very skeptical of
VM guest suspend with any file system. It should be true there is fs
sync that happens when the guest kernel is told to suspend, but then
what happens to that flush once it's in the VM or hypervisor? *shrug*
How long does it take to actually get from VM all the way to stable
media?

Because necessarily you have to consider worst case scenario, like
doing file writes and a complete loss of power. Since Btrfs and kernel
block layers aren't directly responsible for writing to the disks,
it's ambiguous exactly when and in what order, the writes do get to
stable media.

Ok so now what? It's entirely possible you've totally eliminated the
problem. Or it might be possible you've only reduced the chance it'll
happen - meaning something like it will happen at some point.

Is it superfluous extra work for no benefit, to unmount this Btrfs
file system, or use fsfreeze, prior to suspending the VM? Or never
suspend the VM? Or maybe the non-default mount option flushoncommit is
useful in this case? It's a huge hassle to have to rebuild a 12TB
volume, it's a high penalty.

--=20
Chris Murphy
