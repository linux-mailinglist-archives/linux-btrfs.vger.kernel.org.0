Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1730273253
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgIUTBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 15:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgIUTBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 15:01:08 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB1C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 12:01:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so16329238qkf.4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Sep 2020 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bDuv3B41gzO3aAv6vsdlpegJ1NcWg0gGdBJRIjuMpTI=;
        b=vvGqYx5xT1dcd/8ltglM0AJAmRN0B6Pmy41AbSFFtG4ydVpv2klYffqKI3UUZlqmcC
         E2shgdLpDmF8Gy15efKxkTDzXVzh0MQXE+KngwvGKkPLWJbL+tJJriMojN+IFxLPlXeH
         +U1t1f7hdZ6tNAzALYWgrMkf5y2xmYFTaidsr6Jumv6anN2ZtCf6y41INRHwYAIFjvbM
         mIVOdYW+KwrdI+YfIYRV96UrHKNEGtq2J4/NHFK32ML07wUDO0H/4nfTvJVndhnWFs6R
         hI95qeewm1h5MzdkP2R0YXfRzNByZgVQ/iETneGK+CcD+dFxyDfxc38JwH223/KstvuQ
         c2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bDuv3B41gzO3aAv6vsdlpegJ1NcWg0gGdBJRIjuMpTI=;
        b=bp0mE+6dqhAzaHRmPxaZym+05mJVn3GCJ4rzMCOW0+UhDs3t/Is9rh9Ua7j2aLm0Af
         BW4YUZ6v9i/jfLitJsQJL8TEzyVMm2tjBsjpA1exEwN3LySgdbWgwEAATRaFr3L0TIWk
         HMPVhz2Jh/JBDXxux7vhiepSgFSrEOhWPHY4CpsqKCSNvUZ0TSFNaZt8JbWNW25PSzz0
         N0Zismh8ZozpG/YVf+XOhTd4F4oZZNHccrrF/EU6pfpmAV8/zleE5ayYqGgz/5QTgy/N
         cABhWzzJjCipWP6Fq+ZYbWsBcuneLU+53TnYB2F6e7PgoGUM10/oslFokIiyoNwjLrTa
         mIPQ==
X-Gm-Message-State: AOAM532yH9MPEgsehkoSMLEip+zLnGTAIaDy+NjHKqlIS8IwMbHRny2q
        55z2Ry/JvttfOvC5WwirdyBmBbALbeKh8AxY
X-Google-Smtp-Source: ABdhPJyFbvwToc9F4C2ru3bao+0QpN2GwtDUOGVV9svOBltZOa7v1wfwleK7caH+zKoI2l2j+PqvFQ==
X-Received: by 2002:a37:952:: with SMTP id 79mr1208311qkj.57.1600714867759;
        Mon, 21 Sep 2020 12:01:07 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j197sm9542156qke.131.2020.09.21.12.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 12:01:07 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] btrfs: remove free space items when creating free
 space tree
To:     dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1600282812.git.boris@bur.io>
 <e8c4e0e500f1f19787c84cf8fb7a54063f0fedf0.1600282812.git.boris@bur.io>
 <20200921171304.GM6756@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <47c03527-573f-3f43-f6b7-c015dcb71c97@toxicpanda.com>
Date:   Mon, 21 Sep 2020 15:01:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200921171304.GM6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 1:13 PM, David Sterba wrote:
> On Thu, Sep 17, 2020 at 11:13:40AM -0700, Boris Burkov wrote:
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3333,6 +3333,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   			close_ctree(fs_info);
>>   			return ret;
>>   		}
>> +		/*
>> +		 * Creating the free space tree creates inode orphan items and
>> +		 * delayed iputs when it deletes the free space inodes. Later in
>> +		 * open_ctree, we run btrfs_orphan_cleanup which tries to clean
>> +		 * up the orphan items. However, the outstanding references on
>> +		 * the inodes from the delayed iputs causes the cleanup to fail.
>> +		 * To fix it, force going through the delayed iputs here.
>> +		 */
>> +		btrfs_run_delayed_iputs(fs_info);
> 
> This is called from open_ctree, so this is mount context and the free
> space tree creation is called before that. That will schedule all free
> space inodes for deletion and waits here. This takes time proportional
> to the filesystem size.
> 
> We've had reports that this takes a lot of time already, so I wonder if
> the delayed iputs can be avoided here.
> 

Chris and I told him to do it this way.  If you have a giant FS the time is 
mostly going to be spent doing the free space tree, the iputs won't add much 
more time to that.  We have to do this so the orphan cleanup that follows 
doesn't screw up because we haven't put our inodes yet.  This is one time pain 
and avoids us having to figure out what to do about orphans we generate while 
mounting the file system.  Thanks,

Josef
