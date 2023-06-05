Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111BA722D26
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjFERAJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjFERAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 13:00:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF6ED
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 10:00:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f60924944aso758275e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685984405; x=1688576405;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/8AtTzfVWgd+InpKIziojxkVLZdX65d7qdsx/+Yaf0=;
        b=Qvpphx5ia2AzcNZiGP4bcgMmz9yfoHCDckfmHmWANMHYOW1g5fn835Wf29DJrVaSji
         Zo3fBTAE+Ua+cp5HtVXHVYhkc1WinO55IagYetJNCrCzIW3nBkQtDbvf5Kux4dFiDdEi
         vBTP1zhYJS04+4HvylSOgsLZXJaCbEFB1yzVU12s2ZIzwCdzehv99QcdSPxmlH8MaNk9
         v6fn0PesW0gfyZTSOySs856jybP8W6XflbijZo2YjhVznqfJ8a5UoJcNxqvHPQwCPVXl
         2xujIEiY0thLysD6eTBQDK1y4+HZCEQc/0/IDl0gydpcCKnOIiYdS3dtKe1nJv8MgnCM
         ggxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685984405; x=1688576405;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/8AtTzfVWgd+InpKIziojxkVLZdX65d7qdsx/+Yaf0=;
        b=k3VPCiQmANBQ2wGzGpJNtdINCack/uY8JpUoYSmaQe3DP15ZkCy10ah94JQ9fTJdni
         j5NuZb5DSNPu/j/u65WaCVEHSATUczvj/7cu5KNrpE6VpZ+ePfdj+GKxL1/utcVqFS9B
         2SvdqBuYoB0GJQFvSHi5rVWDCFi8rGSA/leKP4ThiAecrXAKf1IDJDvaL8BfXM9R/REJ
         cud+ba6mevTYatwK+6FUG7WcTr9YoIokPJud4h/FFLiQBnB4P2H8q2wqswy+xUjtlvBQ
         Cc9WFZSow1NvejKKGxXu/8taBgP1GqzhGCIGm9oZRYPWHhsfdbkgI7xSWAn/rw7Tp1TN
         qh7w==
X-Gm-Message-State: AC+VfDxpXInWXbU44IRbL+54FVuUGDOuCwY8yq1i7AB1SP3V6P9AhfYk
        KGrbA7g/ndu4J+ZJ36INyhcmDoNieyM=
X-Google-Smtp-Source: ACHHUZ6OfmXcU6wmHO/hdGy91faMhulio/MZWXbIV2vVAz3soEb1PDYU2RIpDjuOpPDX7HSPQKhOfQ==
X-Received: by 2002:ac2:5999:0:b0:4f6:1c08:e9b4 with SMTP id w25-20020ac25999000000b004f61c08e9b4mr2525575lfn.6.1685984405117;
        Mon, 05 Jun 2023 10:00:05 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:1d8:d636:e803:d06:4133? ([2a00:1370:8180:1d8:d636:e803:d06:4133])
        by smtp.gmail.com with ESMTPSA id p19-20020a19f013000000b004f4589808ddsm1174119lfc.305.2023.06.05.10.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 10:00:04 -0700 (PDT)
Message-ID: <9bfa8bb6-b64e-d34f-f9c8-db5f9510fc29@gmail.com>
Date:   Mon, 5 Jun 2023 20:00:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: How to find/reclaim missing space in volume
Content-Language: en-US
To:     Marc MERLIN <marc@merlins.org>, linux-btrfs@vger.kernel.org
References: <20230605162636.GE105809@merlins.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20230605162636.GE105809@merlins.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05.06.2023 19:26, Marc MERLIN wrote:
> I have this:
> sauron [mc]# df -h .
> Filesystem         Size  Used Avail Use% Mounted on
> /dev/mapper/pool2  1.1T  853G  212G  81% /mnt/btrfs_pool2
> sauron [mc]# btrfs fi show .
> Label: 'btrfs_pool2'  uuid: fde3da31-67e9-4f88-b90d-6c3f6becd56a
> 	Total devices 1 FS bytes used 847.89GiB
> 	devid    1 size 1.04TiB used 890.02GiB path /dev/mapper/pool2
> sauron [mc]# btrfs fi df .
> Data, single: total=878.00GiB, used=843.85GiB
> System, DUP: total=8.00MiB, used=128.00KiB
> Metadata, DUP: total=6.00GiB, used=4.04GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 

btrfs filesystem usage -T is usually more useful than both the above 
commands.

> 
> sauron:/mnt/btrfs_pool2# du -sh *
> 599G	varchange2
> 598G	varchange2_ggm_daily_ro.20230605_07:57:43
> 4.0K	varchange2_last
> 599G	varchange2_ro.20230605_08:01:30
> 599G	varchange2_ro.20230605_09:01:43
> 
> I'm confused, the volumes above are snapshots with mostly the same data
> (made within the last 2 hours) and I didn't delete any data in the FS
> (they are mostly identical and used for btfrs send/receive)
> 
> Why do they add up ot 600GB, but btrfs says 847FB is used?
> 

Each subvolume references 600G but it does not mean they are the same 
600G. If quota is enabled, "btrfs quota show" may provide some more 
information, otherwise "btrfs filesystem du" shows shared and exclusive 
space (you need to pass all subvolumes in question to correctly compute 
shared vs exclusive).
