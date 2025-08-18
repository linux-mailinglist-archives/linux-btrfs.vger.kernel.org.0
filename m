Return-Path: <linux-btrfs+bounces-16137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2EEB2B407
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 00:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1B8584200
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FE27F00E;
	Mon, 18 Aug 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SYnCIXfi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2E27B4FA
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555253; cv=none; b=Mej9AifInzZme3D9xNieFdGSo1wqoi2mYvVfpFzyJzVw2vfJX7WNJ0xh50Ejd9jgJRcrodZWUEq0StFkBKK6v2gBKcmK4IdoYAcbPtdT+s7KLoYdS47TiZvEaQ0hmr9U0qlUnD+sIIZDyhDX1P7FPZ32+i2qS0DjpoexX9T7EIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555253; c=relaxed/simple;
	bh=7qlXefFKnlH/8mbE+5ZCeUp06v3Wy1rke8gTxxlaMbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NByAIkpWUQy9I1N9W3VJCPEIdxePrAvr3qyKhxXPWcJO5JjQ6tBnY38kBi/JJG4TDGNDQBx2xVxlXU8FgyKRqP3yIMRvmWMmajPWXnZz7uvYY+GrZQlW338W/ZrthANYDCBlpz7/4lCksIt10I8exZs/+vilx6LCvGAoggIvrSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SYnCIXfi; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755555247; x=1756160047; i=quwenruo.btrfs@gmx.com;
	bh=QAj2voDWVx/hN8qkqDWN0go72D7RQ+sczZI+Yw5Mh1o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SYnCIXfiGpFuXFCH58RWHOgwqKnWAhdKPC/Nt1LhBN1haM7t67+cMXd5T27tH0Dx
	 ZgUp70LeeW5k7eIr0bfPF8VfFqmAarv2T1lklRACj/FQTOUiiUFwZWl/aJWkLAmm8
	 pHXPwSO5i57QU538FmxBgeFPpwFXgaw/WaXiq2umL6N2kE5SYRJ8uqLeEQ738hPiv
	 btuTm85bJPChQ4JAGC8DXFOBKjruI27sD2ZLQToQRFWf2epinDoWdJBJkZKVr+gHa
	 hCKXYYDmMrDMzhBmYaFH18HtTHPo6YD3mQg8JcvO1e8BTSlqRVGMxnsYnsvWT+3NF
	 I06PI7RIrXe5jRM+fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9dwj-1uSrfP3LRl-00zZL2; Tue, 19
 Aug 2025 00:14:07 +0200
Message-ID: <7e3d86a1-7003-494c-9a8d-4efe6a57824e@gmx.com>
Date: Tue, 19 Aug 2025 07:44:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] btrfs: add workspace manager initialization for zstd
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1755148754.git.wqu@suse.com>
 <db54546adb1bb51b2b9d1841520dbf9dc64adbed.1755148754.git.wqu@suse.com>
 <20250818150829.GL22430@twin.jikos.cz>
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
In-Reply-To: <20250818150829.GL22430@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8mNbc8psTpMeET7xZdMIEBxJCuRf3hak1Co4Ad/+yckrPlvh1dd
 khGIpabzw+qtWs4xH10ANvcogMSNsOVYgaVv/rg2tlLRlza+Mn4q5sT7oyp2GRhG61MivCN
 lHbT2TdvO/2iKTs8noF7npnubec0C6MdQA3GejQuT0hzxubN/gm07uMGwXNRzn1Ki2wrxZn
 pCqXYlA8FeuXgm5wL0OOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gTGS/SuAPoQ=;tCdMUB9TLFr8kqQWivBpwtk/IYm
 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



=E5=9C=A8 2025/8/19 00:38, David Sterba =E5=86=99=E9=81=93:
> On Thu, Aug 14, 2025 at 03:03:21PM +0930, Qu Wenruo wrote:
>> This involves:
>>
>> - Add zstd_alloc_workspace_manager() and zstd_free_workspace_manager()
>>    Those two functions will accept an fs_info pointer, and alloc/free
>>    fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD] pointer.
>>
>> - Add btrfs_alloc_compress_wsm() and btrfs_free_compress_wsm()
>>    Those are helpers allocating the workspace managers for all
>>    algorithms.
>>    For now only zstd is supported, and the timing is a little unusual,
>>    the btrfs_alloc_compress_wsm() should only be called after the
>>    sectorsize being initialized.
>>
>>    Meanwhile btrfs_free_fs_info_compress() is called in
>>    btrfs_free_fs_info().
>>
>> - Move the definition of btrfs_compression_type to "fs.h"
>>    The reason is that "compression.h" has already included "fs.h", thus
>>    we can not just include "compression.h" to get the definition of
>>    BTRFS_NR_COMPRESS_TYPES to define fs_info::compr_wsm[].
>=20
> This is a bit unfortunate, I'd like to keep the subystems in their own
> files but we'd have to add another kind of indirection to resolve that.
> Either a new header or another structure for the compression types that
> is not embedded in fs_info. But the type definitions are short and used
> in a lot of code anyway so no big deal.

Yeah, I'm fine with the change as a temporary fix.

For the long time, I'm always wondering why we didn't put this into=20
on-disk format.

It's part of the btrfs_file_extent_item::compression definition, thus=20
on-disk format seems like a better fit (for the 4 supported value + NR).

Thanks,
Qu

