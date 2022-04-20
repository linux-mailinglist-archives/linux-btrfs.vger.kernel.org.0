Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928EF5081E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350874AbiDTHUy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 03:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244636AbiDTHUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 03:20:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916903AA55
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:18:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t13so832404pgn.8
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KShDa2PjJXDUAAPLhosxnDR0KNtzqTAwj60JBRrdtRI=;
        b=p3HLvrh9PRbNea4BBFIOSD73OiGuhPWJwNmFgobPcifofT/OglDO32IHMuSu2dJGth
         UkqJAPT8gAU7Q+p6CmxnWsrMWxdB8yRu23PSHYdRhV8YWmYxuPm0pkuQHDRR5PiWVGKn
         N9OWXokUXC01IlkF3Co9l8mueQVJQl9tKgfBKNqQlzjCj2Qnwp6xqC2abUejeiBxYQVR
         1SMyxgb6vmhezFWIOIOec/vIM9wIO99syRc9AP7kWbAIuMcMLL/6dEo5nKuawg5FHzuW
         bI4ShAWwzuKGSZaoxG94CCTUcBsvf2x59L86r04s7hZY4xh5JDVUTPPUeNBotP9rRMka
         BH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KShDa2PjJXDUAAPLhosxnDR0KNtzqTAwj60JBRrdtRI=;
        b=BqnZz1w5WvQULc6qUfoWv/7QB4FGLX/ZxokRPiquF3e42Lvol90RbJqaJbMP9+ERrI
         KUpPXmya6lNVsiZztcumFDyCQ5rDx5QvbTQei6zetJzQfPVMgkQnK9Z5HSsezmppkBpx
         KlnlVAmLCLrQj3eQQq++fLJqj04yMYTB8v77r3Nwpw9trSIDEVyGvx5EBe8fyiQbQH7y
         J8z5GDzijHsufVPmrorjmplbZ09tQlPOw+Le0Jd6+j24Yaz8xLqJ2J3b6KvDq8SRraXh
         VwpcJQc6Ho35rU6E/F8J114VqsAnouGCrUtWgciovhjg9lnObO11/2ZFAmqYdkJXYfvc
         buxQ==
X-Gm-Message-State: AOAM531mJzQGxbI5EiGYUtcTHXkquz/EBlMeTlayqocPtnshqu4COwTJ
        zLaboK8lxbtEOVSiCJG34oG4L0/Cu7I88vC4BjHzaVBB
X-Google-Smtp-Source: ABdhPJyjepc6qqwLD+ydVYKIulibxQhaiIQPVzC1zt1erd1f2kwwxFpegw+tvW7yyPD+u28JyXGQVU/aLK6D4WvenCY=
X-Received: by 2002:a05:6a00:98e:b0:50a:9524:94f0 with SMTP id
 u14-20020a056a00098e00b0050a952494f0mr7132300pfg.9.1650439086087; Wed, 20 Apr
 2022 00:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGv6Cq+uwBMgo6th6E16=om8321wTO3fZPXF151VLSYiexFUg@mail.gmail.com>
 <6672365e-c3d2-1a4c-7eb6-957f7a692d3a@cobb.uk.net>
In-Reply-To: <6672365e-c3d2-1a4c-7eb6-957f7a692d3a@cobb.uk.net>
From:   Alex Powell <alexj.powellalt@googlemail.com>
Date:   Wed, 20 Apr 2022 16:47:54 +0930
Message-ID: <CAKGv6CovkUjb92MAaM-irNcJvJk2P_2QNpybzCSsSs2RMgfz4A@mail.gmail.com>
Subject: Re: space still allocated post deletion
To:     Graham Cobb <g.btrfs@cobb.me.uk>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you,
The issue was veeam keeping snapshots in .veeam-snapshots above the
root subvolume. I have no idea why this is the expected behaviour,
because the backups are set to go to /mnt/data.

I'm confident that if I wait 7 days, the backup retention period, this
will fix itself. So this itself is not a bug in btrfs, it is more a
misconfiguration by Ubuntu or Veeam.

On Tue, Apr 19, 2022 at 8:51 PM Graham Cobb <g.btrfs@cobb.me.uk> wrote:
>
> On 19/04/2022 11:41, Alex Powell wrote:
> > Hi team,
> > I have deleted hundreds of GB of files however space still remains the
> > same, even after a full balance and a dusage=0 balance. The location I
> > am deleting from is usually a mount point but I found some files had
> > saved there while the array was unmounted, which I then removed.
>
> Most likely you have files in subvolumes which are not currently mounted
> anywhere. You need to mount the root subvolume of the filesystem to see
> all the files. Many distros default to putting the system root into a
> non-root subvolume.
>
> I think you can see them all if you use:
>
> btrfs subv list -a /
>
> To access them...
>
> mkdir /mnt/1
> mount -o subvolid=5 /dev/sdh2 /mnt/1
>
> Graham
>
> >
> > root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
> > 6.4G /mnt/data/triage/complete
> > 189G /mnt/data/triage/incomplete
> > 195G /mnt/data/triage
> >
> > root@bean:/home/bean# rm -rf /mnt/data/triage/complete/*
> > root@bean:/home/bean# rm -rf /mnt/data/triage/incomplete/*
> > root@bean:/home/bean# du -h --max-depth=1 /mnt/data/triage
> > 0 /mnt/data/triage/complete
> > 0 /mnt/data/triage/incomplete
> > 0 /mnt/data/triage
> >
> > root@bean:/home/bean# btrfs filesystem show
> > Label: none  uuid: 24933208-0a7a-42ff-90d8-f0fc2028dec9
> > Total devices 1 FS bytes used 209.03GiB
> > devid    1 size 223.07GiB used 211.03GiB path /dev/sdh2
> >
> > root@bean:/home/bean# du -h --max-depth=1 /
> > 244M /boot
> > 91M /home
> > 7.5M /etc
> > 0 /media
> > 0 /dev
> > 0 /mnt
> > 0 /opt
> > 0 /proc
> > 2.7G /root
> > 1.6M /run
> > 0 /srv
> > 0 /sys
> > 0 /tmp
> > 3.6G /usr
> > 13G /var
> > 710M /snap
> > 22G /
> >
> > Linux bean 5.15.0-25-generic #25-Ubuntu SMP Wed Mar 30 15:54:22 UTC
> > 2022 x86_64 x86_64 x86_64 GNU/Linux
> > btrfs-progs v5.16.2
>
