Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2FF994D
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 20:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKLTDv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 14:03:51 -0500
Received: from mail.mailmag.net ([5.135.159.181]:52542 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfKLTDv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 14:03:51 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2019 14:03:49 EST
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id EA220EC03ED;
        Tue, 12 Nov 2019 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1573585094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMvOL6TS0jt8TI+dS0bfXDXXu4qcSt1DDtgq+YLNB2Y=;
        b=I9knaAv+oJ8zuSY4BJRclHXNYf7IhczzA+G3hZX/CBOC8JoK+tze35whA4hVPdKeccAWND
        Tjv4JCbGq0ncWjqLbuR4BEDszUWDeu0rA3+jJrL6//QLob2g+QxGGyC11/4TdT38DOpFrG
        PUy8mmgMMy7NmBYQsn9PNBcY6h1LGiw=
MIME-Version: 1.0
Date:   Tue, 12 Nov 2019 18:58:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   joshua@mailmag.net
Message-ID: <a862cfb2fc8feca06b510c7a8dfd1d2a@mailmag.net>
Subject: Re: btrfs based backup?
To:     "Ulli Horlacher" <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <20191112183425.GA1257@tik.uni-stuttgart.de>
References: <20191112183425.GA1257@tik.uni-stuttgart.de>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1573585094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMvOL6TS0jt8TI+dS0bfXDXXu4qcSt1DDtgq+YLNB2Y=;
        b=BDzQF69Xf8rzosRpW+/kvTFkS8Lvmw88MAAwU3YwzmlWxtFgpI1LXFBQoGyTA7Sbt82FZU
        zHEGauUAJ+bjgMV1gKgDKKTVfsuGLqeM0fS4UCjo9D/w535OD/QJ/xo7WybJZ1awXOwWoW
        4SpSahgZsmYYMQw2ew7RkEjiJU1VbZQ=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1573585094; a=rsa-sha256; cv=none;
        b=E5zXC7mCrjAvdXvqJR8zFHtLZw1ESaj4AdePipOumwr9oZJNsab96dJTHrwq+yfnP9hdNQ
        swU7juq1kdiUSPNtcO6v8+rfKabof66k0FcQoa98oLAjGvnbNouv/+P3+YrWJ9y0aCgTbj
        z8abSpcOw0Q2fA69s4XPEmhze3OQtHg=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I highly recommend something similar to snapper or btrbk (https://github.=
com/digint/btrbk) for the automation of snapshotting.=0A=0AI've used snap=
per previously and currently use btrbk, and both allow you to set very cu=
stomizable retention policies for snapshots.=0A=0ASay you take snapshots =
every hour, you could configure something like:=0A- Keep Hourly snapshots=
 for 24 hours.=0A- Keep Daily snapshots for 7 days.=0A- Keep Weekly snaps=
hots for 4 weeks.=0A- Keep Monthly snapshots for 6 months.=0A=0AOf course=
 you can optimize what snapshots you keep based on your knowledge of the =
data, and balancing point-in-time recovery vs not having too many snapsho=
ts to make some btrfs operations slower.=0A=0Abtrbk is focused towards ru=
nning it both on a source and a destination server to automate send & rec=
eive for backup purposes, but it can also simply manage snapshots on the =
local machine.=0A=0A=0ANovember 12, 2019 10:34 AM, "Ulli Horlacher" <fram=
stag@rus.uni-stuttgart.de> wrote:=0A=0A> I need a new backup system for s=
ome servers. Destination is a RAID, not=0A> tapes.=0A> =0A> So far I have=
 used a self written shell script. 25 years old, over 1000=0A> lines of (=
HORRIBLE) code, no longer maintenable :-}=0A> =0A> All backup software I =
know is either too primitive (e.g. no versioning) or=0A> very complex and=
 needs a long time to master it.=0A> =0A> My new idea is:=0A> =0A> Set up=
 a backup server with btrfs storage (with compress mount option),=0A> the=
 clients do their backup with rsync over nfs.=0A> =0A> For versioning I m=
ake btrfs snapshots.=0A> =0A> To have a secondary backup I will use btrfs=
 send / receive,=0A> =0A> Any comments on this? Or better suggestions?=0A=
> =0A> The backup software must be open source!=0A> =0A> -- =0A> Ullrich =
Horlacher Server und Virtualisierung=0A> Rechenzentrum TIK =0A> Universit=
aet Stuttgart E-Mail: horlacher@tik.uni-stuttgart.de=0A> Allmandring 30a =
Tel: ++49-711-68565868=0A> 70569 Stuttgart (Germany) WWW: http://www.tik.=
uni-stuttgart.de=0A> REF:<20191112183425.GA1257@tik.uni-stuttgart.de>
