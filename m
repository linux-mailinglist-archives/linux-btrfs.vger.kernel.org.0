Return-Path: <linux-btrfs+bounces-206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA257F1E02
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 21:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9BDB2139C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 20:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9716374E3;
	Mon, 20 Nov 2023 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HH8SJMOw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08064C3
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700512404; x=1701117204; i=quwenruo.btrfs@gmx.com;
	bh=PX2d76sxbffIoqRvd6yRUJwSIKpVuo7hGEnauEZg//w=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=HH8SJMOwwGYmnVh5y4mEm7COTlOeuOonJvEX9ZhCbMbm6zahZCIHaLkHiAUhNbwn
	 vFJ6sVvR6Y6zKDSdHLqh4Gp1v66hLNmp66oTIj7nMlCKBXTD/kli2/WeDo8jFshme
	 nJMK8kUqb+QyrHPULM0N9V8/9ha9VkeY8FU5DSCV2+/ZzTPLA+AzME5SO3FNcy9ye
	 2bhFoW5mdwOpSBibKcq30/AVb/9TXEBndIHh5Z8iFv4L6oyaE/N3trJbAAqVCSSLO
	 Cvc0hCFATHAoSyAyEOA88WOZ/Mespb8Bo6fkoQBa/LxEJGeS0XPdcBo+OnqWBr3TR
	 dV9y8wPnSD3taC6Oow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq2E-1rKNQZ1jfk-00tBoF; Mon, 20
 Nov 2023 21:33:24 +0100
Message-ID: <687fae90-5cc1-4d1d-aff6-3d83cef15c59@gmx.com>
Date: Tue, 21 Nov 2023 07:03:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: checksum errors but files are readable and no disk errors
Content-Language: en-US
To: Phillip Susi <phill@thesusis.net>,
 Johannes Hirte <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <87ttpgz3qp.fsf@vps.thesusis.net>
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
In-Reply-To: <87ttpgz3qp.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4PLhi1TJmBgaVLuCdhvr8QnAh1bbDa7szJCeYWJG8qxnF2xHCKl
 PzCGZaMNmjm5XV9MUPFajOyRBBED1HVaFVQTcr+oo3AeVphOq5Flh4ARLQGdM73Qo5v71fl
 8r4IkQU3H/27mZZo1+Rn8XYuekGOtd7ulGxt1CWZph9EktivOsoujQRvMPJQJJnMulmst7v
 tLynxdmeMc1Hecy1QUdTw==
UI-OutboundReport: notjunk:1;M01:P0:WBxZdg8PHo8=;7Drq0WSJCwESzG9MNyQt++igGfy
 n1lzfDebFGB75d/2lw7y8svxrmQwSJzitRYQQx0VQWEqkDgYBs3YzcZ32q31GDybzTFas5e/6
 GELN99wyMIwzmRoIDQFn98cP2UaVjD8VlgzEMiUkcThB9e2BDHesZFe05bXMvAaVb1D+6X5TG
 RJudCKqIWIZkSA/OMFibpUEeZPbQMJa5IJJcYinETNdva4kf41vgKrWKLrgAh1y9dHsec8/Og
 1hliUWbyeixZBWL/HKE6qvQmwxgqlQoRo5v/O/8Io+F0ekur0SS118yeNoiiBzXq/QpRThhMV
 o6rc1ijOEQqW1qxvZ2AXZssS5hHTsydVIWTLhZH6GbjwXkZNM4umpILwVQ4NpdqKJ2PcpOFsy
 A/WMkNVmfFE8QI2OoRB3+RFwlmCAXjJdG47g6ZNmhXR7rYR0/gz61GuohsugM0ks2AzCtS1YN
 Po7IHW5CyG3BSp9sApGtZYXBMca4ievg031hQkcYa9ZXjOkIERZRx4NFib1ZqPP+JGGri0Dbj
 HsqdOuX2GsFuCJYvPf9qZWyTlPkY/XLacltfcPrJPRNiV9nN6ZwQXM2kMpHVbufnd8urbnjYv
 5HsNHw5ojH+WJ4stQBiuGElfgR+Tiz56XcA6XSVQ2l1CxodWwvnhAQNYFZ9wtG9TwAPPVTHFq
 sgKY08GZFJvLT+3RC/HypnPWh9Pvlm4XYVMozWb2ANnAfiodARYSq5+vcpwoBJnRecSMJj0Mb
 w05XbF93A1J5EwtOnTZgYOSr+8ZpPW5t06Jq36o/p2D4Sr7I7BrmWDlGH7+PvXh1TiDb3t+x1
 hxB/k1iseHbLu54j9qieUw5O2xkFJV9lxqAJ/Cu7NzLFd4LCXFIk2XtFoaH76M2bmAuDv19C9
 hsW8T+pGn7+nlMWrmuBpQXkOnTqTGoa/u9mKIJQWkieXw+ifi8rd5a00cJnw+AsqkTVZwiaXt
 KnRAGC4EOCACd2CkI+LxZ11mL/8=



On 2023/11/21 04:49, Phillip Susi wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
>
>> For the cause of the error, the most common one is page modification
>> during writeback, which is super common doing DirectIO while modify the
>> page half way.
>> (Which I guess is common for some VM workload? As I have seen several
>> reports like this)
>
> How is it common for applications to modify the page during directIO,

If you really want some proof, I can add double csum verification for
direct IO.

In fact just recently fsstress has a bug that leads to the exact
situation due to uring got interrupted by signal, and caused page
modification.
(https://www.spinics.net/lists/fstests/msg23274.html)

Exactly caught by btrfs csum, and initially thought to be a bug of
btrfs, but turns out to be a bug of fsstress.

Considering how many different ways we have to do IO (and equally how
many ways to screw up), I'm not surprised by it at all.

> which is explicitly NOT ALLOWED and will result in bad things happening
> no matter what FS you are using or if you are using md.

So we all know a program should not SEGV during "normal" usage, but
there are tons of crash report in the world.

"NOT ALLOWED" is not good enough for real world.

Thanks,
Qu

>  Even with md,
> if you modify the page under direct write, the original may have already
> been written to one disk, then the other disk gets the (partially)
> updated version, and md has no way of knowing this.  It will detect it
> if you do a scrub I guess, but it doesn't know which is the "good"
> copy.  At least with btrfs csums one disk might contain the original,
> uncorrupted data with the good csum and then that will be used.
>
> Even with ext4 on a single disk, this behavior will result in a corrupt
> file that is neither the original, nor fully modified version.  If qemu
> is doing this, then that's a bug in qemu that needs to be fixed.  Then
> again, if qemu is submitting a block for write to disk while the guest
> OS modifies it, then maybe the bug is in the guest OS, as it should not
> be modifying a page that is under write.

