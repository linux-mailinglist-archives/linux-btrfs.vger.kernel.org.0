Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDDA577147
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiGPTzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 15:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPTzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 15:55:14 -0400
Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397542AF
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 12:55:13 -0700 (PDT)
Received: from APOLLO ([212.159.61.44])
        by smtp with ESMTPA
        id CnscoKLTSO2riCnsdoxmWH; Sat, 16 Jul 2022 20:55:11 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Zs/+lv3G c=1 sm=1 tr=0 ts=62d3179f
 a=AGp1duJPimIJhwGXxSk9fg==:117 a=AGp1duJPimIJhwGXxSk9fg==:17
 a=DAwyPP_o2Byb1YXLmDAA:9 a=L9DwQCMy54uqYXZy468A:9 a=CjuIK1q_8ugA:10
 a=ihKm7AoEDJlyv6ivJOgA:9 a=ITdVHhY7-e0A:10
X-AUTH: perdrix52@:2500
From:   "David C. Partridge" <david.partridge@perdrix.co.uk>
To:     <linux-btrfs@vger.kernel.org>
Subject: Oh dear - some new problems
Date:   Sat, 16 Jul 2022 20:55:09 +0100
Message-ID: <004c01d8994d$f5677800$e0366800$@perdrix.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_004D_01D89956.572C2E20"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdiZTXaGCvb/KXHaQ1KhdKKfeMTRUQ==
Content-Language: en-gb
X-CMAE-Envelope: MS4xfCNNKnwzP7MjmfWyDfgp4nj78a7gslk432qFcVtGeLz8LgD5/2Hwj3m4z5FrS85HFk/lmEVA0QIOCgVPdL28bkXkUHrnmYtgJh6gyAimojTA10wugCb+
 SyhEeN5sLkSRasLWa1lDNjVKBDegfIGbp0hK5A2SSUjm/dz7xFYG0DOW9v0NKcTvAdSEehoCSKNpqq83ReyQYxjOJqS2BE3UPWQ=
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_40,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_004D_01D89956.572C2E20
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I get an error log from a weekly btrfs scrub:

Scrub started:    Sat Jul 16 07:45:26 2022
Status:           finished
Duration:         6:12:24
Total to scrub:   9.99TiB
Rate:             455.57MiB/s
Error summary:    csum=36
  Corrected:      0
  Uncorrectable:  36
  Unverified:     0

Have now run the scrub again and it's showing errors even though it isn't
yet complete.

Please see attached journalctl log file

The raid array detected an error on one of the drives which I have now
replaced and the raid is now rebuilding ...

What should I do at this juncture.

Thanks, David


------=_NextPart_000_004D_01D89956.572C2E20
Content-Type: application/octet-stream;
	name="Btrfs problem.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Btrfs problem.log"

Jul 16 19:22:20 charon kernel: scrub_handle_errored_block: 25 callbacks =
suppressed
Jul 16 19:22:21 charon kernel: btrfs_printk: 50 callbacks suppressed
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11146, inode 93090, offset 2261442560, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11146, inode 93090, offset 2261442560, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11141, inode 93090, offset 2261966848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11141, inode 93090, offset 2261442560, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11141, inode 93090, offset 2261966848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11105, inode 93090, offset 2261966848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11105, inode 93090, offset 2261442560, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11105, inode 93090, offset 2261442560, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11105, inode 93090, offset 2261966848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11132, inode 93090, offset 2261442560, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11132, inode 93090, offset 2261442560, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11132, inode 93090, offset 2261966848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11132, inode 93090, offset 2261966848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11145, inode 93090, offset 2261966848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11145, inode 93090, offset 2261442560, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11145, inode 93090, offset 2261966848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11145, inode 93090, offset 2261442560, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11116, inode 93090, offset 2261966848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234103296 on dev /dev/sdc1, physical 5973244829696, =
root 11116, inode 93090, offset 2261966848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: btrfs_dev_stat_print_on_error: 23 =
callbacks suppressed
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 37, gen 0
Jul 16 19:22:21 charon kernel: scrub_handle_errored_block: 26 callbacks =
suppressed
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003234103296 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11116, inode 93090, offset 2261442560, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233579008 on dev /dev/sdc1, physical 5973244305408, =
root 11116, inode 93090, offset 2261442560, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 38, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003233579008 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11146, inode 93090, offset 2261970944, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11146, inode 93090, offset 2261970944, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11146, inode 93090, offset 2261446656, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11146, inode 93090, offset 2261446656, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11141, inode 93090, offset 2261970944, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11141, inode 93090, offset 2261970944, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11141, inode 93090, offset 2261446656, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11141, inode 93090, offset 2261446656, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11105, inode 93090, offset 2261446656, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11105, inode 93090, offset 2261970944, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11105, inode 93090, offset 2261970944, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11105, inode 93090, offset 2261446656, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11132, inode 93090, offset 2261446656, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11132, inode 93090, offset 2261970944, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11132, inode 93090, offset 2261970944, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11132, inode 93090, offset 2261446656, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11145, inode 93090, offset 2261446656, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11145, inode 93090, offset 2261970944, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11145, inode 93090, offset 2261970944, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11145, inode 93090, offset 2261446656, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11116, inode 93090, offset 2261446656, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11116, inode 93090, offset 2261970944, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234107392 on dev /dev/sdc1, physical 5973244833792, =
root 11116, inode 93090, offset 2261970944, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233583104 on dev /dev/sdc1, physical 5973244309504, =
root 11116, inode 93090, offset 2261446656, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 39, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003233583104 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 40, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003234107392 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11146, inode 93090, offset 2261975040, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11146, inode 93090, offset 2261975040, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11146, inode 93090, offset 2261450752, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11146, inode 93090, offset 2261450752, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11141, inode 93090, offset 2261975040, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11141, inode 93090, offset 2261975040, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11141, inode 93090, offset 2261450752, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11141, inode 93090, offset 2261450752, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11105, inode 93090, offset 2261975040, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11105, inode 93090, offset 2261975040, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11132, inode 93090, offset 2261975040, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11105, inode 93090, offset 2261450752, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11105, inode 93090, offset 2261450752, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11132, inode 93090, offset 2261975040, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11145, inode 93090, offset 2261975040, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11145, inode 93090, offset 2261975040, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11132, inode 93090, offset 2261450752, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11132, inode 93090, offset 2261450752, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11116, inode 93090, offset 2261975040, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234111488 on dev /dev/sdc1, physical 5973244837888, =
root 11116, inode 93090, offset 2261975040, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11145, inode 93090, offset 2261450752, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11145, inode 93090, offset 2261450752, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11116, inode 93090, offset 2261450752, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233587200 on dev /dev/sdc1, physical 5973244313600, =
root 11116, inode 93090, offset 2261450752, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 41, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003234111488 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 42, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003233587200 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11146, inode 93090, offset 2261979136, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11146, inode 93090, offset 2261979136, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11141, inode 93090, offset 2261979136, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11141, inode 93090, offset 2261979136, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11146, inode 93090, offset 2261454848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11146, inode 93090, offset 2261454848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11105, inode 93090, offset 2261979136, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11105, inode 93090, offset 2261979136, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11141, inode 93090, offset 2261454848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11141, inode 93090, offset 2261454848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11132, inode 93090, offset 2261979136, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11132, inode 93090, offset 2261979136, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11105, inode 93090, offset 2261454848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11105, inode 93090, offset 2261454848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11145, inode 93090, offset 2261979136, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11145, inode 93090, offset 2261979136, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11132, inode 93090, offset 2261454848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11132, inode 93090, offset 2261454848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11116, inode 93090, offset 2261979136, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234115584 on dev /dev/sdc1, physical 5973244841984, =
root 11116, inode 93090, offset 2261979136, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11145, inode 93090, offset 2261454848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11145, inode 93090, offset 2261454848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11116, inode 93090, offset 2261454848, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003233591296 on dev /dev/sdc1, physical 5973244317696, =
root 11116, inode 93090, offset 2261454848, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 43, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003234115584 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 44, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003233591296 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234119680 on dev /dev/sdc1, physical 5973244846080, =
root 11146, inode 93090, offset 2261983232, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234119680 on dev /dev/sdc1, physical 5973244846080, =
root 11146, inode 93090, offset 2261983232, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234119680 on dev /dev/sdc1, physical 5973244846080, =
root 11141, inode 93090, offset 2261983232, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234119680 on dev /dev/sdc1, physical 5973244846080, =
root 11141, inode 93090, offset 2261983232, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234119680 on dev /dev/sdc1, physical 5973244846080, =
root 11105, inode 93090, offset 2261983232, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234119680 on dev /dev/sdc1, physical 5973244846080, =
root 11105, inode 93090, offset 2261983232, length 4096, links 2 (path: =
tvshows/Star Trek Strange New Worlds/Season 01/Star Trek Strange New =
Worlds - S01E04 - Memento Mori.mkv)
Jul 16 19:22:21 charon kernel: BTRFS warning (device sdc1): checksum =
error at logical 6003234119680 on dev /dev/sdc1, physical 5973244846080, =
root 11132, inode 93090, offset 2261983232, length 4096, links 2 (path: =
torrents/sickchill/Star.Trek.Strange.New.Worlds.S01E04.1080p.WEB.H264-CAK=
ES[TGx]/star.trek.strange.new.worlds.s01e04.1080p.web.h264-cakes.mkv)
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 45, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003234119680 on dev /dev/sdc1
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): bdev /dev/sdc1 =
errs: wr 0, rd 0, flush 0, corrupt 46, gen 0
Jul 16 19:22:21 charon kernel: BTRFS error (device sdc1): unable to =
fixup (regular) error at logical 6003233595392 on dev /dev/sdc1

------=_NextPart_000_004D_01D89956.572C2E20--

