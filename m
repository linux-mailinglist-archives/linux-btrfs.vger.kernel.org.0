Return-Path: <linux-btrfs+bounces-5001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C18C5E02
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 01:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE9B21324
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 23:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C0182C96;
	Tue, 14 May 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Sq1cJ7vD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BE182C90
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727908; cv=none; b=r23FWc/efIeXoNdalo+m9PrCdaa0Lt2Fi0MKbiJXgRB2iO6m8I14br640JN3FL+fAoR1If01YnwQLPGS1iR0M92YL4s2BvWoqeFNO8dlK9c+3UnnwB+XvpmyTAquNJPukM+4k9T8lFXL08Vkbke0bvxTw4j0IBkp/EyawVV0L9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727908; c=relaxed/simple;
	bh=Jso1PdX9FQJOtPiWMEhV4ShTS7myi8JiDvWuSObRka4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j4jGflnUVn7KoUMSu3Kpqh6SK6QuLk4KmJJlXqBXq8fXKgrBxqedNAo/VCWImKnNQHCM7Jw64kiKrLIFBMqmQwL+KWOAqSPx9s2NP1yDZ45dG4qCScS2/3+FA/+xDQZ6OBaOQzEH9heU32Pj8sjR3VBV1ynvYhEaB4IUbFP1S2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Sq1cJ7vD; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715727901; x=1716332701; i=quwenruo.btrfs@gmx.com;
	bh=y3F+cXSsZuvSFUk8Q4G0aY7aIBI3WSO7+SXUvgBbvgA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sq1cJ7vDjLSFTfERDMIUF1dD9kBAs4QsihHX90a1xgEbzaZ7yTEYLKKUg7e2WjIU
	 W80MXWcF7rHUw7yxkfsNbwDHS8hlHmju5EdP9Z7D8uKh+9eJAk+EJgMcga69n9PHd
	 VYZqh4d9eN9c3ezPpWbu50JahlMS/dcM9/GxcwP3Jz5CKshdASJ2Fw0Vcb62E5DzJ
	 NGB5Y2TiFzKXy19JuB3KHJOIIlVqqzJbjXW6wsRkkNyAFJ3iVpAfqtP1TRpTy7o5D
	 LeLeAPkasaQUKDQJ7guuXEEAPCOvUO6GRP8RJbgKUj8MA0mLemfor+H8I2ypnO2Qj
	 CIZd/sayN6MfgR/oew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNJg-1s1yso2gr4-00YfS2; Wed, 15
 May 2024 01:05:01 +0200
Message-ID: <65db4776-b74f-48f0-ab7f-b33f56e1c00c@gmx.com>
Date: Wed, 15 May 2024 08:34:57 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] btrfs-progs: add test for zone resetting
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-8-naohiro.aota@wdc.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <20240514182227.1197664-8-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lrdfFsMXVofd8wD4lmDzd/9ZYNU8oqqzOYUNhNOE8L7rqNt66f+
 Y75Cojz8rPzHKYar5p8xs5SHVXzEW1B1ag7g0BiP3uhO7gz6t52qRIjRu1jJvP0ODrW4C5j
 /8/nWABsoAv6Jb/Xl7ex47XLIysk8D9AA5wWaPnNQgUtRjpsEqnbsV+SMiWn1D+yJhcmoMi
 9Q8FlHCQ0WbYm6uUjmRxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hakm/EozaDw=;0X5AsPEPXVLlmodj/3GuZWtA/6B
 pwCGfCjfrqNeWe0mRXRAvX8MkchJQgOErIRkvhx1Tk35haToYGWSCcXoOAZ7f6mmZxijWllZv
 1c5hlQ4yQGinrTDmNKom9PtRNEEiYDINMFRS9OtgJPAMxVlFDlfjLDnpSGymdhcHJ1aU07pfa
 hYjW67mFYyt+nbjJAXhr8UupTqbk0llADFhhKFMmPp1Ahq63hPiQiCf0O5uFW43ihZFrIVNsA
 /ARXIepErdzqJ7YwTNZQoXp9+g/eP8EO0NKoqbv7NjbkaROrydWx4V05d0RP0zpar9YYeAM4J
 kXBFlxq7wd+ciAuLn1htDBllOZSU571SBf/rp37k9Knfv9fyjDXwt2rv2RavbMdX+N8cDKrgr
 klQg84r18jgS3lMMv6R0QuLdiGHYeNZzuQhBdtMJIGv6GUd1r2Nq2KOjnkA476kFfVNSNMTDt
 iTa3hpjd+AaVcUTDW560UXKS4ndKxkQTjsUCpQTtATurylm3xMH2sAX2N5QwBCDZe95jySFJr
 yfjgbKCqPL+IjY4XiNzE39WUHy9Ro1CzZQo+t+4r9cap6paPb6VOx8B4Qv6Df8nSeF6T2p2gQ
 zwSul1xC4XThlNSm+Orkai4FGjMg1YrMKsGLPcCbGQeeWDFjTvuvuXgxdPL6cRP2vM6JTfh4t
 5WhY50HxCS4AUhr3jvREZGkUCLUA68QKP5yGUd5eHD8ua/QnTZe4Qo0zTobb+E0iiIhoakj52
 nE8U9bbyyUDYQUT72rDQFhCOARWYXpoPmCoTzBO5oChCDQwK9pzhoJlIS/vEP20hZS4LS+guW
 2ibQmqENC0Vmq8uTL/ltrAbgjw2SNcvGdbmcYgM4OZ7i8=



=E5=9C=A8 2024/5/15 03:52, Naohiro Aota =E5=86=99=E9=81=93:
> Add test for mkfs.btrfs's zone reset behavior to check if
>
> - it resets all the zones without "-b" option
> - it detects an active zone outside of the FS range
> - it do not reset a zone outside of the range
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   tests/mkfs-tests/032-zoned-reset/test.sh | 62 ++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>   create mode 100755 tests/mkfs-tests/032-zoned-reset/test.sh
>
> diff --git a/tests/mkfs-tests/032-zoned-reset/test.sh b/tests/mkfs-tests=
/032-zoned-reset/test.sh
> new file mode 100755
> index 000000000000..6a599dd2874f
> --- /dev/null
> +++ b/tests/mkfs-tests/032-zoned-reset/test.sh
> @@ -0,0 +1,62 @@
> +#!/bin/bash
> +# Verify mkfs for zoned devices support block-group-tree feature
> +
> +source "$TEST_TOP/common" || exit
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +nullb=3D"$TEST_TOP/nullb"
> +# Create one 128M device with 4M zones, 32 of them
> +size=3D128
> +zone=3D4
> +
> +run_mayfail $SUDO_HELPER "$nullb" setup
> +if [ $? !=3D 0 ]; then
> +	_not_run "cannot setup nullb environment for zoned devices"
> +fi
> +
> +# Record any other pre-existing devices in case creation fails
> +run_check $SUDO_HELPER "$nullb" ls
> +
> +# Last line has the name of the device node path
> +out=3D$(run_check_stdout $SUDO_HELPER "$nullb" create -s "$size" -z "$z=
one")
> +if [ $? !=3D 0 ]; then
> +	_fail "cannot create nullb zoned device $i"
> +fi
> +dev=3D$(echo "$out" | tail -n 1)
> +name=3D$(basename "${dev}")

Can we wrap all the zoned devices setup in a common function?

I believe zoned tests would only increase in the future.

> +
> +run_check $SUDO_HELPER "$nullb" ls
> +
> +TEST_DEV=3D"${dev}"
> +last_zone_sector=3D$(( 4 * 31 * 1024 * 1024 / 512 ))
> +# Write some data to the last zone
> +run_check $SUDO_HELPER dd if=3D/dev/urandom of=3D"${dev}" bs=3D1M count=
=3D4 seek=3D$(( 4 * 31 ))
> +# Use single as it's supported on more kernels
> +run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -m single -d single "${dev}=
"
> +# Check if the lat zone is empty
> +$SUDO_HELPER blkzone report -o ${last_zone_sector} -c 1 "${dev}" | grep=
 -Fq '(em)'

You may want to use `run_check_stdout`, as that would dump the command
and its output into the log for easier debug.

And since the test is relying on external program `blkzone` you may want
to put all those requirement into a zoned specific helper like
`check_zoned_preqreq()`.

Thanks,
Qu

> +if [ $? !=3D 0 ]; then
> +	_fail "last zone is not empty"
> +fi
> +
> +# Write some data to the last zone
> +run_check $SUDO_HELPER dd if=3D/dev/urandom of=3D"${dev}" bs=3D1M count=
=3D1 seek=3D$(( 4 * 31 ))
> +# Create a FS excluding the last zone
> +run_mayfail $SUDO_HELPER "$TOP/mkfs.btrfs" -f -b $(( 4 * 31 ))M -m sing=
le -d single "${dev}"
> +if [ $? =3D=3D 0 ]; then
> +	_fail "mkfs.btrfs should detect active zone outside of FS range"
> +fi
> +
> +# Fill the last zone to finish it
> +run_check $SUDO_HELPER dd if=3D/dev/urandom of=3D"${dev}" bs=3D1M count=
=3D3 seek=3D$(( 4 * 31 + 1 ))
> +# Create a FS excluding the last zone
> +run_mayfail $SUDO_HELPER "$TOP/mkfs.btrfs" -f -b $(( 4 * 31 ))M -m sing=
le -d single "${dev}"
> +# Check if the lat zone is not empty
> +$SUDO_HELPER blkzone report -o ${last_zone_sector} -c 1 "${dev}" | grep=
 -Fq '(em)'
> +if [ $? =3D=3D 0 ]; then
> +	_fail "last zone is empty"
> +fi
> +
> +run_check $SUDO_HELPER "$nullb" rm "${name}"

