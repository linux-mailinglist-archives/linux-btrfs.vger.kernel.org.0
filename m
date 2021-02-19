Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E79320200
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 00:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSX5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 18:57:19 -0500
Received: from mail.mailmag.net ([5.135.159.181]:54068 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhBSX5S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 18:57:18 -0500
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 2679EEC444D;
        Fri, 19 Feb 2021 14:56:36 -0900 (AKST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1613778997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OI+lKlyH4qEhmIXI5OXeJR+sZqMhPWoEw0aqb/TmfY=;
        b=zRHga+9G5w04VfUaUxDWVc2LYnjTa463HRXYDGemqgIuuiQmTT284SRLyzFnBNPGXJcyJz
        kCeobx4KJQLiIcpm4nPQkusU8L1LNvgIGs3yTSMfd9uCvRB4d+y7GWCx0XUyCFqvOuC4E1
        NeAKZr6pVikJVpRv7xaDMldEfTa7eIU=
MIME-Version: 1.0
Date:   Fri, 19 Feb 2021 23:56:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Joshua" <joshua@mailmag.net>
Message-ID: <d2ca3e092c22c8186fe3f8a0e65192d5@mailmag.net>
Subject: Re: Large multi-device BTRFS array (usually) fails to mount on
 boot.
To:     "Graham Cobb" <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
In-Reply-To: <f559cfb0-1e9c-7dc8-f54d-2a9fc71980cd@cobb.uk.net>
References: <f559cfb0-1e9c-7dc8-f54d-2a9fc71980cd@cobb.uk.net>
 <8ae61a4f-8a7f-332f-a6b6-4ad808cc88c8@cobb.uk.net>
 <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
 <2cf10687560a2acb0b9445dfe570867b@mailmag.net>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1613778997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OI+lKlyH4qEhmIXI5OXeJR+sZqMhPWoEw0aqb/TmfY=;
        b=GRkQjU2PqMuQXH9YR41cLzNu3Zxz/8kMHt6lMQb/R4iTbX5scD8sI6QyoQl4PJENcGwQKm
        nipidw/tT7q9wDXNU9Dg9MRhFRlPFCev0VRCMT4UR9+U2Gr9sPWfUl8DQoDI04mQRWAuac
        38FnIMo1KTMT1vsxXEEPTzs5zFZNeLk=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1613778997; a=rsa-sha256; cv=none;
        b=baEZSTE6nX74BAAIT19Bm407cTk2oi1uynjexmtQIb72WzEEQr/8KQsHcOrurDt/j2YCxJ
        1OhoS9IFY8cD9S9UfoPcgod0IQ92epK04TR06fmsgfZT5lx6tlZnFVlLwgXS4FQzab4Z/t
        w7f1jkk8tNgT20yn8ZVWn4jvbichRD4=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

February 19, 2021 2:45 PM, "Graham Cobb" <g.btrfs@cobb.uk.net> wrote:=0A=
=0A> On 19/02/2021 17:42, Joshua wrote:=0A> =0A>> February 3, 2021 3:16 P=
M, "Graham Cobb" <g.btrfs@cobb.uk.net> wrote:=0A>> =0A>>> On 03/02/2021 2=
1:54, joshua@mailmag.net wrote:=0A>> =0A>> Good Evening.=0A>> =0A>> I hav=
e a large BTRFS array, (14 Drives, ~100 TB RAW) which has been having pro=
blems mounting on=0A>> boot without timing out. This causes the system to=
 drop to emergency mode. I am then able to mount=0A>> the array in emerge=
ncy mode and all data appears fine, but upon reboot it fails again.=0A>> =
=0A>> I actually first had this problem around a year ago, and initially =
put considerable effort into=0A>> extending the timeout in systemd, as I =
believed that to be the problem. However, all the methods I=0A>> attempte=
d did not work properly or caused the system to continue booting before t=
he array was=0A>> mounted, causing all sorts of issues. Eventually, I was=
 able to almost completely resolve it by=0A>> defragmenting the extent tr=
ee and subvolume tree for each subvolume. (btrfs fi defrag=0A>> /mountpoi=
nt/subvolume/) This seemed to reduce the time required to mount, and made=
 it mount on boot=0A>> the majority of the time.=0A>>> Not what you asked=
, but adding "x-systemd.mount-timeout=3D180s" to the=0A>>> mount options =
in /etc/fstab works reliably for me to extend the timeout.=0A>>> Of cours=
e, my largest filesystem is only 20TB, across only two devices=0A>>> (two=
 lvm-over-LUKS, each on separate physical drives) but it has very=0A>>> h=
eavy use of snapshot creation and deletion. I also run with commit=3D15=
=0A>>> as power is not too reliable here and losing power is the most fre=
quent=0A>>> cause of a reboot.=0A>> =0A>> Thanks for the suggestion, but =
I have not been able to get this method to work either.=0A>> =0A>> Here's=
 what my fstab looks like, let me know if this is not what you meant!=0A>=
> =0A>> UUID=3D{snip} / ext4 errors=3Dremount-ro 0 0=0A>> UUID=3D{snip} /=
mnt/data btrfs defaults,noatime,compress-force=3Dzstd:2,x-systemd.mount-t=
imeout=3D300s 0 0=0A> =0A> Hmmm. The line from my fstab is:=0A> =0A> LABE=
L=3Dlvmdata /mnt/data btrfs=0A> defaults,subvolid=3D0,noatime,nodiratime,=
compress=3Dlzo,skip_balance,commit=3D15,space_cache=3Dv2,x-systemd.=0A> o=
unt-timeout=3D180s,nofail=0A> 0 3=0A=0ANot very important, but note that =
noatime implies nodiratime.  https://lwn.net/Articles/245002/=0A=0A> I no=
te that I do have "nofail" in there, although it doesn't fail for me=0A> =
so I assume it shouldn't make a difference.=0A=0AAhh, I bet you're right,=
 at least indirectly.=0A=0AIt appears nofail makes the system continue bo=
oting even if the mount was unsuccessful, which I'd rather not since some=
 services do depend on this volume.  For example, some docker containers =
could misbehave if the path to the data they expect doesn't exist.=0A=0AN=
ot exactly the outcome I'd prefer, (due to services that may depend on th=
e mount existing being allowed to start) but it may work.=0A=0A=0AI'm rea=
lly very unsure how nofail interacts with x-systemd.mount-timeout.  I wou=
ld think it would increase the timeout period.  But that's not what I'm s=
eeing.  Perhaps there's some other kind of internal systemd timeout, and =
it gives up and continues to boot after that runs out, but allows mount t=
o continue for the time specified?  Seems kinda weird.=0A=0AI'll give it =
a try and see what happens.  I'll try and remember to report back here if=
 so.=0A=0A=0A> I can't swear that the disk is currently taking longer to =
mount than the=0A> systemd default (and I will not be in a position to re=
boot this system=0A> any time soon to check). But I am quite sure this ma=
de a difference when=0A> I added it.=0A> =0A> Not sure why it isn't worki=
ng for you, unless it is some systemd=0A> problem. It isn't systemd givin=
g up and dropping to emergency because of=0A> some other startup problem =
that occurs before the mount is finished, is=0A> it? I could believe syst=
emd cancels any mounts in progress when that=0A> happens.=0A> =0A> Graham
