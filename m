Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FE7E1670
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Nov 2023 21:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjKEUis (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 15:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEUir (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 15:38:47 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288C7B8
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 12:38:44 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cba6e8e65so24431601cf.2
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Nov 2023 12:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699216723; x=1699821523; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1mT65/JWpbkA21kNG0x8u3Svy2mrHfmYB46PWJD9ps=;
        b=THeG6obN81G/hNbjKiJvpbHNEx1SAv/TLXl8lz7ZEoEWjsGkhwJD/FE/Yw5vTU0c6f
         ZVcJjFYv9qQgDFfnMocUSpY9tl6h+bsp7K+avN/wP7ny+9l7f5zhUxEmyj3TI4xAL0EG
         uicAOKX0A+IgHm9vqT8aI4T5Kdzeb4VS9WXHKZTUPiz4TqbjmvWSAE4aUwn4EzKocyt4
         qlWrOd3LC4kAKbu/iNasnxOj4dvFXdKggaR5Q5ksoAFWnml6qsDT6+dLQybHDI/fQE6+
         qYhqRvKev3Pu/KEFPqaUy/TylHC8OpDitVgHhGnz3hTpTAfBimRiWJxCrhTHAiw8DkKb
         L1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699216723; x=1699821523;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1mT65/JWpbkA21kNG0x8u3Svy2mrHfmYB46PWJD9ps=;
        b=CFro8lL1JdwHmwjEVAHZerb0kPLr5Vl2kR0b9igNCYA7Vtstlm54CQdgpaLD2HkyBa
         klvr9Sc0RzaAyNpPiWSQ5sp6lUZMkPwIa5K76orGfBvHRAaW7kjL5FFDcTJSBpCbgG5p
         povwDnX79pcsmFNCgkbZ0qJS6xBlSiK9S88wgSXi+TCE5/M3E0NDPdXyOPnzqtS80pTt
         Ns1BGvTDWPp4yoCMY2ZD56Ovgxfb7Fgm7Ir7dg3wEN99moR7jt6JTMcdRuh3aSTNrBnd
         TBo2jDwPuazbpgxWdrdGsFO57/Hy7TbWjLl/IgTlp/4TCp9u1PieP73QLlvEmaaHLEXl
         MNBA==
X-Gm-Message-State: AOJu0YwCLWyEzMrjNAb3MNhKrBCgyRKUvcnWAtfCjdd2aWOqKdS1qgN6
        XM8vGPNsL2JKbPgRIk8ElTqte7X/rr4=
X-Google-Smtp-Source: AGHT+IHn1uvs8dI7SBOv5YpiB0geqBn86MFyoD+N7dealZ9wsgO3rdHD5vCKN0VPfgYnB3ac/q/mVQ==
X-Received: by 2002:a05:622a:1344:b0:417:f5ff:c14a with SMTP id w4-20020a05622a134400b00417f5ffc14amr33545435qtk.43.1699216722943;
        Sun, 05 Nov 2023 12:38:42 -0800 (PST)
Received: from [192.168.1.1] (pool-100-16-13-166.bltmmd.fios.verizon.net. [100.16.13.166])
        by smtp.gmail.com with ESMTPSA id p16-20020ac87410000000b00419732075b4sm2768418qtq.84.2023.11.05.12.38.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 12:38:42 -0800 (PST)
Message-ID: <9de00454-0cd9-4d2d-aed4-23490f7dde83@gmail.com>
Date:   Sun, 5 Nov 2023 15:38:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     BTRFS Mailing-List <linux-btrfs@vger.kernel.org>
From:   Joe Salmeri <jmscdba@gmail.com>
Subject: Can btrfs repair this ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I was running openSUSE Tumbleweed build 20231001 when I first found this 
issue but updated to TW build 20231031 the other day and it still 
reports the same issue.

Kernel 6.5.9-1 btrfsprogs 6.5.1-1.2 Device Samsung 860 EVO 500 GB 
Partion #5 root btrfs filesystem, no RAID or other drives

I run "btrfs device stats /" about once a week and no problems are reported.

I run "btrfs scrub start /"   regularly too and no problem are reported

I ran "btrfs check --readonly --force /dev/sda5" the other day and got 
the following errors:

         Opening filesystem to check...

         WARNING: filesystem mounted, continuing because of --force
         Checking filesystem on /dev/sda5
         UUID: 7591d83f-f78e-402b-afe5-fab23dad0ffe
         [1/7] checking root items
         [2/7] checking extents
         [3/7] checking free space cache
         [4/7] checking fs roots
         root 262 inode 31996735 errors 1, no inode item
                 unresolved ref dir 132030 index 769 namelen 36 name 
02179466-b671-4313-8fa5-0eb87d716f92 filetype 2 errors 5, no dir item, 
no inode ref
                 unresolved ref dir 132030 index 769 namelen 36 name 
77ef9cd4-0efe-46af-bf7f-47f582851e16 filetype 2 errors 2, no dir index
         ERROR: errors found in fs roots
         found 33034690560 bytes used, error(s) found
         total csum bytes: 28819244
         total tree bytes: 986251264
         total fs tree bytes: 876134400
         total extent tree bytes: 62521344
         btree space waste bytes: 277302161
         file data blocks allocated: 141608800256
          referenced 39054090240

Running "find -inum 31996735" identifies the item is is complaining about as

         /usr/bin/find: File system loop detected; 
‘./.snapshots/1/snapshot’ is part of the same file system loop as ‘.’.
         /usr/bin/find: 
‘./home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-0eb87d716f92’: 
No such file or directory

Running "ls -al /home/denise/.config/skypeforlinux/blob_storage/" also 
shows that this is correct item

     drwx------ 1 denise joe-denise   72 Nov  1 22:49 .
     drwxr-xr-x 1 denise joe-denise 3.7K Nov  1 20:07 ..
     d????????? ? ?      ?             ?            ? 
02179466-b671-4313-8fa5-0eb87d716f92

When I originally ran btrfs check there were actually a bunch of other 
items listed, however, I have timeline snapshots turned on for the 
/@home subvolume and all the other items were because of that item in 
each of the other snapshots.

I removed all the other "home" snapshots and now btrfs check only 
reports that one item as shown above.

I have heard that btrfs check --repair is generally not recommended but 
I have been unable to find a way to have btrfs remove the item it is 
complaining about.

I have tried rmdir, rm -rf, as well as find -inum 31996735 -delete and 
all report the same issue with not found.

If I understand correctly, the parent directory entry ( so 
/home/denise/.config/skypeforlinux/blob_storage/ ) has the entry for 
/home/denise/.config/skypeforlinux/blob_storage/02179466-b671-4313-8fa5-0eb87d716f92 
with inode of 31996735 but it doesn't really exist.

I do not consider this a HW issue because btrfs stats, scrub, and smart 
do not report any errors and I also track all the smart info ( health, 
reallocated sector, wear leveling, etc ) for SSDs and there are no 
errors reported and I am not having any other issues.

I suspect that this occurred the other day when Skype crashed. The item 
is not needed, I just cannot figure out how to remove it.

So, is it possible for me to remove this item and if so how do I do it ?

-- 
Regards,

Joe

