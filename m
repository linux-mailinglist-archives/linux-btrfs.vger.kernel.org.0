Return-Path: <linux-btrfs+bounces-8918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8299D8AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 22:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434F1B22326
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 20:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665511D0141;
	Mon, 14 Oct 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="LZiU+Q/n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787371C75FA
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939410; cv=none; b=E0M3fVwuHax5n7KNJEfKfAk+eOcTuGmdzIDpAcA3h1zujqBJPkmC/4hNjG6M+Z6XGE8MTrbYsK3TPTLujoKhIKWmPUAWOqf2/k6jY59t2xg0osSs0iX57xQwPynf7nz/aqRPBP/OPJjx27p6sR26W8NSdSa0tM+fj3pxQmEk6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939410; c=relaxed/simple;
	bh=J2m+AssnDLRVka9hX0xwY699Mw17ap5ax4BoBMvYGJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uPhKNXtXzMLtkqqTeMMLH/Pw/+lM7fiRsTXTEKlyEXPcP6aPp7e7eyl2GYkqIBA7SZIN1Hm19vkEsk/eTt3WITyD1hLIji8OURfAPnPlq2Fnqx7yju8amnRoRue0pDnS9OcOYMdYRYonFdFKoZ69y57BNq7ufedvRxN28B2FXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=LZiU+Q/n; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728939401; x=1729544201; i=quwenruo.btrfs@gmx.com;
	bh=0K9wM2IQOiG2Ci5pRy5Tjwph+hHLSwh4EATtZXX0kSI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LZiU+Q/nrfd9Kv+17btW6Ab5twkw7th/uTEu8zEDVFloA44Nr6wP5mZ0qHU3ki53
	 DcrybFQTp3wbk3MWEl829aYEz45bvM0FlpwDOv00yBslKv8tuIVzJ5wuGRemVQ37U
	 Z731R3+XVW6CwUuMnlNGSMebmnotSSY8sowZ0mAWlYLN3TiSo3SuHe+QSjUwj4C22
	 Al7/4gx+LdfpzXIOiA/lsq6rBSLPIo4U8ylxzbpv9iz47dkWo8dU1AkuCMjt7SsG6
	 zlsCYcOSp2iwqDbtZ44j0iONqBO9cGUSll/uPVhggiRebB/rH2yYXON0hNpl4c3Mn
	 oe+9jgzZoa44Pk4/jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNt0M-1tKLWC3ObQ-00KabP; Mon, 14
 Oct 2024 22:56:41 +0200
Message-ID: <74f576b3-03bd-4861-bb3c-571a7bb75265@gmx.com>
Date: Tue, 15 Oct 2024 07:26:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix use-after-free on head ref when adding delayed
 ref
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com>
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
In-Reply-To: <02fc507b62b19be2348fc08de8b13bd7af1a440e.1728922973.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XCNZLsf5DNjXqx9kKS/svj6pIUPwfHm+Ov4wY2Z7bhQ7+K6wCVW
 pf3XqPEcWj9LgsoTX9FzP0V9o7A+nmpC23a4ryP4U/jC6gCkV6U6DPWXjcjhvTSsovyvCki
 Ggil6xhiy1m546WtmR9XwvwnmJMBt5U4rTwa8hy3Ia6xSRXhc4IrFceKHghFYxHNymsRaRz
 vbgyMf51iuRlfADQ18HjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qw6pewpLmPU=;DcN74gBoLE+W6zuIQMwz8HLEi4F
 vL5/B7TQlSrYqQK3aP6bYlmZggp8Y7Tu5znHbHxtNlPehqeEIPMgAtw+o5Vc0/mg7hMNXvxVw
 FR0jsAsJkC67zOSLd8SYOFXqM1e2djb5iDIzTRpu+5LKjroSLmt3k5uNj0C2GqLTyjCwAK127
 i2gh434DhVi/Y2NZFqRiNsOWGULqKG0nADJOOG8VdOgYz++mxPXmZDSRb4W0DmhLLOJ7eDxwB
 V61lvNmPRo5LQXWXTdh3E+uH0Z3ANcHWtlfrHeTd2YUSfHJ+tFaUGzRybskopQU1pVFFAI6vV
 Fb05Nawo0G2LQx67acu9ECLcpj+FBmr9y5azzAg5lSzskr9pKKSBmAY8D0INWtmj/Ro1YhKi4
 yEFuYodqsZaHzAicL9a2PBIWy4cX2GeajzGbNDSoaUD/uc/KACyYKRM5ZN9C2O6CFZJjUbref
 abDlpbx7IGAoS16elZrhgbn2FS3pg/vHcOHl61UtLEIjinTpvN05BS88QSsExgCRhsXjlfgix
 WtQTlVp9QZo1O09pIucNeuL/cgNYn+wkeclIshZRsDEfDsvuSRPfUpvtZPi26xjZD5IqMw9pz
 MOJJqSpZ2HMNf1SnGU/k/xDXgdHWSpCyqvXWRhAiS2M4Fzy3pOeEa5eWsIUrTXJeGuZDZO9iX
 z3MXnuLMOM9YVkUmM9DFtpu/HogaemN66J/uWxP93x4hjcsgz1vbjxT2Cg1fdQy8DPwDkk/iD
 /RJkZmH7WdAdICU5Z1TVATHGdX1YI6O/EVf0ytCD9DIzF5EwbbWQ5ygjZ0ck2L+vjN3im69pC
 C34qRvsu5kIdZbDrYbU7nsPVILvpieZAfqnhD0ztVU104=



=E5=9C=A8 2024/10/15 02:54, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> At add_delayed_ref(), if we added a qgroup record, we can trigger a
> use-after-free on the head reference when calling
> btrfs_qgroup_trace_extent_post() since we are not holding the delayed re=
fs
> spinlock anymore at that point and in the meanwhile other task may have
> removed the head reference after running delayed refs.
>
> So fix this by extracting the bytenr from the generic reference instead
> of the head reference.
>
> Reported-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/670d3f2c.050a0220.3e960.0066.G=
AE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> This is meant to be squashed into the following patch that is in for-nex=
t
> but not in Linus' tree:
>
>    "btrfs: qgroups: remove bytenr field from struct btrfs_qgroup_extent_=
record"
>
>   fs/btrfs/delayed-ref.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 13c2e00d1270..04586aa11917 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1074,7 +1074,7 @@ static int add_delayed_ref(struct btrfs_trans_hand=
le *trans,
>   		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
>
>   	if (qrecord_inserted)
> -		return btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr=
);
> +		return btrfs_qgroup_trace_extent_post(trans, record, generic_ref->byt=
enr);
>   	return 0;
>
>   free_record:


