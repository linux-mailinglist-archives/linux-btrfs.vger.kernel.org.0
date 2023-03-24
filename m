Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E741C6C847A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 19:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjCXSGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjCXSF4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 14:05:56 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7B23C44
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 11:04:05 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id x17so3277602lfu.5
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679680741; x=1682272741;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8klVSPsqEvPDLECAA6eNyJUSotv6ZOl40o0TX7meNXk=;
        b=Z81/nsm7E7hU6hZlzgMP+LbqefNst2eh6XZdI6xDp8kwGQS7LceDLrfQhOrC2Wx3IR
         SqLnNx3PT/KJsdj4knjpc+qSRO664frLbYkJ0SsFVeza/vn05l3zux4g62FoMvPx0WAX
         RY6/F8wooofPFP5DmzAT8TUgRVxsHJTlGbcModKdcQmvC+Q/KwRdl48LorDib+LR0HO8
         dvqBEYsQm/QZAHxHzlmlCDvW/cIZRhM1+e/ZCSsF6ECig8huqwsWRIKDGB39IwNalhVt
         zpoZJGJn60ShDdFnuEvKODuVrFPVr7d5o9Sp5FYAxoKbaf21VTgnR/jNLK5ySzy5vRDB
         OpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680741; x=1682272741;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8klVSPsqEvPDLECAA6eNyJUSotv6ZOl40o0TX7meNXk=;
        b=ydYVMjdX0954MBb5SflbRNp7nlmlYAbXktGi0OAbbYSWnguQyXrhaiRCJU3nqR6Nfn
         nvF5FDr84oYMICnE4xIjYyuO1qT29PVjUloOfpg+rFmBeh60Xv+zM8udNI79U4pdHtOI
         RVj8BwFZvh+YQJySkE+bXSMdT2nB0sPymQXLgVD0WbMIK+tX7xZt8PyNp7oFkvldq2zH
         gmVnWG+a6VRkaOrLnWdNSpAatoH2NshJcfY8pcxg+pFyKQK0fXQ03Wg0RxZn5X099dw4
         urUWFHY3sHeRWdWg5Csm6xBq2ydLu2mByayEIl5Er4WEGrcWCoqmD25QyCk2G3a3elVE
         PdFA==
X-Gm-Message-State: AAQBX9f4exTXoT3b6NIj9NhVrwGZ4u5xr0cki3WDfuy7XpkBY7PdwcdL
        vPhQNQFONNET29oZygnUg4HNKvbH8hQ=
X-Google-Smtp-Source: AKy350blKLiGWU3gXx7jcD/s6JdtHm+1MLsomIZVAjmm0XwjGNQ5iax6rl9NgzyhnXkUnAstARpTUA==
X-Received: by 2002:ac2:52b9:0:b0:4d2:c70a:fdfa with SMTP id r25-20020ac252b9000000b004d2c70afdfamr775919lfm.4.1679680740812;
        Fri, 24 Mar 2023 10:59:00 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:2677:4ce9:961:b338:7bcc? ([2a00:1370:8182:2677:4ce9:961:b338:7bcc])
        by smtp.gmail.com with ESMTPSA id r17-20020a056512103100b004e8483bff82sm3431976lfr.271.2023.03.24.10.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 10:59:00 -0700 (PDT)
Message-ID: <0cf5a777-53b5-7f49-05ae-3fa732689154@gmail.com>
Date:   Fri, 24 Mar 2023 20:58:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: help with mounting subvolumes
Content-Language: en-US
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOLfK3VnoHksj2J-r-r360yJ6T6Dd1LX2iTNJ9njmmfttvc8bg@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAOLfK3VnoHksj2J-r-r360yJ6T6Dd1LX2iTNJ9njmmfttvc8bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24.03.2023 20:20, Matt Zagrabelny wrote:
> Greetings,
> 
> I do not use subvolumes (yet). I've searched the internet for some
> tutorials on mounting subvolumes, but the documentation seems lacking.
> 
> So far, I've tried...
> 
> # btrfs subvolume create /foo
> # mount -t btrfs -o subvol=foo,defaults,nodatacow
> /dev/disk/by-uuid/5f33a159-4475-44e5-a5f8-40a23e18983a /mntfoo
> mount: /mntfoo: mount(2) system call failed: No such file or directory.
>         dmesg(1) may have more information after failed mount system call.
> 
> However /mntfoo exists:
> 

It does not say "mount point does not exist".

Argument of subvol= option must be full path from the top level 
directory. You root filesystem most likely is already located in one of 
btrfs subvolumes, so subvolume foo is inside other subvolume and you 
need to provide full path.

tw:/home/bor # mount /dev/vda2 -o subvol=foo /tmp/foo
mount: /tmp/foo: mount(2) system call failed: No such file or directory.
        dmesg(1) may have more information after failed mount system call.
tw:/home/bor # mount /dev/vda2 -o subvol=/@/.snapshots/1/snapshot/foo 
/tmp/foo
tw:/home/bor #


