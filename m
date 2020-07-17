Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541E1223F56
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgGQPSi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgGQPSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 11:18:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA1C0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 08:18:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id e3so4366835qvo.10
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v6LyJcvS12LhhieSTxt1VHSVOt/s3DVCWYrA/m0JMRQ=;
        b=b9zwo4bO+bgEF+cQbjVgNCa3n3Xjxlb+nE9mzLkcEaP1rnGvjT3VzhX3IfBopkroYd
         DTMo6ktGjAc0n/RubCahFGRlW9QJZgY/X7K4NEKUJk879XwdiYEMWycFCj5fzVPxEY38
         A3DcPWVqZuV76qu+Ti2OPqn8czCcL9mqtQeal2WLzJjp3D/5YSCyvgjXCrGH6Rv2kYZB
         Tid9QLrBh2piFbTQfdjw+ERU20OHcODKhYt5V/KFn2yvK8dOlNSA2GdW9mte+OWy6iFL
         wTH0ER23rXalJLyoMgFbYpKoLAzqHOQHkxPXo5XlrFsXlgPrkzMelBUZelMuphSqozP0
         EmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v6LyJcvS12LhhieSTxt1VHSVOt/s3DVCWYrA/m0JMRQ=;
        b=Lqma73iIHiiGup7i6F6kEHpCrsGv8XvdpWBN3qktp4/HzUKpgyy2P9g0zwBAbrLcut
         3Rt3V+4mWzN22IayypeVXpDHusvFblw3v/cnAWNWZwzJPxLUMIeSZ/I8QF3FnMasPiOd
         P+QCjLF5r29Sw5xhn3RzgOunH1Jfd0hLQWNBVcYtwIZ2F8TzQlyxINSXcu+7V7QnoZY/
         txzV3vXbdUUWF6q0CGae1vtfzlIblvidKmY0L9+NMyjPoRIdqwj2e+0bPQzXr2JH2dQT
         N6AXWqgQahaszRnzQnI7FkGRaydB6+YLpmmo+P6fxenhnW8pkqoB+WmYBZEg0VXNOcDY
         ni0A==
X-Gm-Message-State: AOAM531g0HT9Ch052pOY+OT9zCQ14oyA/0JbKkyTX8UUlIM8Ve7d/00T
        s1XECgEmpFCFoHqXlm7tL68yOg==
X-Google-Smtp-Source: ABdhPJwvURJ0tuj+KhZTFO/E9BBm2KxdwKOLfY5IPAgDigL5C9pd1bLBswEcQl6UpBW/mgO5CkMB8g==
X-Received: by 2002:ad4:5148:: with SMTP id g8mr9107411qvq.173.1594999116155;
        Fri, 17 Jul 2020 08:18:36 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p3sm11071149qtl.21.2020.07.17.08.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 08:18:34 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix lockdep warning while mounting sprout fs
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     martin.petersen@oracle.com
References: <20200717100525.320697-1-anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <971f9aba-1cf1-2681-86ef-244af76c0904@toxicpanda.com>
Date:   Fri, 17 Jul 2020 11:18:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717100525.320697-1-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/17/20 6:05 AM, Anand Jain wrote:
> Martin reported the following test case which reproduces lockdep
> warning on his machine.
> 
>    modprobe scsi_debug dev_size_mb=1024 num_parts=2
>    sleep 3
>    mkfs.btrfs /dev/sda1
>    mount /dev/sda1 /mnt
>    cp -v /bin/ls /mnt
>    umount /mnt
>    btrfstune -S 1 /dev/sda1
>    mount /dev/sda1 /mnt
>    btrfs dev add /dev/sda2 /mnt
>    umount /mnt
>    mount /dev/sda2 /mnt
>    <splat>

NAK, I've fixed this properly locally, I've just been waiting for xfstests to 
finish with all the other lockdep things I've found.  Thanks,

Josef
