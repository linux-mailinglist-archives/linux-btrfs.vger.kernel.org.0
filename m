Return-Path: <linux-btrfs+bounces-8276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77037987B86
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 01:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F921C228CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 23:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B11B0111;
	Thu, 26 Sep 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kOj5T8Y6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12611B0100
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392431; cv=none; b=ttjqMlqpBl5cUgjfQhdDUSNaHTm6+4wqbPUO5Q9t19L990jh4ZCHauAo5tsWVtuex4gMytQS5DIV1g7AOUKjI3wG1CrN/6HRB6Ov/vO1aQGJ2lfKSloOaLPZPfK6WCN/AgQgWu3fCpmqaCqs+wXlXs8EWNL8exE29EulswLYD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392431; c=relaxed/simple;
	bh=hIiCPlUJtK7lNbEcw/NWm9YRMHq1MD7jR79zL+0jOBc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F9qz6xTR85llTaldR51TBRu8/yMniuDSCmXwQQP/+wmk1/MxvnlgGE4bNiLZiA89DdXz4yQtCBZCjNljNcoGAFuIWYhuvPWCW+86tTkssO4G5U16drEzN4poYS4Kol7W95waxSALv4REhQGhPtnH3QqOalVjF6U757p0REFPi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kOj5T8Y6; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727392421; x=1727997221; i=quwenruo.btrfs@gmx.com;
	bh=hIiCPlUJtK7lNbEcw/NWm9YRMHq1MD7jR79zL+0jOBc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kOj5T8Y6Rg+PiQ+M1RZqdQqwsE8oD4aXflQF6OYGB3yiEo7LqFrw90d4S6IqW/tx
	 40xziKBGn4vsIfKJBUKxIbMDqmx73LYlb6n5PBAysj8T/zASAK/TN83g4i/8BEL9J
	 a9JtzJO5UEGz2g/4Cw/IaYuj7xEJmSKTxiIi32MGtOxUjJ5I9bPXNUOsZza5JlrtZ
	 rg071arNk5dVbYaGI39lZj+D43k/WXP5TsRJu1tWMDKCIXdLeUAULGpuRq9BcQdzw
	 jCvmTIMKPN9SV87xFtO7few/dnRGiT//Z6LZt88HVZQisaXk6Gy5nO6/9xFwMnI/Y
	 9BIOwN7Mx0zBOGL95Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1sPLrr3sqR-00QdZ8; Fri, 27
 Sep 2024 01:13:41 +0200
Message-ID: <f9062d51-946c-4142-9be1-ea8a2701592a@gmx.com>
Date: Fri, 27 Sep 2024 08:43:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Ben Millwood <thebenmachine@gmail.com>, linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>
References: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
 <1171b314-be9d-40cf-b3ab-b68b03a96aa2@gmx.com>
Content-Language: en-US
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
In-Reply-To: <1171b314-be9d-40cf-b3ab-b68b03a96aa2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HxNERs4a6pNSwPz8mgqjfl423XoBxotk3v5QW7A70jCQoy04wds
 D8Aw5GH45UdGXL0+9kiFew9jN6QiKN5+rm4LUz5fTAf4cMSkJAKGJRMFTUyX6AnAyKebMyn
 LowsDa8ae6PZ3LErOsziNegVlBiqv8yCF9uVp3PnaSvpK4zl4X6Os5qiYe0AjEHNk5NYhlQ
 o6jXNCOb9qkT0mUnNassQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nwk7tBn/V6s=;eAHnlht1xEWDct0vTjHFypze4Lr
 qd86tgmKGpH4U3Zdg/NAOqjk4rpuKSFEBkRQ+j2G2SgwXBGwCErDUKbmBbveLWsijnDQY8KT7
 n5YYNPaMJzxQ8J0hiB2tltcWchSB5cgc/w5hjw/8dhWU220NOyUpdr6JZ71fkOc/hnMMMXVl8
 OMXUgLPY9Nz1JWiISZtSDyDl7Cb+m+EpkO1WzPD5F92UXXzQm+YaFM9YtUrJBbAtT4MeUlmL/
 3rf6uxtM5Zrcx8qv2SaB4yYD0FlSQc7bv/bk0ZNoL3zpBG3xs+vv1tdWEQXUarq9xBsB8CNz+
 71OQZh05Ic4CYKQvzfAEgkL0rk2GtWrXKFe1zap1u9FZqwihYgbB4TfqgXbqKtbyspposxzly
 j55dBv4dDfKCtHc0e5FywWuIQXfB8IEUgjWuKNURLKexXsIatgvBL0764hpsD1izroKGyCrJ7
 fAaJK6MYxjxFzTA/fVbAOiUvyzoQnZPPOMKFc2cE7CF/JD2hgqVBI9RtuPoBylBot6uq8xvxB
 A5b7UpKGNZmuZWPy/Z+ddj9aCR0VTGS7kcy0oK0GwbRZR52WUPQPNXQJNoFW9z0D4dDIcufic
 HiQF1GBCKuBD8oqa0cGVf0+8pTsRq0YqOVCTRwohwKxsPHFk54yh8DfwSYQql/H4FDxzkWY6U
 dECOcZ5vFHlKeHHjfJucJwYtoE/vBsYDjx0+umgZ18wqKDnF72XI9lxPvumuSdQjpdfGu4o4x
 houdBsJiTy71ydK0dbiVPkkOfmTyFHSMxigdIYT+U/GORkZkx6ya8+5rBBp+o3NdP2jzPYlTu
 vaPRW+g+fJqVVFC4QGzfZ50ZML9RFdjTcoMz6MvZwwlwg=



=E5=9C=A8 2024/9/27 07:59, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/9/27 01:45, Ben Millwood =E5=86=99=E9=81=93:
>> Hi folks,
>>
>> I got these mailing list details from
>> https://github.com/kdave/btrfs-wiki/blob/master/btrfs.wiki/
>> Btrfs%20mailing%20list
>> , which sounds like it's deprecated as a source, so I hope the details
>> and etiquette guidelines are still current...
>>
>> Anyway, I'm seeing an error with similar symptoms as this old thing:
>> https://lore.kernel.org/linux-btrfs/87blnsuv7m.fsf@gmail.com/T/ , but
>> likely with a different cause.
>>
>> My setup is:
>> - My btrfs filesystem has two top-level subvolumes, /root and /snap,
>> which I mount into / and /snap respectively. (I don't remember exactly
>> why I did it this way, to be honest.)
>> - I have a regularly-triggered systemd unit that runs: btrfs subvolume
>> snapshot -r / "/snap/root/$(date -u --iso-8601=3Dseconds)"
>> - I have two external USB disks, and I btrfs send -p
>> /snap/root/LASTSNAP /snap/root/NEWSNAP | btrfs receive
>> /mnt/USBDISK/root/YEAR for each one (I have scripts to do this for me,
>> but I've reproduced the issue without the scripts. If you still want
>> to read more about them for whatever reason, you can find them at
>> https://github.com/bmillwood/backups )
>> - Periodically I btrfs subvolume delete old snapshots from /snap/root.
>> The ones in the external USB disks stay there forever. (I don't have
>> crazy amounts of data, so this has been sustainable so far, but it
>> does mean I have over 3k snapshots on there, which is perhaps
>> unusual...)
>>
>> This more-or-less works most of the time, but recently I have a
>> snapshot that won't co-operate, failing with "ERROR: failed to clone
>> extents to home/ben/code/nix/noether/etc-nixos/system-packages.nix:
>> Invalid argument". This happens with the same snapshot + erroneous
>> file path for both of my external disks.
>>
>> I redid the send / receive pipeline with -vv on the receive:
>>
>> btrfs send -p /snap/root/2024-09-12T16\:29\:16+00\:00
>> /snap/root/2024-09-12T17\:04\:17+00\:00 | btrfs receive -vv
>> /mnt/electricaltape/root/2024 &> /mnt/electricaltape/receive-vv.log
>>
>> and here's tail receive-vv.log:
>>
>> unlink o1209472-383-0/vmsish.3.gz
>> utimes nix/
>> store/.links/0h84wh2xnnfqram84dsszzii4v2r497hvxsvbxfyppgfnwc3c4rk
>> unlink o1209472-383-0/warnings.3.gz
>> utimes nix/
>> store/.links/0kh81sw0mh5sm7sgfb5g99rgb45qw85qs1s8qndjh4kchi0j1jq6
>> unlink o1209472-383-0/warnings::register.3.gz
>> rmdir o1209472-383-0
>> utimes nix/
>> store/.links/02m8fllf71vlf6wwx2h72k2adfx015gq8sxmbb5b52xdv3rq012l
>> clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
>> source=3Detc/nixos/system-packages.nix source offset=3D0 offset=3D0
>> length=3D4985
>
> The length is not aligned, thus it's causing problems for the receive en=
d.
>
> It looks like it's the slightly behavior change introduced in upstream
> commit 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if
> it ends at i_size"), which allows the full full clone even it's not
> fully sector aligned.
>
> In that case, I think it's better to make receive to roundup the clone
> length so the clone call won't be rejected by the kernel.

My bad, it's not the case.

Kernel itself can handle such case without any problem, so it's not the
unaligned length.


However from your receive log, it shows the file should have the correct
size:

133380:write etc/nixos/system-packages.nix - offset=3D0 length=3D4985
133381:truncate etc/nixos/system-packages.nix size=3D4985
133382:utimes etc/nixos/system-packages.nix
316933:clone home/ben/code/nix/noether/etc-nixos/system-packages.nix -
source=3Detc/nixos/system-packages.nix source offset=3D0 offset=3D0
length=3D4985

But there are quite some operations between the two, mind to dump the
full send stream by:

# btrfs send -p /snap/root/2024-09-12T16\:29\:16+00\:00
/snap/root/2024-09-12T17\:04\:17+00\:00 | btrfs receive --dump &>
/tmp/dump.log

And send the full dump.log?

Thanks,
Qu

