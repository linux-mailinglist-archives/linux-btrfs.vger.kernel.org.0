Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12F65168F6
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 02:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358176AbiEBAFe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 20:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEBAFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 20:05:32 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C866431
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 17:02:05 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jt15so219192qvb.8
        for <linux-btrfs@vger.kernel.org>; Sun, 01 May 2022 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1aptWXCUJ4+R9bpg74Qk4poZ+GONbllUbL2q9FgUXP8=;
        b=Rf2VCvm1LChrfxRNBHOA0RYBWRZ3WH4WjTFuQ9J+qxLx160A2ZDIhOH6G8uwZ8r+I4
         S1Bu5hDSAF1nxOVdLJOxm9UwvDHPFYRUlTJCKqF5uDFUyVit24RN6hlgF9tcR/2XzxwO
         n3pnChtB0KEHWNwz2/VWp/kRV55JO5Z6+jI6zkEdwuKTG4Tb8zR7oELEJWb8AX1B/ZI9
         FOauVsGsNeE7ofLsTcehcS8x+vL+C5/uV2oZHv6MdFzor1vNC7bsde9Iw6G2t90zjbvO
         O1Hmd4hWGug/Hk1mMYF7tt18derYil0YZz0BsW/jPmYT+R1DV2Zp/yeX5DHwo9NusyE8
         i/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1aptWXCUJ4+R9bpg74Qk4poZ+GONbllUbL2q9FgUXP8=;
        b=04vqhX43LMYKaquxJ/hJBgYN1Qu2MV+N3AAMdGOeGz/SWCCiRIRSOWfOXCTY5qJvdm
         obP4BQl4raGshD+1dvn44Jr5DhGU4gyZJgv8Pi+g2iINkyLYNu0UrYn9ezmn0UOR6qtU
         TERlEH6PyM4G7Jaikb+BSAdtBQ5hpWNz0VOkDrmR63Dz5nlv4SRLqYzWaR+mgxar0riT
         KwIHkqzv61NZq0Iu/sLRRq/bBGR0QfIo3h0cwRfv208BDarAmJUsCBTQykOUo0icKDok
         RhelecymLAFVInvhArA6dbld4RY+arzCD97433ur3SF5a0AxmzIClsFJxiMmia0tB+ME
         J4SQ==
X-Gm-Message-State: AOAM532JxhQ4/++mMgXT175SB0P3QyeSldH71XYYklU4lqo9E8d5Hbja
        zMuBt/wnH/Xzq0RB5764OH1t1KOB4k7SDg==
X-Google-Smtp-Source: ABdhPJzb6jB5KgUiQQtug3Kn7PTRfWfwtwUHTHqmcYjdp1RZjreqQH7sbVPw9yb96yxYBJCJDv2skQ==
X-Received: by 2002:a05:6214:240c:b0:456:46be:f6b3 with SMTP id fv12-20020a056214240c00b0045646bef6b3mr7590280qvb.49.1651449724971;
        Sun, 01 May 2022 17:02:04 -0700 (PDT)
Received: from ?IPV6:2601:46:c600:af85:3271:224b:5e3e:dacc? ([2601:46:c600:af85:3271:224b:5e3e:dacc])
        by smtp.gmail.com with ESMTPSA id w6-20020a05620a0e8600b0069fd57d435fsm1567150qkm.101.2022.05.01.17.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 17:02:04 -0700 (PDT)
Message-ID: <85da8da9-54ee-f65b-e79e-bb24b7540e7c@gmail.com>
Date:   Sun, 1 May 2022 20:02:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: How to convert a directory to a subvolume
Content-Language: en-US
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
References: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
 <20220430201458.GG15632@savella.carfax.org.uk>
From:   John Center <jlcenter15@gmail.com>
In-Reply-To: <20220430201458.GG15632@savella.carfax.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Hugo,

Thanks for responding.  I guess what I don't understand, @home is a 
subvolume, but it appears as /home when it is mounted via fstab.  It has 
a top level ID of 5.  If I create a subvolume for opt, it has a top 
level of 256.  I've tried different variations of opt, /opt, & @opt, but 
they all appear as that variation under /:

john@Mariposa:~$ sudo btrfs subvolume create /@opt
Create subvolume '//@opt'

john@Mariposa:~$ sudo btrfs subvolume list /
ID 256 gen 5968 top level 5 path @
ID 257 gen 5968 top level 5 path @home
ID 259 gen 5966 top level 256 path @opt

john@Mariposa:~$ sudo btrfs subvolume delete /@opt
Delete subvolume (no-commit): '//@opt'

john@Mariposa:~$ sudo btrfs subvolume create /opt
Create subvolume '//opt'

john@Mariposa:~$ sudo btrfs subvolume list -t /
ID    gen    top level    path
--    ---    ---------    ----
256    5993    5        @
257    5993    5        @home
260    5993    256        opt


What I'm expecting is when I do the subvolume list, I would see 
something like this:

john@Mariposa:~$ sudo btrfs subvolume list -t /
ID    gen    top level    path
--    ---    ---------    ----
256    5993    5        @
257    5993    5        @home
260    5993    5        @opt

I would also think the fstab would look something like this:

UUID=ce05e908-2dce-4368-b864-2f29650185e8 /               btrfs   
defaults,space_cache=v2,subvol=@ 0 1
#
UUID=ce05e908-2dce-4368-b864-2f29650185e8 /home btrfs   
defaults,space_cache=v2,subvol=@home 0       2
#
UUID=ce05e908-2dce-4368-b864-2f29650185e8 /opt           btrfs 
defaults,space_cache=v2,subvol=@opt 0       2

I also thought I would have to mount the subvolume like a directory.

So, what am I missing between what I'm seeing vs what I think I should 
be seeing?

Thanks for your help!

     -John


On 4/30/22 4:14 PM, Hugo Mills wrote:
> On Sat, Apr 30, 2022 at 04:08:59PM -0400, John Center wrote:
>> Hi,
>>
>> I just installed Ubuntu 22.04 with a btrfs raid1 root filesystem.  I want to convert a directory, like /opt, into a subvolume. I haven’t been having much luck.  /opt is empty right now, so it’s a good candidate for conversion.  Could someone please explain how to do it?  I’ve been at a dozen different websites, & tried different variations of the “btrfs subvolume create” command, but nothing works when I go to mount it.  I think I’m missing something simple, but not sure what it is.
>     You can't convert a directory into a subvolume.
>
>     Since the directory in question is empty, just delete it and create
> a subvol there instead:
>
> # rmdir /opt
> # btrfs sub create /opt
>
>     If there's stuff in there, you need to create the subvolume with a
> different name, copy the contents of the directory into it (optionally
> with --reflink=always) and then delete the original directory and move
> the subvolume into its place.
>
>     Hugo.
>
