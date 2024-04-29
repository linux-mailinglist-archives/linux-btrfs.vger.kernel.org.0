Return-Path: <linux-btrfs+bounces-4633-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07418B654D
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D0A1C22058
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943F119068D;
	Mon, 29 Apr 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gr3sQlHF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B012190687
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428326; cv=none; b=aC+rFMoZiAzOnt3KQ+7RG0DnW/b4SntnqcTcWfhSfBOf1BuhHpmbALNVSrpmOKWmGqQA27krgW0w38euJ22YfvbWOPmoFT7jwf6L+O8EmWsvLrbakmdiCX3dVbm9XLaSZluboNV50SxYhR5L9C3WzwURXkn5M/wUA7l1rnUAKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428326; c=relaxed/simple;
	bh=mc2PqlCWry5ANWmqDhZBAH2ALursJ6OfOyCcTKqKbXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLX44/AjlAhYPBJongYexdWAoB4xMY3kLS1hdFVNrVeLLIWaDuYfE+E0GoEObrLJXhavzUc7y2JmatWHhSCa8/UnFx2VPZ59+qKEv5o6HWFnOlvUfCScqZdwyPj5BY/g/y9lvir+0msW6/wj7qoyJoXSZud/OplZB5hNXwJCCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gr3sQlHF; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714428316; x=1715033116; i=quwenruo.btrfs@gmx.com;
	bh=c+gvSFOpoSJZnv9a9C0yHD4B4DVjOxLgIbj8Imx4/tk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gr3sQlHFaIU6UVkeduYBloMUi/hwSjizIaHzfyjbTCCuIgU2cPMfvF2vCsKY+Xrq
	 n/s88FBfXbI7eui9gPUlXw27hPOw8t9qthL1ZuUdrgCzwoFpiitk64m9FVbHF6Bo7
	 VlHJEPLTCAJxz35Eanb2OzZ5d8IXa1++FP36fLgtbkYUt/6CypFB0PDRIfLaebCQC
	 UVZpkPBsFC+ASHaGLSzrHz8YUB5gU91AwxzoXhI3BkCqJjwj2lqeh/C8f90EeUjS8
	 iSJDtFeM3d4dpJFODzySXU0Uzg0Qlgf3cSnLR9tov1zRmb574dBsFEh1EiJGy4v8n
	 w0a+GDhUXPx+z2F6TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7JzQ-1s0RaZ3KKC-007Fsv; Tue, 30
 Apr 2024 00:05:16 +0200
Message-ID: <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
Date: Tue, 30 Apr 2024 07:35:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: dsterba@suse.cz, Boris Burkov <boris@bur.io>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain> <20240429163136.GG2585@suse.cz>
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
In-Reply-To: <20240429163136.GG2585@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RdM08lJd7HcXMYAYEoZU66QCSX969uf0npteR5B+2GlWPgMIXVl
 gF1c+9oRvVuuV+F7gjMtrhWkRpygnUo0Zc4j0C77mo2uC/3GuXa+PkiykZzllbuXWju/zOD
 qartOmds64OakEd1fGoiBhbi9AjJhW6azmHzaHohniPKcduI+fCc+K3KO9EP0LyZd223Cn3
 J9E10mL9K2pdIbInpKMHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TUovUyxHVcA=;EjBoAzlWsiD5+u0MfJ2R4eEP+nr
 vTqHUlS1G3W9A7XEtko4+oBvVInD4YP2LiHTtZ+//ALnoE3fFwH/KamL6Yu+/unM0FYYM9bzo
 h8Dhg9kygUq3D/zzMVXWj/89spWBEUEzR1FUTHo4zZCMsMmmUXyA7QA6Vdk5qRFUSFbPdLOA4
 X7QqlZnJ49G6+92NBxDfOhpRY990fHgOg5Nx0QGjRLaDWr4B9M30maebNZdrNP0czqJwUYqrG
 qndXT38jfgNtobKf/SrbdGdG/F6eDa6n+pGQ8ghC3ybVf172TtkkI8u2Cmyf6fzhb3ayUJIlh
 ySaPizxgx34FdNuR0H6Jgw4v2ZpxU6pfAE9oyogjyxrhqIAhJXDZx1K7Mi8chD/bahEEqPx5n
 CdCo2ukM4rN9BU4RQ+lQv8YSakpP8wb5QsDee185RaIyNtv3hHHwf83Twr9UBKsWv+Tu1tyIo
 bljsGl6EIqOOFJ+hwxXutI+YPz3SE/MmPYHQF5h23f/69StjfQI3PpIc8vuvc8dccjWE47aL9
 JOfx9jhn8V9nOaMHEUIp77MWdxeKMHFB0sGpOkk7K4aLFccNWRYM79XI8Q6GbCPmY7+AcIC4I
 JISwAmGZ1l3tfofca6h7kAoQOyntoREogKtUA3YfISFpq+gKGPsq+xzuuc05w8jpQQePLno5a
 ds5AMmG2GUgUcGawIRKjuvqZPW/52LeZCQ/GL7iRB9FXZbT6+0yxTzf8IJaa3IWUCsnyOrK0o
 Lp/RAtJYsW2uvJ+LvONSLRSXwJEYx21kcqz+wIAU7zWHhcGqkH/Q2mbEhwWwDVKHeOehqMiAo
 COD1MqyT+OhLrDzeazIObttOWXnJO1GnNyZVUeOHm1I3g=



=E5=9C=A8 2024/4/30 02:01, David Sterba =E5=86=99=E9=81=93:
> On Mon, Apr 29, 2024 at 06:13:33AM -0700, Boris Burkov wrote:
>> I support the auto deletion in the kernel as you propose, I think it
>> just makes sense. Who wants stale, empty qgroups around that aren't
>> attached to any subvol? I suppose that with the drop_thresh thing, it i=
s
>> possible some parent qgroup still reflects the usage until the next ful=
l
>> scan?
>
> The stale qgroups have been out for a long time so removing them after
> subvolume deletion is changing default behaviour, this always breaks
> somebody's scripts or tools.

If needed I can introduce a compat bit (the first one), to tell the
behavior difference.

And if we go the compat bit way, I believe it can be the first example
on how to do a kernel behavior change correctly without breaking any
user space assumption.

Thanks,
Qu
>
>> Thinking out loud -- for regular qgroups, we could avoid this all if we
>> do the reaping when usage goes to 0 and there is no subvol. So remove
>> the qgroup as a consequence of the rescan, not the subvol delete. I
>> imagine this is quite a bit messier, though :(
>>
>> We could also just not auto-reap if that condition occurs (inconsistent
>> qg with a parent), but I think that may be surprising for the same
>> reasons that got you working on this in the first place...
>>
>> Do we know of an explicit need to support --no-delete-qgroup? It feels
>> like it is perfectly normal for us to improve the default behavior of
>> the kernel or userspace tools without supporting the old behavior as a
>> flag forever (without a user).
>
> $ id=3D$(btrfs inspect rootid subvol)
> $ btrfs subvolume delete subvol
> $ btrfs qgroup remove 0/$id 1/1 .                   <---- fails
> $ btrfs qgroup destroy 0/$id .                      <---- fails
>
>> Put another way, I think it would be perfectly reasonable to term the
>> stale qgroups a leaked memory resource and this patch a bug fix, if we
>> are willing to get overly philosophical about it. We don't carry around
>> eternal flags for bug fixes, unless it's some rather exceptional case.
>
> The command line option does not do what I expected, if somebody would
> have to update the scripts to add it then we can do the kernel
> auto-remove and the document it. Eventually we can translate the -ENOENT
> error code to be ignored.
>
>> If we are on the hook for supporing that flag because we already added
>> it to progs and don't want to deprecate it, then maybe we can think of
>> something compatible with default auto-reap.

