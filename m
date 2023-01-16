Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89466BB9C
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jan 2023 11:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjAPKWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Jan 2023 05:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAPKW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Jan 2023 05:22:28 -0500
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843FD1ABC4
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 02:22:25 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 20E365C1CB2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jan 2023 11:22:24 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Correct way to clear a free space cache file invalid error
Date:   Mon, 16 Jan 2023 11:22:23 +0100
Message-ID: <2269684.ElGaqSPkdT@lichtvoll.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sorry for incomplete subject, reposting.

Hi!

Kernel 6.1, btrfs-progs 6.1.2. Filesystem on NVME SSD, via LVM and dm-
crypt.

I would like

[   18.657903] BTRFS info (device dm-1): the free space cache file 
(23912775680) is invalid, skip it
[   18.697033] BTRFS info (device dm-1): the free space cache file 
(25254952960) is invalid, skip it

to be gone.

So I tried

mount -o remount,clear_cache,space_cache=v1 /

as well as

mount -o remount,clear_cache /
mount -o remount,space_cache=v1 /

to no avail.

Before that I had space cache v2 on the filesystem as with most of my 
other BTRFS filesystems. But since it really should not be necessary for 
a 50 GiB filesystem for the Linux system (not user data), I thought I 
play it safe this time. At least from what I learned from btrfs manpage.

In a page on BTRFS wiki it is stated that one should run "btrfs check" 
on the filesystem.

So what is the correct way to clear that error?

I did not perceive any malfunctioning due to the error in dmesg. The 
filesystem scrubs without errors.

Best,
-- 
Martin





