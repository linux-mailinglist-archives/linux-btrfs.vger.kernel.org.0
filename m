Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39B372716F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 00:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFGWUA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 18:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjFGWTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 18:19:49 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1C2696
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 15:19:06 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-786f7e1ea2fso7001241.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686176313; x=1688768313;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tscqtiWNPRZB/rwsEFvY/JJuQDZQvgsE7LJ1A1TZhfY=;
        b=QrhcUdZ/9Ff7luFFmncu8tNofZA0Zq/2MVdC3XQbjgHuicqd1uaeByj7LM6NgqkZhg
         8uGTnA8LoUgoLqbIYuYxXa52ufSBlZIDwoAK7BR773Dnu520De2s+8XSBwXBRHSJf5wU
         Dgh32BqW1OajgwgpSfri9rhl1RjVg85sCyKOWlrPtCgublls/wTu9V7cbYsVhW8oukuc
         o10P/+L7JGUmSp0+QAoBH1bkubzQctpZ9tf+fWLR8rndwwKPC1D2Bt6klx1PueKA6Utv
         8918zEdoOXDF37XCtksD0B5w3p/PsjdDmsSMEp33zeyvAAOxszrW6+bq7bh4ocxe6rgM
         gMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176313; x=1688768313;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tscqtiWNPRZB/rwsEFvY/JJuQDZQvgsE7LJ1A1TZhfY=;
        b=c9Iq+4W6gatDFOtYaxVG/S1SLkHZNCgyletpOBC6APCqBmX5BGMDygHUdYVabaYS7g
         DbGPGLB0xa3ocaiU8XPYvcHWDK5POm5ZMe/XOtFAjMwzaCln1uZcPNfMUr495a38jOK4
         Hr6oHRjP67JEqF9mVRrr5OrqdNhI8noO8QoTnT6K9j69R2iCPg38qXjCqC4DDr7hhKFe
         Z4IDhlGANgj/OiOZyFcWsvnFe2S4bzQ+KMcgeEVz9eLO+GORmcv7yCvLZXi619S640Jg
         uOeVXv94JE1ry4505R+P/uvkwnC9kZRNzKAabHOH2KdLjnSa814faKi3sqZ+LIGOHqxF
         7FGw==
X-Gm-Message-State: AC+VfDynM4HpAqa0JwLWiPRc4EIQ9TXlSVsT1LvyI1d+/0MCRmk/QX7W
        ZoK2VgbsZaKQ5DX8pRvLHEpcILi5k3g=
X-Google-Smtp-Source: ACHHUZ6TlHqNvWaz2tpUGalOYlQ1Flx9Qn5Lb2fDF9Br2RnFW6JidB5JdEWWpti1i9PsP3rSR607eA==
X-Received: by 2002:a67:d00f:0:b0:43b:159b:f2c5 with SMTP id r15-20020a67d00f000000b0043b159bf2c5mr1005279vsi.32.1686176313445;
        Wed, 07 Jun 2023 15:18:33 -0700 (PDT)
Received: from DigitalMercury.freeddns.org (bras-base-mtrlpq0313w-grc-04-65-94-64-248.dsl.bell.ca. [65.94.64.248])
        by smtp.gmail.com with ESMTPSA id f1-20020a0ccc81000000b0061a68b5a8c4sm206168qvl.134.2023.06.07.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:18:32 -0700 (PDT)
Received: by DigitalMercury.freeddns.org (Postfix, from userid 1000)
        id 94CC2D690C9; Wed,  7 Jun 2023 18:18:31 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Phillip Susi <phill@thesusis.net>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
In-Reply-To: <PR3PR04MB7340C8A490ED5E5B5446879FD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <87zg5b821z.fsf@vps.thesusis.net>
 <PR3PR04MB7340C8A490ED5E5B5446879FD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Date:   Wed, 07 Jun 2023 18:18:23 -0400
Message-ID: <87edmmvrv4.fsf@DigitalMercury.freeddns.org>
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

Bernd Lentes <bernd.lentes@helmholtz-muenchen.de> writes:

>>-----Original Message-----
>>From: Phillip Susi <phill@thesusis.net>
>>Sent: Wednesday, June 7, 2023 10:09 PM
>>To: Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
>>Cc: Andrei Borzenkov <arvidjaar@gmail.com>; linux-btrfs@vger.kernel.org
>>Subject: Re: rollback to a snapshot
>
>>The last time I installed Ubuntu on btrfs, the installer automatically created a
>>top level subvolume named @ and actually installed the system in that
>>subvolume, then configured grub to tell the kernel to mount the root btrfs
>>volume with the flag subvol="@" so that the system would boot normally.
>>Then you just mount the real root of the filesystem somewhere else and make
>>a snapshot of the @ subvolume.  When you want to roll back, you just rename
>>@ to something else, and either rename or create a new writable snapshot
>>from your previous snapshot and name it @, then reboot.
>
> Do you remember which version it was ?
> You say " top level subvolume named @". You mean subvolid 5 ?
> " Then you just mount the real root of the filesystem". What do you mean by "real root" ?
> Does the subvolume @ already contain files or is it just a container for another subvolume ?
> "you just rename @ to something else". How can i rename a subvolume ? Just rename the corresponding directory ?
> " Then you just mount the real root of the filesystem somewhere else" Why ? With a bind mount ?
>
> Bernd

If I remember correctly, Ubuntu looks something like this

sudo btrfs sub list / -t
ID      gen     top level       path
--      ---     ---------       ----
347     477642  5               @
348     476215  5               @home

which is

subvolid=5
         |_ @
         |_ @home

and you shared this info in the initial thread:

> root@Microknoppix:/home/knoppix# mount|grep btrfs
> /dev/mapper/ubuntu--vg-ubuntu--lv on /mnt/btrfs type btrfs (rw,relatime,space_cache,subvolid=5,subvol=/)

> root@Microknoppix:/home/knoppix# btrfs sub list /mnt/btrfs
> ID 430 gen 1215864 top level 5 path .snapshots
> ID 434 gen 1213568 top level 430 path .snapshots/06-06-2023--15:16_PRE_UPGRADE
> ID 435 gen 1216086 top level 430 path .snapshots/06-06-2023
> I want to go back to ID 434 or 435.

So you have something like
1. subvolid=5
2.          |_ @
3.          |_ @home
4.          |_ snapshots
5.                     |_ 06-06-2023--15:16_PRE_UPGRADE
6.                     |_ 06-06-2023

subvolid=5 is always the "real root" I think Andrei Borzenkov is calling
it to mitigate the confusion resulting from potentially having used the
default subvolume feature, which in my opinion should never be used,
because it will confuse the bootloader.  A default Ubuntu installation
will have "subvol=@" in the bootloader, which means all that you need to
do is move your snapshot into place (position #2 in the above table)

So I think you're going to do something like the following: Mount the
true / (position #1) or subvolid=5 to /mnt/btrfs, then

  cd /mnt/btrfs/snapshots
  btrfs sub snap -r ../@ ./@_broken-upgrade  # note readonly "-r"
  cd ..
  # I still do a subvol sync and fi sync here
  btrfs sub del -c ./@
  # I still do a subvol sync and fi sync here
  btrfs sub snap ./snapshots/06-06-2023--15:16_PRE_UPGRADE ./@
  #             /\ note no readonly "-r"

If you stuck with Ubuntu defaults and didn't use the default subvolume
feature, then subvol=@ is still what grub will boot, and
06-06-2023--15:16_PRE_UPGRADE is now the new writable @.

I believe this is the safest method available.  The perfect snapshotting
tool would make it easier to see the relationship between snapshoted
copies of subvolumes.

Note that rootfs rollbacks won't fix potentially incompatibly upgraded
databases in @home (is that rare these days?).  There's not really any
good fix for that, other than to restore them from backup.  Note that
with this method you will lose a day's worth of everything in @ that
didn't have its own subvolume (ie logs, any VMs not in @home, etc).

For the record: If you consult the table above, the default subvolume
feature makes any subvolume become the user-apparent / of the
filesystem, and hides anything that's not beneath its tree.

'hope this helps,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmSBAjETHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYWl5D/0QfjlFNt00cos5YU61kfwyS/w4NBKH
evtHlauStmtCcAEI8R7LSgskWYsGs15GlnILJWBWBmerFWNuLvr1L1SuoFr4sDZW
/J4vBOfoMgv4OWJIkmhhugy5Wkf14YAagjs4kjHkzj5q5KMqjdEa2f3HXqYDWOGW
vbdDMAPPTa9O/wUHG59NfAAMZ229XsjuuZk22wWnyuT0YWPooOLlvsEIK/UIV9w+
Ph2Y3CBHIH+Ogoy1be9RfIyfFuennSGcBqPf9v7SUbINk9148+NGfhnQNLo5zOMN
xKEHcYYOK8WKJ+mbDaV3ch+MV8rVGIVg7vm5uwbuNaUTiqEqCd3RwwH4JDUJSIlB
Vu+kwhtAQs8GgRuZXDJQpiQ3gdH/RA6PQ5QnMTOVRh0SMQPVnIzUYQUrBTu/RtU/
UeInUX4nQtptwVdRKNLqfFOYt44Gyl7C9kups7yIcXDKdCtTKURtxrci68PnOXSQ
sNuCGWmjcBydiwRu4McuQcO5piSFhx/cdmMa2xEE1FJKifavi5Vzr97dZQqmycMp
AyAl7MJ+xxHhO+6fyZgTI4WET5EMHZFQWPmqmcjh3V6Ce/RhnPwkLFIrwJH+E9CC
OPncVXqaFtqOLfu2b5m3v2++60emm2gimRIA53LRg1CBWab1k3cFEPOYv8iD60fF
vcSC1p83mALv1g==
=b/H8
-----END PGP SIGNATURE-----
--=-=-=--
