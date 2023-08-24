Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7599786C89
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjHXKFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 06:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjHXKFi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 06:05:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4721984;
        Thu, 24 Aug 2023 03:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1692871525; x=1693476325; i=quwenruo.btrfs@gmx.com;
 bh=uO+BKs6AnF5euvGzwKfDaPLvjVtC5+GgWrtUI0bu2O4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KcZxQ0vsuDo97UfvP3bE86roLfX+Fro8lVQC2ViHlKQmvfMr08s9looAUU6yLn+gLSsQxfo
 Ao7R+Mm8T0PTSYlY4lKaP6sve6D8zM1cwQW+9mkLoqv06ZdUIYeKJOKhuguKrZ5XLlS23Xtxq
 uQHuiJntusdERlm+EOnpv0IIa6aWSj0kGgSHiAixjiyHgbuFYZ/Pc7jbkG9HKxJV9pL3UpjPr
 zqZCxZYA7pKiZyUDJU2RBENPsNEn6OAu0lBXC24b7WIXgoOyOKYVa6Fl8oWxE8XeSKNf/6UOs
 wLKHL/+cZAN5HAVx0ymmVmP8GwBHMtuSd+2f09oCGYGeSRoGrPPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqs4Z-1pvMXt1qKH-00mujJ; Thu, 24
 Aug 2023 12:05:25 +0200
Message-ID: <dea5fcb8-7c48-4b62-97b7-4b226e6ac0a5@gmx.com>
Date:   Thu, 24 Aug 2023 18:05:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/213: fix failure due to misspelled function name
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <71413edbeb1ee5b945f0b82faccaf4a75e8ba56b.1691924176.git.fdmanana@suse.com>
Content-Language: en-US
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
In-Reply-To: <71413edbeb1ee5b945f0b82faccaf4a75e8ba56b.1691924176.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4z5PTonRZFX9Ro9GcTGSe7x9aHSpQxtD6+5KStb4Ot1s++vH+mX
 bB3j+70bMDKN7BeY7cC4Dm2CcqAHGsspFxAKY0n8bmKqmApRouWk1gre9ZA57tc2Xe6f3Ls
 qBoYpOsEIES3Op+fjAtAjPaIj3W+hG+vZFEJYiJGdBJhTnjJFxxep3KjtrbNpb/UepFCVC1
 us60PxShNw8uw905eH9VQ==
UI-OutboundReport: notjunk:1;M01:P0:XI0icSlBLLg=;mUmuJFm2fsBPejACaTzoNr/qva/
 mUPv/K+6zePMM6pQNsWrA9itPbk4LA47hH3pZHGdQDCtLev7dnahPmGNksmsl9ZJvg6/iXYzE
 T5nsjgEFFq+S40ccNOU2gVW/dxMNWyRcBvsp938WtE0fxCUGBh18rYd+SwwPj0opJvMaA3Htd
 vkorBPoJfY+mEMVolOaX9jHHTCip4SrGz2mn/dZsBtvZpC3TJkOJhjoIlKmZHq2LtHnBYTLbS
 ZuEqfbnD89KS04refZOeShI1mtzGOH791joiFiee07jfhvNIpTLFncjt7sHJEb1P+r8wSLuDM
 0Gw0wb9cmLHFCpXq9FpJW5ZZ/0YQwoUu5f1YduTDdum7/85D98AmGP/wVeyeTjEbtEd7o3zFh
 PB5UO3+FfT7I7P7ISzCFH8ta2AyBA9yco/hH/HLr1m1q+SLEKy/EKVwmA7CRNXLAxT1I2CrZq
 c/bmWMHz8+KOm98y5xeHAxCesgxo8UfnncOlERwO1SZgszRiLHXhCsSYwXu3zJrPSdZ9lidGx
 cuAPlWDVrvx86Uh259lcyi0zls1rJ6CmiLle54FQgh+CUfbnF3o3slfO+wE0YFgUiCcWjm5u3
 zNZj5rYX82AmUfoYmkoOyRISPhFNABLqnIoOEKPjuVkDOX7g81qIEZwXlA/qpATY41BAIUyX5
 fRLHBWDFHwijU8vfqk4YA/iR4Zj0ctf0tkG/eHgMwH9FQj/kL+2BNy6tsMhZRup4mNn4WyFGS
 kD3ThCJnflYtLczilwFPRh1VXLXySxQUq/7klfoTrR4M7n8Q3WNTLJ+MfuWCHwuQYpvCvPS1F
 v4tlk33mVsfAwHlMtw5fB6tehNFFy4k3xZvUfC9SLbReVBi6+TIr27pt9TYBrLzmP6kQlneFR
 fIt9JFy4G+YIR069Z/SnjmZpD7q1Oh5gGuw1l5gvrhPAaJajaSVoNHdC7veOXX5IScFzJ+QuG
 4CPC7NMc9yo6gAsSfZ/YitmVJJ4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/13 19:01, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> The test is calling _not_run but it should be _notrun, so fix that.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   tests/btrfs/213 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/213 b/tests/btrfs/213
> index 5666d9b9..6def4f6e 100755
> --- a/tests/btrfs/213
> +++ b/tests/btrfs/213
> @@ -55,7 +55,7 @@ sleep $(($runtime / 4))
>   # any error about no balance currently running.
>   $BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT" 2>&1 | grep -iq 'not in=
 progress'
>   if [ $? -eq 0 ]; then
> -	_not_run "balance finished before we could cancel it"
> +	_notrun "balance finished before we could cancel it"
>   fi
>
>   # Now check if we can finish relocating metadata, which should finish =
very
