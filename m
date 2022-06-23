Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4560F557726
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiFWJxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 05:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiFWJw7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 05:52:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705B3120B5
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655977974;
        bh=k3OZu/X/YFKLL28XDEs9Z8vOfv9gPJFncqCX7247ZAg=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fOHaz0cm+i3fuOhaPANLd91fWZZKOzcbT9vMCllEdyaoKD42TfRxlYj2GmteLubH3
         b4g9Ewx2ldvLLIOXipkNScnxVf8m7S8FsrKWyayAGf2S2csL4cgG7+j0FOardiRw5Q
         +Fju4trSNfAHtD5BhxkGX3nSSxyUzpaySdhvGA8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1oOBor20YS-00Jt9u; Thu, 23
 Jun 2022 11:52:54 +0200
Message-ID: <207c3f84-7a6c-bc61-d8ca-083ee29fa8ba@gmx.com>
Date:   Thu, 23 Jun 2022 17:52:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: remove skinny extent verbose message
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220623080858.1433010-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220623080858.1433010-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5xceM+Oo88w/srlD1arbfzFdXx6eXsoDZR6XLynogkQ2ovnvWUZ
 Nu593/q7SNUw9LZ3QQkCPgjsnShtAEyhBp3iMscIjfo967Y4cgXGVO7/WCYIV4Adiv2irfF
 MZFNuFXf5uI/Ay3m2222x3xKtxV8oCogReXGZ5dFTdXSl8jqsbDCSVd/dh7giIzcYg242Ap
 AX6oIJJMHsn3Cey+6tE5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zbNKdxRmmcc=:m0XXx+XQAzC6RK861Hmkm5
 u3IOetpQ1lrmBu+9tUM5k2Ia9paMJBCRm9TialWBwLeSEotl4l2ZjMkQ4bT9/f6DTFjgqhIQt
 GE1mc+cqIskl8TBK6fEAzIIyw3QUbLhYhN1iC7CQGjIRXd2ppYGkkxtPeOc7c9NIbnySGTF/b
 ng/4AmdbJvbms0GWEqAyUrZNc5tRt9wq+jgA0aPjcJo68UJZTPj5el8VakgX+W3wJzxGNAiTV
 Gbw7ww2mjWGaNeyL5PNDMX3P3Tyo9feqRD5rXeDD3iaCYJyvSDaRJnrV5Z1V1XyHx3/ZYd5gi
 QACi4yNgHvnAo34S/0ww7RrOyyTGLUYSgmu6O3S8NEX0W7rLpSAfWiGbQY2jX0yrvONLVR5a5
 MZDuziIEdS+6zi+S1m4bzJHc4WgGC5dR948V6MPR5NBttm6jt+63z1nHQ/Cv0EcHaSZPPTsAF
 15uxCXtXUNBTMEixzWMQJ2KpmPrZFAct0NETBc/ja98ceoZlYcZfTnF9JdR+3veawG3Wy9qLw
 e1wYtIivdT+PxUEf7vSb4VrvGXfb+6cbR/6jm1voUeBEVq+5mS+x5GKJOLXgq3fFtV4r4Voni
 PoxMAXuTSlWCiGeuttTDxeBc8kEp+7orBkMYGFFnEIC65FJzL4yk84n7Ihnxuwy0UwdZLQwPa
 J28H0DwXkNYqvbEfIwd3XdM5WtUZQe4YFC1AbYNIHz8sc5hGgpkMy1TQwrS0icI0iZuPTIqO4
 96WRE+n1WVb/xgXW0UtoSAJ8G8rqkPooYZpj29rXNCasLHjayfBOLobkrybgjM6xN/YvRoUc4
 DBkHd1Ov3BSlfq7Bo3mxhkhY+67Mo6LCKthDN4vmdD40agdCCa5C8Px/vq56eRdh0zuNoPvxQ
 BZWUeujqCoQmRRqDhbpu3l8BVEGzxWdp9kh1tgebRB6D729h44BkdkUO7OruNcFwjaMHJjChg
 crR4+S9IKAUwV8EjOKVyWNIxNRhOjheTj5vjcIpfLMLEqZHbO7GQCQWALqdYPqMYu+ASIoThw
 4glZQUD1hCoZfhEndNO+YjgWSCbB9B69pOlMq5F80CpDGJmQ8Us9aNvHNpEOLxqD6Gzbqjw6D
 Xl/9FspC927wEdbxKPVJpktWuHZpL0Yuqfg80M2YikrHLpa0RYI75gPzg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/23 16:08, Nikolay Borisov wrote:
> Skinny extents have been a default mkfs feature since version 3.18 i
> (introduced in btrfs-progs commit 6715de04d9a7 ("btrfs-progs: mkfs:
> make skinny-metadata default") ). It really doesn't bring any value to
> users to simply remove it.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8c34d08e3c64..0af4c03279df 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3501,9 +3501,6 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>   	else if (fs_info->compress_type =3D=3D BTRFS_COMPRESS_ZSTD)
>   		features |=3D BTRFS_FEATURE_INCOMPAT_COMPRESS_ZSTD;
>
> -	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
> -		btrfs_info(fs_info, "has skinny extents");
> -
>   	/*
>   	 * Flag our filesystem as having big metadata blocks if they are bigg=
er
>   	 * than the page size.
