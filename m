Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC461FF2DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgFRNVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 09:21:24 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:47630 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgFRNVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 09:21:24 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 49njJ15nChz4f3m1f
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 15:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1592486481;
        bh=areNsxa/zB8hmtXM1aK220Yb+wKHiJ0Y9YOkXkesyC8=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=QHDVkmgPznvD8dCe2H4gcl+eVF9EOJT8+WTdIl8jNVHQw88CGWT+OnHjkJfubnmaN
         Mi/NAcfGK8ZCFTpjZQcmTOE+0m9E+65MTK3fyEPPFF8T8xMdhbYfI4C9p6GNIMEYBk
         aErjkHOCNxA5HkFuHwy7m3VzFMXrZkOAw1Vimx4M=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 49njJ15Nf5zHCZ
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 15:21:21 +0200 (CEST)
X-AuditID: 0a3aad17-4b9ff7000000186c-34-5eeb6a5176b6
Received: from fe0vm1651.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id 43.73.06252.15A6BEE5; Thu, 18 Jun 2020 15:21:21 +0200 (CEST)
Received: from FE-MBX2028.de.bosch.com (fe-mbx2028.de.bosch.com [10.3.231.38])
        by fe0vm1651.rbesz01.com (Postfix) with ESMTPS id 49njJ14ZVjzvl7
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jun 2020 15:21:21 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2028.de.bosch.com (10.3.231.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Thu, 18 Jun 2020 15:21:21 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b]) by
 FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b%3]) with mapi id
 15.01.1979.003; Thu, 18 Jun 2020 15:21:21 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Physical address offset of the inline extent
Thread-Topic: Physical address offset of the inline extent
Thread-Index: AdZFbyvOGU84GVKARDy4IQ9SM0Ag6g==
Date:   Thu, 18 Jun 2020 13:21:21 +0000
Message-ID: <31850f19929b40e4ade80a264c1af97d@rs.bosch.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.184.223]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCZbVWVjcw63Wcwdep2haXHq9gd2D0+LxJ
        LoAxissmJTUnsyy1SN8ugSvj39aLrAWTWCru/zzE1sA4h7mLkZNDQsBE4tS/I2xdjFwcQgIz
        mCQmr7zMDOHcZZRYu7aFHcJ5yyhxZ/kzKGcPo8SveTsYQfrZBJwlzl9cDDZLRMBe4vnPmaxd
        jBwcwgKmEk++u0GErSTu7exkg7D1JOZdP8cEYrMIqEocuf8ArJVXwFri64LJLCA2o4CsRGfD
        O7AaZgFxiVtP5jNBnCogsWTPeaizRSVePv7HCmErSVw695gVol5HYsHuT2wQtrbEsoWvoeYL
        Spyc+YRlAqPILCRjZyFpmYWkZRaSlgWMLKsYRYszDcpyjQwsjPWKklKLqwwM9ZLzczcxQoJf
        fAfj/44PeocYmTgYDzFKcDArifA6/34RJ8SbklhZlVqUH19UmpNafIhRmoNFSZxXhWdjnJBA
        emJJanZqakFqEUyWiYNTqoGJQTnS5uOkH03Se/Kry9u3dxkbuKzfcV1t7xyzW1zvFtuGeM4W
        3qjd3cr+7F/aBEGtXI59EtFxebuZEz8sXqOvYXb7c/4DibbnOtHTdk4wEjExzZnUbXp95aKi
        rN7CZ19O93y+IPjSVZPzg2zuyvmTLX06lxa+PKs7V+1htYOYn8zHeG9V/dwpW64rm3oKThML
        fTjZcd2iE3emCHu35bnU5Sd8ZDR/lxLBsvjFI+cTE4Skzh9s7HQq0lL490PU/YlWMBfj7C8H
        gw7d7vjLmS/OHlOV6pDhz7Qkcml0lPWWNTbCzF+cTlRb7Uh+ctfl72oVkfdHTGduqpl390C+
        6I6wAGXHpzqXj2cVbzijmanEUpyRaKjFXFScCAAQy1Um7QIAAA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Does anybody know how to get an address offset of the file data inline exte=
nt?
Kernel returns 0 trough FS_IOC_FIEMAP ioctl, but I would really like to get=
 real physical offset if possible, most probably meaning:

In FS tree - on-disk address of the extent data item for the relevant file =
object + the offset within that item (0x15).

I was hoping that the key.objectid of key.type =3D EXTENT_ITEM would give m=
e such an information, but apparently this is not the case.

Thanks very much,

Dejan



