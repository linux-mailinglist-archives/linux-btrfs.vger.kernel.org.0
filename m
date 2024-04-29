Return-Path: <linux-btrfs+bounces-4647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0BC8B65E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208D52831E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4B2E3E8;
	Mon, 29 Apr 2024 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k6CANgri"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F120B18C1F
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431008; cv=none; b=P44X3wVYEHPwcPUSLqHRhhlZZwx3+dwsb2yM9WjlEcFrkpt/5RDakTcoh++/RCQehS885UAD8cjoGb3oWkw3pM02EVxe2sq6i6HLBsKniTuuZkxWJwQyDxWITqrQ7urJdQGbJw0VruUNnrslnOQZuNo+4wWRBmSt5GFqpVlmuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431008; c=relaxed/simple;
	bh=0kzP1PXm/i4Bj7aYNQWcoSHE7uhSD4p4v45XZ3Bh1UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN32ITsyxm1b3VeBr9GI/mbVCDKtWbLCUF6wpJHi91xPvp+8jFBRJwXTprLwnJtgeMq+sLVU++jtrP/AsNOR57TySVvYFSe95PafFWQa06jBUc+z/XBvynAUtf4x63ekC9LtGxUNPBlFKXCADdg4EHaAgV8SH/xwsHF3kw16s6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k6CANgri; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714431000; x=1715035800; i=quwenruo.btrfs@gmx.com;
	bh=0kzP1PXm/i4Bj7aYNQWcoSHE7uhSD4p4v45XZ3Bh1UQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=k6CANgriGnWhxIZJwHHPgUbidtiYD/GWATH1qJ4H7beFQU/u0/atP4C7Qp+UEoUl
	 20h0axFMSvuFHh1ddeadbCzmGRS33N99bnFGzYEGVRnFJ+HZtcgrTuw1TTQA4yGQL
	 QMvShYQY7EWTfNvCluIL4BxUI6VJDlSS27KZrnMzNRHkErnpKxJr5ANYQwRZUvh4W
	 FXYcfv7TelcrLsHdYSuaiDVi/HmEQXI5+DeaJq9NINMaTdj8OqCWYAXaVGufYcbuc
	 zOvVwryizsuslhBfAf3NLNr2WrPX5V55Zu1+5lhPqpUUzefXgaj/tV9hJCtACPZoS
	 3pyaa3o30qMKUF/6gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M89Gt-1ry1Rd4Brn-005LLd; Tue, 30
 Apr 2024 00:49:59 +0200
Message-ID: <c9c3b70a-b71a-48c9-be26-28c6065ddca8@gmx.com>
Date: Tue, 30 Apr 2024 08:19:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: Boris Burkov <boris@bur.io>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1713519718.git.wqu@suse.com>
 <07e54de6747a5bf1e6a422cba80cbb06ba832cf4.1713519718.git.wqu@suse.com>
 <20240424124156.GO3492@twin.jikos.cz>
 <598907d6-77e0-4134-b709-51106dcfb2f8@gmx.com>
 <20240425123450.GP3492@twin.jikos.cz>
 <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain>
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
In-Reply-To: <20240429131333.GC21573@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:la/geS9hkcATJRDi3TcCtm8yIex1YDGIQZMg2QPdD47tRQ0WdBI
 AtQxVVFgH6BO93hh/GFcHPwIsx3kcBaisEt0nqG/3TpwRcmPk7aGtPkOQPiI/CQrCvlJI9b
 LbawQ67a3F/g6FGvy1bniZKYjratx6/GEDnTm20WD9aAqnmP+SV/9dk1bfhCck4SqQUhaGU
 nnOZeKwqDCbJr4D161yaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IVzJ4Z7JN3k=;OSkH9d/O/GLjFP2uyYepziTUBEc
 O9YcdhLR6STKS1BoyDL6Mxg8x9PDCth5os4ROJ4lAM6iljdLBuyXyrA9X6zsVwz/APWm0x5x9
 vc7M1gdx3unuLOlU15jR7DtBYVnYVR9N31AfqAFpaSTwbHcJmTbZ3bXrtk4fMHO/fuYhspyLB
 3j7gTNflRW3+yqhBEwpP6RHbD8w5ewRvAwhJ9Z6R1sDQTQF9iKy3zYM3gIFk2Ke8kxgcQecUl
 f25XkKBaeUKuf0oQO7msF0DkRPfSOHGhcbXjf3f0uRYs36dwact7VjJkaj9uMDrvgu96SAiTt
 kc6rb07gF11iXp56F4ouA8s1CgoWgY63TzzX638VmsBuOn7ZRxwvcsYpEXoVrmUC/QSWG7Ky2
 wD43oN703qCmBAcWDkjw6WKFOoBJxlju3e8zbjl5+21BopEodnipr9of2AnE8goqlV6/MJysB
 Tk/EaGwsSl3Lh10MFz4c4Wu2+K3lBZxdRNmO/1SgJ1CFinbZFDgBeoYUajN+ovUSgYUZ/okgY
 jmkjTr1OxuKpRMIR3ays6vQh1qaTklLQCI06odqLfN2Mrr8k3bKa6PYDelxTua6TE3b8w8/wY
 wFtmzmgbyG8M8z/y7K+MBEovT9PCYPBPZ2lt3pXox2h68u/J/t6rxDwDwYJDIAxeyLwPGJqlX
 02e7z7sTMlqozupVNv9+1nmsmmy8VhTvqJHgzblVQSg+QkrIju3c9EYLwcZwPSGZXhk6GHeBt
 CCEx7DF/6SI2gBEdbtiTWaFW82q9as6zbsEdGYDD5MqjFmD/ub/7E8GztDUx+TRiS5hZMuzed
 MkKIzkLfQtiWaHB+HQOVgxLW9IvrKUFcUFtA0TuAxfo+E=



=E5=9C=A8 2024/4/29 22:43, Boris Burkov =E5=86=99=E9=81=93:
> On Fri, Apr 26, 2024 at 07:21:08AM +0930, Qu Wenruo wrote:
[...]
>> I'd say, you should not implement this feature without really
>> understanding the challenges in the first place.
>>
>> And that's why I really prefer you send out non-trivial btrfs-progs for
>> review, other than pushing them directly into github repo.
>>
>> Thanks,
>> Qu
>
> I support the auto deletion in the kernel as you propose, I think it
> just makes sense. Who wants stale, empty qgroups around that aren't
> attached to any subvol? I suppose that with the drop_thresh thing, it is
> possible some parent qgroup still reflects the usage until the next full
> scan?

Yep, that's the problem.
Although I can also do the extra dropping for regular qgroups, but since
it's already inconsistent, modifying the numbers won't make much
difference anyway.

>
> Thinking out loud -- for regular qgroups, we could avoid this all if we
> do the reaping when usage goes to 0 and there is no subvol. So remove
> the qgroup as a consequence of the rescan, not the subvol delete. I
> imagine this is quite a bit messier, though :(

This may be a little more complex, we need to do the extra check at
qgroup accounting time.
And IIRC there may be some corner case that numbers of a qgroup dropped
to 0 temporarily, but later extents accounting would increase it back.

Another concern is related to rescan.
Rescan would mark all qgroup to have 0 numbers first, then let rescan to
refill them all.

This means for a fully dropped subvolume in INCONSISTENT mode, there is
no other timing other than rescan setting its numbers to 0.
So dropping the qgroup when its number goes back to 0 won't happen for it.

>
> We could also just not auto-reap if that condition occurs (inconsistent
> qg with a parent), but I think that may be surprising for the same
> reasons that got you working on this in the first place...
>
> Do we know of an explicit need to support --no-delete-qgroup? It feels
> like it is perfectly normal for us to improve the default behavior of
> the kernel or userspace tools without supporting the old behavior as a
> flag forever (without a user).

I do not think any one would intentionally prefer a stale one.

But considering if squota requires a stale qgroup to keep the accounting
correct, the difference between regular qgroup and squota may grow
larger and larger in the future.

I'll need to re-consider the qgroup drop condition to make it only
possible to delete really stale qgroups (all zero and no subvolume for
both regular qgroup/squota, but for inconsistent regular qgroup,
allowing dropping non-zero qgroups).

>
> Put another way, I think it would be perfectly reasonable to term the
> stale qgroups a leaked memory resource and this patch a bug fix, if we
> are willing to get overly philosophical about it. We don't carry around
> eternal flags for bug fixes, unless it's some rather exceptional case.
>
> If we are on the hook for supporing that flag because we already added
> it to progs and don't want to deprecate it, then maybe we can think of
> something compatible with default auto-reap.

Like a compat bit to represent if we do the auto-reap.
This would definitely make older script happy.

But I think it's a little overkilled.

Thanks,
Qu
>
> Thanks,
> Boris
>

