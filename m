Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC4727714
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjFHGLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjFHGL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:11:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD0E57
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686204684; x=1686809484; i=quwenruo.btrfs@gmx.com;
 bh=CRRFOUoiXSTPPdd6aFZj+7+oW7ggPp1/5m24eSHJ0G4=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=N0JD7MSOhCSBe6AFC1OeryR4sFwDRSZdp2xQtVBsTKArX9OfNppLvNbM8mDNTSRmP4gRnAM
 F/y+BNRlGf5pEpJNVEaEXAVhHQWL9RllIbjMCX2bAxmoQmL3UJX2oWb1ip2KPs9TLWV9RW0ez
 FuqT6Wd5fzAecZeHULddUpTeXRFBW5+Ef8v8RCBd+UZgPWii/Pe+NJYDPnFJ2vErk4YiscrV0
 SWdgwtdvCN1CPzmW4On3p2PoEQsjosXR7i5MYUtT8KvzgvkgiHDwlJGpm/qA6F7MZVxBi94ju
 YhOLNzOnrzpndzN2Bp7UKHkYhNOwnLNtGErvKiYODTxNapKEsosQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8ygY-1qDBHR2FOQ-0066eJ; Thu, 08
 Jun 2023 08:11:24 +0200
Message-ID: <ac8f20f2-1193-51f6-8a7f-3f88ab7a17fa@gmx.com>
Date:   Thu, 8 Jun 2023 14:11:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/7] btrfs-progs: check_mounted_where: pack varibles type
 by size
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <20d70d9b1ab791c796c73bfc84c23abe956af52c.1686202417.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20d70d9b1ab791c796c73bfc84c23abe956af52c.1686202417.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7wS9vui5FkEVAdxmIl0n7m8CxYONUs+V7cV1WaDxBfou7H1dlFV
 k6MGt4l+gc0dftbB6IHn93F4+gdcQvPC6L3TAyMwpZMA7vsh4+8f7E/qhpxEWhAxRxrPolw
 146ikXWmWNYogQGEva05lcIOO7T7xZEZd2VhDNyLcQijjmadaYAw7ilHrqEalqiCmGnSJOY
 ffE7EmQ5wE/Lqc8IaNv1g==
UI-OutboundReport: notjunk:1;M01:P0:U2KScKctZxg=;+B9tMAUbwEg05d1DzBBsFW3eSHd
 EXxaHz8TGnEAA15MbiT7nh1B7gDvq56kTGlx8p6GtdEn7R5J0u4H3qA5JZzCZLMInZ2v8I0dN
 iOsU7GeVwLdW7v0Mid7pIPtwY4ODz+gckbEW3kD7vOEEQA5sDqL3vnoJSf1p3T4LEjysFJoIj
 TUlAp2L+5Lum7HYaRD1jjJFohOdcIgHFpqvwrD51wSSTe6ZpF5av7D+FWf8FqTtlmhMBycrHr
 0bA6iq6ClLw1LAfyra3HRGlQritluEh1u2Zo6kyKKZyFSktF9IcF1wRO8SSKLo5EM3/2iSSH3
 7u6qsQ+fIJjpqgedYL6blT5aHKX5wZ64AtxeweVvC5Lu112VDdCNDGCUt60fsFYNAwyOit4zT
 X0OpKacCYeRPZwCL/RthvOqSNigIq2/JHZSBa43Udg25x0HES8TF3VMTrKPX2W3CtBUcQeXxZ
 Ka6Gm/toEJ01ADK5KnPoPXfBYt7nv8Ioka7cG/TMCNuDJGxQPYtTRXh7AcTcXbbn/dMhvtHS1
 NtubmO2cV+zhXH171YJgy++5/sd1sUuLfGZ6dkZFNcx2Z6wE4o6dmnF/rZ+mB8r4ntkWx/tUj
 D2K7/qUs6aQvUKP1/L01xKba9Qf6a7L+UK16qUq1BCEJt0Nby5UHCvDwe/ww5b4PaUE8p8XGb
 ZMSAsvMTunX/k0lQXTrkP5kbEKXMMZqDxdHUwPg4M+sntpTzzVf5YFL+75a5CTG87VxTXHyHP
 7tqJcVg9rHTm5PxjJY0xq05injINgcsX3eX+lpm0VHX50bRVKru0ikI68G4fq7r2a1fD42B20
 PRsaKg2vPW8UqZdeYRL5ymQR9pal9jlDq65bn0Fe10caHlxfOvOWX9qKSf6c8u6VaiLI9EtyG
 tKdNZKA+BirTuZ6EyJEvD05lPOIol+6V0ZuXqlmmQCrcOMbQXCznwaZRkDCkfdpJY45gc1Ty8
 sbxuuASScxtxEOUr/RmRuniDdYo=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 14:00, Anand Jain wrote:
> Pack variables by their type; it may save some space. Also, fixes a line
> indentation.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   common/open-utils.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/common/open-utils.c b/common/open-utils.c
> index 01d747d8ac43..1e18fa905b51 100644
> --- a/common/open-utils.c
> +++ b/common/open-utils.c
> @@ -55,16 +55,16 @@ static int blk_file_in_dev_list(struct btrfs_fs_devi=
ces* fs_devices,
>   int check_mounted_where(int fd, const char *file, char *where, int siz=
e,
>   			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags)
>   {
> -	int ret;
> -	u64 total_devs =3D 1;
> -	bool is_btrfs;
>   	struct btrfs_fs_devices *fs_devices_mnt =3D NULL;
> -	FILE *f;
>   	struct mntent *mnt;
> +	u64 total_devs =3D 1;
> +	FILE *f;
> +	int ret;
> +	bool is_btrfs;
>
>   	/* scan the initial device */
> -	ret =3D btrfs_scan_one_device(fd, file, &fs_devices_mnt,
> -		    &total_devs, BTRFS_SUPER_INFO_OFFSET, sbflags);
> +	ret =3D btrfs_scan_one_device(fd, file, &fs_devices_mnt, &total_devs,
> +				    BTRFS_SUPER_INFO_OFFSET, sbflags);
>   	is_btrfs =3D (ret >=3D 0);
>
>   	/* scan other devices */
