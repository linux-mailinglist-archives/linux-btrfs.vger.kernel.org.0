Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB312539761
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 21:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347510AbiEaTvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347719AbiEaTu5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 15:50:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A6F69B6D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654026652;
        bh=WzxJEV2mbkLPTq5rrAyJ/tCykiYEk69HaLLEKETyMf8=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=BTGgeRIjmpit5JwvAwPA5gItFU2832luUgk7a9uLg8hlFyNQXmzcInYMewWJACTSd
         y1iZFiS5DX3Y0tSUwf5WAmf73buZJzYtp6PJfbIAHoc4Dtk6HtsDCT3TQmnrDq2+In
         Aq6EjABHevzsw2rOB5uQFLcfQUxgXspzO2gfDsMY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.0.0.100] ([217.227.44.38]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5rU-1o9EvE2emW-00M4Ri for
 <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 21:50:52 +0200
Message-ID: <9c3fec36-fc61-3a33-4977-a7e207c3fa4e@gmx.de>
Date:   Tue, 31 May 2022 21:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   =?UTF-8?Q?Lucas_R=c3=bcckert?= <lucas.rueckert@gmx.de>
Subject: [HELP] open_ctree failed when mounting RAID1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KTSz+TGrtMyutPw2cuErBHpGNq3pHo3ivzkdvL6bjYP2BG/ILOw
 Q6OvrHImJ8lT/lLxsaFkWvJQDlhcax/0Vxtcb2QXbGIGXzyRVQjFqb+2J7nRs9qDmW/lUMv
 8HvyU7TA7SVZWXjMt3grYHBaRL7Z/BJy3+t2g42h2TflTxctwcRmcxB+B/o0fYG9A9U6cMr
 N5pVAJQI9Bo5MFtX2nEWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PIU9wopapZU=:hirWQKmFF07pU6T9znLgmr
 WCJQr8gsf6RgyU2cT9XsvvDFfLV931D9QXjoN9sZEeSZd6X6VsO8JlThrOcYOW3Pjvr1KRzK5
 X0xGVWhYP9BEjj++HBRsfPH+5fdhGdfO0ctGm4jO3Eh/4HBoZR9RISmiY/ttPVGKcmd6OH8PK
 ZoYZdeqa+NbHs9mOuhLUZxjHlKxJ7DeY+BTM3BWg0oRG2gx2ztVYXyrp1ctAIZVHT5DNMKY49
 UzwRis7fWPg9k17Wr3Xi3mvzrfkhZeuI8Xzef1sS+WUhlSlqrXhbQUBi9l+sGM7lBP5IYb5be
 B8METN2mDp3swmRETEip1JwRjmXGDdNPu1JrxXMJ1wF6ZB7Ejsl8gvfJnI4KbHrUqxJvhQVvQ
 anOjWqdj+wZZkLaMYD8qD7xoK86RwSmtV6GslMktR6uRjXqgeMIrHaTAloDD+/uiacYUz+CKJ
 7Jk4dNAIxMPK4qfI38azgvAWn6wjfYASY5Cvjln4rNJ8vJ97Tu9gqwMyGVbQFaRQHKxP547DX
 +BIu6KW6KQOEuc0jHDKkcWteW9MIbLDDQyCos5RuZoGH1OM07FVaQwAGzv3XJpfTWBS1OiGsp
 1B24t1CdlUJxnrN8GE6jx+QbSM84wyidltMQJt4qf3cMIDO3VlG9+h8AmBNpeprVqiW+L5Rf3
 msrJ2rSrS2vm30wiUHELsogVgYn3fZ5R3jBBhkMX2MX3f/0lMORCO6O+zPhqLB2grON9w9gba
 3lNimW9LGOGslMOx9x6Whjbqd3HQRFbpFZtT0eNrOdd5hcX2xooYoj8pUfrq8SPG5kRyvNrPM
 WDE2lw2MPPTrT1UJCidrGnOqr24jIAex6AKoV/RkpIVklRVtbVhMunKoDTN8hLzGrGTWXIUFe
 N7zOuod5ehNDoxMzXIIl+iMQy4QBvuQ/1LFYQx2ZBcSP56EwBittSFzUbeiSp3JkF9XRL61jS
 Y9be6ca5CzQkWVL2hj7aJTTRDPdCfaJYy0qLzrziMEa/f8Mvis6QGJORDfX+CTOgnJ1+ZhNPV
 NRIULoHVG8AOPZs/gJEmsQEAcqmbZG2PaxrYXVeLTnxPma58VrsfrvVKqKqJh/GYnpb/U8E3Y
 H9CKbnZlY11PI2Q9RMaMmYBUo52DZt5U1Gz/yVaKmBvuoc/LdJnqAspug==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

i run two HHD's(sda;sdb) in RAID1.

Kernel: 4.9

Distro: Linux odroid 4.9.277-83 #1 SMP PREEMPT Mon Feb 28 15:16:26 UTC
2022 aarch64 aarch64 aarch64 GNU/Linux

btrfs-progs: 5.4.1

I created the filesystem with:

mkfs.btrfs -d raid1 -m raid1 -L somelable -f /dev/sda /dev/sdb


And added it to my fstab:

UUID=3D<uuid> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /mnt/somefolder =C2=A0=
=C2=A0=C2=A0 btrfs compress=3Dzstd=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 2


When running:

mount -a

i get an error:

mount: /mnt/backup: wrong fs type, bad option, bad superblock on
/dev/sda, missing codepage or helper program, or other error.


and dmesg reports:

BTRFS error (device sdb): open_ctree failed



Yours sincerely

Lucas

