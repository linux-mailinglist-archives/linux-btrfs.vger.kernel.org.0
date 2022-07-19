Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25D157A843
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 22:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiGSUe0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 16:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbiGSUeZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 16:34:25 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D99509EC
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 13:34:24 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 9C1F081222;
        Tue, 19 Jul 2022 16:34:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658262864; bh=b6KoQH4IIjdZXq/Yh+nATHmIIpEaqXrJ5w8J2gJUido=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Jq02ryhjsiTMS9RH28tKO1k7OFSeZOojwxMklMvZn0wvSwHXXk0/cY36fOW2U8XvJ
         /h4dfMhbaf31mZl1dUs6uRizMScSJPObbrOkq1nk7vdcBBcE340ZCrUcTfIAGZaI9k
         kxJBTEs9FTbVMhsP2DxLEq+80bJ2FyitYAdiPt4p7Ql93thoKieyUfwIunqsKf8xeo
         4sspqlC5cYibFxKIQgwqFHGUd7T+JAMi7JH/efxUsl7jmLfBQn7twGDW5VWZRkAGwI
         eBk6uvQEoQK+HWrdBihd63jQWQbdARnQNnXK8I53ZpyJID+WwUiSyyy4RdRdjMvyqJ
         UGzKXsgyT5Psg==
Message-ID: <8088b3c1-6fe6-5a8c-949b-5326d4f8a4ea@dorminy.me>
Date:   Tue, 19 Jul 2022 16:34:22 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] btrfs-progs: support for fs-verity fstests
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1658182042.git.boris@bur.io>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1658182042.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/18/22 18:13, Boris Burkov wrote:
> Adding fstests for fs-verity on btrfs needs some light support from
> btrfs-progs. Specifically, it needs additional device corruption
> features to test corruption detection, and it needs the RO COMPAT flag.
> 
> The first patch defines (u64)-1 as "UNSET_U64"
> The second patch adds corrupting arbitrary regions of item data with -I.
> The third patch adds corrupting holes and prealloc in extent data.
> The fourth patch includes BTRFS_FEATURE_RO_COMPAT_VERITY to ctree.h
> 
> --
> v3: add patch #defining (u64)-1 in btrfs-corrupt-block
>      check item bounds in corruption function
>      improve usage message for new corruption use case
>      add patch with verity ro compat flag
> v2: minor cleanups from rebasing after a year
> 
> Boris Burkov (4):
>    btrfs-corrupt-block: define (u64)-1 as UNSET_U64
>    btrfs-progs: corrupt generic item data with btrfs-corrupt-block
>    btrfs-progs: expand corrupt_file_extent in btrfs-corrupt-block
>    btrfs-progs: add VERITY ro compat flag
> 
>   btrfs-corrupt-block.c | 128 ++++++++++++++++++++++++++++++++++--------
>   kernel-shared/ctree.h |   4 +-
>   2 files changed, 109 insertions(+), 23 deletions(-)
> 
For the series:
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
