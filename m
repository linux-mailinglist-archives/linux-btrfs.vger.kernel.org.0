Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE77AD668
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Sep 2023 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjIYKvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Sep 2023 06:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYKvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Sep 2023 06:51:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A9B8;
        Mon, 25 Sep 2023 03:51:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E19EC433C7;
        Mon, 25 Sep 2023 10:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695639105;
        bh=IqybDoYHMaaCznWJUADBeCM/Vh98fvof8z8k20b79O8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PipXA0OS1BRV2g8afc0ZSlIfOufEi7DsiCWYMT9K67yqv33AL8ObfFaxbHSLw+oRf
         N/wMeUsxDPTUaA06CgiAlMHtgXHqzeJ/YAeA7dua+87tveYmiF9l8zu7FkAJvk4XFD
         UX0s+krwZoClZpuqPwVOp1hnHSWK/YJ3vNtBTly0jMqeo7+kKarkLGGM6vl6TqqN6U
         5oAr03itabYT9G8ZLb6DkSyT+S25WTtutCitnhWKRXkFPZNqpgXz9xODdH3YXnK5/E
         ypZVOd3GgRs9h927NzO/QID5coN03WTK+BidWTqL9YhVcWjZdTrQ39j9bBtTAPLrbe
         0rBqX3CI3R8bQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3a76d882052so3972928b6e.0;
        Mon, 25 Sep 2023 03:51:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YybV6fcKYfzkL9cdHkgAt3+o6zCPl3eADGomUtucKDPNcu/70s0
        iHmcJEq5lS7eXbwyvEFRg9+0bG7FzlYx22NhOpM=
X-Google-Smtp-Source: AGHT+IHztWGKW3WhHCr5FV2XhzTyZzYNVpdyY0dHNmrwprohKQ26AIen7G6Iq4TeUfenEPDIjgT6VSyziqNsIINKhoU=
X-Received: by 2002:a05:6871:78e:b0:1b3:f010:87c2 with SMTP id
 o14-20020a056871078e00b001b3f01087c2mr7282503oap.30.1695639104454; Mon, 25
 Sep 2023 03:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230925043359.2765806-1-naohiro.aota@wdc.com>
In-Reply-To: <20230925043359.2765806-1-naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 25 Sep 2023 11:51:08 +0100
X-Gmail-Original-Message-ID: <CAL3q7H68Doncz4_FcG-2zDnjRO6_ML4-Ucmv3sRrWTeZAJuFXw@mail.gmail.com>
Message-ID: <CAL3q7H68Doncz4_FcG-2zDnjRO6_ML4-Ucmv3sRrWTeZAJuFXw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/076: fix file_size variable
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 25, 2023 at 5:34=E2=80=AFAM Naohiro Aota <naohiro.aota@wdc.com>=
 wrote:
>
> The file size written below is 10 MB, but the variable is set to 1 MB. Fi=
x
> it, or the test will fail.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Ok, so this means that v3 of the recent patch:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-next=
&id=3Df4c7dbbb4f166996d8fefdebbceacd2f7d359dee

was completely untested and now the test always fails. Too bad.

Thanks for the fix.

> ---
>  tests/btrfs/076 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/076 b/tests/btrfs/076
> index 23f9bd534a0a..894a1ac7fa5d 100755
> --- a/tests/btrfs/076
> +++ b/tests/btrfs/076
> @@ -37,7 +37,7 @@ if _scratch_btrfs_is_zoned; then
>                 max_extent_size=3D$(( $zone_append_max / 4096 * 4096 ))
>         fi
>  fi
> -file_size=3D$(( 1 * 1024 * 1024 ))
> +file_size=3D$(( 10 * 1024 * 1024 ))
>  expect=3D$(( (file_size + max_extent_size - 1) / max_extent_size ))
>
>  _scratch_mkfs >> $seqres.full 2>&1
> --
> 2.42.0
>
