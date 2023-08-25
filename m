Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B7F787FD9
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbjHYG1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 02:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbjHYG13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 02:27:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8B1FE9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 23:27:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-54290603887so317598a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 23:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692944845; x=1693549645;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0vrZyDdWpYh2W23nEjiaAUmw+Vbo3E7M6tYqRxLV4A=;
        b=W9TEQ9EL+QECqFh3kHeGWQWtAQn0EA4XN/8bKFfQVH2dsYzv3p16RM1Al5S9WiYB7K
         feM1hNZ7i7tX3D+7sevL1f7vV6rtMiZTVaEZZRLauq0wlt6/nfxAKnn/MHy1GfUgo+Y6
         Hd0F59cuhULot8++eMob20lXboiRa+VXcuMEUMTCH2L1eYNJ1h1GFab6yFAao0bQvjx8
         EUSwZSd5lcbGMVsgErt0/EUX5B7AqqXlngHHrAeYDXHF42+MgfYTGrppA1YyG2ju6P/j
         lKT0nhpJyV/d0s/9Vsy73gBHTNd5x6aHDU3OSjqoJ2o8orOqTtv3L5GM9GF3z71KDPfE
         RA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692944845; x=1693549645;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e0vrZyDdWpYh2W23nEjiaAUmw+Vbo3E7M6tYqRxLV4A=;
        b=bb8Djf3zg7uZThz6IjBnAGpualINM32+DP4W8gR9p0DR3NHz/aZY3IiNWCfNeLopbM
         HgLNWh5s8MxCtaeADgQ8Bpgu1p5NvfqLdbeg+eLk3TYeso2ploYdzFp5miODvneqeJiP
         Vqd5yzxw+I0mCHOOpvLZFeoR7Xxnf0bHnguKlgc7SR0Z31UkI974Yrj7OxicRmfQMxqz
         z1wmj8Qz9SdwhQmRvJYOjmpePhwHDuvLPDnB5kbGII5qtSOZprEffghTKTiHjy+y8GRK
         w3TycHglpZLpaflqFD8aJJSlf+g2QEJFQKurahLhqQE05WypABPEe0iLWQKJMuHjiOWX
         oM7g==
X-Gm-Message-State: AOJu0Yy54a183FW9zm6W+j9wlT0C2YCLbkUMdEqc2n2yTW6zlpz2xEjO
        Fif7W/77NjvoKX47H64YdILCWEOe9G6wHQ==
X-Google-Smtp-Source: AGHT+IFFysvV24bkiCYwpotXMq9nyhb0HbVLNBmau0Ba8TuPE5vWtdkZHN6neio9TbT5yTwVzv5jPQ==
X-Received: by 2002:a05:6a20:cf:b0:13f:a83c:fae1 with SMTP id 15-20020a056a2000cf00b0013fa83cfae1mr14879453pzh.54.1692944845237;
        Thu, 24 Aug 2023 23:27:25 -0700 (PDT)
Received: from ?IPV6:ddf2:f99b:21f4::3? ([199.15.79.70])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902744400b001b03b7f8adfsm784282plt.246.2023.08.24.23.27.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:27:24 -0700 (PDT)
Message-ID: <db36520a-e3c6-4dac-ae5f-1826b8e6d753@gmail.com>
Date:   Fri, 25 Aug 2023 14:27:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   dianlujitao <dianlujitao@gmail.com>
Subject: kernel bug when performing heavy IO operations
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Dear developers,


When the IO load is heavy (compiling AOSP in my case), there's a chance 
to crash the kernel, the only way to recover is to perform a hard reset. 
Logs look like follows:

8月 25 13:52:23 arch-pc kernel: BUG: Bad page map in process tmux: 
client  pte:8000000462500025 pmd:b99c98067
8月 25 13:52:23 arch-pc kernel: page:00000000460fa108 refcount:4 
mapcount:-256 mapping:00000000612a1864 index:0x16 pfn:0x462500
8月 25 13:52:23 arch-pc kernel: memcg:ffff8a1056ed0000
8月 25 13:52:23 arch-pc kernel: aops:btrfs_aops [btrfs] ino:9c4635 dentry 
name:"locale-archive"
8月 25 13:52:23 arch-pc kernel: flags: 
0x2ffff5800002056(referenced|uptodate|lru|workingset|private|node=0|zone=2|lastcpupid=0xffff)
8月 25 13:52:23 arch-pc kernel: page_type: 0xfffffeff(offline)
8月 25 13:52:23 arch-pc kernel: raw: 02ffff5800002056 ffffe6e210c05248 
ffffe6e20e714dc8 ffff8a10472a8c70
8月 25 13:52:23 arch-pc kernel: raw: 0000000000000016 0000000000000001 
00000003fffffeff ffff8a1056ed0000
8月 25 13:52:23 arch-pc kernel: page dumped because: bad pte
8月 25 13:52:23 arch-pc kernel: addr:00007f5fc9816000 vm_flags:08000071 
anon_vma:0000000000000000 mapping:ffff8a10472a8c70 index:16
8月 25 13:52:23 arch-pc kernel: file:locale-archive fault:filemap_fault 
mmap:btrfs_file_mmap [btrfs] read_folio:btrfs_read_folio [btrfs]
8月 25 13:52:23 arch-pc kernel: CPU: 40 PID: 2033787 Comm: tmux: client 
Tainted: G           OE      6.4.11-zen2-1-zen #1 
a571467d6effd6120b1e64d2f88f90c58106da17
8月 25 13:52:23 arch-pc kernel: Hardware name: JGINYUE X99-8D3/2.5G 
Server/X99-8D3/2.5G Server, BIOS 5.11 06/30/2022
8月 25 13:52:23 arch-pc kernel: Call Trace:
8月 25 13:52:23 arch-pc kernel:  <TASK>
8月 25 13:52:23 arch-pc kernel:  dump_stack_lvl+0x47/0x60
8月 25 13:52:23 arch-pc kernel:  print_bad_pte+0x194/0x250
8月 25 13:52:23 arch-pc kernel:  ? page_remove_rmap+0x8d/0x260
8月 25 13:52:23 arch-pc kernel:  unmap_page_range+0xbb1/0x20f0
8月 25 13:52:23 arch-pc kernel:  unmap_vmas+0x142/0x220
8月 25 13:52:23 arch-pc kernel:  exit_mmap+0xe4/0x350
8月 25 13:52:23 arch-pc kernel:  mmput+0x5f/0x140
8月 25 13:52:23 arch-pc kernel:  do_exit+0x31f/0xbc0
8月 25 13:52:23 arch-pc kernel:  do_group_exit+0x31/0x80
8月 25 13:52:23 arch-pc kernel:  __x64_sys_exit_group+0x18/0x20
8月 25 13:52:23 arch-pc kernel:  do_syscall_64+0x60/0x90
8月 25 13:52:23 arch-pc kernel: entry_SYSCALL_64_after_hwframe+0x77/0xe1
8月 25 13:52:23 arch-pc kernel: RIP: 0033:0x7f5fca0da14d
8月 25 13:52:23 arch-pc kernel: Code: Unable to access opcode bytes at 
0x7f5fca0da123.
8月 25 13:52:23 arch-pc kernel: RSP: 002b:00007fff54a44358 EFLAGS: 
00000206 ORIG_RAX: 00000000000000e7
8月 25 13:52:23 arch-pc kernel: RAX: ffffffffffffffda RBX: 
00007f5fca23ffa8 RCX: 00007f5fca0da14d
8月 25 13:52:23 arch-pc kernel: RDX: 00000000000000e7 RSI: 
fffffffffffffeb8 RDI: 0000000000000000
8月 25 13:52:23 arch-pc kernel: RBP: 0000000000000002 R08: 
00007fff54a442f8 R09: 00007fff54a4421f
8月 25 13:52:23 arch-pc kernel: R10: 00007fff54a44130 R11: 
0000000000000206 R12: 0000000000000000
8月 25 13:52:23 arch-pc kernel: R13: 0000000000000000 R14: 
00007f5fca23e680 R15: 00007f5fca23ffc0
8月 25 13:52:23 arch-pc kernel:  </TASK>
8月 25 13:52:23 arch-pc kernel: Disabling lock debugging due to kernel taint

Full log is available at https://fars.ee/HJw3
Notice that the issue is introduced by linux kernel released in recent 
months.


I also reported the issue at 
https://bugzilla.kernel.org/show_bug.cgi?id=217823

