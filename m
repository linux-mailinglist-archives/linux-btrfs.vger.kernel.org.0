Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FEF27B432
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Sep 2020 20:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgI1SOH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Sep 2020 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgI1SOG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Sep 2020 14:14:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39343C061755
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:14:05 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id r8so1489288qtp.13
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Sep 2020 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KL6Y+9f4woPZIGaU62P9PT94b0Jp/DTj9sWzkoJwl3k=;
        b=bWAjQpKQMc0y54GGuXltk0s4V7oeqK4ZztE48opElfc5MVMl/hBK63XMSEvl2k/DmE
         ph6mMEZQQyHhdx1DADaLAT9uxgBZhqFEtciijwoSsHn2sVPS3KQ42gL0pwYSA7douOOm
         mNmkphZqFXpB7kntDz+2zzUTPRu90PZ72mBpGVr0QITQTa5FlQUXiiqJKiUg2RmK79U7
         4RxOE2MzhJo0gHgYyb6+ydOdv8qMCg1ihtGUIx6KavfojQm148/PGphEAoocUdkamiH+
         3kcKHL2ipPQt8MjQ+8tvHW02jYhsHAg3ZAZi7v9lzDSCm+5/gBvlnsUjsnYMqzdW4ps7
         xilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KL6Y+9f4woPZIGaU62P9PT94b0Jp/DTj9sWzkoJwl3k=;
        b=cQSF7eA8b9AQHh8rlOuci2thW7ogbMjwHOUEdac7Z3PVJcZOP7MBVJ16raO1Er+stD
         Sy6ZGZNuTKdHqTrR5cA/sXLzmOAYhhF048HSu/RviWGV4Y6MiQ45FuRhoAkVZbyrZQKk
         dAC8fws7LcmA6ktT6EF3FFqqEMu+dSnulaJtNo6jvx4f+s9y9BTNa4bZ0kTvEYFecwyk
         TS4SedHDywn5LDuXeM+3fe98VPddf/XddK3zcfygbn0QrBwyrHX1yWmb/wfHECwLeKzk
         Xc2SvmCyNqca5b6iUEPz/1MGffKhYE56X0sOkuV9kC+LMAxE3uPyvxjSIpcAEIQ06xag
         yaEg==
X-Gm-Message-State: AOAM532zTMzjH3BwFhvoaXbnERVy+9MXFo4HHv7+WbfBqOmtpCLVhTpS
        q1BL3GnvbxzE69mCczlc8TOTAQ==
X-Google-Smtp-Source: ABdhPJx1t/gkyDiP98+yC40E2mJ9ioXax/XJ+aBwQq6CTzzMe09ir+s9MUZOacDLrysqJdYxSaENPA==
X-Received: by 2002:ac8:7413:: with SMTP id p19mr2919872qtq.347.1601316844316;
        Mon, 28 Sep 2020 11:14:04 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c40sm2223217qtb.72.2020.09.28.11.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 11:14:03 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: free device without BTRFS_MAGIC
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com
References: <dbc067b24194241f6d87b8f9799d9b6484984a13.1600473987.git.anand.jain@oracle.com>
 <1ee9b318e3bb851aaec9c1efd1eadb117ad46638.1600741332.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <abf4c158-6b31-be1a-8645-59fc0ca7306a@toxicpanda.com>
Date:   Mon, 28 Sep 2020 14:14:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1ee9b318e3bb851aaec9c1efd1eadb117ad46638.1600741332.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/21/20 11:13 PM, Anand Jain wrote:
> Many things can happen after the device is scanned and before the device
> is mounted.
> 
> One such thing is losing the BTRFS_MAGIC on the device.
> 
> If it happens we still won't free that device from the memory and causes
> the userland to confuse.
> 
> For example: As the BTRFS_IOC_DEV_INFO still carries the device path which
> does not have the BTRFS_MAGIC, the btrfs fi show still shows device
> which does not belong. As shown below.
> 
> mkfs.btrfs -fq -draid1 -mraid1 /dev/sda /dev/sdb
> 
> wipefs -a /dev/sdb
> mount -o degraded /dev/sda /btrfs
> btrfs fi show -m
> 
> /dev/sdb does not contain BTRFS_MAGIC and we still show it as part of
> btrfs.
> Label: none  uuid: 470ec6fb-646b-4464-b3cb-df1b26c527bd
>          Total devices 2 FS bytes used 128.00KiB
>          devid    1 size 3.00GiB used 571.19MiB path /dev/sda
>          devid    2 size 3.00GiB used 571.19MiB path /dev/sdb
> 

Wouldn't this also happen if the bytenrs didn't match?  In that case you aren't 
freeing anything, and we'd still show the improper device correct?  So why not 
deal with that case in a similar way?  Thanks,

Josef
