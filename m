Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92E342BE5
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Mar 2021 12:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCTLPJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Mar 2021 07:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhCTLOn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Mar 2021 07:14:43 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E2C0613BC
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 03:49:31 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m132so1013541ybf.2
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Mar 2021 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BVX4kh6RjgvHZy07dkmCMs7oyZs3T1ItnVX4dgH/vDU=;
        b=NjqkdNmKkzxE2VtANBOHS0rflxVqvueFRgYdwGYhqE7LeYeL59Eo2LEDZPG+XyXzhz
         oI0Wfn3PLG2F0Iewgpw82txzZgisgf2BctGmeX01oHt4P7ovNASZVbbAuMxv/BImBHHp
         4JwhsJV2z49Z6uzOad9t36qIXhT45kY5gs35ctRGpCsOIAzu+47oPFnaXjmKGZfI20aA
         TNc8PEoU4TMLbpOqjwxoW9VVdXLmHXywJiDe6FdY/oCkUpayeRSRhbv/zAhvJqAI57Ny
         W3Vmz5vP6YCM99ZsPonAYuSVuwV8XN/uR1kIcxJ4juQE0PCBMiycXoyWGgPoGysmWKBj
         5BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BVX4kh6RjgvHZy07dkmCMs7oyZs3T1ItnVX4dgH/vDU=;
        b=jxrdne/PBY6J3cUXjMJZO8edCjyQpPLQ7JVPEMeO/1R4F4D6ab0GPxsBIW4BXYER8/
         W7jP4vXu7/mKSdiwJtXeyEfLjxpGVurMDvmIQeaH6sbkUe7XX8PETRFN/w2T4N6zb1Eb
         7hfuUX/HcF+Znb85+0p9KE1xTakPyPDscQT59PrpF1eej5BLJmoqjwZsRXQNS9iIJlC3
         VfS82v25qK24Qqv8hQgIanulS1pXA83hNV5AGsbHB6HHoohkRgZ3oJ7c0pk4SkcGg4MR
         8Zw3pwtGbQ8tPjNa5PjovEI9nkkDGLpUaqeXOH4BJ2OIwzvaNDVelzKUhmNhQHeNWCIy
         5Eyg==
X-Gm-Message-State: AOAM5307YPq4UkXkqSJiUQ/Y6V15GFCsrQhuXXLosrhgwK9RGQTQMNIx
        gJG8OGEgOPtl9q6ZHX/Bzlo2pqnRKgoiJkqozlsMbtsZ8L4gjQ==
X-Google-Smtp-Source: ABdhPJwpYungTW6n31MpI45ixa+x61Xlx0A8pQ5EU/NjpQ7+fiL7foORRXtz7av/s2gqGjHbFkYpyuT/GB93sqE4eIE=
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr4009470oto.133.1616222050885;
 Fri, 19 Mar 2021 23:34:10 -0700 (PDT)
MIME-Version: 1.0
From:   Dave T <davestechshop@gmail.com>
Date:   Sat, 20 Mar 2021 02:33:59 -0400
Message-ID: <CAGdWbB6JtU54uEOotj=H-DG_7oeUT5KZQG5uM-ibiC2YDbV5Nw@mail.gmail.com>
Subject: parent transid verify failed / ERROR: could not setup extent tree
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I hope to get  some expert advice before I proceed. I don't want to
make things worse. Here's my situation now:

This problem is with an external USB drive and it is encrypted.
cryptsetup open succeeds. But mount fails.k

    mount /backup
    mount: /backup: wrong fs type, bad option, bad superblock on
/dev/mapper/xusbluks, missing codepage or helper program, or other
error.

 Next the following command succeeds:

    mount -o ro,recovery /dev/mapper/xusbluks /backup

This is my backup disk (5TB), and I don't have another 5TB disk to
copy all the data to. I hope I can fix the issue without losing my
backups.

Next step I did:

        # btrfs check /dev/mapper/xyz
        Opening filesystem to check...
        parent transid verify failed on 2853827608576 wanted 29436 found 29433
        parent transid verify failed on 2853827608576 wanted 29436 found 29433
        parent transid verify failed on 2853827608576 wanted 29436 found 29433
        Ignoring transid failure
        leaf parent key incorrect 2853827608576
        ERROR: could not setup extent tree
        ERROR: cannot open file system

BTW, this command returns no result:

    which btrfs-zero-log

I don't have that script/application installed. I'm running Arch Linux. I have

core/btrfs-progs 5.11-1
llinux 5.11.7-arch1-1
