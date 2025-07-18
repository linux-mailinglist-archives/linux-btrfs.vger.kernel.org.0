Return-Path: <linux-btrfs+bounces-15560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BFFB0ABB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017693A575B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Jul 2025 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A5321D5B3;
	Fri, 18 Jul 2025 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i7yPYIIU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BCA6FB9
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Jul 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874821; cv=none; b=TFC7mRnQ1dfYoHkNwk73qyPzvxtmFNPJ8SMPoXgSd/oqKHFeZTUq2nmx+vk5Y+8gKRNbDOyCmrOl0kz+yILLcpgEIxAkxGaSEnFD9GrZ/4NoYCze0OwZyyf3Li8E/MP13OPbbcwKlmcI1eymfx8tYbiGoAZGZC1RlF3DKFPZh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874821; c=relaxed/simple;
	bh=7sTPKWxmWERK7WcTSVKcXxfedlkNKY/ZGLA8wClWqW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jeYbes0z8SB7Lj/HhyNBde51Ri8WlzuIRNK5plqL8+dD69NUGpWKiUNxyGlcW0vXowX794xmkKrN8Q+NiXkVirjQALkbv0TrJFkBZYKvLje2fTC4GFNFI9+XbBZGrEgjB6mABX/r+sEPNv9sqYCzQxF1tregIjYhW97OlIwQmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=i7yPYIIU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752874812; x=1753479612; i=quwenruo.btrfs@gmx.com;
	bh=UJgwGN47rWiM98x4L/dyhNEGrzIikaVY1ekXZ//MDII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i7yPYIIU904JsEI56nArUpgXdjZ+0sZnyRP90QMwLRl5QNHZo4X/AxH4eqIMxRL1
	 rIantaMdcSISPqjvTAIAQybjB8+fPUGKkFHKm305NfvSgbORPzvE7CFVP41Iy/y8v
	 RsxYBQYcdIan+TYyhnkp3rRTair31cFQfQPWpf8DzzU2Fqz5HTZHy2dKxcBEsl6qB
	 sYILC2ck3xEeQbKHG4U42Se8QMG8BjSNwyPuBuxqNq6B/Rtk9MsnvjbLrfO4NZmww
	 NSAr7qmTLGLah4gQwWwJyTEJOu1GRCoWrvQclUkFmjSx8X1y7PliIGoKce7AbwZYr
	 zB08mhSgLRKge7sV4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1uj5qi35GF-016qMD; Fri, 18
 Jul 2025 23:40:12 +0200
Message-ID: <5cce84b4-a754-42d4-9644-27c5e593dcdb@gmx.com>
Date: Sat, 19 Jul 2025 07:10:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: unfold transaction aborts when writing dirty block
 groups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <2289bf86333cbe87cd607891d8021abff43187a5.1752859064.git.fdmanana@suse.com>
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
In-Reply-To: <2289bf86333cbe87cd607891d8021abff43187a5.1752859064.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TAGIxA/NYvBcYth0wPpA9DugepvvSnvcvGWd1LqyXKYkyVGLS8E
 s7rqDxa4RkYrNzSpjfIxNarU436mUbOA5DaNBbYnpevYINBQM5CJFCH90eN5kTv/x9a5Jjm
 KvhqrfHZfulYc2amlXGHECxHnkMfCEIpB2G0jVZQ+iXRy107TmdzUsjOsTOqf/o5vIW68dg
 BxSfE0FizRvJ4zY8RCo/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P14ipcb3j8A=;XKN5tt/Xqp8cBZymR71ivy/YQCv
 nCVqK4W+MWRuL68Q17yc5gDrRGUhkynCDPqLF2avdMkgWq++OTpp37lXiIbxu3MDklf0j+xjl
 fjDUKURyl5pfwMBcqIYLPXD5XSr1ZO48ZNLllziDMSP2lA18+JFVdXGHDKnc+NwChVWVQ/+in
 0H7WihALAWCfPpziK/Gl5930GmwzYe+dmGZYWUT9nhlOJKOcO4bDWZTKU1+mw3Mi7VQwaaZ3f
 hQLVX+Cwlb+tz3O4nMvoGvUSqGPFlOB684UliVewZJ9ONEokkhDtNo5+1PD9s9RDl3Y1qUOhn
 yjFsGlf7dfUvE1P3CuOXnOGuKQOZlH0yrPxf9QnfZPEb5EY95lTU1NYAhxq74CvtSQg8Ki6sX
 vCHPXZrccHZfyy5B5TGnBv74RE8Wp+wvJd0tcGh5gSrVu7Zr2cAiXke0zDnvDyVfcY50knAqJ
 GMu/h7UPjsBILCZ2gj2jPCLutfWBxfLFMQHNg9q05c3YCYXUngZRbZ4TGgKmu9/QAtF686Tf6
 pAlLtYUFPl3XOynKoi5C5jYo1Y2ELqQh6MHYZ0ecBrQtV0DIMEtZx5OTjGUTTm2Fo+fPTVYOy
 7GRvUz3XMr34YFJyxS+rGM2L9Dk6AkohP7lL0Jj8bZNrdWZ+r4px/dAXQLfoegVmeGjzG88+0
 ifuzaj9m4RBrmX1rQowRq2Rc5su8PJhvIztchVBUL7EYgtlGQdm1jJOKeinif2tppZ94GtrDe
 rLFPSfoId0qgpHgZ8e+b5FppCsAFuWpGD1XKnZfooVoR6wuOp/xlCNbvaGPKgrk7KW7cEOV4p
 qXg/H6GzZAHZtK8V2QtpVeMbhcjmFOPzCfaKTsACUtb9rp4gOl+X8+dQuThOMRJ2BcMTYToAe
 bk328VQwDCcGjHiyWK+Yy11nDp0TEnCczL0MWZ1R8VLimAsm2eZZ6Gq6dWc/Ie5NgCxhQgLLi
 aLXZtsYxekO7z6qqc1G3l67ybqAcmRdYeYOPUl1aA9jXO/4nhffjVKLtSvrOs4B+WN9xcB+5p
 ZUBKbyd9WxH6/lEbYwQQWbyD1J9HgFnVo/GH2aTAErHfP6TR0a3R85z+HZjwJLx83vIv4nidm
 m5hiCIttMKXrOiklVNq2RX+t505aFX1Z6Jpu8JF9YMtXUKGpl1JikxjpAs6cEXnuPTYnLnCXQ
 LHunTS/RfyDNxXIbJlIXbb3ZEwbhcHcRKkwOCfwKDu+rbQV2a1uFkE6uM2PRx3f7XKCfOoAxP
 FOIjQOSI+E4i5BbAPsKRryRnKarzmD3MglHL3p6IexP4sju0z6ljjHerPuMhtuhkzIBCoE4TF
 eaOC45SxlH3E0Xi42msYxatOLUSHJaIDYnXKDMMK6qeJbGFXK+lWY4OYKxJlQbUu4sbFNoeq2
 KBaxv18cC9DCFtcr08fai9X4AdZMMCmE68IB1+RF5ODRUECQ2SXrH1DncNyhhZm3bhYsrtaIE
 GZHOwoT2YEflUz9zfagzdSDKSnV/m/DVtyNetZkfpKCfty51RBhlrjsriFYHA9lQVWjzONsjb
 rMczWrqjHP/mTqtk4iQO4l1dyuIeCeqJaR36WFcvHzBBI05YFvncug4icu1CF3W9van7waMwJ
 GOLSvfUbBBHpZ9bRNeOEea3DB3hz3OWMnaRKTtV4gIDGz0ygACIv5+spw0HZ/pgVcMpZRfjTO
 BMmJMHDgjnUqEWAJUpsC9bGwSuEk5SR0ekPg67+qoTTf3jNqdb+yu72kHdEOrd2gyCHTDZMmX
 BFg0sKuGsVyR5MpMhQuET2xT1mN6TcepA9dB4ol/lRcWQ7NQA4e7G7MDUPOJcLdfsu2NW/NJA
 8ik01tRKfGD0e4D0DSG4/iquxcFx6rTzkZ6CNxDVI1ApgCudITir2PBOOG/Xo49erENV6EtHK
 xj+CHe+KVSymt4+Y7JMRr2l3sRrsAvJee18ebekNJRgDFrgNbcc+TAXRymqyCh8CBD77HU7rR
 asMfg6ki8t6UgiIwtB09N3cBC6YHETU22oxbofq+lMLvJN91KFAR42uj3rlLDSFHu75cAn5M4
 uIR4o4Bif6PL3b52VJL7SQNpUtfOAD9N6d8bWA5+wcqYIblsdUlEt6CgknozXhw/HW7rGb/Y2
 yLGrnIJO58YTbjGSoi9JJsJIC+ncGaaEhtRhqJ3z/xii5mv0xtRsmvSmeXVqzvPuSe92pRFRR
 XadRghdZU5mrGwgKGGvSkpdGaoA+4iCUjVxczf+QmKtSlKHfioLSacbY85UcaAl1UJbt5WCr3
 kryFJ+GljpZBal4Gn0VN0Ukn9+SUeNh76zjHh1iGTZx7HI3RMpRCMvUguiHh/nFQ2Kj6Fek/Y
 UiX+970Pe0M/J2EuhZWjt3zDaI97dwa/SU2YfFKadHzm0NsAEJjZAabeijB6cswhr+H6rd2X1
 1QrubASe23wTiuYAtS90+6VwhVlakrj2yu15ssUVEZYe0wx5mQEs/9pUktZvbH9R/QY+NhUHY
 J/GaqhatskZHwCFXxPKMOzx8tj7NekEoMGDEQm+quh1AXUtHy7XkkPCtSYmCA0wn7QwcedZug
 HZonpiolswqbPJcPQuF+JsYiBovwPJq4b79cRDNwdsnhDD5Z80Lfyu1hDzJrQ/zJveFz3bm1N
 kLoIDfPCMvO86nhrGnEDQhlYurAitLETuSHtGVpTICiUdfEy9GMthGvBEKDrpSLjQU04KaHGE
 4/9qF/l96dun73aZBeV8dOrvM28Uon6NRYvtesOvulzYVcr62JVQSLCamxLu6F3SwkZgebi1K
 vZ+x74U+tyJuowREtpU7N9yeZmGWqtHRE1aHwQB0NUReDDyuhON/PNdLuibU/oohdNZA8B9gR
 DJUGON8ksixwKzwZSkNcEHCOSKDLpe9ZbdKyIfqJDt+ZX3U2wPOCBFHrYENfnwxWZdEvDPigo
 5Zwkcybh+20ZGRC+PI2xygfk4x6x1BS9j199/361Cvc//4Ms4GmuKnXemzrP8r7zuI0F6vf6Z
 xfkAdKMPjDm8ESP+Ru6DjHyi3nUL9dv8p5Uvw5i+AFx1UzJfkLxoKvVoQMOSjzFFnDAvmGETH
 5eglQ/x1V/cjCO5Xg0UVTD0HHWr8vKbwlJdli8DguPllquR5KPxnhuEuVVwsAwtNXYlIL0J1G
 3V81oXvfoIGwNFEDyAZVtq0lFXwX+YsH5OMPDzwaMLQAN6o8zxj4JiBtozR/Ny8jkr+58idy5
 4PwRYjxw+i2hWdWQi7h1bpfhsaD1kOtti4IaNUlE7LzAHc2EY7K24GRPGHQ3RQBvBjJ/t1apk
 hUmAMbLMgEFITrnW/8x/5ACtQgOWrct3ZAyLLn+/Ep1+hYAbnawMuW1p8W74OR5+rRlQyRnFo
 JmRcLuFr5oocwmMnAUoSFqKlWlqb8RIZ3y9cjxDWyJNIDzwss2hjHs/KvkJ3+HAmJtnrywLX8
 Z0vUM2YvjuyqYMfqiDunkelW3X7U+0fLdpO9T3zN+sKtwi8c+hwyp0CYuPfaB9HfkhMROvfOs
 eFnXfy4KQslWS0bRoJgI6JiJopidpKkotG3mWjlPdfa0DVSm5e7P2jaalS2Y0BTetD4yGaI+n
 JmjYCoZSjz2PnfhdQ8xJfbSW10h0jPl2Kvk7VA6b2SJuFIe5s9zxMU2iryPfYGvW3HcqjETXt
 GIdzgWLIXNAbiHuWgJ/eI4JKWGNAc6QjS5y8R7NByx0hNbqwxjIom8mqA==



=E5=9C=A8 2025/7/19 02:50, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have a single transaction abort call that can be due to an error from
> one of two calls to update_block_group_item(). Unfold the transaction
> abort calls so that if they happen we know which update_block_group_item=
()
> call failed.
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/block-group.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 47c6d040176c..9bf282d2453c 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3644,9 +3644,11 @@ int btrfs_write_dirty_block_groups(struct btrfs_t=
rans_handle *trans)
>   				wait_event(cur_trans->writer_wait,
>   				   atomic_read(&cur_trans->num_writers) =3D=3D 1);
>   				ret =3D update_block_group_item(trans, path, cache);
> -			}
> -			if (ret)
> +				if (ret)
> +					btrfs_abort_transaction(trans, ret);
> +			} else if (ret) {
>   				btrfs_abort_transaction(trans, ret);
> +			}
>   		}
>  =20
>   		/* If its not on the io list, we need to put the block group */


