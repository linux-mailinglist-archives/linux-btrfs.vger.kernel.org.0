Return-Path: <linux-btrfs+bounces-985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FF581515B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82186B23F02
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7347F7E;
	Fri, 15 Dec 2023 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RFBpRTPC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5BE47F7C
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1702673050; x=1703277850; i=quwenruo.btrfs@gmx.com;
	bh=r95y9QEW7989QZgWsq3EyuOQUJhzpa2nWH7Mv5JCIAg=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=RFBpRTPC+IBknTyNuRApmUEG2z9yuHoc3DF1R1PkWtlWYEKxHqbfrCqDbOQJWrez
	 JqzlLPdsOa2gSyq4MZU8KRJz98L22JIqlXLL4yFjkYlQXYlkUAECv+CN+kQiAJ1nK
	 MBDBZxR5yH+HxJhbsjUKMbbop9ju8Ls4U5yTNEWwEMiGysXfk8I/7n2uxUqM/rFnB
	 BfT/5KNPTPJILfgCHu/JqGsbZ9SL3YJRxehvlr7tV22GxmZlq6wWBp6uC9w82DwCi
	 8fbzBe8gZFdJ/Fu2JhAWynGNhrg6Si8vPJFMXm407yTuO34d/yZ4rrTmFgXoKQ07A
	 LFp6AZpF+BurpQL1bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([193.115.79.20]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2jC-1rabAR3gH4-00n9Kr; Fri, 15
 Dec 2023 21:44:10 +0100
Message-ID: <cbe969fd-5c2d-4c54-92e7-3952d9ca37b2@gmx.com>
Date: Sat, 16 Dec 2023 07:14:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle existing eb in the radix tree properly
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <93ba6929e6ce070bd27bd80220bff7112793a3ca.1702658189.git.josef@toxicpanda.com>
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
In-Reply-To: <93ba6929e6ce070bd27bd80220bff7112793a3ca.1702658189.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j5TaYFR/qLQlH0mGzKgO64b8u9rjhGnOeOzRrbta+dROKdpFsq4
 kMEfAnWCsw76EduJHKdy31lnv1Sbs8Ky5d8+wfh718PIkqbtjW7ajLjIp9ncOHJVTmBrVKr
 +uNpdanXPio7Nm2S/hIHUccBUewdBVSeGGQRoT04amcsIjtBRqm4kbiyH8TXqwZgrHUFjIF
 mVBcrpcmqdCiGqBEl3FxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YkpWDp+0X40=;JJp5f3L6Rfx0qVXfYGLcvPAp6gc
 2f6lgzmQkOsgrWwamvJjsO18j6q8zTkA1CQTmQEXyW/Pp4ljjgOyZL4P3aK8ydXS4+T36Nx4K
 wtQoMlO+tWstuXCDvI39Ck0lW5w/pBMFfAQy6kT6t/eLHkC6H8eNunhPHbqdPANltE7QQNaBt
 fzmG4EroApEVdMJh+FXnQiSWaXx0KJe9W/9HUujIwjxmQCMyj8I9HDdkOJC0g0auW0dY5hqKn
 RTAB/qhI11w/JEPZ2fjEXqj+uVwZLpDGAeWgZiJeoKoh7tuwhF8OsjQNTN57gP6PkeN4GMR+i
 voVqvcI4+Q1Wn00dK3/AoQ8dR8SFTz7a4eIyZ1tmjtouVv1CfbvYi8zbqX0pa5WTxigaksGgh
 geo1KhMQYHbxfMAhjRjrJNJR7MmETTlDwGfNNP+uTAHRfjqvirIoxTPOthlEsuJXBzVTOThSM
 psqoA/s5x36OYb59o9z0Z2BF4VsVWjBo9g9NjIQJ3exRGMqvGcw5SWf56+V4+zP1UUC6IVKxH
 zUXDmRNX1AhROA3X3D4q1BnQbD9VIWqpe3DKj2x8UPNwa1ZCH/pmydWtL3XP7wxRsm1Kf+1pw
 rljHcLlbZieTA5H1AO5RmenhyNSrl28RNcP7rQ+JIeMMHkBv5/3WLnqOVF5hCE3j5lZF0ZlL6
 NW2W9nwyWZ5K3hOXPBqAvcRRADkyugZ+Ge+iPv7ZpIE8uoSoZ5biOa3e0ikXa+3wmrA3630uX
 448Cmw0wOAIjMJYKiBrgoAu1mb2LVbUyXmoNvZ9ejE9+alSpL0uv1SPZLEUAvR6zsFfpw1/ft
 ezSnyI4/b3sZkTlbDSizOBFFzQ4zy38ep1Qdr33nW/2iQr8UGPlfaf9ihhobYdNph5SkpPt7I
 8oP0XnK3VGjzftA8ahZVjwPDJCWztTH45LTM7wk2lTHtC0qr9NaJHMmRCzntaGCUfBihMyHEX
 PmIFjTRnvsWE7ZpzSHcCtZDxMGo=



On 2023/12/16 03:06, Josef Bacik wrote:
> This fix can be folded into "btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method".
>
> My previous fix simply fixed the panic, this fixes the memory leak that
> I observed after fixing the panic.
>
> When we have an existing extent buffer in the radix tree we'll goto out
> to clean everything up, but we have a
>
> if (ret < 0)
> 	return ERR_PTR(ret);

Stupid me...

I shouldn't put this refactor in a already bug-prone behavior change patch=
.

>
> Even though we have the existing extent buffer.  We've looked this thing
> up so have a reference on it so we leak that, but we're also returning
> an error when we shouldn't be.  Fix this up by setting ret to 0 if we
> get an error back from the radix tree insert.  With these two fixups I
> can now get through btrfs/187 on subpage without anything blowing up.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for pinning it down and the fix,
Qu

> ---
>   fs/btrfs/extent_io.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b42603098b6b..375fbec298bc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3731,6 +3731,7 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>   	spin_unlock(&fs_info->buffer_lock);
>   	radix_tree_preload_end();
>   	if (ret =3D=3D -EEXIST) {
> +		ret =3D 0;
>   		existing_eb =3D find_extent_buffer(fs_info, start);
>   		if (existing_eb)
>   			goto out;

