Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B956DA479
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 06:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389040AbfJQEHL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 00:07:11 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:39536 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfJQEHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 00:07:10 -0400
Received: by mail-vk1-f170.google.com with SMTP id u4so201912vkl.6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2019 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tmVHEVOGD/6K2JGysHHSw5AUc3WQFlNd4J4PgPfuZoo=;
        b=AvkhdTpaSR4HhSJf17PabQ2pnmu7uGjVkN4QZ5wu47rFLxJZube2m76qNPHZH4r/d2
         9kqdxOQX4VTBUY9iogGU578pNL9kTw6W30ykILDUOnkNbWVB9gnlPiThDPwu9OnYYUaZ
         SXQTdnoq6huTqDW8loBlM9VRGpQIkxPuRVSnUN+Zd4oGaf0UskndY+LgOVeRWXYB3yyv
         DsmpyBHw9LDYUTlS+vQuQAtrtsMQ7eACednWK/Hvx8S5It7uaX3zWUBr6sZc9fCiLJyk
         uefyyPHxvs71EfKCsbhK3ixx6YSLhFAHAix7P75u5JmOH/sncN7vQlnpUr7OfekVoWfW
         EHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tmVHEVOGD/6K2JGysHHSw5AUc3WQFlNd4J4PgPfuZoo=;
        b=smc1OcxLbw8R4UWjyCGi8dHczzDBVb1o7PKGzh2CJ3qfY4e1QHSWzY695wxtM774WV
         ouFROJnOGg+6mDoA5/grlc4x0/L8OLQ/e9n/YLieJH5hkE4o1Lr2OPrLq2vcltiLhUyp
         RCt2tg5eaZmUSC/gZLtAQfr/KzynfNEphidqJAi/y4e5G0c+MNXiKn5UHWr7fRzl8g0+
         0UhZdL/YUIQ03hliPrgQqkL/273jcO2yyvjfEnT8okgr8Yp5CPWvoL+sr47e9it25YxT
         1ze2b+UvDR76GaAGFdCNDaAyAorP5DH3jFKyrVyLcfdRV/A6/B6WDWrLIbdjAfoDftF/
         PJtQ==
X-Gm-Message-State: APjAAAWB6wOxUB+UByAsJXnQaME6tP7+R6SyVJJCHKFxBYAxlCAorfqg
        4aY/FGy2NRzeS45tQIKgyTZ6gt689bC1AjYqh4FaA7CVcjc=
X-Google-Smtp-Source: APXvYqyKgqIrApx3LjSwK/qeBLti/kiwOjvE5JVLVMu/bvb4JtXTMGUvbp8o63hZyAo7eSevPXZBjH+HHvN1fSlEG7E=
X-Received: by 2002:a1f:a293:: with SMTP id l141mr869025vke.43.1571285229461;
 Wed, 16 Oct 2019 21:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
In-Reply-To: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
From:   Jon Ander MB <jonandermonleon@gmail.com>
Date:   Thu, 17 Oct 2019 06:07:01 +0200
Message-ID: <CACa3q1wUmgY9uTygYFVBer=QgZjtwX2NOvVT68kAYKAgoLpXRg@mail.gmail.com>
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It would be interesting to know the pros and cons of this setup that
you are suggesting vs zfs.
+zfs detects and corrects bitrot (
http://www.zfsnas.com/2015/05/24/testing-bit-rot/ )
+zfs has working raid56
-modules out of kernel for license incompatibilities (a big minus)

BTRFS can detect bitrot but... are we sure it can fix it? (can't seem
to find any conclusive doc about it right now)

I'm one of those that is waiting for the write hole bug to be fixed in
order to use raid5 on my home setup. It's a shame it's taking so long.

Regards


On Thu, Oct 17, 2019 at 12:21 AM Edmund Urbani <edmund.urbani@liland.com> w=
rote:
>
> Hello everyone,
>
> having recovered most of my data from my btrfs RAID-6, I have by now migr=
ated to
> mdadm RAID (with btrfs on top). I am considering switching back to btrfs =
RAID
> some day, when I feel more confident regarding its maturity.
>
> I put some thought into the pros and cons of this choice that I would lik=
e to share:
>
> btrfs RAID-5/6:
>
> - RAID write hole issue still unsolved (assuming
> https://btrfs.wiki.kernel.org/index.php/RAID56 is up-to-date)
> + can detect and fix bit rot
> + flexibility (resizing / reshaping)
> - maturity ? (I had a hard time recovering my data after removal of a dri=
ve that
> had developed some bad blocks. That's not what I would expect from a RAID=
-6
> setup. To be fair I should point out that I was running kernel 4.14 at th=
e time
> and did not do regular scrubbing.)
>
> btrfs on MD RAID 5/6:
>
> + options to mitigate RAID write hole
> - bitrot can only be detected but not fixed
> + mature and proven RAID implementation (based on personal experience of
> replacing plenty of drives over the years without data loss)
>
> I would be interested in getting your feedback on this comparison. Do you=
 agree
> with my observations? Did I miss anything you would consider important?
>
> Regards,
>  Edmund
>
>
>
>
>
> --
> *Liland IT GmbH*
>
>
> Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
> Tel: +43 463 220111
> Tel: +49 89
> 458 15 940
> office@Liland.com
> https://Liland.com <https://Liland.com>
>
>
>
> Copyright =C2=A9 2019 Liland IT GmbH
>
> Diese Mail enthaelt vertrauliche und/oder
> rechtlich geschuetzte Informationen.
> Wenn Sie nicht der richtige Adressat
> sind oder diese Email irrtuemlich erhalten haben, informieren Sie bitte
> sofort den Absender und vernichten Sie diese Mail. Das unerlaubte Kopiere=
n
> sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
>
> This
> email may contain confidential and/or privileged information.
> If you are
> not the intended recipient (or have received this email in error) please
> notify the sender immediately and destroy this email. Any unauthorised
> copying, disclosure or distribution of the material in this email is
> strictly forbidden.
>


--=20
--- Jon Ander Monle=C3=B3n Besteiro ---
