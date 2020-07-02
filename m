Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFFD211F7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGBJLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 05:11:24 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:46140 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGBJLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 05:11:23 -0400
Received: from fe0vm1650.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 49yC550jDqz1XLDQw
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 11:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1593681081;
        bh=X0oETvpFcGplNJn3ohMC9pcbXvP9UDJwP0kLctCAZSI=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=IWVIyfiYFj3/kB4AmzLTrGCIwymH3hGjGnRI6pNlVQtemOo9Patl3SoFDsM6+k37e
         kUynn7VgPTFuM9PU701q8T/8lc0IjySBVA6WuUhP6r8wNAjn2sLbxvt6/59DO20CyO
         NnsSOOsLuusrgBZdcy1vClNT+/LfIxbENqbOhSi4=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 49yC546R16z3J1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 11:11:20 +0200 (CEST)
X-AuditID: 0a3aad14-e0fff70000003b75-54-5efda4b86d42
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 6C.2A.15221.8B4ADFE5; Thu,  2 Jul 2020 11:11:20 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (fe-mbx2029.de.bosch.com [10.3.231.39])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 49yC544QF0zvlG
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 11:11:20 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2029.de.bosch.com (10.3.231.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Thu, 2 Jul 2020 11:11:20 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::c815:e4fb:f7f:69ab]) by
 FE-MBX2029.de.bosch.com ([fe80::c815:e4fb:f7f:69ab%3]) with mapi id
 15.01.1979.003; Thu, 2 Jul 2020 11:11:20 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: FIEMAP ioctl gets "wrong" address for the extent
Thread-Topic: FIEMAP ioctl gets "wrong" address for the extent
Thread-Index: AdZQUL8TC28qUku1QeuTriBPGQAMhQ==
Date:   Thu, 2 Jul 2020 09:11:20 +0000
Message-ID: <cfd1d2842b4840b99539f00c34dc5701@rs.bosch.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.30.238]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCZbVWVnfHkr9xBi/bNC0uPV7B7sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGkkstzAXnWCvOnPzK2sB4gKWLkZNDQsBEYtPqSexdjFwcQgIz
        mCTOTv7KCOHcZZRo//OADcJ5wyjx5OwRJghnL6PE0fW97CD9bALOEucvLmYGsUUE7CWe/5zJ
        CmILC1hKHNu7nhUibidxpH85I4StJzFr8lGwOIuAikTP419MIDavgLXEqi0tYDajgKxEZ8M7
        MJtZQFzi1pP5TBC3Ckgs2XOeGcIWlXj5+B/QHA4gW1Fizm8liHIdiQW7P7FB2NoSyxa+ZoYY
        LyhxcuYTlgmMIrOQTJ2FpGUWkpZZSFoWMLKsYhRNSzUoyzU0NzHQK0pKLa4yMNRLzs/dxAgJ
        fpEdjCd7PugdYmTiYDzEKMHBrCTCe9rgV5wQb0piZVVqUX58UWlOavEhRmkOFiVxXhWejXFC
        AumJJanZqakFqUUwWSYOTqkGJmu1xpsCcbVTbYw2TFnyUXaVdeeiXkYznfWP7jmKh1w/6b99
        h8H2jfInDypw5d6udfsxdaMcUyrHwgU610MWfJTc/67qSOrVttluHK4LU2y+bnu6Qa+a973d
        0hWr557rMnUrbLBlKXpvau3X/Pqqy0Oeu8//vp8XvnPz5XaTK6zz2bN0+p6x3prbqi22uydx
        6pFitVPXvinLn9G+kvxCSyI7VTMl64LF94U3V6t0vg3JLPb8Y7WfT3rx0iU9RrHVTGbmT7Q7
        L4t6rM812MG3MaBO7EXcUu5lnetr5C4+C/N9KWyx7n5RuO3rljdPMn9OiDt0Leplis+rZyWL
        Q756uKy5PuXX/xzjU+a7Yk9vDlJiKc5INNRiLipOBACcJq2l7QIAAA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I'm collecting file extents for our application from BtrFs filesystem image=
.
I've noticed that for some files a get the "wrong" physical offset for star=
t of the extent. I verified it using hexdump of the filesystem image: when =
dump the content starting from the address returned from FIEMAP ioctl, I se=
e that the content is absolutely different from the content of the file its=
elf. Also, the FIEMAP ioctl reports regular extent, it is not inline.

Environment:
- 4.15.0-96-generic #97~16.04.1-Ubuntu SMP Wed Apr 1 03:03:31 UTC 2020 x86_=
64 x86_64 x86_64 GNU/Linux
- btrfs-progs v4.4

Does anyone has any idea? I would appreciate your help on this one.
Tnx.

Best regards,
Dejan
