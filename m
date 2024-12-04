Return-Path: <linux-btrfs+bounces-10057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C859E3375
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 07:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E31B242E1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600A187FFA;
	Wed,  4 Dec 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="n6ukyLqk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD980BF8;
	Wed,  4 Dec 2024 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733292835; cv=none; b=uJ7DN8+hwIKZU5Lo0N9epiWgd6dvxH0N4U+IvsqRgHFV/Lc5nn6NZ6UpS6axjeI1n3Rc3agz+o0s4H0a/KoIe5nDhfKaXbCwjkZ790DHkqwe3TwoldM/LItNigwc+o6HafvkxTp2SMoe67fJFZA2MyYdYIJKncmfjQC9CnTKlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733292835; c=relaxed/simple;
	bh=oiJcmzV0ir7YgFDiZnJqjaI0Xbe0k0RUZf4lk8e1sl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jooyJRKzDcehzd1SWFoJNCa2gmYeUIi1LHMjvpyRCjX/poX6hE4lTW8EOrLzfESEiIDpycP4I/oiJofY0QPP5qV4EfZTG0oZDhwKA3Z7b6A5LNqZQ2K4hBZKJprh1BW07G+Duy/Iy+V41iTG6IxjxSkINeoO9ygagRK+VKFf2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=n6ukyLqk; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733292820; x=1733897620; i=quwenruo.btrfs@gmx.com;
	bh=BAwWjXxGKBbQhZ6mZqExeu75S8gB0Lu4Aby/AgVIbUs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=n6ukyLqkKeG5oM3666lFNrr6pPK8Ojc+wY47vgjqD9xfhEmu6q1WFH4rhgHtT70O
	 /KN6Uy1Jv6zCVRJetO4SkEdZXvRWBb4k7l+AR/zLmeiCHQsfg+hngIE8LNGZP0n80
	 YVwomCU2j4+/nAaSWoJvQT8pWVgcmPfKiHeNaFKNDwPu4Z5q/uvkOfcOE9iXgIqLM
	 qS0cNswhFI3l/Q9ngc+9slXHqjomcmEdsYpl4wBnvYQcfE6D47xrtzroj08p7Q0jZ
	 1MWQmhBGhnkPq7jPoLH3xpuTi/FXxy66YsRWYVxcpGXciBQTTS1/Gr2ITXUUudJpJ
	 SdFAqJHUQhFDmMmD9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsZ3-1tRkfD170h-007TMu; Wed, 04
 Dec 2024 07:13:40 +0100
Message-ID: <e299045e-34a9-4f09-ba86-49134293af61@gmx.com>
Date: Wed, 4 Dec 2024 16:43:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fix a few zoned append issues v2 (now with Ccs)
To: Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org
References: <20241104062647.91160-1-hch@lst.de> <20241108144857.GA8543@lst.de>
 <20241203170120.GE31418@twin.jikos.cz> <20241204001718.GA22411@lst.de>
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
In-Reply-To: <20241204001718.GA22411@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EejO+n5DQ44tR1jajDbozWvo7584/d7UUHsgMTx3MiRt1okUNG2
 3wjnW5A+VeyhjD5pa8K16hx9DYjz16gEF5qPAYbmqPrixo2OsfH33dVzLxnGZVnu/6RcXKc
 J19xQT1UitbSOPSsMFoor1VFf/5BKNTLyEjg5Bm+OUG1XHa0VQoKlTwCJQu0ud5wvqETMtY
 ibjVNoHxfWNlOyg+9jVxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+L1n8U/Vz9M=;xhwRtnGzpSNnVd12WBv2YzCdnP8
 l+qDKEvQug2rfIFuP1Q0RB0txM7ap/R7DqMUMXgHrYmoJ9Bug1SITRoA8AQf4K69VxWrVPCD+
 WDDxWIfzFsM+7tH3LDz9we/djLmNKJ+t7aILxll3E00JKlfaPRVvC5SxrFspnw9pnUCN7DSdx
 7jFXTCFV/L1ZjJmJ/HA8vbPltSb7s/clOIpZJ/eppIaKhQzRkHNq/KwOk8Ymdv+9TI7uZP8/x
 lfXQnanBMPTVm+wbTlBtnFy4X6zeE0b+Aqk+GiMsa9lD9BWgkMP1fh57WRx3WaMqCfna4ekwm
 FsWXmth879K1cyXXeflQ0Ota/oOolTX7pAsoTc1hrpvQw85R8WxSvBH4YDoLhYZxlo/8XHxBE
 DTZ49BzN9eCXSfMGWpug8WAhffw8SKGFVtO7hcMXblVuhuK72v7EH8pKXRt7MOCarf+PwFs5E
 vSPjS/yGOYOJOTqcj4bsFIk/LjdMhEUvndtk+bew7W6bbk/Nb0DW0q4uR5unUhkULTVXyRIcl
 xAME5D+A+b1SkuZ5lwywEmho9b6JDtYfe/ERJpby9AyVcWoVmXEpDpaQ0B0SiM+KMC8jy0khw
 pJdAzQKaCHHNDaCB9lnr39pqP3SUIKKFVUzqa9ijX0+n6E0n0hbfsGJtN0iaq+T5QsvlX/AyV
 arTcSuinHdZPq2OcyX6jRpCZdlFGoOZ4ihyoRgD/8RkxvQFAyJ1EM+xdYAuoZfW6+hgGWcJUJ
 ZPsct3ssRQ+rJFFZj4YXGB4SF3LhWms+mB0AWZaRzFllKvt4xWWwTcE3goRfIObB2LCDIzL/1
 xhk/EtShAj41Wi5BeWv+2u44sDQ61zLq2kPmeGUkIRNnnsn49HmLlYbyMQBqeXLCppDRLRNR0
 10tHeQ2KhMEJsSKw9qF6Yjrnnc13cypMhPs45IWEYo8Oh2FYk68/8UunA2xGrYZ802t7tvsmk
 a96CQT1B7w9MEg2a/RRx5nLMbAPSJlgXZW84BtW9tTrm5kBo6h3SxT4Wsltxly98CUIzFHExS
 /sl1ZbxvTNTxWIWeiGAw50uxXgy2wwslf8ACbSQCVs82EX0LYFMlUWWiZBCbNyfzGnzYkdnrL
 nurOU/wuQNPs+NY0wRhMYCZ669wpsA



=E5=9C=A8 2024/12/4 10:47, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Dec 03, 2024 at 06:01:20PM +0100, David Sterba wrote:
>> On Fri, Nov 08, 2024 at 03:48:57PM +0100, Christoph Hellwig wrote:
>>> On Mon, Nov 04, 2024 at 07:26:28AM +0100, Christoph Hellwig wrote:
>>>> Hi Jens, hi Damien, hi btrfs maintainers,
>>>
>>> How should we proceed with this?  Should Jens just pick up the block
>>> bits and the btrfs maintainers pick up the btrfs once they are
>>> ready and the block bits made it upstream?
>>
>> The block layer patches are now in master, I'm adding the remaining
>> patches to btrfs for-next.
>
> Thanks.  I wanted to resend them, but my baseline testing still showed
> crashes in generic/475 so I was looking into an expunge config to
> check if there are no regressions first (there really shouldn't, but
> I wanted to double check).
>

Talking about generic/475 crash, it looks like there is something wrong
inside btrfs' space reservation code, which causes run_delalloc_range()
to fail with ENOSPC (which should not happen).

If my memory works correctly, at least 3 release ago we didn't hit such
ENOSPC during run_delalloc_range().


I'm working on fixing the involved error handling, there are some
patches to reduce involved crashes:

For ordered extent double freeing:
https://lore.kernel.org/linux-btrfs/cover.1732695237.git.wqu@suse.com/

For ENOSPC error handling in run_delalloc_range():
https://lore.kernel.org/linux-btrfs/0b4675971b718709497ca35c0d69e06db0c69d=
58.1732867087.git.wqu@suse.com/
https://lore.kernel.org/linux-btrfs/3e5d5665ef36ee43e310be321073210785b89a=
dc.1733273653.git.wqu@suse.com/

Which can help you to continue, but at least on my aarch64 VMs with 64K
page size and 4K block size, I can still hit random failures related to
unfinished iput or run-away locked pages.


Unfortunately I'm not educated enough to pin down the
run_delalloc_range() ENOSPC errors, but only use this chance to fix the
error handling...

Thanks,
Qu

