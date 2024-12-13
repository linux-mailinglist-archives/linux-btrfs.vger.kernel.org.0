Return-Path: <linux-btrfs+bounces-10362-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC19F17D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0226161B98
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE221922DC;
	Fri, 13 Dec 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YtRf+mIT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08784188704
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124086; cv=none; b=JtgLLBzKD6zEAHLZDyMTwQdi6OKDRzhsVEiMilu57fAkg9rorEKcb6a/OMLBZObqAay7MN2b77qC3tAhV5OmF0RSFI6GikTcisdOjuTzCtaHeSj8+5CNjQKCHj/HFHvEL4Xs1EnyKBfe+FalxdoJKsQJG5ht/qolftRqGahLpIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124086; c=relaxed/simple;
	bh=r0hMEjzaX8uMjdusp7K54ax08GlrVKIXY0TxBYFMOVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tw+T/bmEwcXwrDZW66jfFjxVE7aYLX/UdBdWgd+t5FaFB8zWSqmhrdkwSQFFVPfxVMFx/E5oDtr3TTz7tkLqIUfZMt6DUeUA1ncliKWI/k267MA/76NH+Qe9NgfX3xdJJ+SsbbpRsRg9TGGmGej3gPkCDcV6RDb5ySAOVDX6cpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YtRf+mIT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734124077; x=1734728877; i=quwenruo.btrfs@gmx.com;
	bh=jNAYo7xYU9QdX2URhKiOwQvqKI9/IHGrckLtW/ddN60=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YtRf+mIT8D9h/BmyqwkbeBdc3Wamq20HHE7aCEfllfLDOJgxbLPqaLlQnjLrGZNv
	 0aN+KsCXSDGc/KWF0JMnFgxn5gKEzxvp6+Fd2gKEUTzQvDoK/2de7kty6I17uhnm9
	 s7nR5TU5bpny1K7KvIVddUBufjZcC/04j/yaI49WD4Uv7dsT7g8mKY02YffwNNkUk
	 vlsQjgridE/PoPMx+IOqdIvrxIP2WAXpO5NpoSxyji+PlKFBxwwnH4Xu99yt+WkJ/
	 U3VBcAG1ewfSXnnWFOZkqn5rooqL+0GBunmZwBXvXbTjdQ/XQI0UERl6kd1RuqYXS
	 xQ6VN+R8agEGXXuwhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSc1B-1tBWia0uZF-00JPlo; Fri, 13
 Dec 2024 22:07:57 +0100
Message-ID: <137c7bea-5b12-4277-b000-4b42ee47501f@gmx.com>
Date: Sat, 14 Dec 2024 07:37:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] btrfs: fixes around swap file activation and
 cleanups
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1733832118.git.fdmanana@suse.com>
 <cover.1733929327.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:piDr5u9rylqsykcF6SjqUdur0pYCays1VvmRyLWrNtPxVBk5y9B
 uyAu6+UNikE0pqJXWvwgar2bnPq/RfYY2fGjdxMkbbEzNos5txsUeIdO3hf8Bd6cwgAJxIf
 BuA2me+c3FqZmzywdbAoy/48WJVHbx1abDPue0d8SyS4mu3x5Z5cLAWuFNuRL3EUGaQ7i78
 jTq0M1V35ZK8gBL+iUgUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Dlio0AnDaI=;oDvIEUZDO5To8WSgigftI+oKqkg
 vEsTbkHr4DHHEeT7AHG8VNDZG/1hkyJGYlAdrpW6LiLaqk7hcUPQq4JGo0z3FJZW5CmNuZPfa
 mL1HrxvEgA/fYmGCH7ebnBdZvx8UxzWMeyjFdPBsK/qnQuxUD7D2Z3uOSb6wXW0JU8+xMRBiF
 Eu8oGysRI//0uZvyf8tLB8U+NdNfCaKZwQrfk9GY9AkCTCH7inqNzEBQF6714JUwa2rrJVNA0
 PCxweChexpw74IMq9Ss3c7xtXL9qy3B3NZvQ75JBgHVOoZR4r8x4MJlE1iuN+gGUaORlPBr4h
 jxiid43upp2NomYYwzQVxxgquI5f4HoPfDzUw3Osud4W0hCg9QjVSM/f6AkiE9r3xBqPQzbGL
 BA/y0GQliEGvsaUNCuwat6SaQ+R8OFlALKglvZaB+DUuGFRomGNm8XVYyKhbwGqH34rqlox17
 HddxhG1zNwsXq+xmiW08mOY2PnrFqdLhKC6nkv3TkqokesPw9ASeEFz3RiY3aEZQGeMKqvhRC
 93uJEWuTuZE8XYMuq7mHWMu692mpJLnyVlmTPbiukMZbk+/62pjWo6TJb7+rGERrx5Kdq3Rsr
 wBD8aSD7MgVmk32cXSqRVyxPY+qhNOrIWU5suiEB9CCRhWLtcKZiX2GrPoXuYkhlS3J375Mmp
 8jqd9Mrphf6lsd57/lu+RzJGBeaMqyFBRVQvqld1QYpdVy2+ihTKBscm3xQAvi4wjPw4FYYXm
 ZWmiFmgt6q2sdWfiAO0VeQQ5rXMHaHvBjgxehGYkCSPq2aQWvYl4eDQ2kSsUgic4vNGdORXGj
 4+7/0istp+JdGDAQlfdltdvSMfrTRgjxm/oGbuTfnIxtVBblJ8feU6Uq62PDHq6w+sDZygnTt
 oujybVOIX9q+W4RgSfJpX4ZUwDjpr8nLSd+/5m+UOHQpdiIYfPEczCJCL7IFeznOxOkUNcp7N
 mG7GSaq09dQfSc8Z56e+xW+geGO1FeP3WIqy9BRvHzGKLpt3WiipBMtNeKV3IIYqP2upQafyH
 soBZ0zWQ98haYu1Fzzs1cFPwnr9QDg8IP0DHF0M8WX8Ai3Iud1PoveN/ARhpOjoyS1fVMuHIl
 EMeDp8XlDF5Az0OwwSjYnLxOJNEW4w



=E5=9C=A8 2024/12/12 01:34, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> There are a couple issues with swap file activation, one being races wit=
h
> memory mapped writes, while the other one is a failure due to buggy
> detection of extent sharedness - we can often consider an extent as shar=
ed
> when it is not but it used to be. The rest are just some cleanups or
> enhancements.
>
> V2: Updated patch 10/11, it mentioned a no longer existing argument that
>      removed in patch 05/11, the patches were re-ordered at some point.

Reviewed-by: Qu Wenruo <wqu@suse.com>

>
> Filipe Manana (11):
>    btrfs: fix race with memory mapped writes when activating swap file
>    btrfs: fix swap file activation failure due to extents that used to b=
e shared
>    btrfs: allow swap activation to be interruptible
>    btrfs: avoid monopolizing a core when activating a swap file
>    btrfs: remove no longer needed strict argument from can_nocow_extent(=
)

Very happy we can get rid of one of the double bool parameters.

Everything I see something like func(x, y, true, false); it almost
drives me crazy.

Thanks,
Qu
>    btrfs: remove the snapshot check from check_committed_ref()
>    btrfs: avoid redundant call to get inline ref type at check_committed=
_ref()
>    btrfs: simplify return logic at check_committed_ref()
>    btrfs: simplify arguments for btrfs_cross_ref_exist()
>    btrfs: add function comment for check_committed_ref()
>    btrfs: add assertions and comment about path expectations to btrfs_cr=
oss_ref_exist()
>
>   fs/btrfs/btrfs_inode.h |   2 +-
>   fs/btrfs/direct-io.c   |   3 +-
>   fs/btrfs/extent-tree.c | 128 +++++++++++++++++++++++++-----------
>   fs/btrfs/extent-tree.h |   3 +-
>   fs/btrfs/file.c        |   2 +-
>   fs/btrfs/inode.c       | 146 +++++++++++++++++++++++++++++------------
>   fs/btrfs/locking.h     |   5 ++
>   7 files changed, 203 insertions(+), 86 deletions(-)
>


