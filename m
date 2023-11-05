Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775807E180C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 00:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjKEXku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Nov 2023 18:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjKEXkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Nov 2023 18:40:49 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A55E1
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Nov 2023 15:40:46 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-672096e0e89so25748946d6.1
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Nov 2023 15:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699227646; x=1699832446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dagjjyfPOBlm6EeE25b7pg5WCLn3y6LiIW92GHru0A=;
        b=kXngfynCAR35jRJxt2iabPfEX+rwCuvIIG+g8PJIK0jljdzBvFDiqMY+L+LVryjPDO
         hqRpUka5aPTOvXOtvJSvbeTPNahvvSCGhfPSjl6Zu85V1Xayetfp5Az/GyQPIg0rTO9O
         GFr4lEAR75ZCVZfxBm1CQLlqijiKbCdL4jcCDObjh6RLl6bOJYP6F80gH8ibHhrrPWdw
         yQ5fQGrQWEwgRT+nZuCpigsQ1Ye7iA3sV/QO1bbxQ4kNO3GCKZCznGGbCxkEIoP+ASIa
         7IL95p//cj8ydUpxwEqTN3ouhhUe8NXL8RrS2hiScU/JIfWfvRyI8HQJkgNBgUBpqqZT
         SnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699227646; x=1699832446;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dagjjyfPOBlm6EeE25b7pg5WCLn3y6LiIW92GHru0A=;
        b=fMAGuC/4JkgmKGvOSNmMVIgxgPHRImCxq3u3gm8i9hIAJfnC7388A4Ozvg3w9xm/pk
         fV8aZlJubCFYdTVYlGlfcoLvGw89l9L64Nxt5QzF5H0bFOqRLSsnTfdq24wF87pZ588a
         2Ny2U8FKn3V4v9W8nFmWj/EelbRrgv6VxJQpGjPdhxsRGNZaQZhQ/PvEhFxxfM+EL3wM
         g7YzVqQ+L0372ZZw0+PiumaqAb65q4iYd+6eTal6kBUxQWEU9tsskuKwQrLzZRk9LFao
         x5fhaHWfpoMorjab2U8e8lwSR2ZzalXeieXAYV1nXILD5PdqJ9L4ZhX0/kQcJG2Ews2B
         DFow==
X-Gm-Message-State: AOJu0YwCjinOw5MJzbfxoxzd686vEBF3DkRh8uBgLAsRjQaI4EKLP/oR
        x7wQ4GLZJ87RN8KBPQx4SG362B+9JYkf2Q==
X-Google-Smtp-Source: AGHT+IHcDqBf7fsmnzHv1Mx6fF8ZRyKjjCJ1SV7DbLLtJJ1la8j/7g3NFbDz6WADSqTcHHgILYgd5w==
X-Received: by 2002:a05:6214:624:b0:671:560f:32fa with SMTP id a4-20020a056214062400b00671560f32famr26185685qvx.40.1699227645980;
        Sun, 05 Nov 2023 15:40:45 -0800 (PST)
Received: from [192.168.1.1] (pool-100-16-13-166.bltmmd.fios.verizon.net. [100.16.13.166])
        by smtp.gmail.com with ESMTPSA id t9-20020a0cef49000000b0066d12d1351fsm2914937qvs.143.2023.11.05.15.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 15:40:45 -0800 (PST)
Message-ID: <be0c51ba-86bd-44e7-884a-6cfccfa76184@gmail.com>
Date:   Sun, 5 Nov 2023 18:40:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs progs release 6.6.1
Content-Language: en-US
From:   Joe Salmeri <jmscdba@gmail.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20231105222046.19483-1-dsterba@suse.com>
 <aa605999-708c-4b8c-a05c-78fd2cc6b5b2@gmail.com>
In-Reply-To: <aa605999-708c-4b8c-a05c-78fd2cc6b5b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

Thanks for the info.

I'm using btrfsprogs 6.5.1-1.2 and my btrfs filesystem is a single 
partition on a single device so it does not seem like the bugfix release 
is related to my issue.

I actually think the issue occurred because of Skype crashing ( although 
it does still seem a little odd to me that would cause the issue ).

Is there a way for btrfs to remove that directory entry which points to 
the inode that does not exist ?

After I removed all the @home snapshots, that got rid of all of them 
items that btrfs check reports EXCEPT for the one in the @home subvolume 
so deleting a subvolume can remove the items, but I really don't want to 
have to delete and restore the @home subvolume to fix it.

And since then btrfs has created new timeline snapshots for @home so 
those obviously have the same issue as the ones I deleted but that 
problem would go away if I can find a way to remove the offending item 
in the @home subvolume.

Is there some way to remove that item ?

Running "ls -al /home/denise/.config/skypeforlinux/blob_storage/" also 
shows that offending item:

     drwx------ 1 denise joe-denise   72 Nov  1 22:49 .
     drwxr-xr-x 1 denise joe-denise 3.7K Nov  1 20:07 ..
     d????????? ? ?      ?             ?            ? 
02179466-b671-4313-8fa5-0eb87d716f92

I tried removing /home/denise/.config/skypeforlinux/blob_storage/ since 
that is the folder that contains the 
i02179466-b671-4313-8fa5-0eb87d716f92 directory item but that fails

     rm -rf /home/denise/.config/skypeforlinux/blob_storage/
/usr/bin/rm: cannot remove 
'/home/denise/.config/skypeforlinux/blob_storage/': Directory not empty

Joe

> On 11/5/23 17:20, David Sterba wrote:
>> Hi,
>>
>> btrfs-progs version 6.6.1 have been released. This is an important bugfix release,
>> v6.6 is broken and should not be used.
>>
>> Due to an accidental change in definition of the scanning ioctl in a
>> "documentation only" patch the mkfs or 'device scan' command were not able to
>> register all devices and mounting multi-device filesystems failed.
>> I misdiagnosed that as a change in the CI environment, thanks all early
>> packagers and testers for reports and the fix.
>>
>> Changelog:
>>
>> * fix device scanning ioctl definition, accidental change to the 'forget' ioctl
>>    that breaks mounting multi-device filesystems
>>
>> Tarballs:https://www.kernel.org/pub/linux/kernel/people/kdave/btrfs-progs/
>> Git: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git
>> Release:https://github.com/kdave/btrfs-progs/releases/tag/v6.6.1
> -- 
> Regards,
>
> Joe

-- 
Regards,

Joe

