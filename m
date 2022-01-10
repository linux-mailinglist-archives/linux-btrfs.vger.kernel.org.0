Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3920A48A0C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 21:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbiAJUNZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 15:13:25 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:56330 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239485AbiAJUNZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 15:13:25 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-36.iol.local with ESMTPA
        id 712gnubRpeQ4z712gngvZK; Mon, 10 Jan 2022 21:13:23 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1641845603; bh=PyLPWkNvG5mtU+PBl+ZPF2NIs/3y9G5aYaTFKsatDpA=;
        h=From;
        b=qJOsDI7r1X4JDZzv9KIzW55x8FOFAjQZ2q1P/0bY80JmNpq54g+e6NcDSuV/7rSXq
         xcm4O5QeRTMleGWe1vwZy4BqNeqJKXqS4l3X3/XOL0HZhePeZ/uui9PjQVun3AL589
         1vKsN0wiMgAUdCYM2jZccS94RlfMXdPmk8l+xIS0zzFHCOW5keyYVNUiqamcNq9X5k
         /lz08pXlj1Onj7TyCllI9ubk4GDBNCNx3B7ZcJORTvHmMDcxPOGgtPVr/9Nw9zzoqI
         DGvGDHxFws3NjHIuWspuEtYOoEtOk7bv1R48B1kiUZ9v4QYtSeNVuvS0u7KJRuHrRg
         kC7MpC3kpNhbQ==
X-CNFS-Analysis: v=2.4 cv=WK+64lgR c=1 sm=1 tr=0 ts=61dc9363 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=yPCof4ZbAAAA:8 a=HQ1Gqp9KBWHWwr6B4roA:9 a=QEXdDO2ut3YA:10
Message-ID: <03c7c3d2-5abe-0087-90d9-698c77a98fc4@libero.it>
Date:   Mon, 10 Jan 2022 21:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v4 3/4] btrfs: add device major-minor info in the struct
 btrfs_device
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
References: <cover.1641794058.git.anand.jain@oracle.com>
 <9dca55580c33938776b9024cc116f9f6913a65cf.1641794058.git.anand.jain@oracle.com>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <9dca55580c33938776b9024cc116f9f6913a65cf.1641794058.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHmfFQpHAggXAFsCRTOPj7GO4X2+qjSYZm5DE1C8mTPRXRgqa+jFwX4fBd5IFXU2YrleRXO7HgQLB8+KJJsIWx8g7nTVzTc9xk10g9gDBzKMVVwC+HkF
 8Af0k+Q38XaH6ds0CWcf2LE0KNTcKNfYGRcK8LFOLeMknrokGPKVHRT8FwFp938N3OsvEeGcXRCgM7J3DhdulHklA4I/cSzek2BrQQxlbWMC6I0AhEUgZH9J
 qh8wFI1jt7+0hEDezUvj0q7ovqhQlKe5HcQTwaXdpVlF+8M7Jh5wP29Nm0WKNOBppDEMnvd13OVd2p/5Zc4ysZUjXFJGeGjcFC6zrJtaiAQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/01/2022 14.23, Anand Jain wrote:
> Internally it is common to use the major-minor number to identify a device
> and, at a few locations in btrfs, we use the major-minor number to match
> the device.
> 
> So when we identify a new btrfs device through device add or device
> replace or device-scan/ready save the device's major-minor (dev_t) in the
> struct btrfs_device so that we don't have to call lookup_bdev() again.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

[...]

> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 76215de8ce34..ebfe5dc73e26 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -73,6 +73,8 @@ struct btrfs_device {
>   	/* the mode sent to blkdev_get */
>   	fmode_t mode;
>   
> +	/* Device's major-minor number */
> +	dev_t devt;

What is the relation between

	device->devt

and

	device->bdev->bd_dev

?

I assumed that there are situation where there is no a device connected to a btrfs_device
structure (e.g. a degraded mounted filesystem where a device is missing); in this case
does devt == 0 ?

But are there cases where devt != 0 (a device is associated to a block device structure) and bdev == NULL ?




>   	unsigned long dev_state;
>   	blk_status_t last_flush_error;
>   


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
