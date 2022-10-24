Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54653609FE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Oct 2022 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJXLLc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiJXLLU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 07:11:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8154A138
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 04:11:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e18so29823807edj.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwhX/H6eI/U7I9KsOrWYOXkjzjrrDvrblmC2tc4YLwE=;
        b=i7MUu4NAnx+PGX1Fa/mEkhb7g/qM9S3Gjle/rmk1yPcI2w1KupKhhnEkE43UvxOz12
         lM+aA3PHzvIKuMcApjOq07BVmFnfzFgc86/3jYT8YcE9woArpnqzeWzmj0+eupzptAHj
         iODNO4yiTeO34I3KGF8faiPYULho8Z77g2Wy52KEBpBSflU+bxpLKoIb6Y/W3f+bFPpf
         MTuPZfkYqlJzeA6lfl1+F9yUhT2xMrgIz82IEz6xVJT1Kt1PEkVp8pcRf5V3cM+vDd5j
         l6mTcKkXyRzwBngGGXJ4ybEUWa3e7Y7oYBozB+ONX/c5xH5gjvj2bZCangkRCeuLjYZ4
         WErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwhX/H6eI/U7I9KsOrWYOXkjzjrrDvrblmC2tc4YLwE=;
        b=JPmFuJTmmwPRKkNCsxSE4k42HZhbE7kvSIoe3M+3lYBSNUY5twJjpLNJjvRU+tg9my
         yfdCAg2HTSOdhJhZH8FoHmyxmDXVFaphSVLOOimnmEIae+ez+iG22LVYt8CRZApjQBex
         f9EqWJnNnm1qAagDUiZuuYzZ7+y3aPN0Tk5OkWN1ldEa4JmuNf/TIq/W2g2/+FKTBLdY
         ACv6y7jc2b0DOYnZv8npPFPfmzRgWJ6AFjTUWb9qRVFBaFOtjfDb37L+k76AqX9jPl3x
         q5fXg0dmzjglwFAPmiOSn+kFeVvWm1TTSqnqAj5B08XKn1M4c0OIzN4ar6+nTCpc7pmQ
         IbfA==
X-Gm-Message-State: ACrzQf3AYLr2yXVjKKucSBQ2VriI/0xS+XySLKT7icI4KQr5WnT1gRjI
        40lUzXUzIySqHFdNHIW9p8ahe/UwQudt5NfYgXrbhs2RNlE=
X-Google-Smtp-Source: AMsMyM4HJQfCcjIRQwbEKCUzxEVdgspMV8ShgPpnIQ8z49Ab/N+5Gn6mD2iudxQT7MHDhKKp5lMbk0dkng3EOGtO0vw=
X-Received: by 2002:a17:907:3da2:b0:78d:45df:b4f with SMTP id
 he34-20020a1709073da200b0078d45df0b4fmr26410462ejc.651.1666609873684; Mon, 24
 Oct 2022 04:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <CALyjvZsgYXkDXKbNhNYrsbVE8rx3nGwy8fAD6gxredq0_ezNoA@mail.gmail.com>
In-Reply-To: <CALyjvZsgYXkDXKbNhNYrsbVE8rx3nGwy8fAD6gxredq0_ezNoA@mail.gmail.com>
From:   Abhimanyu Saurot <saurotabhimanyu89@gmail.com>
Date:   Mon, 24 Oct 2022 13:11:02 +0200
Message-ID: <CALyjvZu61NNDokqaHxDvMOwXpsdgkd0SrR4+PPb5Nee5BBtprQ@mail.gmail.com>
Subject: Re: btrfs filesystem becomes read only
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Team,

We have installed btrfs on our backup server having a 1.2 P partition
formatted using btrfs.
This partition stores the  data which is backed up from a different
folder mounted on the same server.
However we see that btrfs filesystem become read only quite frequently
and we can do anything but reboot the server to recover the filesystem

We tried to run balance on the filesystem that gives some breathing
space however the issue reoccurs.

Would it be possible to help us fix the issue ?

Details of system:
uname -a
Linux 3.10.0-1160.el7.x86_64 #1 SMP Tue Aug 18 14:50:17 EDT 2020
x86_64 x86_64 x86_64 GNU/Linux

btrfs --version
btrfs-progs v4.9.1

btrfs fi show
Label: none  uuid: b6d915e1-47c6-43ed-9f6e-eed2dc4309f3
        Total devices 9 FS bytes used 312.06TiB
        devid    1 size 130.96TiB used 34.74TiB path /dev/sda
        devid    2 size 130.96TiB used 34.74TiB path /dev/sdb
        devid    3 size 130.96TiB used 34.74TiB path /dev/sdc
        devid    4 size 130.96TiB used 34.74TiB path /dev/sdd
        devid    5 size 130.96TiB used 34.74TiB path /dev/sde
        devid    6 size 130.96TiB used 34.74TiB path /dev/sdf
        devid    7 size 130.96TiB used 34.74TiB path /dev/sdg
        devid    8 size 130.96TiB used 34.74TiB path /dev/sdh
        devid    9 size 130.96TiB used 34.74TiB path /dev/sdi

btrfs filesystem df -h  /hpc/storage/nlhtc/fs-htc-002
Data, RAID0: total=311.47TiB, used=311.46TiB
System, RAID1: total=32.00MiB, used=12.59MiB
Metadata, RAID1: total=612.00GiB, used=610.29GiB
GlobalReserve, single: total=512.00MiB, used=29.00MiB

Regards,
Abhimanyu Saurot
