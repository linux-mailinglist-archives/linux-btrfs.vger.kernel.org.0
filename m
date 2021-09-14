Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64C40A2D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 03:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhINBuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:50:39 -0400
Received: from mail.mailmag.net ([5.135.159.181]:47084 "EHLO mail.mailmag.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhINBui (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:50:38 -0400
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id E3121EC348A;
        Mon, 13 Sep 2021 17:49:19 -0800 (AKDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1631584160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhXUTwdlbRwlBWhUVAyTQGmQYLnOL+98KAPdvaux4NE=;
        b=bGX0q0HXQ993CsvV40/bH5EC3L6UL4Y5k+UndFaIOp+0PTAUx3Y62OnhqIV8S9it9vY1XX
        bP4+PI7zcX3ucaiODzeU1CRL3rNdSjnwJqwztnevoVeNfNmPfjUjZhG9zlwBRY0K5glMym
        FAy6m24Z9s46V3T9NbmmtuWGGmS2wO0=
MIME-Version: 1.0
Date:   Tue, 14 Sep 2021 01:49:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   "Joshua" <joshua@mailmag.net>
Message-ID: <fc2fbb950e825676988f425773c2bde5@mailmag.net>
Subject: Re: btrbk question: Should I Prefer Fileserver-initiated Backups 
 from Several Hosts (Instead of Each Host Sending to the Server)?
To:     "Dave T" <davestechshop@gmail.com>,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
In-Reply-To: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
References: <CAGdWbB5z6sGbDSJRygvWOiNNSP6hNhzFP-eMDfTm6nGoBpehKQ@mail.gmail.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1631584160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhXUTwdlbRwlBWhUVAyTQGmQYLnOL+98KAPdvaux4NE=;
        b=VcW+dgsA17dkuGT34ZlYLc1QIT1+qBFjL4QYdR97UebOiw+w0NQZ+/B60wrCLGio45aFA+
        Yzyyf6n+cM88oDCDXQ68V+mVg3OCn5BpAT7Zt8wME/jjxtYmjoU4MvKloxGkWAfwTrEPMI
        A7LkYe7MP0FZX2M5GxvQmckfFX3N1+Y=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1631584160; a=rsa-sha256; cv=none;
        b=CnvM5ZOWaOdRO8R6k44rzhYqrFu7Xjr0MV5zFK8qbSwU6O+LvH+alDTpqglxQEGOyZDMAz
        chR3w4L0fncoBs4tabpdvFeGElCujnWSr6PeXDOVy+7ptVkPT9q794t6WICAhxmk0YU/ZR
        Pg+EgqzuDnsYMUmpmzm8yW8vT7MbrNg=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

September 12, 2021 10:42 AM, "Dave T" <davestechshop@gmail.com> wrote:

> Are btrbk-specific questions OK here?
>=20
>=20I have a small LAN with a fileserver that should store backups from
> each attached host on the LAN. What is the most efficient (performant)
> way to do this with btrbk?
>=20
>=20Each host (laptops, desktops and a few other devices) does hourly
> local snapshots with btrbk. Once per day, I would like to send backups
> of each volume on each device to the local fileserver. This has to be
> done via SSH (as NFS isn't supported by btrfs send|receive, afaik).
>=20
>=20The options I'm aware of from the btrbk readme
> (https://digint.ch/btrbk/doc/readme.html) are:
>=20
>=201. host-initiated backup to the fileserver from each host
>=20
>=202. fileserver-initiated backups from all hosts
>=20
>=20My guess is that the second option is preferred. Is that correct?

I personally prefer it, yes.

I can manage all my retention in one place, and my backups are isolated. =
If a client is
compromised, the backups on the server cannot be deleted by an attacker, =
since my clients have no
access to the server, rather the server has access to the clients.

> Assuming I use the second option, do I need to be concerned about it
> initiating a backup on a host while that host is also performing a
> local hourly snapshot?

I don't think so.  Hopefully someone will correct me if so.

> What are the disadvantages of the fileserver-initiated approach?

If a client is offline, it will not be backed up at that time.

There's probably other disadvantages, but that's the main one I can think=
 of.

> If one host is offline, will the backup procedure continue on with the
> other hosts it can reach at that time?

It should, but I don't know 100%

> Since deleting snapshots can potentially be a costly operation (in
> terms of performance), should I split the process into two steps,
> where one step would pull the backups from each host without any
> deletions, and a second step would then prune the backups according to
> configured retention policies?

If it's important that the backup process complete as soon as possible, p=
erhaps this would be a
good idea.

If that's not important, I don't see why it would matter.

> How many backups (snapshots) can I safely retain for each host volume?
> I would like to keep as many as possible, but I know there is a
> threshold at which performance can become a problem.

I would think the limits would be relatively high, but I personally only =
run dailies for a week,
then weeklies for a month, then monthlies for a year.

> I mount btrfs volumes on the **hosts** with these mount options:
>=20
>=20autodefrag,noatime,nodiratime,compress=3Dlzo,space_cache=3Dv2

Just FYI, noatime implies nodiratime. Source: https://lwn.net/Articles/24=
5002

> And I have the systemd fstrim.service enabled.
>=20
>=20The fileserver is a dedicated backup server, not a general-purpose
> fileserver. I plan to use most of those same mount options. Do I need
> the autodefrag option? Will autodefrag help or hurt performance in
> this use-case? The following message from this list caused me some
> confusion as I would have expected the opposite:

Sorry, I honestly don't know what impact this might have.
I personally run autodefrag on my clients, and not on my backup server.

> [freezes during snapshot creation/deletion -- to be expected? November
> 2019, 00:21:18 CET]
>=20
>>=20So just to follow up on this, reducing the total number of snapshots=
 and increasing the time
>> between their creation from hourly to once every six hours did help a =
*little* bit. However, about
>> a week ago I decided to try an experiment and added the "autodefrag" m=
ount option (which I don't
>> usually do on SSDs), and that helped *massively*. Ever since, snapper-=
cleanup.service runs without
>> me noticing at all!.
>=20
>=20Are there any other recommendations?
