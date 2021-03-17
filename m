Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2311833E675
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 02:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCQBvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 21:51:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:51583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhCQBv3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 21:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615945887;
        bh=tVhkEz2CalTQaV7MqZNfxHYGvv/4PuNugdYNEy9kZf0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=UKemiRQlKDaiQ8qQ3gmn211BcCAyH5rZtuYHuZg4NgP3R0/+V8vij0Ft+5P8SFbdo
         zSHkhxpw1PaMIdr2ockTOdbyNowUpju0LZwY2Z2xRFYQBJwNo4d7qIcCukt7DDCt3U
         v5/VUphAuobc9hAfxpQ6GDKvILGx2cycr2OMavh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mBQ-1lq5Xm3JVs-0133Cd; Wed, 17
 Mar 2021 02:51:27 +0100
Subject: Re: [PATCH v2] btrfs-progs: common: make sure that qgroup id is in
 range
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
References: <20210316132746.19979-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <87189d7e-a3ed-94fb-823d-4125ec3f922d@gmx.com>
Date:   Wed, 17 Mar 2021 09:51:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316132746.19979-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7nuROIvfiAP2mvw9fG8UkVFteLNZtAbvGB9spibHJtkZfZPLV3V
 5DAMvi3eCt2szO5Xu5D3plwqe2s0+64CuLPRUJ3L9jWMpYAMJJqhbsvNeWbepQ5ivedPtE9
 qw7ahbJpcJEcF08BLTWqTx0NZQz5t8x2pEGwGv502uFXxdr8ucAHO2mRL54qukcg1PjpkmK
 OUEOWDcxVOYAqbqIlkxTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QFADcpHGe5k=:FdiFuffkVQxwdifYbFw/KG
 Aj0YnswI2cT4CKjHf3yZHPgmXq/SSDsEuRLXHbZuQN0lcuXk8jlLLU4+2nfJevTnC+ST4oPQz
 QicIwQJJZKOZIOlS9Wt65cn1kwMjRwd3TteQ1oqWcczTtkOzBYxVnxLuEh4gVysMBheEQ6WzF
 vKqJlvExQ/oCmQ3CGvbiuLKcq6B7AmollMLp5SPQewlc+n9F4ejLHFdjLfP+b9xZT2IVHZqUM
 f3N2jtRa4+70AwyArzVW2nYZK6vfs92UBVGknE/dMVphGMsdxktis0b6FE+B+jt1iIeQ9US67
 GiDbtglCH0EkBrNTe6GjbTg07AmKAUuCgV0fk0lTcrWPEVk12eWTd+HG0xRN6UqDty8HUsvcM
 FSF5nasCFhejjuAIPG3p54drvdAqIM7uAMauCMshzVRkkiJuWlzJNo9mwqUnfQJtsIBIGl9W2
 fCrAh1W3ksDlX8OpDs7rf7c1cw0DNmU5F8OcNIGoQoYESqxiUGBEuOLcH/AytIVc8viN7AcHt
 CsyhzCphWN6tYTXmjowAGnUqJTWwfTyhAJqJmDazYE8EbVb6xSYx+2FmVGaXD/dGVFDcsgE/h
 Z1UhiYaOKc9UD78lnRHnZH4h7FLQz91IZnYGTbhviB501bJLuHD/sK6j5U5humKEvlkOeRGCV
 cxa5wfJQpqo7Ul3YMjx6+O/MgVzJp/i0yk2fgx0eEEwjntpkJntSPlmr5+ofRDscmAGUekt4X
 jNuSXw0YoYqodv2sJ/46HXg9zucXQWbf74tkid1AAbhO3Nh3SCH+uao6DnsarizgSebarhz+g
 IVpwCn5+++PSMYMX3UiedQxAHV9NjpYKmDLl9NyaIyvFDLzpLFh9ytQnCUFW97IHmylhwS4S4
 TndDF94RIJNlIA1iRKBg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/16 =E4=B8=8B=E5=8D=889:27, Sidong Yang wrote:
> When user assign qgroup with qgroup id that is too big to exceeds
> range and invade level value, and it works without any error. but
> this action would be make undefined error. this code make sure that
> qgroup id doesn't exceed range(0 ~ 2^48-1).
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> v2:
>    Use btrfs_qgroup_level() for checking
> ---
>   common/utils.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/common/utils.c b/common/utils.c
> index 57e41432..ba0bcb24 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -727,6 +727,8 @@ u64 parse_qgroupid(const char *p)
>   		id =3D strtoull(p, &ptr_parse_end, 10);
>   		if (ptr_parse_end !=3D ptr_src_end)
>   			goto path;
> +		if (btrfs_qgroup_level(id))
> +			goto err;
>   		return id;
>   	}
>   	level =3D strtoull(p, &ptr_parse_end, 10);
> @@ -734,6 +736,9 @@ u64 parse_qgroupid(const char *p)
>   		goto path;
>
>   	id =3D strtoull(s + 1, &ptr_parse_end, 10);
> +	if (btrfs_qgroup_level(id))
> +		goto err;
> +
>   	if (ptr_parse_end !=3D ptr_src_end)
>   		goto  path;
>
>
