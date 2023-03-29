Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377DD6CD0FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 06:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC2EFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 00:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2EFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 00:05:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D062D74
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 21:05:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id br6so18439368lfb.11
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 21:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680062700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cm0y2jSlKLbtKc2Bni3lfkugX6u2IVjpRhw/AvZRoJs=;
        b=gZcu8qJeIxaPRruDwisq3hnuQ0J28C4A8plgGcqOhihjAFBUJ8b1F8PJzoCLCTO8nP
         yat8j7JB3j8M5v5CkDBKMqATgye2xrxbfCPKejQ5tdspKQ+omSfcVuSaX116AsvwrsQf
         c2CAbwzM8BWdagQAINpPF/Z4xXvKxuORe1tWlWU7F8UzplY3R0YgrU4czyreM82Zbi8d
         g5k2ps+cfIJ6/wl+MHN7FHxz/fhtNDqqivtYPzfFrXQ4baxmv3PWOyfwB1YzBgC7OUbk
         uMi9cyrnmZ2Kz0XO97KuIaUcBJqH21qVeFVCAazyLUDeXhOsBYYOMt+Gq00HhpIrt7jG
         g1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680062700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm0y2jSlKLbtKc2Bni3lfkugX6u2IVjpRhw/AvZRoJs=;
        b=l64iPJB3XXCPVcPXNUdjAMf+x6bZojiw1W/sIqUshMQuGPdODkqHYz8e2U24SZY9Up
         bFof0vBpcsfT+YmydsJ5iQ7ZG3i7zykk+tZfIonjcordQZYEL3PFv+2817xMnCzHCsmX
         Y5CzzA77kw7PiRGUkmerlZXq8KFyNFyHxbAhJmo3fkdNA1SANyxfGPRJwr9uAXm9Og41
         hTg6FGk6Cs+mwfdQMf9AXIIk6JmqoID+6YzA49h2XRM7oYWUMg2/cpB4sAp3gx2X/kLY
         jW3D4Twvzbl8luQUyaVQjUVJyPd82sYpMLrwEXMBDyNtcp9ogopYNDPbM4jTM7g5NWaC
         WulQ==
X-Gm-Message-State: AAQBX9ePvyBEzw5rGb2comueK+gxej3ymzTC6e4jyXCc3q5isZ14COT0
        4jgwG1wzWS6w3XsL4cmE9IBwdcXMOqg=
X-Google-Smtp-Source: AKy350YubYbOGAbGFDZ5G7AmwrrMpCYH3DqeKqdpTMj+4Xsv2aWyo8fzBN2b4gP9hen1gEP5FFXS8A==
X-Received: by 2002:a05:6512:2185:b0:4db:1e4a:749c with SMTP id b5-20020a056512218500b004db1e4a749cmr3802604lft.0.1680062700113;
        Tue, 28 Mar 2023 21:05:00 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:2677:cde2:a192:62d7:6123? ([2a00:1370:8182:2677:cde2:a192:62d7:6123])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25312000000b004eaec70c68esm3456991lfh.294.2023.03.28.21.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 21:04:59 -0700 (PDT)
Message-ID: <65e86175-d73a-3c83-96a2-c38f9abbde8f@gmail.com>
Date:   Wed, 29 Mar 2023 07:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: subvolumes as partitions and mount options
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>,
        Matthew Warren <matthewwarren101010@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
 <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com>
 <CAOLfK3UZDNO_jSOOHtnA+-Hh-V6_cjsL36iZU0a+V=k80KDenQ@mail.gmail.com>
 <CA+H1V9zb8aO_Y37vdwbubqHZds__=hLe06zx1Zz6zdsDLUkqeQ@mail.gmail.com>
 <CAOLfK3Uokj64QcBypkfr7X79qQ9235o=bv87RJtRSKjupKUQLw@mail.gmail.com>
 <CA+H1V9zmpna9Ncov-15einQ0pLevy-1zF-nSvJrzgz7Mp_TrHw@mail.gmail.com>
 <CAOLfK3Um8uwJyvyn9V4YLAXvv7JDAPF9t6KHDi-Q49XYoZf2Rg@mail.gmail.com>
Content-Language: en-US
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAOLfK3Um8uwJyvyn9V4YLAXvv7JDAPF9t6KHDi-Q49XYoZf2Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28.03.2023 22:45, Matt Zagrabelny wrote:
> On Mon, Mar 27, 2023 at 8:42 PM Matthew Warren
> <matthewwarren101010@gmail.com> wrote:
>>
>> It looks like you already have it mostly set up correctly. You will
>> want to mount your filesystem somewhere without specifying a
>> subvolume.
> 
> Sure. Things are starting to make a little more sense.
> 
>   Then you can put all the subvolumes you want "hidden" in
>> there. This should be as simple as unomunting /subv_mnt, moving
>> subv_content to the btrfs root subvolume,
> 
> Right. My rootfs is mounted with a subvolume option, so I still can't
> get at the "root" subvolume:
> 
> # mount | grep btrfs
> /dev/nvme0n1p2 on / type btrfs
> (rw,relatime,ssd,space_cache=v2,subvolid=256,subvol=/@rootfs)
> 
> Thusly, I would need to unmount my root partition (presumably through

There is no need for this, multiple subvolumes can be mounted concurrently.

mount -o subvol=/ ...

> a live-cd or equivalent) and then mount:
> 
> mount /dev/nvme0n1p2 /mnt
> 

This depends on what default subvolume is and will not necessarily mount 
the top level of btrfs.

> and create my subvolume:
> 
> btrfs subvolume create /mnt/@foo
> 

"@" is just a convention, there is no magic in it, it is not *needed*.

> then boot back into my system with the regular root fs mount entry in
> /etc/fstab and then I can mount the subvolume as desired:
> 
> mount /dev/nvme0n1p2 /path/to/foo -o subvol=@foo
> 
> It looks like I can mount the root:
> 
> sudo -i
> mkdir /btrfs-fixer
> mount /dev/nvme0n1p2 /btrfs-fixer
> btrfs subvolume create /btrfs-fixer/@foo
> umount /dev/nvme0n1p2
> rm -rf /btrfs-fixer
> mount /dev/nvme0n1p2 /path/to/foo -o subvol=@foo
> 
> Not a bad work-around.
> 
> Thanks for all the help!
> 
> -m

