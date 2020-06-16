Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C591FB259
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgFPNlw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 09:41:52 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:52304 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgFPNlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 09:41:52 -0400
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 49mTrY2FMgz1XLDR8
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 15:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rs.bosch.com;
        s=key1-intmail; t=1592314909;
        bh=Blyw8H3U3Hs/DwLbRliK/Ii7eDdnWeT57W3KrO500o8=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=VNScMX2vt1o5FciQdk7GsonuO2nLnsIRgtubDu7Z7yiViAtjuIM4rG0cUaLoLKm7s
         Nh/EbV8k+KhWcEimJZgUPkWHdMeBxabDmqTwYVvxuaVybfLbweLyUiCRB1fei02yyU
         zMw3UkUESxpiKxLGDdR6pRZVujtuOa8OZY16rfGE=
Received: from si0vm02576.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 49mTrY0mshz6CjVXs
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 15:41:49 +0200 (CEST)
X-AuditID: 0a3aad0d-fddff70000004e65-8c-5ee8cc1cb091
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm02576.rbesz01.com (SMG Outbound) with SMTP id 77.A6.20069.D1CC8EE5; Tue, 16 Jun 2020 15:41:49 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (fe-mbx2029.de.bosch.com [10.3.231.39])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 49mTrX6lTbz6CjZP0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 15:41:48 +0200 (CEST)
Received: from FE-MBX2029.de.bosch.com (10.3.231.39) by
 FE-MBX2029.de.bosch.com (10.3.231.39) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1979.3; Tue, 16 Jun 2020 15:41:48 +0200
Received: from FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b]) by
 FE-MBX2029.de.bosch.com ([fe80::5cea:9c45:b636:5b%3]) with mapi id
 15.01.1979.003; Tue, 16 Jun 2020 15:41:48 +0200
From:   "Rebraca Dejan (BSOT/PJ-ES1-Bg)" <Dejan.Rebraca@rs.bosch.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Having troubles to disable inline extents
Thread-Topic: Having troubles to disable inline extents
Thread-Index: AdZD4YpxwA3ZaANaT02rXcz/vOG1VQ==
Date:   Tue, 16 Jun 2020 13:41:48 +0000
Message-ID: <2e956e490f6a430f9aa82fed3c8be08c@rs.bosch.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.151.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsXCZbVWVlf2zIs4g7N5Fpcer2B3YPT4vEku
        gDGKyyYlNSezLLVI3y6BK+PvTdeC/WwVR84dZGlgXMTaxcjJISFgIrG1+TGQzcUhJDCTSWJx
        8wV2COcBo8TKKysZIZy3jBLP7qxjg3D2MErM6uliAelnE3CWOH9xMTOILSJgL/H850ywucIC
        RhITZzeyQcTNJT5un8IOYetJTJw1AyzOIqAqse/eHiYQm1fAWmLzpxdgNqOArERnwzswm1lA
        XOLWk/lMELcKSCzZc54ZwhaVePn4H9QPihJrVzdC1etILNj9iQ3C1pZYtvA1M8R8QYmTM5+w
        TGAUmYVk7CwkLbOQtMxC0rKAkWUVo1hxpkFZroGRqbmZXlFSanGVgaFecn7uJkZI8PPuYNzZ
        9UHvECMTB+MhRgkOZiUR3nd7XsQJ8aYkVlalFuXHF5XmpBYfYpTmYFES51Xh2RgnJJCeWJKa
        nZpakFoEk2Xi4JRqYNokuHz3nlXaL2rt4hX+Lvzgs3jaPpu5GzPfqF+90/G2adqtyU5rI9S3
        75IofGJqcsGztDHoeJtQ7Gu9A2xHM3t/7hK9l+7fW5yxaX93rKfGrebAqFMmycuiU//+Kq1b
        dXWmd390/58FQfWfd/3ZvZlpSsDO3H3fmGVLD+mH75QrfXB71yT2VqXtDMffhL3LfsGY53Uz
        5rW60ez/yQdTgvcl9u9glr3x47/la13tgtCyNxY1i8pexmnzT/v388ur29yvj51JMKqeKH1h
        msben10/nZ4XTw/3us0f9v9G+c/KvV7Pcs82FxqvD0y98v6woFT35E9ONdvtZhw8ZnHJ9upz
        m4n2vx5vUp5zPcCnhzNKiaU4I9FQi7moOBEAZK49de0CAAA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

We are trying to add support for BTRFS in our project, so we started to exa=
mine this filesystem.
For the moment, we don't want inline extents for our tests, but we have dif=
ficulties to turn them off. I'm using 'max_inline=3D0' mount option to disa=
ble them, but I still see them for small files (< 50 Bytes) using FS_IOC_FI=
EMAP ioctl. Kernel log when executing mount:
[11051.642976] BTRFS info (device loop0): max_inline at 0
[11051.642978] BTRFS info (device loop0): disk space caching is enabled
[11051.642979] BTRFS info (device loop0): has skinny extents

Environment:
- 4.15.0-96-generic #97~16.04.1-Ubuntu SMP Wed Apr 1 03:03:31 UTC 2020 x86_=
64 x86_64 x86_64 GNU/Linux
- btrfs-progs v4.4

I would really appreciate your support on this.
Tnx.

Best regards,

Dejan Rebraca
BSOT/PJ-ES1-Bg
