Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1BB558AD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiFWVgh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 17:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFWVgh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 17:36:37 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068474F1D9
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 14:36:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 128so770223pfv.12
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=UvDK2/oJND1ywPhRY1ayuNU3kfPX2feiTxfynfVcjR0=;
        b=bimQ9smlq/ISycyo2sR1qiLgy+DGmstY/jaF+XAMgPx7AymQOqOtzQndjEeUweqsCT
         lKmib5eUiQhgXB/CT0ECiEVE8+FbX+5btzVgZrareUyat6AH/kX9nGMAMZZvOpLpTKPv
         ZoPtBE8sKNPL8mRs97RJ5yEZVIMs07X44NPE9SfnG2vycL6GwxluEij8OImVL4elJi7L
         HYyxxWyQ+fM3qlJjxrog+rph2qI42hJEJn1aOos0sCF7uHR52/wF9tEVxJbuZjE0/mdO
         IHyblwKsb8kJ+rT4pn9XPiRP87sQqhT8p3cEvftwkcy/man85U+5JF2jx+SLsXnH97TW
         PZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=UvDK2/oJND1ywPhRY1ayuNU3kfPX2feiTxfynfVcjR0=;
        b=OMTEUpBeUhEgBMXn/38iCkZeNj9068OyrZ+m9I8SoqvvpWjftxJ4E1/kxoRI1DIllI
         tkJCT4K5gxYvpHSimFkenB1slN51D6ik0Cv0rqqWmybo40OUXWpdoW932+6hgLFxvLCA
         k0edDj8zD3tmA9qM03LEPTGccSJOx24XixZ1AbvP02WFTEUbzS9SOx9gj76snvMnTrm0
         BiGYMmTXu5lviGgoLLTmMWBSmp00ViirR7DgPX7FqnuucQ7tsvy9HTuPdENDZ3znmC8Q
         kMn0XaahBo1iE5Il73acZf+CUw7Kwb6EqQyTG7Xr2eIWUpaAQK12a/xAMrQSqM3N/JJi
         mYEA==
X-Gm-Message-State: AJIora9vci7/Yq+vYFZxO53Sy9pPJz4AoFsCF63I7G9k016KHCXKQftj
        wd92Uz5KgsxAFCOo4VeOGR5vATZSRbo=
X-Google-Smtp-Source: AGRyM1sJI6RcBk80mxcqjxE6g464+iWaWBGks+gtehxWNmFAXRvcb5xVUZRx+2T74wa8Nol2slkoig==
X-Received: by 2002:a63:794e:0:b0:40d:99b:bb4 with SMTP id u75-20020a63794e000000b0040d099b0bb4mr9212414pgc.133.1656020195054;
        Thu, 23 Jun 2022 14:36:35 -0700 (PDT)
Received: from ?IPV6:2601:600:9c80:6570:dabb:c1ff:fe0f:3e57? ([2601:600:9c80:6570:dabb:c1ff:fe0f:3e57])
        by smtp.gmail.com with ESMTPSA id j19-20020aa78013000000b00525203c2847sm107892pfi.128.2022.06.23.14.36.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 14:36:34 -0700 (PDT)
Message-ID: <b8011afe-fb24-3349-30eb-182a8792c67a@saikrishna-Lemur>
Date:   Thu, 23 Jun 2022 14:36:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Saikrishna Arcot <saiarcot895@gmail.com>
Subject: Memory not shared for files opened from different subvolumes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I was looking at the page map allocations for some process (mainly to 
see why a certain application was taking so much memory), and noticed 
that for some files that were mapped into memory (such as shared 
libraries), the share count for those memory pages weren't as high as I 
expected it to be, or they were not shared at all. For example, I have 
Docker running with the btrfs storage driver instead of the default 
overlay2 storage driver. With multiple instances of a container running 
at the same time with the same processes, the libraries that they had 
open were using their own physical memory pages, instead of sharing the 
physical memory pages (since it's the same file anyways).

As a smaller example, I have two subvolume snapshots of my root 
partition, and if I mount both of them and mmap a file from both of them 
that is the same in both of the subvolume snapshots, then the physical 
memory pages will be different. IIRC, with Docker using the overlay2 
storage driver, the physical memory pages were indeed being shared for 
the same file being mapped into memory.

Here's a small test case showing two subvolume snapshots being mounted, 
a small file that is the same in both snapshots being picked, and the 
physical pages used for the files being different (page mapping table 
was read from /proc/self/pagemap).

$ sha1sum mount/subvol{1,2}/lib/x86_64-linux-gnu/libdl.so.2
e483a364675ffaee4ebace1e116aca0db322a7d5 
mount/subvol1/lib/x86_64-linux-gnu/libdl.so.2
e483a364675ffaee4ebace1e116aca0db322a7d5 
mount/subvol2/lib/x86_64-linux-gnu/libdl.so.2
$ stat mount/subvol{1,2}/lib/x86_64-linux-gnu/libdl.so.2
   File: mount/subvol1/lib/x86_64-linux-gnu/libdl.so.2
   Size: 14432           Blocks: 32         IO Block: 4096   regular file
Device: 77h/119d        Inode: 77161762    Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-05-21 11:55:04.530135877 -0700
Modify: 2022-03-03 18:54:17.000000000 -0800
Change: 2022-05-21 11:55:04.494136093 -0700
  Birth: 2022-05-21 11:55:04.418136551 -0700
   File: mount/subvol2/lib/x86_64-linux-gnu/libdl.so.2
   Size: 14432           Blocks: 32         IO Block: 4096   regular file
Device: 78h/120d        Inode: 77161762    Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-05-21 11:55:04.530135877 -0700
Modify: 2022-03-03 18:54:17.000000000 -0800
Change: 2022-05-21 11:55:04.494136093 -0700
  Birth: 2022-05-21 11:55:04.418136551 -0700
$ sudo ./a.out mount/subvol{1,2}/lib/x86_64-linux-gnu/libdl.so.2
File 1:
0x00007fdeb50cb000: 0xa1000000006eda02
0x00007fdeb50cc000: 0xa100000000795de1
0x00007fdeb50cd000: 0xa10000000013867b
0x00007fdeb50ce000: 0xa1000000004e4a58

File 2:
0x00007fdeb50c7000: 0xa10000000036ad44
0x00007fdeb50c8000: 0xa1000000003b08e0
0x00007fdeb50c9000: 0xa100000000143c7e
0x00007fdeb50ca000: 0xa1000000001c3d45

This was on the 5.17.5 kernel, but I've observed this on 5.13 as well.

My question is, is it possible to share the physical pages for the same 
file from two different mount points being opened? This would reduce the 
physical memory used in larger cases.

-- 
Saikrishna Arcot
