Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED16E5421D3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 08:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiFHEr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 00:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiFHErB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 00:47:01 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F5CC17DF
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 14:17:37 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l1so13224918qvh.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:in-reply-to:references:cc:date:message-id
         :mime-version;
        bh=hrsYRn7bGV/+DjNzuG2H0PJOZuzxim573s0EmEdUsUo=;
        b=p3QJQaIgSFgS40GJl1hQJfv+PqhpQaM3UDYq6KtH/cbmRcg59O2zdUMl6YUlGm0aDk
         DZZTYLuNuEaLh5jCmJVK5Rbd8HEqnLjKdymNov6eK0UQ9u/TygmZa0DVmK5h/wIoG00R
         tbtWzh1Z8/I0M1gkKWXFooGavfDNjyr/2z/6LaGrb1CRifOc+y4KHLVE0rVQ+T2Chby7
         5sFpjlqXDfs3s8JZuhgl6x5rrvXop5tsCSz4Ej7hvEJD8HiowjNHkShwkI3Z08P+BIYN
         frKcpEbMXSZJn6PyC9FxN3Qwst+uxqfdUu8il+ilY6/dCknfJMo5DLFzeozrKsLAVUJV
         p5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:cc:date
         :message-id:mime-version;
        bh=hrsYRn7bGV/+DjNzuG2H0PJOZuzxim573s0EmEdUsUo=;
        b=Hx+kpzuXuG08ELnkxhWE84/+1SK5tIt/wM9qoDsJkWOC2iFprGTILlgTANcTiArG5i
         HEKFdRLaK3bqvDpBmCs+IawRTtyyVr7hrv+6v+J8OhL3PcU8mwojici1AmUS2KyHJj93
         a8AUrGIoDdk92Bg0edbRKW+RJx2yG1VEI4ECyRZGwSjstAforDID98UZUltuGj/JgblE
         unNBMGNb9Qaxy50IiK/ZjAaMw5Mn0Jfg+zC+/fclYmJDW7z/BXlK/87aSY1Cd5xGRGl8
         MBUlp2F2xyixeP91GmWs6cb0DhBZ/yutJxqDfQUvdVh4LoPG8cYgNwX6oXAn1bCY0GfE
         h+Zw==
X-Gm-Message-State: AOAM531m0ZW+/QRVCwR6dx2InCCgcINSrc4YKQUhK/01oZBhjEMtIOe4
        cDInVpmO4vwW4MFlbpWpnw0=
X-Google-Smtp-Source: ABdhPJww9kPoIoytbiUXeR751sOqkKIyiNG8mwFyu2+VAq33SFuysPjGaG/V6Wp+6PTsTJm37ZBruw==
X-Received: by 2002:a05:6214:1d25:b0:464:55a9:48df with SMTP id f5-20020a0562141d2500b0046455a948dfmr34782221qvd.113.1654636656337;
        Tue, 07 Jun 2022 14:17:36 -0700 (PDT)
Received: from DigitalMercury.freeddns.org (bras-base-mtrlpq0313w-grc-09-50-100-165-103.dsl.bell.ca. [50.100.165.103])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a258f00b006a6af149cffsm8920864qko.61.2022.06.07.14.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:17:35 -0700 (PDT)
Received: by DigitalMercury.freeddns.org (Postfix, from userid 1000)
        id 6083EC66621; Tue,  7 Jun 2022 17:17:34 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     Graham Cobb <g.btrfs@cobb.me.uk>, Forza <forza@tnonline.net>,
        efkf <efkf@firemail.cc>, linux-btrfs@vger.kernel.org
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
In-Reply-To: <fbc263ea-1d85-50b2-1968-f37065e8bb97@cobb.uk.net>
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
 <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
 <6685a5e4-6d03-6108-1394-0f75f6433c9e@firemail.cc>
 <4bad94f3-7cf2-6224-6876-7a1e3fe5abcd@tnonline.net>
 <fbc263ea-1d85-50b2-1968-f37065e8bb97@cobb.uk.net>
Date:   Tue, 07 Jun 2022 17:17:26 -0400
Message-ID: <87sfogkwbd.fsf@DigitalMercury.freeddns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Graham Cobb <g.btrfs@cobb.me.uk> writes:

> On 30/05/2022 21:47, Forza wrote:
>>=20
>>=20
>> I had a discussion with some Windows users, and they did exactly the
>> same thing - yanked the mirror out and then inserted it again. 4 times
>> out of 5 it "worked" and they got upset when it didn't work the last tim=
e.
>>=20
>> So, with that said, there is room to improve documentation, man pages
>> and guides to help users find the information they need to check their
>> system correctly.
>>=20
>> For now, mounting each mirror independently and then combine them again
>> is not good for Btrfs. This use-case seems to be unhandled.
>
> Sounds like btrfs should do something like assign the filesystem a
> completely new UUID (updated onto all the superblocks present at the
> time) if you mount degraded. To prevent any disks not present at that
> time from being reintroduced later.
>
> A bit drastic but that is what is really happening with a degraded
> mount: you are creating a new filesystem, with some of the contents
> inherited from an old one, and some missing.
>

Yes, I agree something should be done, but I'm not sure this is it.
Rather than this, I wonder why a multidisk profile of btrfs doesn't
do something like the following:

1. Maintain a list of devices that are part of the filesystem, using
/dev/disk/by-id or by-uuid identifiers.  At fs creation, these are
added to the "good list"

2. If ever the filesystem is mounted degraded, the IDs of missing
device[s] should be moved to a "bad list", and permanently blocked from
use.

3. If ever those IDs reappear (ie: they match an element of the "bad
list"), a warning should be emitted in the kernel log, and btrfs-progs
tools should warn that a "wipefs" of those devices is required before
readding them.

4. It also seems like it would be user-friendly to emit a warning if
ever single block groups are found on a on what should be a 100%
profile=3Draid{1,10,c3,c4,5,6} filesystem, because this is a dangerous
situation to be in.  This would signal that an urgent rebalance is
required after step #3.


Qu, is this possible with the current on-disk format?  If not, then
could something like this (specifically the "bad device list" at #2)
please be included in the design of the next on-disk format?  Ideally it
would be nice if reattached disks could replay all transactions since
they were detached, so maybe the future on-disk format could also
reserve a field for this?  The silent creation of profile=3Dsingle blocks
makes using Btrfs profile=3Draid{1,c3,c4} risky when compared to ZFS
mirrors.

Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmKfwGcTHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYT9jEADcriGN3tC9nKeSef+sXaDuBmhv0oAD
yI7wNFQz3Uqa8/lM5gxnXjz4h5FXCiD/RNt56aMcjO60Iwv25SVrlFL2LlR1jmte
bydnAU7mebjpb91rFG3I0OKexcWYv9oJmw1wgqPTMMzH2yoCwT0mppA5xTM0VuQ3
kG628XtTIrJMZPu5ItE7KKnLLWQX0RZJTvW+ca43YNem2ddxtljxnH3DwqgQ0QkU
wQvtkdeiJsaNNfJZLg3i62q8ZGe8W1cVmeeEJj+uf7xYtAl9AYi+IlbcrzQvHN/U
9JC88ve6vthFpMhmmoxekiymbiQo+gch6O25xfaLVWUVwXBZvVmOMMK2YbGyYoMS
c9OICzwNazjMXRSWA32z9hOBa03rIlZw1c+uNpkfkWxeRU5dNKoJ220iZwrj7/P3
vIiBfTVWuoDb4wj2RWcQUYL3sSg4F+W+ngx+IL1wsiAmh3IZz6f5ZPECAKCtv9DN
VOMzwDZJqbZ8Q1Q+RHZz2ACM7Z0qhpVF3hpJejytx4D4OAgiXJFzlPFx7ghw6Yes
pxN5XWmzCi7F/ZS0T/fRZ9A1tILLJuIUzuM1nbxvSxKP7yU+W8+pmkCcwBrGD9Qr
aEtrg6KmRLfy2Ib8utK5uElHQShXtGy8gUO6HNrRcaNzg4f2wtpH9bXtr/fypuG9
B/mBbujNOMpg4g==
=fyoU
-----END PGP SIGNATURE-----
--=-=-=--
