Return-Path: <linux-btrfs+bounces-1425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F482CA83
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 09:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1808B230EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Jan 2024 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F7D7E9;
	Sat, 13 Jan 2024 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ear//mCt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1343364
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Jan 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705134775; x=1705739575; i=quwenruo.btrfs@gmx.com;
	bh=xl4bogCWrmA4bLll0tCdsus7ilJ6V9N41JAouqdDZTw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ear//mCtNPm/8utF1ANMqfvX0EjKqVVTvI7Tv170WPKTbYs16FKrKSQAK/btITB4
	 Px+D5DkPfFyd3EVMkdg5vdTGNmuKKIHh9nVi7/lz2dgj/ujDFe8LrJ89tytIUWC1E
	 bzOI9T8Elff90ON52CJP0maekvRU0eHrF3YOJGCgQsHvMP2HNnVAQKMRpXrFz5bvB
	 Cdn9mHifGh/IJpHMgcyHkk3ZgXfNit5DesMqQNlN/xKifc5aqHCynBEchNkBlm6EW
	 qvZELiHqbElSsMW8QqhAN68xfl/7wJAAevRhHBWjo7t/w3bBr2UYkSu0qok0Qf52e
	 zohQ2H/5s2pq8Unbqw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MS3mz-1rZFdN3tJD-00TRR6; Sat, 13
 Jan 2024 09:32:55 +0100
Message-ID: <8fd63b73-18cb-435f-b380-75983037de17@gmx.com>
Date: Sat, 13 Jan 2024 19:02:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: defrag: add under utilized extent to defrag target
 list
To: Andrei Borzenkov <arvidjaar@gmail.com>, dsterba@suse.cz,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Christoph Anton Mitterer <calestyo@scientia.org>
References: <2c2fac36b67c97c9955eb24a97c6f3c09d21c7ff.1704440000.git.wqu@suse.com>
 <20240110170941.GA31555@twin.jikos.cz>
 <a033550b-9300-42bd-9ec2-74f9ee15cad3@suse.com>
 <20240112155806.GS31555@twin.jikos.cz>
 <7bef3393-a1b4-4a18-98cb-508cfb1ca6ee@gmx.com>
 <15751051-dc90-498f-82bb-773d639a3b24@gmail.com>
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
In-Reply-To: <15751051-dc90-498f-82bb-773d639a3b24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AoiIt1oKc5aHh+nmhka09EYipy0rD2/Oce4pEKKoAVe984DlJAt
 fFNhLq1xvCD2c1rc7f0EgLdzpLB0a2IQoUZTJas8MYcG9jKeVezHs90Sd3Y+tG5Mj0PuGZt
 2kNVWcA0wd6s122gGNbvLqQ6r+p243k7HSqnMqi7QAz+3hLbz75pwMCVvTNQu5S0F4yeqPS
 WSkA6sxQvqf4k2KUAqetw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KIsvER2WLcQ=;PdpeMZQ+n0LlD4QFYwBPCmoFK+t
 MTLrPs5WlUS2dFI3ovpRyow2hYH1C3en6WlVn7+GjymEVi0uSN03+qqMgZ7aZnCYKsh942dk0
 eQoS3Pk1bm7B6/PhaconHniE4TWx6qKJ5OyZ7whnOfgYcaASTlXh2WbCXMaoYYoWCzrmqqvhJ
 raNCALOLNhuNJa2PtgVe+13z7h3RzOtSMK+5pPwMukxTarLUKw89W81BxGWcn6AgRDiooR2/Q
 7GXbDOzJ/KUmBnxF9d/yZGYBE2dtOlTfL35owb7+izuv/i2g/Wx8KVFbRJC2Smp/nLP4icpfw
 NL5Fy74kpFuXxW/R7peqFmWprCxK3lgLem869dyfwD2Lbld9rGxjeFSjzX7FbJwvTXaGG/OVM
 6YBVJdK2VXnssrpuf8yuyCSSZmBpkz9seMj2GhfhGjxMS0xuKiPknI+tDXdMBQyX/FcaKCo2X
 oEZAoAdBVnka8u8ReaKKtvcx/j6cR0rnMmeYczy8AIsPfnCgCtCXiuy+dAlSjusC3SlLoN8Cx
 pZ6pdioxreMp357O8A+K1NU1t9IRxQJpicDyelgV0P6v50+oPbK1/UPt6MKOyhFN791JYYs+b
 75gHesOd4TLqfBNaQOU0CZOW//QiDWvkm+eDziIyd00J+p8GviElbyFVvitUGhhERL4C6U5A7
 U1/lMsfEH1iPpfWdB95iNRiJSn8EuEdCy0G6RK3a1gGKpeWJf9ycu9UwOOxZd5e7vdeoMEh8i
 C86Cjw18YXuaOetMbWPTFCulk/ltgwzElrKd49CeyaRBfzqC7T2FApr8Lv3ZqwofLVcQ/k2eV
 zbnv1EYbWerHQjnK/6EmxHOW4kyqf3c6P2NKshcE5vex8flfQAc+8Oy5dokwPtYEAlJBqhz6N
 pHLqMqBlNqpD1iETkB27qkzMKBEt2mnHGPU+YUOTIg+uaDkI8DwDVOF+dYFknFheogvO6BHvA
 3yzSIWBUsi9LAUDIldkUordDUJI=



On 2024/1/13 18:35, Andrei Borzenkov wrote:
> On 13.01.2024 06:17, Qu Wenruo wrote:
>>
>> What we really want to do is, just add extra filters to allow end users
>> to re-dirty the last file extent.
>>
>
> It is possible to punch holes in the middle of the file, so partial
> extents can happen anywhere.
>

That would change the content of a file.

Defrag (re-dirty files) should not change the content.

If you mean zero detection, then I'd say it's a little beyond our simple
(not that simple though) defrag implementation.

Thanks,
Qu

