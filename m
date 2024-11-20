Return-Path: <linux-btrfs+bounces-9796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250C9D43C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 23:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B2028368A
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC93D1BC086;
	Wed, 20 Nov 2024 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YqvcxOjE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F3333998;
	Wed, 20 Nov 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732140431; cv=none; b=GsxcdpzqmAxGbHRC42yNGc2r+9lPnsxtGC5nwuoKXtWUv9OJ+rKN3NyNkSZfiZJoDMOwY9hO5BBRJ4aluLjtksXiXsRv0LBJRWDlt8ziMDINu3Hzk4a7E/ypFgnauFtV538RFkkj2vj8SS/dxWOwfhEdB2hG8c82nBs2Rngpl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732140431; c=relaxed/simple;
	bh=TcoueP1+LPjAqEKWEbJ58Np0bSqbg757lhFVZsREuxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8jRw4gf3zqBQb1xGgZkwCRS2N+32lDzu94WfbolEGw7VpRJWQ6J9Jg/TXMLWsN55t/ZfRUm5GChVT0kM54rx1Nc8pGiPP9MyNcoE1x8S9AbPXk/cuOg4yFnPK/M0bwlI8PlXIbnehbAUlhJ9uGnmQgHCQ1sXF+1cCMxy3Z7QAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YqvcxOjE; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1732140422; x=1732745222; i=quwenruo.btrfs@gmx.com;
	bh=KQkwEdGradvceENobCLXZ2bQPiyM8Zvog1e4KGbgXg8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YqvcxOjEKU6Ix7YiOOz0MKnQsTCzFlw/qPFApUw5GBiLi1TRlTKB+LqusH2K/UBL
	 2IGtD6A/GurXR4EjDGBA+1t3poEL9C/qUXFZMvACNUGKkipKVxt+QGuzlEcBmgnkv
	 NRwAA7Ynbi4xe7/0eFx79NnEHT/60Sef/W4h2TdY0LSFee5+I6QdjHy/fPEhoRfO0
	 k9cgKixlyRqAI7sqmdnpL6wntY7Govjux0MO0IdcUmwNBCZ4DL6F8M6Mhvkbjdq83
	 cIrJRldQ/Ac0eFLshTeFuRbFwIO5ux57QGntGsXBWJtm70Xp0DFsmzozEsfD8CzEz
	 GU9oJB4LDPo1M8Ekzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MplXz-1tWzvc3SYf-00dNSO; Wed, 20
 Nov 2024 23:07:02 +0100
Message-ID: <1141f20f-86e4-4638-adc4-5cb290f87691@gmx.com>
Date: Thu, 21 Nov 2024 08:36:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: fix blksize_t printf format warnings across
 architectures
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
References: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
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
In-Reply-To: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7Jy1/iK0JvEKL5DCMLaF3rDju68UjdhpGKPnqdxycB30kjS4Ffk
 Lp/+QcXtl2kdw4Kf94pvCFaO1lAmZ/+i7OBht+9GKr4HAO0B5DQgPkqAiLm7LO7R3wxVnmJ
 gAfT9eMya8J8EtGXjrdWjz/Vi/wXSjqj6+WredU+/kmRqhDPdKjwA7+fPt0eb5dEwp6lwml
 uCj1mK19ZDnOO+JLVTBuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pDgitaMPl4s=;SV8h4iBs/QXOaarLMzd0AqKW+Y/
 9HMd5wfc/uiRNbe3tdmq+rvhPZIPp6Fq7fzSrDGbIwRfdkSUFxX7eXWcCslK+M8zzgiVZZcYt
 +J4lt0/ga7WIIct9zIzzIHE8Yl0yYs2AokGmMhpdzWBRIUXXzzVoOT0fEJYl+Bpt+fkwAlFg/
 vSsGrAmJRj8VSsKo7KKqfF1NbsWpbM06UyVaTtbnXMWISbp+Rr8WCzOMe6baFthSbGfewXm7C
 6sEdceH/M7o8inivSvGNouVQgnDljpe/efl8qBZhUWXFvF1sSRs64Qjg6hE5SBql7P/zsWZIG
 yhrYBkRLg8hgQ3nSJ3FXL2vfIcri+Y+m7IceYocIqHyHPpGiOmZdNqzfpgXtGkoreC/zsJaK0
 8Rbb9sHHycdVErCjD+YSHVKJjsArqkyBAcBSsTZrweYa3sKAatRRcAAHBc60zod+bdLbxTCcM
 7IsfvEGDr+UB5jW6tkqIeFfWkq1DZi1tbhxCjlITFqU6T/iwbp+PmxG5K7yP89U1HDF0TmOWJ
 HxUVFTAZRpv6PembjBMWTwpDUD1eMejzIpE8QwoMz4DnZRJzHRgIMXvsZwByeC0XswRPhv1ip
 cLEk1lMkOvFmLeewuzERWz5fd7CbKq32R5lvM8DrQUOOeEPkoKGO4m4iJL9FqfXNQVoLvUWV4
 fy9HLBuXwyQAxtDq1qHI3QG41wfLmM+XTWZm79g2M/kZDxreWfQPWpujUW6fC7SqhGyBYSujn
 g8EF6YY0CvXi2Qwbx62u0ZfuRqvZzcaFdLzzRrLc8iQBUKOtgCgQ/E1Ujf149oqILkt0eR+WY
 IDV9va1TqL3aVwxG2npbPAYJDjaW4gwY26qjOHwmO6DwChYJLrzSLIagcwstswetC+BKbzZ9W
 1/VGDJQzmUU9kQ0QXaiXWmkK44I8BKPasjcgsTKgjmXrXU2YNYCSdp6n6



=E5=9C=A8 2024/11/20 22:10, Anand Jain =E5=86=99=E9=81=93:
> Fix format string warnings when printing blksize_t values that vary
> across architectures. The warning occurs because blksize_t is defined
> differently between architectures: aarch64 architectures blksize_t is
> int, on x86-64 it's long-int.  Cast the values to long. Fixes warnings
> as below.
>
>   seek_sanity_test.c:110:45: warning: format '%ld' expects argument of t=
ype
>   'long int', but argument 3 has type 'blksize_t' {aka 'int'}
>
>   attr_replace_test.c:70:22: warning: format '%ld' expects argument of t=
ype
>   'long int', but argument 3 has type '__blksize_t' {aka 'int'}

Why not just use %zu instead?

Thanks,
Qu

>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   src/attr_replace_test.c | 2 +-
>   src/seek_sanity_test.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
> index 1218e7264c8f..5d560a633361 100644
> --- a/src/attr_replace_test.c
> +++ b/src/attr_replace_test.c
> @@ -67,7 +67,7 @@ int main(int argc, char *argv[])
>   	if (ret < 0) die();
>   	size =3D sbuf.st_blksize * 3 / 4;
>   	if (!size)
> -		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
> +		fail("Invalid st_blksize(%ld)\n", (long)sbuf.st_blksize);
>   	size =3D MIN(size, maxsize);
>   	value =3D malloc(size);
>   	if (!value)
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index a61ed3da9a8f..c5930357911f 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -107,7 +107,7 @@ static int get_io_sizes(int fd)
>   		offset +=3D pos ? 0 : 1;
>   	alloc_size =3D offset;
>   done:
> -	fprintf(stdout, "Allocation size: %ld\n", alloc_size);
> +	fprintf(stdout, "Allocation size: %ld\n", (long)alloc_size);
>   	return 0;
>
>   fail:


