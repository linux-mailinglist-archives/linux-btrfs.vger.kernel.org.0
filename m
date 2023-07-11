Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA274E664
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 07:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGKFmW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjGKFmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 01:42:19 -0400
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD8E57
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 22:42:18 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 5DB4173AFC5;
        Tue, 11 Jul 2023 07:33:37 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Date:   Tue, 11 Jul 2023 07:33:36 +0200
Message-ID: <5690570.DvuYhMxLoT@lichtvoll.de>
In-Reply-To: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Tim Cuthbertson - 03.07.23, 22:19:50 CEST:
> Yesterday, I noticed that a scrub of my main system filesystem has
> slowed from about 2.9 gb/sec to about 949 mb/sec. My scrub used to run
> in about 12 seconds, now it is taking 51 seconds. I had just
> installed Linux kernel 6.4.1 on Arch Linux, upgrading from 6.3.9. At
> first I suspected the new kernel, but now I am not so sure.
> 
> I have btrfs-progs v 6.3.2-1. It was last upgraded on June 23.

I can confirm this with similar values.

v6.3 was fine, with scrub speeds from 1.8 to 2.6 GiB/s, v6.4 only has a 
bit less 1 GiB/s.

atop shows 100% utilization of NVME SSD which is odd at less than 1 GiB/
s sequential I/O and a lot of kworker threads doing about 200-300% of 
system time CPU utilization.

This is with ThinkPad T14 AMD Gen 1 with AMD Ryzen 7 PRO 4750U and 32 
GiB RAM on Samsung 980 Pro 2TB NVME SSD connected via PCIe 3. The 
hardware can definitely do more throughput even with "just" PCIe 3.

-- 
Martin


