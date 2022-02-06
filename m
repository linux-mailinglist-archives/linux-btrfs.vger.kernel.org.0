Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEDD4AAF2A
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Feb 2022 13:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiBFM0A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Feb 2022 07:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiBFM0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Feb 2022 07:26:00 -0500
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 04:25:57 PST
Received: from eu-shark2.inbox.eu (eu-shark2.inbox.eu [195.216.236.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8BBC043182
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Feb 2022 04:25:57 -0800 (PST)
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 831D41E0008A;
        Sun,  6 Feb 2022 14:19:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1644149990; bh=0aUV2R5M49c4drLpXN7D0e8DoghY3a+YbbzoTDrRsSs=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
         Content-Type:X-ESPOL:from:date:to:cc;
        b=Q0bj/BLqCRxzdishMweHOCqY2s/i91ys/XSOAYpnfQOwDg0TXEr1O5SgQMvftgAw+
         6syq67yMSvGlSUH7Ly4S6Qh5LRzlW1VRRKg9hPk9CNdd8VAuzN72PhFQBcVipT+UjZ
         vuoPud/8tml5ZNXsb4euxkSTsgjN/uq4utfBQmZo=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 768561E00093;
        Sun,  6 Feb 2022 14:19:50 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id YriyvBu5vsKB; Sun,  6 Feb 2022 14:19:50 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id E2B461E0008A;
        Sun,  6 Feb 2022 14:19:49 +0200 (EET)
References: <20220205203028.4F35.409509F4@e16-tech.com>
 <27f44938-e58b-8566-0359-ef0260bd9b84@gmx.com>
 <20220205224936.478B.409509F4@e16-tech.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: tree-checker: check item_size for dev_item
Date:   Sun, 06 Feb 2022 20:12:20 +0800
In-reply-to: <20220205224936.478B.409509F4@e16-tech.com>
Message-ID: <5ypsw5k3.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1ml5Y3ejOlil2/Qn/cGwczrjRLXOn5iJm3kEIZgAiJPFTkYip5XRGxnW10RX+5ujkX
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 05 Feb 2022 at 22:49, Wang Yugui <wangyugui@e16-tech.com> 
wrote:

> Hi,
>
>> >>>> A btrfs filesystem failed to boot with this patch.
>> >>>>
>> >>>> corrupt leaf: root=3 block=1081344 slot=0 devid=1 invalid 
>> >>>> item
>> >>>> size: has 0 expect 98
>> >>>>
>> >>>> Any way to fix it online?
>> >>>
>> >>> This btrfs filesystem is created by centos 7.9 installer 
>> >>> (btrfs
>> >>> 4.9?)
>> >>> about 1 years ago.  and then mainly writen by kernel
>> >>> 5.4/5.10/5.15.
>> >>>
>> >> Yes, btrfs-progs v4.9 and v3.10 based kernel.
>> >> I created a btrfs and it looks fine.
>> >> Could please provide output of
>> >> btrfs inspect-internal dump-tree $device -t 3
>> >> ?
>> >> You can trim it if the content is too long only leaf 1081344 
>> >> is needed.
>> >
>> > Hi,
>> >
>> > # btrfs filesystem show /
>> > Label: 'OS_T640'  uuid: 73dcce98-8f6b-4ec8-bfac-fa7c7c87409d
>> >          Total devices 10 FS bytes used 5.53TiB
>> >          devid    1 size 799.00GiB used 332.01GiB path 
>> >          /dev/sda2
>> >          devid    2 size 1.75TiB used 741.00GiB path 
>> >          /dev/sdg1
>> >          devid    3 size 1.75TiB used 745.00GiB path 
>> >          /dev/sdj1
>> >          devid    4 size 1.75TiB used 740.00GiB path 
>> >          /dev/sdi1
>> >          devid    5 size 1.75TiB used 745.00GiB path 
>> >          /dev/sdd1
>> >          devid    6 size 1.75TiB used 480.00GiB path 
>> >          /dev/sde1
>> >          devid    7 size 1.75TiB used 480.00GiB path 
>> >          /dev/sdh1
>> >          devid    8 size 1.75TiB used 479.00GiB path 
>> >          /dev/sdc1
>> >          devid    9 size 1.75TiB used 480.00GiB path 
>> >          /dev/sdb1
>> >          devid   10 size 1.75TiB used 479.00GiB path 
>> >          /dev/sdf1
>> >
>> > #btrfs inspect-internal dump-tree /dev/sda2 -t 3 > 3.txt
>> >
>> > and then 3.txt is zipped as  this attachment file(3.zip)
>>
>> Full dmesg of the boot failure please.
>>
>> The dump-tree shows the device item is completely sane, it has 
>> size 98,
>> not the value (0) reported from tree-checker.
>>
>> Thus I don't know why tree-checker is reporting this problem.
>>
>
> This (attachment file boot.dmesg.txt.zip ) is the full dmesg 
> output
>
As Qu suggested to me, would you plase provide output after
apply of the following diff? (It may crash the kernel if there is 
*real*
one invalid dev_item).

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9fd145f1c4bc..5fb981b4b42a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -25,6 +25,7 @@
 #include "volumes.h"
 #include "misc.h"
 #include "btrfs_inode.h"
+#include "print-tree.h"

 /*
  * Error message should follow the following format:
@@ -977,6 +978,7 @@ static int check_dev_item(struct extent_buffer 
*leaf,
        if (unlikely(item_size != sizeof(*ditem))) {
                dev_item_err(leaf, slot, "invalid item size: has 
                %u expect %zu",
                             item_size, sizeof(*ditem));
+               btrfs_print_leaf(leaf);
                return -EUCLEAN;
        }


--
Su
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/02/05
>
> [2. application/x-zip-compressed; boot.dmesg.txt.zip]...
