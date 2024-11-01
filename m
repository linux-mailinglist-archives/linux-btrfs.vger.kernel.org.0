Return-Path: <linux-btrfs+bounces-9303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6EA9B9991
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 21:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C51C21B3C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC41E0DFC;
	Fri,  1 Nov 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Zl+JxrD6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BEB1D9A57;
	Fri,  1 Nov 2024 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493535; cv=none; b=uEZz+sJoEI4kaFg0t7+w3E47I90bEFZ+5X/FPrVsVWPXguCKNUM6M2jpkjSc9lzC1rIlIr9U7VgPqY8nuvXi2hB/zRRpjId7WB+eVKVFgDtBPr2Ir7G+Oryp7dL8yuIjDmNHIbu3flugYEzPHVZmsQ4pIn78JuUBP+CvvmBjv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493535; c=relaxed/simple;
	bh=LbeAvpeGzEEdswwvXXAai6DT38hHZtkxpIBvXkTaxPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDw6yhSA1SuTqZ2yumHJtRoRWeayjbqcROzijJZKNJrx10KSeu/J9hfiD6AzU7KxPC/PMKdqOw949R35rs70BGlni19k50ySz52YLh2XqUynd5PA3hnip5f44X6mpBJFAiduEoMRzAuSgVlHsTFAGX935VyuYzsxbbx/V+refok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Zl+JxrD6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730493528; x=1731098328; i=quwenruo.btrfs@gmx.com;
	bh=0s+L56v4O0dWA+Gqog3uIkOy4Q0RwHasootLmorD4EY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Zl+JxrD6ReQn9c3ihNizqs5/7DFugNNW6mglXJnLVLBWj3mX756E1ST8Yiz4hqdz
	 JctTEpYvaHIJycwIi+cAPvZZITHrQKG+dgHmTN9OZhPbPzQJKap/Q/LlPL7zNJ1UE
	 PI/MeetdbtcEkY3yk5pJpQsj4xUw6oUNNG7iAztNYCi/F2nDPhOWuZihirvaMFW2x
	 mNlmwesjoDjlzNSrnZGzmW54CSHTvUX518EmncPl5IJoiE5W8pPCuXgXMKFZ1yxbi
	 xBFMI8L7arXH7dILPi+t0dA1yNE3JDnQekOyVgapDdg85nai+i+ogH09xYdIgZ4H3
	 uBfUVxnNqMOZJhWSWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9G2-1tbJ1l1a4s-00bMZX; Fri, 01
 Nov 2024 21:38:47 +0100
Message-ID: <867b68d9-d873-4416-8d6d-be56bfc11542@gmx.com>
Date: Sat, 2 Nov 2024 07:08:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: a new test case to verify mount behavior with
 background remounting
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20241101102956.174733-1-wqu@suse.com>
 <20241101125517.kb7akqvi5tae3wor@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20241101125517.kb7akqvi5tae3wor@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ejI492eA6ZsXQ5Tnl87ug+sj4hY+OLtXdGpgb+VCTsw0kHwQCSE
 uT2vBFxwkusLtzsbshbmtpbJA1+H21Oc3XNlgLVlKi8sAZ5BMYRVWKbx6/M42shRI5Re/qS
 BbBo3SNJHAjVTkVbwoHaE2VsranbB4i6SSaWKtksiGg8KGE5H/0sIt190q62D4sLCCDyXM5
 uRmQGtZ/BcLb8QOilrsYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a7J+HiQk5LE=;jJ6rjKta62Bq7hilQa82uSZZxoY
 EDMV2qAuKlr9b8ZH8OsXSVXekB6ScWVJptXbtNiUyOCi9w1NdLUzRpa1DgNphd0a8W/znuszF
 79/8ILH8+2e2OxoyeRDsHrkd4821w15uYenOUIaSyTiaWNhjNn271L6y/+Pp3AvHa0Z4IXhMB
 j+DyTzG6i0J9hprq8n1zYX0zbbvQDXbERQFM9dLRtT7hF0xxX1LHvsu+2JQ44auEBM2xC2R9k
 sbrL3+1gxWGfm+p6hJAnMNP9+V0M8braxDTO0kLex6fcBqANGh94CoZJ7QtBzjaFUHS4PQ+l4
 vie+cqXO/QoOCdAcqc95rfHf8ha1/tZzgb0zDC8TT81EGbyz7mSc9tXVO93B9oSlx9IoGe9Ew
 s+k7h0qhKxkDqH4cENyaoc5b7jBtF/y5jqFmBsyeCpohgBrY3WQqhCQ70qTRmWXx+rmQkJ7Xz
 APU8y8Mf9bEEqP0OG2iw1OrGjSxfMbQZt+Qnpx/xXPaqb7b4jAbsTa4e4tAoA2MfvCjNF0+ht
 eajlV2pkHWZ4xvdbPdqRbGbtJp50/RKclQWw+SA2stM2Zxi1rUO03g38gVJKwuyaJq4fzC01A
 YIzU02qmBGQ2yIKuUYXRG6atICt0h/X20VSxGD6wOrj3eMMRLa/POGp2Img0gO/L1P3SBOe9S
 cr+w/djzuy4hqNP5n7XwuU7OnrHA0FAJ0Ug+FAVaywSfBLjVC2bg07XsmTBiPqqDuG/y4pOe/
 LfozsFY5UB94Tfw16BQmbJOWkImXKiYS9e5MybAHW/QquOwkanWoDvTeA4wJdv1mA2y7XJ5OY
 MQScMHbUhtdKSsYfHoNwEKrg==



=E5=9C=A8 2024/11/1 23:25, Zorro Lang =E5=86=99=E9=81=93:
[...]
>> +_cleanup()
>> +{
>> +	cd /
>
> rm -r -f $tmp.*

The test doesn't utilize any temporary file AFAIK.

>
>> +	kill "$remount_pid" "$mount_pid" &> /dev/null
>
> With below "unset" (see below), we can:
>
> [ -n "$mount_pid" ] && kill $mount_pid
> [ -n "$remount_pid" ] && kill $remount_pid

If both pids unset, kill will do nothing but shows its usage.
In that case since we re-direct both stderr and stdout, it will not
cause anything wrong.

>
>> +	wait &> /dev/null
>
> Just curious, what can cause "wait" command print something?

"wait" can output errors for invalid options or the pid is not a child one=
.

But without any option it doesn't seem to output any error message.

>
>> +	$UMOUNT_PROG "$subv1_mount" &> /dev/null
>> +	$UMOUNT_PROG "$subv2_mount" &> /dev/null
>> +	rm -rf -- "$subv1_mount" &> /dev/null
>> +	rm -rf -- "$subv2_mount" &> /dev/null
>
> rm "-f" prints nothing, so
>
> rm -rf -- "$subv1_mount" "$subv2_mount"

Nope. it can output error like -EBUSY if any of the mount point is still
being mounted.

Thus to be extra safe I prefer to do all the redirection in the cleanup
function.

As I have hit problems inside the cleanup function too many times,
mostly because the previous version is lacking the signal handling for
each workload.

>
>> +}
>> +
>> +# For the extra mount points
>> +_require_test
>> +_require_scratch
>> +
>> +_scratch_mkfs >> $seqres.full 2>&1
>> +_scratch_mount
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 >> $seqres.full
>> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 >> $seqres.full
>
> Hmm... I wondering what'll happen, if remove these two lines then run th=
is test
> on other filesystems :)

Not sure about other filesystems, but do other filesystems allows
different RO/RW flags for the same fs?

>
>> +_scratch_unmount
>> +
>> +subv1_mount=3D"$TEST_DIR/subvol1_mount"
>> +subv2_mount=3D"$TEST_DIR/subvol2_mount"
>
> Better to try to remove them at first. We can't make sure these names ne=
ver
> be existed in $TEST_DIR.
>
>> +mkdir -p "$subv1_mount"
>> +mkdir -p "$subv2_mount"
>> +_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=3Dsubvol1
>> +
>> +# Subv1 remount workload, mount the subv1 and switching it between
>> +# RO and RW.
>> +remount_workload()
>> +{
>> +	trap "wait; exit" SIGTERM
>> +	while true; do
>> +		_mount -o remount,ro "$subv1_mount"
>> +		_mount -o remount,rw "$subv1_mount"
>> +	done
>> +}
>> +
>> +remount_workload &
>> +remount_pid=3D$!
>> +
>> +# Subv2 rw mount workload
>> +# For unpatched kernel, this will fail with -EBUSY.
>> +#
>> +# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
>> +# mounted RO, unpatched btrfs will retry with its RO flag reverted,
>> +# then reconfigure the fs to RW.
>> +#
>> +# But such retry has no super block lock hold, thus if another remount
>> +# process has already remounted the fs RW, the attempt will fail and
>> +# return -EBUSY.
>> +#
>> +# Patched kernel will allow the superblock and mount point RO flags
>> +# to differ, and then hold the s_umount to reconfigure the super block
>> +# to RW, preventing any possible race.
>> +mount_workload()
>> +{
>> +	trap "wait; exit" SIGTERM
>> +	while true; do
>> +		_mount "$SCRATCH_DEV" "$subv2_mount"
>> +		$UMOUNT_PROG "$subv2_mount"
>> +	done
>> +}
>> +
>> +mount_workload &
>> +mount_pid=3D$!
>> +
>> +sleep $(( 10 * $TIME_FACTOR ))
>> +
>> +kill "$remount_pid" "$mount_pid"
>> +wait
>
> unset remount_pid mount_pid
>
> to avoid later kill (in _cleanup) kill other processes.

IIRC the child pid won't be reused until the parent process exits.

>
>> +
>> +# subv1 is always mounted, thus the umount should not fail.
>> +$UMOUNT_PROG "$subv1_mount"
>> +$UMOUNT_PROG "$subv2_mount" &> /dev/null
>> +
>> +rm -rf -- "$subv1_mount" "$subv2_mount"
>
> Do this in _cleanup (as above), so this line can be removed if it's not =
a
> necessary test step of this case.

This is an extra safety check, to make sure the unmount is properly done.

And that's why here we do not re-direct the output, unlike cleanup.

As I have already hit cases where the rm returned EBUSY error due to
races with the children processes not handling signal correctly.

Thanks,
Qu
>
> Others look good to me.
>
> Thanks,
> Zorro
>
>> +
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
>> new file mode 100644
>> index 00000000..cf13795c
>> --- /dev/null
>> +++ b/tests/btrfs/325.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 325
>> +Silence is golden
>> --
>> 2.46.0
>>
>>
>
>


