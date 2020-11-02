Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7952A3385
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Nov 2020 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBTBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 14:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgKBTBy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Nov 2020 14:01:54 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F05C0617A6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Nov 2020 11:01:54 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id d1so6013971qvl.6
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Nov 2020 11:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1shGAMUSuKMtPKVl8/1J3Ou9x5keNRlS/b6bv8tJ0OE=;
        b=mTBIVlNZncAUuD4RFIhlsEwBuJc3fjLukeJ5WOSLejyYJS7h3MTaFaGbRa6L8ZKmj0
         JF4ygg+UFOMPVsICnxHXj0HiGBCGh+tIunDDoHqR1OR1kz9ks4HkvwGtBKv30cPkEs66
         2he/zldCn/Nof9c0+4sd/agFj+EOmm17s69RMOtIQURI36OUCYxAGYcjLncb1AngtYI2
         hb+dDkD0pZCb8+/3Jg5BHiJPEdhzu0Xp8hYUpCBIqjteFl56hu5aU6yznSaF2xIM26L9
         TOeSPDaZaxpsypbuwYzEjqar2yZgw1ZtPhcR3mYRSCS3YWAW6YSqMttYKaR96H69Ylja
         BUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1shGAMUSuKMtPKVl8/1J3Ou9x5keNRlS/b6bv8tJ0OE=;
        b=a/9EUI1t7yJQc0oAcRtD4oxkEfUYugkz4w4FPFBYj4Pn5Bi4iSMjU2C/fdp0K6XJPs
         i47QGULdJK/1CsUgyZ57NqO5Fn280O1GBLjtY6CdKXi0A3Lac3OE4QGI2rUdl6/gOKXz
         KqhoGgEL43myR/cdfq1tCGUCSGlYClDS3ZbdeVl+vlSPgmUzu+VgzJulllNV4++1Iu9c
         kQZe+Z3IUjo1D74PuZDO80zoYghLqBNJYfJXffRt6YBmpYfBqFoFljku/h5aqgK1TNEE
         5EhMqnx1wSlPxUtz8tkDTd3RCUvH7Woc4+0Ss0wVN0ZwWuXykV+Q/qf3OVGGwFsQh8op
         A5rQ==
X-Gm-Message-State: AOAM531ex8QMXVNO04fsgj3YR2axNTXTuwNtTEp8QGmFfQBtyG8fTBio
        0DMD4KdgIDwjDm1/rxh9bmPf8A==
X-Google-Smtp-Source: ABdhPJyOAYe+HXJLpQx6UiB2/lBe/3TycB+vGrbn9zEJgTYuhyVzkjN54IqzlJdjf7Vpa8VZ/A+/PQ==
X-Received: by 2002:a0c:bb83:: with SMTP id i3mr24128292qvg.15.1604343713709;
        Mon, 02 Nov 2020 11:01:53 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f1sm1782394qtf.68.2020.11.02.11.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 11:01:53 -0800 (PST)
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
 <0485861e-40d4-a736-fc26-fc6fdb435baa@toxicpanda.com>
 <SN4PR0401MB3598937F8C4499BE687667A89B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <65e72221-a9a5-f1cb-3fa5-5ffd98e45b2b@toxicpanda.com>
Date:   Mon, 2 Nov 2020 14:01:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598937F8C4499BE687667A89B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/2/20 1:53 PM, Johannes Thumshirn wrote:
> On 02/11/2020 19:23, Josef Bacik wrote:
>>> +		/* shouldn't have super stripes in sequential zones */
>>> +		if (zoned && nr) {
>>> +			btrfs_err(fs_info,
>>> +				  "Zoned btrfs's block group %llu should not have super blocks",
>>> +				  cache->start);
>>> +			return -EUCLEAN;
>>> +		}
>>> +
>> I'm very confused about this check, namely how you've been able to test without
>> it blowing up, which makes me feel like I'm missing something.
>>
>> We _always_ call exclude_super_stripes(), and we're simply looking up the bytenr
>> for that block, which appears to not do anything special for zoned.  This should
>> be looking up and failing whenever it looks for super stripes far enough out.
>> How are you not failing here everytime you mount the fs?  Thanks,
> 
> Naohiro (or Josef and everyone else as well of cause), please correct me if I'm
> wrong, but on zoned btrfs we're not supporting any RAID type. So the call to
> btrfs_rmap_block() above will return 'nr = 0' (as we're always having
> map->num_stripes = 1) so this won't evaluate to true.
> 

No it should return nr == 1 in the single case.  This maps physical address to a 
logical address in the block group, so it could be multiple, but if that bytenr 
falls inside the block group it'll return with something set.  Hence my 
confusion.  Thanks,

Josef
