Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45DA315E27
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 05:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhBJESr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 23:18:47 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:42282 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhBJESq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 23:18:46 -0500
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 23:18:45 EST
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Db5pn2cNcz2d;
        Wed, 10 Feb 2021 05:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1612930113; bh=ZDhTCXZCzIKGT4AKpym1hMLWxqXenhYjqabI+NNVA8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMcUs6cF8NQyQqbsoLs8XE1qtfzxGU9uBVivpA8PtKpv7xpWTG/rSDWROTz9YWxU5
         CxWE7DeG1VY/Ep4KBzJ8b4nYmuP+u3Bf2+AeemI0OWhWa1crlOdqkPwdUDg6pq9VBI
         edTj0+06Ie1hxaaSWV0XS6M56xOH5NprinFGRECwF08qDakLQeFzHoT4fAS0dWB7/E
         Ek5ZwFd7Cy7u+fuTz69wwqGZ5P/3JQZHNNVbzpqBXd7MMSfne6MSKdHlbOyzDv9FOS
         NmRako666R3IBOoNu7cPDJs0WvluSKxlRK8TX6U3JfU+Uf6YLLf0B5KojybkFJ0Jlw
         iA9OhSGd83jEQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 10 Feb 2021 05:08:05 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Michal Rostecki <mrostecki@suse.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Rostecki <mrostecki@suse.com>
Subject: Re: [PATCH RFC 4/6] btrfs: Check if the filesystem is has mixed type
 of devices
Message-ID: <20210210040805.GB12086@qmqm.qmqm.pl>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-5-mrostecki@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209203041.21493-5-mrostecki@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 09, 2021 at 09:30:38PM +0100, Michal Rostecki wrote:
> From: Michal Rostecki <mrostecki@suse.com>
> 
> Add the btrfs_check_mixed() function which checks if the filesystem has
> the mixed type of devices (non-rotational and rotational). This
> information is going to be used in roundrobin raid1 read policy.a
[...]
> @@ -669,8 +699,12 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	}
>  
>  	q = bdev_get_queue(bdev);
> -	if (!blk_queue_nonrot(q))
> +	rotating = !blk_queue_nonrot(q);
> +	device->rotating = rotating;
> +	if (rotating)
>  		fs_devices->rotating = true;
> +	if (!fs_devices->mixed)
> +		fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);
[...]

Since this is adding to a set, a faster way is:

if (fs_devices->rotating != rotating)
	fs_devices->mixed = true;

The scan might be necessary on device removal, though.

> -	if (!blk_queue_nonrot(q))
> +	rotating = !blk_queue_nonrot(q);
> +	device->rotating = rotating;
> +	if (rotating)
>  		fs_devices->rotating = true;
> +	if (!fs_devices->mixed)
> +		fs_devices->mixed = btrfs_check_mixed(fs_devices, rotating);

Duplication. Maybe pull all this into a function?

Best Regards,
Micha³ Miros³aw
