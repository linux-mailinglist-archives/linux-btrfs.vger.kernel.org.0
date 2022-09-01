Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DDB5AA317
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbiIAWba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 18:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiIAWbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 18:31:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813301AF0B
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662071409;
        bh=pcc2m/GRmUlExILZSCWBaD34UiG6V4kPbYrU6T4J+HU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=De6dQDDcTmEiW4ecTKJrhSD32A7sJR7MXQ3rTQENSqQ78DkXcJwKq8VWCUeLv43v7
         eY7qiBo+LEix/vOCmjusgPqkJdrAtPQYbcfkdoc427YwLN9M3D3SsCO08MWCku9nii
         a/nr4Lwidpvxv80vQDLCIoFPmWs6clGa+4sdZkhg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1pAbHW1tG9-00q9o8; Fri, 02
 Sep 2022 00:24:48 +0200
Message-ID: <af276eba-1355-6ca8-0c62-33e94e133f47@gmx.com>
Date:   Fri, 2 Sep 2022 06:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 04/10] btrfs: remove zero length check when entering
 fiemap
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1662022922.git.fdmanana@suse.com>
 <4d19dc86c76af6e7ca8577e7d3fdf5a319a7357d.1662022922.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <4d19dc86c76af6e7ca8577e7d3fdf5a319a7357d.1662022922.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rsMD8JqwF9X2KjBxmVUh8dRFRJ0MF6GC1f7BcE6acJ/76ne/Zbo
 iAOLhD4l0W8H3HzwhEyOj4+yqiaqhbur1O3BxSH6/xCPRolv/Nxg9fiMTH/cuf4I+/9peRM
 uZOCKrqq907DC4HCsAEssWZXrUzi+G+GROIwgVz2wVmHStqrwE3Q5NRUYZLKdRIgVSpa3n0
 nr2c8J+r099apHMGXalyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FdF7iWDFPu0=:VpOhM/QpXmy2qtHzDLDro/
 YG4ErxVTjhhsK/8nosvq1pz+dDWdYYRVXJDhLAlEYOBwzPB2qlmfVPMRRcexY1ztZaI8mJuXZ
 56PDhDjJbE19v/27+4TPfv6eBPl1lSQpfeXrNMC6l2jkwmjz82dNhz7C2AzUXFZ61ENf4Bn5T
 8cWAJqiOC35JZGm6IPU5DM0j4nKf2EYI1TfY7Ww/j8EC5rf0A54xd+8UH43SZy67FzSF8SHCW
 euwvU1+zxN8qFNhh+Uvz8cfbxLGx9mzca6EgUycBbaEsuwhA3Iob1RCVb13l0FJrjB6i+oMJk
 zMqZkzTAGLFHRC8TZGqJ4kjDPRAVA7Xy30gg/lXSurpcYLMLAahkrYMcYlk5MihflIwR+1b8Q
 t4y3exkyz0SHvAb5RYlU/wHIAHFC6v1bbOsFd1LSRFfpDjEN3x9KW51mVyDutfKgmX0GEf2u0
 AeRwd0IZ1fg/M0Mr8BQV74N3kw/Tr0srm+DLQ2vdKvjPIleW+8UhUazh+uannCcWzvVz7NSCi
 PQkjaxeVfeQRlocdo6qa95Z561MyUpts3v3cF17/IU7bYg+kD8fdAwrx+kqm8uwrH/ZeDKcQs
 bqzhpPcsyCDS8krvPhomi9iX8Wy0qlEMqGq6IZIM+eUze2ostfhL/34t/qJnyhrlTRBhEuo2N
 Pu+gZcYSRjwpEDdbFh7xHDJ4IL/T0p5/11ydKHzBlrrfu2t1CvQMvOu2DerpSfAnRB+hRn5rz
 Y1UcCKVDJbJa+OQRp3DlWCyOIGRlMe8XV1CFPWvacdyjnEpe/96tq/JrDU6RwcoEY33Q30td7
 M33QlPEQyPLKUW+8QvA4Hs6iNoEMYAKAwfA/OWoL/Ukc12tjvFn/NJMhc2F82DFxaJ81wAY35
 ZNJKniP8JI0OBm8Wxf1D2cHjHux085IEO9Di3s/hjBk1x08JK9nlChrJYLmXvraz+qETL7NOo
 p8EIfvEKhxL9Kq8DlEDmQj/hpd0nZPsLbuceFf0mqBSmDerRKYSq22U+YBnlRjErvSNHeHwz0
 MAiA26qDCPaxFXk3Ht1oJD8foXf1MoY8uV408DteLyO5der/mAm/X/CAZRVOgyIA0CnKXioOV
 yc8awjuTlVB9OBRNAgbq/SyUeFdJPIGrAzDRbIYrvbBYB8+wLZ08pHx5tV0wBwsnVUpJR0drG
 tu1GWNNuUfJ3daLCLoKp3Dnz7f
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
> There's no point to check for a 0 length at extent_fiemap(), as before
> calling it, we called fiemap_prep() at btrfs_fiemap(), which already
> checks for a zero length and returns the same -EINVAL error. So remove
> the pointless check.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ceb7dfe8d6dc..6e2143b6fba3 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5526,9 +5526,6 @@ int extent_fiemap(struct btrfs_inode *inode, struc=
t fiemap_extent_info *fieinfo,
>   	u64 em_len =3D 0;
>   	u64 em_end =3D 0;
>
> -	if (len =3D=3D 0)
> -		return -EINVAL;
> -
>   	path =3D btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
