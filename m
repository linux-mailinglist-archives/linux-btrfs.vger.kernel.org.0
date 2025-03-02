Return-Path: <linux-btrfs+bounces-11958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD283A4B556
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Mar 2025 23:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919B21697A9
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Mar 2025 22:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C841EEA3B;
	Sun,  2 Mar 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="O/RvU4l+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435C132122
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Mar 2025 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740955730; cv=none; b=WJwgJIHSCDSqTWhHo1wPoJxl3N7goHzM5q1cJbeZXkW7yBCGoHZ3ksZoQE/0ncTPkva1nqD8rT11GtGJCanrNOsnZ+fvREsGi8L503hTlAlTCP4z774oJrhGXuiHtcGCzYsvvO6iFcRT+30abvR06vOiXN1lEZl8i+ys4FINfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740955730; c=relaxed/simple;
	bh=m9K8bkCUFxp2iYUW9z1aQhNF3NSyFgtnKDrggg9HKJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myeIEs8oeemyRt+49a8jlQz+6yG2s7yPXk+FPwMj9fPA8of3wGC6c6mhjeb+nLYizR99BqXeS6CSbsvtONj+1LlvbdzYQ9XUPuxh04wJUUO2lIGHTmj0dytCU/KkKS1gq3RGOFNH6qgFguMsg3gTsShxkww4lkaTgRN3spM+gJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=O/RvU4l+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1740955725; x=1741560525; i=quwenruo.btrfs@gmx.com;
	bh=2PmMx9doGV5EYVQNF7S4rZXh+e4TDj6jADV8hCK2yuU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O/RvU4l+qEg1Zbzj5hiKbFPy+zooOJq/hIr14O38jYrr5yNbnldFQmoK8L373oLd
	 6OiZq2oVNac6TlB5Eq4YuUXPPQ4Y7lF81BGidqu2p4K6oDsSeKmGmR7ln355r56k5
	 JKolXECivR15Io4yUv9iqhS48qnjtImY4YDxq9OqoG+7llYjEsKh7WvqyoPEEpChT
	 3zRNiq6DhrgkOkNjZ4KlPJIhZJiNgEYpLryWFDxishIQOUBeS5FNBD3ye5wASFsEB
	 JjaoClCgn53cIJKeRsPLFaROsSSjNLHnmQZNVkiv7/d4wri2CXW3nWrag7ce/Zd5T
	 cvJDp94k1JVXekUsOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6qp-1tVkvP2CRH-00cEcl; Sun, 02
 Mar 2025 23:48:45 +0100
Message-ID: <b067b88a-4611-41ff-862a-a61c73bf543e@gmx.com>
Date: Mon, 3 Mar 2025 09:18:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] btrfs: make subpage handling be feature full
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740635497.git.wqu@suse.com>
 <20250227111603.GB5777@twin.jikos.cz>
 <ffd5ebe0-541c-4d21-b7dd-f0bbe29c8200@suse.com>
 <20250228124202.GF5777@suse.cz>
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
In-Reply-To: <20250228124202.GF5777@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QdxQJOakW7SFxBayUN2fqX5iK3FQii+Z9C29byw/tYkn3fj4cEk
 OFSpggJDeNPq8PEFLzJCV7vewWjp+AUXHIppZd3Gfy1dkQYrLP55bC7OUVwcD1ioGqf5OL2
 AtIUBYeatSSaVQR7ZCWr9eZxZnKdkVmaFL0AumfnMTly1K9WQK8VrrkBy5HEHSXh+82uVFb
 EbNVZqazxqtyNRhZkhadw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YbGr2xG9W4k=;3GgixSynrM6vKViUJB/qgLgKOmD
 iz6+VRW9LtPwXFkwBwEoB8vkCWJzJ3jkUhUxIArS5tLApHso8wmH8Qu9NzMy6VSin61vv4gK/
 ZE/UHSPVX2FyfSiVM4LALy3FnFzHAkPcjz+7Vgo5Fd414yt1t+gj5FUfJ0lDJAoFAfzwthMS8
 RR6/Acv0DXB7O9xUKyN1B0FCP0sFpvXesn7XWA12R/YE68UAqqaKeCOuFH8lSTFSFqAeo1vFr
 /UVtCmFV6HHYJEkv+N99fUXtCP5yKuocRgceD5swAcUNiqtdkxi2ks4y7FJQqnjYTSw4LPtTt
 yT+a+AiYtVhGT34gipooJielud+jleWT+Rd5av/NzyTMFFIU7oQunJROizjf1Bz8XlBdWI+6j
 U2IpEl7nBWmU+RokAx1VPZUwyGWIasgtrDkyF2j0wu35XFDIrYIzGDVup1N4eFr9cXu8ZMwhG
 +iP4xFip4140hm5EfL1vbjeYImnWLg/pXmc5u8lclzjAVsMi7Y6DLA6GMn0dtU7WtfF1L7kTb
 WJYhogiQGpFTbKxMWWdC1orOsUDLRLfFU5P0254Pt3MgvksMfyeNh/cmSXPNGwyAJp45T4jqq
 B/NQOj/oHNsi3lG9swv/Bn6BpatowDW9sVsQBSpwZTmgfb2FEgZ8/OODxpAzmj9cE04jb5tAN
 EQMB5Xw/2DhTQqRTagD4F2kGWX0FSJw7+tznbJr4B2iYWlpU5H894OYNsdhlAB6w4nikk5bv/
 ufQ+PpFhCNMVwDIPNsuaEllK6sUkit2kBekKrPi2EG+OB0q2gyljj2Abe5w9AyX1P5XJiHwS1
 zlxW+GEq5FU/BFBod5TWM23SQV79MaIzh9/iJHud7LCxyjW2yxTN/y4gajfkKH/8Bp0ckVTMZ
 B+KGYFUI6yQt+IoCFO8XA5/XsVUWMZEfVhnP9ptTBWc/Jp9VfEnPvvJph6LERPCNA6xEmw6ac
 6tYzxGEXWwtKywksNc632z/201FkPn0VSolfNqxmEq2ArBz9Tcrr2GXTYzm0UlTvRaJU1QCDD
 beQ4azyZeyS/ElCXaavAyVivwWIqYQSyR124A/yqsYh/uXFjZtgZiOnNaDJncUQSsnWWq5olk
 Y5oc0WybCx7F0aRHJgF5ypbHrf3L9jLH+UPckMLRATea5D5E76PrvLWlYAxwME4hpYv9jvZq4
 NL/7Q4S7dwpkYOUgrDtGi9F/7j8HaUmpGSPvMaXsCMU0FiL7st+9rrKh1IYOdlbyIG+Pm3QXv
 PmHc3RhFFs5XirvPa7fNgIxNqfeP21fvvCXYRdua2L7q0f8OpAGWgcH9AmtsX4+v4VVql++/b
 mjrUquToEvGPrhtmhSNy01KAK/lKj65hJpENepjBcd7yCk8sYzetQn4nmVkqvf547UEKR+T1t
 A7Bi7pAM7Yc15K+DETLxChXBDUCnhcAOcR7Zk=



=E5=9C=A8 2025/2/28 23:12, David Sterba =E5=86=99=E9=81=93:
> On Fri, Feb 28, 2025 at 01:44:04PM +1030, Qu Wenruo wrote:
>> For the 2K one, since it's just two small patches I'm also fine pushing
>> them now.
>> Just do not forget that we need progs patches, and a dozen of known
>> failures from fstests, and I'm not yet able to address them all any tim=
e
>> soon.
>
> Yeah, the mkfs support can go to the next minor progs release. About the
> status we can print a warning and document it. No need to focus on
> fixing the fstests, I think stress testing will be sufficient for now.
>

It turns out that this will not be a smooth sailing.

There is a very huge conflicts between our async extent and subpage
handling for writeback.

Our async extent mechanism can mark a folio writeback at any time.
(At submission time we keep the range locked, and let the compression
work happen in another thread).

If we have two async extent inside the same folio, we will have the
following race: (64K page size, 4K fs block size)

    0          32K         64K
    |<- AE 1 ->|<- AE 2 ->|

             Thread A (AE 1)           |            Thread B (AE 2)
=2D-------------------------------------+------------------------------
submit_one_async_extent()             |
|- process_one_folio()                |
    |- subpage_set_writeback()         |
                                       |
/* IO finished */                     |
end_compressed_writeback()            |
|- btrfs_folio_clear_writeback()      |
    |  /* this is the last writeback   |
    |     holder, should end the folio |
    |     writeback flag */            |
    |- last =3D true                     |
    |                                  | submit_one_async_extent()
    |                                  | |- process_one_folio()
    |                                  |    |- subpage_set_writeback()
    |                                  |
    |                                  | /* IO finished */
    |                                  | end_compressed_writeback()
    |                                  | |- btrfs_folio_clear_writeback()
    |                                  |    | /* Again the last holder */
    |                                  |    |- last =3D true
    |- folio_end_writeback()           |    |- folio_end_writeback()

This leads to two threads calling folio_end_writeback() on the same folio.

This will eventually lead to VM_BUG_ON_FOLIO() or other problems.

Furthermore we can not rely on the folio->private to do anything after
folio_end_writeback() call.
Because that call may unmap/invalidate the folio.

What's worse is, the iomap's extra writeback accounting won't help.
Iomap will hold one extra writeback count before submitting the blocks
inside the folio, then reduce the writeback count after all blocks have
been marked writeback (submitted).

That solution requires that all the blocks inside the folio to be
submitted and marked writeback at the same time.

But our async extent breaks that requirement completely.


So far I have no better solution, but to disable the block-perfect
compression first, then introduce the same iomap's extra count solution.

The proper solution is not only the iomap solution, but to make the
async extent submission to mark the folios writeback.
That will be quite some work (part of the iomap migration plan).

Thanks,
Qu

