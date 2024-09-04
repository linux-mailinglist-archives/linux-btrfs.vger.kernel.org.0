Return-Path: <linux-btrfs+bounces-7841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272296C992
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 23:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9664BB22A07
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E25155A4F;
	Wed,  4 Sep 2024 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZRwoJ9tx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECA613CFBD;
	Wed,  4 Sep 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485501; cv=none; b=DRTLaA3ful+lS/SGRAAsEv83Aat9Inhx/bFz/iA0t+yWCH0GIlt1AZvM3dYZ4r0t7RTKokxS0V3mBSwjyvHx+F3fXzmtPdBxMCol0Gyz5H60XpmSwGnGuzEBUnV8gKnuCe2d2UcycXgq0WPhYMRbrLFX67gsnR+11J5GfF+lh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485501; c=relaxed/simple;
	bh=d3NsZoIxYVB0YgQKQudIzvQ3zMytbjN8hCyMoMOuoMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxXliWPORN4ik59MkbWz7BmhkbIdvXRYWfHiCfExQ8llTpUDv0f4wZkte+e3/auw372nEuakfoSIs4aH/Fv7VoyQkJAqRzRBnNPfN4S1xJ9zFuQpL3OTUlkoGbQNzNNFX1rn4dP+d71Hd75V/fdLyuhLj96IyiX5dtFJqkelowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZRwoJ9tx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725485490; x=1726090290; i=quwenruo.btrfs@gmx.com;
	bh=pSCQ1776ISJNY2amuMhyPV3YJGwlGzO5rvznyDPvxFM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZRwoJ9tx13RxwZvF0MIegI9c1RPBbKJYOzFHiyu8F2QVc8WloWbCDsKRQgjRslc1
	 qGzz8S/jiFa4w57UJWMuNb/SI1BJi+MAV83peJG0R6Tv8cJTsbCnK4+1XQWiZ6IbM
	 aoVrhJaZuTSXalX7Qby4mPKOTJY/01qScpKrB2MSCvYOXpLFVRMJ/1EcBBd4vYDzJ
	 RHgd4zQVx61J0o+mlm0Z+vYV5qkjL2onibqpTf6x2/B55nZkbQNYygTnGxkvEVOoe
	 JW8cs7Cer7DTqe75x15xccFFuz1NKJNoICFJpZCdk1xIKJHCRsQSPd+W/+pLOJdsw
	 no2EFyxhfSomvr+iQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU4y-1sDjF73iOS-00kWOp; Wed, 04
 Sep 2024 23:31:30 +0200
Message-ID: <a52ac518-27fc-4853-be01-fdb03e49e862@gmx.com>
Date: Thu, 5 Sep 2024 07:01:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Added null check to extent_root variable
To: dsterba@suse.cz
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
References: <20240904023721.8534-1-ghanshyam1898@gmail.com>
 <9ee34826-259f-45a1-99d5-a21262489e49@gmx.com>
 <20240904174630.GP26776@twin.jikos.cz>
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
In-Reply-To: <20240904174630.GP26776@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2hjoBxVkF+13bHZICQz55dACE6B2sn3RvBX4pUo4qKCPVzDhAyx
 WOw8e+b9sGx4KVuU1N5tUiKhcpPRbxVUU5qT9pXfpsN4TW8AP2UbD0UF4ibon4iu299Z5Ir
 GwK/Bi8dzd0dPhL73X2VqE1TO+5yrso6cLCX3D3D3bi8COOe+yQ1nQ7gddhfYDIFR6tYCD+
 cGY/OcU8p/snzSvpSV8Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5lvh+j4PrKw=;pveEJPFrHy2lPddYF8RRSYn0TOO
 WkVN1BTW/w3s64pu+Hq1kEuWzYWTgcAr3j7zIRjs40P/MUAyVxZkQb5KwUtjCUN9vXkcDmaN8
 rgHzTDaxAAxjVirgDIGOvCcIsRS4ZjbNHkENfEpSGZQ9rD+3K5dOYL7l7hXluePRP6QCSYuT0
 HrK0t7BWuDZIhykCFaUGhEVXz7KAe5BAm8+Odzmst+BMPnAGLy14Ittq6/impTCI7JDNXYbJw
 gh/ZXMGB/XDEf7xKM7LFrGSwjmG+nFVy+aq2I0E1LiwLr5XOXwZiRYQT8zgK2RmSdB7owms4/
 6POpCBfv1ESB1n/y3tnE5w72uO9ut5yUeTr+weVuWkr51pRRP0BVvxJg2CzLoTHP2Mnf+BEKV
 2GwKYJ8cIeClEE7E/jsHdK5gyAfU4dx+C/A4mwZyBYr+ydYGRAl4lHHduGW9ovtykg7rCVnMV
 rw9O7cpkfZECOqA2N0nNPwdx4DNYFcAdWG/DeAEHKGYTMoDcrrZHAijY7ofghjfObtMtzstbg
 WDmBzsEzP2qhF7oIHrefmNqChsxOG+8OGlX1GphrDodi4T2QhajJBPG7HrSCm1MV8mNDnZZ+A
 vlEr4Pt/e7q+WiO5pQVBRnaB76IIOcdHV2DoLFT67kAMG5jb9oQDOtoTeGfbYuRUxMOLrn0ow
 aS+OxPSTNPpyiKHLP2Zf5l1AZ5WE4w2lS/PU58ztKZyJzfLzL1hSrTguM/UxNaQbaQgvASaSB
 Cm8opII+JKpDJqIUTiFqy44o4cx1Gu9eWcYt8bQZ02HrZyDAufkng0WHF7sl/QXFTEmTCPqf2
 oMYNw+s1VZhBX2ke7HyBje1A==



=E5=9C=A8 2024/9/5 03:16, David Sterba =E5=86=99=E9=81=93:
> On Wed, Sep 04, 2024 at 03:21:34PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/9/4 12:07, Ghanshyam Agrawal =E5=86=99=E9=81=93:
>>> Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
>>> Closes:https://syzkaller.appspot.com/bug?extid=3D9c3e0cdfbfe351b0bc0e
>>> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
>>> ---
>>>    fs/btrfs/ref-verify.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
>>> index 9522a8b79d22..4e98ddf5e8df 100644
>>> --- a/fs/btrfs/ref-verify.c
>>> +++ b/fs/btrfs/ref-verify.c
>>> @@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *f=
s_info)
>>>    		return -ENOMEM;
>>>
>>>    	extent_root =3D btrfs_extent_root(fs_info, 0);
>>> +	if (!extent_root)
>>> +		return -EIO;
>>> +
>>
>> Can you reproduce the original bug and are sure it's an NULL extent tre=
e
>> causing the problem?
>>
>> At least a quick glance into the console output shows there is no
>> special handling like rescue=3Dibadroots to ignore extent root, nor any
>> obvious corruption in the extent tree.
>>
>> If extent root is really empty, we should error out way earlier.
>>
>> Mind to explain the crash with more details?
>
> In the stack trace it looks the ref-verify mount option is enabled, I
> don't think we've tested that in combination with the rescue options as
> ref-verify is a debugging tool, must be built in config (by default is
> not and is not on distro configs).
>

Indeed it is the rescue=3Dibadroots mount option.
And unlike the regular mount options which all show a message line, none
of the rescue mount options will output an error message.

Thus that's why we're ignoring the missing extent root in
btrfs_read_block_groups().

In that case, yes the fix is correct.

Just need a small description on the combination to trigger the bug:

- Corrupted extent tree root

- rescue=3Dibadroots mount option

- Built-in ref-verify

Thanks,
Qu

> We should fix the bug where it crashes when run in syzkaller so we can
> allow it to continue coverage but otherwise I wouldn't put too much
> effort into that. I.e. if we can do a simple fallback and exit gracefull=
y
> and not try to continue ref-verify + missint extent (or other trees).
>

