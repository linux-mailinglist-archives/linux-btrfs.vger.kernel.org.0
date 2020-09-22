Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE42742A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 15:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVNIF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIVNIF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 09:08:05 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065CC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 06:08:04 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h1so9461231qvo.9
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Sep 2020 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgnjcaZpgLg8GKeXycL7i+hPMAo/atGgY0lTPtAZf2Y=;
        b=GNuK1gufy3vOAhQYzTcQuOpEdePgw5UThdGLWRV517STXf7Ge3e9RYRaO26ZeDNprO
         H7v7LczoBEHHXgcS3t8gbTEZQ5Zf8rKBcmy9voWgY++hRYgbiNy8lQOb30lsuG0na4CP
         ozRr30TfW1+rqsgETcWLolFq3TTzmPSrc+CxR4QE7+6hGk6SC3lItdTTsdPr/6tZH/t0
         0lwO8DkRjwy2CiixvEinlkG9awg65vuiFuE67b09rYfN2fpThAedMhh95yY10rzMRYBg
         CFAKGoX/4hzMVpIyjS4jicTcNGUcNgSWHQ4/hrcZPrv2UffCirh1nFw3JFC0AF30F5wu
         mcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgnjcaZpgLg8GKeXycL7i+hPMAo/atGgY0lTPtAZf2Y=;
        b=T8LfIWK5hdw0lsbKEZYTiHkT2/05q5Nc0iM2135pLoSn7Ko3fnu2cq7tL2cVgePcqb
         AyAbWCE9n0OlTCKJ2Aopo+NihYHVDZHUj1uSfv5aRfNnN9cdlVdxeUmQcWPXf66fztD2
         YjawpOkBAX4s+v5HKC/0SM2S7JlnuWierqbBh7kTfEon/gL/5VJCQBvAOwNPGBTw0eU2
         Ndmf5hvA7RcejloGk5R2jJzWICvTytpueBZtvJiZQGShBkVDGqptKddMN1egH7+34ewH
         gqnDcbS/pa1jDGpn1Sthj3asZvUk5jAD4DeFqZat6KAp9na8rTl9x4SbhDmT39b1/4be
         dklA==
X-Gm-Message-State: AOAM532FDq1YZQjQ+FjaiVxyEtqH3bbJjGa0AbT9XbtForbGzoKq8fxQ
        MfXCCyHSOkLNqfr1PVJXLQrry5BBQGNANCh5
X-Google-Smtp-Source: ABdhPJzEJeZXXeATtouT35C3FN6zevn/1q1Yrx7jQE7jG6NDoblqasymkvBhFikJgAtzYMtRxgqPdw==
X-Received: by 2002:a0c:f982:: with SMTP id t2mr5673780qvn.5.1600780083499;
        Tue, 22 Sep 2020 06:08:03 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z29sm12761785qtj.79.2020.09.22.06.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:08:02 -0700 (PDT)
Subject: Re: [PATCH add reported by] btrfs: fix rw_devices count in
 __btrfs_free_extra_devids
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     syzbot+4cfe71a4da060be47502@syzkaller.appspotmail.com
References: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4f924276-2db3-daba-32ec-1b2cf077d15d@toxicpanda.com>
Date:   Tue, 22 Sep 2020 09:08:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <b3a0a629df98bd044a1fd5c4964f381ff6e7aa05.1600777827.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/22/20 8:33 AM, Anand Jain wrote:
> syzbot reported a warning [1] in close_fs_devcies() which it reproduces
> using a crafted image.
> 
>          WARN_ON(fs_devices->rw_devices);
> 
> The crafted image successfully creates a replace-device with the devid 0.
> But as there isn't any replace-item. We clean the extra the devid 0, at
> __btrfs_free_extra_devids().
> 
> rw_devices is incremented in btrfs_open_one_device() for all write-able
> devices except for devid == BTRFS_DEV_REPLACE_DEVID.
> But while we clean up the extra devices in __btrfs_free_extra_devids()
> we used the BTRFS_DEV_STATE_REPLACE_TGT flag which isn't set because
> there isn't the replace-item. So rw_devices went below zero.
> 
> So let __btrfs_free_extra_devids() also depend on the
> devid != BTRFS_DEV_REPLACE_DEVID to manage the rw_devices.
> 

This is an invalid state for the fs to be in, I'd rather fix it by detecting we 
have a devid == BTRFS_DEV_REPLACE_DEVID with no corresponding dev_replace item 
and fail out before we get to this point.  Thanks,

Josef
