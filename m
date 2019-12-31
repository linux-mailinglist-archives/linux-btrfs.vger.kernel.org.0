Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F812D6EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Dec 2019 09:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbfLaIFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Dec 2019 03:05:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:55371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfLaIFP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Dec 2019 03:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577779508;
        bh=urbtCO0mOEIAxMwJXxlfLePJyEfJJ1HZ5uE2r//FHIA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=kU4rGHlejfWz/apQOpVX8kXmyuUlrrfAemuXTr03ubx0JNOeN38H+rko6QzZDht7B
         lApGuPXf1GXcdWs9EXfSaTo2nSQh43GHFgmjbP7zm5h/FFkIofEfRMidnu0/hEk289
         odALAwmOBou8j+xq/Fh9B/tXb0RyVHdgMz4nKxEE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.182] ([104.199.231.176]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XPn-1jqBAQ2xbV-014PJb; Tue, 31
 Dec 2019 09:05:08 +0100
Subject: Re: [PATCH 0/5] btrfs-progs: Bad extent item generation related bug
 fixes
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20191231071220.32935-1-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <5a8af1ab-1bca-465b-7c39-6b1dc3a63cf1@gmx.com>
Date:   Tue, 31 Dec 2019 16:05:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191231071220.32935-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gGtQmCmNWXU6DnTaVqY50fTkxtdhpQ6ql0CC33XpPFsZQZBCILW
 poL+DtB1cqXqtM569JY6nb2UaeEETLaj3AD3QyQMHVf/Sj6v4Io7dqYl7Pu/Eoj92ay1clu
 J8QpXIly8VQBsN4+ZsRMM7d5d/lcyKdsV7nVuyM2/GJe0kEdBlsEAQOAkdtayja/+0LKz2s
 HTeFHBT8R3HYd7t+zcIwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ucOhTVOCEOc=:QK3lRg/2y14lsFqQvQmXCa
 5nrpnAsO+stHQg0NkhrqMcfiZ9yohCuEorVNxEBUE1BBolr/DI9Ddmf0s97eqXJLL8N39RtFa
 f23+YdaLGLyiFdaOV1wrOjWlZ2kj2gaJMqQpHj9PweIjXM74ujqBPJGTJE3gpw4ZGTPz5l90z
 +ObS00QHovaF1A+dq7ykRZia2+g5q4Z//yRuBbIpLEn2VUx0s50NqE7W1ox8RyRYtZprvSwxq
 Is2gq5hoFcDBIhIGmhpVQSrk0EhSwsKg97dOhugfrV8JOLrdPP6z71i6n6CKsOl55Zw2HJadJ
 J0AmofP6DfvtnWS4GwzpEkmQ9ZCpxj3dOZ28RRvKIGaIvrttgQ0FxCU2/rQtM0zsMdQqQKlrw
 UJRkazKiXHtCJkdIuZn218jr8haFhhzisOMBJLKq/aGN80z5fGCKtAecZF738kwEFv8qSFCiU
 XsfHAA7/YOm8ucSocmdajgdoQkDGcOWSfLQRDh0/r//E7f3CSkmf0E4loDnzqTwTAwLxrstfe
 xvfZaaNp4cJXHmMUYDTjgFxphNPQcrERmSMkzyw+46rej1u6RWM3CKJci3GmXz8XkL3qJ5tNs
 bawulqphlby6zt7wWSQat5j4LPBWuTK9D7JcEkN0bI57EUutyEz7+AAA397GkpaenRx/6LxvG
 PUz/KFnU4ssH4z2GK2Xidv2RhLu3BrH8UZ9d3At+1Kwgy6JVMxy31rngO3BoUKPuAi1t2HnsL
 yVloi93IxNC/DzDpz8E7U4+GtHNoTthdny/5GtRoQONz3kcG0JG2lWZjSbNnPPVctvDf9HUPV
 9N9n+EV/i7rUcPmB+ASVmUB3++/iNRYFetO6J/ARswKkWf3ButU2jDkrEur19px25Yb7lXbVW
 Rsr+S2KUQwyRAgrUQHsXCqZSnY2G+zL4x05kqkehaM13j00nMdmto6bP5u2SvpDHHDs8iDkJi
 n8a2fWSVIv3+N2hNHgxNfJCT2gKrOqg5FLllXJniFgHmVySbyHHRCKtU5hMosfRu0s6tQtwIb
 okchTEwbKsEuak/1UWUgcPftH2U5kOievQbo7Mm+QLU0MTELk+ugItuI3VTItowlFoJAOcsey
 1VMss+OYsXstqsrOw7snocDplbAuV9DYX2vPvafsFdCFQqfTE02fKZ7iFv8nxDiiLfOIskN9M
 xyIZh374xFVwXkOGH9JGhMF6PncDtr+x4iwGoxTwim3K7mKfWZ3SGs2Q/huaTDEmvIiTn61lu
 U97i+4K2nuoZyCcmFtJrIWpoo+TMW8WrjoJ51sj7h0Bbw8mAClST89c89q9o=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/12/31 3:12 PM, Qu Wenruo wrote:
> There is an issue reported in github, where an fs get corrupted
> extent tree initialy, then I recommended --init-extent-tree.
>
> Although --init-extent-tree indeed fixed the original problem, it caused
> new problems, quite a lot of EXTENT_ITEMs now get bad generation number,
> which failed to mount with v5.4.
>
> The problem turns out to be a bug in backref repair code, which doesn't
> initialize extent_record::generation, causing garbage in EXTENT_ITEMs.
>
> This patch will:
> - Fix the problem
>    Patch 1
>
> - Enhance EXTENT_ITEM generation repair
>    Patch 2
>
> - Make `btrfs check` able to detect such bad generation
>    Patch 3~4
>
> - Add new test case for above ability
>    Patch 5
>
> Qu Wenruo (5):
>    btrfs-progs: check: Initialize extent_record::generation member
>    btrfs-progs: check: Populate extent generation correctly for data
>      extents
>    btrfs-progs: check/lowmem: Detect invalid EXTENT_ITEM and EXTENT_DATA
>      generation
>    btrfs-progs: check/original: Detect invalid extent generation
>    btrfs-progs: fsck-tests: Make sure btrfs check can detect bad extent
>      item generation
>

Nice fixes.

Reviewed-by: Su Yue <Damenly_Su@gmx.com>

>   check/main.c                                  |  36 ++++++++++++++----
>   check/mode-lowmem.c                           |  19 +++++++++
>   .../bad_extent_item_gen.img.xz                | Bin 0 -> 1916 bytes
>   .../test.sh                                   |  19 +++++++++
>   4 files changed, 67 insertions(+), 7 deletions(-)
>   create mode 100644 tests/fsck-tests/044-invalid-extent-item-generation=
/bad_extent_item_gen.img.xz
>   create mode 100755 tests/fsck-tests/044-invalid-extent-item-generation=
/test.sh
>

