Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779677A9E72
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjIUUCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 16:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjIUUBf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 16:01:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D91FF0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:22:29 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502a4f33440so2204431e87.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316947; x=1695921747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QjINkp9z0WEbRds+MydXEcFTuy82AewMj2v/F6ND/M=;
        b=Bpfgraa8oeWS+mHzcoSVYO+tKDItXDvK2aLouAbUX4B+gxdnplo9SGFq0sJm6LF/ia
         9pTmJ7QQd9jRa/Yy8UMzaoM5FLeLz9R+9PVjr35lHo+GA6ruiLeX7+JCHbmZyHBmwtH7
         cvKOW9xSGpV8evIwQNaxskQP/xowwFKZgF+h78g7PdiAk3roC896K2eUS3hMql1qHhLh
         9dWhLPkZ0qIQAVmQGBW34wBEsy6oE/19mHUSX/pUlYLwPz1ioRJconqvczpYYriF2mQk
         IC/xyz/mgynXxXWHh2CXLOX2PQuPeh3/aO4MhrLvubGTsjbAxeWt6k9gjjN4LaX17AFW
         2S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316947; x=1695921747;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0QjINkp9z0WEbRds+MydXEcFTuy82AewMj2v/F6ND/M=;
        b=RZ095lUigF3P4XeoD74l9pAqtf3RRofsEtyE6hufVu220SJo3RyXVkjnQ+hgfAZOXy
         plTC9ALE0dFnxTaxZYpi7T9GK7zOw4BAcMXvbBjy015ovlJoeoFl21XifhxhcTEFsnt/
         4JiSR2PO+hw6jCFdfsdnuvvVjT6kHxoTFKPwUWIE4d5sNCRv5Q0hsx5hIqxgAu8/uYHi
         pFNcxIiEx4Dc0IdbMGbmWQcXsKd18do/tbW80wsLvw0jWrvfbL3XtG4kdrSrEHibMjzW
         KVqzDZSv+RVItIFRURDmciQYnejgo5zNYJu55Ov5lcdnEEHUZnM4Pmb0OygYxagMOQUX
         ZAQQ==
X-Gm-Message-State: AOJu0YxX4eUGRARpyMSoNgKctwwsgwOWRmrQXTlw3/oN43kJOmcYTLnM
        ayvcHauT8lQdb8eUgnds831ll9IHQ5O5FA==
X-Google-Smtp-Source: AGHT+IHVRyHwrECpPw7m53ZTBcbLUbJB26eA+ldPi2C9CrnhxinUFrr8PxMi56TaVG+0MAVWisZWmg==
X-Received: by 2002:aa7:d758:0:b0:522:3d36:ff27 with SMTP id a24-20020aa7d758000000b005223d36ff27mr4826251eds.31.1695302857152;
        Thu, 21 Sep 2023 06:27:37 -0700 (PDT)
Received: from [192.168.3.88] (ppp-94-68-116-207.home.otenet.gr. [94.68.116.207])
        by smtp.googlemail.com with ESMTPSA id z25-20020aa7c659000000b00530ba0fd672sm819975edr.75.2023.09.21.06.27.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 06:27:36 -0700 (PDT)
Message-ID: <3c93d0b5-a8cb-ebe3-f8d6-76ea6340f23e@gmail.com>
Date:   Thu, 21 Sep 2023 16:27:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
Subject: btrfstune --convert-to-block-group-tree segfaulted. now filesystem is
 unmountable
To:     linux-btrfs@vger.kernel.org
Content-Language: el-en, en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,
i tried to convert my BTRFS filesystem to block-group-tree but it
segfaulted and now the fs is not mountable.

❯ btrfstune --convert-to-block-group-tree /dev/sda
[1]    174047 segmentation fault (core dumped)  btrfstune
--convert-to-block-group-tree /dev/sda


[2531715.190802] btrfstune[174047]: segfault at 1f ip 000055ec409fd198
sp 00007ffd0a772eb0 error 4 in btrfstune[55ec409d6000+6a000] likely on
CPU 3 (core 2, socket 0)
[2531715.190818] Code: 40 00 f3 0f 1e fa 41 56 41 55 49 89 fd 41 54 49
89 f4 55 89 d5 53 48 8b 5f 68 49 89 ee 48 85 db 74 3f 48 8d 74 35 00 0f
1f 00 <48> 8b 43 20 48 8b 4b 28 48 01 c1 49 39 cc 0f 83 8c 00 00 00 48 39

[174131]: Process 174047 (btrfstune) of user 0 dumped core.

                                                  Stack trace of thread
174047:
                                                  #0  0x000055ec409fd198
alloc_extent_buffer (btrfstune + 0x34198)
                                                  #1  0x000055ec409ee4f5
read_tree_block (btrfstune + 0x254f5)
                                                  #2  0x000055ec409db5a6
read_node_slot (btrfstune + 0x125a6)
                                                  #3  0x000055ec409e6e2d
n/a (btrfstune + 0x1de2d)
                                                  #4  0x000055ec409e8a4d
n/a (btrfstune + 0x1fa4d)
                                                  #5  0x000055ec409def01
btrfs_search_slot (btrfstune + 0x15f01)
                                                  #6  0x000055ec409e9c79
btrfs_insert_empty_items (btrfstune + 0x20c79)
                                                  #7  0x000055ec40a0090c
n/a (btrfstune + 0x3790c)
                                                  #8  0x000055ec40a05185
n/a (btrfstune + 0x3c185)
                                                  #9  0x000055ec40a05c75
add_to_free_space_tree (btrfstune + 0x3cc75)
                                                  #10 0x000055ec40a3ec49
n/a (btrfstune + 0x75c49)
                                                  #11 0x000055ec409fb52a
btrfs_run_delayed_refs (btrfstune + 0x3252a)
                                                  #12 0x000055ec40a13091
btrfs_commit_transaction (btrfstune + 0x4a091)
                                                  #13 0x000055ec409dcfdd
convert_to_bg_tree (btrfstune + 0x13fdd)
                                                  #14 0x000055ec409d640a
main (btrfstune + 0xd40a)
                                                  #15 0x00007f44ace27cd0
n/a (libc.so.6 + 0x27cd0)
                                                  #16 0x00007f44ace27d8a
__libc_start_main (libc.so.6 + 0x27d8a)
                                                  #17 0x000055ec409d7db5
_start (btrfstune + 0xedb5)
                                                  ELF object binary
architecture: AMD x86-64


❯ btrfstune --convert-from-block-group-tree /dev/sda
ERROR: filesystem doesn't have block-group-tree feature


❯ mount /dev/sda /storage/btrfs -o ro
mount: /storage/btrfs: wrong fs type, bad option, bad superblock on
/dev/sda, missing codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.

Sep 19 17:18:23 elsinki kernel: BTRFS info (device sda): using crc32c
(crc32c-generic) checksum algorithm
Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): unrecognized
or unsupported super flag: 274877906944
Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): superblock
contains fatal errors
Sep 19 17:18:23 elsinki kernel: BTRFS error (device sda): open_ctree failed


❯ btrfstune --convert-to-block-group-tree /dev/sda
ERROR: failed to find block group for bytenr 20196285349888
ERROR: failed to convert the filesystem to block group tree feature
extent buffer leak: start 17825576632320 len 16384

❯ btrfs filesystem show
Label: none  uuid: 5a583d35-3eb2-410b-9044-1ac87a062247
        Total devices 3 FS bytes used 9.53TiB
        devid    1 size 3.64TiB used 3.64TiB path /dev/sda
        devid    2 size 3.64TiB used 3.64TiB path /dev/sdc
        devid    3 size 3.64TiB used 3.64TiB path /dev/sdd

❯ btrfs check --mode lowmem /dev/sda
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: 5a583d35-3eb2-410b-9044-1ac87a062247
[1/7] checking root items
[2/7] checking extents
ERROR: chunk [20197359091712 20198432833536) doesn't have related block
group item
ERROR: chunk [20198432833536 20199506575360) doesn't have related block
group item
ERROR: chunk [20199506575360 20200580317184) doesn't have related block
group item
ERROR: chunk [20200580317184 20201654059008) doesn't have related block
group item
ERROR: chunk [20201654059008 20202727800832) doesn't have related block
group item
ERROR: chunk [20202727800832 20203801542656) doesn't have related block
group item
ERROR: chunk [20203801542656 20204875284480) doesn't have related block
group item
ERROR: chunk [20204875284480 20205949026304) doesn't have related block
group item
ERROR: chunk [20205949026304 20207022768128) doesn't have related block
group item
ERROR: chunk [20207022768128 20208096509952) doesn't have related block
group item
ERROR: chunk [20208096509952 20209170251776) doesn't have related block
group item
ERROR: chunk [20209170251776 20210243993600) doesn't have related block
group item
ERROR: chunk [20210243993600 20211317735424) doesn't have related block
group item
ERROR: chunk [20211317735424 20212391477248) doesn't have related block
group item
ERROR: chunk [20212391477248 20213465219072) doesn't have related block
group item
ERROR: chunk [20213465219072 20214538960896) doesn't have related block
group item
ERROR: chunk [20214538960896 20215612702720) doesn't have related block
group item
ERROR: chunk [20215612702720 20216686444544) doesn't have related block
group item
ERROR: chunk [20216686444544 20217760186368) doesn't have related block
group item
ERROR: chunk [20217760186368 20218833928192) doesn't have related block
group item
ERROR: chunk [20218833928192 20219907670016) doesn't have related block
group item
ERROR: chunk [20219907670016 20220981411840) doesn't have related block
group item
ERROR: chunk [20220981411840 20222055153664) doesn't have related block
group item
ERROR: chunk [20222055153664 20223128895488) doesn't have related block
group item
ERROR: chunk [20223128895488 20224202637312) doesn't have related block
group item
ERROR: chunk [20224202637312 20225276379136) doesn't have related block
group item
ERROR: chunk [20225276379136 20226350120960) doesn't have related block
group item
ERROR: chunk [20226350120960 20227423862784) doesn't have related block
group item
ERROR: chunk [20227423862784 20228497604608) doesn't have related block
group item
ERROR: chunk [20228497604608 20229571346432) doesn't have related block
group item
ERROR: chunk [20229571346432 20230645088256) doesn't have related block
group item
ERROR: chunk [20230645088256 20231718830080) doesn't have related block
group item
ERROR: chunk [20231718830080 20232792571904) doesn't have related block
group item
ERROR: chunk [20232792571904 20233866313728) doesn't have related block
group item
ERROR: chunk [20233866313728 20234940055552) doesn't have related block
group item
ERROR: chunk [20234940055552 20236013797376) doesn't have related block
group item
ERROR: chunk [20236013797376 20237087539200) doesn't have related block
group item
ERROR: chunk [20237087539200 20238161281024) doesn't have related block
group item
ERROR: chunk [20238161281024 20239235022848) doesn't have related block
group item
ERROR: chunk [20239235022848 20240308764672) doesn't have related block
group item
ERROR: chunk [20240308764672 20241382506496) doesn't have related block
group item
ERROR: chunk [20241382506496 20242456248320) doesn't have related block
group item
ERROR: chunk [20243529990144 20244603731968) doesn't have related block
group item
ERROR: chunk [20244603731968 20245677473792) doesn't have related block
group item
ERROR: chunk [20245677473792 20246751215616) doesn't have related block
group item
ERROR: chunk [20246751215616 20247824957440) doesn't have related block
group item
ERROR: chunk [20247824957440 20248898699264) doesn't have related block
group item
ERROR: chunk [20248898699264 20249972441088) doesn't have related block
group item
ERROR: chunk [20249972441088 20251046182912) doesn't have related block
group item
ERROR: chunk [20251046182912 20252119924736) doesn't have related block
group item
ERROR: chunk [20252119924736 20253193666560) doesn't have related block
group item
ERROR: chunk [20253193666560 20254267408384) doesn't have related block
group item
ERROR: chunk [20254267408384 20255341150208) doesn't have related block
group item
ERROR: chunk [20255341150208 20256414892032) doesn't have related block
group item
ERROR: chunk [20256414892032 20257488633856) doesn't have related block
group item
ERROR: chunk [20257488633856 20258562375680) doesn't have related block
group item
ERROR: chunk [20258562375680 20259636117504) doesn't have related block
group item
ERROR: chunk [20259636117504 20260709859328) doesn't have related block
group item
ERROR: chunk [20260709859328 20261783601152) doesn't have related block
group item
ERROR: chunk [20261783601152 20262857342976) doesn't have related block
group item
ERROR: chunk [20262857342976 20263931084800) doesn't have related block
group item
ERROR: chunk [20263931084800 20265004826624) doesn't have related block
group item
ERROR: chunk [20265004826624 20266078568448) doesn't have related block
group item
ERROR: chunk [20266078568448 20267152310272) doesn't have related block
group item
ERROR: chunk [20267152310272 20268226052096) doesn't have related block
group item
ERROR: chunk [20268226052096 20269299793920) doesn't have related block
group item
ERROR: chunk [20269299793920 20270373535744) doesn't have related block
group item
ERROR: chunk [20270373535744 20271447277568) doesn't have related block
group item
ERROR: chunk [20271447277568 20272521019392) doesn't have related block
group item
ERROR: chunk [20272521019392 20273594761216) doesn't have related block
group item
ERROR: chunk [20273594761216 20274668503040) doesn't have related block
group item
ERROR: chunk [20274668503040 20275742244864) doesn't have related block
group item
ERROR: chunk [20275742244864 20276815986688) doesn't have related block
group item
ERROR: chunk [20276815986688 20277889728512) doesn't have related block
group item
ERROR: chunk [20277889728512 20278963470336) doesn't have related block
group item
ERROR: chunk [20278963470336 20280037212160) doesn't have related block
group item
ERROR: chunk [20280037212160 20281110953984) doesn't have related block
group item
ERROR: chunk [20281110953984 20282184695808) doesn't have related block
group item
ERROR: chunk [20282184695808 20283258437632) doesn't have related block
group item
ERROR: chunk [20283258437632 20284332179456) doesn't have related block
group item
ERROR: chunk [20284332179456 20285405921280) doesn't have related block
group item
ERROR: chunk [20285405921280 20286479663104) doesn't have related block
group item
ERROR: chunk [20286479663104 20287553404928) doesn't have related block
group item
ERROR: chunk [20287553404928 20288627146752) doesn't have related block
group item
ERROR: chunk [20288627146752 20289700888576) doesn't have related block
group item
ERROR: chunk [20289700888576 20290774630400) doesn't have related block
group item
ERROR: chunk [20290774630400 20291848372224) doesn't have related block
group item
ERROR: chunk [20291848372224 20292922114048) doesn't have related block
group item
ERROR: chunk [20292922114048 20293995855872) doesn't have related block
group item
ERROR: chunk [20293995855872 20295069597696) doesn't have related block
group item
ERROR: chunk [20295069597696 20296143339520) doesn't have related block
group item
ERROR: chunk [20296143339520 20297217081344) doesn't have related block
group item
ERROR: chunk [20297217081344 20298290823168) doesn't have related block
group item
ERROR: chunk [20298290823168 20299364564992) doesn't have related block
group item
ERROR: chunk [20299364564992 20300438306816) doesn't have related block
group item
ERROR: chunk [20300438306816 20301512048640) doesn't have related block
group item
ERROR: chunk [20301512048640 20302585790464) doesn't have related block
group item
ERROR: chunk [20302585790464 20303659532288) doesn't have related block
group item
ERROR: chunk [20303659532288 20304733274112) doesn't have related block
group item
ERROR: chunk [20304733274112 20305807015936) doesn't have related block
group item
ERROR: chunk [20305807015936 20306880757760) doesn't have related block
group item
ERROR: chunk [20306880757760 20307954499584) doesn't have related block
group item
ERROR: chunk [20307954499584 20309028241408) doesn't have related block
group item
ERROR: chunk [20309028241408 20310101983232) doesn't have related block
group item
ERROR: chunk [20310101983232 20311175725056) doesn't have related block
group item
ERROR: chunk [20311175725056 20312249466880) doesn't have related block
group item
ERROR: chunk [20312249466880 20313323208704) doesn't have related block
group item
ERROR: chunk [20313323208704 20314396950528) doesn't have related block
group item
ERROR: chunk [20314396950528 20315470692352) doesn't have related block
group item
ERROR: chunk [20315470692352 20316544434176) doesn't have related block
group item
ERROR: chunk [20316544434176 20317618176000) doesn't have related block
group item
ERROR: chunk [20317618176000 20318691917824) doesn't have related block
group item
ERROR: chunk [20318691917824 20319765659648) doesn't have related block
group item
ERROR: chunk [20319765659648 20320839401472) doesn't have related block
group item
ERROR: chunk [20320839401472 20321913143296) doesn't have related block
group item
ERROR: chunk [20321913143296 20322986885120) doesn't have related block
group item
ERROR: chunk [20322986885120 20324060626944) doesn't have related block
group item
ERROR: chunk [20324060626944 20325134368768) doesn't have related block
group item
ERROR: chunk [20325134368768 20326208110592) doesn't have related block
group item
ERROR: chunk [20326208110592 20327281852416) doesn't have related block
group item
ERROR: chunk [20327281852416 20328355594240) doesn't have related block
group item
ERROR: chunk [20328355594240 20329429336064) doesn't have related block
group item
ERROR: chunk [20329429336064 20330503077888) doesn't have related block
group item
ERROR: chunk [20330503077888 20331576819712) doesn't have related block
group item
ERROR: chunk [20331576819712 20332650561536) doesn't have related block
group item
ERROR: chunk [20332650561536 20333724303360) doesn't have related block
group item
ERROR: chunk [20333724303360 20334798045184) doesn't have related block
group item
ERROR: chunk [20334798045184 20335871787008) doesn't have related block
group item
ERROR: chunk [20335871787008 20336945528832) doesn't have related block
group item
ERROR: chunk [20336945528832 20338019270656) doesn't have related block
group item
ERROR: chunk [20338019270656 20339093012480) doesn't have related block
group item
ERROR: chunk [20339093012480 20340166754304) doesn't have related block
group item
ERROR: chunk [20340166754304 20341240496128) doesn't have related block
group item
ERROR: chunk [20341240496128 20342314237952) doesn't have related block
group item
ERROR: chunk [20342314237952 20343387979776) doesn't have related block
group item
ERROR: chunk [20343387979776 20344461721600) doesn't have related block
group item
ERROR: chunk [20344461721600 20345535463424) doesn't have related block
group item
ERROR: chunk [20345535463424 20346609205248) doesn't have related block
group item
ERROR: chunk [20346609205248 20347682947072) doesn't have related block
group item
ERROR: chunk [20347682947072 20348756688896) doesn't have related block
group item
ERROR: chunk [20348756688896 20349830430720) doesn't have related block
group item
ERROR: chunk [20349830430720 20350904172544) doesn't have related block
group item
ERROR: chunk [20350904172544 20351977914368) doesn't have related block
group item
ERROR: chunk [20351977914368 20353051656192) doesn't have related block
group item
ERROR: chunk [20353051656192 20354125398016) doesn't have related block
group item
ERROR: chunk [20354125398016 20355199139840) doesn't have related block
group item
ERROR: chunk [20355199139840 20356272881664) doesn't have related block
group item
ERROR: chunk [20356272881664 20357346623488) doesn't have related block
group item
ERROR: chunk [20357346623488 20358420365312) doesn't have related block
group item
ERROR: chunk [20358420365312 20359494107136) doesn't have related block
group item
ERROR: chunk [20359494107136 20360567848960) doesn't have related block
group item
ERROR: chunk [20360567848960 20361641590784) doesn't have related block
group item
ERROR: chunk [20361641590784 20362715332608) doesn't have related block
group item
ERROR: chunk [20362715332608 20363789074432) doesn't have related block
group item
ERROR: chunk [20363789074432 20364862816256) doesn't have related block
group item
ERROR: chunk [20364862816256 20365936558080) doesn't have related block
group item
ERROR: chunk [20365936558080 20367010299904) doesn't have related block
group item
ERROR: chunk [20367010299904 20368084041728) doesn't have related block
group item
ERROR: chunk [20368084041728 20369157783552) doesn't have related block
group item
ERROR: chunk [20369157783552 20370231525376) doesn't have related block
group item
ERROR: chunk [20370231525376 20371305267200) doesn't have related block
group item
ERROR: chunk [20371305267200 20372379009024) doesn't have related block
group item
ERROR: chunk [20372379009024 20373452750848) doesn't have related block
group item
ERROR: chunk [20373452750848 20374526492672) doesn't have related block
group item
ERROR: chunk [20374526492672 20375600234496) doesn't have related block
group item
ERROR: chunk [20375600234496 20376673976320) doesn't have related block
group item
ERROR: chunk [20376673976320 20377747718144) doesn't have related block
group item
ERROR: chunk [20377747718144 20378821459968) doesn't have related block
group item
ERROR: chunk [20378821459968 20379895201792) doesn't have related block
group item
ERROR: chunk [20379895201792 20380968943616) doesn't have related block
group item
ERROR: chunk [20380968943616 20382042685440) doesn't have related block
group item
ERROR: chunk [20382042685440 20383116427264) doesn't have related block
group item
ERROR: chunk [20383116427264 20384190169088) doesn't have related block
group item
ERROR: chunk [20384190169088 20385263910912) doesn't have related block
group item
ERROR: chunk [20385263910912 20386337652736) doesn't have related block
group item
ERROR: chunk [20386337652736 20387411394560) doesn't have related block
group item
ERROR: chunk [20387411394560 20388485136384) doesn't have related block
group item
ERROR: chunk [20388485136384 20389558878208) doesn't have related block
group item
ERROR: chunk [20389558878208 20390632620032) doesn't have related block
group item
ERROR: chunk [20390632620032 20391706361856) doesn't have related block
group item
ERROR: chunk [20391706361856 20392780103680) doesn't have related block
group item
ERROR: chunk [20392780103680 20393853845504) doesn't have related block
group item
ERROR: chunk [20393853845504 20394927587328) doesn't have related block
group item
ERROR: chunk [20394927587328 20396001329152) doesn't have related block
group item
ERROR: chunk [20396001329152 20397075070976) doesn't have related block
group item
ERROR: chunk [20397075070976 20398148812800) doesn't have related block
group item
ERROR: chunk [20398148812800 20399222554624) doesn't have related block
group item
ERROR: chunk [20399222554624 20400296296448) doesn't have related block
group item
ERROR: chunk [20400296296448 20401370038272) doesn't have related block
group item
ERROR: chunk [20401370038272 20402443780096) doesn't have related block
group item
ERROR: chunk [20402443780096 20403517521920) doesn't have related block
group item
ERROR: chunk [20403517521920 20404591263744) doesn't have related block
group item
ERROR: chunk [20404591263744 20405665005568) doesn't have related block
group item
ERROR: chunk [20405665005568 20406738747392) doesn't have related block
group item
ERROR: chunk [20406738747392 20407812489216) doesn't have related block
group item
ERROR: chunk [20407812489216 20408886231040) doesn't have related block
group item
ERROR: chunk [20408886231040 20409959972864) doesn't have related block
group item
ERROR: chunk [20409959972864 20411033714688) doesn't have related block
group item
ERROR: chunk [20411033714688 20412107456512) doesn't have related block
group item
ERROR: chunk [20412107456512 20413181198336) doesn't have related block
group item
ERROR: chunk [20413181198336 20414254940160) doesn't have related block
group item
ERROR: chunk [20414254940160 20415328681984) doesn't have related block
group item
ERROR: chunk [20415328681984 20416402423808) doesn't have related block
group item
ERROR: chunk [20416402423808 20417476165632) doesn't have related block
group item
ERROR: chunk [20417476165632 20418549907456) doesn't have related block
group item
ERROR: chunk [20418549907456 20419623649280) doesn't have related block
group item
ERROR: chunk [20419623649280 20420697391104) doesn't have related block
group item
ERROR: chunk [20420697391104 20421771132928) doesn't have related block
group item
ERROR: chunk [20421771132928 20422844874752) doesn't have related block
group item
ERROR: chunk [20422844874752 20423918616576) doesn't have related block
group item
ERROR: chunk [20423918616576 20424992358400) doesn't have related block
group item
ERROR: chunk [20424992358400 20426066100224) doesn't have related block
group item
ERROR: chunk [20426066100224 20427139842048) doesn't have related block
group item
ERROR: chunk [20427139842048 20428213583872) doesn't have related block
group item
ERROR: chunk [20428213583872 20429287325696) doesn't have related block
group item
ERROR: chunk [20429287325696 20430361067520) doesn't have related block
group item
ERROR: chunk [20430361067520 20431434809344) doesn't have related block
group item
ERROR: chunk [20431434809344 20432508551168) doesn't have related block
group item
ERROR: chunk [20432508551168 20433582292992) doesn't have related block
group item
ERROR: chunk [20433582292992 20434656034816) doesn't have related block
group item
ERROR: chunk [20434656034816 20435729776640) doesn't have related block
group item
ERROR: chunk [20435729776640 20436803518464) doesn't have related block
group item
ERROR: chunk [20436803518464 20437877260288) doesn't have related block
group item
ERROR: chunk [20437877260288 20438951002112) doesn't have related block
group item
ERROR: chunk [20438951002112 20440024743936) doesn't have related block
group item
ERROR: chunk [20440024743936 20441098485760) doesn't have related block
group item
ERROR: chunk [20441098485760 20442172227584) doesn't have related block
group item
ERROR: chunk [20442172227584 20443245969408) doesn't have related block
group item
ERROR: chunk [20443245969408 20444319711232) doesn't have related block
group item
ERROR: chunk [20444319711232 20445393453056) doesn't have related block
group item
ERROR: chunk [20445393453056 20446467194880) doesn't have related block
group item
ERROR: chunk [20446467194880 20447540936704) doesn't have related block
group item
ERROR: chunk [20447540936704 20448614678528) doesn't have related block
group item
ERROR: chunk [20448614678528 20449688420352) doesn't have related block
group item
ERROR: chunk [20449688420352 20450762162176) doesn't have related block
group item
ERROR: chunk [20450762162176 20451835904000) doesn't have related block
group item
ERROR: chunk [20451835904000 20452909645824) doesn't have related block
group item
ERROR: chunk [20452909645824 20453983387648) doesn't have related block
group item
ERROR: chunk [20453983387648 20455057129472) doesn't have related block
group item
ERROR: chunk [20455057129472 20456130871296) doesn't have related block
group item
ERROR: chunk [20456130871296 20457204613120) doesn't have related block
group item
ERROR: chunk [20457204613120 20458278354944) doesn't have related block
group item
ERROR: chunk [20458278354944 20459352096768) doesn't have related block
group item
ERROR: chunk [20459352096768 20460425838592) doesn't have related block
group item
ERROR: chunk [20460425838592 20461499580416) doesn't have related block
group item
ERROR: chunk [20461499580416 20462573322240) doesn't have related block
group item
ERROR: chunk [20462573322240 20463647064064) doesn't have related block
group item
ERROR: chunk [20463647064064 20464720805888) doesn't have related block
group item
ERROR: chunk [20464720805888 20465794547712) doesn't have related block
group item
ERROR: chunk [20465794547712 20466868289536) doesn't have related block
group item
ERROR: chunk [20466868289536 20467942031360) doesn't have related block
group item
ERROR: chunk [20467942031360 20469015773184) doesn't have related block
group item
ERROR: chunk [20469015773184 20470089515008) doesn't have related block
group item
ERROR: chunk [20470089515008 20471163256832) doesn't have related block
group item
ERROR: chunk [20471163256832 20472236998656) doesn't have related block
group item
ERROR: chunk [20472236998656 20473310740480) doesn't have related block
group item
ERROR: chunk [20473310740480 20474384482304) doesn't have related block
group item
ERROR: chunk [20474384482304 20475458224128) doesn't have related block
group item
ERROR: chunk [20475458224128 20476531965952) doesn't have related block
group item
ERROR: chunk [20476531965952 20477605707776) doesn't have related block
group item
ERROR: chunk [20477605707776 20478679449600) doesn't have related block
group item
ERROR: chunk [20478679449600 20479753191424) doesn't have related block
group item
ERROR: chunk [20479753191424 20480826933248) doesn't have related block
group item
ERROR: chunk [20480826933248 20481900675072) doesn't have related block
group item
ERROR: chunk [20481900675072 20482974416896) doesn't have related block
group item
ERROR: chunk [20482974416896 20484048158720) doesn't have related block
group item
ERROR: chunk [20484048158720 20485121900544) doesn't have related block
group item
ERROR: chunk [20485121900544 20486195642368) doesn't have related block
group item
ERROR: chunk [20486195642368 20487269384192) doesn't have related block
group item
ERROR: chunk [20487269384192 20488343126016) doesn't have related block
group item
ERROR: chunk [20488343126016 20489416867840) doesn't have related block
group item
ERROR: chunk [20489416867840 20490490609664) doesn't have related block
group item
ERROR: chunk [20490490609664 20491564351488) doesn't have related block
group item
ERROR: chunk [20491564351488 20492638093312) doesn't have related block
group item
ERROR: chunk [20492638093312 20493711835136) doesn't have related block
group item
ERROR: chunk [20493711835136 20494785576960) doesn't have related block
group item
ERROR: chunk [20494785576960 20495859318784) doesn't have related block
group item
ERROR: chunk [20495859318784 20496933060608) doesn't have related block
group item
ERROR: chunk [20496933060608 20498006802432) doesn't have related block
group item
ERROR: chunk [20498006802432 20499080544256) doesn't have related block
group item
ERROR: chunk [20499080544256 20500154286080) doesn't have related block
group item
ERROR: chunk [20500154286080 20501228027904) doesn't have related block
group item
ERROR: chunk [20501228027904 20502301769728) doesn't have related block
group item
ERROR: chunk [20502301769728 20503375511552) doesn't have related block
group item
ERROR: chunk [20503375511552 20504449253376) doesn't have related block
group item
ERROR: chunk [20504449253376 20505522995200) doesn't have related block
group item
ERROR: chunk [20505522995200 20506596737024) doesn't have related block
group item
ERROR: chunk [20506596737024 20507670478848) doesn't have related block
group item
ERROR: chunk [20507670478848 20508744220672) doesn't have related block
group item
ERROR: chunk [20508744220672 20509817962496) doesn't have related block
group item
ERROR: chunk [20509817962496 20510891704320) doesn't have related block
group item
ERROR: chunk [20510891704320 20511965446144) doesn't have related block
group item
ERROR: chunk [20511965446144 20513039187968) doesn't have related block
group item
ERROR: chunk [20513039187968 20514112929792) doesn't have related block
group item
ERROR: chunk [20514112929792 20515186671616) doesn't have related block
group item
ERROR: chunk [20515186671616 20516260413440) doesn't have related block
group item
ERROR: chunk [20516260413440 20517334155264) doesn't have related block
group item
ERROR: chunk [20517334155264 20518407897088) doesn't have related block
group item
ERROR: chunk [20518407897088 20519481638912) doesn't have related block
group item
ERROR: chunk [20519481638912 20520555380736) doesn't have related block
group item
ERROR: chunk [20520555380736 20521629122560) doesn't have related block
group item
ERROR: chunk [20521629122560 20522702864384) doesn't have related block
group item
ERROR: chunk [20522702864384 20523776606208) doesn't have related block
group item
ERROR: chunk [20523776606208 20524850348032) doesn't have related block
group item
ERROR: chunk [20524850348032 20525924089856) doesn't have related block
group item
ERROR: chunk [20525924089856 20526997831680) doesn't have related block
group item
ERROR: chunk [20526997831680 20528071573504) doesn't have related block
group item
ERROR: chunk [20528071573504 20529145315328) doesn't have related block
group item
ERROR: chunk [20529145315328 20530219057152) doesn't have related block
group item
ERROR: chunk [20530219057152 20531292798976) doesn't have related block
group item
ERROR: chunk [20531292798976 20532366540800) doesn't have related block
group item
ERROR: chunk [20532366540800 20533440282624) doesn't have related block
group item
ERROR: chunk [20533440282624 20534514024448) doesn't have related block
group item
ERROR: chunk [20534514024448 20535587766272) doesn't have related block
group item
ERROR: chunk [20535587766272 20536661508096) doesn't have related block
group item
ERROR: chunk [20536661508096 20537735249920) doesn't have related block
group item
ERROR: chunk [20537735249920 20538808991744) doesn't have related block
group item
ERROR: chunk [20538808991744 20539882733568) doesn't have related block
group item
ERROR: chunk [20539882733568 20540956475392) doesn't have related block
group item
ERROR: chunk [20540956475392 20542030217216) doesn't have related block
group item
ERROR: chunk [20542030217216 20543103959040) doesn't have related block
group item
ERROR: chunk [20543103959040 20544177700864) doesn't have related block
group item
ERROR: chunk [20544177700864 20545251442688) doesn't have related block
group item
ERROR: chunk [20545251442688 20546325184512) doesn't have related block
group item
ERROR: chunk [20546325184512 20547398926336) doesn't have related block
group item
ERROR: chunk [20547398926336 20548472668160) doesn't have related block
group item
ERROR: chunk [20548472668160 20549546409984) doesn't have related block
group item
ERROR: chunk [20549546409984 20550620151808) doesn't have related block
group item
ERROR: chunk [20550620151808 20551693893632) doesn't have related block
group item
ERROR: chunk [20551693893632 20552767635456) doesn't have related block
group item
ERROR: chunk [20552767635456 20553841377280) doesn't have related block
group item
ERROR: chunk [20553841377280 20554915119104) doesn't have related block
group item
ERROR: chunk [20554915119104 20555988860928) doesn't have related block
group item
ERROR: chunk [20555988860928 20557062602752) doesn't have related block
group item
ERROR: chunk [20557062602752 20558136344576) doesn't have related block
group item
ERROR: chunk [20558136344576 20559210086400) doesn't have related block
group item
ERROR: chunk [20559210086400 20560283828224) doesn't have related block
group item
ERROR: chunk [20560283828224 20561357570048) doesn't have related block
group item
ERROR: chunk [20561357570048 20562431311872) doesn't have related block
group item
ERROR: chunk [20562431311872 20563505053696) doesn't have related block
group item
ERROR: chunk [20563505053696 20564578795520) doesn't have related block
group item
ERROR: chunk [20564578795520 20565652537344) doesn't have related block
group item
ERROR: chunk [20565652537344 20566726279168) doesn't have related block
group item
ERROR: chunk [20566726279168 20567800020992) doesn't have related block
group item
ERROR: chunk [20567800020992 20568873762816) doesn't have related block
group item
ERROR: chunk [20568873762816 20569947504640) doesn't have related block
group item
ERROR: chunk [20569947504640 20571021246464) doesn't have related block
group item
ERROR: chunk [20571021246464 20572094988288) doesn't have related block
group item
ERROR: chunk [20572094988288 20573168730112) doesn't have related block
group item
ERROR: chunk [20573168730112 20574242471936) doesn't have related block
group item
ERROR: chunk [20574242471936 20575316213760) doesn't have related block
group item
ERROR: chunk [20575316213760 20576389955584) doesn't have related block
group item
ERROR: chunk [20576389955584 20577463697408) doesn't have related block
group item
ERROR: chunk [20577463697408 20578537439232) doesn't have related block
group item
ERROR: chunk [20578537439232 20579611181056) doesn't have related block
group item
ERROR: chunk [20579611181056 20580684922880) doesn't have related block
group item
ERROR: chunk [20580684922880 20581758664704) doesn't have related block
group item
ERROR: chunk [20581758664704 20582832406528) doesn't have related block
group item
ERROR: chunk [20582832406528 20583906148352) doesn't have related block
group item
ERROR: chunk [20583906148352 20584979890176) doesn't have related block
group item
ERROR: chunk [20584979890176 20586053632000) doesn't have related block
group item
ERROR: chunk [20586053632000 20587127373824) doesn't have related block
group item
ERROR: chunk [20587127373824 20588201115648) doesn't have related block
group item
ERROR: chunk [20588201115648 20589274857472) doesn't have related block
group item
ERROR: chunk [20589274857472 20590348599296) doesn't have related block
group item
ERROR: chunk [20590348599296 20591422341120) doesn't have related block
group item
ERROR: chunk [20591422341120 20592496082944) doesn't have related block
group item
ERROR: chunk [20592496082944 20593569824768) doesn't have related block
group item
ERROR: chunk [20593569824768 20594643566592) doesn't have related block
group item
ERROR: chunk [20594643566592 20595717308416) doesn't have related block
group item
ERROR: chunk [20595717308416 20596791050240) doesn't have related block
group item
ERROR: chunk [20596791050240 20597864792064) doesn't have related block
group item
ERROR: chunk [20597864792064 20598938533888) doesn't have related block
group item
ERROR: chunk [20598938533888 20600012275712) doesn't have related block
group item
ERROR: chunk [20600012275712 20601086017536) doesn't have related block
group item
ERROR: chunk [20601086017536 20602159759360) doesn't have related block
group item
ERROR: chunk [20602159759360 20603233501184) doesn't have related block
group item
ERROR: chunk [20603233501184 20604307243008) doesn't have related block
group item
ERROR: chunk [20604307243008 20605380984832) doesn't have related block
group item
ERROR: chunk [20605380984832 20606454726656) doesn't have related block
group item
ERROR: chunk [20606454726656 20607528468480) doesn't have related block
group item
ERROR: chunk [20607528468480 20608602210304) doesn't have related block
group item
ERROR: chunk [20608602210304 20609675952128) doesn't have related block
group item
ERROR: chunk [20609675952128 20610749693952) doesn't have related block
group item
ERROR: chunk [20610749693952 20611823435776) doesn't have related block
group item
ERROR: chunk [20611823435776 20612897177600) doesn't have related block
group item
ERROR: chunk [20612897177600 20613970919424) doesn't have related block
group item
ERROR: chunk [20613970919424 20615044661248) doesn't have related block
group item
ERROR: chunk [20615044661248 20616118403072) doesn't have related block
group item
ERROR: chunk [20616118403072 20617192144896) doesn't have related block
group item
ERROR: chunk [20617192144896 20618265886720) doesn't have related block
group item
ERROR: chunk [20618265886720 20619339628544) doesn't have related block
group item
ERROR: chunk [20619339628544 20620413370368) doesn't have related block
group item
ERROR: chunk [20620413370368 20621487112192) doesn't have related block
group item
ERROR: chunk [20621487112192 20622560854016) doesn't have related block
group item
ERROR: chunk [20622560854016 20623634595840) doesn't have related block
group item
ERROR: chunk [20623634595840 20624708337664) doesn't have related block
group item
ERROR: chunk [20624708337664 20625782079488) doesn't have related block
group item
ERROR: chunk [20625782079488 20626855821312) doesn't have related block
group item
ERROR: chunk [20626855821312 20627929563136) doesn't have related block
group item
ERROR: chunk [20627929563136 20629003304960) doesn't have related block
group item
ERROR: chunk [20629003304960 20630077046784) doesn't have related block
group item
ERROR: chunk [20630077046784 20631150788608) doesn't have related block
group item
ERROR: chunk [20631150788608 20632224530432) doesn't have related block
group item
ERROR: chunk [20632224530432 20633298272256) doesn't have related block
group item
ERROR: chunk [20633298272256 20634372014080) doesn't have related block
group item
ERROR: chunk [20634372014080 20635445755904) doesn't have related block
group item
ERROR: chunk [20635445755904 20636519497728) doesn't have related block
group item
ERROR: chunk [20636519497728 20637593239552) doesn't have related block
group item
ERROR: chunk [20637593239552 20638666981376) doesn't have related block
group item
ERROR: chunk [20638666981376 20639740723200) doesn't have related block
group item
ERROR: chunk [20639740723200 20640814465024) doesn't have related block
group item
ERROR: chunk [20640814465024 20641888206848) doesn't have related block
group item
ERROR: chunk [20641888206848 20642961948672) doesn't have related block
group item
ERROR: chunk [20642961948672 20644035690496) doesn't have related block
group item
ERROR: chunk [20644035690496 20645109432320) doesn't have related block
group item
ERROR: chunk [20645109432320 20646183174144) doesn't have related block
group item
ERROR: chunk [20646183174144 20647256915968) doesn't have related block
group item
ERROR: chunk [20647256915968 20648330657792) doesn't have related block
group item
ERROR: chunk [20648330657792 20649404399616) doesn't have related block
group item
ERROR: chunk [20649404399616 20650478141440) doesn't have related block
group item
ERROR: chunk [20650478141440 20651551883264) doesn't have related block
group item
ERROR: chunk [20651551883264 20652625625088) doesn't have related block
group item
ERROR: chunk [20652625625088 20653699366912) doesn't have related block
group item
ERROR: chunk [20653699366912 20654773108736) doesn't have related block
group item
ERROR: chunk [20654773108736 20655846850560) doesn't have related block
group item
ERROR: chunk [20655846850560 20656920592384) doesn't have related block
group item
ERROR: chunk [20656920592384 20657994334208) doesn't have related block
group item
ERROR: chunk [20657994334208 20659068076032) doesn't have related block
group item
ERROR: chunk [20659068076032 20660141817856) doesn't have related block
group item
ERROR: chunk [20660141817856 20661215559680) doesn't have related block
group item
ERROR: chunk [20661215559680 20662289301504) doesn't have related block
group item
ERROR: chunk [20662289301504 20663363043328) doesn't have related block
group item
ERROR: chunk [20663363043328 20664436785152) doesn't have related block
group item
ERROR: chunk [20664436785152 20665510526976) doesn't have related block
group item
ERROR: chunk [20665510526976 20666584268800) doesn't have related block
group item
ERROR: chunk [20666584268800 20667658010624) doesn't have related block
group item
ERROR: chunk [20667658010624 20668731752448) doesn't have related block
group item
ERROR: chunk [20668731752448 20669805494272) doesn't have related block
group item
ERROR: chunk [20669805494272 20670879236096) doesn't have related block
group item
ERROR: chunk [20670879236096 20671947538432) doesn't have related block
group item
ERROR: chunk [20671947538432 20672987725824) doesn't have related block
group item
ERROR: chunk [20672987725824 20674027913216) doesn't have related block
group item
ERROR: chunk [20674027913216 20674051833856) doesn't have related block
group item
ERROR: chunk [20674051833856 20674067365888) doesn't have related block
group item
ERROR: chunk [20674067365888 20674079948800) doesn't have related block
group item
ERROR: chunk [20674079948800 20674088337408) doesn't have related block
group item
ERROR: chunk [20674088337408 20674096726016) doesn't have related block
group item


my system specs are:
AMD Phenom(tm) II X4 965 Processor @3400MHz
8GB RAM

❯ uname -r
6.4.9-arch1-1


