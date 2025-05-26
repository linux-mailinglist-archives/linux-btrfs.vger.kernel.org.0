Return-Path: <linux-btrfs+bounces-14240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD2AC3D85
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 12:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E191896548
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 10:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220761F3D58;
	Mon, 26 May 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="o/Tvy9jl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285381DC994
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253596; cv=none; b=O7Ag1Ebj0LebwqwbP5d3UKZYP2eomouzX1bvrNvrgJffDkAqMbIDQwKsh6tS95vlesxgibMD3UuEBT7Spr3FK6+Xfm8XaagRBH2R6p9QkTcfnf3rM16nygU99jV5O52kUG3qo9fNbnRUiZB0rNhriLPpC0pv+wWg3AxbpTMQfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253596; c=relaxed/simple;
	bh=ceEMd+SzfuvZNSys3PPY+RQY2BKvbhFrRildI2eXk6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twWsTQbovUiwqz09U1icBB+29VWfT4Sma8xVk57CvBvGOvJ+jxs3z4n/RsCJ6FB697CTSI17cALUlHdqmiGPKXa3Wp+k9OWP1yxCOH6d+XbywZIC/JtG0u5XUoftAnngGatgYiiR0MJDsGdwqr3K20DcWsHpnZHH+SUzK6qELTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=o/Tvy9jl; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748253588; x=1748858388; i=quwenruo.btrfs@gmx.com;
	bh=PtVXoOwTDq/cw8lMOtkej+qJcEAs0ioYHUZczi33yU8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=o/Tvy9jlKbMgc14MV5MBm7JpewsFuxf+8Fxn8mmS2+Ftel2FWe13d/07OF5fdow0
	 9oM0zwvuKvNeg0PI0uoJWP45UefpxVhB2L0tV0/Nze5F9ZdBox9rBdwI0TxjdEStJ
	 9ikebZbmW0AH54qz7iqSVSrGdGEZKy0wMCZHxPrGA0DQm5fDjCAXn8i+BbUhMNfPh
	 JrHiYPDyAZ5b9PBQGJQXVKAumyh/UqNUV+2920CeqYBzY5op6cy+m8RqJ9VurkKKN
	 iuUMefZFecHhVU5v5ZcM+aZUT03WK/VTQArsoV+J144P4mVk7MvCmjelEGRlR4Jke
	 QXVs25IWRCszFi388g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgeoI-1upVS52ebM-00hcQ0; Mon, 26
 May 2025 11:59:42 +0200
Message-ID: <16f6f076-e5cb-464c-9cfa-376614af66a1@gmx.com>
Date: Mon, 26 May 2025 19:29:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implicit
 declaration of function 'ASSERT')
To: Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
References: <20250526134027.187C.409509F4@e16-tech.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <20250526134027.187C.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pI7cpp05hr18lK7S2ATNMsqm8p3aPX9TVFFmUZMVHI3VaKxysRP
 JB0TvvYTxgp8wOXALfR/oftzLAa9CO8IbUQjKLq/kiXdWo/oK/qUggHKJZ7+KDzOWc2ALY3
 tEpqSHEO/XSVgHkfOzmXvs6grQD1tF1uI72S5BSyPFTdQQ51+uzi/lBLUwsOMmczCppb/JX
 QZG5qkzzDu3c6IdUs2AMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qz6N9/VMTn8=;ebgsqEFzB2hyvYti65bIMs7BqDG
 D02LmvX1hyXEaDBBIlu70DIjHnXfnerBbSbAEOzIwzFHbNqCwJYpEMvtEuHmHY+LURNtQW7/L
 8nQEE9lGUxJxuLn+B85SXB6H3wd8lZyxpW7dkY+imhZVyc8jWUiyX7TX65zKKXTPjB/dBRJbZ
 zRfrJFzLiNXUUEwPV2B082FehGY9vOkDP3V00/iYYM5pxpRaKqAdBqdbrnAK+LZ9OqRC2mLVj
 APWsk6OPsYai3GCEZ0fcdR0YrIu68c+j0n5ElhS9w4X3/GlBYBab5YtgN6ed8+AsnRY6rry/M
 nIfNigXSfg4nNG5eHtI1tkd8EKT1OEQTiW8in8jN4MyEbgK2B5THQGSR7LkA3QH4mOnRtqQ2z
 KIQ7i0lvZp1P+Tp3bETPIAEzTrciRwLzrrzz9XtDDEd90lMi0QAVTrXrdSM0neVlqwJGpLOMC
 2gUy9yKvOhnsJEHSQKGHTcGGDCwocbfeVnF87wywZfeT6HppZB6db/ICV8DU3kFvGGVEmoGyx
 l6MOdzuZzQActpir3+d1j/RKTC5vtSRbNbcw99K8XvcZnMAATQoHevzXo5mKkcGRZ1hX5uOWL
 YbsN4Cpkrrhk9yCzKyvFuQ4tpiTViyjSVFxynTPo9dHwxzNWMiL+xQLU7K22bvLwBoC/h45sF
 kU9FYzS7G3PRLr+2GvXf7dqPDlBgHFozqePEPzUC0SmcLnbEgWYrnuMbhpiZuNHio/9pbRtLJ
 C4+SV9wte/PR5Dpeolljm3100yg38aqJxr/w2B338m7hApHrHskmbar4jq6SxQlN7Q9UzX3BL
 RAOVj6dSA56BopOyMMncwpiLtgIADCwhCI+pYMSl4rX6grMlIbdSRFVx/gaLSGvgtqD9cmGR9
 ivBeM43uWYmJcfSqHnE9JoK1ZG35q35MpWPTEdxjv7rMkoqQjm7si66+boFeWfH1LGBgWyCOP
 VHJF/IvjZjZ7HSsoGgM+D/KBVwonW2JRF7gBCHXt1RKPYG9jgD7+FGhceuU/cG5LS9uVCjvMy
 yqFCbv+ZIhvTrlzs/ARkmPSzE5pzdDGgeJkF4k3zvmuEo+u3BmE7yj8sBiqNaV0pyLIlRaAc7
 i9yTbZWvdAYDO1+IwKVMApAyoOeUsBohgltRr88Waksc4USVZ0dNPIIgyWua9aMyQPLDo7r4+
 NKdmNnE0DB5qFndvrFkHX8UG6Tv+qLHJusOqipGjUjbOulqKTAXPB8+NDo6YuoyiKOeK9Bv1V
 LxwTXHL4ft4oDEn9cZ08Ist8e53Fkia2r3vUtHGatW8JKmtFrZKaYuPyvv1LZ1E2khnaRuVKF
 GzLEsoS/yU4AmY2fHHH8IbtxLaPXnghvECTVueO7zGDRe7/Ej7wLdwXRhkh4PftnERxBWRTMs
 E8WesdkEhUdUa/NlnpdB2aJdlnKwIKQnUe2bo6HjPvxs3lGR+kzOVNkeR/



=E5=9C=A8 2025/5/26 15:10, Wang Yugui =E5=86=99=E9=81=93:
> Hi,
> Cc: Filipe Manana
>=20
> I noticed 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implici=
t declaration of function 'ASSERT')
>=20
> fs/btrfs/discard.c: In function 'peek_discard_list':
> fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSER=
T'; did you mean 'IS_ERR'? [-Werror=3Dimplicit-function-declaration]
>       ASSERT(block_group->discard_index !=3D
>       ^~~~~~
>       IS_ERR
>=20
> It seems realted to the patch(btrfs-fix-discard-worker-infinite-loop-aft=
er-disabling-discard.patch).
>=20
> I walked around it with the following patch.
>=20
> diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
> index 98bce18..9ffe5c4 100644
> --- a/fs/btrfs/discard.c
> +++ b/fs/btrfs/discard.c
> @@ -7,6 +7,7 @@
>   #include <linux/math64.h>
>   #include <linux/sizes.h>
>   #include <linux/workqueue.h>
> +#include "messages.h"
>   #include "ctree.h"
>   #include "block-group.h"
>   #include "discard.h"

I think you should send this as a formal patch to the stable list.

Thanks,
Qu

>=20
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/05/26
>=20
>=20
>=20


