Return-Path: <linux-btrfs+bounces-1994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E28456FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F141F24E7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DE215D5D9;
	Thu,  1 Feb 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="M3LEou8M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756615D5DD;
	Thu,  1 Feb 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789317; cv=none; b=tPj7NJxyjyuhDpKBVfSV/sFazLsakCNw2m8RG2sORbFpt3rdqBkmnrxMGF5Xg0T0/RG3j4fdBBx2vY/CCI7TuRZhu8hsJfzuUCq/xXesxulkunwh+p2p03VqplQP6EL1zWtkWGBek1qdqPXhdr0n7GLm8TLlP119NedKGbW/tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789317; c=relaxed/simple;
	bh=5YHOQ4t6yvK3SOA0EQMMmdoojJngamhIGtLZGsyLgo4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ie0SwaSOl1JFQNGeZqpavO0fit+TSLRSazBOhl9c1Evjln7d1lQk1gHYbxCbFARRD+aAy9UvpxQmI5cplAxzDOTB+OEPq/j2A9qIW/vsRHD9TcZ28EBt4TZ7E4VrsELWhaEGaWtkzNOaPYv8IWtf4X6kbS7zpcXJ4shLHI/x0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=M3LEou8M; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706789291; x=1707394091; i=markus.elfring@web.de;
	bh=5YHOQ4t6yvK3SOA0EQMMmdoojJngamhIGtLZGsyLgo4=;
	h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:
	 In-Reply-To;
	b=M3LEou8MMS9TNQvjNu/ylUsfrcTZ1OUVx30pCajQzVW/8shzoQbC+WfK/r4ARlk+
	 vfQ7je1kym7XyDIT+KglvMYc9Zv0yW02NQS0Kj41Pb5rV6J1TwQgARHk/7uhJNCK+
	 pByTTKceEB7hhg4qz9upH/siB0sKs8ciN40UgBrXudIKyYea46r/+FXqeJOAOZ3H9
	 Ab7Vr6GSIq+4d/7SAJexowrmTqfw1U6GUVqwKoVEzAzEFUFI31QF45kOuW/fhjF5g
	 Gd5+xhucxfQKrq/FsvAJCJ20M24Y1CGsePZ5pERshr+B553p+QjK0qlDo4Z+W3cA4
	 0YepboYwYebp/R+A5A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOm0x-1rgs0y0diR-00PweK; Thu, 01
 Feb 2024 13:08:11 +0100
Message-ID: <dc42614d-adee-4cf9-96e4-b27604360a9b@web.de>
Date: Thu, 1 Feb 2024 13:07:50 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, linux-btrfs@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <a6ed9030-8d48-4f9c-8504-9a5308813791@kylinos.cn>
Subject: Re: btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a6ed9030-8d48-4f9c-8504-9a5308813791@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tTR37h8N46o+RCJpvASlOfWYMAUb/RsxgvmxcFn4VqZVCNz+VOQ
 +TOTHTfBox+SSAX1Ef7at2fUMMNHBbUN+xOXpHMPMpgj+LmeSgeQUxF0fb8G/sfCGZUKPIY
 UJGTFWcVOfTUalTsN6ZpHzFKfPHkjihgixACFQuiY6DcyiU3bHMDAhyTz18t8qolD1V3YYw
 6QkSWgkylotG5Tunt/IVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mqIb6wq4LtU=;b4G7ICZaPcoftmM5jOtpljxBMY4
 5GLrhfnMWHfJ6VvAcmVMCGYLumi7hV2GNCE98m8mSBXZi8WL/Ua08FGxmRin8EFt/jzMnE+jy
 zS4S9+1wZts0+1ndt5Aun4t87+tn2mmrG9vX6PHLh/5kHfdde7YYMSVc969NjziLWJmgVYUV+
 hYM58UnZFhD4dO1ea5jdjCggdYN/kRox4qk8eRD+LeFkEwtNnjlRwWxGZcBDW5FIr8Vdjsd/7
 0DHk+ZxVFVCdJMp2M51S2SQ+CYlUPZQ+PlrTlSGSSbHGTx8I6kFFyv90j3gvf2AUotCwHtdco
 UlGlGwnSi7quqXL22Ty+JHVaANvke3496t7CYjq0NkJjl/07S+YGBA5GtVQjhQ1k5j26EJlbV
 9wSphFvxdpmIMHGLn1NHRD7B7BVOFkThcnkYQrsSEVtHHpVR2XyN1Spjgm41I2nA0aLfbY4HI
 zJIXNGfZwQNVQSHHBMf3L20zfB8TrZVa+O/CvV6Orz1iGh/V+gdfvBRtvp9Iz0RjxpxinAJ1P
 bn1M/axtSiB/HBaMJK5dXX+lz914FwX5FDv2uL76BzuYGVMKMvV3dgM9cUesbrv69lUnpVBIz
 OvAWFwPIQieIgdfA9yJcRakODNYXgtU5ddvkTHwVdqtpfRVJBCXzJpnuEGLuhea8qNgt+Tdi3
 9qQx3CLm9f1Y9ogLqqBXhIbts2JveK03iIglZZYaUTbP03lE7qPsiIJJ8fGos7kTgHbTj6zTm
 0P4v9u8zagOHAzBk3d9GAAg61XAUCCEo6SZRgn6S3eII2bEFwkvYwKZbhy5mg0oqXGnVD0p/8
 mME5tysoru8UP6+kMaPukDmPKzeHl8YiSoThCeD8UIPms=

=E2=80=A6
> So i'll update the commit msg to this:
>
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> Make the code cleaner and more readable.
=E2=80=A6

* Please replace the word =E2=80=9Cnew=E2=80=9D by a reference to the comm=
it 8eb8284b412906181357c2b0110d879d5af95e52
  ("usercopy: Prepare for usercopy whitelisting").

  See also related background information from 2017-06-10.

* How does your response fit to the repetition of improvable change descri=
ptions?

  Example:
  [PATCH] btrfs: Simplify the allocation of slab caches in btrfs_transacti=
on_init
  https://lore.kernel.org/lkml/20240201093554.208092-1-chentao@kylinos.cn/
  https://lkml.org/lkml/2024/2/1/387

* How do you think about to group similar source code transformations
  into patch series?


Regards,
Markus

