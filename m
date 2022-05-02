Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8935176E1
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiEBSzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiEBSzV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 14:55:21 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7785960E4
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 11:51:51 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id e10so4733632vsr.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RPNgyxXJDXDGZcBc1aT/pZKGxSqyn/L69+NbRjC7Bzw=;
        b=lNvhf40q2tE4zEbVeF4ncfbyYFvZ4TlqOV8nhVfQG3hpQTIlZeLe5vgHbAx/+UVja5
         R9Evd0aX3QCck9H4f2cEa7vWpFZJV4xBP+8uN95pDj9kAfd5T7eNxndcC4+mdJq8FsTC
         vv9fBRtYwr4YWFsPlkFVp/ROooEPtBTxkPUFhfpxPpoarA657eofuvAPCN0aQ9Pml6Jb
         Xg8jLZTQ/d3tN9gjVUKe3dkBo1WyqcM6Pa9miHYuz031bSACCjIyFzXo78HKqOrkc0+x
         n5V3+8oTiGAhqbTHNU6jYAyvj4jbd5p7N7ULBak1AjZeSoAyijiqSoHrxxB71b0QNyE3
         VtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RPNgyxXJDXDGZcBc1aT/pZKGxSqyn/L69+NbRjC7Bzw=;
        b=eJrUUs6fooKudOx2eDudxwxsgjf8GAqrVysFdxE814Ou/UeraUj3uOl7+UDoTG2/dY
         vmFqJkEvse4/GkXiPI7mBy51Z84y8aaUMoBBwgbKQqysBE6SvWtIUiZ2RvvoWDdQYg9t
         BkcagXzo0w6deD456P2Inx+c97Rq6ljBu5xHCETjEceoxMuHoCB1I/l4/MDeMMGuWZ7d
         ucBaWJ0ypyVIzV0KRQByndvuL9R6qyBfLrKAS5GfnIjFb7K0Pn1HIA9cfT9hnqvkyfiw
         cj3oUuU6LoBiiBjut1QQuEk5otV2n/xzcgNYHMNz9pMAz5UXeWJ2pjBGrnYYYJoktjR3
         yUfg==
X-Gm-Message-State: AOAM531OeKSiBGhLwR0wTekJjbgfJonJ9nR2207y9CVT4JSUWXPS2KV5
        hNTTewAyK3EVdsah7Gfv95c=
X-Google-Smtp-Source: ABdhPJzf43NI8kw8J98Ip721CRSA/G1gC1p/9lSVbrTOYxrjD7tO+0r+i4WBsZssb1j/eFuXwZ3GKQ==
X-Received: by 2002:a67:67c6:0:b0:32c:bf27:8f68 with SMTP id b189-20020a6767c6000000b0032cbf278f68mr3585782vsc.86.1651517510526;
        Mon, 02 May 2022 11:51:50 -0700 (PDT)
Received: from ?IPV6:2601:46:c600:af85:f97:831b:e168:8fdc? ([2601:46:c600:af85:f97:831b:e168:8fdc])
        by smtp.gmail.com with ESMTPSA id e13-20020ab0356d000000b003626f894df1sm2658460uaa.31.2022.05.02.11.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:51:49 -0700 (PDT)
Message-ID: <d0f9265f-24d0-f6a4-b502-a3ecd7f33e16@gmail.com>
Date:   Mon, 2 May 2022 14:51:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: How to convert a directory to a subvolume
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
 <20220430201458.GG15632@savella.carfax.org.uk>
 <85da8da9-54ee-f65b-e79e-bb24b7540e7c@gmail.com>
 <CAJCQCtQuCorJ6YaPb_hVpX4312U4Ec5v3jcw+g6whYFd4udx0g@mail.gmail.com>
 <f04d134b-1cc6-591e-ba62-437c032707ca@gmail.com>
 <CAJCQCtSAHj78aY_uUhYrnZSshLs=YtMet6uoESTyA1ZgKvqMBw@mail.gmail.com>
From:   John Center <jlcenter15@gmail.com>
In-Reply-To: <CAJCQCtSAHj78aY_uUhYrnZSshLs=YtMet6uoESTyA1ZgKvqMBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

root@Mariposa:/# mount | grep btrfs

/dev/sda3 on / type btrfs 
(rw,relatime,space_cache=v2,autodefrag,subvolid=256,subvol=/@)
/dev/sda3 on /home type btrfs 
(rw,relatime,space_cache=v2,autodefrag,subvolid=257,subvol=/@home)
/dev/sda3 on /opt type btrfs 
(rw,relatime,space_cache=v2,autodefrag,subvolid=268,subvol=/@opt)

Thanks, Hugo & Chris!

     -John


On 5/2/22 12:15 PM, Chris Murphy wrote:
> On Mon, May 2, 2022 at 11:37 AM John Center <jlcenter15@gmail.com> wrote:
>> Hi Chris,
>>
>> Thanks for responding!  Well, I made some progress:
>>
>> root@Mariposa:/# mount /dev/sda3 /mnt
>>
>> root@Mariposa:/# btrfs subvolume create /mnt/@opt
>> Create subvolume '/mnt/@opt'
>>
>> root@Mariposa:/# btrfs subvolume list /
>> ID 256 gen 11732 top level 5 path @
>> ID 257 gen 11733 top level 5 path @home
>> ID 268 gen 11733 top level 5 path @opt
>>
>> Once I unmounted /mnt, I had to create the /opt directory again:
>>
>> root@Mariposa:/# umount /mnt
>>
>> root@Mariposa:/# mkdir opt
>>
>> Then I mounted /opt & it didn't complain:
>>
>> root@Mariposa:/# mount /opt
>> root@Mariposa:/# btrfs subvolume list /
>> ID 256 gen 11751 top level 5 path @
>> ID 257 gen 11751 top level 5 path @home
>> ID 268 gen 11733 top level 5 path @opt
>>
>> So, is this correct?
> Looks correct. You need to include something like 'mount | grep btrfs'
> to know for sure, that should show subvol and subvolid for each mount
> point.
>
>
>
>> It would have been good if there was a direct way
>> to add the level that you wanted the subvolume created & mounted with
>> the btrfs command.  So if I take a snapshot of @, /opt won't be
>> included?
> Btrfs snapshots via the btrfs-progs CLI tool are not recursive. So
> whether the subvolumes are arranged in a nested or flat layout doesn't
> matter. There is a non-atomic recursive snapshot (create and remove)
> option in libbtrfs both for C API and Python bindings.
>
>
>> That'd my goal.  I've been using btrfs at a very basic level,
>> added on top of an md raid1.  It worked well for a number of years, but
>> then I needed to replace the disks, I thought I'd go all in on btrfs.
>>
>
