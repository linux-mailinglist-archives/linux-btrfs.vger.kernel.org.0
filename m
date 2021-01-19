Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB02FC04E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jan 2021 20:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391312AbhASTrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jan 2021 14:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbhASTpi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jan 2021 14:45:38 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4D5C0613CF
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:44:57 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id w79so23072536qkb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jan 2021 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MF61aXFKRKC9xRDUv1G+4nwf79Spnu6UrlSYjHWeS5Y=;
        b=h0amHnJOtCsVzkt8UzRI1KKpK5/ErEkuu71tdiIb4+Op96aAQCUtLlYD6rZFMONFNS
         s6mHvqkIrMcsyjMMCtHkz7vPgaact5GdmTLxv8ym6Yy/YhwaxC06NBXe3mn247atlRD5
         qSyk0FAQYx4XFNdn2Hcn7sZfVn1DZuWU1pYJl5vV9zxZKRfW1SQx78c/ZEBZkj2eXum4
         P75vO3SGWNCyfeyqgSu8MUyLT8qKpN5kk5ANoFB8TO8m07P7mHgiqfd5fEIkoM8cyqgk
         YTLoUJJGD3aqTvtRDHN9zDPKRxZOuUQpWTFMXjUfzyUl5dfHBbHluvb5UP9EmD8IXniT
         UD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MF61aXFKRKC9xRDUv1G+4nwf79Spnu6UrlSYjHWeS5Y=;
        b=X9Ao3Y/SlZC2l4Xp7fcFMMIl5FFOdcqE1s9kjVzAoho7DdFF4aXS8nYmK3WUhF9czQ
         UVHyDfeucsZkKLLMEgRvzfRpHI3upbigjsX9nGoTvu4k5xa7vhmtz/zp9uIpBxigG5A2
         O6ZdwOLDGovYdsYohsOOSHThmb3mnTHpk6A2UMNcJxTS9J9F4xKUagxbEomZoMUsdZcG
         snZ8Yb49sb3rSbb/+v8dlwasPW6K0DIOS3+gP8d4Bj2JtFZ0SGtovStKeP32Zog8AGHT
         mnsES+ED0B/6w/rqZYbS63jbdXUCyU7Ggv6LCfrN2dBOju4fP8uGRlX8Ys6fiik2QynX
         pntQ==
X-Gm-Message-State: AOAM530r5g61ZEq//0b7TYT8zBHN1sYgaZgQ8wNLr53fLP9VYX0XgUpa
        EAW7W+yh2fmj3I7+/l/90GwCXg==
X-Google-Smtp-Source: ABdhPJy1E2n1wySk9qOrdh3bOstGX6IFnS4gtEswiZWoLLb1i3LgQH21DQ/IG1in4qkgxOGgQ0zCxQ==
X-Received: by 2002:a05:620a:22a5:: with SMTP id p5mr5934451qkh.69.1611085496201;
        Tue, 19 Jan 2021 11:44:56 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d1::1325? ([2620:10d:c091:480::1:a066])
        by smtp.gmail.com with ESMTPSA id 184sm13689008qkg.92.2021.01.19.11.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 11:44:55 -0800 (PST)
Subject: Re: [PATCH v3 3/4] btrfs: introduce new read_policy device
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
References: <cover.1610324448.git.anand.jain@oracle.com>
 <3c90d2b8e03dcd9ba9db00c4283a5e73f543a13f.1610324448.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4d6003c1-527f-b29b-49fb-d6aa9dccac0e@toxicpanda.com>
Date:   Tue, 19 Jan 2021 14:44:54 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <3c90d2b8e03dcd9ba9db00c4283a5e73f543a13f.1610324448.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/11/21 4:41 AM, Anand Jain wrote:
> Read-policy type 'device' and device flag 'read-preferred':
> 
> The read-policy type device picks the device(s) flagged as
> read-preferred for reading stripes of type raid1, raid10,
> raid1c3 and raid1c4.
> 
> A system might contain SSD, nvme, iscsi, or san lun, and which are all
> a non-rotational device, so it is not a good idea to set the read-preferred
> automatically. Instead, device read-policy along with the read-preferred
> flag provides an ability to do it manually. This advanced tuning is useful
> in more than one situation, for example,
>   - In heterogeneous-disk volume, it provides an ability to manually choose
>      the low latency disks for reading.
>   - Useful for more accurate testing.
>   - Avoid known problematic device from reading the chunk until it is
>     replaced (by marking the other good devices as read-preferred).
> 
> Note:
> 
> If the read-policy type is set to 'device', but there isn't any device
> which is flagged as read-preferred, then stripe 0 is used for reading.
> 
> The device replacement won't migrate the read-preferred flag to the new
> replace the target device.
> 
> As of now, this is an in-memory only feature.
> 
> It's pointless to set the read-preferred flag on the missing device, as
> IOs aren't submitted to the missing device.
> 
> If there is more than one read-preferred device in a chunk, the read IO
> shall go to the stripe 0 as of now.
> 
> Usage example:
> 
> Consider a typical two disks raid1.
> 
> Configure devid1 for reading.
> 
> $ echo 1 > devinfo/1/read_preferred
> $ cat devinfo/1/read_preferred
> 1
> $ cat devinfo/2/read_preferred
> 0
> 
> $ pwd
> /sys/fs/btrfs/12345678-1234-1234-1234-123456789abc
> 
> $ cat read_policy
> [pid] device
> $ echo device > ./read_policy
> $ cat read_policy
> pid [device]
> 
> Now read IOs are sent to devid 1 (sdb).
> 
> $ echo 3 > /proc/sys/vm/drop_caches
> $ md5sum /btrfs/YkZI
> 
> $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
> sdb              50.00     40048.00         0.00      40048          0
> 
> Change the read-preferred device from devid 1 to devid 2 (sdc).
> 
> $ echo 0 > ./devinfo/1/read_preferred
> 
> [ 3343.918658] BTRFS info (device sdb): reset read preferred on devid 1 (1334)
> 
> $ echo 1 > ./devinfo/2/read_preferred
> 
> [ 3343.919876] BTRFS info (device sdb): set read preferred on devid 2 (1334)
> 
> $ echo 3 > /proc/sys/vm/drop_caches
> $ md5sum /btrfs/YkZI
> 
> Further read ios are sent to devid 2 (sdc).
> 
> $ iostat -zy 1 | egrep 'sdb|sdc' (from another terminal)
> sdc              49.00     40048.00         0.00      40048          0
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
