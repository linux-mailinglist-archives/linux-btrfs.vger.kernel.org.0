Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D13A0E78
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhFIIH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 04:07:28 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33705 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbhFIIHZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 04:07:25 -0400
Received: by mail-ed1-f48.google.com with SMTP id f5so22659639eds.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jun 2021 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=COdIvH365UP0L7nv+ScIM3QNNrL0N/t+87FLJR4RvkA=;
        b=XPQ1CC1XOQX0NPHrsZc51b9CHOEK6s96VUmdeQKLIpSIdR/u+sOlRSfvWMSNvAgl8H
         jbpkQ3GaXSEaLX+IwS+YEyn4o9Ju9mCXjE3fgkxhN9iQIQ8yiYiOz9zHG9v6JD4F0hTR
         6xs0JFjmr4UOfYcqdppneDqfupSOG2sVuwwXidEtvoHXjpUk+tphGbPQWbJ/qL2C3o/D
         jLV4PUosxXbohGLQMZYcMCAXMgc9EQuH9z5kObdA/ZvmHshIX5y2iW/VRjjxAma64EMO
         /UoaLq0pk50ScsIhRjCmMq67gpefC1zFzuT6PenVoU5zWE0MIwWZKCl3UM/4qSH0JJWC
         lnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COdIvH365UP0L7nv+ScIM3QNNrL0N/t+87FLJR4RvkA=;
        b=Dtxusx6lMRFEGeu6hYGrLh5YuUIP2Z3goOpZbfnf/msonZBpMmYViEMJMMTYP9jW3F
         TTV6w1nK3WVURi4oMWoMow9ypafuJtxBB2f9QM6NG5V34RpqZzlO70kUvcA7cDkdOdIl
         4Alng0LzASohqLxdR92TrRM7DZmR9l2C0XEIaAYkk4omzzmQjlpn6LOiaLgska4k42GN
         u3VD0y9zQzAOwBFMpeE7DkOW9p+uWfJ5FyezyR/Zvj5Ss194i/I4oQYBbZewUKw16Baw
         xbqS47K5dcCCaKTb8mvRMu4yoz+aaE4RmopU27tdRZdXuDwXKkHFRgBvkopZu1au7qzx
         A//Q==
X-Gm-Message-State: AOAM530Dm4gBBRkB97fJSgt/ciaHGUJZKa7Z+tJh4S9zXddsfvNeVudT
        Dvwch5NYCDQfQXwSC1efydX97IlOLQyPFA==
X-Google-Smtp-Source: ABdhPJzMasWs1xCO4qg8rKVgt4DxyCX/11CqqMASKqGbfmBOMEIWLAZBOiu59UgVq1SH3WKQQd9n0g==
X-Received: by 2002:a05:6402:344:: with SMTP id r4mr29075472edw.226.1623225859238;
        Wed, 09 Jun 2021 01:04:19 -0700 (PDT)
Received: from localhost.localdomain ([176.92.65.46])
        by smtp.gmail.com with ESMTPSA id qq26sm749667ejb.6.2021.06.09.01.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 01:04:18 -0700 (PDT)
From:   auxsvr <auxsvr@gmail.com>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Write time tree block corruption detected
Date:   Wed, 09 Jun 2021 11:04:17 +0300
Message-ID: <4656165.31r3eYUQgx@localhost.localdomain>
In-Reply-To: <b5596fac-26a1-5c5a-5653-62175073484a@gmx.com>
References: <1861574.PYKUYFuaPT@localhost.localdomain> <b45698d3-b208-bcec-52b4-5c8e70804148@gmx.com> <b5596fac-26a1-5c5a-5653-62175073484a@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wednesday, 9 June 2021 04:05:18 EEST Qu Wenruo wrote:
> # btrfs ins dump-tree -t dev /dev/sda2
# btrfs ins dump-tree -t dev /dev/sda2
btrfs-progs v4.19.1 
device tree key (DEV_TREE ROOT_ITEM 0) 
leaf 181304705024 items 59 free space 11984 generation 1049986 owner DEV_TREE
leaf 181304705024 flags 0x1(WRITTEN) backref revision 1
fs uuid 44c67fa4-e2c4-4da5-9d07-98959ff77bc4
chunk uuid e09a0d7a-15ec-48ef-89fa-adaa5ec52990
        item 0 key (0 PERSISTENT_ITEM 1) itemoff 16243 itemsize 40
                persistent item objectid 0 offset 1
                device stats
                write_errs 0 read_errs 0 flush_errs 0 corruption_errs 0 generation 0
        item 1 key (1 DEV_EXTENT 22020096) itemoff 16195 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 229569986560 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 2 key (1 DEV_EXTENT 1095761920) itemoff 16147 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 537007226880 length 33554432
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 3 key (1 DEV_EXTENT 2169503744) itemoff 16099 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 227422502912 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 4 key (1 DEV_EXTENT 3243245568) itemoff 16051 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 226348761088 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 5 key (1 DEV_EXTENT 4316987392) itemoff 16003 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 225275019264 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 6 key (1 DEV_EXTENT 5390729216) itemoff 15955 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 224201277440 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 7 key (1 DEV_EXTENT 6464471040) itemoff 15907 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 223127535616 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 8 key (1 DEV_EXTENT 7538212864) itemoff 15859 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 222053793792 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 9 key (1 DEV_EXTENT 8611954688) itemoff 15811 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 220980051968 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 10 key (1 DEV_EXTENT 9685696512) itemoff 15763 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 315011104768 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 11 key (1 DEV_EXTENT 10759438336) itemoff 15715 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 295851524096 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 12 key (1 DEV_EXTENT 11833180160) itemoff 15667 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 437149237248 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 13 key (1 DEV_EXTENT 12906921984) itemoff 15619 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 187694055424 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 14 key (1 DEV_EXTENT 14014218240) itemoff 15571 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 181251604480 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 15 key (1 DEV_EXTENT 15087960064) itemoff 15523 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 328164442112 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 16 key (1 DEV_EXTENT 16161701888) itemoff 15475 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 379972485120 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 17 key (1 DEV_EXTENT 17235443712) itemoff 15427 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 531168755712 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 18 key (1 DEV_EXTENT 18309185536) itemoff 15379 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 457684549632 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 19 key (1 DEV_EXTENT 19382927360) itemoff 15331 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 347860893696 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 20 key (1 DEV_EXTENT 20456669184) itemoff 15283 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 345142984704 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 21 key (1 DEV_EXTENT 21530411008) itemoff 15235 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 532242497536 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 22 key (1 DEV_EXTENT 23644340224) itemoff 15187 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 183399088128 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 23 key (1 DEV_EXTENT 24718082048) itemoff 15139 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 537040781312 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 24 key (1 DEV_EXTENT 25791823872) itemoff 15091 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 208095150080 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 25 key (1 DEV_EXTENT 26865565696) itemoff 15043 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 207021408256 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 26 key (1 DEV_EXTENT 27939307520) itemoff 14995 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 205947666432 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 27 key (1 DEV_EXTENT 29013049344) itemoff 14947 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 204873924608 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 28 key (1 DEV_EXTENT 30086791168) itemoff 14899 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 203800182784 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 29 key (1 DEV_EXTENT 31160532992) itemoff 14851 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 202726440960 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 30 key (1 DEV_EXTENT 32234274816) itemoff 14803 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 201652699136 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 31 key (1 DEV_EXTENT 33308016640) itemoff 14755 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 200578957312 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 32 key (1 DEV_EXTENT 34381758464) itemoff 14707 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 199505215488 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 33 key (1 DEV_EXTENT 35455500288) itemoff 14659 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 198431473664 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 34 key (1 DEV_EXTENT 36529242112) itemoff 14611 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 460905775104 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 35 key (1 DEV_EXTENT 37602983936) itemoff 14563 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 196283990016 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 36 key (1 DEV_EXTENT 38676725760) itemoff 14515 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 259097886720 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 37 key (1 DEV_EXTENT 39750467584) itemoff 14467 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 184472829952 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 38 key (1 DEV_EXTENT 40824209408) itemoff 14419 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 195210248192 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 39 key (1 DEV_EXTENT 41897951232) itemoff 14371 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 182325346304 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 40 key (1 DEV_EXTENT 42971693056) itemoff 14323 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 194136506368 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 41 key (1 DEV_EXTENT 44045434880) itemoff 14275 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 186620313600 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 42 key (1 DEV_EXTENT 45119176704) itemoff 14227 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 188767797248 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 43 key (1 DEV_EXTENT 46192918528) itemoff 14179 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 189841539072 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 44 key (1 DEV_EXTENT 47266660352) itemoff 14131 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 193062764544 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 45 key (1 DEV_EXTENT 48340402176) itemoff 14083 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 191989022720 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 46 key (1 DEV_EXTENT 49414144000) itemoff 14035 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 190915280896 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 47 key (1 DEV_EXTENT 50487885824) itemoff 13987 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 280606277632 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 48 key (1 DEV_EXTENT 51561627648) itemoff 13939 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 471576084480 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 49 key (1 DEV_EXTENT 52635369472) itemoff 13891 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 282753761280 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 50 key (1 DEV_EXTENT 53709111296) itemoff 13843 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 523384127488 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 51 key (1 DEV_EXTENT 54782853120) itemoff 13795 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 524625641472 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 52 key (1 DEV_EXTENT 55856594944) itemoff 13747 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 526202699776 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 53 key (1 DEV_EXTENT 56930336768) itemoff 13699 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 533316239360 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 54 key (1 DEV_EXTENT 58004078592) itemoff 13651 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 264802140160 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 55 key (1 DEV_EXTENT 59077820416) itemoff 13603 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 433558913024 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 56 key (1 DEV_EXTENT 60151562240) itemoff 13555 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 534389981184 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 57 key (1 DEV_EXTENT 61225304064) itemoff 13507 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 290303508480 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
        item 58 key (1 DEV_EXTENT 62299045888) itemoff 13459 itemsize 48
                dev extent chunk_tree 3
                chunk_objectid 256 chunk_offset 535463723008 length 1073741824
                chunk_tree_uuid 00000000-0000-0000-0000-000000000000
total bytes 64424509440
bytes used 46488170496
uuid 44c67fa4-e2c4-4da5-9d07-98959ff77bc4

> # btrfs ins dump-super /dev/sda2
# btrfs ins dump-super /dev/sda2
superblock: bytenr=65536, device=/dev/sda2
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x5c8acbc2 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    44c67fa4-e2c4-4da5-9d07-98959ff77bc4
metadata_uuid           44c67fa4-e2c4-4da5-9d07-98959ff77bc4
label
generation              1050015
root                    181625438208
sys_array_size          97
chunk_root_generation   1047576
root_level              1
chunk_root              537007226880
chunk_root_level        0
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             64424509440
bytes_used              46488170496
sectorsize              4096
nodesize                16384
leafsize (deprecated)           16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x161
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        1050015
uuid_tree_generation    1047664
dev_item.uuid           abc9d19a-d9d1-40a4-9bd5-f28654800249
dev_item.fsid           44c67fa4-e2c4-4da5-9d07-98959ff77bc4 [match]
dev_item.type           0
dev_item.total_bytes    64424509440
dev_item.bytes_used     63451430912
dev_item.io_align       0
dev_item.io_width       0
dev_item.sector_size    0
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

Thanks,
Petros


