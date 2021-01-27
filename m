Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BC30575A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 10:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhA0Jtv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 04:49:51 -0500
Received: from mout.gmx.net ([212.227.17.21]:48661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234742AbhA0JsY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 04:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611740796;
        bh=/v3JfsKDq3K17fM5XuYkGVKInvAlWtx1vUeh3eUqJYA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LuWg/pZyVPEQ0Ve1NKJ8qYNymVUPkM3/tsr1LTiS2OVzJkeno0wI2/UsOA/3l4wkP
         m34O8UOy89toUnE0pAzcFCB3GN59nyq2p95EsXgwEBDWXwljF6/14b8GDiaw2bIuxh
         yINqDxE+eu4oXhR4z41Qqjy6UgpWnYb79WWNSxKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mt79F-1lxdXW1X1F-00tRf8; Wed, 27
 Jan 2021 10:46:35 +0100
Subject: Re: [PATCH] fs: btrfs: Select SHA256 in Kconfig
To:     matthias.bgg@kernel.org, Qu Wenruo <wqu@suse.com>,
        Marek Behun <marek.behun@nic.cz>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20210127094231.11740-1-matthias.bgg@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2e1865ff-af6e-feec-a224-2364dbb80a0c@gmx.com>
Date:   Wed, 27 Jan 2021 17:46:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127094231.11740-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PYXwCd6ZYs03KiysJMzHv3zWc4juz8J908M0TCTtUI/6GuY2R3Y
 62NUjduyy2vidiMWEQKem0r1UA5cJV1uW9W3y8hCZt7fV6jiNAHSpy8xs9G6zywRbYBolfI
 nJ5/CwWMdBIOfMXH/f2mA3nQ371aqFhRtg8OuELFD9XqxQMx+rHbWhY5W/Y8yKfXxUYLPp5
 vhtj8MJpWT6zvr/mXyYeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ie2M+hVmAY=:zUzAil4G68aEEUY2aoyQ0g
 DLdVKUl4vFmjg4JVKcCtpo5+BGWe7CE7hkEEbWi6bn3X1iY1wsbpx01gfAWfkgqZ+3YjKhJ9X
 HxMcLGuGn5DQQ1zEuxT0+lsSRh6dGEdWkTnz6fd2lCeFZYzSv9OeLbBj7W1ORYqTIIBV+n+Hx
 8frFcVf8VyJVj4UT3an1ilH9Ilbu3bNdwBoDxfZerQkiLn7RK7A/+G3rlBjYawkj/ztuQ1pZp
 rkS98E4bVBJ40/k/abg6hICfcwJ70RROWdCmH1xmins+wHAv9uuUAWXl4f7lqla7/NAExf51/
 d7Z5PvPf2hUS/AUkRtVclyS8RMdDOKHscxmuzIwC0R4Jo4q6DLPVmGABjcah12RaR2DpHhu0O
 imEWeFj3GhFZ5BImc46C8kziDQ8IJTFN//QKPGZHCxcvdM8hcBcEhsg48mib5/iHUZxhbQk5N
 223exMtqbql5NZGWgktIPCoVFRESoCNvQwk5c3BErguCp7mw2Dz9Ap6BJg2T/6keHpR8YZnCf
 lJk8i6lGQPU9HbFXu6AxVUuB84+fM6gNkr4hZL3FkRUm9IORYhnRc9OpmtRLY6OajDgnbsg/u
 dq3sJnplecjbRm3IcL0FMZaVt66I5ZGjkqKJHseqT9Xq4QK4sllHPtMEEZZvun6cv+ScgTGKy
 R8A+c3iGNxFVp7BcP4/z+OixUpLftfNCchL/sgQ1xlDnb0m3MZO+g0hj32kDfOFmCPSPBnufR
 aiFU12Ms1cqBLjs1jzBAghtzSySDUy0EEtRZD+i0uPM257xoNIdf6CG7Pa8Jv5pFv811nVl8T
 WZVKlc+rxTvsk4QzOzyeoGJnqxtOPqNtRu/uiyWsT1o4yR/x50Eb4ck+0uy1D6ZbckXCmhMxM
 j/Y9tsgscYnidmm0rRUg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/27 =E4=B8=8B=E5=8D=885:42, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
>
> Since commit 565a4147d17a ("fs: btrfs: Add more checksum algorithms")
> btrfs uses the sha256 checksum algorithm. But Kconfig lacks to select
> it. This leads to compilation errors:
> fs/built-in.o: In function `hash_sha256':
> fs/btrfs/crypto/hash.c:25: undefined reference to `sha256_starts'
> fs/btrfs/crypto/hash.c:26: undefined reference to `sha256_update'
> fs/btrfs/crypto/hash.c:27: undefined reference to `sha256_finish'
>
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

Oh, forgot to select sha256.

Thanks for the fix.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> ---
>
>   fs/btrfs/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index f302b1fbef..2a32f42ad1 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -4,6 +4,7 @@ config FS_BTRFS
>   	select LZO
>   	select ZSTD
>   	select RBTREE
> +	select SHA256
>   	help
>   	  This provides a single-device read-only BTRFS support. BTRFS is a
>   	  next-generation Linux file system based on the copy-on-write
>
