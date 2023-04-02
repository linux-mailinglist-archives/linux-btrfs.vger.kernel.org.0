Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D436D39EF
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Apr 2023 21:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjDBTGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Apr 2023 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBTGM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Apr 2023 15:06:12 -0400
Received: from sm-r-011-dus.org-dns.com (sm-r-011-dus.org-dns.com [84.19.1.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F9CAF33
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Apr 2023 12:06:11 -0700 (PDT)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 10B00A0C65
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Apr 2023 21:06:10 +0200 (CEST)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 04D44A1E4C; Sun,  2 Apr 2023 21:06:10 +0200 (CEST)
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 2E417A0C65
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Apr 2023 21:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
        s=default; t=1680462451;
        bh=N4Jzu7NpPq9kzVSvvo6Vj7MwI7gVe2D4foencnzvzyw=; h=From:To:Subject;
        b=YrUifYGNjIYv0mAEgKEW+5fSkqbxra5DwXNjhXwrwMt6FadQwFR0inXYEGGxMXEZj
         XKHwaIUbHTu8l/Gj9miRIGuzwUL70z4RAk/QyZ2ucXrkQ5gXlwvjg/qSPHSsWHXXoy
         nAx8FiLsKtTAkLLLBc0dZpav9zh58PVIwJR4j+Pc=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 94.31.96.101) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Scrub errors unable to fixup (regular) error
Date:   Sun, 02 Apr 2023 19:06:07 +0000
Message-Id: <emb76b8ee4-a409-477e-b5f2-1189081e4c8e@59307873.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: <168046245130.13935.5026682426672509414@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

after a scrub, I had these errors:
[Sa Apr  1 23:23:28 2023] BTRFS info (device sda3): scrub: started on=20
devid 1
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3=20
errs: wr 0, rd 0, flush 0, corrupt 63, gen 0
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup=20
(regular) error at logical 2244718592 on dev /dev/sda3
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3=20
errs: wr 0, rd 0, flush 0, corrupt 64, gen 0
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup=20
(regular) error at logical 2260582400 on dev /dev/sda3
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3=20
errs: wr 0, rd 0, flush 0, corrupt 65, gen 0
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3=20
errs: wr 0, rd 0, flush 0, corrupt 66, gen 0
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup=20
(regular) error at logical 2260054016 on dev /dev/sda3
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup=20
(regular) error at logical 2259877888 on dev /dev/sda3
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3=20
errs: wr 0, rd 0, flush 0, corrupt 67, gen 0
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup=20
(regular) error at logical 2259935232 on dev /dev/sda3
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): bdev /dev/sda3=20
errs: wr 0, rd 0, flush 0, corrupt 68, gen 0
[Sa Apr  1 23:23:35 2023] BTRFS error (device sda3): unable to fixup=20
(regular) error at logical 2264600576 on dev /dev/sda3


root@homeserver:~# btrfs scrub status /dev/sda3
UUID:             c1534c07-d669-4f55-ae50-b87669ecb259
Scrub started:    Sat Apr  1 23:24:01 2023
Status:           finished
Duration:         0:09:03
Total to scrub:   146.79GiB
Rate:             241.40MiB/s
Error summary:    csum=3D239
   Corrected:      0
   Uncorrectable:  239
   Unverified:     0
root@homeserver:~# btrfs fi show /dev/sda3
Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
         Total devices 1 FS bytes used 146.79GiB
         devid    1 size 198.45GiB used 198.45GiB path /dev/sda3


Smartctl tells me:
SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE     =20
UPDATED  WHEN_FAILED RAW_VALUE
   1 Raw_Read_Error_Rate     0x002f   100   100   000    Pre-fail  Always=
=20
       -       2
   5 Reallocate_NAND_Blk_Cnt 0x0032   100   100   010    Old_age   Always=
=20
       -       2
   9 Power_On_Hours          0x0032   100   100   000    Old_age   Always=
=20
       -       4930
  12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always=
=20
       -       1864
171 Program_Fail_Count      0x0032   100   100   000    Old_age   Always=20
       -       0
172 Erase_Fail_Count        0x0032   100   100   000    Old_age   Always=20
       -       0
173 Ave_Block-Erase_Count   0x0032   049   049   000    Old_age   Always=20
       -       769
174 Unexpect_Power_Loss_Ct  0x0032   100   100   000    Old_age   Always=20
       -       22
183 SATA_Interfac_Downshift 0x0032   100   100   000    Old_age   Always=20
       -       0
184 Error_Correction_Count  0x0032   100   100   000    Old_age   Always=20
       -       0
187 Reported_Uncorrect      0x0032   100   100   000    Old_age   Always=20
       -       0
194 Temperature_Celsius     0x0022   068   051   000    Old_age   Always=20
       -       32 (Min/Max 9/49)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always=20
       -       2
197 Current_Pending_ECC_Cnt 0x0032   100   100   000    Old_age   Always=20
       -       0
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age  =20
Offline      -       0
199 UDMA_CRC_Error_Count    0x0032   100   100   000    Old_age   Always=20
       -       0
202 Percent_Lifetime_Remain 0x0030   049   049   001    Old_age  =20
Offline      -       51
206 Write_Error_Rate        0x000e   100   100   000    Old_age   Always=20
       -       0
246 Total_LBAs_Written      0x0032   100   100   000    Old_age   Always=20
       -       146837983747
247 Host_Program_Page_Count 0x0032   100   100   000    Old_age   Always=20
       -       4592609183
248 FTL_Program_Page_Count  0x0032   100   100   000    Old_age   Always=20
       -       4948954393
180 Unused_Reserve_NAND_Blk 0x0033   000   000   000    Pre-fail  Always=20
       -       2050
210 Success_RAIN_Recov_Cnt  0x0032   100   100   000    Old_age   Always=20
       -       0

What would you recommend wrt. the health of the drive (ssd) and to fix=20
these errors?

Best regards,
Hendrik

