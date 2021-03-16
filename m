Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1961533CD77
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 06:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhCPFpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 01:45:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:57859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhCPFoq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 01:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615873478;
        bh=wXba8SMwWbLhBlf6pDEyETpV1bZp7zSmXODECgvPCG0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=FiJttI+/2o34IRteDmqPUFbLktJEBlAHuAWT2xhnp5wr9l9rH5mWr67x1knE+lW0H
         /nmLuxe2KGKEit6GAW4m+1aqf7ahBBfEmnRaiFd4/vJQP3sapiipT0GMQkT9zbNAB6
         J6/Ji3+KrQPlPpaOsv4d9/OmkcPZeDowc6HFY4lo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiJV6-1lsdhj1dOo-00fPFv; Tue, 16
 Mar 2021 06:44:38 +0100
Subject: Re: [PATCH] btrfs-progs: common: make sure that qgroup id is in range
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz
References: <20210315155638.18861-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2c58bf6a-d13c-2628-bfa5-c122b7ad73a6@gmx.com>
Date:   Tue, 16 Mar 2021 13:44:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315155638.18861-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:etb51DELe5bgG3NaH3+vv7pcNW4tzXJamRmLc7LrL9D11/sxD/O
 ZhE5b6vjGzB5VMU1/wPr11oU+QB1UsaKs5UaRvcSnc/NysxNMdwsjqC49+xOKY42adloyWQ
 TmNvwIWoRI/U4e1iKNG0b9HIwtfWiijVpPzKwMY3hc0p3N2pGfIPAVCMX0X4m0L0GuMr5GI
 R7Vv6Wq4TT/hUk6lqiV9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p5jVf5TOOik=:REgudObGdW84VojZFfrM4p
 nkRWLwrEtPF9TTXl/dd3fszUFMCUp0visaNGmHjW2mIzw8fTrPWvknx5SApZipKUQ981eJdrQ
 Aqok80h53dgnUJID6iF19mpsN4m1c8dRKGvFgXAlvCZzPsPuBmpmYMpHuSWuaG+1xUxNg0Kcg
 Bhqbkw6acZMDzqVJEn4BZIPYZSVqDgsciS9/ipvNYpaJJ6qaOYI4A7hk4hFO0T6ymCVcp4EJD
 /IS/1oD3tjxBz4n/aMXD/LRWQo5UgjFNffdBhVu1112ZoEh3CRcdI4zlvoBmpoUdMxgG4O/Cq
 kn9x7GvAgzf8Bggu3SH3mFTbJ0SBDPyZZAwKE5oZe3zR/WhQy9w/4UKCAJ9QT9UCi26RGKfV4
 SFCRVW1K1guxw/GARLSgp43PfqKW9JP+E0/7k2zYwzXj876KMJwT4tAL5FbtpQUJ3VvixIWeR
 zYGrwUzFYrVzEmgnBi1B2R/HnUf8Z75OzsNUqNkVkvG3lbJU20SkZdOn49savpXLqb1VfvLUi
 uPDlULjgW9HCy/xiO/Ljk+pDyLOvZglyZgSad6k80oJsTI4rAz97WDhx/1DuQo2nNAS1sXqHa
 TtoP58ntxYe08ethUghy0NTktBMglUah1RmsbhSTObKgSf/dMbXgiHE7Uc/MmlUGx06IB5OHO
 LI736VGpWYsnd8pgEJsVrfuiIHJYxK98ABTFFpLDPLs3QPCvQznw85NwOV8sdnojXgKoJgH3l
 8WpP5EKxR3IaCOmrfdX7adhcByXGeJsARsNdBAZEy9xC8UetMSGqjqnhKMBFuWX6ALwc0Pz15
 GAqT8Hxf6PwuZt8+8qMl5/U2jYMwn8Bxv3EMqD5uARAb1t6iAomGCfirEb+aU2oAtlrI9zkzq
 vh4IX88/K0svr1hmfCug==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/3/15 =E4=B8=8B=E5=8D=8811:56, Sidong Yang wrote:
> When user assign qgroup with qgroup id that is too big to exceeds
> range and invade level value, and it works without any error. but
> this action would be make undefined error. this code make sure that
> qgroup id doesn't exceed range(0 ~ 2^48-1).
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Shouldn't the check also happen inside the ioctl?

Thanks,
Qu
> ---
>   common/utils.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/common/utils.c b/common/utils.c
> index 57e41432..a2f72550 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -727,6 +727,8 @@ u64 parse_qgroupid(const char *p)
>   		id =3D strtoull(p, &ptr_parse_end, 10);
>   		if (ptr_parse_end !=3D ptr_src_end)
>   			goto path;
> +		if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
> +			goto err;
>   		return id;
>   	}
>   	level =3D strtoull(p, &ptr_parse_end, 10);
> @@ -734,6 +736,9 @@ u64 parse_qgroupid(const char *p)
>   		goto path;
>
>   	id =3D strtoull(s + 1, &ptr_parse_end, 10);
> +	if (id >> BTRFS_QGROUP_LEVEL_SHIFT)
> +		goto err;
> +
>   	if (ptr_parse_end !=3D ptr_src_end)
>   		goto  path;
>
>
