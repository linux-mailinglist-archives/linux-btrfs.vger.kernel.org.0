Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A414558F3ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 23:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiHJVsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 17:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiHJVsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 17:48:30 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46F2796A7
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 14:48:28 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4M33Tg1nFRz9sWy
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 23:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=balkonien.org;
        s=MBO0001; t=1660168103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PtE6crTFH3OmAByxat865L98ey3Es2n11cT9yFa5mps=;
        b=c02JyAP15iv3TtQk09/WfyLnZt0RleyKKNXmn8wkynaQ1eJ1T9VwXYWpx8V746Bk/kk3ze
        O9//bVbag7hE9/0ThMxbdMhAKgKWU14V+GJycX9dSAHEbhfN+gZxbuHxXCeWRD8flvQAH4
        5MhZt6cWynGrbbcoC0deplyhVQDQ5ALKD9zogjzpTDwTnG8/64IaelPPdUJ64sXRJFJ2CO
        ykcwCp4n4d9Wy1jquAyeqWY3myPg85fdmx8SKi0eZw9g/gKdUsv9YTHcYSwUxGeeqWgjA/
        iFcCqyj5v8f155w/Z6Hzqc0LTNlVi64WiIIaIsRdebnHTKoPl0mmAE+qQsHPrg==
Message-ID: <b4f62b10-b295-26ea-71f9-9a5c9299d42c@balkonien.org>
Date:   Wed, 10 Aug 2022 23:48:17 +0200
MIME-Version: 1.0
Content-Language: de-DE
To:     linux-btrfs@vger.kernel.org
From:   Samuel Greiner <samuel@balkonien.org>
Subject: btrfs replace interrupted + corruptes fs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear folks,

I have the feeling of being in trouble.

I have a btrfs fs upon 4 HDs. 1 HD should be replaced.

1. I issued the btrfs replace command, but got the message, that the 
target HD is mounted (it was not, it did not appear in the mount output).

2. I did a system reboot in hope to do a successfull replace. The system 
did not start but said, that it could not mount the btrfs fs because of 
a missing device.

3. I booted GParted Live to investigate further.

3.1 A mount -o degraded,rescue=usebackuproot,ro failed.
In dmesg I get the following errors

flagging fs with big metadata feature
allowing degraded mounts
trying to use backup root at mount time
disk space caching is enabled
has skinny extents
bdev /dev/sda errs: wr 755, rd 0, flush 0, corrupt 0, gen 0
bdev /dev/sdd1 errs: wr 7601141, rd  3801840, flush 12, corrupt 3755, 
gen 245
replace devid present without n active replace item
failed to init dev_replace -117
open_ctree failed

4. btrfs check runs through without error

-> I guess even if i was prompted the message, that the target device of 
the btrfs replace was mounted the replace was started. Due to the reboot 
now there seems to be errors in the filesystem additional to an replace 
which i cannot stop, because i can't mount the filesystem.

Right now I have a btrfs check --check-data-csum running in hope to get 
the errors fixed.

But actionally I really don't know how to deal with that situation.

Do you have any recommondations?


Thank you very much!
Samuel


Additional info:

I'm on an recent debian bullseye. But I can't run uname -r because right 
now I'm on the GParted (1.4.0-5) Live-System.

btrfs fi show /dev/sdd1
Label: 'Data' uuid:
     Total devices 4 FS bytes used 6.59 TiB
     devid 1 size 3.65 TiB used 3.39 TiB path /dev/sdd1
     devid 2 size 2.73 TiB used 2.49 TiB path /dev/sdb1
     devid 3 size 5.46 TiB used 2.11 TiB path /dev/sdc1
     devid 1 size 5.46 TiB used 5.21 TiB path /dev/sdd1
