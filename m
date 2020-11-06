Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CA2A9A56
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgKFRCp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 12:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgKFRCp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 12:02:45 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD2CC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 09:02:45 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id t191so500595qka.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=moQ5odqqON5o7afDS35IJB5sSm9VM6JdKV2FNbPQLQI=;
        b=W9MGycVD2ZgV5cRZZEynVeS0hq4xuEBGOHWAlUxQbZW/yitYrwiuTS/mzBjl5hSpSB
         BmIy1m7J4rhW6VIxSk5Lz2qM7TFBB9uJihXi+Gai/TE4GzvsEcaYV3WPFMShArzjcfAc
         qcu4muar2nUXC1JIYTsIXVRiujZGp68AJnRfsLkMwNAORLtqcW0689HhNgbT/YT/Kr2O
         Su3nyBixhLlJ4bwP9Ww2BRmqxwIi8JgmdSFohP4cdpmzOehbfeWF7y7myNvBbc2nFX5U
         cR3Uy3gQr+a4YevFnx4aHeG6czwGBNaHOAcELfV7dfls0AKTAYvJITDOL648Grjq60/7
         UEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moQ5odqqON5o7afDS35IJB5sSm9VM6JdKV2FNbPQLQI=;
        b=CFoCmdicznG0pQTkuN7ffgqQnWtDt3V8krm4q7zKf+53OomQeCF5lZ56EHeEdtcto/
         T6YjAq5j3OheTNQQnW8R/0M3uYA8o3vj9I/10iAc592QghAnyrbydbom3YgjlMf+eiHP
         f3Mcw0sTtJrsaDSdRI659ET/hw81qxSn0vbgwK9GJ7//dISRZdMIOv97kzAolueo8bxX
         Zu6iY9V0mPEj+1/Sg6Axq3YYES4w9RO/n0Ye7EvisZfYH9gqvbFxMsFhBqHRq60ODIdu
         JbNIx4ksNSZSx43Sw1PUTzHJ7Pjy3vSZXKOsP2Vglhuje3Q9a8NZCB4U3EkNLg/wkXzq
         yWqg==
X-Gm-Message-State: AOAM533L2mmzyq2csmKTs+rOPaJs0WvHEakyf1kv+sjpPcWgTYVECh8Y
        wBz1cuwS/dNDsTDQaQJHDI49sdfNE2VDJ6nM
X-Google-Smtp-Source: ABdhPJwFodFwNMQUlj25szK8ycMM1YoIqgARHWyNyiqpduWpjAqbyOTS6/REjznkF4DoEUPzP2ENnA==
X-Received: by 2002:a37:7c04:: with SMTP id x4mr2317908qkc.441.1604682163955;
        Fri, 06 Nov 2020 09:02:43 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z2sm942106qkg.76.2020.11.06.09.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:02:43 -0800 (PST)
Subject: Re: [PATCH 1/1] btrfs: cleanup btrfs_free_extra_devids() drop arg
 step
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1604649817.git.anand.jain@oracle.com>
 <a20a37162b49e5b1de7a5ec70607102b61ac94eb.1604649817.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4275cb92-5451-a193-d7cf-a3f76b7c7cf6@toxicpanda.com>
Date:   Fri, 6 Nov 2020 12:02:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a20a37162b49e5b1de7a5ec70607102b61ac94eb.1604649817.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/6/20 3:06 AM, Anand Jain wrote:
> Following patch
>   btrfs: dev-replace: fail mount if we don't have replace item with target device
> dropped the multi ops of the function btrfs_free_extra_devids(), where now
> it doesn't check the replace target device. So btrfs_free_extra_devid()
> doesn't need the 2nd argument %step anymore. Perpetuate the related
> changes back to the functions in the stack.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Actually nm,  I forgot to build, this thing doesn't compile.  Thanks,

Josef
