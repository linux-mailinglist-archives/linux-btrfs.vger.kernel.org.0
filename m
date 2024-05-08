Return-Path: <linux-btrfs+bounces-4824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215F8BF988
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 11:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BCE281DDF
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C963757E7;
	Wed,  8 May 2024 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cQL80pga"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7F7D3FB;
	Wed,  8 May 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160554; cv=none; b=VkKE6x23uVvw0PYzLVk92pfk5Gr2m8LFEDka6XRqkoxbLiCsosUTc/d4SVPywVY2wJwH0Srjj2Ea/sRZQfqWqzRcw3HwSaPD8UiOvKHbPtr5YhpREtxCfRwhYwV3G5eHULE23jJS4y3+/uOSV1twaDvOh9GuCTrNMF7Q7DDTQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160554; c=relaxed/simple;
	bh=4KIdYjsFuhHonaoCrgUKLL5x0io8ZaPEXJi6Ow2CoA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8wEvUXygykK9KgoTbS/TzE9wkaL4xBxMrNXHLGoorQB/WhNHrrbvU0xEt/edIYPClTmyI/nK+K5gNykWIbnomrFYtp/MdTvLhrMItNoNBwdxJrXI+gfyC8apaB9Zku9Zq6yOJncjrbxoRLTPCgB6BcoLskYFNWTw1F9/MhEHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cQL80pga; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715160525; x=1715765325; i=quwenruo.btrfs@gmx.com;
	bh=UON0bZ2qYVZI9xC70I2OhzL/SyRmiG781qZsT1wXwCQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cQL80pgaK16J7AjGEuCgl7nOkUGykKy/FvNu7WyIk4KX1Vg+bOvktd3BycMFRxEJ
	 LF6xY8T+9G/nJ2+utcLXOJ6qrDJblLPQaybLrkB8mM4LKQXBhE6ZjQ5pcEynxVptc
	 A9g86HtKFTSCX5qSYCzpQHo9ig0pljLODN0x4ptaclxY8djkiCoiB7Sf+JtTJTXU/
	 VlQsVb6aa3S3bWsrnvhYAvSbAmuySosjfW7Xn5jFl9fvn0908QNAEhdrmYfS8fioR
	 pWF0gXVQ2TDdohGAjEAz+EAAa8nf6k5vSH42bnI7uzgMBBEltywnNiAM3QoY6rAqg
	 hJ8xnQa0cgJPAMHwTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV67y-1sDwza1MXO-00S7Vn; Wed, 08
 May 2024 11:28:45 +0200
Message-ID: <fd188158-1959-4d91-be39-210a3b4dfcdf@gmx.com>
Date: Wed, 8 May 2024 18:58:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: add gc stress test
To: Zorro Lang <zlang@redhat.com>, Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
 Naohiro Aota <Naohiro.Aota@wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "hch@lst.de" <hch@lst.de>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>,
 "daeho43@gmail.com" <daeho43@gmail.com>
References: <20240415112259.21760-1-hans.holmberg@wdc.com>
 <e748ee35-e53e-475a-8f38-68522fb80bee@wdc.com>
 <20240416185437.GC11935@frogsfrogsfrogs>
 <20240417124317.lje5w5hgawy4drkr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <eddca2b5-0c15-4060-ba7b-89552de4a45d@wdc.com>
 <20240417140648.k3drgreciyiozkbq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <edcb31e0-cddb-4458-b45e-34518fbb828d@wdc.com>
 <20b38963-2994-401c-88f8-0a9d0729a101@wdc.com>
 <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20240508085135.gwo3wiaqwhptdkju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fnMeXrr3ROO4KOja3NDTw7lZP9qkwyI3MU00SGdyXa69wplbHUF
 POVqcyxIS6NC7FhjPbCDHEIJCAY5Ay6DxyJx3LggiSawXaaoyk2t5vik3R7rlIC6CuOW82M
 Z9LiVGK+Lse5crgnIIBzTlXKbIAll4s24tYWJmFv0UDFphjTLz9N/KzIlNy7pegwRdCNW6V
 ZHFFv05W8ttIBcuq8LKWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ieEJ3oDY0eM=;fB3OtO3l1UknZDKKx1BIQGPTs6n
 /CeV1qykgYcxkRy2NMQMUm0YveIZRa83vFLF7ohWbhe/hyrCxGiPColYSe7/tq7xuK4dshg+Q
 zy83tLh8qoARGd+q7PcKySDrkzQbSlIADLIBCvPz2ZspJLobnAlA/lZ/4CyXAwdXxwPjjzaIc
 qd3TQ/xwkw3zSexFWP4ERWQWGqZHHGTVDZPVyIte724SO1ASBinHCP8Vo19YNvrr2m//QMO/J
 e0syA831j55IodHOexbx5SPXfFNffjzjvszUYq0afFzcMeApXJ5i1fBheRL+8yXQ8BGdfSiwT
 jNLSdsBFDtlTPUKPVouI6zJ3HM2npDuEz/VF0/j4BrQhR/Zr0zFApXNuudzmfYLDtIW9TsUKa
 Uniryx1V/KjfiQaFbrYOVx1INoyYY40g8Z1Sj6pcVr1Pnaiy0jnPb+dW3pzNDVu7qKLw0/90P
 WxzXjwAkLhZbtNsosSWRYGKP3uSGf2IoYjVro41IgjnTnF9gEWiWcfDmExCsI6XvxEEXrzdcL
 lAV6Mf+b1U/5VQ05nw3jgPPwysKYyR5DSGfT5B+6kO8qAkKs3kWTNcHbjzhjNFVNtXmapN4Wx
 lhg2fmxkemjrnh2Mr9OJTMkxw32Hsg0rzuySfeZ2zK7KWVW2e6GQjpxctjJxKHDqEGhqMyZYd
 lHn5ds/vq3XrKcJ+nvQMBwNLIC3Kelqs6zJByCJ5H9WAQSbcNzEhYcJaog1mS9RHgLSgcGMDw
 zvckKW0A+T4X8KedrQc8MsB0cIF/O3PmwOWQu93xYlO7J19hrCheRIm/FP6+jKcja6TV9FH2U
 TABPi7M06hcwAsOg7OAGKk6ux3+RDwS0MjLxvvAAEWcsw=



=E5=9C=A8 2024/5/8 18:21, Zorro Lang =E5=86=99=E9=81=93:
[...]
>>>
>>
>> Hey Zorro,
>>
>> Any remaining concerns for adding this test? I could run it across
>> more file systems(bcachefs could be interesting) and share the results
>> if needed be.
>
> Hi,
>
> I remembered you metioned btrfs fails on this test, and I can reproduce =
it
> on btrfs [1] with general disk. Have you figured out the reason? I don't
> want to give btrfs a test failure suddently without a proper explanation=
 :)
> If it's a case issue, better to fix it for btrfs.
>
> Thanks,
> Zorro
>
> # ./check generic/744
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 hp-dl380pg8-01 6.9.0-0.rc5.20240425gite88c=
4cfcb7b8.47.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 25 14:21:52 UTC 202=
4
> MKFS_OPTIONS  -- /dev/sda4
> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sda4 /mnt=
/scratch
>
> generic/744 115s ... [failed, exit status 1]- output mismatch (see /root=
/git/xfstests/results//generic/744.out.bad)
>      --- tests/generic/744.out   2024-05-08 16:11:14.476635417 +0800
>      +++ /root/git/xfstests/results//generic/744.out.bad 2024-05-08 16:4=
6:03.617194377 +0800
>      @@ -2,5 +2,4 @@
>       Starting fillup using direct IO
>       Starting mixed write/delete test using direct IO
>       Starting mixed write/delete test using buffered IO
>      -Syncing
>      -Done, all good
>      +dd: error writing '/mnt/scratch/data_82': No space left on device

[POSSIBLE CAUSE]
Not an expert on zoned support, but even with the 95% fill rate setup,
the test case still go fully filled btrfs data, thus no more data can be
written.

My guess is, the available space has taken some metadata space into
consideration, thus at the end of the final available bytes of data
space, the `stat -f -c '%a'` still reports some value larger than 5%.

But as long as the data space is full filled up, btrfs notice that there
is no way to allocate more data, thus reports its available bytes as 0.

This means, the available space report is always beyond 5%, then
suddenly dropped to 0, causing the test script to fail.

Unfortunately I do not have any good idea that can easily solve the
problem. Due to the nature of dynamic block groups allocation, the
available/free space reporting is always not that reliable.

[WORKAROUND?]
I'm just wondering if it's possible that, can we fill up the fs to 100%
(hitting ENOSPC), then just remove 5% of all the files to emulate 95%
filled up fs?

By this, it can be a more accurate way to emulate 95% used data space,
without relying on the fs specific available space reporting.

Thanks,
Qu
>      ...
>      (Run 'diff -u /root/git/xfstests/tests/generic/744.out /root/git/xf=
stests/results//generic/744.out.bad'  to see the entire diff)
> Ran: generic/744
> Failures: generic/744
> Failed 1 of 1 tests
>
>>
>> Thanks,
>> Hans
>
>

