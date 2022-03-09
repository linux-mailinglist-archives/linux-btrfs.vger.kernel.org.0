Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6F54D27E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 05:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiCIEey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 23:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCIEew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 23:34:52 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA93A73A
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 20:33:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s10so1379137edd.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 20:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OJgyyGfeeVj0q47UXcScUAwGOmtWd+hQFWUsbFr7gxA=;
        b=QSU2dn4emOu3LmA0jPluYmJD01l01QEMAIUeEucyk+X/0/nneNkbypq1gNErf0/47o
         VPGy6jQtj8h/vMpg+UlJR6T6TqvODcKP0O0FxY/0D+Z2DltxzL0rFLqSSxCbx3jW1pqk
         P5Iq9/dJkqk33iAqm7b+vCeD0vhWj+vevF9iqgE+adi+8aKv94yt4H1XHIANYpM1+MoT
         MXkDQasJKeH5lr7LAioiJrIrDLhfOdWJfuaAyPgjl+6kggo15zqj/GNCG36+XjG2VsfN
         cbzCWLllc8r+OeElsOjdhvc6yFYbWuKWDHYWlVAJJ22pdYHx7orSPWeMHp/Te/hQiVd+
         XnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OJgyyGfeeVj0q47UXcScUAwGOmtWd+hQFWUsbFr7gxA=;
        b=gRwm4HeEmI3647I/3xnYhvri8oC2PpqYDrJ8L6+Wp+LiClvL5aZtAoQqZZlz1oRDMi
         0GF0wo59EBjcWBFMMdp+d6FN1M90Ps2Myk8LZwfYxSZy2lsQCo3lc1n+i8Xb7qNle4Qy
         GZ/qUqBqDsfEsOyOtTDdurWCnkUiBB6vBmVyrdMppNbjk6JncbRzh9dRZDsxtkOz9OZw
         fxRt7ZoHGmgt1TyUKGkwP4HV+IosIBEQ51bVmKJN6pUUBE4EBD3djYuCT3idVslUzFVI
         nEzo861W8czfJDukCGGnvnDaSX8V1mhUoHLUd1AkCgMy78cKivRCxYdL5a6pnU17sNMq
         bp+A==
X-Gm-Message-State: AOAM532EEBGUm3781tjSnREdq/fZymNzgUr4pIgucuXzx3FR5YYVhk0b
        tJo1b4NftSnZDnfwyOV+onmhwiYkAZBUvEI6qi8Eh54i
X-Google-Smtp-Source: ABdhPJxFjrfIeT0JQhsmLEjo+6uWg5MGCpIOPAF7aYmSjledZKjWDNu+B+4iQq4dMxlOneCYhgDRgb5eXTdvZJ6hS/g=
X-Received: by 2002:a05:6402:510b:b0:416:9d56:20e with SMTP id
 m11-20020a056402510b00b004169d56020emr26571edd.264.1646800428835; Tue, 08 Mar
 2022 20:33:48 -0800 (PST)
MIME-Version: 1.0
References: <CALPV6DsfOQHyQ2=+3pKF3ZfavL21fgthQS+=HStEfMQbhZU50g@mail.gmail.com>
 <7a4962a0-b007-59a4-282e-8912b2425c5e@gmx.com> <CALPV6DtuY6KxFKF6WR2HDPzzVm8TbcGEXwTMiDAy6MdL+jC7jA@mail.gmail.com>
 <ca8e7647-9996-d05d-1438-ff2b82c7038b@gmx.com> <CALPV6DvuD5Tn_mepbVPcWkbNA-s9Nj-jc1dsY8Cm5KOrYfbu0Q@mail.gmail.com>
In-Reply-To: <CALPV6DvuD5Tn_mepbVPcWkbNA-s9Nj-jc1dsY8Cm5KOrYfbu0Q@mail.gmail.com>
From:   bill gates <framingnoone@gmail.com>
Date:   Tue, 8 Mar 2022 22:33:37 -0600
Message-ID: <CALPV6Dtvu4U7Mj93H+uuN-mm4S9KvdQk_arbu_J5oTwMg-pOKA@mail.gmail.com>
Subject: Fwd: Updated to new kernel, and btrfs suddenly refuses to mount home
 directory fs.
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

Oops, forgot to copy this to the list -- L
---------- Forwarded message ---------
From: bill gates <framingnoone@gmail.com>
Date: Tue, Mar 8, 2022 at 10:28 PM
Subject: Re: Updated to new kernel, and btrfs suddenly refuses to
mount home directory fs.
To: Qu Wenruo <quwenruo.btrfs@gmx.com>


Oh... I ran the ins dump-tree on the old kernel (4.19), not the new
one. The new kernel sees it differently (!)

----- kernel 5.15 ins dump-tree
btrfs-progs v5.15.1
leaf 10442806968320 items 169 free space 3439 generation 6835704 owner
EXTENT_TREE
leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
       item 0 key (10442625581056 EXTENT_ITEM 16384) itemoff 16232 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115485335552) level 0
               tree block backref root CSUM_TREE
       item 1 key (10442625597440 EXTENT_ITEM 16384) itemoff 16181 itemsize 51
               refs 1 gen 307924 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10997584617472) level 0
               tree block backref root CSUM_TREE
       item 2 key (10442625630208 EXTENT_ITEM 16384) itemoff 16130 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115501953024) level 0
               tree block backref root CSUM_TREE
       item 3 key (10442625646592 EXTENT_ITEM 16384) itemoff 16079 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115518570496) level 0
               tree block backref root CSUM_TREE
       item 4 key (10442625662976 EXTENT_ITEM 16384) itemoff 16028 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115535187968) level 0
               tree block backref root CSUM_TREE
       item 5 key (10442625679360 EXTENT_ITEM 16384) itemoff 15977 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115551805440) level 0
               tree block backref root CSUM_TREE
       item 6 key (10442625695744 EXTENT_ITEM 16384) itemoff 15926 itemsize 51
               refs 1 gen 308431 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11052875681792) level 0
               tree block backref root CSUM_TREE
       item 7 key (10442625712128 EXTENT_ITEM 16384) itemoff 15875 itemsize 51
               refs 1 gen 308431 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11052859064320) level 0
               tree block backref root CSUM_TREE
       item 8 key (10442625728512 EXTENT_ITEM 16384) itemoff 15824 itemsize 51
               refs 1 gen 308431 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11052892299264) level 0
               tree block backref root CSUM_TREE
       item 9 key (10442625744896 EXTENT_ITEM 16384) itemoff 15773 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12064823508992 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 10 key (10442625761280 EXTENT_ITEM 16384) itemoff 15722 itemsize 51
               refs 1 gen 6745444 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12496472784896) level 0
               tree block backref root CSUM_TREE
       item 11 key (10442625794048 EXTENT_ITEM 16384) itemoff 15671 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115639283712) level 0
               tree block backref root CSUM_TREE
       item 12 key (10442625810432 EXTENT_ITEM 16384) itemoff 15620 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115655901184) level 0
               tree block backref root CSUM_TREE
       item 13 key (10442625826816 EXTENT_ITEM 16384) itemoff 15569 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115672518656) level 0
               tree block backref root CSUM_TREE
       item 14 key (10442625843200 EXTENT_ITEM 16384) itemoff 15518 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2068362 INODE_REF 2066150) level 0
               tree block backref root 257
       item 15 key (10442625875968 EXTENT_ITEM 16384) itemoff 15467 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2068385 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 16 key (10442625892352 EXTENT_ITEM 16384) itemoff 15416 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12065235910656 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 17 key (10442625908736 EXTENT_ITEM 16384) itemoff 15365 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12065187733504 EXTENT_ITEM 57344) level 0
               tree block backref root EXTENT_TREE
       item 18 key (10442625925120 EXTENT_ITEM 16384) itemoff 15314 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115689136128) level 0
               tree block backref root CSUM_TREE
       item 19 key (10442625941504 EXTENT_ITEM 16384) itemoff 15263 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115705753600) level 0
               tree block backref root CSUM_TREE
       item 20 key (10442625990656 EXTENT_ITEM 16384) itemoff 15212 itemsize 51
               refs 1 gen 6833576 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 9686276972544) level 0
               tree block backref root CSUM_TREE
       item 21 key (10442626007040 EXTENT_ITEM 16384) itemoff 15161 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12065510035456 EXTENT_ITEM 1052672) level 0
               tree block backref root EXTENT_TREE
       item 22 key (10442626023424 EXTENT_ITEM 16384) itemoff 15110 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12065890512896 EXTENT_ITEM 49152) level 0
               tree block backref root EXTENT_TREE
       item 23 key (10442626039808 EXTENT_ITEM 16384) itemoff 15059 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12065799458816 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 24 key (10442626072576 EXTENT_ITEM 16384) itemoff 15008 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12065947615232 EXTENT_ITEM 712704) level 0
               tree block backref root EXTENT_TREE
       item 25 key (10442626088960 EXTENT_ITEM 16384) itemoff 14957 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764131 INODE_ITEM 0) level 0
               tree block backref root 257
       item 26 key (10442626105344 EXTENT_ITEM 16384) itemoff 14906 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764153 INODE_REF 76762106) level 0
               tree block backref root 257
       item 27 key (10442626121728 EXTENT_ITEM 16384) itemoff 14855 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764176 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 28 key (10442626138112 EXTENT_ITEM 16384) itemoff 14804 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405131452416) level 0
               tree block backref root CSUM_TREE
       item 29 key (10442626154496 EXTENT_ITEM 16384) itemoff 14753 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764289 INODE_ITEM 0) level 0
               tree block backref root 257
       item 30 key (10442626170880 EXTENT_ITEM 16384) itemoff 14702 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115722371072) level 0
               tree block backref root CSUM_TREE
       item 31 key (10442626187264 EXTENT_ITEM 16384) itemoff 14651 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12066310410240 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 32 key (10442626203648 EXTENT_ITEM 16384) itemoff 14600 itemsize 51
               refs 1 gen 6724925 flags TREE_BLOCK
               tree block key (10241601216512 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 33 key (10442626220032 EXTENT_ITEM 16384) itemoff 14549 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2541168 DIR_INDEX 9) level 0
               tree block backref root 257
       item 34 key (10442626236416 EXTENT_ITEM 16384) itemoff 14498 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405148045312) level 0
               tree block backref root CSUM_TREE
       item 35 key (10442626252800 EXTENT_ITEM 16384) itemoff 14447 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2541180 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 36 key (10442626269184 EXTENT_ITEM 16384) itemoff 14396 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2541188 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 37 key (10442626285568 EXTENT_ITEM 16384) itemoff 14345 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405164662784) level 0
               tree block backref root CSUM_TREE
       item 38 key (10442626334720 EXTENT_ITEM 16384) itemoff 14294 itemsize 51
               refs 1 gen 6264604 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11230848499712) level 0
               tree block backref root CSUM_TREE
       item 39 key (10442626400256 EXTENT_ITEM 16384) itemoff 14243 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10235629682688) level 0
               tree block backref root CSUM_TREE
       item 40 key (10442626416640 EXTENT_ITEM 16384) itemoff 14192 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12203664891904) level 0
               tree block backref root CSUM_TREE
       item 41 key (10442626449408 EXTENT_ITEM 16384) itemoff 14141 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12067359137792 EXTENT_ITEM 12288) level 0
               tree block backref root EXTENT_TREE
       item 42 key (10442626465792 EXTENT_ITEM 16384) itemoff 14090 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (12204759490560 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 43 key (10442626482176 EXTENT_ITEM 16384) itemoff 14039 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12067310555136 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 44 key (10442626498560 EXTENT_ITEM 16384) itemoff 13988 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12204762636288) level 0
               tree block backref root CSUM_TREE
       item 45 key (10442626514944 EXTENT_ITEM 16384) itemoff 13937 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10567535681536) level 0
               tree block backref root CSUM_TREE
       item 46 key (10442626531328 EXTENT_ITEM 16384) itemoff 13886 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (11216497197056 EXTENT_ITEM 16384) level 0
               tree block backref root EXTENT_TREE
       item 47 key (10442626547712 EXTENT_ITEM 16384) itemoff 13835 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (12894114234368 EXTENT_ITEM 16384) level 0
               tree block backref root EXTENT_TREE
       item 48 key (10442626564096 EXTENT_ITEM 16384) itemoff 13784 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (13092730437632 EXTENT_ITEM 16384) level 0
               tree block backref root EXTENT_TREE
       item 49 key (10442626580480 EXTENT_ITEM 16384) itemoff 13733 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764473 INODE_REF 76762122) level 0
               tree block backref root 257
       item 50 key (10442626596864 EXTENT_ITEM 16384) itemoff 13682 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12067776978944 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 51 key (10442626613248 EXTENT_ITEM 16384) itemoff 13631 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405181280256) level 0
               tree block backref root CSUM_TREE
       item 52 key (10442626629632 EXTENT_ITEM 16384) itemoff 13580 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (13092764860416 EXTENT_ITEM 16384) level 0
               tree block backref root EXTENT_TREE
       item 53 key (10442626662400 EXTENT_ITEM 16384) itemoff 13529 itemsize 51
               refs 1 gen 1434043 flags TREE_BLOCK
               tree block key (15409727 DIR_INDEX 1378) level 0
               tree block backref root 257
       item 54 key (10442626678784 EXTENT_ITEM 16384) itemoff 13478 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10567552299008) level 0
               tree block backref root CSUM_TREE
       item 55 key (10442626711552 EXTENT_ITEM 16384) itemoff 13427 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12068306247680 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 56 key (10442626727936 EXTENT_ITEM 16384) itemoff 13376 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12068680613888 EXTENT_ITEM 81920) level 0
               tree block backref root EXTENT_TREE
       item 57 key (10442626744320 EXTENT_ITEM 16384) itemoff 13325 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764584 INODE_REF 76762122) level 0
               tree block backref root 257
       item 58 key (10442626793472 EXTENT_ITEM 16384) itemoff 13274 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10567568916480) level 0
               tree block backref root CSUM_TREE
       item 59 key (10442626859008 EXTENT_ITEM 16384) itemoff 13223 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (10442421272576 EXTENT_ITEM 16384) level 0
               tree block backref root EXTENT_TREE
       item 60 key (10442626875392 EXTENT_ITEM 16384) itemoff 13172 itemsize 51
               refs 1 gen 4570110 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11694087127040) level 0
               tree block backref root CSUM_TREE
       item 61 key (10442626908160 EXTENT_ITEM 16384) itemoff 13121 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12069107830784 EXTENT_ITEM 102400) level 0
               tree block backref root EXTENT_TREE
       item 62 key (10442626940928 EXTENT_ITEM 16384) itemoff 13070 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12069177942016 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 63 key (10442626957312 EXTENT_ITEM 16384) itemoff 13019 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12069211504640 EXTENT_ITEM 131072) level 0
               tree block backref root EXTENT_TREE
       item 64 key (10442626973696 EXTENT_ITEM 16384) itemoff 12968 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764814 INODE_REF 76762122) level 0
               tree block backref root 257
       item 65 key (10442626990080 EXTENT_ITEM 16384) itemoff 12917 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2538301 INODE_ITEM 0) level 0
               tree block backref root 257
       item 66 key (10442627006464 EXTENT_ITEM 16384) itemoff 12866 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2538310 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 67 key (10442627022848 EXTENT_ITEM 16384) itemoff 12815 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405197897728) level 0
               tree block backref root CSUM_TREE
       item 68 key (10442627039232 EXTENT_ITEM 16384) itemoff 12764 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (9708461223936 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 69 key (10442627055616 EXTENT_ITEM 16384) itemoff 12713 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (9709536043008 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 70 key (10442627088384 EXTENT_ITEM 16384) itemoff 12662 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115738988544) level 0
               tree block backref root CSUM_TREE
       item 71 key (10442627104768 EXTENT_ITEM 16384) itemoff 12611 itemsize 51
               refs 1 gen 6698785 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12177849692160) level 0
               tree block backref root CSUM_TREE
       item 72 key (10442627121152 EXTENT_ITEM 16384) itemoff 12560 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2538341 INODE_REF 2537331) level 0
               tree block backref root 257
       item 73 key (10442627137536 EXTENT_ITEM 16384) itemoff 12509 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2538361 INODE_REF 2537394) level 0
               tree block backref root 257
       item 74 key (10442627153920 EXTENT_ITEM 16384) itemoff 12458 itemsize 51
               refs 1 gen 672522 flags TREE_BLOCK
               tree block key (2552451 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 75 key (10442627170304 EXTENT_ITEM 16384) itemoff 12407 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115755606016) level 0
               tree block backref root CSUM_TREE
       item 76 key (10442627186688 EXTENT_ITEM 16384) itemoff 12356 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764880 INODE_REF 76762122) level 0
               tree block backref root 257
       item 77 key (10442627203072 EXTENT_ITEM 16384) itemoff 12305 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12069486489600 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 78 key (10442627219456 EXTENT_ITEM 16384) itemoff 12254 itemsize 51
               refs 1 gen 4416707 flags TREE_BLOCK
               tree block key (17422551 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 79 key (10442627252224 EXTENT_ITEM 16384) itemoff 12203 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2538389 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 80 key (10442627268608 EXTENT_ITEM 16384) itemoff 12152 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76765020 INODE_REF 76762122) level 0
               tree block backref root 257
       item 81 key (10442627284992 EXTENT_ITEM 16384) itemoff 12101 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2538408 DIR_INDEX 53) level 0
               tree block backref root 257
       item 82 key (10442627301376 EXTENT_ITEM 16384) itemoff 12050 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12069821075456 EXTENT_ITEM 974848) level 0
               tree block backref root EXTENT_TREE
       item 83 key (10442627334144 EXTENT_ITEM 16384) itemoff 11999 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12070201597952 EXTENT_ITEM 1052672) level 0
               tree block backref root EXTENT_TREE
       item 84 key (10442627350528 EXTENT_ITEM 16384) itemoff 11948 itemsize 51
               refs 1 gen 6698785 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12193235271680) level 0
               tree block backref root CSUM_TREE
       item 85 key (10442627399680 EXTENT_ITEM 16384) itemoff 11897 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK|FULL_BACKREF
               tree block key (2538447 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 86 key (10442627432448 EXTENT_ITEM 16384) itemoff 11846 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (9723383021568 EXTENT_ITEM 950272) level 0
               tree block backref root EXTENT_TREE
       item 87 key (10442627481600 EXTENT_ITEM 16384) itemoff 11795 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405214515200) level 0
               tree block backref root CSUM_TREE
       item 88 key (10442627497984 EXTENT_ITEM 16384) itemoff 11744 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405231132672) level 0
               tree block backref root CSUM_TREE
       item 89 key (10442627514368 EXTENT_ITEM 16384) itemoff 11693 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12087570075648 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 90 key (10442627530752 EXTENT_ITEM 16384) itemoff 11642 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10567585533952) level 0
               tree block backref root CSUM_TREE
       item 91 key (10442627563520 EXTENT_ITEM 16384) itemoff 11591 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12088286089216 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 92 key (10442627579904 EXTENT_ITEM 16384) itemoff 11540 itemsize 51
               refs 1 gen 6698785 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12243322048512) level 0
               tree block backref root CSUM_TREE
       item 93 key (10442627596288 EXTENT_ITEM 16384) itemoff 11489 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12068807602176 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 94 key (10442627629056 EXTENT_ITEM 16384) itemoff 11438 itemsize 51
               refs 1 gen 6727271 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12183535943680) level 0
               tree block backref root CSUM_TREE
       item 95 key (10442627645440 EXTENT_ITEM 16384) itemoff 11387 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405247750144) level 0
               tree block backref root CSUM_TREE
       item 96 key (10442627678208 EXTENT_ITEM 16384) itemoff 11336 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115772223488) level 0
               tree block backref root CSUM_TREE
       item 97 key (10442627694592 EXTENT_ITEM 16384) itemoff 11285 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12157162041344 EXTENT_ITEM 790528) level 0
               tree block backref root EXTENT_TREE
       item 98 key (10442627710976 EXTENT_ITEM 16384) itemoff 11234 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 9756884873216) level 0
               tree block backref root CSUM_TREE
       item 99 key (10442627727360 EXTENT_ITEM 16384) itemoff 11183 itemsize 51
               refs 1 gen 6464632 flags TREE_BLOCK
               tree block key (65735848 INODE_REF 58323055) level 0
               tree block backref root 257
       item 100 key (10442627776512 EXTENT_ITEM 16384) itemoff 11132 itemsize 51
               refs 1 gen 6139527 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11830064242688) level 0
               tree block backref root CSUM_TREE
       item 101 key (10442627792896 EXTENT_ITEM 16384) itemoff 11081 itemsize 51
               refs 1 gen 6464632 flags TREE_BLOCK
               tree block key (65736607 INODE_REF 65731578) level 0
               tree block backref root 257
       item 102 key (10442627858432 EXTENT_ITEM 16384) itemoff 11030 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12180178153472 EXTENT_ITEM 8192) level 0
               tree block backref root EXTENT_TREE
       item 103 key (10442627874816 EXTENT_ITEM 16384) itemoff 10979 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12180343758848 EXTENT_ITEM 14528512) level 0
               tree block backref root EXTENT_TREE
       item 104 key (10442627891200 EXTENT_ITEM 16384) itemoff 10928 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12142622306304 EXTENT_ITEM 24576) level 0
               tree block backref root EXTENT_TREE
       item 105 key (10442627907584 EXTENT_ITEM 16384) itemoff 10877 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12180880535552 EXTENT_ITEM 155648) level 0
               tree block backref root EXTENT_TREE
       item 106 key (10442627923968 EXTENT_ITEM 16384) itemoff 10826 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12204407955456) level 0
               tree block backref root CSUM_TREE
       item 107 key (10442627940352 EXTENT_ITEM 16384) itemoff 10775 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12180491771904 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 108 key (10442627956736 EXTENT_ITEM 16384) itemoff 10724 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764087 INODE_ITEM 0) level 0
               tree block backref root 257
       item 109 key (10442627973120 EXTENT_ITEM 16384) itemoff 10673 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12185288880128 EXTENT_ITEM 49152) level 0
               tree block backref root EXTENT_TREE
       item 110 key (10442627989504 EXTENT_ITEM 16384) itemoff 10622 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12206515376128) level 0
               tree block backref root CSUM_TREE
       item 111 key (10442628005888 EXTENT_ITEM 16384) itemoff 10571 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12185404018688 EXTENT_ITEM 1052672) level 0
               tree block backref root EXTENT_TREE
       item 112 key (10442628022272 EXTENT_ITEM 16384) itemoff 10520 itemsize 51
               refs 1 gen 6464632 flags TREE_BLOCK
               tree block key (27390978 INODE_ITEM 0) level 0
               tree block backref root 257
       item 113 key (10442628038656 EXTENT_ITEM 16384) itemoff 10469 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12196305096704 EXTENT_ITEM 12288) level 0
               tree block backref root EXTENT_TREE
       item 114 key (10442628055040 EXTENT_ITEM 16384) itemoff 10418 itemsize 51
               refs 1 gen 6464632 flags TREE_BLOCK
               tree block key (17346964 INODE_REF 17346635) level 0
               tree block backref root 257
       item 115 key (10442628071424 EXTENT_ITEM 16384) itemoff 10367 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12202632044544 EXTENT_ITEM 135168) level 0
               tree block backref root EXTENT_TREE
       item 116 key (10442628104192 EXTENT_ITEM 16384) itemoff 10316 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12184667025408 EXTENT_ITEM 4198400) level 0
               tree block backref root EXTENT_TREE
       item 117 key (10442628120576 EXTENT_ITEM 16384) itemoff 10265 itemsize 51
               refs 1 gen 6236744 flags TREE_BLOCK
               tree block key (76764208 EXTENT_DATA 0) level 0
               tree block backref root 257
       item 118 key (10442628136960 EXTENT_ITEM 16384) itemoff 10214 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12223140970496 EXTENT_ITEM 1114112) level 0
               tree block backref root EXTENT_TREE
       item 119 key (10442628153344 EXTENT_ITEM 16384) itemoff 10163 itemsize 51
               refs 1 gen 6464632 flags TREE_BLOCK
               tree block key (57503313 INODE_REF 5903664) level 0
               tree block backref root 257
       item 120 key (10442628169728 EXTENT_ITEM 16384) itemoff 10112 itemsize 51
               refs 1 gen 6727271 flags TREE_BLOCK
               tree block key (12282814701568 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 121 key (10442628186112 EXTENT_ITEM 16384) itemoff 10061 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12223473651712 EXTENT_ITEM 729088) level 0
               tree block backref root EXTENT_TREE
       item 122 key (10442628202496 EXTENT_ITEM 16384) itemoff 10010 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12224274079744 EXTENT_ITEM 3145728) level 0
               tree block backref root EXTENT_TREE
       item 123 key (10442628218880 EXTENT_ITEM 16384) itemoff 9959 itemsize 51
               refs 1 gen 6835701 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 9822438273024) level 0
               tree block backref root CSUM_TREE
       item 124 key (10442628251648 EXTENT_ITEM 16384) itemoff 9908 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12224877871104 EXTENT_ITEM 15855616) level 0
               tree block backref root EXTENT_TREE
       item 125 key (10442628268032 EXTENT_ITEM 16384) itemoff 9857 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12225476325376 EXTENT_ITEM 208896) level 0
               tree block backref root EXTENT_TREE
       item 126 key (10442628284416 EXTENT_ITEM 16384) itemoff 9806 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12226798768128 EXTENT_ITEM 2101248) level 0
               tree block backref root EXTENT_TREE
       item 127 key (10442628300800 EXTENT_ITEM 16384) itemoff 9755 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12227805872128 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 128 key (10442628317184 EXTENT_ITEM 16384) itemoff 9704 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12233946206208 EXTENT_ITEM 20480) level 0
               tree block backref root EXTENT_TREE
       item 129 key (10442628333568 EXTENT_ITEM 16384) itemoff 9653 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12233996038144 EXTENT_ITEM 233472) level 0
               tree block backref root EXTENT_TREE
       item 130 key (10442628349952 EXTENT_ITEM 16384) itemoff 9602 itemsize 51
               refs 1 gen 6698785 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12160562507776) level 0
               tree block backref root CSUM_TREE
       item 131 key (10442628366336 EXTENT_ITEM 16384) itemoff 9551 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12237278531584 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 132 key (10442628382720 EXTENT_ITEM 16384) itemoff 9500 itemsize 51
               refs 1 gen 6727271 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12421121183744) level 0
               tree block backref root CSUM_TREE
       item 133 key (10442628399104 EXTENT_ITEM 16384) itemoff 9449 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12237030932480 EXTENT_ITEM 118784) level 0
               tree block backref root EXTENT_TREE
       item 134 key (10442628415488 EXTENT_ITEM 16384) itemoff 9398 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12237580976128 EXTENT_ITEM 4194304) level 0
               tree block backref root EXTENT_TREE
       item 135 key (10442628431872 EXTENT_ITEM 16384) itemoff 9347 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12241256226816 EXTENT_ITEM 200704) level 0
               tree block backref root EXTENT_TREE
       item 136 key (10442628448256 EXTENT_ITEM 16384) itemoff 9296 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12241758822400 EXTENT_ITEM 28672) level 0
               tree block backref root EXTENT_TREE
       item 137 key (10442628464640 EXTENT_ITEM 16384) itemoff 9245 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12253141274624 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 138 key (10442628481024 EXTENT_ITEM 16384) itemoff 9194 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11321250156544) level 0
               tree block backref root CSUM_TREE
       item 139 key (10442628497408 EXTENT_ITEM 16384) itemoff 9143 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405264367616) level 0
               tree block backref root CSUM_TREE
       item 140 key (10442628513792 EXTENT_ITEM 16384) itemoff 9092 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10405280935936) level 0
               tree block backref root CSUM_TREE
       item 141 key (10442628562944 EXTENT_ITEM 16384) itemoff 9041 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12265441398784 EXTENT_ITEM 2097152) level 0
               tree block backref root EXTENT_TREE
       item 142 key (10442628579328 EXTENT_ITEM 16384) itemoff 8990 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12271441833984 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 143 key (10442628595712 EXTENT_ITEM 16384) itemoff 8939 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12272561885184 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 144 key (10442628612096 EXTENT_ITEM 16384) itemoff 8888 itemsize 51
               refs 1 gen 309972 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 11115788840960) level 0
               tree block backref root CSUM_TREE
       item 145 key (10442628628480 EXTENT_ITEM 16384) itemoff 8837 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12282866843648 EXTENT_ITEM 905216) level 0
               tree block backref root EXTENT_TREE
       item 146 key (10442628644864 EXTENT_ITEM 16384) itemoff 8786 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12283205406720 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 147 key (10442628661248 EXTENT_ITEM 16384) itemoff 8735 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10434327703552) level 0
               tree block backref root CSUM_TREE
       item 148 key (10442628677632 EXTENT_ITEM 16384) itemoff 8684 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12289339404288 EXTENT_ITEM 81920) level 0
               tree block backref root EXTENT_TREE
       item 149 key (10442628694016 EXTENT_ITEM 16384) itemoff 8633 itemsize 51
               refs 1 gen 302689 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10434344321024) level 0
               tree block backref root CSUM_TREE
       item 150 key (10442628710400 EXTENT_ITEM 16384) itemoff 8582 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12299776696320 EXTENT_ITEM 3145728) level 0
               tree block backref root EXTENT_TREE
       item 151 key (10442628726784 EXTENT_ITEM 16384) itemoff 8531 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12299871612928 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 152 key (10442628743168 EXTENT_ITEM 16384) itemoff 8480 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12302335598592 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 153 key (10442628759552 EXTENT_ITEM 16384) itemoff 8429 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12207655321600) level 0
               tree block backref root CSUM_TREE
       item 154 key (10442628775936 EXTENT_ITEM 16384) itemoff 8378 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12302453288960 EXTENT_ITEM 2097152) level 0
               tree block backref root EXTENT_TREE
       item 155 key (10442628792320 EXTENT_ITEM 16384) itemoff 8327 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12303679279104 EXTENT_ITEM 98304) level 0
               tree block backref root EXTENT_TREE
       item 156 key (10442628808704 EXTENT_ITEM 16384) itemoff 8276 itemsize 51
               refs 1 gen 6680401 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 12209255579648) level 0
               tree block backref root CSUM_TREE
       item 157 key (10442628825088 EXTENT_ITEM 16384) itemoff 8225 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12306045173760 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 158 key (10442628841472 EXTENT_ITEM 16384) itemoff 8174 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12306189029376 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE
       item 159 key (10442628857856 EXTENT_ITEM 16384) itemoff 8123 itemsize 51
               refs 1 gen 6487789 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10596968013824) level 0
               tree block backref root CSUM_TREE
       item 160 key (10442628874240 EXTENT_ITEM 16384) itemoff 8072 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12310012329984 EXTENT_ITEM 131072) level 0
               tree block backref root EXTENT_TREE
       item 161 key (10442628923392 EXTENT_ITEM 16384) itemoff 8021 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12311480930304 EXTENT_ITEM 61440) level 0
               tree block backref root EXTENT_TREE
       item 162 key (10442628972544 EXTENT_ITEM 16384) itemoff 7970 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12317130739712 EXTENT_ITEM 1052672) level 0
               tree block backref root EXTENT_TREE
       item 163 key (10442628988928 EXTENT_ITEM 16384) itemoff 7919 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12317269188608 EXTENT_ITEM 2097152) level 0
               tree block backref root EXTENT_TREE
       item 164 key (10442629005312 EXTENT_ITEM 16384) itemoff 7868 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12317973839872 EXTENT_ITEM 4096) level 0
               tree block backref root EXTENT_TREE
       item 165 key (10442629021696 EXTENT_ITEM 16384) itemoff 7817 itemsize 51
               refs 1 gen 6834895 flags TREE_BLOCK
               tree block key (EXTENT_CSUM EXTENT_CSUM 10051564580864) level 0
               tree block backref root CSUM_TREE
       item 166 key (10442629038080 EXTENT_ITEM 16384) itemoff 7766 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12318824312832 EXTENT_ITEM 2097152) level 0
               tree block backref root EXTENT_TREE
       item 167 key (10442629054464 EXTENT_ITEM 16384) itemoff 7715 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12319312617472 EXTENT_ITEM 4993024) level 0
               tree block backref root EXTENT_TREE
       item 168 key (10442629070848 EXTENT_ITEM 16384) itemoff 7664 itemsize 51
               refs 1 gen 6787103 flags TREE_BLOCK
               tree block key (12319524802560 EXTENT_ITEM 1048576) level 0
               tree block backref root EXTENT_TREE

----

Thanks,
-- Laurence


On Tue, Mar 8, 2022 at 9:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/3/9 09:09, bill gates wrote:
> > This filesystem was most likely created in 2014 using the tools of
> > that time, at least that's the oldest file in my home directory. It
> > _might_ have been made in 2019, that's the date on the mount point.
> >
> > There are 2 subvolumes on /dev/sda2, /home and /var.
> >
> > My btrfs-progs version is 5.15.1.
> >
> > Per your request:
> > # btrfs ins dump-tree -b 10442806968320 /dev/sda2
> > btrfs-progs v5.15.1
>
> Weird, the output doesn't match the dmesg.
>
> This tree belongs to csum tree, not root tree.
>
> Thanks,
> Qu
> > leaf 10442806968320 items 34 free space 6225 generation 6834902 owner CSUM_TREE
> > leaf 10442806968320 flags 0x1(WRITTEN) backref revision 1
> > fs uuid 83c6c9ca-b8fe-4d4c-aaa8-1729f90b0824
> > chunk uuid 9b77400b-f370-4f49-be82-9cb38c7f78a0
> >         item 0 key (EXTENT_CSUM EXTENT_CSUM 9848629587968) itemoff
> > 16075 itemsize 208
> >                 range start 9848629587968 end 9848629800960 length 212992
> >         item 1 key (EXTENT_CSUM EXTENT_CSUM 9848630026240) itemoff
> > 15823 itemsize 252
> >                 range start 9848630026240 end 9848630284288 length 258048
> >         item 2 key (EXTENT_CSUM EXTENT_CSUM 9848630714368) itemoff
> > 15815 itemsize 8
> >                 range start 9848630714368 end 9848630722560 length 8192
> >         item 3 key (EXTENT_CSUM EXTENT_CSUM 9848630984704) itemoff
> > 14723 itemsize 1092
> >                 range start 9848630984704 end 9848632102912 length 1118208
> >         item 4 key (EXTENT_CSUM EXTENT_CSUM 9848632160256) itemoff
> > 14703 itemsize 20
> >                 range start 9848632160256 end 9848632180736 length 20480
> >         item 5 key (EXTENT_CSUM EXTENT_CSUM 9848632180736) itemoff
> > 14279 itemsize 424
> >                 range start 9848632180736 end 9848632614912 length 434176
> >         item 6 key (EXTENT_CSUM EXTENT_CSUM 9848632942592) itemoff
> > 14067 itemsize 212
> >                 range start 9848632942592 end 9848633159680 length 217088
> >         item 7 key (EXTENT_CSUM EXTENT_CSUM 9848633286656) itemoff
> > 13815 itemsize 252
> >                 range start 9848633286656 end 9848633544704 length 258048
> >         item 8 key (EXTENT_CSUM EXTENT_CSUM 9848633548800) itemoff
> > 13579 itemsize 236
> >                 range start 9848633548800 end 9848633790464 length 241664
> >         item 9 key (EXTENT_CSUM EXTENT_CSUM 9848633810944) itemoff
> > 13527 itemsize 52
> >                 range start 9848633810944 end 9848633864192 length 53248
> >         item 10 key (EXTENT_CSUM EXTENT_CSUM 9848633950208) itemoff
> > 12671 itemsize 856
> >                 range start 9848633950208 end 9848634826752 length 876544
> >         item 11 key (EXTENT_CSUM EXTENT_CSUM 9848634826752) itemoff
> > 12659 itemsize 12
> >                 range start 9848634826752 end 9848634839040 length 12288
> >         item 12 key (EXTENT_CSUM EXTENT_CSUM 9848634970112) itemoff
> > 12643 itemsize 16
> >                 range start 9848634970112 end 9848634986496 length 16384
> >         item 13 key (EXTENT_CSUM EXTENT_CSUM 9848635056128) itemoff
> > 12583 itemsize 60
> >                 range start 9848635056128 end 9848635117568 length 61440
> >         item 14 key (EXTENT_CSUM EXTENT_CSUM 9848635117568) itemoff
> > 12151 itemsize 432
> >                 range start 9848635117568 end 9848635559936 length 442368
> >         item 15 key (EXTENT_CSUM EXTENT_CSUM 9848635592704) itemoff
> > 12135 itemsize 16
> >                 range start 9848635592704 end 9848635609088 length 16384
> >         item 16 key (EXTENT_CSUM EXTENT_CSUM 9848635703296) itemoff
> > 11791 itemsize 344
> >                 range start 9848635703296 end 9848636055552 length 352256
> >         item 17 key (EXTENT_CSUM EXTENT_CSUM 9848636108800) itemoff
> > 11719 itemsize 72
> >                 range start 9848636108800 end 9848636182528 length 73728
> >         item 18 key (EXTENT_CSUM EXTENT_CSUM 9848636669952) itemoff
> > 11691 itemsize 28
> >                 range start 9848636669952 end 9848636698624 length 28672
> >         item 19 key (EXTENT_CSUM EXTENT_CSUM 9848636698624) itemoff
> > 11371 itemsize 320
> >                 range start 9848636698624 end 9848637026304 length 327680
> >         item 20 key (EXTENT_CSUM EXTENT_CSUM 9848637026304) itemoff
> > 10979 itemsize 392
> >                 range start 9848637026304 end 9848637427712 length 401408
> >         item 21 key (EXTENT_CSUM EXTENT_CSUM 9848637468672) itemoff
> > 10131 itemsize 848
> >                 range start 9848637468672 end 9848638337024 length 868352
> >         item 22 key (EXTENT_CSUM EXTENT_CSUM 9848638631936) itemoff
> > 10079 itemsize 52
> >                 range start 9848638631936 end 9848638685184 length 53248
> >         item 23 key (EXTENT_CSUM EXTENT_CSUM 9848638685184) itemoff
> > 9791 itemsize 288
> >                 range start 9848638685184 end 9848638980096 length 294912
> >         item 24 key (EXTENT_CSUM EXTENT_CSUM 9848638980096) itemoff
> > 9787 itemsize 4
> >                 range start 9848638980096 end 9848638984192 length 4096
> >         item 25 key (EXTENT_CSUM EXTENT_CSUM 9848638984192) itemoff
> > 9735 itemsize 52
> >                 range start 9848638984192 end 9848639037440 length 53248
> >         item 26 key (EXTENT_CSUM EXTENT_CSUM 9848639045632) itemoff
> > 9111 itemsize 624
> >                 range start 9848639045632 end 9848639684608 length 638976
> >         item 27 key (EXTENT_CSUM EXTENT_CSUM 9848639684608) itemoff
> > 9091 itemsize 20
> >                 range start 9848639684608 end 9848639705088 length 20480
> >         item 28 key (EXTENT_CSUM EXTENT_CSUM 9848639967232) itemoff
> > 8003 itemsize 1088
> >                 range start 9848639967232 end 9848641081344 length 1114112
> >         item 29 key (EXTENT_CSUM EXTENT_CSUM 9848641150976) itemoff
> > 7947 itemsize 56
> >                 range start 9848641150976 end 9848641208320 length 57344
> >         item 30 key (EXTENT_CSUM EXTENT_CSUM 9848641409024) itemoff
> > 7887 itemsize 60
> >                 range start 9848641409024 end 9848641470464 length 61440
> >         item 31 key (EXTENT_CSUM EXTENT_CSUM 9848641695744) itemoff
> > 7643 itemsize 244
> >                 range start 9848641695744 end 9848641945600 length 249856
> >         item 32 key (EXTENT_CSUM EXTENT_CSUM 9848642043904) itemoff
> > 7615 itemsize 28
> >                 range start 9848642043904 end 9848642072576 length 28672
> >         item 33 key (EXTENT_CSUM EXTENT_CSUM 9848642162688) itemoff
> > 7075 itemsize 540
> >                 range start 9848642162688 end 9848642715648 length 552960
> >
> >
> > On Tue, Mar 8, 2022 at 5:48 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/3/9 03:05, bill gates wrote:
> >>> So, I recently attempted to upgrade from Linux kernel 4.19.82 to
> >>> 5.15.23, and I'm getting a critical error in dmesg about a corrupt
> >>> leaf (and no mounting of /home allowed with the options I'm aware of)
> >>>
> >>> [ 396.218964] BTRFS critical (device sda2): corrupt leaf: root=1
> >>> block=10442806968320 sl
> >>> ot=8 ino=6, invalid location key objectid: has 1 expect 6 or [256,
> >>> 18446744073709551360]
> >>> or 18446744073709551604
> >>
> >> Please provide the following output:
> >>
> >> # btrfs ins dump-tree -b 10442806968320 /dev/sda2
> >>
> >>
> >> The error message means, we got a DIR_ITEM in root tree.
> >>
> >> Normally that is used to indicate what default subvolume is.
> >> Thus it's normally 6 or 5, or any valid subvolume id.
> >>
> >> But in your case, it's 1, thus tree-checker is rejecting your root tree.
> >>
> >> I didn't thought we could have 1 as default subvolume (as 1 is the root
> >> tree, which is not a subvolume).
> >>
> >> But it looks like we should update btrfs check to fix this case.
> >>
> >> Is the fs created using older btrfs-progs? I guess that may be the cause...
> >>
> >> Thanks,
> >> Qu
> >>
> >>
> >>> [ 396.218967] BTRFS error (device sda2): block=10442806968320 read
> >>> time tree block corru
> >>> ption detected
> >>>
> >>>
> >>> Interestingly. that 18446... number is a power of 2, looks like maybe
> >>> a bit flip? dmesg, uname, etc included in pastebin below. "btrfs
> >>> check" found no problems with fs on either kernel version. Would like
> >>> to figure out how to fix this, if possible.
> >>>
> >>> https://pastebin.com/0ESPU9Z6
> >>>
> >>> Thank you for any assistance,
> >>> -- Laurence Michaels.
