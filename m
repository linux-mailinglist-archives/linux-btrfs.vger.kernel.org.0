Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC0475989
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 14:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbhLONU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 08:20:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35488 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhLONU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 08:20:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 491B0212C5;
        Wed, 15 Dec 2021 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639574427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDguJLBjyj4RSRToVmB/8s+bOJVPWr4eYb7ga1+ycPQ=;
        b=qIdCmhxgwbiWN1pOTlVJPJH0LSLmoQ/0nDnW5Kfp0kOV8hTvvkghPDeFghabtuybwXWkG4
        0BkxFQ43qRiBKfcLNAaoy02/uMAAXi0nV80Oz+CXIoeEydz9DZw+NuRKs0IPjP2Zx2YiZk
        C9X7L6eV/AK+PjFdVmY+y+J2h41HFoI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E62711330B;
        Wed, 15 Dec 2021 13:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aNyzNZrruWGQSAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 15 Dec 2021 13:20:26 +0000
Subject: Re: [PATCH] btrfs: Fix missing blkdev_put() call in
 btrfs_scan_one_device()
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20211215103843.331630-1-shinichiro.kawasaki@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <49813991-b87d-a7e0-f697-3b677f6b96e5@suse.com>
Date:   Wed, 15 Dec 2021 15:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215103843.331630-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 15.12.21 г. 12:38, Shin'ichiro Kawasaki wrote:
> The function btrfs_scan_one_device() calls blkdev_get_by_path() and
> blkdev_put() to get and release its target block device. However, when
> btrfs_sb_log_location_bdev() fails, blkdev_put() is not called and the
> block device is left without clean up. This triggered failure of fstests
> generic/085. Fix the failure path of btrfs_sb_log_location_bdev() to
> call blkdev_put().
> 
> Fixes: 12659251ca5df ("btrfs: implement log-structured superblock for ZONED mode")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # 5.15+
> ---

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
