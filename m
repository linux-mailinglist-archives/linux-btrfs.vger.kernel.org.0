Return-Path: <linux-btrfs+bounces-1420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27D882C661
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 21:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD2EB2328B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A5168C3;
	Fri, 12 Jan 2024 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="K6Ld65Se"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742F416418
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705091726; x=1705696526; i=quwenruo.btrfs@gmx.com;
	bh=vQ1TBC4dAKiNCCAY/B41AE4t1Qr7ar1ekm/f3Acf8BI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=K6Ld65Se8QAepkGNHGeQmh3CkVPocp6r6p/Ziwsuhf+sSASQzppvi3ROawADyG2Z
	 ls92lTYbqUMsOmCujmRUPVTxPLcyuHjsfXTqMDKAp6AmNyILka+DW1d4N49MSgSHq
	 KNHqcb2rRgt5h/YyoorF8CF+G9T3sERyrjPTNK4ajdRvmMPURzG1mHcG3FPesuTOZ
	 R9utRynHDzjxm5ZaDyX439gbriJS+LApxEL/BVwGUg1fsCRvwy9kGMCiAt4h8ef6l
	 qjVxtZcrEDSrVS0L53t9Cbws2dq1h2X5NQAwcb3KN8XdpPjhPKiQz3HGpPgfE8kCp
	 RwHr3wypyOwlGnffBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1rPlgw1sLX-001yoL; Fri, 12
 Jan 2024 21:35:26 +0100
Message-ID: <882254fa-47b8-44b3-91b5-20378aaa0778@gmx.com>
Date: Sat, 13 Jan 2024 07:05:21 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: fix iref size in error messages
Content-Language: en-US
To: Chung-Chiang Cheng <cccheng@synology.com>, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
Cc: shepjeng@gmail.com, kernel@cccheng.net
References: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
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
In-Reply-To: <a2c72015288d70b870ded1d6f8aaba1c2cf63f97.1705045187.git.cccheng@synology.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UCMJv0RR/s9WbbE1Vf4m+2LyFJnvVFK+HCORdkl7YrH+9+tvdLE
 eiGcAWRurTYF+lcoAp6G9rJG2LygAp7xi95JecdOJ6KdsbwywWSjELGSTtmu0WUIJ/E+F6b
 u7RW+TrHTd9tKlTXQpKSQi3ZV4orkYs+GCL7f93zkeC97fZjp5bO76sV8aKNJ3XGl79s0GL
 PRIwSYEdyToaBGbF+pADA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2klpq9WHsRk=;swYBJGkG7nV3l9S8aCvEyeAgu6P
 pGgbd0BfK4NlB7h6Aq60NsDsj9NWoCzt/NE/7AkViChBkqYFeRv/7vPJDHh4tMVTOKIqSOmJP
 nSDwoJC61VA2WzpV0f29CuJHaSb4PDdkJTzRlVb1/FJAk4MMI3xq14os+ehNVTXq3MXQ8PYgp
 XpFUqyrrd0vLvw73yQ7+SK+4KENt6bgE8ginQrNikt6MQkm8fX2O9dTeAEIEV7eQMSepbcld6
 8dUD8Xed4DeLqmtaH+YaAD5JI7YT5TdH9N1NTtEwHHmRSHOGf97TkJIaNAzDftjPZeanMWANa
 AxCJnsl8sRoIUWgVvEfOJuf4+XCAtmc8E5sU4tZ/qx3DmjpLIFPQI1jSeEcv0wP38hF3Z9wlv
 ISikN5bDdC8AurX6LH9x5RhtQMkdJ870LKPB3ddYo5w4P/21iXoZECJduL5AOM91Ceu3YPrMN
 jtowlnGXhvACV27gdTpipj3kBwW+cg91pSM2LIr1xkBwaTiSl7B3DoYnVHYWYPMTFJotofh2E
 xPUI44PZk8CGVKfVJ8SWBVrGn7Tv1Lx13CXGzeJfpngEfsOQnYZxsU/XJCbG3ycAg0L4ChAsj
 3Y/1fr1tqMgmdnLAXWk4pbtrKsvUC2VQ7RhCLlH+7C7hhU5zbK4mWbUXJYAe2gNERo5QiDmgt
 Ovzl7GoLupxwKf3YqWZ26Pk1aZowpKRt9cfnBdVIlKQSL/8D9UBrpE1ZsbxUmbxJunIHlXDTZ
 QdixwcE6lWMkR2ZJxg5+bMB8gczJUcEeS2Jk6bEAWrGcMRgWDE42P+o9yLiixGG3eTomFulhu
 o1JhRP+m8zM0gDA3RE2SEFxUwF2mokRb/XGlbGrTOrGDtvQCoJNBYasYtBy8ss3hQC0EyY6Nu
 E/0Mbnb76K1cxeAaBxFGTfp+lPioJSVln+RNPxw6l4QNjcSJ3o58PaUeZEc6tRYIBGEPng/Ml
 2x8hJL1qJQ0uIGrtQSf3Be38g20=



On 2024/1/12 18:11, Chung-Chiang Cheng wrote:
> The error message should accurately reflect the size rather than the
> size.
I guess the second "size" mean inline type?

Otherwise looks good.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>   fs/btrfs/tree-checker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 50fdc69fdddf..6eccf8496486 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1436,7 +1436,7 @@ static int check_extent_item(struct extent_buffer =
*leaf,
>   		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end))=
 {
>   			extent_err(leaf, slot,
>   "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
> -				   ptr, inline_type, end);
> +				   ptr, btrfs_extent_inline_ref_size(inline_type), end);
>   			return -EUCLEAN;
>   		}
>

