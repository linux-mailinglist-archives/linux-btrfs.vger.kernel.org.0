Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B4E6A0E4A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 18:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBWRB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 12:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBWRBz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 12:01:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68217305CB;
        Thu, 23 Feb 2023 09:01:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19245B81AAA;
        Thu, 23 Feb 2023 17:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D7CC433EF;
        Thu, 23 Feb 2023 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677171711;
        bh=d16C2HRm0LYB8LJaGTRd5wyQ2UdE7g8S2a2pCgz2p08=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mBny6NombNGnytlOMhYg2Hi5GCs6lgdcSy/+XWEoT70lyQOKteU6B0VTNlIuo3kK1
         kUyY6KFo/EhttK6gTURtzkNUJzQRpHRXuQ6GTK2yqdE/n4zDUKIg98uWNFEhlYKkkc
         RBLy9dR3tYRJbWcNv/G//5pmG7kwP0su9OvliY6w+zKuA0q1HPV/MnXTN2VHLXlv7F
         FeP6QMXrQqAyP5taDZwSpgG9EUZ9YVkSMABDpRNLxAFONPGUQFJmiftYiVXCwRuONj
         QrBMqA8vv6WQJ8V/cqU6JnI+sz6SsxS+qrFVd7tW4IbYGgOF4oEuGxdN75kzr+lLms
         Kzc68h45uNS2w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-172094e10e3so16192369fac.10;
        Thu, 23 Feb 2023 09:01:51 -0800 (PST)
X-Gm-Message-State: AO0yUKVIGMXxEMLC1HHPRk6hYFVNBo2AKpsbc7jPM8YytQO3VOv2GSU+
        Pj8Wyp9kXCB4wlOUr+wyWiZE7DVpZqsOsKglVSY=
X-Google-Smtp-Source: AK7set8tz3y/2qGykd+tlK0pPm88engMzoreGzKC4v9AnSdV9J6psFYyAa99mK+28YtZNOsRLGA3FBr30ppx9ee5s8A=
X-Received: by 2002:a05:6870:d248:b0:16e:11dc:2513 with SMTP id
 h8-20020a056870d24800b0016e11dc2513mr2616930oac.98.1677171710793; Thu, 23 Feb
 2023 09:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20230223154035.296702-1-johannes.thumshirn@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 23 Feb 2023 17:01:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4gkVfb03+SB6-FzxFH+6aVu2MUM9ZTRVhYi_8d7m4+ig@mail.gmail.com>
Message-ID: <CAL3q7H4gkVfb03+SB6-FzxFH+6aVu2MUM9ZTRVhYi_8d7m4+ig@mail.gmail.com>
Subject: Re: [PATCH] common/rc: don't clear superblock for zoned scratch pools
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 23, 2023 at 3:56 PM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> _require_scratch_dev_pool() zeros the first 100 sectors of each device to
> clear eventual remains of older filesystems.
>
> On zoned devices this creates all sorts of problems, so just skip the
> clearing there.

What kind of problems? Can you give 1 or 2 examples at least?
And it would be nice to comment in the code why we don't zero the
sectors for zoned devices.

Thanks.

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/common/rc b/common/rc
> index 654730b21ead..d763501be2b2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3461,7 +3461,9 @@ _require_scratch_dev_pool()
>                 fi
>                 # to help better debug when something fails, we remove
>                 # traces of previous btrfs FS on the dev.
> -               dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +               if [ "`_zone_type "$i"`" = "none" ]; then
> +                       dd if=/dev/zero of=$i bs=4096 count=100 > /dev/null 2>&1
> +               fi
>         done
>  }
>
> --
> 2.39.1
>
