Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DE15FFA09
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Oct 2022 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJOMez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Oct 2022 08:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJOMew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Oct 2022 08:34:52 -0400
Received: from out20-145.mail.aliyun.com (out20-145.mail.aliyun.com [115.124.20.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E52E9DC
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Oct 2022 05:34:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0748137|-1;BR=01201311R111S57rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0062712-0.000166358-0.993562;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Pd86w4h_1665837286;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Pd86w4h_1665837286)
          by smtp.aliyun-inc.com;
          Sat, 15 Oct 2022 20:34:46 +0800
Date:   Sat, 15 Oct 2022 20:35:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: question about the performance of 'btrfs send'
Message-Id: <20221015203501.E1ED.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

a question about the performance of 'btrfs send'.

The output speed of 'btrfs send' is about 700MiB/s in the 3 cases.
1) kernel 5.15.73 + 'btrfs send --proto 1'
2) kernel: 6.0.1(with btrfs-devel misc-6.1) +  'btrfs send --proto 1'
3) kernel: 6.0.1(with btrfs-devel misc-6.1) +  'btrfs send --proto 2'
btrfs-progs: 6.0

the outut of 'perf report':
Overhead  Command  Shared Object      Symbol
*1  40.63%  btrfs    [kernel.kallsyms]  [k] __crc32c_le
*2   9.97%  btrfs    [kernel.kallsyms]  [k] memcpy_erms
*3   9.25%  btrfs    [kernel.kallsyms]  [k] send_extent_data
*4   5.40%  btrfs    [kernel.kallsyms]  [k] asm_exc_nmi
*5   2.73%  btrfs    [kernel.kallsyms]  [k] __alloc_pages
   1.14%  btrfs    [kernel.kallsyms]  [k] __rmqueue_pcplist
   0.92%  btrfs    [kernel.kallsyms]  [k] bad_range
   0.88%  btrfs    [kernel.kallsyms]  [k] get_page_from_freelist

What I expected:
the above *1) __crc32c_le take >60%, and the outut speed > 1GiB/s.
The *1) __crc32c_le is necessary operation, and the speed
seems OK.  2GB/s * 40% = 800MiB/s, it is close to 700MiB/s.

Question:
The above *3) is difficult to understand. Any advice?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/10/15


