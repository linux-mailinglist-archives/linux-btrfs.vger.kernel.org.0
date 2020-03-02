Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC631758A3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 11:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCBKtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 05:49:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:47883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgCBKtB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 05:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583146134;
        bh=GVT9ac1Wsq1WM/5pHvOn0gO1913k/m4PmNGLhdJsAUU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ajd1JhGe8GkwtIwfYFdjgzoQoUDjP+p9SThthPGkPHSPh1GQMSMEHWqVCEoOLIxcu
         ba03IGbKOyT2XZuVS62zBe6kEChsIpGj+YVsLuj7NOC08RHCBx41tzDsvNabw/CpcE
         zqKtH7FP/ieIQ/Gw9W5DC4nO67Z+FDXXkKKbuhws=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McY8d-1jel7z0Job-00czHJ; Mon, 02
 Mar 2020 11:48:54 +0100
Subject: Re: [PATCH] btrfs: use rounddown in decide_stripe_size
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <20200302104651.1703-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <e52d328a-7264-606d-7341-183886c31004@gmx.com>
Date:   Mon, 2 Mar 2020 18:48:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302104651.1703-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qN8y9W7D7eFX7Jp1izEdaD6L5H17fFOw9hzYOeDJ0BE56Ph6GkF
 bSs3+F4kyEBjGm11i2shsDuHYybOR6txXtNq6zvzzPW/sXfylOsVY3TUgdB+NKyxbzofQoZ
 PHJKNQl+CU7J6GLyfQu0/4yPPQb5OhT62ityoDnVDwbw4goN3tipR8WZliKsI6Qenz/aJ6E
 JUyjsY78Uv20wDq0xm+ow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jwr9i8+t+fA=:1+eMM2uDuTeeS4sXrDun9X
 pXTqDtMExpPw4FdATF8ZH6Vhz2cla996iWjGez5FqS684/uAaWlDeyk2ShhekiRufmrJdJEhr
 Z2UNdS3q+RxVk6aiRwvIthDrJmDkevhCRCYhmx2onu17hE6xh3O29KzT9ahJ43KVMzF0itOET
 JM7I3ODbvm5C4zWI5sG3voblcfmFVuPQxHRSxk+DFsc5q68N6ASYbn1OWcq/H9XMqI3/iLo5D
 j5H70ztq3LGP6ZijVpEXxG9tQr0qAYBUbDVQJ37EQ/C1gl67JErmwWLDIyY81eaUnVkeZF+Pf
 0533jbelUgJ2DBB9dF6OZva9DPe16sLTOUk1v2pODGY3Afq4OkcQofSm/1nr3fJUjrzl2qB7H
 afJSh8FENCteRriynKA6rKxVFKLCmasE/qDMDkvlpkdYC+Kncy2Ck7pvjLpWISzkbY//p/WrD
 SSkFZmYZH+U9kwpivu2PsJvvxbhsK3dG8p834HBg4sFGQkdDlo3lKkpx+YvvD4mFdP5/ZlR2d
 QqAm9Mr4BIWJotzBdai5uOuzcT4e2a0pJwEQvOKdVsuR029p1r0l9TuvEPAzkC7tTXBNpv/41
 prBmdVim0plF+PKbyZwY7WyLwzZve2D1Qb3x2NnbollJIA8nfr1mynfp6u/XNO/bGPV7M3k54
 0XMwKK+qxDwXbR7sUaeXccE1jaECus6R0GCx9iQWd3srlkdy4oHni0kRBFURI9U7TumBczPpA
 kN1TVR8bW17s5jjEoLSaQPeN9M5QoaWVJ20vJSG/MHJrbs05PkXg3LnGzg0iuIwf5OMcM5y2Z
 0Ppjz+NSyUp6qLURATmzqf+EpnY2kB3zfSDfPGocNfMCn8oP0HsVp7yGYZf8npGZMXTfOkEtq
 toHyg48USgmhRli2IEJ8IW74RXUofXXuNfMeyAJJ2WM6EYlpAmMl3AKfwi5pXZJnBljOpKi8i
 ob0TCSA2te4DwXK1E0x/U1Hbsx2UDlv9op8ZE1SBc2EHinZnjeunxYPzZYbbNv82dtP7kfnqd
 48OvgZ+H3Rg0XSwFw6KIpzgZbTZ3RAoqVu+MeWApG5kg1o50eCuRUMJbZk6TMjNVl3PeceIOv
 oQ4ANXALf1HxUozpnlF/fxgBIBL/AzMoE5+bKUeQhydNTFyfJ9tyNaS2RfdgQ30Iy5GBn3r9F
 7rE9OioDh4uTDNMgT5MR8DYh1qtQVdH62tiK1ulMHAn4165Azxqk1edmhGAKt9EL/4ly37KZM
 Kj92fHanHv0mgEfWk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/2 =E4=B8=8B=E5=8D=886:46, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> Dave, please fold this into c1ac11142016 ("btrfs: factor out decide_stri=
pe_size()")
>
>  fs/btrfs/volumes.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 267847c72c22..111c1270f800 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4994,11 +4994,7 @@ static int decide_stripe_size(struct btrfs_fs_dev=
ices *fs_devices,
>  {
>  	struct btrfs_fs_info *info =3D fs_devices->fs_info;
>
> -	/*
> -	 * Round down to number of usable stripes, devs_increment can be any
> -	 * number so we can't use round_down()
> -	 */
> -	ctl->ndevs -=3D ctl->ndevs % ctl->devs_increment;
> +	ctl->ndevs =3D rounddown(ctl->ndevs, ctl->devs_increment);
>
>  	if (ctl->ndevs < ctl->devs_min) {
>  		if (btrfs_test_opt(info, ENOSPC_DEBUG)) {
> --
> 2.17.1
>
