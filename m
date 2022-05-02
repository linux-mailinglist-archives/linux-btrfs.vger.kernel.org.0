Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624415172C9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbiEBPl1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 11:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiEBPl0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 11:41:26 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10C81013
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 08:37:54 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 126so10648266qkm.4
        for <linux-btrfs@vger.kernel.org>; Mon, 02 May 2022 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MoGbUHf/KpNVEdl3OQQ5TAz0W0eJQ9hqCNfgxFVsrN0=;
        b=ECUjcZAjI3PgSTzlLTm/7VMK2n1nekHOWO9B19SklokQszNPZtLhWFAxgUU9LCwRa0
         C+GqWlmfg3zQA3yfkOgFCoUuR8uoyh2mcu5yUbwzHO4Eu1bWRBW5AHOHEhPvGWUtJQbj
         CWvjn9ZWwRlJltZreBmBjBPvGY5MRWqEkjr+QCPCFOdOSLPxSGkywkOcQjhgngzQKuaq
         XOx8kkRVjG3HU0o/WlRYS1wrb/BqQUr7fGYSG5WcwAA08ixCzYixyutWQg9y1+eRBXPT
         F5xFvzpo2Up3ZdLxei2TX3H674rJHrLjqs0mgrs3n4iBi4fkxKWMg8Q8zigu+1CevA/A
         VcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MoGbUHf/KpNVEdl3OQQ5TAz0W0eJQ9hqCNfgxFVsrN0=;
        b=ufoAJfIDRN00VI+GLPA8qFyY4lQfjknpemDhfsXSuuMx2Mbxluz33CjCXqMx/kt2K5
         vVFgYUnTbyP+zo59uTx2iSNv0TL5D5kqIEXm/7LifyCpW0kp5s/NmKCNh7oXG1TK0uJ3
         TzjDiqobtMjGlifiQUBI/mss9k5znnYkkBjJoe8kAt5/4n/eKaPXLOZSBFbhFT7bm4wY
         9l+iE8CH60/XY2Q5iHb08XKAqc3XQCrruTvriO9X0qWSwVMxisu3pxy1WPZKWRCscKEi
         HoPw/RYUlBhqff4uTnbU7+JXIeqEAilD+a7Hls8TXcwcyFliS9SlOmAOFQqLTgmEtVqe
         vXcQ==
X-Gm-Message-State: AOAM5315ImPf6QPyKXJ20eqskOPvERCvfEzyg1dUGzlmv/GxsT8Mrn4F
        NfBR1KdnCnfQTUHeay+lmg6MEvbCzBInKg==
X-Google-Smtp-Source: ABdhPJxDpztSNc7gPt3ApSmRBMdI72+wDKY/S63GqEcFciU7BHdlmFxv0y/xkLtdEOg4HTtb6oGCwA==
X-Received: by 2002:a37:350:0:b0:69f:8c4e:9fa5 with SMTP id 77-20020a370350000000b0069f8c4e9fa5mr8902826qkd.770.1651505873833;
        Mon, 02 May 2022 08:37:53 -0700 (PDT)
Received: from ?IPV6:2601:46:c600:af85:3271:224b:5e3e:dacc? ([2601:46:c600:af85:3271:224b:5e3e:dacc])
        by smtp.gmail.com with ESMTPSA id b3-20020ac86783000000b002f39b99f6a9sm4145643qtp.67.2022.05.02.08.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 08:37:53 -0700 (PDT)
Message-ID: <f04d134b-1cc6-591e-ba62-437c032707ca@gmail.com>
Date:   Mon, 2 May 2022 11:37:52 -0400
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
From:   John Center <jlcenter15@gmail.com>
In-Reply-To: <CAJCQCtQuCorJ6YaPb_hVpX4312U4Ec5v3jcw+g6whYFd4udx0g@mail.gmail.com>
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

Hi Chris,

Thanks for responding!  Well, I made some progress:

root@Mariposa:/# mount /dev/sda3 /mnt

root@Mariposa:/# btrfs subvolume create /mnt/@opt
Create subvolume '/mnt/@opt'

root@Mariposa:/# btrfs subvolume list /
ID 256 gen 11732 top level 5 path @
ID 257 gen 11733 top level 5 path @home
ID 268 gen 11733 top level 5 path @opt

Once I unmounted /mnt, I had to create the /opt directory again:

root@Mariposa:/# umount /mnt

root@Mariposa:/# mkdir opt

Then I mounted /opt & it didn't complain:

root@Mariposa:/# mount /opt
root@Mariposa:/# btrfs subvolume list /
ID 256 gen 11751 top level 5 path @
ID 257 gen 11751 top level 5 path @home
ID 268 gen 11733 top level 5 path @opt

So, is this correct?  It would have been good if there was a direct way 
to add the level that you wanted the subvolume created & mounted with 
the btrfs command.  So if I take a snapshot of @, /opt won't be 
included?  That'd my goal.  I've been using btrfs at a very basic level, 
added on top of an md raid1.  It worked well for a number of years, but 
then I needed to replace the disks, I thought I'd go all in on btrfs.

Thanks for your help!

     -John


On 5/2/22 9:16 AM, Chris Murphy wrote:
> On Sun, May 1, 2022 at 8:02 PM John Center <jlcenter15@gmail.com> wrote:
>> Hi Hugo,
>>
>> Thanks for responding.  I guess what I don't understand, @home is a
>> subvolume, but it appears as /home when it is mounted via fstab.  It has
>> a top level ID of 5.  If I create a subvolume for opt, it has a top
>> level of 256.  I've tried different variations of opt, /opt, & @opt, but
>> they all appear as that variation under /:
>>
>> john@Mariposa:~$ sudo btrfs subvolume create /@opt
>> Create subvolume '//@opt'
> This is the mistake. Since @ is mounted at /, using /@opt actually
> means /@/@opt, thus it's been nested.
>
>> john@Mariposa:~$ sudo btrfs subvolume list /
>> ID 256 gen 5968 top level 5 path @
>> ID 257 gen 5968 top level 5 path @home
>> ID 259 gen 5966 top level 256 path @opt
> @opt was created inside @, that's why it looks like this. Thus, @opt
> is nested within @. Thus, @ and @home follow a flat layout. And @opt
> follows a nested layout. To continue with the flat layout for @opt
> you'd need to create the @opt subvolume in the top-level of the file
> system alongside @ and @home rather than within one of them. To create
> it in the top-level you need to mount the top-level somewhere, e.g.
>
> btrfs subvolume get-default /
>
> Assuming this refers to ID 5, then you just
>
> mount /dev/sdXY /mnt
> btrfs subvolume create /mnt/@opt
>
> And the fstab entry should be subvol=@opt
>
> If get-default reports a value other than 5, then you need to
> explicitly mount the top level:
>
> mount -o subvol=/ /dev/sdXY /mnt       OR
> mount -o subvolid=5 /dev/sdXY /mnt    OR
> mount -o subvolid=0 /dev/sdXY /mnt
>
> The top-level subvolume was assigned ID 5 during initial creation of
> the file system. Soon after, ID 0 was set up as an alias for 5 because
> maybe it'd be easier to remember.
>
> Note: The top-level nomenclature used by btrfs subvolume list is
> considered confusing, and I think it's going away in btrfs-progs
> soonish? The "top-level" of the file system is considered equivalent
> to subvolume ID 5, which has no name, cannot be renamed or removed,
> but can be snapshot, and is the subvolume created at mkfs time. Above,
> it sounds like there's multiple "top-level" subvolumes, e.g. 5 and
> 256. But in practice it's not how anyone is using the term "top
> level", which these days is intended to refer to just ID 5. The
> subvolume with no (explicit) name.
>
>
>
>> john@Mariposa:~$ sudo btrfs subvolume delete /@opt
>> Delete subvolume (no-commit): '//@opt'
>>
>> john@Mariposa:~$ sudo btrfs subvolume create /opt
>> Create subvolume '//opt'
> Yep, / is still the @ subvolume here, because @ is bind mounted to /
>
>
>> So, what am I missing between what I'm seeing vs what I think I should
>> be seeing?
> It'd be neat if we had a way to create subvolumes in the top level
> directly without having to mount the top level. The FD variant of the
> C API found in libbtrfsutil suggests it's possible. And also we have a
> way to delete subvolumes by subvolid, even when they aren't locatable
> via the mounted file system hierarchy, using the --subvolid flag.
>
>
>
>
