Return-Path: <linux-btrfs+bounces-1628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1799D8377B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 00:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D20D1C237E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 23:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3C04E1B3;
	Mon, 22 Jan 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rnliwtKo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29A4B5A6;
	Mon, 22 Jan 2024 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966064; cv=none; b=Q5RWkdu1XyZMqWVygBTnB8blBfw8xKlaVzFMYlfpju+amBq4Niw8Z0uVHmbVGVpJPNWfSBKVPE/hLyoNFjyor2x91F7d3Ls39JaHiUmpG99WjMv3ckd/+Iw56V6DaWRHKuDZGik9exzS2Q6IA1HyhGHmoWksoLfmFjXiYeGJmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966064; c=relaxed/simple;
	bh=594BwK7mvu1HQwBaIY2Xo3HEKqrdu9uTJlsJkT01tJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KatElTQddZL26jqaHXE5Cfznx7J7ksgxnrmpUSQEsJU5mRKXvAdUi+V1CXhesIy/d2diZjhewU9SXa18Q9WD994am12UizYsCENK3/Ar3EWT6xFV381j6Hs4G99MKcQbnvzsH4KZRNfJPxUanx6uPj6YaeuxhnrZyg+fBBajfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rnliwtKo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705966058; x=1706570858; i=quwenruo.btrfs@gmx.com;
	bh=594BwK7mvu1HQwBaIY2Xo3HEKqrdu9uTJlsJkT01tJg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rnliwtKognca61/cSz+XRxp6A9uzg58g6Biit17Y32DmvZY1mmo+7CAUkV55BaBX
	 UxkX3idixNNdCJzUqswWuETTXLI2zX4up0RfEWHRyWKvSgai+wMk8HSY4Y1uG/1Yy
	 IfNEECjWlMwAq77JgYlEnF+VAaUfvYDPYLh5/Zw1Ro03svDMijtXD24nGAn3TVmhq
	 p6hnFujTjL14qb893UuUEVxIXYnpLV9AUUY9n7/6RrITBTg1nlAcX8q2szPTqq/2U
	 rI+9PY4RwOM2I95RLF9BEEHtlie3lBBy8mn/WdCm0Ge15ITaPEN3IsolPJmijUcfi
	 O49ngM3q+ubEiTYWJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MpDNf-1qkh422EIx-00qkIg; Tue, 23
 Jan 2024 00:27:38 +0100
Message-ID: <b55a95be-38e8-4db7-9653-f864788b475c@gmx.com>
Date: Tue, 23 Jan 2024 09:57:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Btrfs fixes for 6.8-rc2
To: dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1705946889.git.dsterba@suse.com>
 <CAHk-=wgHDYsNm7CG3szZUotcNqE_w+ojcF+JG88gn5px7uNs0Q@mail.gmail.com>
 <CAHk-=wiroGW6OMrPXrFg8mxYJa+362XJTsD5HkHXUHffcMieAA@mail.gmail.com>
 <20240122230526.GF31555@twin.jikos.cz>
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
In-Reply-To: <20240122230526.GF31555@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W1dfWQ5ZXwpCKKhC+n129uDN3Sy9Vd/Lm0aqg7YNd97SRAJ7I7W
 90DEfSyUZwbvaL3J9hw2OF5IBFnhHPYh+U2GaTtjer8yQSX2xmNZIA6VeeKdEHDUYqC7p/9
 0OaFAerGpJblGUSgT3W4pYlvsGQ7dwVcmuxqXEinuuSn1+cwem5XU6s103fxXUick9iBICW
 W/f+cnxgZnUMNRNgowNug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YLR9kyS6L6k=;6lznmeudGg0lYSx7TxfomiCtTTG
 Um5zcO+07YMO40YrUi30k6xFbD44ru58wPyMF5z0RJTNUgfh9B+mfO8ii/kvncZA/BwtN0Rxo
 jto+1hpI1O4jEXfLRWAOtdjoqa+JF2uivpbawepLefKshwSrFbJuhToNbQb2+4qp5PzboVFSP
 nRVoP1IpZpQwR56JV+890luSDx9npfhBHLnTQ4fWn5vmPxqwdqaS0x7phdZdBX8j1Yxbo0xNY
 cCFTSANaC7kSUALvJuCwZcFBVlTpIGAwMcR17Rfljy6H/rk1qYeOBGtuXKBDWxkW+oC25Ml2D
 R+VkzCrjWAuc2fZa8Le+bQEpYR7EkhdEj4kPM2JIvRAAeBW0R7q+lUeLIABaj1mQVdd2XuCng
 aq6es1Par+doh1Acz//CgYQrpLfeX54+C/uSZBxPsXQq8nDvzY9RQ4/eiqlIDj+A1OsHx3Jgu
 ycp6W/P5HdOtHjkl3Y4LieCMc2KKzA3tF4qWE2Dr1SDkahjuONozgf1MVvxGFtgeBsAgYr9rA
 showmK30xFp28Iky1E6N0p161nEzaZp8onbTi3IL0+iRk11Vdpdp5d8GTYWzrpYH3LgXZOsUf
 G6A/6htgQnp9Hrh75c+sOEwlnakDIrIMK6Ha53PZRLFyppAqESnbcFGMV41iu5GIlXddtPO7x
 tXo7OX+PqtbprD8nW4lndu3jSqWOlnKAYqHuf1Wr2hQ1giV+ilRzyfxjlAfbCTgMIQ2Fay6ps
 N9LP8Qf7KF0k9gMyFjik9/qJXEhrRMxoX9zYHaZL9KP2BIrMrRzU4Jr1cJeFcOL6INntfMTiQ
 W2Cf341KsagFObr23ryFigP3lKF226XsWH3B5IREf0pX6Mqb2BQ/1+HNioQCl0/O7AfUdRDjq
 FLXLGLc4yFT0cWjFXDH2u5uFwzUi5mQpHhfrkUIxTQYY9S2+vlnT6EEyGxnnuEt7l8ypdTvD/
 tzGqloq94f7W5R1wCP8v+QnphgA=



On 2024/1/23 09:35, David Sterba wrote:
> On Mon, Jan 22, 2024 at 02:54:31PM -0800, Linus Torvalds wrote:
>> On Mon, 22 Jan 2024 at 14:34, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> Bah. These fixes are garbage. Now my machine doesn't even boot. I'm
>>> bisecting
>
> Ah, sorry.
>
>> My bisection says
>>
>>     1e7f6def8b2370ecefb54b3c8f390ff894b0c51b is the first bad commit
>
> We got a report today [1] that this commit is indeed bad,
>
> https://lore.kernel.org/linux-btrfs/CABq1_vj4GpUeZpVG49OHCo-3sdbe2-2ROcu=
_xDvUG-6-5zPRXg@mail.gmail.com/
>
> the timing was also unfortuate and too late to recall the pull request.

All my fault.

The offending line is:

+	memcpy_to_page(dest_page, dest_pgoff + to_copy, workspace->out_buf.dst,
+		       to_copy);

I'm using the bad pg_off for the memcpy_to_page() call.
And zstd is the only affected algo.

All the other algos go like this:

+	memcpy_to_page(dest_page, dest_pgoff, workspace->buf, out_len);

So that's why it's screwing up the zstd compressed inline extent
decompression, as we can easily write beyond the page boundary and write
into the next innocent page.

And the existing compression group didn't catch it at all.

Would fix it and add new test cases for the regression.

Thanks,
Qu
>
>> but I'll still have to verify by testing the revert on top of my curren=
t tree.
>>
>> It did revert cleanly, but I also note that if the zstd case is wrong,
>> I assume the other very similar commits (for zlib and lzo) are
>> potentially also wrong.
>>
>> Let me reboot to verify that at least my machine boots.
>
> Per the report revert makes it work again and zlib and lzo cases are not
> affected.
>
> I can send a pull request reverting all the three until we figure out
> what's wrong, or you can do it as all revert cleanly.
>

