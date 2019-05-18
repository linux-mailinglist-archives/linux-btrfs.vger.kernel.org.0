Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB8032258D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 May 2019 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfERXdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 May 2019 19:33:05 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:58436 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfERXdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 May 2019 19:33:04 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 May 2019 19:33:04 EDT
Received: from tux.wizards.de (pD9EBF040.dip0.t-ipconnect.de [217.235.240.64])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 3D7784168BE8;
        Sun, 19 May 2019 01:25:37 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id CDFFB753F8B;
        Sun, 19 May 2019 01:25:36 +0200 (CEST)
Subject: Re: 5.1.3: unable to handle kernel NULL pointer dereference in
 btrfs_reloc_pre_snapshot
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs@vger.kernel.org
References: <20190518230330.GK20359@hungrycats.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <44222573-241b-6777-4218-0fe06d6b7b12@applied-asynchrony.com>
Date:   Sun, 19 May 2019 01:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190518230330.GK20359@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/19/19 1:03 AM, Zygo Blaxell wrote:
> There are several new things in 5.1.  First a lockdep warning:
> 
> 	[  146.037574][    C3] hrtimer: interrupt took 2002067 ns
> 	[  365.442210][    C2]
> 	[  365.442616][    C2] ================================
> 	[  365.443477][    C2] WARNING: inconsistent lock state
> 	[  365.444389][    C2] 5.1.3-zb64-253cbcb7e197+ #1 Tainted: G        W
> 	[  365.445491][    C2] --------------------------------
> 	[  365.446670][    C2] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> 	[  365.447961][    C2] swapper/2/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> 	[  365.449941][    C2] 00000000d8a506e5 (&(&wsm.lock)->rlock){+.?.}, at: zstd_reclaim_timer_fn+0x29/0x190
> 	[  365.452043][    C2] {SOFTIRQ-ON-W} state was registered at:
> 	[  365.453394][    C2]   lock_acquire+0xbd/0x1c0
> 	[  365.454180][    C2]   _raw_spin_lock+0x34/0x70
> 	[  365.455021][    C2]   zstd_get_workspace+0x63/0x280
> 	[  365.455889][    C2]   end_compressed_bio_read+0x1cf/0x450
> 	[  365.457373][    C2]   bio_endio+0xce/0x1c0

The fix for that was just posted on Friday:
https://patchwork.kernel.org/patch/10948813/

Maybe apply and try again, you seem to have a lucky streak. :^)

-h
