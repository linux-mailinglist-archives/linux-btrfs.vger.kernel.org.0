Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9037313DF53
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 16:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgAPP4H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 10:56:07 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37025 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgAPP4G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 10:56:06 -0500
Received: by mail-qv1-f67.google.com with SMTP id f16so9267143qvi.4
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zqMwRapW2/9N/PP3rsXj45x2/Hja5vSuUYGNBl/Tszw=;
        b=UweQXmERTYYziR2QpzGs2afuzCUSwr2c9n+/tWhYrBAQbKBkHaokxEcfrVj1vjVt8t
         bjEo/pehaDrCOCI7xW5nhxoJkA7mfEq8JO0VPuiCOtXOsEnKF0RL4v9IX/9oniEVlKbd
         K1MQ8a4uL+C3h90jDqwY+GTEbe6DAi0RnzEZFcyD48MDIFWUbd/4WzxSmYvu5w3jFWnO
         aH9cMHkoWtzEY0mydCg/RiVkmW+KLXTf4XdeKWcU2u/BTLm4OFJjqo7PGbkU7yJi5B4l
         KJkh7VOtqDhwrf9sKPdLEQNqaIyvMVVjnIsw7+2yAhHLo2SgyG2UZbeDsgAFniFykdGB
         WLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zqMwRapW2/9N/PP3rsXj45x2/Hja5vSuUYGNBl/Tszw=;
        b=AAZofRvpWutDwZNJAbiZKjgRqMyF4gAwVXux2SxUVvHAvVBmEil2Dw50A9naVlyzr6
         K1Ho9qhNSd+z4rmVHjitCLhdSe0DU5y7/M3KVjW+t555Qt3veO2hDfbOvtTM5tEFSgpD
         jOhNEv2nDwHotVdeNK1p7cWj/elS0yo4vOwrU+EllH5dO15NeiDg/haisemJeRKdQaQW
         GNcKnbHuxlyJ7/cGzV4Q19MIsr3G7eIetxPKldTCfT13d7hL0YYO4SgOa6huSyOAT7sb
         L9QCAVzPT6Kx+HOwtTpipmzaSalcdWdix97ogOI1C17YSyQ9GErSdjWQv2aEOKqi92TH
         chUw==
X-Gm-Message-State: APjAAAVw1GsrTOEh8J87J5QZGxs6tCjVZJYRZeCcDVthATN0gCYOv+2/
        OFZgjcz/Ja21+8E3arMPBi+Z5AojCe5qYw==
X-Google-Smtp-Source: APXvYqwOAS69Sywofjeyn7swYegvfSaiKLiCS8IqOuEDnsS1mRVZe1Gxe/PHPIJ6mu/HDH0P+1dHAA==
X-Received: by 2002:ad4:40cb:: with SMTP id x11mr3226588qvp.167.1579190165670;
        Thu, 16 Jan 2020 07:56:05 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::6813])
        by smtp.gmail.com with ESMTPSA id q25sm10487335qkq.88.2020.01.16.07.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 07:56:04 -0800 (PST)
Subject: Re: [PATCH v3 3/5] btrfs: remove identified alien btrfs device in
 open_fs_devices
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-4-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <550c6454-be48-51bb-1196-40586e3649b7@toxicpanda.com>
Date:   Thu, 16 Jan 2020 10:56:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191007094515.925-4-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/19 5:45 AM, Anand Jain wrote:
> In open_fs_devices() we identify alien device but we don't reset its
> the device::name. So progs device list does not show the device missing
> as shown in the script below.
> 
> mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
> mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdb
> sleep 3 # avoid racing with udev's useless scans if needed
> btrfs dev add -f /dev/sdb /btrfs
> mount -o degraded /dev/sdc /btrfs1
> 
> No missing device:
> btrfs fi show -m /btrfs1
> Label: none  uuid: 3eb7cd50-4594-458f-9d68-c243cc49954d
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 12.00GiB used 1.26GiB path /dev/sdc
> 	devid    2 size 12.00GiB used 1.26GiB path /dev/sdb
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Why not just remove the device if there's any error?  I'm not sure why these 
particular checks make a difference from any other error?  Thanks,

Josef
