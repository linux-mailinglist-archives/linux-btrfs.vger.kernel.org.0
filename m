Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985745FD68
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Nov 2021 09:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352799AbhK0I3A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 Nov 2021 03:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350920AbhK0I1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 Nov 2021 03:27:00 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1BBC061574;
        Sat, 27 Nov 2021 00:23:46 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z6so8151307plk.6;
        Sat, 27 Nov 2021 00:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bGmERxn2R3A5l8QWIWXKFaZBkGHf4Fm99d8NueBFwP8=;
        b=fhlYHQoDAyvxDXOMpbTILhF0A3hpfqqX+gxAIzyDBuNEJCZuZEeSjInt7ix7thQJQU
         /fPjjdhij7vmD6zEjUNgbstbrqmxn+4aW7ZXb9bh1X/3eDGS/+IRwXzr4pxsMhU7Qmyx
         d0gpiYpbKPjsr8cU0ENnpka/v1dp5IfKpGb2huJNRJQp/eezY8n8dcWl7Mqc1d7hDEQr
         9wLSNwB0T7TLqyBxKbSl+ntakZ7CIfQM0LyoEzukXDuzgnX8taaxOzPFvT+FCLHnMTcK
         g4YOUkzW2+Cpr788Gwzp534on8T2daUXANbrZi71SnMC/Z1vDXRX+3Gi4xZ0/oKoVthc
         m6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bGmERxn2R3A5l8QWIWXKFaZBkGHf4Fm99d8NueBFwP8=;
        b=kKcbpRMOHhDVT67xeM0O/Vh7QDOYjtNgeYWR4Bs1B8/19Wrsk1UxNFX6cy2HAVne5Q
         K7Zf97ArJYhvgAxBdWWPP/xZ9sdu2PiJTjduukxU5DqNj7Gj5dGplXP6hZ1rJl7PvZmW
         eYKs1fiZ8dFFfREbceQ3a/UpHvTLebharDoDQtsAnFN3RAuDtgNYf8L4aUfEK/4Wdgna
         2v/Jyx8PSs4QP4H5MSEODsPxiiZ/ORCC/srchojkX/fk0e8NiNhEiSNjeMlQ+N2cAFJ7
         UJw2NT3TQf3TOhHh5lcqZ8QUiz1REtBkIPiO0NpvJ/Kdr1Tbix2iog6o3HFmnPINP0ym
         QOrA==
X-Gm-Message-State: AOAM531M8zBma2Cn2zUVxRjfv+hY63QnzPSbvXwapiMDtqUlIo3de8HO
        EAeT3ZJgd73FRvzunfupN9Fa0rAQfMw=
X-Google-Smtp-Source: ABdhPJwueZVRAAStbtRvEj+gnjdqSzpCqW5l8e2lu4tUXiLXW9rodL29xA5pU1/e+iUJa/20UICBuA==
X-Received: by 2002:a17:90a:e613:: with SMTP id j19mr22101589pjy.182.1638001425310;
        Sat, 27 Nov 2021 00:23:45 -0800 (PST)
Received: from [166.111.139.123] ([166.111.139.123])
        by smtp.gmail.com with ESMTPSA id t3sm10845260pfg.94.2021.11.27.00.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 00:23:44 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: btrfs: several possible ABBA deadlocks
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <44b385ca-f00d-0b47-e370-bd7d97cb1be3@gmail.com>
Date:   Sat, 27 Nov 2021 16:23:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

My static analysis tool reports several possible ABBA deadlocks in the 
btrfs module in Linux 5.10:

# DEADLOCK 1:
__clear_extent_bit()
   spin_lock(&tree->lock); --> Line 733 (Lock A)
   split_state()
     btrfs_split_delalloc_extent()
       spin_lock(&BTRFS_I(inode)->lock); --> Line 1870 (Lock B)

btrfs_inode_safe_disk_i_size_write()
   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
   find_contiguous_extent_bit()
     spin_lock(&tree->lock); --> Line 1620 (Lock A)

When __clear_extent_bit() and btrfs_inode_safe_disk_i_size_write() are 
concurrently executed, the deadlock can occur.

# DEADLOCK 2:
__set_extent_bit()
   spin_lock(&tree->lock); --> Line 995 (Lock A)
   set_state_bits()
     btrfs_set_delalloc_extent()
       spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 
(Lock B)

btrfs_inode_safe_disk_i_size_write()
   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
   find_contiguous_extent_bit()
     spin_lock(&tree->lock); --> Line 1620 (Lock A)

When __set_extent_bit() and btrfs_inode_safe_disk_i_size_write() are 
concurrently executed, the deadlock can occur.

# DEADLOCK 3:
convert_extent_bit()
   spin_lock(&tree->lock); --> Line 1241 (Lock A)
   set_state_bits()
     btrfs_set_delalloc_extent()
       spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 
(Lock B)

btrfs_inode_safe_disk_i_size_write()
   spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
   find_contiguous_extent_bit()
     spin_lock(&tree->lock); --> Line 1620 (Lock A)

When convert_extent_bit() and btrfs_inode_safe_disk_i_size_write() are 
concurrently executed, the deadlock can occur.

I am not quite sure whether these possible deadlocks are real and how to 
fix them if they are real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
