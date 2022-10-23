Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B4360918D
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJWHBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Oct 2022 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJWHBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 03:01:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E00696C2
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 00:01:34 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o4so4154958ljp.8
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 00:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92QvZdw0mbKlQI7Z0WC1VhCnbixsuxoOcinBZ9Tochs=;
        b=GW/udvOEUpInOa3zvx6PwAP1n/WCtC/ujcZYGz13Lkk8rU4VviTX4eJS0PY0UbB8fa
         3lk4mDSZevg2NOXT4Qan+CYvXM4HG2JZfX0yN9C4dBS8d/gRHjNU+Ga/sfe/S9iRQ5Xc
         ajggInSJyvnBZ5ESxAtyZUXMBazmzne3pcz2V+ofFMQC7o9YElEeXg7SbVlmipSzJOKv
         dMUkyvjGaZ/XXy1BEPHbnCyOkGQ5IoyPAYxlqNOlCocPyqWf1HxpT4lcMRg3GXBD92tD
         falEFDc5ShqVdBbekHTmoR5zXl/WlS7mL9H/RSo4nhHm7lEDVBzCauQ2w8yTTWb0kleE
         QPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92QvZdw0mbKlQI7Z0WC1VhCnbixsuxoOcinBZ9Tochs=;
        b=T7KK8GRwmKisGe3DKg+7SCaOdzEhX0CazJMMDcoHOu8Lgvb/BgNUlARd1Jl3FmJkjO
         SEDoQRzOBG+dt7+YgFFH/GUXxgPpeVu4jNONMAcjiFRaVmQDTFn09o/KTsM3yAAPKOhT
         BKFJlK+PHLw5+WgO61NRoQI0wG8pR6cKx2dubj/9SnoF7vh+fT/DSmUnrLwPlAXPM7dd
         qmxNLWKXis7PmyvywQDhFM8YsGtCIZJNiG0QwrC/0Y5i9n1ol4X5O8Qcwr5tv4eBUBjg
         +AD7o4nu6/fL0he9+NfELlu58lNNHBlzUyiokYb9HcylCiYkxLu1kLsMRb7bzaGoGRu9
         oYfw==
X-Gm-Message-State: ACrzQf2psKGsn/Y+HdD3q4RmD+w6jlOX2RMv7AbPM8WIwlw/nkjoHYYL
        gKl0AUwGaJGjFgHO8elfsCUHndAq5WY=
X-Google-Smtp-Source: AMsMyM5MM9UxJZyoS6claVlgpfif/MdB8q2uT9wswhVjQubJGM5pdsruBbig8onI7pe70nKV/v1ZLw==
X-Received: by 2002:a2e:920f:0:b0:26d:fe57:a1b6 with SMTP id k15-20020a2e920f000000b0026dfe57a1b6mr9240049ljg.345.1666508493105;
        Sun, 23 Oct 2022 00:01:33 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:683d:d39b:93f8:dc63:5f03? ([2a00:1370:8182:683d:d39b:93f8:dc63:5f03])
        by smtp.gmail.com with ESMTPSA id c32-20020a2ebf20000000b00261ccf566e3sm122494ljr.65.2022.10.23.00.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 00:01:32 -0700 (PDT)
Message-ID: <d59f04b3-9b79-905c-dca9-5fc4ce7be0a9@gmail.com>
Date:   Sun, 23 Oct 2022 10:01:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Is it safe to use snapshot without data as 'btrfs send' parent?
To:     Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>,
        linux-btrfs@vger.kernel.org
References: <d87ce800-670e-9ca2-b524-8b20678abd9b@inbox.ru>
Content-Language: en-US
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <d87ce800-670e-9ca2-b524-8b20678abd9b@inbox.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23.10.2022 00:13, Nemcev Aleksey wrote:
> Hello Btrfs developers.
> 
> Thank you for your great product, Btrfs!
> 
> I want to use Btrfs snapshots and 'btrfs send | btrfs receive' features
> to incremental backup my PC to an external drive.
> I can do this using commands:
> btrfs subvolume snapshot -r subvolume snapshot; btrfs send snapshot -p
> previous_snapshot | btrfs receive backup_drive
> 
> But Btrfs snapshots on my PC consume space even for deleted files.

Snapshots by definition preserve the content of filesystem at the time 
snapshots were created. So of course data captured by snapshots continue 
to consume space on filesystem. What use would snapshots be if data were 
immediately deleted everywhere?

> So I can't just remove unused files to free space on my PC if I keep
> parent snapshots for incremental backups on this PC).

You only need to keep one latest snapshot to implement incremental 
forever backup.

> I need to do another backup, then remove snapshot left from previous
> backup from my PC to free up space.
> 

Yes, that is what every backup software that supports snapshots does.

> I want to use metadata-only snapshots to overcome this issue.
> 

There is no issue here.

> Can I safely use the following chain of commands to keep metadata-only
> snapshot on my PC and keep full snapshots on the
> backup drive?
> 

There is no such thing as "metadata-only snapshot". I am not sure what 
gave you this idea.

> # Initial full backup:
> # Create temporary snapshot
> btrfs subvolume snapshot -r source/@ source/@_backup
> # Send temporary snapshot to the backup drive
> btrfs send source/@_backup | btrfs receive backup_drive
> # Delete temporary snapshot
> btrfs subvolume delete source/@_backup
> # Move received on backup drive snapshot to its final name
> mv backup_drive/@_backup backup_drive/@_backup1
> # Send back metadata-only snapshot to source FS
> btrfs send --no-data backup_drive/@_backup1 | btrfs receive
> source/skinny_snapshots
> 

This creates new subvolume under source/skinny_snapshots with empty 
files. This subvolume is completely unrelated to the original source 
subvolume source/@.

> # Incremental backups:
> # Create temporary snapshot
> btrfs subvolume snapshot -r source/@ source/@_backup
> # Send temporary snapshot to the backup drive using metadata-only
> snapshot as parent
> btrfs send source/@_backup -p source/skinny_snapshots/@_backup1 | btrfs
> receive backup_drive

This sends difference between "skinny snapshot" with empty files and 
your current filesystem. Which means it sends full content of all files 
currently present on filesystem effectively converting incremental send 
stream into full send stream.

> # Delete temporary snapshot
> btrfs subvolume delete source/@_backup
> # Move received on backup drive snapshot to its final name
> mv backup_drive/@_backup backup_drive/@_backup2
> # Send back metadata-only snapshot to source FS
> btrfs send --no-data backup_drive/@_backup2 -p backup_drive/@_backup1 |
> btrfs receive source/skinny_snapshots
> 
> I tested this sequence, and it seems to work fine on small test filesystems.

This is very convoluted way to simply create sequence of full snapshots.

> Backups seem to be correct and seem to have all files they should have
> with correct checksums after all.
> Source FS frees up space after deleting files while having metadata-only
> snapshots on it.
> It's possible to use such "skinny" snapshots as parent for btrfs send
> command.
> 

It is possible to use *any* snapshot as parent. btrfs will compute 
sequence of operations to get from parent to your sent snapshot. In the 
worst case it means deleting all existing data and recreating from 
source. Using full send you start with empty target and avoid deleting.

> But I'd like to get confirmation from Btrfs developers:

I am not developer, but ...

> Is this approach safe?

If "safe" means "filesystem structure and the *content* of files will be 
replicated on receive side" - yes.

> Can I use it daily and be sure my backups will be consistent?
> 

I do not know what "consistent" means for you. If "consistent" refers to 
filesystem state during "btrfs send" - yes, it is consistent (snapshots 
are atomic).

Again - you could replace all this voodoo dance with simple sequence of 
full "btrfs send". Your procedure loses all advantages of btrfs data 
sharing between snapshots both during send (you always send full 
content) and on backup storage (because receive side is unaware that 
identical files share the same data).
