Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376DCD95D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfJPPkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 11:40:15 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35935 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfJPPkO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 11:40:14 -0400
Received: by mail-wm1-f51.google.com with SMTP id m18so3298400wmc.1
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2019 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=liland-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=34o9j1zSktGtBupQXhHUPymaQoRhq/kdv25PyWS5f/8=;
        b=I4EmlGF1ykPeBNP/ze7aRKLLo/z44SZN/E2dbOsKftHZk6VUdPPA847xrcuNRnfB0T
         C+ypQ3SPbuWCa4oy62gVwtZXX4+UqQBW5jfLnFoV7dvMubnFRugOnJAdmv/DImXa3uPO
         i6pfzLN2q8aGBNAfcrb0yV6Nmjgad6s1W24Uaqr4hPAO3a6d8RQKarSDFiOBebLxgi8r
         2MTEdapkai5yyCaVqwu1ZjD0aSMgIv5YOvtEoVq0CmqblJUhl5ui+x2lNCnx2shnntdS
         1zVWo7h93STMjuTOy2LKOy3JrfTUONSZN1MEy2KprDm7gv0i2jtYTW5DspS0adMxwH0A
         7+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=34o9j1zSktGtBupQXhHUPymaQoRhq/kdv25PyWS5f/8=;
        b=A8HYLyvGUCY3OrPPg/iN2uamWbbirftm/ZMuZYroMsHjtpvn9JBpdXjkaVxUIJ+MhJ
         XCGL+aa2uB+yfV1kNK3kDjin+HiegtOQ4rikvW2PsBsi57RC21U10KKLX9OAgenPE0x0
         Z1tl4Bjz8aigxRtau3JhOaisFWhicDlCcETBBufHniEPQgp8BNjmSU6VwF1PYXJ7COwD
         ifSPK+nob4cntJiM/vvCCDqUtGXX5HF+1RMVvsiJGRj6COU+sf+XjDYnHFNoAK5kdWyk
         cyIHPjCl0nhB370xSgsQyvpNCyxPYP21JP7DLcgvhXWYUzOeNN34zzxpd1QAmIPXpHQP
         QjlA==
X-Gm-Message-State: APjAAAVrHiH1thnk0pautAsLnBmcZpcSlcrX7cT9WrWa5PDsKJKqIWlH
        Ya05bMg0KHMWgT1eUcXj3Qfil+6L1F3shnHjOCg59uVCdFlSpQ+qnE1KDcANAVA8Vq03JkZlfuJ
        T1wSU+/pQZaTFq/YdyGY/O0Yu
X-Google-Smtp-Source: APXvYqzEhuXVgG9qRBW8Jdp8NRndAhr/BQpBWpWUl8ADdCnHJGn78+6IvYbuj0QN49waEqNMbFb+Jw==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr3693630wmi.136.1571240412451;
        Wed, 16 Oct 2019 08:40:12 -0700 (PDT)
Received: from [192.168.0.121] ([62.218.42.35])
        by smtp.gmail.com with ESMTPSA id s13sm3121055wmc.28.2019.10.16.08.40.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 08:40:11 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Edmund Urbani <edmund.urbani@liland.com>
Subject: MD RAID 5/6 vs BTRFS RAID 5/6
Message-ID: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
Date:   Wed, 16 Oct 2019 17:40:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello everyone,

having recovered most of my data from my btrfs RAID-6, I have by now migrat=
ed to
mdadm RAID (with btrfs on top). I am considering switching back to btrfs RA=
ID
some day, when I feel more confident regarding its maturity.

I put some thought into the pros and cons of this choice that I would like =
to share:

btrfs RAID-5/6:

- RAID write hole issue still unsolved (assuming
https://btrfs.wiki.kernel.org/index.php/RAID56 is up-to-date)
+ can detect and fix bit rot
+ flexibility (resizing / reshaping)
- maturity ? (I had a hard time recovering my data after removal of a drive=
 that
had developed some bad blocks. That's not what I would expect from a RAID-6
setup. To be fair I should point out that I was running kernel 4.14 at the =
time
and did not do regular scrubbing.)

btrfs on MD RAID 5/6:

+ options to mitigate RAID write hole
- bitrot can only be detected but not fixed
+ mature and proven RAID implementation (based on personal experience of
replacing plenty of drives over the years without data loss)

I would be interested in getting your feedback on this comparison. Do you a=
gree
with my observations? Did I miss anything you would consider important?

Regards,
=C2=A0Edmund





--=20
*Liland IT GmbH*


Ferlach =E2=97=8F Wien =E2=97=8F M=C3=BCnchen
Tel: +43 463 220111
Tel: +49 89=20
458 15 940
office@Liland.com
https://Liland.com <https://Liland.com>=C2=A0



Copyright =C2=A9 2019 Liland IT GmbH=C2=A0

Diese Mail enthaelt vertrauliche und/oder=20
rechtlich geschuetzte=C2=A0Informationen.=C2=A0
Wenn Sie nicht der richtige Adressat=20
sind oder diese Email irrtuemlich=C2=A0erhalten haben, informieren Sie bitt=
e=20
sofort den Absender und vernichten=C2=A0Sie diese Mail. Das unerlaubte Kopi=
eren=20
sowie die unbefugte Weitergabe=C2=A0dieser Mail ist nicht gestattet.=C2=A0

This=20
email may contain confidential and/or privileged information.=C2=A0
If you are=20
not the intended recipient (or have received this email in=C2=A0error) plea=
se=20
notify the sender immediately and destroy this email. Any=C2=A0unauthorised=
=20
copying, disclosure or distribution of the material in this=C2=A0email is=
=20
strictly forbidden.

