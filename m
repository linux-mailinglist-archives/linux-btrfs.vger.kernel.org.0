Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567B258CF2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 12:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgIAKnS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 06:43:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40506 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAKnN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Sep 2020 06:43:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33624ACC5;
        Tue,  1 Sep 2020 10:42:45 +0000 (UTC)
Subject: Re: [PATCH] btrfs: add test for free space tree remounts
To:     Boris Burkov <boris@bur.io>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <2c9c22c45c2a0876239cdb1290e62e1266160768.1598915077.git.boris@bur.io>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABzSJOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuZGU+wsF4BBMBAgAiBQJYijkSAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRBxvoJG5T8oV/B6D/9a8EcRPdHg8uLEPywuJR8URwXzkofT5bZE
 IfGF0Z+Lt2ADe+nLOXrwKsamhweUFAvwEUxxnndovRLPOpWerTOAl47lxad08080jXnGfYFS
 Dc+ew7C3SFI4tFFHln8Y22Q9075saZ2yQS1ywJy+TFPADIprAZXnPbbbNbGtJLoq0LTiESnD
 w/SUC6sfikYwGRS94Dc9qO4nWyEvBK3Ql8NkoY0Sjky3B0vL572Gq0ytILDDGYuZVo4alUs8
 LeXS5ukoZIw1QYXVstDJQnYjFxYgoQ5uGVi4t7FsFM/6ykYDzbIPNOx49Rbh9W4uKsLVhTzG
 BDTzdvX4ARl9La2kCQIjjWRg+XGuBM5rxT/NaTS78PXjhqWNYlGc5OhO0l8e5DIS2tXwYMDY
 LuHYNkkpMFksBslldvNttSNei7xr5VwjVqW4vASk2Aak5AleXZS+xIq2FADPS/XSgIaepyTV
 tkfnyreep1pk09cjfXY4A7qpEFwazCRZg9LLvYVc2M2eFQHDMtXsH59nOMstXx2OtNMcx5p8
 0a5FHXE/HoXz3p9bD0uIUq6p04VYOHsMasHqHPbsMAq9V2OCytJQPWwe46bBjYZCOwG0+x58
 fBFreP/NiJNeTQPOa6FoxLOLXMuVtpbcXIqKQDoEte9aMpoj9L24f60G4q+pL/54ql2VRscK
 d87BTQRYigc+ARAAyJSq9EFk28++SLfg791xOh28tLI6Yr8wwEOvM3wKeTfTZd+caVb9gBBy
 wxYhIopKlK1zq2YP7ZjTP1aPJGoWvcQZ8fVFdK/1nW+Z8/NTjaOx1mfrrtTGtFxVBdSCgqBB
 jHTnlDYV1R5plJqK+ggEP1a0mr/rpQ9dFGvgf/5jkVpRnH6BY0aYFPprRL8ZCcdv2DeeicOO
 YMobD5g7g/poQzHLLeT0+y1qiLIFefNABLN06Lf0GBZC5l8hCM3Rpb4ObyQ4B9PmL/KTn2FV
 Xq/c0scGMdXD2QeWLePC+yLMhf1fZby1vVJ59pXGq+o7XXfYA7xX0JsTUNxVPx/MgK8aLjYW
 hX+TRA4bCr4uYt/S3ThDRywSX6Hr1lyp4FJBwgyb8iv42it8KvoeOsHqVbuCIGRCXqGGiaeX
 Wa0M/oxN1vJjMSIEVzBAPi16tztL/wQtFHJtZAdCnuzFAz8ue6GzvsyBj97pzkBVacwp3/Mw
 qbiu7sDz7yB0d7J2tFBJYNpVt/Lce6nQhrvon0VqiWeMHxgtQ4k92Eja9u80JDaKnHDdjdwq
 FUikZirB28UiLPQV6PvCckgIiukmz/5ctAfKpyYRGfez+JbAGl6iCvHYt/wAZ7Oqe/3Cirs5
 KhaXBcMmJR1qo8QH8eYZ+qhFE3bSPH446+5oEw8A9v5oonKV7zMAEQEAAcLBXwQYAQIACQUC
 WIoHPgIbDAAKCRBxvoJG5T8oV1pyD/4zdXdOL0lhkSIjJWGqz7Idvo0wjVHSSQCbOwZDWNTN
 JBTP0BUxHpPu/Z8gRNNP9/k6i63T4eL1xjy4umTwJaej1X15H8Hsh+zakADyWHadbjcUXCkg
 OJK4NsfqhMuaIYIHbToi9K5pAKnV953xTrK6oYVyd/Rmkmb+wgsbYQJ0Ur1Ficwhp6qU1CaJ
 mJwFjaWaVgUERoxcejL4ruds66LM9Z1Qqgoer62ZneID6ovmzpCWbi2sfbz98+kW46aA/w8r
 7sulgs1KXWhBSv5aWqKU8C4twKjlV2XsztUUsyrjHFj91j31pnHRklBgXHTD/pSRsN0UvM26
 lPs0g3ryVlG5wiZ9+JbI3sKMfbdfdOeLxtL25ujs443rw1s/PVghphoeadVAKMPINeRCgoJH
 zZV/2Z/myWPRWWl/79amy/9MfxffZqO9rfugRBORY0ywPHLDdo9Kmzoxoxp9w3uTrTLZaT9M
 KIuxEcV8wcVjr+Wr9zRl06waOCkgrQbTPp631hToxo+4rA1jiQF2M80HAet65ytBVR2pFGZF
 zGYYLqiG+mpUZ+FPjxk9kpkRYz61mTLSY7tuFljExfJWMGfgSg1OxfLV631jV1TcdUnx+h3l
 Sqs2vMhAVt14zT8mpIuu2VNxcontxgVr1kzYA/tQg32fVRbGr449j1gw57BV9i0vww==
Message-ID: <61d279c1-1e2d-a59d-c14b-339ea859549b@suse.com>
Date:   Tue, 1 Sep 2020 13:42:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c9c22c45c2a0876239cdb1290e62e1266160768.1598915077.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1.09.20 г. 2:05 ч., Boris Burkov wrote:
> btrfs/131 covers a solid variety of free space tree scenarios, but it
> does not cover remount scenarios. We are adding remount support for read
> only btrfs filesystems to move to the free space tree, so add a few test
> cases covering that workflow as well. Refactor out some common free
> space tree code from btrfs/131 into common/btrfs.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Overall looks good, for a couple of minor cleanup suggestions see below.
Still:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  common/btrfs        | 12 +++++++++
>  tests/btrfs/131     | 29 +++++++-------------
>  tests/btrfs/219     | 65 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/219.out |  9 +++++++
>  tests/btrfs/group   |  1 +
>  5 files changed, 96 insertions(+), 20 deletions(-)
>  create mode 100755 tests/btrfs/219
>  create mode 100644 tests/btrfs/219.out
> 
> diff --git a/common/btrfs b/common/btrfs
> index 6d452d4d..9517c0a4 100644
> --- a/common/btrfs
> +++ b/common/btrfs

<snip>

> diff --git a/tests/btrfs/131 b/tests/btrfs/131
> index 3de7eef8..93ff59f4 100755
> --- a/tests/btrfs/131
> +++ b/tests/btrfs/131
> @@ -52,17 +52,6 @@ mkfs_v2()
>  	_scratch_unmount

<snip>


>  # success, all done
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> new file mode 100755
> index 00000000..1b889b78
> --- /dev/null
> +++ b/tests/btrfs/219
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 219
> +#
> +# Test free space tree remount scenarios.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"

<snip>
\
> +# Remount:
> +# -o space_cache=v1; -o remount,space_cache=v2: error
> +# -o space_cache=v1,ro; -o remount,space_cache=v2: success
> +echo "Trying to remount with free space tree"
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount -o clear_cache,space_cache=v1
> +_btrfs_free_space_tree_enabled
> +_try_scratch_mount -o remount,space_cache=v2 >/dev/null 2>&1 || echo "remount failed"

nit: _scratch_remount space_cache=v2 || echo "remount failed"

it will save you typing "-o remount" ;D

> +_scratch_unmount
> +
> +echo "Remount read only fs with free space tree"
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount -o clear_cache,space_cache=v1
> +_btrfs_free_space_tree_enabled
> +_scratch_mount -o remount,ro,space_cache=v1

ditto

> +_btrfs_free_space_tree_enabled
> +_scratch_mount -o remount,space_cache=v2

ditto

> +_btrfs_free_space_tree_enabled
> +# ensure the free space tree is sticky across reboot
> +_scratch_unmount
> +_scratch_mount

_scratch_cycle_mount

> +_btrfs_free_space_tree_enabled
> +_scratch_unmount
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
> new file mode 100644
> index 00000000..0b22e258
> --- /dev/null
> +++ b/tests/btrfs/219.out
> @@ -0,0 +1,9 @@
> +QA output created by 219
> +Trying to remount with free space tree
> +free space tree is disabled
> +remount failed
> +Remount read only fs with free space tree
> +free space tree is disabled
> +free space tree is disabled
> +free space tree is enabled
> +free space tree is enabled
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 3295856d..f4dbfafb 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -221,3 +221,4 @@
>  216 auto quick seed
>  217 auto quick trim dangerous
>  218 auto quick volume
> +219 auto quick
> 
