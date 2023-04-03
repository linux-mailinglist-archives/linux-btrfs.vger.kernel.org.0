Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222EA6D3E22
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 09:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjDCHeJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Apr 2023 03:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDCHeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Apr 2023 03:34:07 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF9902A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Apr 2023 00:34:05 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <off-centre@100flowers.tech>)
        id 1pjDzy-00Gthk-9O
        for linux-btrfs@vger.kernel.org; Mon, 03 Apr 2023 08:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=100flowers.tech; s=selector2; h=Message-Id:Date:Subject:To:From:
        MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=3xU63VCzgeDPzh9+3dUg5uEY1zytEkDJf0YGtfWj1cE=; b=oUhiREcnUb5xLG2GoXgCKBeb74
        vGj+lEcoyFNpus2RQtxcrbq3+kmpHasX2Uv+WDtMzhgsCiUXWFqkXd0pKZ8zBjsIZLimli7HwjW2u
        tG/a7GrAVVddcIHQXWCsFM5bcPW5YJUPmIf5zIBLtcjXoR5ZrvYKPhLLWnVoGKf26PkEcn6e/ESb7
        wu8s1HegC812LIn3Jmgs7zCmYHhJ1QFNJq8CiocA526AZF4pr9u7InsLIf/580Z5ATme8k5gLwaeJ
        cs2OHiXcfgl0SwymckD3gaXOqbkG/UH0OpJa3Fr48SA7p29HPCUaBSyDT2lojh+oWfxZKjOfc3jG+
        7B9Io3fw==;
Received: from [10.9.9.127] (helo=rmmprod05.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <off-centre@100flowers.tech>)
        id 1pjDzy-0000F9-1q
        for linux-btrfs@vger.kernel.org; Mon, 03 Apr 2023 08:49:02 +0200
Received: from mail by rmmprod05.runbox with local (Exim 4.86_2)
        (envelope-from <off-centre@100flowers.tech>)
        id 1pjDzy-0002yU-0u
        for linux-btrfs@vger.kernel.org; Mon, 03 Apr 2023 08:49:02 +0200
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received: from [Authenticated alias (1047917)] by runbox.com with http
 (RMM6); for <linux-btrfs@vger.kernel.org>; Mon, 03 Apr 2023 06:49:01 GMT
From:   "Craig Silva" <off-centre@100flowers.tech>
To:     "linux-btrfs" <linux-btrfs@vger.kernel.org>
Subject: btrfs mirror fails to mount - corrupt leaf
Date:   Mon, 03 Apr 2023 16:49:01 +1000 (AEST)
X-RMM-Aliasid: 1047917
X-Mailer: RMM6
Message-Id: <E1pjDzy-0002yU-0u@rmmprod05.runbox>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs filesystem show
Label: none  uuid: 34f2c6cc-2665-4b9b-9503-356c83066d33
Total devices 2 FS bytes used 864.48GiB
devid    1 size 3.18TiB used 2.02TiB path /dev/sda1
devid    2 size 3.18TiB used 2.02TiB path /dev/sdb1

blkid
/dev/sdb1: UUID=3D"34f2c6cc-2665-4b9b-9503-356c83066d33" UUID_SUB=3D"5c40e6=
1e-04d0-4025-8c97-be4a12da719a" TYPE=3D"btrfs" PARTLABEL=3D"primary" PARTUU=
ID=3D"c0bde629-1d0c-44d9-a48a-6f4657627428"
/dev/sda1: UUID=3D"34f2c6cc-2665-4b9b-9503-356c83066d33" UUID_SUB=3D"05db5d=
7d-92e9-46d3-a7bf-655af00ccb85" TYPE=3D"btrfs" PARTLABEL=3D"primary" PARTUU=
ID=3D"3a5b7725-0be5-4935-89ae-2b67813cbc07"

btrfs-find-root /dev/sda1
incorrect offsets 5447 33559879
Superblock thinks the generation is 1443155
Superblock thinks the level is 1

All supers are valid

dmesg:

BTRFS critical (device sda1): corrupt leaf: root=3D2 block=3D546514255872 s=
lot=3D205, unexpected item end, have 33559879 expect 5447
BTRFS critical (device sda1): corrupt leaf: root=3D2 block=3D546514255872 s=
lot=3D205, unexpected item end, have 33559879 expect 5447
BTRFS error (device sda1): failed to read block groups: -5
BTRFS error (device sda1): open_ctree failed
BTRFS info (device sda1): disk space caching is enabled
BTRFS info (device sda1): has skinny extents
BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd 0, flush 0, corrupt=
 11, gen 0
BTRFS info (device sda1): bdev /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt=
 11, gen 0

I checked hardware both sda and sdb with smartctl and no apparent errors.

I'm in the process of a restore (ho-hum) - but it would be nice if there wa=
s a way of fixing it
