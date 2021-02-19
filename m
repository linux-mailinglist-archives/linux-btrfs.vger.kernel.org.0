Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8FC31FE19
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 18:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBSRnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 12:43:00 -0500
Received: from mail.mailmag.net ([5.135.159.181]:36310 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhBSRmx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 12:42:53 -0500
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id 68A19EC4F99;
        Fri, 19 Feb 2021 08:42:11 -0900 (AKST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1613756531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it9K+Ic5TQsFvF4p1fOg6O8jceltdZeF4WZxLC6wIUs=;
        b=CO/ojtpz1hS4VU31sb432RxCrHLf9aaXJ3+tSk6aW1C5ND+g8HTSxoWrGTNX+P9JGiMpqt
        mjoraTjEXbnOX2G3k29Tjc/NwovYHmkIkQCjBvdiW4tSMBYkO63pnqP4m6SihijsDF+WZ6
        ptmRUCZJwv2H4TtTpvt5jCWe5fcSwdo=
MIME-Version: 1.0
Date:   Fri, 19 Feb 2021 17:42:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Joshua" <joshua@mailmag.net>
Message-ID: <2cf10687560a2acb0b9445dfe570867b@mailmag.net>
Subject: Re: Large multi-device BTRFS array (usually) fails to mount on 
 boot.
To:     "Graham Cobb" <g.btrfs@cobb.uk.net>, linux-btrfs@vger.kernel.org
In-Reply-To: <8ae61a4f-8a7f-332f-a6b6-4ad808cc88c8@cobb.uk.net>
References: <8ae61a4f-8a7f-332f-a6b6-4ad808cc88c8@cobb.uk.net>
 <e23a835842fa7ecf5b8877e818bc68ea@mailmag.net>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1613756531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=it9K+Ic5TQsFvF4p1fOg6O8jceltdZeF4WZxLC6wIUs=;
        b=LGudnhcUQYPKAM4MjK/zNXqKMIQd6h14wfXa+2hUPZKy3/aEz/7bgTzUYdnx7ARalytJVz
        GI+qogUbs1vbnH6UNsumqEr34Cj1rGHrOZmepsPXcYvVE6t9SsDO+CBGpjEQhf3Uv/6LTc
        SnXfP2iZTBmidDRClgmnlqKy4+aVVBw=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1613756531; a=rsa-sha256; cv=none;
        b=uvcHaPqhGIaoizuzmTlyEFKTHjMTk5EXXa+5tLu5f2XE6BYbNjf32CUwJx6tLp+SRMmTNX
        dXzyNEj+yIpKQcSEusql0NUiVfBut5Y5z1AbHS0mw9P5Ok+W/IMVmVG03JaOvw9aCu+wKf
        RREYrJ9ySqy5rd6wAxm6WOviUt2GozA=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

February 3, 2021 3:16 PM, "Graham Cobb" <g.btrfs@cobb.uk.net> wrote:=0A=
=0A> On 03/02/2021 21:54, joshua@mailmag.net wrote:=0A> =0A>> Good Evenin=
g.=0A>> =0A>> I have a large BTRFS array, (14 Drives, ~100 TB RAW) which =
has been having problems mounting on=0A>> boot without timing out. This c=
auses the system to drop to emergency mode. I am then able to mount=0A>> =
the array in emergency mode and all data appears fine, but upon reboot it=
 fails again.=0A>> =0A>> I actually first had this problem around a year =
ago, and initially put considerable effort into=0A>> extending the timeou=
t in systemd, as I believed that to be the problem. However, all the meth=
ods I=0A>> attempted did not work properly or caused the system to contin=
ue booting before the array was=0A>> mounted, causing all sorts of issues=
. Eventually, I was able to almost completely resolve it by=0A>> defragme=
nting the extent tree and subvolume tree for each subvolume. (btrfs fi de=
frag=0A>> /mountpoint/subvolume/) This seemed to reduce the time required=
 to mount, and made it mount on boot=0A>> the majority of the time.=0A> =
=0A> Not what you asked, but adding "x-systemd.mount-timeout=3D180s" to t=
he=0A> mount options in /etc/fstab works reliably for me to extend the ti=
meout.=0A> Of course, my largest filesystem is only 20TB, across only two=
 devices=0A> (two lvm-over-LUKS, each on separate physical drives) but it=
 has very=0A> heavy use of snapshot creation and deletion. I also run wit=
h commit=3D15=0A> as power is not too reliable here and losing power is t=
he most frequent=0A> cause of a reboot.=0A=0AThanks for the suggestion, b=
ut I have not been able to get this method to work either.=0A=0AHere's wh=
at my fstab looks like, let me know if this is not what you meant!=0A=0AU=
UID=3D{snip} /         ext4  errors=3Dremount-ro 0 0=0AUUID=3D{snip} /mnt=
/data btrfs defaults,noatime,compress-force=3Dzstd:2,x-systemd.mount-time=
out=3D300s 0 0=0A=0AHowever, the system still fails to mount in less than=
 5 minutes, and drops to emergency mode.=0AUpon checking dmesg logs, it i=
s clear the system is only wait 120 seconds, before giving up on mounting=
, and dropping to emergency mode.=0A=0A--Joshua
