Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061EF536E54
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 May 2022 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiE1UVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 May 2022 16:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiE1UVH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 May 2022 16:21:07 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9DF50035
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 13:21:02 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id s31so8550545qtc.3
        for <linux-btrfs@vger.kernel.org>; Sat, 28 May 2022 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=0957nLGseuH076pcsYem7j921UWi38JfN5X5A3yBhY0=;
        b=We0A1F4s9IKRWVx+UzgAHiMDyY5xSkwAvR6QEuJ+FJqa/Je7jNCf46Klm473PtL+yg
         EZqQdiiTxPVLlXbbx9ZKm3jbrI4MTuH/75xXwg29GXtqrcFYNtS+o0FSHl7eNAO+/6fe
         jmlH6HgaK7c4Tl44flTWk9IQsKTgS/SorHPTetWAqeb0V7mCFIyeemqe2WEOGatLaUfY
         YgOtAAQlu0SaII9vTAB+F70IPKcWhjvHYoFvHz6NmtGLf9nE+i+1XHZUfJCd3DnlsDFg
         unYpTUWoGfROTmJ1AQdqlTA5I/5EuVqmiXBZMQyrU97Bh6Qvo3fwUFETYDukRPWnolxp
         kISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0957nLGseuH076pcsYem7j921UWi38JfN5X5A3yBhY0=;
        b=qS+HUweykLE/1F286fJ714gWuQa9jLPKfwuRaxiP6J487/g4wmdPYVur6j6qzXFEIX
         /LeF1VUAYe3vM7omYwybSxPJ3iw7wBD7ceDmCfP7lIaEkC9XP2anid2/GQ2UPbcboxAH
         9mtQwhKEaMLNvvJ1c8UCLtvShYI6cdr8+ItGAgRRYO2RhIsEkkU5BS9MbsWca9dCENfa
         2SF3EX2XYz5VOhmiINy9k1MjJ8BPd7NvnKNaVGo5bSvbrKSlnFLvJWUlnZWHgIzExWLW
         3oEpha8dPJyHRtyMFF1hFpH11VJaSYNuD+KoaIPdQo1wtB39FpU6PPUWmj36Qnoll1Zi
         hpQA==
X-Gm-Message-State: AOAM531WJOvyZf0T+gtRWr17J2Ru5D8BDy09MAgzUHMWVSnPQgHt1xO6
        MflT3DcoDr87l7F8WigGm75qfRyAUcI=
X-Google-Smtp-Source: ABdhPJyC1qFEWc6HWDSfkoethjOPkDHE/keVa4OUNz/qUznBXNaxQlb8woil9Lv/ClqKWw5jKUsfKQ==
X-Received: by 2002:a05:622a:120a:b0:2ff:8258:45dc with SMTP id y10-20020a05622a120a00b002ff825845dcmr3400659qtx.189.1653769261475;
        Sat, 28 May 2022 13:21:01 -0700 (PDT)
Received: from DigitalMercury.freeddns.org (bras-base-mtrlpq0313w-grc-09-50-100-165-103.dsl.bell.ca. [50.100.165.103])
        by smtp.gmail.com with ESMTPSA id c17-20020a05620a269100b006a37eb728cfsm4913014qkp.1.2022.05.28.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 13:21:00 -0700 (PDT)
Received: by DigitalMercury.freeddns.org (Postfix, from userid 1000)
        id 3F338C570B3; Sat, 28 May 2022 16:21:00 -0400 (EDT)
From:   Nicholas D Steeves <nsteeves@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>, efkf@firemail.cc,
        Duncan <1i5t5.duncan@cox.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
In-Reply-To: <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
Date:   Sat, 28 May 2022 16:20:59 -0400
Message-ID: <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
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

Hi Chris, Efkf, Duncan, and anyone else reading this,

Chris Murphy <lists@colorremedies.com> writes:

>>#btrfs fi df /mnt/sd/
>>Data, RAID1: total=772.00GiB, used=771.22GiB
>>Data, single: total=1.00GiB, used=2.25MiB
>>System, RAID1: total=32.00MiB, used=96.00KiB
>>System, single: total=32.00MiB, used=48.00KiB
>>Metadata, RAID1: total=3.00GiB, used=1.54GiB
>>Metadata, single: total=1.00GiB, used=0.00B
>
> This is not good. Some of the data and some of the metadata
> (specifically system profile which is the chunk tree) is only
> available on one drive and I can't tell from this if it's on a drive
> that is missing or is spewing errors. Anything that has a single copy
> that's also damaged, cannot be recovered. Unfortunately this file
> system is not completely raid1 and that's likely one source of the
> problem. The chunk tree is really critical so if any part of it is bad
> and not redundant (no good copy) the file system is not likely
> repairable. Get the data out as best you can. If rescue=all mount
> option doesn't work, the next opportunity is btrfs restore, but it too
> depends on the chunk tree being intact. There is a 'btrfs restore
> chunk-tree' option that will scan all the drives looking for plausible
> fragments of the chunk tree to try and recover it but it takes a long
> time (hours).
>
> 48KiB of chunk tree, if it's corrupt, is quite a lot and might prevent
> quite a lot of recovery. Some older kernels would create single
> profile chunks when a raid1 file system was mounted in degraded,rw
> mode with a missing device. This happens silently. And then when the
> raid1 is back to full strength again, there's no automatic conversion
> or even a warning by the kernel that this critical metadata isn't
> redundant still. The burden right now is unfortunately on the user to
> identify this reduction in redundancy and make sure to do a filtered
> balance to convert the single chunks into raid1 chunks.
>

I reported this issue "Wed, 02 Mar 2016 20:25:46 -0500" with Subject
"incomplete conversion to RAID1?", and it now looks that there's
evidence that this bug isn't harmless after all.

Efkf, would you please confirm if the filesystem was created with Linux
and btrfs-progs 5.10.x? (please keep me in CC)

If anyone knows if this issue was fixed for 5.15, please share the good
news!


Regards,
Nicholas

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEE4qYmHjkArtfNxmcIWogwR199EGEFAmKShCsTHG5zdGVldmVz
QGdtYWlsLmNvbQAKCRBaiDBHX30QYZejEACXHlQhQh8F805bDpdHLijm/r3zTMMl
p7jXE0gqKqXpZMBX7evGo2lG+MzPA5h0SYzLQqMxM+HDzI8nbS+G2m/aB0MnO5fB
5SQZM7SZOw0My2ZgeKVFkDaqV0AboYHIirURRaEP529FBZvtZeAfXZMCauLdVTak
C8nhe4MTyAFXlru3xaqpciLr0RUQECTcVmZfyC51ICr2OVeyHmBx9CitIBRmE/5S
iYUbu7KSx42761gH9555szdSkHmIM0N1jTFBXucG8pvAh7YZaxaukvKk8Y8Lz1P7
dLFMER2ayZcOY00VoQT+53xxTxQYbi3zTw6GvqsmrvwnRqTtSi9/A7KEPkR0TGbu
KELSlRh8ZKOniLdaigvTjT89zXvP1JlWy0YEXq363r9nTEj1nHpdSf90b+RkAEg6
w4dCKD84+j5HmjSHdpp7n4ie6ZAIOYhMEN9FA0wVmh5dHV3eATYmNxGqhX2qbtDb
jKeeAvE9tbBuZnsGvvvzfMMuuhQGdxaSvbhRyGF0HwyDU3YykD3rdJJjAZpRf+TC
hpOaEroVM440QJFWQofZesknhgvnSSkLoeCeaCwczcZpbJCp4Zw/Te9xUkPArFz3
fV/BeFWV1PfwLinn0ULOYmQZ084qGqIT95k+fE47YHr5DxXvsE+d7/1Ppf1h4VkS
Yv7d5zxJSrxreg==
=MLS4
-----END PGP SIGNATURE-----
--=-=-=--
