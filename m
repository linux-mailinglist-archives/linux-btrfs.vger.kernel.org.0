Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B65AA1B9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 23:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiIAVuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIAVt6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 17:49:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C11A38F
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662068989;
        bh=BYsQGsKLX4hzxflw2DNxVqpVqpbLASze476DuvApGUc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Kr3B6OtczM7P5dG04ZtnKw9q8EkRqaqWdctYMUdUnFVsz/8g2a3M1OJhZGWcMBRC9
         cLXOJq4UMEsLZEPEAE9C8VASfvziLv0LcNkd5CFR6YjY1ZdXIZacwf+Ddj/TrjAAGz
         AmjbIIJkvfjPp8gueuBKxpWX6R+yEMivyVjLhmdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQTF-1pLhft3zev-00sP1k; Thu, 01
 Sep 2022 23:49:49 +0200
Message-ID: <b403daba-c615-282c-487e-ef174197c9ef@gmx.com>
Date:   Fri, 2 Sep 2022 05:49:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 01/10] btrfs: allow hole and data seeking to be
 interruptible
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <29ac2c59860774abb16bfb2660e0dd831d793cf5.1662022922.git.fdmanana@suse.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <29ac2c59860774abb16bfb2660e0dd831d793cf5.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwG/Ov7LzXAGbZAxs9bWT1EgCorwARR7TEWOPS1PHn6Jt6pFaWU
 wiCARu5giiIymasON7DfTnsZ6pDgZiLpFiOx+ZHiizSoNYIwSzH9Uj9JPx7Ubdgmtle7mTY
 Q7WSL5fjYcpkjGWUK/5zOc/MxDhNqvQKNeAUdRHGzXqDoIUy/lpI7EhnoPJ3vZy4aUyl4hF
 b++Zy0FOEc6YcztvJTubQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ts/oijMPw2Q=:tmKV3aJ6Ur+URjV4Q/mC+s
 WwDMeOTsDPi0vqudmQboj+yS0CeqslqjkVTSZUEzn7exqL8yue5cot17psyIrlRQkpUQ6c6Kw
 xvxXqCSsRIeXiXNYKSfnZrwf7unv89geRvgX1I9gpyXlBnDCynov0QyZvRlUekcW7euUpXx5M
 XbelfA3R9uqT+p+m+b9ewB7nuY0yO2ig4upLgg0eO7f798PAp6BzJsx3EBSwhwmFpsUskAJNS
 ecbcQ3l2bgGDUdgDAhu+Tigt7F/wOAZXcJPxlI/BVT+CJDbnSv/7m1v9jeo4sthMsFT+pZy1z
 IAaiZADj9opnPkxC/lO0l2zfHww7v6YLC99Dwqj7GMEPStLGTEYtaM5IS743yine9k+GojJFq
 4ese2LtRyT9hKZUTHOP7jSr+bziI3QVGU6ZAKx4L3u4YBQZCA7r1d+MSKWrO6s6KFin/NXL98
 Kla6WcH2uc2YQTjgEH8nZGr4ysQ4XhCSWkLf41cw3NezT0YJQvU8A+doNbDXzj3lO5pz4UwGF
 8MELB5lHqpzepO8XajO8QxhBl4RUZYWEE/9+GukfnOOrQy7mFUJElXgj3UDJPHGgmK4WZXeM3
 /mGfLGQ+CCEdsBDyXgHh/KafRgG/jM+aQ7h4n34j9/ornOatfBXJvatDpWietaOydaDlAmEE8
 i+2bOfk6YcsZxRNg7QwkQrkYPMtevwHuaJ21BYeW3eRWOOjA6H7+DtptEZAngXeN81fA4sqor
 yJ4sN8B3O3ulAOjCHRDqwgItYjJ8LL3EPrn9Ua8JUXGvA4CGJTT5PCM64VMU055l/1/5w+SSc
 C7msQZDhUKwAaO5KZTN9B7NLLDxhF+SYJwNRhW6TYNQ9DSra0iPmJ0DIiAEnPOIJDWKiw2YWM
 U0DoLJMpIvC4QWOs2c+q2xqjqrMIreKONmPcEhvhFnQ4hMZbpi/5FDfbesArWhy3zMHaVXXkT
 Ubxi1anQv3Mv60f/P2ue5qgXvlXvoONmx64qUWHd7faBPOtVavDMnW4G5dggrB/GhSX39LMVq
 LXywTQq/KmuVGcvzcO/wTgKFHIIaNyZotyIDYuIeZwoR9gCDtG7mRcspNDI/e9yO5EYjicWhV
 obMjssJZPniTf+1wNbQYNXdWDMN/PCIpzeKA41OJ9I1qWEkLAN3qrlevNQjigkfi5Ong6pbPX
 IFvS5LiQ+EYYekTndBXlIJ3K9d
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Doing hole or data seeking on a file with a very large number of extents
> can take a long time, and we have reports of it being too slow (such as
> at LSFMM from 2017, see the Link below). So make it interruptible.
>
> Link: https://lwn.net/Articles/718805/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/file.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0a76ae8b8e96..96f444ad0951 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3652,6 +3652,10 @@ static loff_t find_desired_extent(struct btrfs_in=
ode *inode, loff_t offset,
>   		start =3D em->start + em->len;
>   		free_extent_map(em);
>   		em =3D NULL;
> +		if (fatal_signal_pending(current)) {
> +			ret =3D -EINTR;
> +			break;
> +		}
>   		cond_resched();
>   	}
>   	free_extent_map(em);
