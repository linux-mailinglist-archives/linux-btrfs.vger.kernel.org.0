Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854AE6F0136
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 09:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbjD0HGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 03:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242898AbjD0HGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 03:06:33 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F4449F
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 00:06:30 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54fbee69fc4so92884457b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682579190; x=1685171190;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EBgEAMt7M9WuhUA20YfGudycOUVYssLAECD8Ipl9GqE=;
        b=pG5aNfp18De72IO5tAu4gmGgarFqnjxckd7rHjn2sRZHIjvD4Tv8z3D2aXgKUc0V87
         0ZrzGOV2brgnsEuOQQr4k44L03LqbMaSbB9dkBNeZDjO6u0X1WBVfmI3g9mKrzLq26DC
         GkHXCTxtoyPsQ95iJ+ElXw0xNvH/2A/16sWxk8ZonGRtCE61aAbcT05Y6vzbPZ/37Gys
         5KRe6C7Zu+UbHQIVDNQXRnTKjU+U8uzN3r6Tv6LzKZX2JxXjNid3kb+1TpVjpSc5/yKx
         S9KSdkWmLpMubGSMbBugAQtG7SEUTK4n3PmpLYTeV2lrAXk+MlGrBJP8U+N5OF0r2XI0
         QfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682579190; x=1685171190;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBgEAMt7M9WuhUA20YfGudycOUVYssLAECD8Ipl9GqE=;
        b=Bnpzb1dATL3HAUnqGBgbBwkGXCkUfzhc9VvwNYsIFuH8svfHxJaNX1p7OpyyjcZ2WK
         ZLBgcNyJBqjUHMwLnip+2KQ2WMYEDc1nSJPTA06JmGa01G1ZsiojIRftQYEjGZYny8pe
         L2PkO+Sj+c65+kYFDVV5RQT2bpBe6KBwOChOkfVDx/4nMFDqGOOp4qvmq/Zv0KxPd13n
         5U1gcVx/4LTtrh0IfazJfA2xFgkovR7fiHbA1Hz0fYPLbBYGtaM/7R5pppu2ijvM5Ua2
         UvvbECcdA1OwqxStyTzdP4qqYJTZbP3z1Bmnaj+ra44NFOBSnArN+iotkUiLDIZnYRKJ
         6U1w==
X-Gm-Message-State: AC+VfDw8g1kL0TsvuPKW4bYiPNAhro2WuPhLJ9lBe9ZBISVt8BLxH0Oo
        by/pLZGMLAUVpfs2WYnxMv4NrgCllxHhn2oK54e7t+Hop04=
X-Google-Smtp-Source: ACHHUZ58ObcF3nKtqPmpgBNB7bOttgcaunTZpsWLnam5lBmUq26Ur4mi9QSEFGpkJr76Iwormx9z93kWQZMids/tko8=
X-Received: by 2002:a0d:eb07:0:b0:54f:db74:8529 with SMTP id
 u7-20020a0deb07000000b0054fdb748529mr684159ywe.20.1682579189492; Thu, 27 Apr
 2023 00:06:29 -0700 (PDT)
MIME-Version: 1.0
From:   Igor Raits <igor.raits@gmail.com>
Date:   Thu, 27 Apr 2023 09:06:18 +0200
Message-ID: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
Subject: Failed to recover log tree
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

We are using btrfs on some of our VMs and after some bug somewhere,
kernel has crashed and the VM had to be rebooted. After that, 1 out of
4 drives was not able to mount.

I've tried a few commands but that did not help to recover it (I did
not run btrfs check --repair yet).
The kernel is 6.1.18 and btrfs-progs 6.0.2 compiled with the
experimental flag (as we used that to use block-group-tree).

Could you suggest some steps for recovery other than btrfs check
--repair to try out? Thanks in advance!

# mount -t btrfs -o recovery,ro /dev/vdf /mnt/ebs/minio2
 kernel:BTRFS critical (device vdf): corrupt leaf: root=5
block=3562706763776 slot=17 ino=407482430, invalid nlink: has 2 expect
no more than 1 for dir
 kernel:BTRFS critical (device vdf): corrupt leaf: root=5
block=3562706763776 slot=17 ino=407482430, invalid nlink: has 2 expect
no more than 1 for dir
 kernel:BTRFS error (device vdf): block=3562706763776 write time tree
block corruption detected
 kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
errno=-5 IO failure (Error while writing out transaction)
 kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
errno=-5 IO failure (Error while writing out transaction)
 kernel:BTRFS: error (device vdf: state EA) in
cleanup_transaction:1958: errno=-5 IO failure
 kernel:BTRFS: error (device vdf: state EA) in
cleanup_transaction:1958: errno=-5 IO failure
mount: /mnt/ebs/minio2: can't read superblock on /dev/vdf.
 kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
errno=-5 IO failure (Failed to recover log tree)
 kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
errno=-5 IO failure (Failed to recover log tree)
 kernel:BTRFS error (device vdf: state EA): open_ctree failed

# btrfs rescue super-recover -v /dev/vdf
All Devices:
    Device: id = 1, name = /dev/vdf

Before Recovering:
    [All good supers]:
        device name = /dev/vdf
        superblock bytenr = 65536

        device name = /dev/vdf
        superblock bytenr = 67108864

        device name = /dev/vdf
        superblock bytenr = 274877906944

    [All bad supers]:

All supers are valid, no need to recover

# btrfs-find-root /dev/vdf
Superblock thinks the generation is 3595442
Superblock thinks the level is 0
Found tree root at 3424157040640 gen 3595442 level 0
Well block 3424059916288(gen: 3595435 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3424054345728(gen: 3595434 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423941132288(gen: 3595431 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423913361408(gen: 3595430 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423724224512(gen: 3595429 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423618924544(gen: 3595428 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423522717696(gen: 3595419 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423509741568(gen: 3595418 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423381946368(gen: 3595417 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423254937600(gen: 3595411 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3423190253568(gen: 3595410 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257715638272(gen: 3595407 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257566904320(gen: 3595404 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257494061056(gen: 3595402 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257426460672(gen: 3595401 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257354846208(gen: 3595400 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257189138432(gen: 3595398 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257066291200(gen: 3595397 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3257054314496(gen: 3595395 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3256925880320(gen: 3595390 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3256790237184(gen: 3595384 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3256747343872(gen: 3595379 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3256734842880(gen: 3595378 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3256726290432(gen: 3595377 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070848090112(gen: 3595376 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070762254336(gen: 3595369 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070533402624(gen: 3595366 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070520950784(gen: 3595365 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070319542272(gen: 3595364 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070275878912(gen: 3595355 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070224957440(gen: 3595354 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070133649408(gen: 3595348 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3070109827072(gen: 3595347 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2889425747968(gen: 3595340 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2889301147648(gen: 3595339 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2889314811904(gen: 3595337 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2889158066176(gen: 3595332 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2889076523008(gen: 3595330 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2889007906816(gen: 3595329 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2888883896320(gen: 3595328 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2888770060288(gen: 3595326 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2888474230784(gen: 3595325 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2888414789632(gen: 3595324 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2654316625920(gen: 3595323 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2654292000768(gen: 3595322 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2654178476032(gen: 3595321 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2654046437376(gen: 3595317 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2653815832576(gen: 3595312 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2653688217600(gen: 3595311 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2653640425472(gen: 3595310 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503985594368(gen: 3595309 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503770832896(gen: 3595305 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503679131648(gen: 3595304 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503542685696(gen: 3595300 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503440711680(gen: 3595297 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503322124288(gen: 3595294 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503168000000(gen: 3595289 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503054426112(gen: 3595288 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503041384448(gen: 3595287 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2503445053440(gen: 3595285 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2412690669568(gen: 3595284 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2412570755072(gen: 3595281 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2221267697664(gen: 3595278 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2221141753856(gen: 3595275 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2221038993408(gen: 3595270 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220922290176(gen: 3595269 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220743933952(gen: 3595266 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220618924032(gen: 3595264 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220595019776(gen: 3595263 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220507889664(gen: 3595262 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220364578816(gen: 3595258 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220268486656(gen: 3595257 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220199788544(gen: 3595256 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220125945856(gen: 3595253 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220104859648(gen: 3595252 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219941019648(gen: 3595246 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219772805120(gen: 3595245 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219676188672(gen: 3595243 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219385782272(gen: 3595242 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219322032128(gen: 3595239 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219298471936(gen: 3595238 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219189157888(gen: 3595234 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2219168301056(gen: 3595233 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1725089398784(gen: 3595229 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1724993929216(gen: 3595224 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1724703211520(gen: 3595223 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1724590768128(gen: 3595214 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1124192288768(gen: 3595206 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1124086104064(gen: 3595204 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1123955785728(gen: 3595198 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1123796860928(gen: 3595188 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1123702702080(gen: 3595181 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1123696197632(gen: 3595180 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1123421716480(gen: 3595178 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 1123298459648(gen: 3595171 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 409090146304(gen: 3595168 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 408798691328(gen: 3595166 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 408693866496(gen: 3595163 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 408471683072(gen: 3595160 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 768655360(gen: 3595159 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 508542976(gen: 3595157 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 426082304(gen: 3595153 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 275447808(gen: 3595143 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 158154752(gen: 3595138 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 3069995843584(gen: 3594572 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0
Well block 2220640256000(gen: 3594469 level: 0) seems good, but
generation/level doesn't match, want gen: 3595442 level: 0

# btrfs inspect-internal dump-super /dev/vdf
superblock: bytenr=65536, device=/dev/vdf
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x50cf7576 [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            261534ef-b111-4056-8124-6dd207030548
metadata_uuid        261534ef-b111-4056-8124-6dd207030548
label            minio2
generation        3595442
root            3424157040640
sys_array_size        129
chunk_root_generation    3581791
root_level        0
chunk_root        25460736
chunk_root_level    1
log_root        3766932537344
log_root_transid (deprecated)    0
log_root_level        0
total_bytes        5498631880704
bytes_used        4346997747712
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0xb
            ( FREE_SPACE_TREE |
              FREE_SPACE_TREE_VALID |
              BLOCK_GROUP_TREE )
incompat_flags        0x371
            ( MIXED_BACKREF |
              COMPRESS_ZSTD |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA |
              NO_HOLES )
cache_generation    0
uuid_tree_generation    3595442
dev_item.uuid        1d32f1a0-6988-4ed4-b3cd-24d243baf975
dev_item.fsid        261534ef-b111-4056-8124-6dd207030548 [match]
dev_item.type        0
dev_item.total_bytes    5498631880704
dev_item.bytes_used    4820052213760
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
