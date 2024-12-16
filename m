Return-Path: <linux-btrfs+bounces-10436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C429F3D39
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 23:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BDC16ECD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1795D1D54E3;
	Mon, 16 Dec 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qITgLnzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7641D1724
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386827; cv=none; b=JOoIoZLPBx9aHjnE02qVVFBnFsaRq4xjhTA2suzCKD1cTkoMbm3WNHNAifp2bfFIMYtQD8gFfQYpJt+K6HLEM63m1pxf7xZ2ooVroFZl+XNxuRMWulx2RtQQ3lvk6Ym8uMYYO7Cy/MjrpCNyxHH4RRTfKvZlxMv3h4G3twLCWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386827; c=relaxed/simple;
	bh=SbUlpYvqeJefKgHC2WzvZ0exF4hBF0Ffxhm2XLkvWVQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=gIWz56o2CP6wABgD5kNCmh6LTvSKQ8/MryIxaLq0QGXu5DlYgiONB30c/HzqwMQyM1nR4H2swJUiWpF2yYVTWYxvmv3sSjF9SskIZf3R3zHXwcS3DUskSapiuWEG1h7vttM3utEY6P+uSG+jvSbw1UbbstuP+xnDGHfVxaCe88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qITgLnzd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734386821; x=1734991621; i=quwenruo.btrfs@gmx.com;
	bh=ElG6rH25SOyjq5EZ8BQLKCrF+FQikx327x8jY/uMAuE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qITgLnzdvgPlTG6bTaG05UrdyofvdEozRJNKnnlP52kJHJvtY/gsp6iXj/QSI9vf
	 EwXwr1mZ381mJFpCF+ab+6RvFSxg9zBiJB4vwsq+iZMxzkAQItdRMiRTTYa+cmTeb
	 7jlVQuF9eJMO861kEa+uZRK1cUOGtexh0gwhiNAUGcuM4SZ+RWnYdtikLRXJXSOo7
	 blokTyj4MDjMP4gWxGKGwFgpycrmDhqPYbdCZHFsMc7ynYVZHVXU7Pc0ZahD0LHyk
	 o2aLGe3Mvp3SmLI17XSS5cpfbg5YMkg6H55sRybW46/g+/wIFt/6cllhrxNz2BbM/
	 suxkCOwxw5HcQt9RFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPogF-1tB1aY0gZn-00NlAb; Mon, 16
 Dec 2024 23:07:01 +0100
Message-ID: <62871028-9f70-48d2-9d46-3ae1f6a57505@gmx.com>
Date: Tue, 17 Dec 2024 08:36:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] reduce boilerplate code within btrfs
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1734108739.git.beckerlee3@gmail.com>
 <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
Content-Language: en-US
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
In-Reply-To: <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rnuWtjVJXPAITNGvbQZsaeeGJEOkCrtgx0QcTRxxToGmEfDARYA
 UiWegWuUInhbAAQfjPzd5g9qPjT19dE/hj1YFvEASVCrpzlPjEU/p0ePeXSvJZU1iT3bGnr
 iZeKXpdxUxMUghdo1B+pC2F8Y9lbZNWqX3lqubShblLCn3cjqZVQGJZ+sR9guYzy3hDs0XC
 RxIhaFiaafD1s1fYZw3Pg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hsRRf5h8uPk=;wLXy6Dr+SfMRI8l7LfwS5xCZP55
 6J4LWeP7if1TkAFI38BJUQmjfNfsstr7wbXL5uFj+z9nyTqoaAYYijJt/yH8XEnojRAtPXGr5
 9Mh9VrZBjkdTcUPcQI+KBxOkm9AdkQY8sxMRnrOuvkAFqV1eUddt19cwulfIkk4GVyw65ZLu0
 OVlbSO/zIZnh17TmpZgEP+FU2d8IycgWt7tXVEfUK0DcBYYNwSV4i+nffyn660Gbxwl71iHoG
 izcB5xjf2MeOAgk/BS2ctRbHe6h5ajpR/YhogtQnVJDgZG6Z8ewV6CzrXIeTPh8xtmsIGy34f
 EbTKTz8kkPeRgpysiQwq8pZRYD7r6mHJS9DXdWKMiqmid7llZE46kz0Ocr9y52KLsE9suXoyg
 pn3vJk20JYP77CGrQm2dzavWOryYR+Lwt9W+E1vuMS4dTiu1nliJ4IIfbP5Xm1yzlRWQaIux+
 wQg+wxjsGEU1xWF72ywvMrU0UsXvbVVkqTI5ChLEK5bYIqscZozJVuwS0u1eErhM+VFMAiKjj
 4vznHS3cpDnSY1OZdv5nHSMfJCaCXy6SDCP+XPw8vNruVxyQKihYJh9DEodb5os9Sr2NfS4qA
 ENiH/QFjG+83w/CPkC5zfLMd4GYLiRMovmQdJebVolS4PiEUJE9v4ALDbxiuoDQML7W6tK2LH
 GpgdPpKqWSrwqhLCvNOzpK4eD+lmmznuYPQoe+AGkr9Yi+w5aucR4HxWfLBglZcClAemmGe1K
 Me0bnRdKZtb501lSVjgEgpLtQcE+vB0cJ2EZ70ErBY/krmfMVL8gsRnOrQssQTMUaadMt1Y7A
 92LHTNQ/nzmmnN2RxZdE+BRNwefRAo3CwWCNc6vbT89iOPTzl5sm4HEkz5b9nbAVowvZN+RWO
 gWSe2My0zIDY2ijY/LbIqmTryEAgUjGtLV8cBG5byWNYNi3sde47NmhigLhb0NJlQ0q9X/0aQ
 2SlqbfRXLMAAmRApk/TCYlbCrV6K4of8KgarjuF0Fy3cNQI9jUxByoXSKctFvQYtNoNYYmXjn
 99iePJayD2pNbk2uQDdopLs99ylTAbKc1htgvCLg6s/jXsHzFAuG6Vx0Mj1w5jlO0TbNnPbAm
 kmOSuJUthe9T7OY0/pXvyguKF0f6LJ



=E5=9C=A8 2024/12/17 07:50, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=93:
>> The goal of this patch series is to reduce boilerplate code
>> within btrfs. To accomplish this rb_find_add_cached() was added
>> to linux/include/rbtree.h. Any replaceable functions were then
>> replaced within btrfs.
>
> Since Peter has acknowledged the change in rbtree, the remaining part
> looks fine to me.
>
> The mentioned error handling bug will be fixed when I merge the series.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Well, during merge I found some extra things that you can improve in the
future.

- The length of each code line
   Although we no longer have the older strict 80 chars length limit,
   check_patch.pl will still warn about lines over 100 chars.
   Several patches triggered this.

   So please use check_patch.pl or just use btrfs workflow instead.

- The incorrect drop of const prefix in the last patch
   Since the comparison function accepts one regular node and one const
   node, the last patch drops the second const prefix, mostly due to
   the factg that comp_refs() doesn't have const prefix at all for both
   parameters.

   The proper fix is to add const prefixes for involved functions, not
   dropping the existing const prefixes.

   I have also make all internal structure inside those helpers to be
   const.
   (Personally speaking I also want to check if the less() and cmp() can
    be converted to accept both parameters as const in the future)

- Upper case for the first letter of a sentence
   I'm not good at English either, but at least for the commit message,
   the first letter of a sentence should be in upper case.

- Minor code style problems
   IIRC others have already address the problem like:

	int result;

	result =3D some_function();
	return result;

   Which can be done by a simple "return some_function();".

Thanks,
Qu

>
> Thanks,
> Qu
>>
>> changelog:
>> updated if() statements to utilize newer error checking
>> resolved lock error on 0002
>> edited title of patches to utilize update instead of edit
>> added Acked-by from Peter Zijlstra to 0001
>> eliminated extra variables throughout the patch series
>>
>> Roger L. Beckermeyer III (6):
>> =C2=A0=C2=A0 rbtree: add rb_find_add_cached() to rbtree.h
>> =C2=A0=C2=A0 btrfs: update btrfs_add_block_group_cache() to use rb help=
er
>> =C2=A0=C2=A0 btrfs: update prelim_ref_insert() to use rb helpers
>> =C2=A0=C2=A0 btrfs: update __btrfs_add_delayed_item() to use rb helper
>> =C2=A0=C2=A0 btrfs: update btrfs_add_chunk_map() to use rb helpers
>> =C2=A0=C2=A0 btrfs: update tree_insert() to use rb helpers
>>
>> =C2=A0 fs/btrfs/backref.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 71 ++++=
++++++++++++++++--------------------
>> =C2=A0 fs/btrfs/block-group.c=C2=A0=C2=A0 | 41 ++++++++++-------------
>> =C2=A0 fs/btrfs/delayed-inode.c | 40 +++++++++-------------
>> =C2=A0 fs/btrfs/delayed-ref.c=C2=A0=C2=A0 | 39 +++++++++-------------
>> =C2=A0 fs/btrfs/volumes.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 ++++=
++++++------------
>> =C2=A0 include/linux/rbtree.h=C2=A0=C2=A0 | 37 +++++++++++++++++++++
>> =C2=A0 6 files changed, 141 insertions(+), 126 deletions(-)
>>
>
>


