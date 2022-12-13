Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E164B218
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 10:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiLMJOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 04:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiLMJNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 04:13:40 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1DE2BE1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 01:12:53 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u19so16437719ejm.8
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 01:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tesseract-nl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0p+mvi7axm5pydAYuehnql10555xn9/Tpz6ZW1gChuw=;
        b=L6FZKbcsnPcTh30m1VWCX0L3O4Z/zZOikkZUjtWsbz9CgJtEkfrN9nr2+QBvPXZiNc
         A8emxd+j3sgyj1i8K49rC93WQMNb3cjOL0mGIY+wnGP9w76MCvM1bpC3bYBdRrpkItNU
         cSGcAHswiHmF7EUZ+sGd/VBpr4LZgbOF7C6v5r0gC4grzN9dyx+5DSHaaE3VpmURcYMG
         Ws2BRFVd2XEunYXGw4iXV89AHt8NxMdDBxt+jSpKKk8QS5OynYxO/I+WAgfrHDgr0GGY
         3X5M0+i69PBjv331KILgV77HEHAJO4FLUmGohSuxnsBnSA4JWP4QU4cNsLxeWYEgKtKh
         tlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0p+mvi7axm5pydAYuehnql10555xn9/Tpz6ZW1gChuw=;
        b=He2orS1CKRtjSgmPMLDiEnvwIxRoqdtvG5sMPSzQWQwj0SjAEEeOkQ87iglPrpRN8c
         COcyjLpIFIh4Rj9t3Pz2bNNmBMA9nOGaUmjGNvMH+q2kPYmnB3F7rmfTVtZR8PxdyBcu
         QfS1t2LzSaBiVKT0QriXZLhrJMPqEp3Fb/+bT8rcMzhQLnDfDspP88LLZiiVnIRZM+N4
         9ygWwXGzaMqsJackem5wqkwqABfuqU0ZN4BpwpvM9hLydKBpkrbd+OAAJTDQqsnHPUu6
         i2CEmGESaFSyQzIAziOxCCskb2zBgYqwLoMAirxCu501Pa9m9dt/mnbG6tPNe0qe/s7T
         cHog==
X-Gm-Message-State: ANoB5pl888a6YtvzLZ8drE2AwoSpO86q1CeoHrxnWGdAKhIQpBmoLyZl
        n0TJLDip7Xcs2+cOraTUMbgeH7LChmfgTkw8sA==
X-Google-Smtp-Source: AA0mqf6QLnz3/Xl+aE/KxeE/XrMrkrj7kTuOF1rfrKo3eg0cyksuBRVDtbMEPSFOQDKsXHJAOpI+Cw==
X-Received: by 2002:a17:906:c2cc:b0:7c0:f118:624b with SMTP id ch12-20020a170906c2cc00b007c0f118624bmr16328009ejb.44.1670922771860;
        Tue, 13 Dec 2022 01:12:51 -0800 (PST)
Received: from [100.115.250.36] ([84.17.46.6])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00779a605c777sm4248598ejc.192.2022.12.13.01.12.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:12:51 -0800 (PST)
From:   "Gerard Boor" <gerard@tesseract.nl>
To:     linux-btrfs@vger.kernel.org
Subject: Recurring CSUM errors in root -9 when balancing and various files on scrub
Date:   Tue, 13 Dec 2022 09:12:49 +0000
Message-Id: <em070178a7-5d53-4e5e-a8ae-0356b942932b@1f91cd2f.com>
Reply-To: "Gerard Boor" <gerard@tesseract.nl>
User-Agent: eM_Client/9.2.1222.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

I have a btrfs array consisting of 4 disks, using RAID-1 for data and=20
RAID-1c4 for metadata and system. I have added disks over time and this=20
has generally worked fine. The first 3 disks are all 8 TB and the newest=20
one (less than a week old) is 16TB.

After adding the latest disk, I ran a btrfs rebalance to move the data=20
around more sensibly. The rebalance for metadata worked (also from 1c3=20
to 1c4), but the rebalance for data keeps failing with errors like;

[152366.756416] BTRFS error (device sde): bdev /dev/sde errs: wr 0, rd=20
0, flush 0, corrupt 262, gen 0
[152366.757415] BTRFS warning (device sde): csum failed root -9 ino 1720=20
off 4055040 csum 0x19b6bbe6 expected csum 0x9bd067fb mirror 2

I was told that root -9 means these errors occur in the relocation tree=20
and not actually in the data itself. I managed to balance the array for=20
maybe 2/3rds by simply rebooting and rerunning the balance over and=20
over, but now it's at a point where it fails almost instantly when I try=20
to run it.

For reference, the command I'm using is  btrfs balance start -d=20
/mountpoint

When this problem first started, I ran a scrub to see what was wrong,=20
but the scrub returned clean.

Scrubbing is also where problem #2 comes in; whenever I run a scrub,=20
sometimes after leaving the whole thing turned off for days, there's a=20
50%-ish chance it returns with some corrupted CSUM error. In most of=20
these cases it's about 2 or 3 files max and the files seem entirely=20
random; sometimes brand new files, but often files that have been on the=20
array for years without being touched. In most of these CSUM error=20
cases, it also affects BOTH copies of the file and the file cannot be=20
fixed or recovered. I find it hard to believe that a file that's been=20
sitting there for years without issue is suddenly corrupted on both=20
disks it resides on and I think it may be related to the CSUM error I=20
face when rebalancing.

Things I have considered are; bad memory (though how would that corrupt=20
BOTH copies of a file that has been dormant for years?), or maybe a=20
messed up SATA controller resulting in frequent read errors that btrfs=20
sees as CSUM errors? The CSUM errors also affect all 4 disks, including=20
the brand new one.

Some system data;

# uname -a
Linux nasseract 5.10.0-18-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02)=20
x86_64 GNU/Linux
# btrfs --version
btrfs-progs v5.10.1
# btrfs fi show
Label: 'NassierDomer'  uuid: 99d9748a-2afa-421f-b56d-970c68dac58a
         Total devices 4 FS bytes used 10.76TiB
         devid    1 size 7.28TiB used 4.88TiB path /dev/sdb1
         devid    2 size 7.28TiB used 4.88TiB path /dev/sdd
         devid    3 size 7.28TiB used 5.96TiB path /dev/sdc
         devid    4 size 14.55TiB used 5.89TiB path /dev/sde
# btrfs fi df /srv/dev-disk-by-label-NassierDomer/
Data, RAID1: total=3D10.78TiB, used=3D10.75TiB
System, RAID1C4: total=3D32.00MiB, used=3D1.53MiB
Metadata, RAID1C4: total=3D12.00GiB, used=3D11.53GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

Relevant dmesg entries after boot;

[    7.998580] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0, rd=20
0, flush 0, corrupt 308, gen 0
[    7.998587] BTRFS info (device sdb1): bdev /dev/sdd errs: wr 0, rd 0,=20
flush 0, corrupt 300, gen 0
[    7.998590] BTRFS info (device sdb1): bdev /dev/sdc errs: wr 0, rd 0,=20
flush 0, corrupt 177, gen 0
[    7.998593] BTRFS info (device sdb1): bdev /dev/sde errs: wr 0, rd 0,=20
flush 0, corrupt 53, gen 0

Note that /dev/sde is less than a week old.

I'm tempted to gut this entire machine and replace everything except the=20
drives, but maybe someone has some better (cheaper) ideas to fix what is=20
going on here?

Thanks,
Gerard

