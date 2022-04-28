Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A0513E39
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348629AbiD1V6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 17:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiD1V6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 17:58:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29934705B
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 14:54:58 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f4so7971092iov.2
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ICCJ9ys9vUn198UnJWa8a4FdaFe20q7pmxOrvgTM40=;
        b=qJuYp1CagQ1ZFRWrvj8mmNBDdXV7s/sxyIgoa+5mbc46plIPWTjxRZsQe8R+VtUvMm
         uTrtvImDgikkpJRtgAFY9Zks4ZM1C6Y864mL+3gzgJTZHLCayAqeOKecBOcpig03Id0U
         nQLdL87SnMHj1YaGqnQnN6n9kMPBmnu2th0zvUgrZmkOdglKztAoZtCe8QC/vhy8iQoc
         vwB8xc4ASNGi7f1pt6nHegeo6ExsBhOFKr9k/f12dsBNfPBisYqtelZTzNlpuNGWjius
         EaCw6IDtWnuyBK6nLawfm0eK0xQpJ+vXuzipU0rY+TLlMnWb+eflXbdI067R2d06HCLG
         Zaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ICCJ9ys9vUn198UnJWa8a4FdaFe20q7pmxOrvgTM40=;
        b=VJyu1vj8ypA2u2n8wHoh8FsJ//rdGiqGjL/PaiTqQmyDbDoI2ZLxq7c8b08LX12+OR
         QvSIn32Onch68xY2NKT7J65JKNHTuJsDzqukv/4XkHuJ4V8sd7qs7+vAFdtpI1YpRnNQ
         FVfuCaxFxHAraHy9V9dzye2KLLnlkNmdwwqv/S5Q88hl3Lbjes05lNQ3Tkloaa+SXk+n
         qp8fzSuFYllO/GV+vvlqik/7aF3iKOlPz2iK6patUKbF3DWXPa/1Bgx4OowxpMG/9S34
         +/3bj65JcHCUey7RVteCg6ZOWCSD3alFmD3XxGrcA4lxJhEBlZ6R9t913jl8u0yvU4Ky
         Gf9A==
X-Gm-Message-State: AOAM531IpYcALm0vsZuUefKj9jafiquYYyDUh0lcxjYcH79AwNPX0fSm
        smnUs6EdnkyTOsEcNlzOfdgBj2736nsc4yG+Pld1VmFUuus=
X-Google-Smtp-Source: ABdhPJxRfq6wdntILsJHmFbof6FFct4pObkUBy2konv7U09QxEaNFu/pdEjJgslw78wDYK5Slrgshw3Kgt4opcM+wOs=
X-Received: by 2002:a05:6602:29ca:b0:649:558a:f003 with SMTP id
 z10-20020a05660229ca00b00649558af003mr15090498ioq.160.1651182898015; Thu, 28
 Apr 2022 14:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220428031131.GO29107@merlins.org> <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org> <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org> <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org> <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org> <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org>
In-Reply-To: <20220428214241.GW29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 17:54:46 -0400
Message-ID: <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 5:42 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 04:58:24PM -0400, Josef Bacik wrote:
> > -2 is enoent, it must have committed with the deleted block, which is
> > sort of scary but at this point I'll take it.  Go ahead and do the
> > init-extent-tree.  Thanks,
>
> Same output :(
> Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules
> Failed to find [3700677820416, 168, 53248]
>
> it's the one we just tried to clear, and got enoent on.
> Unless -r 11223 is not the correct value? (not sure where it came from)
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d "3700677820416,168,53248" -r 11223 /dev/mapper/dshelf1
> FS_INFO IS 0x55d8bac70600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55d8bac70600
> Error searching to node -2
>

Oooh I'm stupid, I thought the key it was printing out was the extent
we needed to delete, but it's the extent in the extent tree.  You cut
off the part I need, but that's because I'm printing the leaf when I
don't need to.

I've fixed the output so it should print out something like

[number, 108, number] dumping paths

that's what you want to feed into btrfs-corrupt-block, that should
delete the problematic item and then we can continue.  Thanks,

Josef
