Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD235E7352
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Sep 2022 07:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIWFQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Sep 2022 01:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIWFQp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Sep 2022 01:16:45 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898D11ADC6
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 22:16:44 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id e3so4489748uax.4
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 22:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=eU/FNJKGZzl+LbxeW1z9CIVf9ZHDishlyxXRIF2J+cQ=;
        b=HhEL70G0RUns3MPzc2PpcAq5hBRplMxW77G8LokJtJFQiJP5rpvY7sJTy36QM/dCdp
         pK7r34tQ3DIzPOhc6VPylUKNUr2cwCSO0bHh/dPhY7VemfnFrTPnfNIO8vcKQ+G2bwTa
         Fz0a0Fdrk5XN5j9de91xB42CBF1T/nmw6C2ux8eJhRoR1C5bB5jISFdG5OTPHZlA1OqH
         RciAYcoIjXOudEsJLHeu8XiJWgh3U9kwCzCja34k6WLvNNnH5bN/1pqpOXNxELJthUBw
         v5A8KV830h8Dw2i34xb1v1gMm0R2iQD+NLn0VbayV3ZbzrYy9JNDYcK466KXBy8BNc6k
         PMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=eU/FNJKGZzl+LbxeW1z9CIVf9ZHDishlyxXRIF2J+cQ=;
        b=Uv1wQIoUcpIwpoFUXasU/4+q0hqn7QY1irHBHvLvXW0y+X1YKxHPkR02FVRpE0fGQt
         W2v5tRPbtHftoVxdNynzHOPggxUEBZNTxZCQq/Mvsig7TX4kxW9blB5HGSEfg8YONr7V
         yy6QowHCbXCb2QR5923chcgnL3nTWgIX8iQTc+t5EtC03D8C+72BZRPGh81CIVgTD9Zt
         JXOzXIOYqr9ZZRxJq5whmTJ4eR0JYatqvrdE/Bgx1LJlLjjRfSLxQZxgDtvd6mP60urb
         xOCqXq8t9HZ2LZBAgreL84RS5FMba6sRTEMb8FNMvbwfVvyF/eFwsMue2o1ex5w6RnZ4
         XUGg==
X-Gm-Message-State: ACrzQf2dBFHfwgKSA9YE35wqNNa344hZ0EME7ctgfTQRASCCMM1DKJJO
        T6qT4ZkTdb13TRm1M11ShykqCi+Mv0TCIBnKnUWMnK69xQe39sr8
X-Google-Smtp-Source: AMsMyM6t/y1jFqDU9cmGMVuZIUQR4yK+goQA8OXkkKTdw6gK9RlOPP9+PkOfxpc5P4deS36aIHL/YFeKTXWFZdfvb5A=
X-Received: by 2002:ab0:6451:0:b0:3b8:7f95:f20e with SMTP id
 j17-20020ab06451000000b003b87f95f20emr2979439uap.31.1663910203807; Thu, 22
 Sep 2022 22:16:43 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Trescott <dtrescott371@gmail.com>
Date:   Thu, 22 Sep 2022 22:16:33 -0700
Message-ID: <CAPXZLEraHWJRj+QQ+RRGhEB4K4+_4tuUo+r80mzbfYRkpnhaPA@mail.gmail.com>
Subject: Recovering suddenly corrupt Btrfs partition?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello all,

I've got a Fedora boot disk that seems to have had its Btrfs root
filesystem corrupted suddenly. I pulled that disk out and put it into
another machine, and I can't get it to mount read only, complaining of
a bad superblock. I ran `btrfs check --readonly` on the drive and it
started spewing errors saying there were errors found in the
filesystem roots.

If anyone could please advise me on how to get the partition into a
usable read-only state, I'd be extremely grateful. Thank you!

Best regards,
Daniel

`uname -a`:
Linux <hostname> 5.19.9-200.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Sep
15 09:49:52 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

`btrfs --version`:
btrfs-progs v5.18

`dmesg` when attempting to mount partition:
[ 8613.285696] BTRFS info (device sda3): disk space caching is enabled
[ 8613.285700] BTRFS info (device sda3): has skinny extents
[ 8613.288986] BTRFS info (device sda3): bdev /dev/sda3 errs: wr 0, rd
0, flush 0, corrupt 4, gen 0
[ 8613.327357] BTRFS info (device sda3): enabling ssd optimizations
[ 8613.327364] BTRFS info (device sda3): start tree-log replay
[ 8613.636194] BTRFS error (device sda3): parent transid verify failed
on 66931867648 wanted 541837 found 541832
[ 8613.636204] BTRFS: error (device sda3) in btrfs_replay_log:2500:
errno=-5 IO failure (Failed to recover log tree)
[ 8613.657624] BTRFS error (device sda3: state E): open_ctree failed
