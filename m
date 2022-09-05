Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28F95ADBC5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 01:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiIEXQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 19:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIEXQR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 19:16:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4514C50713
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Sep 2022 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662419772;
        bh=FmN2sEVW0LJD4GMNAZpSb1VrWamntcR5tyCA4M8QsPU=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=G2TiqBiygUeqN6vpDOteZQFVuF79VH3SQShcxO7Jw09xrc+48wPLaRO7aOMc6iPgn
         dmyBWpZ2eAgneHWiE8V9lkwScds6Igyf0BiVzi4wVKe+ciILoY7UxsyT6sVsMBbzg0
         j9R5HcerdWxuoqEJ2mu+4lY2gaq7N/AiwI4QnWZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [87.122.255.189] ([87.122.255.189]) by web-mail.gmx.net
 (3c-app-gmx-bap56.server.lan [172.19.172.126]) (via HTTP); Tue, 6 Sep 2022
 01:16:12 +0200
MIME-Version: 1.0
Message-ID: <trinity-2ed29f2d-59e7-439a-893d-3fc3b41be07f-1662419772647@3c-app-gmx-bap56>
From:   Steve Keller <keller.steve@gmx.de>
To:     linux-btrfs@vger.kernel.org
Subject: RAID1/RAID0, online replace
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 6 Sep 2022 01:16:12 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:SHWC69N5Hr5YfpcdxoCob66LQ7muehylyuGcBv5rTXucc1dbyxdSGukQMUrnCR1/yU2FR
 87IMHDCIhGn0Fo8RILWfuUoQ7Qq6TcIRfaFGzK8Pn2OUAOHLAb44pOXjKaIuTokebtpf0alynx0F
 ATzYK+ZFeV4v7NLnUWUPJ3atkx4+vaGQKwTZ+AYxJmRc2OuJy3H7CPuPEO1149PAulCdeioPuq/d
 zweqyNZ2d8v2TJhcmJtG0qTeokSfF0qv05J2GifMK77TASuKQGT/89g27z7NhioHcFovyhyCNxQ+
 CQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:vxZ2p5qxmJk=:eQgfH9USE0BtXT96GoQHdc
 CjwuqEji6aDm2OnZd/UKln9Jt6DZJKGux3EA+dGjKF7P/ED7wwNiumAhxUewfn8wcMN4cNUTv
 sVTBaNTPmqYZtH/mx1cv1jGAnCnoWiahkat814iL0zVfWlXQGQR7yizT0YvE03VRUyYFwcr+9
 n2A3igbgKRP9coJxQwEKarUz3/HymGljfxdbJly+CfsqWCTNrR35gWllslEQbQUUsLJr0mxo6
 zasrTNJjKfFsn5XYnQWMW6DuImY0EV50bEGKy0oMkTmBpwtzzDPgoDGPWaSG1TCy3KnTHzVqd
 6fnKZyM+biNWREs3jpegzPPtFOmSmE2PTKSk9GTWcZmkOA4a/fOtKDI9mPe7Fvl23/m/nMweU
 s18raqOxR9ITpCXpvvIcbTKmF+EtiwKSEygOiTGEDwDiVai/n3iHioeRZ4zcIzaEllgwNPLNV
 Z1PW0pv860aICHSY17LsPau2JbRyRZ5IuRZO/MbxFa87PBW/R1z4g/kBZLUk/vP0WgDIovGjv
 f7oVlR4S4Y7LiUniS2LLt90sOM6Z2asuVJJPKh06oMLMk4BgJ0TZ/6D71kTxPnjbePIjoBRTn
 GC2Ol9O0iqWdlgrSx9F2KkzAidwgkgct3BZfO1I5NIKv8tXOXzVL9y02hRhrqkaJUMxaeiSPV
 gLTOg9kiBo7qkeS0dU3IsaQZqwWXZBuR9pDKr7egDsywkNi06D1l8dYXrtX/hD+n1MVnwUh/m
 iwfugpCuScOAWyKw/ty8oIgNQ+YSXxul4tapUZtWGmrCSQynZxtBD/X8hwPlDPDEnTHNa7zJc
 svG8edP
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A few questions on RAID1 on BTRFS:

1. With RAID1, can I replace a failed disk online, i.e. without
   unmounting the filesystem?  If yes, what happens with files that
   have data blocks which have only one copy?  Are they deleted?  Will
   the FS still be in a clean state?

2. Can I have some files with data blocks in RAID1 and other files in
   RAID0 or single mode?  Can I set this per directory?  E.g. I have
   directories with large multimedia files which change seldom or
   never, which I have in the backup, and for which I don't need high
   availability by RAID1.  Other directories, e.g. source code, change
   often which I'd like to have RAID1 for.

   If that's not possible, can RAID1 for data vs. RAID0 be configured
   per sub-volume?

Steve

