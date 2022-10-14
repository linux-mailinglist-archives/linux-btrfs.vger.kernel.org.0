Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4966F5FF40D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 21:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJNTVZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 15:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJNTVY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 15:21:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E7526556
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 12:21:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu25so8718195lfb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHJHESLUkzOX2fSmAx0D2/TZiOW094jzja0teLknZlo=;
        b=gy4EAOA0YpaRs4XYzSLPZRlH1LrtCdqKA8sfjlbtayas1T4ZVGq6UJ8+tZVRJXWJgD
         W59no+6GPo0VFAOG2ijvm1cwTqfK3vNBZPEUpMnftpfbdarAbq4ZKuNjg4c2sjGFpb97
         hFKZLSp+WlhTlm6xTwNB4y5XZtoPBqSo6bLzOKVHo3n09pvmnAt4nq31lLOonsUdgaPC
         cGj3xYgCt0ZFZ95qsMRhIk7AzYtJJ4Y45IGywHL2cPGE4tKRMO2UsS5Dmy7PxkdqESBX
         UuWrzAr0h7TvVTF7TE4SyVMbhK6ZqJVu9k2ymqtg6s/ZWNNyw5OFj4+/DJfGbRy6zFE4
         s2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHJHESLUkzOX2fSmAx0D2/TZiOW094jzja0teLknZlo=;
        b=0YdJBQ3ovKY3IwVZkZkOof42jv2t0rxfyqasfCs75qiUzR0uDCV+XqeU0LKkwAq7OI
         OTlEr7alY7vodojEz1h4zZqmXycFIeU2p6PLcBEWMhDWH9bMc0K6xXdHSNyQ7jFCxnM9
         i9S0aFiFxu8pDK/qSyXVh1sI7MVgiT2XWhcIJSHnUIIdBtkNBU3W6yPBAYB3MhjUXfZy
         f1caPPFkSYizt761Uc8g2NGn+1OhZmvXQQpiRW/Ui+bDNj8pr/atMkTm2r2VWRZWYJqz
         sDOdFtJfVDkmB8qc1vqwLqXx4mtCrOQbIFipordMWu7cYmwzmoDOxZSYA8xYdfjxwtXt
         AtoA==
X-Gm-Message-State: ACrzQf069Kkgf3fEevT2kqfc13xqOz0qZocCSd+eCfFoxo+iR37i4DUM
        Uei8+++JNiCR+xy+AERTuXDyOnlMJx4=
X-Google-Smtp-Source: AMsMyM5jEHpu6jCuLC397joehOlAxcME71bPWTXpFdwM7GK5vyl7mOL7i2h68N+1YY+AE/3i0WWucg==
X-Received: by 2002:a05:6512:3f9a:b0:4a0:2af3:4523 with SMTP id x26-20020a0565123f9a00b004a02af34523mr2226727lfa.184.1665775281110;
        Fri, 14 Oct 2022 12:21:21 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:683d:d53f:3ecf:4fff:a00? ([2a00:1370:8182:683d:d53f:3ecf:4fff:a00])
        by smtp.gmail.com with ESMTPSA id a11-20020a19f80b000000b004a45ed1ae21sm460776lff.224.2022.10.14.12.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 12:21:20 -0700 (PDT)
Message-ID: <d345acda-9095-318f-9de6-b3eb83dc6921@gmail.com>
Date:   Fri, 14 Oct 2022 22:21:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: documentation of swapfile and nodatacow
Content-Language: en-US
To:     Nikolaos Chatzikonstantinou <nchatz314@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAAQmekd_X=XSZWq+JN0vq+vyYJTxdvsZJBCuCeqEDkz=RVW0NQ@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAAQmekd_X=XSZWq+JN0vq+vyYJTxdvsZJBCuCeqEDkz=RVW0NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.10.2022 21:04, Nikolaos Chatzikonstantinou wrote:
> Hello list,
> 
> This question popped up during the writing of a swapfile
> guide. Following
> <https://btrfs.readthedocs.io/en/latest/Swapfile.html>, I chose to put
> the swapfile on a separate subvolume which does not get
> snapshotted. The steps I have:
> 
>    btrfs subvolume create swap
>    chattr +C swap
>    chmod 0700 swap
>    fallocate -l 1G swap/swapfile
>    chmod 0600 swap/swapfile
>    mkswap swap/swapfile
> 
> I'm uncertain about the chattr step. In
> <https://btrfs.readthedocs.io/en/latest/btrfs-man5.html#mount-options>
> I find the note
> 
>    "This means that (for example) you can’t set per-subvolume
>    nodatacow, nodatasum, or compress using mount options."
> 
> which applies for mount options. On btrfs(5) I find under FILE
> ATTRIBUTES
> 
>    C      no copy-on-write, file data modifications are done in-place
> 
>           When set on a directory, all newly created files will inherit
>           this attribute.
> 
>           NOTE:
>              Due to implementation limitations, this flag can be
>              set/unset only on empty files.
> 
> This says that the +C attribute can only be set on files, not
> directories, although it explains (in theory?) what should happen if a
> directory has that attribute.
> 
> To summarize, I'd like to ask:
> 
> 1) Can `chattr +C` be used on a subvolume? Is it different from mount
>     option nodatacow?
> 

chattr +C is not used "on a subvolume". It applies to top level 
subvolume directory and then is inherited as per documentation.

> 2) Should the man page be reworded 'only on files that are empty'?
> 

Which man page? Man page you quoted (btrfs(5)) already says it.

> 3) Should the readthedocs page be changed to include the subvolume
>     creation step and remove the `truncate -s 0` step?
> 

Why should it enforce any particular layout? It is up to each user to 
decide where swap file is located. The commands in documentation work 
also when file already exists.
