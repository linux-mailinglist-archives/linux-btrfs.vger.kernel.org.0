Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB073D34CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 08:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhGWGEr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 02:04:47 -0400
Received: from fun.that.world ([95.217.86.109]:50314 "EHLO fun.that.world"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234131AbhGWGEr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 02:04:47 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 02:04:46 EDT
Received: from [192.168.24.26] (unknown [217.110.165.89])
        (Authenticated sender: sorpaas)
        by fun.that.world (Postfix) with ESMTPSA id 56D75C238081D
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=that.world; s=mail;
        t=1627022392; bh=FTx4624GnRCqml5khUXryui77kAyfM9+dkcZCKVjUYM=;
        h=To:From:Subject:Date;
        b=KKKM1R6bOnltAPTwr3vA6jEhvM0J9qTOjmqnjvID6RRn1nMDHbXJn9M8k1kp/s42W
         EmoNhpGSiGjHK/mN1nhq4GF71E7I6LepbwQLhuCFx2u2abaw50hkvo8OzJtOAH38YS
         hgZZdp7TpjDKOE1Hc9YKUZKVYWTjfz5CjlJ9DQlc=
To:     linux-btrfs@vger.kernel.org
From:   Wei Tang <wei@that.world>
Subject: Balance loop converting from single to raid-1 (kernel 5.13.3)
Message-ID: <f85b8b32-0fec-056c-63ba-1ebb64f2bc09@that.world>
Date:   Fri, 23 Jul 2021 08:39:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Today I was trying to convert a btrfs disk from single to raid-1. It 
gets stuck in this seemingly infinite loop:

Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:48 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:49 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers
Jul 23 08:30:50 loopforward kernel: BTRFS info (device dm-5): found 1 
extents, stage: update data pointers

Canceling the conversion then restarting it, or rebooting, does not seem 
to do anything -- the same "1 extents" loop always reappears.

# uname -a
Linux loopforward 5.13.3 #1-NixOS SMP Mon Jul 19 08:04:55 UTC 2021 
x86_64 GNU/Linux
