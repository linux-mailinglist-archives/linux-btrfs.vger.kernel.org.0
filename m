Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1446E49B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjDQNRk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjDQNRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 09:17:24 -0400
X-Greylist: delayed 4180 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Apr 2023 06:16:58 PDT
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4242108
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 06:16:58 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:10:06 +0000
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=tostr.ch header.i=@tostr.ch header.b="EzPZC1eN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tostr.ch;
        s=protonmail3; t=1681726215; x=1681985415;
        bh=PHqB+fXFYf2TfK3kt5+lCol3E3PORi1VCWaEmES9vAU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EzPZC1eNCc8V3v4u6xakRfE52V7ydD01LCUDRR+bUsXaoZIa2iga6fhVLh0Ny2RTB
         Xmxrn/ETnXmvg4yWEvkEgUQ9UifY0qD3Q0lJ4AnlakgbWyGZ9pOi5u4eOqB48AqVQz
         5uYaOWCtQ9DyhciZQj321zYcxeombSRw83+Ea3++nbxPWb1rhrxEyuP1/svYwPVEck
         0AQWKR30f0uHt+U7AvnHEC2k67yjRu+J6A5x2iNpAAVZ2iGogaJVo5VQra1Gll/ju4
         xaDgH11lxdo4GQpGhGSmoSQY4XwUWnFjhJu9dExPZKtfHK6yK0qiB1dDabTkytPZD3
         DSQ1SH4bjZSVA==
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   Otto Strassen <otto@tostr.ch>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Filesystem ro mode, check shows a lot of missing backrefs, no idea on how to proceed
Message-ID: <vU62kpQ14yw_mYWcogz5KZy0j0wZ_1bNBQnJvvc-zqlqZAYpjFderRCnigBCG3F2Sv5g9PKexYTf9_dO8H1OxDkQQg1Vlz4UZzMmkwsx7Z0=@tostr.ch>
In-Reply-To: <fb3714a3-ab30-30b0-f336-68e2717b20d8@gmx.com>
References: <sY9YYJrpztwzxhv_9p28An7hkWNiF8hHF0we0ToIQ69b3lpaeBc7l77Kd4jYdsXA6Rps73Xa3guq3XA8c3mZdxDIvSwO5Cyh2eeO5Aqh3-s=@tostr.ch> <c3bf3d9d-9be4-713f-64b8-769d2a014d1a@gmx.com> <BWQf5N5kpHk5W540zTSqzDYn2kLi7lwJt-3odaRz1xs751TcwplGjnVGU-ytnar_lcoaKZHghhONSHAdSPtC98yyq52HXIUTCq1x65RWGwU=@tostr.ch> <fb3714a3-ab30-30b0-f336-68e2717b20d8@gmx.com>
Feedback-ID: 42428327:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------3d665f4500686726450ba4347936a588098701b30c0ab901c344c8fb1e62b8e9"; charset=utf-8
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------3d665f4500686726450ba4347936a588098701b30c0ab901c344c8fb1e62b8e9
Content-Type: multipart/mixed;boundary=---------------------45e9abd742e67425bc0d2cc5f1ba3dd6

-----------------------45e9abd742e67425bc0d2cc5f1ba3dd6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

------- Original Message -------
On Saturday, April 15th, 2023 at 14:27, Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:


> =


> On 2023/4/15 19:04, Otto Strassen wrote:
> =


> > Hi Qu, thanks for your answer.
> =


> [...]
<snip>
> =


> =


> No clue either.
> =


> To understand what's going wrong in the extent tree, we need not only
> the full btrfs check output, but also better with newer btrfs-progs.
> =


> =


> But the existing ones already shows 3 different errors:
> =


> - Backref disk bytenr does not match extent record,
> bytenr=3D4184732463104, ref bytenr=3D0
> =


> This shows one extent backref shows bad bytenr (0, not the expected
> 4184732463104).
> =


> This could cause problem when deleting the extent.
> =


> - ref mismatch on [8291880861696 16384] extent item 3, found 1
> This means one extent shows 3 backrefs, but in subvolumes tree, there
> is only one extent.
> =


> This may be the cause of the RO flip.
> =


> - Incorrect global backref count on 21189054693376 found 4 wanted 0
> This shows one extent which is not referred by anyone in subvolumes.
> =


> This may be the cause of the RO flip either.
> =


> Unfortunately older kernel doesn't give enough output to pin down which
> extent caused the problem (newer one has much better output).
> =


> Considering you have some forced RW (which itself is a bug in btrfs)
> after flipped RO, I'm not sure if this makes the case worse.
> =


> But overall, no transid mismatch, no obvious bitflip, and you mentioned
> no power loss (which should not cause any obvious problem by the nature
> of COW), the remaining causes are very limited:
> =


> - Some btrfs bugs
> At least we know there is one bug that allowed you to remount the fs
> RW after a RO flip.
> =


> And considering how old the kernel is, it's not that weird to hit some
> old but already fixed bugs.
> =


> - That RW mounts caused something wrong
> But that still doesn't explain the initial RO flip.
> =


> > As stated in my first mail, all testing so far came up empty. But I wo=
uld prefer for this to not happen again since it basically blocks work at =
the place. (A second system for failover is unfortunately noy possible rig=
ht now, but at least we have several backups)
> =


> =


> Unfortunately that's something I can never ensure, especially for a
> vendor specific kernel.
> =


> Remember it's the vendor who should take the responsibility, especially
> when they are still using EOL kernels.
> =


> [...]
> =


> > > But I would still strongly recommend to go a newer enough (5.15 at
> > > least) kernel and progs.
> > =


> > Once I have done the extended SMART test, and am ready for a rebuilt, =
I will give this a try. I will have to do it with the synology provided ve=
rsions though.
> =


> =


> That's the tradeoff one has to take when sticking to a specific vendor.
> =


> But if you're going to rebuild, then why not just try "btrfs check
> --repair" in this case?

Ok, some development here. I had to hard-poweroff the NAS because it had b=
ecome completely unresponsive. After that two disks were failed. I removed=
 them, and re-integrated them (no replacement of disks) and md rebuilt the=
 array (no problems). That in itself I find a bit strange, but maybe I did=
 the poweroff at a very bad time?

Now here is the result from repair etc.

$ btrfs check --clear-space-cache v2 /dev/mapper/cachedev_0
# I had to do this before it would let me repair

$ btrfs check --repair /dev/mapper/cachedev_0
# Went through the ~50k lines
<snip>
backpointer mismatch on [21189054693376 16384]                            =
                                      =


owner ref check failed [21189054693376 16384]                             =
                                      =


repaired damaged extent references                                        =
                                      =


Fixed 0 roots.                                                            =
                                      =


block group cache tree generation not match actul 238649, expect 240741   =
                                      =


checking free space cache                                                 =
                                      =


checking fs roots                                                         =
                                      =


checking csums                                                            =
                                      =


checking root refs                                                        =
                                      =


found 20419805880336 bytes used err is 0
total csum bytes: 938142472
total tree bytes: 2908684288 =


total fs tree bytes: 1667170304
total extent tree bytes: 178520064
btree space waste bytes: 427759440
file data blocks allocated: 28059017342976
 referenced 26999960571904


$ btrfs check --readonly /dev/mapper/cachedev_0
Syno caseless feature on.
Checking filesystem on /dev/mapper/cachedev_0
UUID: c14c923f-2038-4841-aa89-504f1044d3be
checking extents
Found dropping subvolume ID:2632 dropping progress: key (458271 INODE_REF =
457325) level: 1
Process dropping snap root: key (2632 ROOT_ITEM 0) dropping progress: key =
(458271 INODE_REF 457325)
block group cache tree generation not match actul 238649, expect 240741
checking free space cache
checking fs roots
checking csums
checking root refs
found 20419801194496 bytes used err is 0
total csum bytes: 938142472
total tree bytes: 2907209728
total fs tree bytes: 1667170304
total extent tree bytes: 177045504
btree space waste bytes: 427205612
file data blocks allocated: 28059017342976
 referenced 26999960571904

So there is only one problem left, I ran a second repair (You Don't Only R=
epair Once), to see what would happen. Same result.

After a reboot the thing is back in ro... So I guess a rebuild it is then?

Thanks and best
Otto


> =


> If it doesn't work, go the rebuild as planned.
> But if it works, you saved a lot of time and should be able to use the
> fs without any problem (as long as btrfs check --readonly returns no err=
or).
<snip>
-----------------------45e9abd742e67425bc0d2cc5f1ba3dd6--

--------3d665f4500686726450ba4347936a588098701b30c0ab901c344c8fb1e62b8e9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmQ9GuAJkOprz5XYRobAFiEEzgw+qhyRVYuktNGm6mvPldhG
hsAAAKlfAQCh/4QBRmOBZWTVwxGgqwwjEraNm2BZF2p1cz5GcbZYdgEAo2Da
jsw7t8YPOKRnLwgQ9ufbMEjBHJwTw8n+u6uKpwc=
=mPYj
-----END PGP SIGNATURE-----


--------3d665f4500686726450ba4347936a588098701b30c0ab901c344c8fb1e62b8e9--

