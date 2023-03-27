Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790766CAE86
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 21:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjC0TZa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjC0TZ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 15:25:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A68CD
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 12:25:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k37so12909873lfv.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679945127; x=1682537127;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/oj5jsCuErK46enJ1ZHB8BbfS+VO++RUEoFjuGYc/k=;
        b=IbBgrf6anuDdA3C0/O9ir3iDjtUW56yIZS4y1Zjt9UPBt8n3Hl6aQiRVwmmUfxo6+0
         Fdy05AS/FL5YfSj1VK+t/M/foR+t6Q5TPBzbMudMR/yTd7T6WUG1p7R1PMJeIC4LDQXr
         BP/XrIzNj/bk7fYQxFtC3nMk17fGY+bH+NbzPzPPU08U1AFgxofiP+MIGaBvLnVChTEF
         SWUxn/yHZQFWLm37q8dl7gbtHB/4IGte9zP5gHX0dIq1sy/xxQLRkVGP1lWncg0Oq3Cq
         ulk+vtCD8Kk0jykbZq32T2N4/8tlXEIdfyvBVuRXhq1hTCZUQbCCQk3j1IS8Nvj8if5y
         BPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945127; x=1682537127;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/oj5jsCuErK46enJ1ZHB8BbfS+VO++RUEoFjuGYc/k=;
        b=x6T8Nn9hQtO9XEdsWxdePK+JYD/kT3izFuMR6W7kYjNB3ckcQ+gcT5EWRv/ZqhfJfh
         UflVkMP2g+5l/vTVug7lDFEKfnsGdVZ9yOmLJt6e6NK5d3966lx1jDcSHmdqi95TDNQC
         wsI9T3SHsJPcS9DpbM1+nHxGk9v0jEGk/BLFPSOl4oV1PugDOyszyJ+HTfn4Jn+guXC1
         o208Gyf0YlmKdTD/mTJULdlvNGGfY2DB6q+o4S0Ft45I8mjWHOM6bwT8t9urly0w5ZLr
         rr8fgQxTHud7yVaDabrXTfmjV9/HSQgPwOKq+uq4+nYSVdEqG4gtOjGa2uCnUnGS6DTr
         ejVw==
X-Gm-Message-State: AAQBX9dkEioU8wDOCWgIBoeTDDmlHNKX7GyJLxg/W5Kam6zF46goINWD
        SAjArMhS5UT4ONMa+zuSRpQ73r4QkPo=
X-Google-Smtp-Source: AKy350ZvDuDYVNBoriw6lEk04XzX+bPRngZwf+6BAx+0J+RvBVKCRCLHU9gJ2EdnNQW1Ua1gAbzemA==
X-Received: by 2002:ac2:5989:0:b0:4dd:a025:d87 with SMTP id w9-20020ac25989000000b004dda0250d87mr3218709lfn.0.1679945126711;
        Mon, 27 Mar 2023 12:25:26 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:2677:d95a:10a8:f2e:6eb8? ([2a00:1370:8182:2677:d95a:10a8:f2e:6eb8])
        by smtp.gmail.com with ESMTPSA id m30-20020ac24ade000000b004eaf55936eesm2477000lfp.233.2023.03.27.12.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:25:26 -0700 (PDT)
Message-ID: <ffca26e0-88e8-1dc7-ce67-6235a94159e1@gmail.com>
Date:   Mon, 27 Mar 2023 22:25:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: subvolumes as partitions and mount options
Content-Language: en-US
To:     Matt Zagrabelny <mzagrabe@d.umn.edu>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <CAOLfK3WuXuVKxH4dsXGGynwkMAM7Gd14mmxiT2CFYEOFbVuCQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27.03.2023 21:48, Matt Zagrabelny wrote:
> Greetings,
> 
> I have a root partition btrfs file system.
> 
> I need to have /tmp, /var, /var/tmp, /var/log, and other directories
> under separate partitions so that certain mount options can be set for
> those partitions/directories.
> 
> I'm testing out a subvolume mount with the subvolume /subv_content
> mounted at /subv_mnt.
> 
> For instance, the noexec mount option can be circumvented:

"exec/noexec" option applies to mount instance, it is not persistent 
property of underlying filesystem. It is not specific to btrfs at all.

bor@bor-Latitude-E5450:/tmp/tst$ ./bin/foo.sh
Hello, world!
bor@bor-Latitude-E5450:/tmp/tst$ mkdir exec noexec
bor@bor-Latitude-E5450:/tmp/tst$ sudo mount -o bind,exec bin exec
bor@bor-Latitude-E5450:/tmp/tst$ sudo mount -o bind,noexec bin noexec
bor@bor-Latitude-E5450:/tmp/tst$ ./exec/foo.sh
Hello, world!
bash: ./noexec/foo.sh: Permission denied
bor@bor-Latitude-E5450:/tmp/tst$




> root@ziti:/# findmnt --kernel /subv_mnt
> TARGET    SOURCE                                FSTYPE OPTIONS
> /subv_mnt /dev/nvme0n1p2[/@rootfs/subv_content] btrfs
> rw,nosuid,nodev,noexec,relatime,ssd,space_cache=v2,subvolid=257,subvol=/@rootfs/subv_content
> 
> root@ziti:/# echo '#!/usr/bin/bash' > /subv_mnt/foo ; echo 'echo foo'
>>> /subv_mnt/foo ; chmod 0755 /subv_mnt/foo
> root@ziti:/# /subv_mnt/foo
> bash: /subv_mnt/foo: Permission denied
> root@ziti:/# /subv_content/foo
> foo
> root@ziti:/#
> 
> Am I missing some mechanism to restrict subvolume with mount options
> that cannot be worked around by accessing the files in the subvolume
> as opposed to the mount point?
> 
> Thanks for any help!
> 
> -m

