Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F4C0F5C
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2019 04:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfI1Ciw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 22:38:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33446 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI1Civ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 22:38:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id x134so3607931qkb.0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2019 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=iDjupTTAda8kTBT1m8JeDfGfWY/aMb52/7Ih2QRPDqQ=;
        b=SdbVZhxF6cKKrcK+rXXp6aOQXVrKrsBJCwsBKQjQj7kTmPEnNSrPgdfjbigmdbGqC+
         ab+WsSOL+5hS733wgGqSVIwCr8C8y9jJUK3IOFwOdbbNE1Omm+G/ePIqxSMLpnwHux9g
         K1x6Oz818MX4kzM6uXmeZTK4jTaqfDZZiO5h+lO/sdUTaakwW+jsApg7oohi2FOVH5LP
         QSHnphQeZTn9QBTDKTva6zVaWwX127bJi6090km9Iiyg4yiGi+CshyiNtTLm8mIOD/t1
         g7t36iZSJZGQBRRz0HIZWLq2lpFgHelTJczWok9Lu0/Vi2zLHrpOXZm6dQ4nv1g6uovV
         2AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iDjupTTAda8kTBT1m8JeDfGfWY/aMb52/7Ih2QRPDqQ=;
        b=iB572r5oyc3trKDvNEBKZ/PPh8t8K5DPACGn9xhyRDNDjTcD63gSJA/rgHP2T7pLKn
         DJr++dqxms7OtCPegkDtTMARGzuTFoFS57dfGyHIcmalLU6i9iGKnZ5Sl2tFIDhIIpnx
         plZ789YI5j9269fgHwVvdrr7iTEuEHWP9VzLb/B/nTosJ32Qpz02G+Cpm8ANJotsJeN7
         p5iRKFWyzUOOAgVITBt7Q+lrmmD843+xyDRaBOnzIvJGnPv0ru8U7JUWZbb9M5XR/FNu
         bT4ZkuKQpVbVICIrDHY0ipK6y03nBh1Ro5PxJ9q8hzAuj56E/c6Sb1Ded3j/cg7OP9Ac
         x0IA==
X-Gm-Message-State: APjAAAX21FEQ1BL0oq40cUFrmPXoWB+yAKNH5KLyZ33xm9DHreNaJs1w
        lZpCLNaCrwXIQVI8z3RNNzY=
X-Google-Smtp-Source: APXvYqzOqDbG85tGRfFt9ig/dmBeRdI3JkGYfm60nhhhSi/nU/jZva4k5uBLeLIx6vEih0Js4BbAiw==
X-Received: by 2002:a37:4f83:: with SMTP id d125mr7978996qkb.295.1569638329994;
        Fri, 27 Sep 2019 19:38:49 -0700 (PDT)
Received: from DigitalMercury.dynalias.net (mtrlpq0313w-lp130-04-76-66-191-48.dsl.bell.ca. [76.66.191.48])
        by smtp.gmail.com with ESMTPSA id q200sm2079063qke.114.2019.09.27.19.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 19:38:48 -0700 (PDT)
Received: by DigitalMercury.dynalias.net (Postfix, from userid 1000)
        id AC5171902F3; Fri, 27 Sep 2019 22:38:47 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     dsterba@suse.cz, Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs wiki, add Parrot as production user
In-Reply-To: <20190827124611.GG2752@twin.jikos.cz>
References: <CAJCQCtRtJ5LjO4vseJCP1zANF7dbjDtcsnoTTNs5YAmHt=NWRw@mail.gmail.com> <20190827124611.GG2752@twin.jikos.cz>
Date:   Fri, 27 Sep 2019 22:38:44 -0400
Message-ID: <871rw1du17.fsf@DigitalMercury.dynalias.net>
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

Hi David,

David Sterba <dsterba@suse.cz> writes:

> On Mon, Aug 26, 2019 at 06:55:47PM -0600, Chris Murphy wrote:
>> https://blog.parrotlinux.org/parrot-4-4-release-notes/
>>=20
>> Looks like they switched to Btrfs by default for / and /home.
>>=20
>> I think they should be listed on
>> https://btrfs.wiki.kernel.org/index.php/Production_Users
>
> Added, thanks for the tip.

If this is the criteria for Production Users, then NeptuneOS can also be
added.  This distribution was an early adopter who defaulted to btrfs
since sometime around 2014, using linux-3.13.11.

By the way, would you please document that the Debian kernel team
backports fixes release-critical (eg: data loss) patches to their stable
kernel, provides a recent mainline kernel via stable-backports (or
$codename-backports), and finally also provides recent btrfs-progs via
that same stable-backports source? (I've been responsible for
btrfs-progs backports since 2016)

It might also be worth noting that the Debian installer doesn't yet
support installation to subvolumes, the Ubuntu installer doesn't support
configuration of subvolumes, and I think neither does Calamares installer
(@ and @home are hard-coded like in Ubuntu IIRC).

Also--to my alarm--the upstream Calamares installer defaults to
compress=3Dlzo, with no way for the user to opt-out.  IMHO this should be
documented for the benefit of conservative users who wish to avoid the
once-a-year newly-found compression bug.


Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4qYmHjkArtfNxmcIWogwR199EGEFAl2Ox7QACgkQWogwR199
EGFvqhAAyy9zBeh4rohaqkG+c5WAVMPnmYjEfv1gJlX+h8V4GboHVhNiNVrzgrMe
3PJB8WPXRngfN7GLVWnRw5mp1NnqMw8yckmaE7bPLdnKd2S3RBVmXl8477dEpQmG
pg+Lsaap5amJXXH6TrQQbefwjLxfYA6foM3n6W99nX13IzkV0NkZkYYYcjlNp0rR
eDKMmKIVfU5P8v3pnawzxxJFiHju9Ckiz15oA5LEs79AOZw7g2yE5M6QhPUWXNrk
/B9Mvjoe1gGyb0Yz19P6mxIVFa199WYzRY3aWeBZL5exPfRmaFYs8BM7+FeWIE5C
wjSWnOgGZtCIGI8q01C+KrNSyA/eEarGt7I8Ki6qBgDDjtkrpOpcguOnnJaVtFWk
P+HnV5Xizrmpr7qyIsJiQf8PyMqx5zvBH4FpkmlqmOXqu+L3MoDhJ+fPFQWOxgdr
pLtv9+il4G6XRuZZBaKg1Lo3F7/5l/3yA9lqFdzvcPdr10EFDk9qACPS+eN+JQ8V
jcQMAFc4ahXS4bPD2+A+H6QwTDcgJZaY2Rw8voF1j3eyqw9JBLz1yMbN9Yscol2R
PqVgLJeaVf4GuEmNgSPiY2gtY/trjTT7Ls6hn19rVGoIBwwi3LmQhtqUOCQyxewe
qvWhouTFEXtD0bd85SAQZsn4qwPE5ZrnD10hz4SJAaM6Fb2NPvU=
=7jrA
-----END PGP SIGNATURE-----
--=-=-=--
