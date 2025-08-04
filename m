Return-Path: <linux-btrfs+bounces-15825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC988B19A8E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 05:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DF61892CFA
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 03:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C721CC59;
	Mon,  4 Aug 2025 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="uQ4jOFmt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541061E489;
	Mon,  4 Aug 2025 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754279921; cv=none; b=RbEO7O5GSMZjzlxpPQdVANTFxFij0g3Tt8relPWBNzBfha1Oa5+V4BuN8dveksxHLbWiVmv3bkQZdPA36m3EByolIZP1WuLDbUajuhBvoTXb1SnFKcADKbLom457Bo1rIz1sc43GM+6LHV20MbSCFzI+vj9Idv+IUqnvQVKKznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754279921; c=relaxed/simple;
	bh=fdziFVl1MadDzNBDq8FRNqeThWeJc421DXJka4otwv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hq1P6rZ8FCdN7t9vB8Y2FfFVU2UeqKVdCy3mfrW2J8Z6UTMMEvzzM8UWfHVc/1kvZi0DR+i+hLekrEAHnbe6r9m8EHnf4hHw1cMSUBDpprmb7DIXeOUUdhSZH+o+Lqc//uJl00mxWkVRwpXbUric1Pr/4rzqWu2JCkuj5FtWuUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=uQ4jOFmt; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754279910; x=1754884710; i=quwenruo.btrfs@gmx.com;
	bh=5wNy9xuq+dWMU+SSUGF2Ze/0Me2l298fwECXpk+2GBo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uQ4jOFmtTtfjxKHd5FvTJhSjHthrhNJ+unwNKNce7maoJZEz06Zzi2A+NGIG6vSF
	 T9fIIAFOUHvxbGHgfUOalJ7km3sxeMS9leM3YgyEehmnCVYA3Z4c7iWq2/20qbWT9
	 nlvyHCFSij3IRt9lNpaCFTlKrZeLXpH4hV2vJ7t+vL9NYlank7T45LivWyThteCqk
	 EkjL4JsH7fxQ+V4MVCQs6nX/egx6W3J7SYjn+Bphyba0hyk6BwjPkSQtkkCem8ZMw
	 1UGhWksbY8ypWuDDSp/Wj2jYzI+Rhcclyodbn/2M5vv+K4DHMIIa6rMwt96JQep44
	 AaDuQtq8lO8cFILROw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1umc5z2LeQ-008ikt; Mon, 04
 Aug 2025 05:58:30 +0200
Message-ID: <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
Date: Mon, 4 Aug 2025 13:28:24 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z/rvrDjnlHWoVuCscAyEE9fVQfTHKmVC2gW7J45yXM1kYgmx4Ke
 jtsxukDsuzO0Yc9CLq5ucH/5IJhayj2wh2RJb4OVpDk+NtH8gSjfZp5CmQ5faiLn6hDTRUm
 y/f524vMojOlu/XMlTCIIRHibtIUmeSmCbNRhrkxGUHHw7iX8e2XmOfm5jXP6L6oDP5S+1p
 uk6XXpLqmSy9/YaQrATzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CfzoKEc2Z1I=;M9qkS5B4OXTJGALvk9gSSDMiYHQ
 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



=E5=9C=A8 2025/7/29 15:51, Nirjhar Roy (IBM) =E5=86=99=E9=81=93:
> For large blocksizes like 64k on powerpc with 64k pagesize
> it failed simply because this test was written with 4k
> block size in mind.
> The first few lines of the error logs are as follows:
>=20
>       d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
>=20
>       File snap1/foo fiemap results in the original filesystem:
>      -0: [0..7]: data
>      +0: [0..127]: data
>=20
>       File snap1/bar fiemap results in the original filesystem:
>      ...
>=20
> Fix this by making the test choose offsets based on
> the blocksize.

I'm wondering, why not just use a fixed 64K block size?

So that all supported btrfs block sizes can result the same file contents.

> Also, now that the file hashes and
> the extent/block numbers will change depending on the
> blocksize, calculate the hashes and the block mappings,
> store them in temporary files and then calculate their diff
> between the new and the original filesystem.
> This allows us to remove all the block mapping and hashes
> from the .out file.

Although I agree we should remove the block mappings from the golden=20
output, as compression can add extra flags and pollute the golden output.

But that can also be done with _require_btrfs_no_compress() helper.

>=20
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/btrfs/137     | 135 +++++++++++++++++++++++++++++---------------
>   tests/btrfs/137.out |  59 ++-----------------
>   2 files changed, 94 insertions(+), 100 deletions(-)
>=20
> diff --git a/tests/btrfs/137 b/tests/btrfs/137
> index 7710dc18..61e983cb 100755
> --- a/tests/btrfs/137
> +++ b/tests/btrfs/137
> @@ -27,53 +27,74 @@ _require_xfs_io_command "fiemap"
>   send_files_dir=3D$TEST_DIR/btrfs-test-$seq
>  =20
>   rm -fr $send_files_dir
> -mkdir $send_files_dir
> +mkdir $send_files_dir $tmp

Just a small nitpick, it's more common to use $tmp.<suffix>, that's why=20
the default _cleanup() template goes with "rm -f $tmp.*"

Thanks,
Qu


