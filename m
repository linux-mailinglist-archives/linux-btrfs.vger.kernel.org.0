Return-Path: <linux-btrfs+bounces-13051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656EA8AC52
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 01:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1FB190210E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C52D8DD5;
	Tue, 15 Apr 2025 23:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UkS4HE3p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55296129A78
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744761201; cv=none; b=WxLHLwiGMXPO/STmfe1xr5hiXbzCt2QT5vnqOO03iB/alz42Df5/ztH9too9a1S173VG6kb2XLlofvy+Hi/Se1eCmkuRmdTM+79Iw6bwUAcUR2ZXcsFAsVE9kMZSgTy4cqzurQfAzxVMIkhE8Mom3auOQ85lNPNL0hovG+Fijf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744761201; c=relaxed/simple;
	bh=fzE/KQjC2+5JpFhQADCKTK41+sxTnjNHomfbWA+GD7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCYTzU2sBhnNMq3mUjnv1XzFSO5u+cEkKGmCuizfalrPciZDr2jbNqPUDoCiO05PX5szOrR6n4KyS8rAYAtlQ9skgAOUCQFMEBlR6Qzi+4RrUH/NHEvUXIALe3pC7DVkaGHYthgtwXgrBmAgUrSVQp09TcZ+aZmKmnaAyMqOCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UkS4HE3p; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744761193; x=1745365993; i=quwenruo.btrfs@gmx.com;
	bh=OJ7gVo329VZoj5TFY9UFxTXNsVn0cpD/bDYk5vcbwUA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UkS4HE3pSBImvAlTiyQJqYZXXtXOW8DjYkniFHsUnsPP9YExlHV2v2kXA0BefGLd
	 T3yajAiZ++yWZ8yV63HDtKpRvAsE7XqOUdgoWyCQEkoRUO5Y3YchkM1ZuTsBbE7sj
	 LZy9kJ12lbDHpCR1f6QiTW3PfAf8F4lZAuifXHkoZf82wGvJV2YmBmJ1JBKyFFXZE
	 RJqQ47KZIey4KWbtAJ9HbmKuXPsaBj+fZgMAPFYRCyFtwgANsEdl5Q8yNLqi9vmGi
	 owd1Bwsud9h2yn1ssBwMcaqbue7NulkAsD9cfJUXpuPlO9PP8AyocXagWcNjN18PJ
	 6UeH9WyHpfw7Yykq7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQnF-1toZjZ49Tp-00EB2V; Wed, 16
 Apr 2025 01:53:13 +0200
Message-ID: <e137c120-4d7b-447e-84cf-b08783cbd878@gmx.com>
Date: Wed, 16 Apr 2025 09:23:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1744657692.git.josef@toxicpanda.com>
 <7e863b3c-6efc-459b-ae25-cf87734dc38f@gmx.com>
 <20250415172344.GB2701859@perftesting>
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
In-Reply-To: <20250415172344.GB2701859@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tjfAzq3gjHpkZzbAD3JQgXw9a+/gSXXtMe03Was0rhI+LGX62DN
 U48xvFnWdCcS+jDnQa/lGT3WfyETn7JJUJRlY/83p5cEMCRmiyO0Q6DAVD1Vw16kx1j5rOl
 SN05sgW0vo8QleZS/ufKNvAgLTSFSacmvRUs1oTytZrd+mjEY+3JN+dt9nvjV6GlJCfzf5f
 b+aH+rUWUMv9s7xDEsWmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tk9iV92Fecw=;7eaxi7Kd6Jtf0QK32RC5trH0tME
 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
 a1RZ4cLFCqAValudCr3GQsAeLaFzWlY=



=E5=9C=A8 2025/4/16 02:53, Josef Bacik =E5=86=99=E9=81=93:
> On Tue, Apr 15, 2025 at 07:38:29AM +0930, Qu Wenruo wrote:
>>
>>
[...]
>> The problem is, we can not ensure all extent buffers are nodesize align=
ed.
>>
>> If we have an eb whose bytenr is only block aligned but not node size
>> aligned, this will lead to the same problem.
>>
>> We need an extra check to reject tree blocks which are not node size
>> aligned, which is another big change and not suitable for a quick fix.
>=20
> We already have this.

The checks inside check_eb_alignment() only ensure the subpage eb will=20
not cross page boundary, not strong nodesize alignment:

         if (fs_info->nodesize < PAGE_SIZE &&
             offset_in_page(start) + fs_info->nodesize > PAGE_SIZE) {
                 btrfs_err(fs_info,
                 "tree block crosses page boundary, start %llu nodesize %u=
",
                           start, fs_info->nodesize);
                 return true;
         }

In fact, it even allows such unaligned tree blocks, but with some warnings=
:

         if (!IS_ALIGNED(start, fs_info->nodesize) &&
             !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK,=20
&fs_info->flags)) {
                 btrfs_warn(fs_info,
"tree block not nodesize aligned, start %llu nodesize %u, can be=20
resolved by a full metadata balance",
                               start, fs_info->nodesize);
         }

Thanks,
Qu

>=20
>>
>>
>> Can we do a gang radix tree lookup for the involved ranges that can cov=
er
>> the block, then increase bit_start to the end of the found eb instead?
>=20
> That's a followup patch that I'm testing now.  I've started with the sim=
plest
> fix so that they can be pulled back to all the affected kernels, and the=
n I'm
> following up with much more invasive changes to make these problems go a=
way in
> general.  Thanks,
>=20
> Josef
>=20


