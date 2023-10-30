Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B944A7DC166
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 21:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjJ3Us6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 16:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJ3Usz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 16:48:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B821AED
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 13:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698698926; x=1699303726; i=quwenruo.btrfs@gmx.com;
        bh=NL4nijApwzz1gGMajk1L0YiUuxEnwT1rVMPzPMZPRgo=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=QyYxBpDhe/kNpt7RP75JPJfzUSJo8U3h1jMu/94uNwEYlS2XqyAZkjrCNzi9wTHC
         xllmnHeHeR112DjkU0s4g5IzS8A9KiqE4HvznCPoX8s5kTEBUsXH3bTqC8alnoQjf
         LUwv5U3FcwO6r9kd3KjPyMXJtLG9y5rEcrYhq68AcsVIc1U68jcsgLLHyWjvtRAuc
         tO0QfG8LWrLYfx1+g+KgSnMJu/t7LPLpdDoJT8+/xbquAvrvNomAfu0acq4SVL7wU
         ZL8lJrG/lj+oJE+HRULl+eTiXTQ9Zv10j9GNf4d9FqaH6NzDVA9EqT+4FNIbCInJX
         CtjnZ5J4gx12DkSRJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDp4-1rLxjR33OK-00xXKw; Mon, 30
 Oct 2023 21:48:46 +0100
Message-ID: <0cea4066-260d-463e-bfb6-ab557a0d1a6f@gmx.com>
Date:   Tue, 31 Oct 2023 07:18:42 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error pointer dereference after failure to
 allocate fs devices
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
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
In-Reply-To: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Ee2dazemY+EFRDYxO1rXQYrKnobY1zT/sbxUar1fPZf6MVj7c9
 G/x6yNfaNY1Xunz6CxUG90bB7DQ19qZzKySX1+YoBBmkPwKxt9I9uM1VoHLKNHlmeN3u9FL
 jdIA5tVNaztgdo1Nb6f0ydRXGyiOyOkhdM9omYpRkUVtjt89wrVBOirOKdVFPTyu7wmK4tr
 LHovMeHgdYS4sPKNILnsA==
UI-OutboundReport: notjunk:1;M01:P0:i2HgRkCb2fY=;DBdOj3H/HXHoumMgQf+g5nQ4hxw
 ATbo9P1nbUZtxRc20D2afw0lOpD1cpWidpHvfGbiRDv/yTNkXBuLiAYlfuqzxsoHTuQPyTBJa
 PZUsvCfB3YGoSXgGF03ZUAIYlhFdHBtS0BH581Raqy3rmbJg/58sXYznjmRapDnfz3BWNOcvR
 uOgF5oZhgHSifC67vsUL2u6EA1MR1HMCXR61VrdShdf3nSo3uhMRgBbrnRWGdgrpuJaPvinVP
 d4YncW0pu3izbAyt9pzSrdysioJ6oYceRZAhJdC+6kbtHATpzNlPGvi6QIfH45LhmzIHj7RU4
 dFtJOeuBiXPJd7KBDnySEvO9uanh7kWZBf9om9GfVvcTJtjCV5jtv8uDbqli/WWOoLJ0FYBlc
 N3/N6xIc3IW2hPfzTJjfj7EAr7nC65A3Eq0w/dUBLKhI3eXPIOL/dBJAN9NWcQzhzsmODqwve
 O7/QjEAgUmva+6ODyfoMfMM/URKehseCmR8bv8NZHk88jhapjdUwuNAtruHD2ClJMTXJXKHDG
 y+pC4q75iowwbJnR/S0HcAjMiNMGjKwV5A1HMaiFR/Z/eqbgNsZzVnS2DIyQyrPeNiM4p8Oda
 nafnWGIXOd1uOU8TJK+dDES9aCd5TJW7x4gB3yh3bc1bA2ZicXPTDsDx5nPv1Anq6GMo3VQhL
 iTqJtSM/LWcg3we3Oid1628RSbhGX7mJW/8BU9Yuk9Dkk96kDcunyicSwte7zfObgeym2lSpq
 Q1uLxUwPx0lEh2DuYDybt8OfF/iXiqwAcTK6rhHpoRzWMO81nI/fW/M1Iu24NelKw9SvfjhU0
 KEVJrIglg/k+LITYV2OYya6907+xiFW23XDKedfU9ZspcebYx9WgDBduZBS+ZS3oOL7e8JAoP
 OdNTyVsr5r0yVIPsjsz5nYzGyAPk4PpquI95ia+id9fTbcszYnTcqmPenrsvzUXGHzIoGimf0
 898lVWb7gRWUAEWOtJVN6Xhxf7A=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/30 22:24, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At device_list_add() we allocate a btrfs_fs_devices structure and then
> before checking if the allocation failed (pointer is ERR_PTR(-ENOMEM)),
> we dereference the error pointer in a memcpy() argument if the feature
> BTRFS_FEATURE_INCOMPAT_METADATA_UUID is enabled.
> Fix this by checking for an allocation error before trying the memcpy().
>
> Fixes: f7361d8c3fc3 ("btrfs: sipmlify uuid parameters of alloc_fs_device=
s()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/volumes.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1fdfa9153e30..dd279241f78c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -746,13 +746,13 @@ static noinline struct btrfs_device *device_list_a=
dd(const char *path,
>
>   	if (!fs_devices) {
>   		fs_devices =3D alloc_fs_devices(disk_super->fsid);
> +		if (IS_ERR(fs_devices))
> +			return ERR_CAST(fs_devices);
> +
>   		if (has_metadata_uuid)
>   			memcpy(fs_devices->metadata_uuid,
>   			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>
> -		if (IS_ERR(fs_devices))
> -			return ERR_CAST(fs_devices);
> -
>   		if (same_fsid_diff_dev) {
>   			generate_random_uuid(fs_devices->fsid);
>   			fs_devices->temp_fsid =3D true;
