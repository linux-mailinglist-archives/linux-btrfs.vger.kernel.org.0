Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A9B228D0F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 02:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGVAVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 20:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgGVAVp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 20:21:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400DC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 17:21:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e12so590030qtr.9
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=1hQnu3Iqsqtocr13dKyCGCbe5juAiio8yuUgx2nh2n8=;
        b=IFMubkM00k7VlzNd+Z1vZnODh5zqtfpc1C2TxW8fkHtiC1H3xjbim0pze72c4TYtKK
         /MM0qkQeREX4SPYT1DmjIX11tDPEUsYwBJ6suvfQMLM2OmTYGAQYfzAnReZyrBPeRftO
         Z9HW2ht5FNE7hHQ6wd2XPm4J245BaLBxYTiNkGFecJUDkiiUCQqnX5jVzD+nFRt3weJW
         97v97KNtYKho9XYZu9P7yeuLA2RlKxuacwvWchRdhSc9scRF/szAUTuiNK+LPW5EUsnE
         eUZ2/js2YNccnMW3GvsC5roJdfkfYJ39j+n9PZJSrt3bMEo2RGVd86klCoM9SbostWOO
         rlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1hQnu3Iqsqtocr13dKyCGCbe5juAiio8yuUgx2nh2n8=;
        b=BbAdFZpHThik0DTXeRPskASYRFwnqpI6guW+kHzE5wB8yqzBl2ZTgfoznlnC/T0vsV
         9gVp/rOPcr2HRDukexfb8EmNaBB+h3aOapvKnyGQumBTSFG7WvzVTdSaXWmh1zVTvEDS
         kmuF69mXx402R+T7LVYKQj0l4VRRcmBA/z/LJHbvsicGxnfZlMzoY7oRTx59omLOfK//
         khRjh9S6fojebvcsFiJGBywYZwd28/kCkDTb+87XR78SJaGJxz+rGSIf64FZ7aCxukkl
         bIsrqlYTBZZssSWTgwyk10yAjVjrHKl7ra18ySMTeYF9mSJLEw5wjXIaeNZJeNOrb0yB
         hvhg==
X-Gm-Message-State: AOAM533ojxYJXEYVZLv+euYZ3yK8Xi4qi3wwsRmOjNd+tIqZVtX7FdTW
        GxkqWgr50g0SgdkJi/iuRQc=
X-Google-Smtp-Source: ABdhPJzAmVYaHRKTF+LvpFpfCOfk3eoWrNaScTSZtkzrArADgBj6+B5r54FfWHiu1j28ZpLQz3u/kg==
X-Received: by 2002:ac8:6c5d:: with SMTP id z29mr7617682qtu.244.1595377303944;
        Tue, 21 Jul 2020 17:21:43 -0700 (PDT)
Received: from DigitalMercury.dynalias.net (mtrlpq0313w-lp130-03-76-66-186-82.dsl.bell.ca. [76.66.186.82])
        by smtp.gmail.com with ESMTPSA id r46sm1449529qtk.75.2020.07.21.17.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 17:21:43 -0700 (PDT)
Received: by DigitalMercury.dynalias.net (Postfix, from userid 1000)
        id 5D87226DA50; Tue, 21 Jul 2020 20:21:42 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Subject: Re: [RFC] btrfs: strategy to perform a rollback at boot time
In-Reply-To: <20200721203340.275921-1-kreijack@libero.it>
References: <20200721203340.275921-1-kreijack@libero.it>
Date:   Tue, 21 Jul 2020 20:21:39 -0400
Message-ID: <87imegh018.fsf@DigitalMercury.dynalias.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Reply follows inline.

Goffredo Baroncelli <kreijack@libero.it> writes:

> Hi all,
>
> this is an RFC to discuss a my idea to allow a simple rollback of the
> root filesystem at boot time.
>
> The problem that I want to solve is the following: DPKG is very slow on
> a BTRFS filesystem. The reason is that DPKG massively uses
> sync()/fsync() to guarantee that the filesystem is always coherent even
> in case of sudden shutdown.
>
> The same can be useful even to the RPM Linux based distribution (which ho=
wever
> suffer less than DPKG).
>
> A way to avoid the sync()/fsync() calls without loosing the DPKG
> guarantees, is:
> 1) perform a snapshot of the root filesystem (the rollback one)
> 2) upgrade the filesystem without using sync/fsync
> 3) final (global) sync
> 4) destroy the rollback snapshot
>
> If an unclean shutdown happens between 1) and 4), two subvolume exists:
> the 'main' one and the 'rollback' one (which is the snapshot before the
> update). In this case the system at boot time should mount the "rollback"
> subvolume instead of the "main" one. Otherwise in case of a "clean" boot,=
 the
> "rollback" subvolume doesn't exist and only the "main" one can be
> mounted.
>
> In [1] I discussed a way to implement the steps 1 to 4. (ok, I missed
> the point 3) ).
>
> The part that was missed until now, is an automatic way to mount the roll=
back
> subvolume at boot time when it is present.
>
> My idea is to allow more 'subvol=3D' option. In this case BTRFS tries all=
 the
> passed subvolumes until the first succeed. So invoking the kernel as:
>
>   linux root=3DUUID=3Dxxxx rootflags=3Dsubvol=3Drollback,subvol=3Dmain ro=
=20
>
> First, the kernel tries to mount the 'rollback' subvolume. If the rollback
> subvolume doesn't exist then it mounts the 'main' subvolume.
>
> Of course after the mount, the system should perform a cleanup of the
> subvolumes: i.e. if a rollback subvolume exists, the system should destroy
> the "main" one (which contains garbage) and rename "rollback" to "main".
> To be more precise:
>

I like the idea of defaulting to a known-good snapshot on unclean
shutdown :-)

Is anyone on this list aware of grub-btrfs
https://github.com/Antynea/grub-btrfs ?  It's not my project, by the
way, but I'm curious what advantages your method has compared to the
alleged ZFS-like Boot Environment support of grub-btrfs?  In particular,
I wonder if the problem have already been solved solved due to that
project's snapper support, and if it just needs more exposure, general
testing, and integration for other distributions.

Oh, and to get apt to trigger snapshot creation:
https://github.com/stefxh/apt-btrfs-snapper

Iirc there are a couple other apt-btrfs snapshot creation projects

Best,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4qYmHjkArtfNxmcIWogwR199EGEFAl8XhpMACgkQWogwR199
EGGYExAA02lxySc+xzgJ+avby01D8aY9V3Cd63vYD7VAIFSciBRIBD16dGeEOWGX
zegJ+qGARX/WoKIEwGxuFSl/42KmTiqUKxXsK/iKbv0+p2gfT/nOy8VIlYDNk0M9
/dq/7OVZQHjoIyAsU8j9TMSsoHVTlP6sbeP1CGk+CFlFjMTgV7qMtCn75RhAGcHS
ysRcC15WPL3EvCEKb4/9ImlFZXd0GJSOx906JGudGJpHNRRR26eLUBoI44Qc2GQ9
uKVrhDsvSr7l35yIDVmyZQfr1LQ+3FkjrB1H/m+0R4k5Hrj3V/FWpYjpNEAZ78t4
4NY0LgWcgZYaCTUn56avTAPLSLWW87JbCyGtIXdPB7BrCNcU01MmlnjgUMxrsPFl
8BX2sJSvMmzDeB+ci0RtUszu9YJ9YHXtMn0Qpe1zI2QFYDayB/G4zLpcZXrwsGjS
s+vvYKCQxqyKaN5K8lF08GBVI1QeX2pVIzSnpFjU63bsNheKv9qE8dbnlNn9bcYj
ksDpEXYkoprzRBoi4zXLj5rivBDLgs6Rb3rBCHbn35xi4kZmzPzdfONrS6xkxu5o
WpZOgZlgPhQgZ1W4wbTtdv/GFjLS9kQ89EbRdGrtYIb3TRgcPTu2YMvIlTvhDqPf
GBkXhNLXMhruGt+BuLIsov/m0OwZjdWZ6l2sMchnqm7lFH9AYVU=
=3ocr
-----END PGP SIGNATURE-----
--=-=-=--
