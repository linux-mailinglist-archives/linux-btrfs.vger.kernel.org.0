Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309CB242AA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 15:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHLNxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 09:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgHLNw5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 09:52:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C06C061383
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 06:52:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so1505484qto.2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bLx953Ltc/rwyNATwRWN6xRdwJjzmscdwwlo/uZ+EOk=;
        b=SuD5qVIrwMAdnwRq+l4QeKMW1Kr1Jwav80IwZ5/3uyrkGTF+oYfyZTOGSxkIiJGy0w
         7Z651/oOa/6zrBjXnqQn6kQTfT7NwyC5H/axt110nEM1qRAckwSwZBaOv/hnYYMp880P
         TUM5uRaPSwKb46oeCCyCOmHZVxZBEXyG+yM3ImDVccPmPASZbOeF0IOsYuL2EcV4YVln
         hdMEO/UufxvP7dpK0rHuy3RsHVFOaVdd0ehpNHXffcgPuLKfCMdyqOZCgQpS2XUz4UyD
         vEMQeJzOx6AV93dBC4jRjziyBPbLKf8r9kCjpIYknA/eca+xTVBSU0rk5oInVtJ03Trd
         CQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bLx953Ltc/rwyNATwRWN6xRdwJjzmscdwwlo/uZ+EOk=;
        b=Ug19vHym47YbIxPa2qxfO8Hji/jyyWYjj+SSth9VbifWdhSjdQfwNL4Q9ptDt4ffz+
         MyXhcKt9T9EAdbKgJf/oNb6r7OXc1G6dE5ILRn/DzOMGyIB+ENgnUX+SwR5SwT1qYD51
         Ltki4KAW0R3ZKjx8zkMpGg4mAsrUdXL5FvFMSOAvA7yxXXZ4uut5vnZ1VMXNolnJTB+h
         a3uIu71uvtuHjd996DRt0683esPk8Ka3xArIdVcCVZJuIVgxODKaVLTjCqMiJvtGIWoB
         6IbxmqWtsLVVW5Xhoq7PI8Ip8DF9WB+xVgohO0AUgkKMfMcwHNv1gSc463af4p2arXHL
         f/Gw==
X-Gm-Message-State: AOAM532ksPgv/SDvM8292hDdfDu9ooASrgkhQmVJVWy6K1zKFEI5w4Tx
        C2xbaBkMLyyeltKIWaigC+q9m6qmaYJgzQ==
X-Google-Smtp-Source: ABdhPJzUEXkvTNgKoCcSSIq/tW8tCWJrKWoBoiXyE6FfH4giqq8uB2SpnU/KhYiH4ea+aLdbBBuvdg==
X-Received: by 2002:ac8:6052:: with SMTP id k18mr6437435qtm.60.1597240376465;
        Wed, 12 Aug 2020 06:52:56 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 65sm2189923qkn.103.2020.08.12.06.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:52:55 -0700 (PDT)
Subject: Re: [PATCH] btrfs: remove fsid argument from
 btrfs_sysfs_update_sprout_fsid
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200812131851.9129-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4cfd98bf-ccf5-a8e5-4e4b-f874b93204e7@toxicpanda.com>
Date:   Wed, 12 Aug 2020 09:52:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812131851.9129-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/12/20 9:18 AM, Nikolay Borisov wrote:
> It can be accessed from 'fs_devices' as it's identical to
> fs_info->fs_devices. Also add a comment about why we are calling the
> function. No semantic changes.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
