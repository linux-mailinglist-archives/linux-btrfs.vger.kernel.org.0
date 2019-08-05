Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52D3818FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 14:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfHEMQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 08:16:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:55377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfHEMQa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 08:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565007384;
        bh=R8dYIb7hv87fVkfCCi0ah+FfHyed5rZxu9F92Ewf80o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gK911h/0eozQiXs1kB9Cg9tm2Uu8kH+5BXEV2IoXpguP08xRynXt1vdgEoJEra9a3
         0/uPOvAZJCqJqozs4D0H/H+NAcgWR11uHODKJALGCX57ZTVbLew8tmTAkEJ66Ei1NP
         L1Y3TdVv6e6HMaKB3+5l4gkmCQsmQ8BmRYFU4neg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MNqfr-1hxbmW2IzT-007Wxu; Mon, 05
 Aug 2019 14:16:24 +0200
Subject: Re: [PATCH] btrfs-progs: Check for metadata uuid feature in
 misc-tests/034-metadata-uuid
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190805114522.12151-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <fbda482d-5530-e6d2-b351-d94c10583c65@gmx.com>
Date:   Mon, 5 Aug 2019 20:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805114522.12151-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U0sNkQehfYSVX0z1BiE1E1TNdDFmdSObI53ss5ikJeeqDn5z5w+
 dPirbYg5LePizmR1JLlvImvxPalcOIg0LaPcFIHCLiEbIeY9qVWOjG5l9/D2fjJOmSC7R4b
 1CwtYgPGk2zkURiuSdBRbD289RI5nWb5PRLi1KEd6/AnjKVPC30fOqEnMNnlztQos5juj6F
 f9aV9gt+H8UW3KhqLALLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n2aVZB12HeA=:OrZ2fXujxXl5GWkVIh0Vsg
 uhy+3TAqLTpPzPyTGWzfGv0nh/db24W977Gha2qF5hjYdyD55lBDoW0L87Po8ddiws0hT2fRc
 z0dxLhxiq3HhdOXAiJ41x+sLTmvAai97KOGBFQGPdF5SSUK/rIk+4BSDfPOuOEIN7DqxPaLVj
 pzxFEqosELo4F/gkpSfi0L1VklLBLEWWU+aIL+SrX1ch9r0PMSUUqE5JH8ISACWQ1jbGTRNXe
 IxTa8cyYAn372jVgs/8R7OOhYNUTn2Of0K1YCd8dkqppdofonQvm2OcXA1s4UO0I1aQlZAC3M
 DXOlZWVW6hTCBpk87RjRrDnXlKqCpm/VkWTjtqA47dCSowC5wp4Do05CVxoULI+dC92qxCfqs
 XHL3h5nXWLKclYl4cm6k4MXZ81A0EGl+S4hLsFKMwkUlj5/nwIfxy/tI+KPfw3GaIkJHvBfsi
 kan5dUk05dpPbu3yxkiG96UaICHxeTLzdo/3lMSMY5PDMCcFi84ipQF5bGxyFHg6AIV5SRSI+
 79YCxb+VYIUQ6PICDEIjZNv/1j4c1VLII5VxV9+/1gBuBxPp5oo8TE+HtwD0KLlRR/sIiync0
 r9ew/YH36MxwCEUZQ1Kcj5LokXqVkqBxyaJluPbVizU8Tj5/6gqjGxcP9Epe0ompMNg5vgxoa
 gRViH7TI7yNYEqhvmmlUbicESFC8sJosHGQY+aF6OM62/9UACS40bVqXaY2wJoDCqGm9GqfNk
 2vEhXU5ovmQ0JtDfqyqu44X0g2UsvAVyjOUvnC+SD/JgFspvm7B7mnaXpXWBVo/FJ6vgFRywI
 zhNWTxNAiemTDCw8DMR6Ca9XQUVsGRbkeQa7t4C5eJ/HOUB1AWVtlHAGckV5hW2NVRbJb2LrF
 Eskh7X85rJQGH0EniWMhTJz7zZcSbwF6i5e3NmNqJnqXJN4kUkWfW047TEdN+REORBIBcKpYo
 kGbYejT3AnlsXJZBlBskGo39jJkeQbVs/2z+q38QEEwSqJfc0GikkrGmkJsULjVtS6KnlL4Si
 HB/GgP1bTq5Sn+SaYXN49izZ6FavMdzpoDsoOenpNsu4bP0Z3ltay5JFwrQd7Hw2LKX3vTT6v
 nYDVqiFq74DNedXpap8oOMBYzSpMXo2hTpmFp/NZKHqoQPWABvVswULglXw1Cuo6QKjUp2I6D
 Ug3lg=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/5 =E4=B8=8B=E5=8D=887:45, Nikolay Borisov wrote:
> Instead of checking the kernel version, explicitly check for the
> presence of metadata_uuid file in sysfs. This allows the test to be run
> on older kernels that might have this feature backported.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

The idea is pretty good, as sysfs is way more accurate.

But /sys/fs/btrfs/features is not ensured to exist, e.g btrfs module not
loaded yet.

Can we fallback to regular kernel version check if
/sys/fs/btrfs/features not exist?

Thanks,
Qu

> ---
>  tests/misc-tests/034-metadata-uuid/test.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-tes=
ts/034-metadata-uuid/test.sh
> index 3ef110cda823..6ac55b1cacfa 100755
> --- a/tests/misc-tests/034-metadata-uuid/test.sh
> +++ b/tests/misc-tests/034-metadata-uuid/test.sh
> @@ -10,8 +10,8 @@ check_prereq btrfs-image
>  setup_root_helper
>  prepare_test_dev
>
> -if ! check_min_kernel_version 5.0; then
> -	_not_run "kernel too old, METADATA_UUID support needed"
> +if [ ! -f /sys/fs/btrfs/features/metadata_uuid ] ; then
> +	_not_run "METADATA_UUID feature not supported"
>  fi
>
>  read_fsid() {
>
