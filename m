Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532397ABBDD
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Sep 2023 00:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjIVWh7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjIVWh6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 18:37:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD5E8;
        Fri, 22 Sep 2023 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1695422266; x=1696027066; i=quwenruo.btrfs@gmx.com;
 bh=MhAHtw/CtpHH/v4U7yDNgoExdZb5DrSCIAw34RFLpiM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=uhR8IkMs2HkDt84z/sEp7TyxMn/3kOH6GkgVh4NKYsnbAWIopQRU84+5B7a2c94rl2958txtpr9
 rRfmiVs6F8riwwwEwSKr8hsX1uWgUz8o/2x6eM5C5QtAXHBMqYgpzxT3czlTJ/SiYNiVNwXjpYn1j
 xJ7di4qBeysRYRmgCk+Hu4whriIcMHpQlN6H58NebccdYJJTOmyG44d/PbiRRhqFKk0En0wcDPNht
 sk3H/jTtnjRkHPuZdQ2Xn+P0eZ/TnDVPuhO3ihQW/oOpv8YmmqlW9FiChF5ntNSb+lccqzPgTDub8
 IthNwzzntyCOHXLY3JX70JOItznSgnjchXFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.6.112.4] ([173.244.62.37]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2WF-1rQbZm2ovX-00k9Cc; Sat, 23
 Sep 2023 00:37:46 +0200
Message-ID: <52ff4c1d-5dc9-4561-9325-884f735a64be@gmx.com>
Date:   Sat, 23 Sep 2023 08:07:42 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use full subcommand name at _btrfs_get_subvolid()
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <c0ebb36f51f97acb3612ec5376a68441b5e62ac6.1695383055.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <c0ebb36f51f97acb3612ec5376a68441b5e62ac6.1695383055.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jYoD3Xca3k2bVFh7JMuRTaO3UEkGprPjjnz/H01YFQFdiBjtFKn
 fGHfOqxl9vHiLeUUu5zisYRNuzn3o+iyfs4uZeWm1ChDNAqGwFGm73cpakf4ojVdN2Va0ga
 xXNgO86n+HfY9/FulMFNEiVF+N8QVe9P//fsoPDkx4lallHniFYxiwo0rMmy+6lCKRWC8Px
 NWk9Eg0mO+ShDfcPW6RoQ==
UI-OutboundReport: notjunk:1;M01:P0:YxFSQ7HU3VM=;34PV21RnJZVIr/Qoiq4VHW5RqNM
 lFhyEWZWiq0CovSvRycTyEA2EOriv3MLn6/+WksI/FGgysoExzo57Tp0x3dD6gUpXl4q0yeGb
 7alCl9jRbMtN2ruUIXoCYerduJeK7WVGCCSH73plg7y54IfIK80ihj0Re3Ygj5tx6mZmI8B+f
 qa/GRib8hERQt9fs40C/y8ODaMHoC2lmkBSGIZmoEOi/m0X7LAMKgqNDGFGTD/triAYXdpY1l
 quAmOQE228Cprm4RXTo4aceFjdue01bl7IYH+rS8t3uGy5peWptsVmuNLIz4K1e0+U7ofpYhz
 hb/jJ0gATN5iYCCwBQBIccovyhyCvlioJhSTbvUghrMCUTDgGaWKRUpepNHfrmt9mzclkjTJb
 XD5key1IeeuYYZXGFOh93RMVK/KzC19eQX2uLYzyRp9cjhkqEEwQmZixcqDM6xNeE/4kWr8/D
 zXORhyo54StsjuKtUzLj7CT6gR5h7QxdBQGayQA4aqd2j919ePgsfx9VtUQoKpMY+ZqKJMPmj
 UeRiIBOlWvvuoHEwm3UO2oDUV4n8tVH+lqoL/Y0lEyiB3Ne3wM6AOvhLYKqkWy5f/nkVhReHk
 5Eabma8LjRsd1dZnyJTOEqVlfliQF/tljIpaDpuN4AhpBm/oHzzK4QAjaMJ8fzWUoghv3WOg0
 OLTt0L04O4DZWppIHYUe177PJ0TiVRLWSkHlboNczCHx+bh2jgNdjvCFW9DBxyJk8mta2EDQ0
 GpY44pYhvZzK0K+VuCuhNbxAxwp9tnGojktE3KSSMG+oloBCwm2THSdvACg4hqnxw0NFcOcKh
 cN5xmyaYKVFcpKxlcNJ7rpDKRbHlpGjf0UYOCH7gi2oUGHCOxenGmL24tFegP5HKplo7RKYJ2
 sTNu8zVz0PqVL0jjW48CUA+CF8yPw3LRFWnn/M50U+j4b7d+ms7GK4m/XBPHDgBrMr/x2zk3U
 1sJ4+ZYmbEJ7rwl05XxWNihNoB9cM3/XiQjTNFjEnAp0ftwV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/22 21:15, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> Avoid using the shortcut "sub" for the "subvolume" command, as this is t=
he
> standard practice because such shortcuts are not guaranteed to exist in
> every btrfs-progs release (they may come and go). Also make the variable=
s
> local.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   common/btrfs | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index c9903a41..62cee209 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -6,10 +6,10 @@
>
>   _btrfs_get_subvolid()
>   {
> -	mnt=3D$1
> -	name=3D$2
> +	local mnt=3D$1
> +	local name=3D$2
>
> -	$BTRFS_UTIL_PROG sub list $mnt | grep -E "\s$name$" | $AWK_PROG '{ pri=
nt $2 }'
> +	$BTRFS_UTIL_PROG subvolume list $mnt | grep -E "\s$name$" | $AWK_PROG =
'{ print $2 }'
>   }
>
>   # _require_btrfs_command <command> [<subcommand>|<option>]
