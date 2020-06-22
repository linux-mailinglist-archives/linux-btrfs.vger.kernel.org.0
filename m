Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647D8202DCA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 02:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgFVAGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Jun 2020 20:06:14 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:37894 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbgFVAGO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Jun 2020 20:06:14 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id DAEA58700
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jun 2020 02:06:11 +0200 (MEST)
Date:   Mon, 22 Jun 2020 02:06:11 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: weekly fstrim (still) necessary?
Message-ID: <20200622000611.GB16871@tik.uni-stuttgart.de>
Mail-Followup-To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20200621054240.GA25387@tik.uni-stuttgart.de>
 <CAJCQCtSbCid6OzvjK9fxXZosS_PAk2Lr7=VTpNijuuZXmRVVEg@mail.gmail.com>
 <20200621235202.GA16871@tik.uni-stuttgart.de>
 <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun 2020-06-21 (17:57), Chris Murphy wrote:

> > > util-linux provides fstrim.service and fstrim.timer for a while now.
> > > fstrim.timer runs on Monday at 00:00 local time. The upstream default
> > > is disabled, some distributions enable it by default.
> >
> > On Ubuntu 18.04 and RHEL 7.8 "systemctl is-enabled fstrim" returns
> > "static"
> 
> You need to check fstrim.timer, which in turn triggers fstrim.service.

root@fex:~# cat /lib/systemd/system/fstrim.timer
[Unit]
Description=Discard unused blocks once a week
Documentation=man:fstrim
ConditionVirtualization=!container

[Timer]
OnCalendar=weekly
AccuracySec=1h
Persistent=true

[Install]
WantedBy=timers.target


root@fex:~# cat /lib/systemd/system/fstrim.service 
[Unit]
Description=Discard unused blocks
ConditionVirtualization=!container

[Service]
Type=oneshot
ExecStart=/sbin/fstrim -av



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<CAJCQCtQmrc5m=H6d6xZiGvuzRrxBhf=wgf8bAMXZ_4p8F3AJFw@mail.gmail.com>
