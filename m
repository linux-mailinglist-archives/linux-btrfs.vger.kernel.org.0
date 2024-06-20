Return-Path: <linux-btrfs+bounces-5863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390DF9115C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 00:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E04282933
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47B139CE5;
	Thu, 20 Jun 2024 22:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="B+rY1jJ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023AF36126
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718922872; cv=none; b=rMjKNdwZmCoDMDPrf2E7KOkqgZ9RqbByMESkQ/tsG37st+hF8ddNAwTnAZNnJIpzwwnxhpy6cHsuT5UtaarB/5OchF+DSXvyCW7/+A9jQCppZ0C4mASpoF0MbHtMkqGLJ4fHv2e2z/KHtEX0+dK8NDZChVDJWcdMTDQEfRg3wQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718922872; c=relaxed/simple;
	bh=jUfgQaXMKRgVkboqnfLoq4qznFUZfaznsyQTkywPvwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+PUC8QelW1/59V3da9bsuPVOOzl1HoUsPBWyXOVyhFkU72BRLq9sM10eGvrCM2Ni6PM5CyDYO3TxtGWkR0FMz0ZMzskN8evnEj0P6jXOb9CRiQfSgd4+zd7RBG+u2uP6ySORVkMtl6Ug4ux0z8oBITZiCVaNe5zCf2ZWYY1sqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=B+rY1jJ4; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718922865; x=1719527665; i=quwenruo.btrfs@gmx.com;
	bh=Ph3nBQrg2KnCslnKBKE+663J3yBeTFtLji+cGLM7mL4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B+rY1jJ4+vM27f9NEHjg/hCkasAcNSvAr9wixsZWScKHblBJ9KQeJTA/WASzVf12
	 flq7KWL/CSo2gTVGFvIQmruFf3lS8+R/Iq9CeS/0RJ70ZTdZvUWAmv20VW8r9DDUK
	 X5FrQZlyW9gH50jNV7LMlUPaa3WT/mli+NENkYebwF177cS6dWJT0rCTolMviboM4
	 GeSe7n/wB+o97mdlIAB9QpuXPpxSUMu0aRqVTN9sAGxcahJQNEKqkfYyczNqqMnNW
	 aRDSxV9kVoXMm/qLiifjsx3ptVhK1Ed5GrmJYW0mVr7CcExGSyPCDpJ/q8a7l3Mev
	 IhFGnY50Wp9mzwlRzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq6M-1se96W1532-014noP; Fri, 21
 Jun 2024 00:34:24 +0200
Message-ID: <61592e4b-62fe-49b4-8ac6-55ff28c3a08b@gmx.com>
Date: Fri, 21 Jun 2024 08:04:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] btrfs: qgroup: warn about inconsistent qgroups when
 relation update fails
To: Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1718816796.git.dsterba@suse.com>
 <913ab94d58070b19dee7aa6760a111c31be473a1.1718816796.git.dsterba@suse.com>
 <20240620212833.GB3251296@zen.localdomain>
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
In-Reply-To: <20240620212833.GB3251296@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6dVlNZZgdfBi2NIB5cseWYfyFduZ62djhtbXA/wArsUWCSPANqi
 IXbqoIJuFMvAquIgsFQEV/gkBukJTL2wE5MDnszpL+ST5njpTm7NR0F5PXpEcKOUFQ/srZ5
 bIbznPEKXhubipWxL5PeyGDP1ClIDunFn7yr/5X/qmCAbJxmCB4pMGXQ26/4yUedLJgMl7m
 M7Z5j1ltvR8Rsl+nHQj0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NENq6NYKAOc=;mQLjLkux3e7W1CKtofwUPyzIxoY
 Mbnn+5ESZCXYdWQT47BeCY+ajnCLsFcXGZTV9JJNBr+8YvUFIno1ZvfFPxX+tdGWuFW2O9W49
 bCzeEB7fzbjuVH6EkigyYqVpUQcWZGhmQH6UXhHscgIWsF+uVW/4cMSEcClGYMin1rAa54Dkv
 sU3YMRG6OqXs4cW9qnrqjrJ2Lwt1Hk0fKSSO5OxdBLMhLYFMHe1n1UPsDa7n4zmYQt1Vr1zoT
 rfm6ExQGn/b4mSeiXK1RPyXrOZqBCnUL9P9NPcWBbzBHRvw28FP/yQboLsSHQqsYAxUz8gfwP
 p09IAlAyU0Kk2DXS02CmZM/eSH6d3wCvGkPNyS869NNsM5aOlw9EXWkDy/8gqe8A0mYMu1rhy
 ePFDbDkDtMSWaVgjFWKubsvqBAEe3Kl6ENsPJWIx24+jrFPqxIngeVGHv2ft9yCwRDV05MB8d
 NnHwMTJtBkvnSOGF/He/niA7u39vX4nsu+KS+9xuLjC9GVBR6KqrM4ruVuC7ZXLrwQshpfSIf
 kvqf46Io/EDQ9Hf0lizT8naxmvzHIuUNytIQPd70uK8/uj/8UtlH16ERlLbUKi60W0Zhw1Unh
 xcmd0kVwJSkM4dn3p2kDwggN5v783WmJoBug+ok0VDTULEJNLQBjPRWT+kOW+jLDYdu+gkEC0
 G2VoKjF1BrMTRaIsofcnoAMcndubGUpkTP6/pEjOkAlgaQ2wjieN9uY+X1VmrRa5VS3TiNXza
 udLkialXUMQaUTozmbApZjygGKMhMTBHhR1oUehJ75u+N8vf8KkCLhFraustUA6w2ssA1UVab
 IjsPQQ5qoBDvAbgfxF/XIJ0y08o2sIDlgKrNuTgqie7CQ=



=E5=9C=A8 2024/6/21 06:58, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Jun 19, 2024 at 07:09:20PM +0200, David Sterba wrote:
>> Calling btrfs_handle_fs_error() after btrfs_run_qgroups() fails to
>> update the qgroup status is probably not necessary, this would turn the
>> filesystem to read-only. For the same reason aborting the transaction i=
s
>> also not a good option.
>>
>> The state is left inconsistent and can be fixed by rescan, printing a
>> warning should be sufficient. Return code reflects the status of
>> adding/deleting the relation and if the transaction was ended properly.
>
> A few thoughts/questions about this:
>
> 1. Why do we even need to btrfs_run_qgroups() here? Won't we btrfs_run_q=
groups
> in the transaction that actually commits the qgroup relation items? I'm
> guessing some qgroup lookup sees the not-committed items in a way users
> care about? Are we expecting such high-scale `qgroup assign` that we
> can't just commit this txn and make it simpler?

I agree with this.

I'm originally thinking some weird situation that one have called
btrfs_run_qgroups(), then we do relation update without
btrfs_run_qgroups(), in this case it may cause problems.

But since btrfs_run_qgroups() is really only called in committing
transaction and this is the only other location, I do not think it's
going to cause much problem.

So overall we should just remove the btrfs_run_qgroups() call and no
need to handle the error (even no need to commit tranasaction).

Thanks,
Qu

>
> 2. Is this really failing in cases where adding the relation items
> succeeds and then it all gets committed successfully? i.e., do you have
> a reproducer for this case?
>
> 3. If this is a realistic scenario, I'm worried about the squotas case,
> which doesn't have any rescan capability to fallback on. However, I
> don't see why my (1) above doesn't just save us anyway. If we commit the
> relation item, then we also commit the status/info items. And the txn
> commit run_qgroups is not allowed to fail.
>
> 4. Let's say that 1. is not strictly essential, and the txn commit is
> going to fix us. In that case, is it really accurate to say we are
> inconsistent any more than just during a transaction before we run
> qgroups? I suppose compared to the case where this succeeded, we are. I
> just have a weird feeling we are stretching the meaning of inconsistent.
> Though not in an egregious way or anything, as we are reporting a
> non-fatal error?
>
> Sorry for the slightly rambling review..
>
> Thanks,
> Boris
>
>>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>>   fs/btrfs/ioctl.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 31c4aea8b93a..f893a6b711c6 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -3877,8 +3877,9 @@ static long btrfs_ioctl_qgroup_assign(struct file=
 *file, void __user *arg)
>>   	err =3D btrfs_run_qgroups(trans);
>>   	mutex_unlock(&fs_info->qgroup_ioctl_lock);
>>   	if (err < 0)
>> -		btrfs_handle_fs_error(fs_info, err,
>> -				      "failed to update qgroup status and info");
>> +		btrfs_warn(fs_info,
>> +			   "qgroup status update failed after %s relation, marked as incons=
istent",
>> +			   sa->assign ? "adding" : "deleting");
>>   	err =3D btrfs_end_transaction(trans);
>>   	if (err && !ret)
>>   		ret =3D err;
>> --
>> 2.45.0
>>
>

