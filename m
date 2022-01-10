Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1744897A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jan 2022 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiAJLkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jan 2022 06:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbiAJLiY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:38:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC1EC061212
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jan 2022 03:38:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u13so43098897lff.12
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jan 2022 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=i77+Qcnj7TAhmyCEskYeM8gJSw/uFp1eIs8ggKOkErQ=;
        b=hMPCQqhS6fuzfrBN3rnySJIEWUfk00OeXzm/l81U8pKmgt0liJF5hUpezhICUFGxC5
         GF2MQsPrMFnR7SyfRFj3+zfqObGi9xYdEEweRsa8+xk5TtzvMlSL3ExtJxJ3ogk2cSw5
         SxFKWBQZxT07f0Zir8LdmCtsLcLECdlZog+MOEGWKx92IFhuRVVieft1N5Gyy7p7a7uz
         fbbwLzK2MDbZTLqbWPMsaweDo+xHic2YDA/eBA/aheQhZ7RyHijT/gf9KDALtWuwpI4j
         /0jesL+pFhyz1h8zHJfwJy0yU4o+4SMzxTZaWdg1+jEhC6/O0XJb2k0MEq/60YpGPlAp
         KAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i77+Qcnj7TAhmyCEskYeM8gJSw/uFp1eIs8ggKOkErQ=;
        b=yO4hI6qRmMBumMkTc3WW0c3ujmUdPff889GGfaDYdmEy4BSTk+rw/r5auDsJRsZaCM
         aSKjRrhOOr1Fk3TY9hx5vl/WIrchcpRMWv6pW/UI3VUTaxf+w2BdbbM1crIh04gAYFVQ
         LGimJAMP6jDi4ldqq3gv+O61WnMYzXgqqarDIuEMUaNekhE/rTuHIfeFxFeioxjeFt8k
         cG7/w28uvlwirgpLcxNCrhP8oKaold2DbDA8YZKCP3rnL0IYW1jlN7cGsMaoXGhoIEgn
         4txd4BBKFYg41hdr3by2cT6QiElyxxM0Qo76JgUvL4oVphvmXeRDwm37kyhzKsizdFDM
         Gs3w==
X-Gm-Message-State: AOAM5304/by5LWhpkAGjOD232TVUTpkFbqxtTSTqwFd9YUYmWsrKhEnT
        cUTtP7ed1BBboNmMZdA1diBHsCNVsB2yvw==
X-Google-Smtp-Source: ABdhPJwVv+TS4piwovsUyjo7XWUUi8mzNCcC5mMj3SPBJLKNVkuUGTjBhYq+at58EcspBxBQ9KmzfQ==
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr43787717ljp.372.1641814702063;
        Mon, 10 Jan 2022 03:38:22 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:d6:c816:a6d6:456b:6a47? ([2a00:1370:812d:d6:c816:a6d6:456b:6a47])
        by smtp.gmail.com with ESMTPSA id cf21sm965265lfb.228.2022.01.10.03.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 03:38:21 -0800 (PST)
Subject: Re: Adding a UUID to the top level subvol on an existing filesystem
To:     Alex MacCuish <alex@maccuish.de>, linux-btrfs@vger.kernel.org
References: <61b5cb09-8bd4-8b25-fbda-73b866a36fd5@maccuish.de>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <f9e3796c-573a-a577-7a1f-4227b89e4da1@gmail.com>
Date:   Mon, 10 Jan 2022 14:38:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <61b5cb09-8bd4-8b25-fbda-73b866a36fd5@maccuish.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09.01.2022 13:11, Alex MacCuish wrote:
> For use of send/receive, I need my subvolume id 5 to have a UUID. I see 

You always send read-only snapshot and send/receive is using UUID of this
snapshot, not of original subvolume. Do you get any error or something
does not work?

> here (https://www.spinics.net/lists/linux-btrfs/msg76016.html) that it 
> was discussed to add this feature to say btrfstune, but I can't find any 
> option to do it. What's the best way to do this and ensure current 
> subvolumes have the correct parent ID?
> 
> ---
> 
> Linux xxx.xxx.xxx 5.15.11-051511-generic #202112220937 SMP Wed Dec 22 
> 10:04:02 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> 
> btrfs-progs v5.4.1
> 
> btrfs fi show
> 
> Label: 'storage'  uuid: 61538bc8-fc27-4818-9cc9-133938e252da
>          Total devices 4 FS bytes used 2.35TiB
>          devid    1 size 1.82TiB used 1.63TiB path /dev/sdd
>          devid    2 size 1.82TiB used 1.63TiB path /dev/sdc
>          devid    3 size 1.82TiB used 744.03GiB path /dev/sdb
>          devid    4 size 931.51GiB used 738.03GiB path /dev/sde
> 
> btrfs fi df /mnt/storage
> Data, RAID1: total=2.35TiB, used=2.34TiB
> System, RAID1: total=32.00MiB, used=368.00KiB
> Metadata, RAID1: total=5.00GiB, used=4.32GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> btrfs subvolume show /mnt/storage/
> /
>          Name:                   <FS_TREE>
>          UUID:                   -
>          Parent UUID:            -
>          Received UUID:          -
>          Creation time:          -
>          Subvolume ID:           5
>          Generation:             4620363
>          Gen at creation:        0
>          Parent ID:              0
>          Top level ID:           0
>          Snapshot(s):
>                                  CN_IMGS
>                                  CN_PKGS
>                                  CN_PKGS/.snapshots
>                                  CN_SHARE
>                                  CN_SHARE/.snapshots
>                                  CN_MEDIA
>                                  CN_MEDIA/.snapshots
>                                  CN_HOMES
>                                  CN_HOMES/.snapshots
>                                  CN_BACKUPS
> 

