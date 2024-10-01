Return-Path: <linux-btrfs+bounces-8403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD598C754
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 23:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD53286204
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF61CBEB1;
	Tue,  1 Oct 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="stlbvUO3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF2819F42F
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816986; cv=none; b=lcvubAWZi5kKBWZJMYMBl0CahipCBZ0OeEEchIeK8OrZhNZtCIUy0Akkrp56Yxae3LXTQHts8c+TNrzahBmr7BDHdGdJS4s73o+/L97rb4nSEH11D8HEm3Bw5YZPNyLT2VM89SrhvBZqqb3PnWWJ2yv6zsspT6mFwYgDX0W9ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816986; c=relaxed/simple;
	bh=8zOSBIvRJXNJXJtBMhoAKY9ViT9W0RxSawDrY6247Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwOzezJH2qO1nL1zKBGieuBxHROtzeUU3X4qW9ghqjDKemv6oahhSxHpJwERnCwi6NuVP576023NKulhBWVT+fc+GQ7A01RaazzJDmHZKp/zg/twlZnTILCmlkmHLAHDc6Qx/1KgSK7O0pxPJXAE8lv9KKQ2Wh+etW8iS86UQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=stlbvUO3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727816980; x=1728421780; i=quwenruo.btrfs@gmx.com;
	bh=Xirv2MQfAIK9GNdPFMHfvnJqiL8nIWY8BBqSRLR9dXc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=stlbvUO35jIbypr+nPH3MYPn40v3+v1xyN83FZm/xPug2gBD0JSjARTvoczTc24x
	 QWC6Bya4dXFQFSWlRIrSid3rtroRdLI3MrbisUGFpZSaaIUzr3H6lbSdwX98EXVWr
	 HUmfxW9hueVygX4AffgP9xhahMZq+YF7y4ejCkhh12PDEBuM1Iji3qX8R3jrf9iYe
	 aWdM7F7gN+SWR8LILFpT43jrc1NNrrkaSirPARTT8cTQ5y13KsX5fub5LDi9TUtB8
	 mdm+gzOaxzgD8YwwnmY5YXM5LMg5TgpEVkuA0EMqJacNkAxJDqjbCiYbiAZN23cGi
	 PPbeDxVKRAU8q0Nicg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1s2pBr2z3g-00zSwf; Tue, 01
 Oct 2024 23:09:40 +0200
Message-ID: <eedc128d-557f-40f6-898a-fc333f51d7eb@gmx.com>
Date: Wed, 2 Oct 2024 06:39:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: simplify the page uptodate preparation for
 prepare_pages()
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1727660754.git.wqu@suse.com>
 <f7504d38c6e6938e4d50e7cee5108a7010e9e8d8.1727660754.git.wqu@suse.com>
 <20241001152015.GD28777@twin.jikos.cz>
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
In-Reply-To: <20241001152015.GD28777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UYS2rWHwxOyawLsn9b2w8TT/cbX3sU7aAL++suLKRIYnlbkwyRN
 xJoIlsShPXvNkimUbWEQr7hDxCJZ20TEBIkLvlJGfSzxMrugerOGewMNCTfNxW/evvX5hUr
 bxMw7+XcRKdn0Jw1dgF+8m/wQZ/S4ehtJ8493sodqvMbMoadSXL81FjftYPZGCG0KFixiv1
 pTmnxEVdc1MxDNxV4CEvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EePrz+5ablM=;8VwjC7UubJrdWo5D/JXN+fjjbgI
 83rzywfsnaDdDWPd4Yhh160FRe1gYRMi1UNlBE3ljSdlSLj33Q5l93svRXGPeH3xRdXTO7egm
 f3ZRnBcY9bpBvZC3/VeciLuU1FfsKtivftGByuwNyThC/Knf/W2XpwtR92c0eQwQCljX1nFhA
 5U+0Xfi9WGPzt5xz6pW3I4tjd40LdMUeDjK0YiTNQvoUNUIxCY3oar1qGORqrWMCnJv6SaDYn
 2nfL9c2K3TYFq0wl8/Yzw+8/44Ugqqgqzzgk9y3ukAfvATDMFMU3Ow0coKYkRtEU134jw5ZqN
 HuQnKSCDgeFxnLWcXgoGbrmGe1PhD7qA47DbDbKHpRd1AQQ4nl3hu0BpDl1QG6uSEjW6l50z/
 OrCfqiD85oIOqX7UUkw3Zkv6ysSA5Ds4KziKZYB5x9GMIGpL8YINvZZa4GqYfPATGBNcZY6YM
 H9SqQhNYVnSP54E8CQCVT8xdcaQUCSByUWLJwpZcjcZrq1YoDsHEDEm/sLmIhMlbAXiJ6DrXl
 tpcvZdbxxCveHkt7vtY0gq7FBcRVOL5onpX9rC4Ynz+EqCbUf1vknNTqk0e5JfoFX7C7Yg+1H
 RKlFC7WO72n4URVPROF0zjRrEH/+PSIdfjxRj/HQjoOog4X8FcveujhJ1c9wXWF0fhDvb+udB
 K1FIuIft+FYcQWsezObLhHqTDUS2OKt3qZtN3V9jRAD1vkpxcoR1SJxVteMWDWEOut28inliD
 h3An9OsOHpiHx9LV5+QPMWbk9r4D8oOZfPIFGHMvLrGpxIOn+sK+qyGKc4uk3MdaDGUl/KgaT
 6kBovR/Nw/W8Y35/gmM69LqA==



=E5=9C=A8 2024/10/2 00:50, David Sterba =E5=86=99=E9=81=93:
> On Mon, Sep 30, 2024 at 11:20:30AM +0930, Qu Wenruo wrote:
>> +	if (force_uptodate)
>> +		goto read;
>> +
>> +	/* The dirty range fully cover the page, no need to read it out. */
>> +	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
>> +	    IS_ALIGNED(clamp_end, PAGE_SIZE))
>> +		return 0;
>> +read:
>> +	ret =3D btrfs_read_folio(NULL, folio);
>
> Please avoid this pattern of an if and goto where it's simply jumping
> around a block and the goto label is used only once.
>

Any better alternative?

Thanks,
Qu

