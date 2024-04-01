Return-Path: <linux-btrfs+bounces-3804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4CB893855
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 08:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DCD1F2138C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 06:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DFA8F51;
	Mon,  1 Apr 2024 06:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s4z8gfKd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B48F4E;
	Mon,  1 Apr 2024 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952515; cv=none; b=Lufuo63O8AV/Xa1t8azQms0DQWZhtEMy/ok/v/oRsrjBHWFC6kNBkOIpSJAwxBY7YwktN0D2oWCeYqNbsvgq/B/mGz7a8epySq49xUVLfZXI53mmxUbxxv7T4Rljqpp4eHTsTxODc9Ie+yK2VZ6BlP5zigNFNjbhNTQHEgqPDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952515; c=relaxed/simple;
	bh=d3IOuB3QzEp+u4cdJLckWvBvmqXD3DMltoFAQ3E1tOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snd/aXmZjljQfWHNTkDdsS6NgN6qZG7YVp/CZzBlLLVrdU9u9dCi4XuesBJun5MrF4ONbFb2fkDuuEOdVOKcE9I4ozgi+tcAVSOonZI7jXR3DseqBRYS5su85Xmik8/dudw1JfO7l6ck8Q2fGR3tJ+decopTDPX7S3V6SkWfGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=s4z8gfKd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711952507; x=1712557307; i=quwenruo.btrfs@gmx.com;
	bh=oAvZ68R3XnYq08f4GMHvw1pOli0vxF70uWlv1x1DQis=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=s4z8gfKd96/dprr/JtexgmMv2vaTyQ2INdhuMELgpy0qtRTCFQBEqcj/v3dqY87N
	 w6/x1pYIPP2odo6kbaoKrxDfbtYPQtvdW2HGdczoMttj3K4BaNT6KsSh7q4Xjn7MY
	 Wc1jqa5sK2jsMjXZJZMoFrJPctuN9RnsIX/6gz7JfcBx8iN4I+G/BOO62z58qozfu
	 54YSzptpIeOZIposQI6gy251YVGaqyv5/Vm8+14PcWMbZduVzkKp7i48N+YitEKuM
	 qjcu9XIjUXc0hd7OEaAxkKDMQ3NH/vdoMnHnOuZAh4ojOJmhbfD3LB6NkRLPU8eDl
	 5Iq/3KK11nq8RXUxMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1sGjJ93aOb-00U1xp; Mon, 01
 Apr 2024 08:21:47 +0200
Message-ID: <a21b3427-ae9f-42e3-a335-3fcb3c10e081@gmx.com>
Date: Mon, 1 Apr 2024 16:51:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/btrfs: lookup running processes using pgrep
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <572b5b3f11cc414bd990d1580f8bf287f4797676.1711952124.git.anand.jain@oracle.com>
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
In-Reply-To: <572b5b3f11cc414bd990d1580f8bf287f4797676.1711952124.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sZgPXngnvPumjGBUeNBhCvO8P6rx6ysCqW/rkftoEfH3692XHYg
 2TKcaSURQHZc/We/bZl035s6+HRnvfdWyICtswrKHJFqMIl0mS8zkXOOd4LT1lFD0Iyx1Su
 n9Foz7o/wWkpN8EJrkfixCPDl5/0DMy6nrJ/KPRV6kAZRzQZK65O/H58mu88Qz1bUpVZR+W
 3NPhRNDwRxtON26zEhq5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+l/Y8p+dNpU=;jvaNf/7YbisBrKh5Nqkv4B7Bea9
 yK/8d1mW9Wg/0E1Txjz/eElCPgBjrP40syYyiFJRLEqIw26RxsDhC6oHPXjUh99Ye0M4X91c5
 IBPFS2jEUf93XCoht0mFoyhsQbzT3TbO6zfNm1gGVs4zFG79stc0+HJiqZui95gObHzWvbKp3
 RglSVh5uQd+INXvCJ+tIQZcxJhPgRiaQqClAsuiw2oQjAKirXQ4glIqbKpwZpa5JAjIxfKQ8K
 Vkp4qO/48pQFuJx5JKSaX6A+2HvxeCcgftQnfTQZg4I02ih/5vWbThTws6gGxVAiOCnxzytz5
 IAZKE6Y71thhln+oUcLnh2rZbplXCu/EKb55tWyJJKcWCP3SLQsyiqyZaX+MKKbKpTXpRDaMZ
 CKg3+irc1GNU049XwCUIuPr3hYo8/9DxkNZDeN2dQFlF2+Mvht9zd+WZR1t0H3ZgPaxoPhfBu
 Xp3xojSZKwf1M/tXTOlCFkSSlZobkOjwyZoRasHezrByHu9qyfv67pH69evoERRJbpLBL2R0r
 JZXrTTO5OvhvYjOZBRvQFGyHhOgYok0cn6qfJqHaZpYMjtb/2L/cbTyTe39gxFdWtWnx/RrCo
 NL7bQPgh40x5ovKnNzoo6C+aboBhJ/VlB2FIcckaek6rwA3InGd3adyGG4mAPL76q6assnDxR
 B+8UnLhjECx81d4ZkONPDNmlmNNHM/ZXRM1zZgsIt5jZz03U4zRaoIT2WTJf+WqB3fejnAyTB
 978TNWxY2etHKa47JyXpumLE7OvrjMb3/mr+NRTmjHU0egmk/LkXuahG83RQI4UZui4dLk7Aa
 VGQEieRd9KKq0oo8KJ0LSW7ytapqEzbYlCawdB/SO7z5A=



=E5=9C=A8 2024/4/1 16:46, Anand Jain =E5=86=99=E9=81=93:
> Certain helper functions and the testcase btrfs/132 use the following
> script to find running processes:
>
> 	while ps aux | grep "balance start" | grep -qv grep; do
> 	<>
> 	done
>
> Instead, using pgrep is more efficient.
>
> 	while pgrep -f "btrfs balance start" > /dev/null; do
> 	<>
> 	done
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Looks good to me.

Although there are already several test cases utilizing pgrep, I'm not
100% sure if pgrep would exist for all systems.

Shouldn't there be some checks first?

Thanks,
Qu
> ---
>   common/btrfs    | 10 +++++-----
>   tests/btrfs/132 |  2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/common/btrfs b/common/btrfs
> index 2c086227d8e0..a320b0e41d0d 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -327,7 +327,7 @@ _btrfs_kill_stress_balance_pid()
>   	kill $balance_pid &> /dev/null
>   	wait $balance_pid &> /dev/null
>   	# Wait for the balance operation to finish.
> -	while ps aux | grep "balance start" | grep -qv grep; do
> +	while pgrep -f "btrfs balance start" > /dev/null; do
>   		sleep 1
>   	done
>   }
> @@ -381,7 +381,7 @@ _btrfs_kill_stress_scrub_pid()
>          kill $scrub_pid &> /dev/null
>          wait $scrub_pid &> /dev/null
>          # Wait for the scrub operation to finish.
> -       while ps aux | grep "scrub start" | grep -qv grep; do
> +       while pgrep -f "btrfs scrub start" > /dev/null; do
>                  sleep 1
>          done
>   }
> @@ -415,7 +415,7 @@ _btrfs_kill_stress_defrag_pid()
>          kill $defrag_pid &> /dev/null
>          wait $defrag_pid &> /dev/null
>          # Wait for the defrag operation to finish.
> -       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; d=
o
> +       while pgrep -f "btrfs filesystem defrag" > /dev/null; do
>                  sleep 1
>          done
>   }
> @@ -444,7 +444,7 @@ _btrfs_kill_stress_remount_compress_pid()
>   	kill $remount_pid &> /dev/null
>   	wait $remount_pid &> /dev/null
>   	# Wait for the remount loop to finish.
> -	while ps aux | grep "mount.*${btrfs_mnt}" | grep -qv grep; do
> +	while pgrep -f "mount.*${btrfs_mnt}" > /dev/null; do
>   		sleep 1
>   	done
>   }
> @@ -507,7 +507,7 @@ _btrfs_kill_stress_replace_pid()
>          kill $replace_pid &> /dev/null
>          wait $replace_pid &> /dev/null
>          # Wait for the replace operation to finish.
> -       while ps aux | grep "replace start" | grep -qv grep; do
> +       while pgrep -f "btrfs replace start" > /dev/null; do
>                  sleep 1
>          done
>   }
> diff --git a/tests/btrfs/132 b/tests/btrfs/132
> index f50420f51181..b48395c1884f 100755
> --- a/tests/btrfs/132
> +++ b/tests/btrfs/132
> @@ -70,7 +70,7 @@ kill $pids
>   wait
>
>   # Wait all writers really exits
> -while ps aux | grep "$SCRATCH_MNT" | grep -qv grep; do
> +while pgrep -f "$SCRATCH_MNT" > /dev/null; do
>   	sleep 1
>   done
>

