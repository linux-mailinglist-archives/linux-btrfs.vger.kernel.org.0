Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6089E11E87E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfLMQjB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 11:39:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34675 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfLMQjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 11:39:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id d202so100966qkb.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 08:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ovf2/AW/iO7NUyaVB6lPFEO6arUdBg/KB8kt2aGi42o=;
        b=YviHxWUzGPf5SYTTnOo5VAQSiB8G38VGO7O3iRAlU9rN7CbbDcczV3hW58OG/Tlyua
         jgbzR11eJz+63EoGGanVsAlagba/2hRgR0gqXtm8wu0jcW3LSfHY9QC8hGhpFlJV+uah
         2ATrZbHgHwWNifDR1PSvQxXz/5ulVp116E2fFsMvDPAUGb6dByZD/blvsi/fmVyPox3L
         k2dlcwchQmpURo4y69SQfWsYurT0lDHXlMAQfRN9bbfIIZirpr5OR8ZEFICYsRiUE7nB
         /RqI2eRvxlFUY/BJWE/hgXKsITdrk45H0JsX/SK4VCxgZvbk9UMV0xtq7/zrJvgZwxPx
         7B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ovf2/AW/iO7NUyaVB6lPFEO6arUdBg/KB8kt2aGi42o=;
        b=FUVNIsiu8pb6IadFWAPEH46mGYtZzRDNV2RHFiWTgJzlANilOuzc83Q0UuKYTpuYhS
         GCYmlAifpDi4LYnxFjDO7/JM0scr1oC5d+RRgQlG5yvbs6Yr5VTFL9jSC10s3mPs3NCZ
         HfMXn3J02ZO+QdGjIE+V2T8Cteu67RTAhP+yXoBOLPvE5v6FYP00v9hING6XbcQ0jWBu
         zCB5zXe+5EjF7S10DgE+ZGokDmahdsE59mSp+tHAflZPOievYIHcYtjtSwcMH9vA8IAw
         kR8I3ewGVHRviWU7zpgEFiXCpvqAdO3D8v0hXG2JHr9AOZM2bI5YSOupC8ufJECa3IL3
         82IQ==
X-Gm-Message-State: APjAAAWvSeY2ubD/O+A6qJtZANv08ZFKKClN9BZSA12czb+4GYFZIBON
        NO7LW+1vOxZU/2jVgHlPozudPQ==
X-Google-Smtp-Source: APXvYqy3ekLJx1gY0jKZptuwAqmQTzSiMllIqo5i/eTDWckSI6Vc8YWP1TDnwrY6cS4SHV8eKrLdBA==
X-Received: by 2002:a37:6685:: with SMTP id a127mr14941462qkc.167.1576255139792;
        Fri, 13 Dec 2019 08:38:59 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4e65])
        by smtp.gmail.com with ESMTPSA id g81sm2989046qkb.70.2019.12.13.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 08:38:59 -0800 (PST)
Subject: Re: [PATCH v6 08/28] btrfs: implement log-structured superblock for
 HMZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-9-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e5bdec6e-a38e-7789-922f-5998b4401d02@toxicpanda.com>
Date:   Fri, 13 Dec 2019 11:38:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-9-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/12/19 11:08 PM, Naohiro Aota wrote:
> Superblock (and its copies) is the only data structure in btrfs which has a
> fixed location on a device. Since we cannot overwrite in a sequential write
> required zone, we cannot place superblock in the zone. One easy solution is
> limiting superblock and copies to be placed only in conventional zones.
> However, this method has two downsides: one is reduced number of superblock
> copies. The location of the second copy of superblock is 256GB, which is in
> a sequential write required zone on typical devices in the market today.
> So, the number of superblock and copies is limited to be two.  Second
> downside is that we cannot support devices which have no conventional zones
> at all.
> 
> To solve these two problems, we employ superblock log writing. It uses two
> zones as a circular buffer to write updated superblocks. Once the first
> zone is filled up, start writing into the second buffer and reset the first
> one. We can determine the postion of the latest superblock by reading write
> pointer information from a device.
> 
> The following zones are reserved as the circular buffer on HMZONED btrfs.
> 
> - The primary superblock: zones 0 and 1
> - The first copy: zones 16 and 17
> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>    to it
> 

So the series of events for writing is

-> get wp
-> write super block
-> advance wp
   -> if wp == end of the zone, reset the wp

now assume we crash here.  We'll go to mount the fs and the zone will look like 
it's empty because we reset the wp, and we'll be unable to mount the fs.  Am I 
missing something here?  Thanks,

Josef
