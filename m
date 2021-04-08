Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFC35838C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHMqG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 08:46:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:46323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231294AbhDHMqF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Apr 2021 08:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617885942;
        bh=/zIT6UMjGT81U6FdJGS9yrOTfpRi3LDN9URq46oc3Rw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CxuW1TRWchvxB5gdly/z2DaxSKCmc7KeWuqHxgEOT0lppu96xcYFP3IK3XFoXbHFP
         e3KzRfOpcFHpoRtwxCMl0YOaAlrMKEmhCo+Isjgf3nbdH0sBnpRjlc/Z3E4+ADA3dI
         tty0YzKMSD4t5VYX0WmGhICruu47t/k37uQcc89A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV63g-1l2KlX0GTW-00S7bF; Thu, 08
 Apr 2021 14:45:41 +0200
Subject: Re: [PATCH] btrfs: Correct try_lock_extent() usage in
 read_extent_buffer_subpage()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
References: <20210408124025.ljsgund6jfc5c55y@fiona>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <dd661e60-0fb5-ac21-19e8-d20d91e61169@gmx.com>
Date:   Thu, 8 Apr 2021 20:45:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408124025.ljsgund6jfc5c55y@fiona>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R7ly+ri5eVjT8g4DdndzEYrvHuOWAFJNdg+x8StVzdYD9Ff06Gw
 wEBtlHzKWOoye8oHI4SlsSXlXh7EppnKIy8m0+J/gE8dw0YCEitTq9mFnvHUWdEqSsuej8M
 VQN2VOs28oD5Tpnlhd2jMd++r2YINisLRML7qnMB2E/4jzrIMhbEmrdSN58r7o0zvGg07A5
 8o2gSE4tUeAm0bu03pSUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LgNGYm4YkgQ=:zgtq8sEnkksHnhDHDokEKX
 sHpWEN2v55qUIcOZTr3vvwK23jJLW2ffVxJky8BBs5U0VqLZqG4ZnTicreNKGxcaba2oYtI4k
 uFmHihMtZrRJWdta7lWsGIwM8dmIQNT+ylcFUYIq9wphbnBXC/9/+ptkASuWn+KP8UhTUx2Ad
 fQmlCcxrqisCfKT/cGvcaPoWLK/bYlyU69hozZDEHsrrRbTw+zTrCpsf7BVXGAe6e6jgHs2bX
 OO/gcayobUUVM8czlVJ21ldptmQ8ZuyGEYrnIX/Izy4WwIm0QOGoWVkM457uEAHSjSX5lII2G
 PPWYxOUaMh8PATO/BKHoU/1D6QiMAku7+IioM0cqiqhl9Ft7DwCrbEX7wmI3l0V7Omdosefef
 4NVpJaigYQ3JoOdhnXqexSQacpbByHNEWM3IUuod0z+j/UDZ2r8oHztc8TCEZsAR5SzW0uEdd
 DhV3NqdRrZnwU1oAPm25WJcbPWuN+lEcQigfiaDC0UEpEoNynncl6ybpmnAeNhZYu+k+mnmd/
 hifCQURwMKN7PEQgUKXDiKn2X9/5CFdsO6hC/+RpYCTcviKa1zRlf3zPtaoWevTZPyhe+SRsR
 f2RWVipBmzUcKKsMj07bBorinbmfft+AwoonHLPN2X6c8qyqqfDaAQ87XMsOdnLbFinEshF1g
 YpfYx0YZ5y5KbMpSI5BiesndWEudJ2A/Rpc/wXIJ9Hx84Kxd+znej38rCgoNOYY5qjrh6LBAx
 Myf9qCilzgmNujMvBwm6fIGdJP29X6qCwGh8Gxii9py9qLK8fxcWJ6L4qO6igd4RjrRAXAKXM
 6Frc4ZIghTWVu3HdtHQC3hrSf8BfGqdCo5tp2RY9uB1zkPMVsnz5TFn37WTs91ZELwxralHYC
 VVM0wcL0axymv6Ikkt6iL9ut2pt4AFSQsWFHO8Myicu05pOCMzQHv/gwcSzByga0DuNF7bKT7
 9Tf+pc8lnRiEbBmfPUaKZwDaNV/xYnKMCQistXo/mJanUj1KN2JZ/FF9zstSfhS2QIliOJBS9
 UbHr1lvSDF6ZhKpG1InuRNZFBCYHEQ2YfhhgjzATFyipS21PWR2IvJNSKC5Urj3OQ5CQ3oOT3
 jS0qPEU7ZRnAA4HqRqTZroSgKdo5+iy5G1lAUvg4pVDPRwEZIi1kGiVRwxCrZvdmU+g8Q/T4M
 yHUCiQWRyZa3DF9besBNJoD7tBF8SGaZIE3KBRy/c2MoPokcGG35GpNM3/Nt3gEnFDWDKUC95
 0akq4a7s/EjtMQv/u
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/8 =E4=B8=8B=E5=8D=888:40, Goldwyn Rodrigues wrote:
> try_lock_extent() returns 1 on success or 0 for failure and not an error
> code. If try_lock_extent() fails, read_extent_buffer_subpage() returns
> zero indicating subpage extent read success.
>
> Return EAGAIN/EWOULDBLOCK if try_lock_extent() fails in locking the
> extent.
>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thankfully the only metadata reader who will pass wait =3D=3D WAIT_NONE is
readahead, so no real damage.

But still a nice fix!

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7ad2169e7487..3536feedd6c5 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5914,10 +5914,8 @@ static int read_extent_buffer_subpage(struct exte=
nt_buffer *eb, int wait,
>   	io_tree =3D &BTRFS_I(fs_info->btree_inode)->io_tree;
>
>   	if (wait =3D=3D WAIT_NONE) {
> -		ret =3D try_lock_extent(io_tree, eb->start,
> -				      eb->start + eb->len - 1);
> -		if (ret <=3D 0)
> -			return ret;
> +		if (!try_lock_extent(io_tree, eb->start, eb->start + eb->len - 1))
> +			return -EAGAIN;
>   	} else {
>   		ret =3D lock_extent(io_tree, eb->start, eb->start + eb->len - 1);
>   		if (ret < 0)
>
