Return-Path: <linux-btrfs+bounces-11255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E946BA26732
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 23:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295581635A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944DC21128B;
	Mon,  3 Feb 2025 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lM1CIzuN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530781FECCA
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623468; cv=none; b=Ph/pvpdQBjuB0U5TrsP+4rZr8PeFLsHeAP6P8ERsfTPF32GuS1AhbrtyVo+eN1im8qG2/vd0022FnVvyxTRmM73/urBH6birHj8vZFUJcteC6R3GVzsOtiiFxVnouIP1+fyz1YpX4U4+LHDLs96+ZbDayxza4e2AV+t42MAHFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623468; c=relaxed/simple;
	bh=GaCJiv/ZJvlOI0Pf0WtH+nbPnrRHxxZziZH/cYzlcdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sL1gx97x6qWwoxTICzuDDJ3VIXk1jkLa1ARd34QWkiB4j6Jbnf26I/KVL+O6RZm3c7ZBidpBKnPbiv66QRR8QLSFNe/xSaiMEy9B8ZhRPSgv5da9sR/9CJdz/GlJ2MyVbTH45IXtMFPkNdlLc3R26B6rip73MRNBrW30b5cGHkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lM1CIzuN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738623452; x=1739228252; i=quwenruo.btrfs@gmx.com;
	bh=cR/TJzIrdPZ+XApEayK2aFnwCIoS4D9KcIody3rrG5M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lM1CIzuNmw/lHD59R9vAn959vbyRVH17cvOpjblF9UKwpka1S7iZGm2wuh4rH/KV
	 beg5XbWeCfwXUatZUc3gwoCTmhfhxRMjdZ2ko/W4IigxLPHZiJxhQOeinBuH2yi/3
	 bZ7XD2vIs5Om7EXe1UFWQnD7IQmAtyXumA7q+y41K7kDtzoXLiTOBcNTJDPqID0nS
	 Hpal6o/ExPgBB2WE8M61rYuyOMZ4JtPxQhyzyjAllPb7YgGCcTVjQEkjAGqY/XV3l
	 sUublEoIqlxlNKyBXqXBgJZB/j9lM3mcnlMSIulmRNqERVAg41mTAYzCcJvdej8/i
	 mnlBFLj7mT3bqToTVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1szAvd042T-00gewz; Mon, 03
 Feb 2025 23:57:32 +0100
Message-ID: <9c6b11f8-d33b-4766-b8bb-02f050f78d9a@gmx.com>
Date: Tue, 4 Feb 2025 09:27:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: always fallback to buffered IO if the inode
 requires checksum
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, "hch@infradead.org" <hch@infradead.org>
References: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
 <CAL3q7H7t=HcNeGdDuSYwGdD0oLTPMoFh6JT5o-UHv+nKkZ7SWA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7t=HcNeGdDuSYwGdD0oLTPMoFh6JT5o-UHv+nKkZ7SWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5kc6tTN/WO+4cbySyoxy08kSts5RdF99turQqMs39tbKglwES7h
 S6kyLLq0Nqsz76IysDzwBWSaT1HUwyDu3qu/9Y2jtMDbPTZh48z3nIY74F1dcnXJvDV5QJY
 EYsti9oFwG+YJB3BRBw0zdNl70qPy84sRtT2Wc3hDtB/PF1E5Gt+53JH0qYn2ZueezC+wYj
 6aOKHeItY5oCLdUVyG4bQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xFarS+oQelo=;LY4UTlh+Bp/jTCIMKAeM58XwM3h
 awQYMO4rFYeMEtGq1nwmB3RB2QUE7zMyw9n3tqMM3f9kBeOiCAVYLK0rqMlKv5NOQ5yw7/nKo
 i+fbbYjiGIIEig1QY5uHsNUbBpOjOJc3N07JLBM13+AT6BNTPgHumKxxdTj+SpgQ1EuXpCGB+
 q/KMJ4wzYqGa9uKd0CU6aUXmk1Fl+xAPBIb4d6AIfSWOwZgJ+/3aFgvwgYo96uASBFE2hQQfm
 bm8VR6m9WcDiPqpRMVR7TClxYwGNJEZQxjLpopa8Xbal+A7xmV0FlqAxZ5yKybMRlsIV9dj6q
 GLf5BszhD13ogl44yEDLIyAO9WS1xoeLz0HSSp4GkhINPobMKR6VV9AWgadAWcqgmDHiX399j
 yYf0Yn19zNU4jywnNTaqLaaj6B90g3MktrDh0usAijsv2JlsH+e5qzQ3i1y49jbIqJ/DlUGrw
 9kMxKPUinQ6Rrp4umAXWLlE9Qf1h1jxmm05eEQ5tiz4pbit1O3En28ftqghyDi9Njm5QfWbNo
 SwGYxa9wJqnu+mRGE9MdZsIzy0mzX4khCZpJSh9DZagA1e9scwydT6oVWnUKfgTxk4fE2Fyki
 YAVNC4tOGi5sLwZ+VvQ+i+gVo1hM86qKrjv0rGS/umIX5wxe3H3bQrVqdZytuWu8dgpply8rF
 g+L9Qg2wYMV468uPp1GIp3ZBu//ZMLtWkPYWG1zo2A1FoiYGc8eBkvh1I4LGdZUxjAaGxi4E+
 6086JfVHwfVie0EhFSUxZ1WiZO4VstHDzI18immbUZ/kAID7ACetdu17+44AMwsBlp5UkVEI/
 eg/vmXTmMdl16DN+LG0KP/qyJyQDggW62Eh2M38Hv6NwLThIkZkc2Jhs3e6+lwx4qyLCptALN
 RqvIARJ4CL/aIRXKiPJOE4PZUjElJ1UkjOX8ZAUUzESeYh3AE68CgJhVGJQuFhpCqrcCPRU7t
 knC/SuHV0sQ+o6cOboAneslT076yc2EhQHujpcR3QOCWuErcUMUmRr6pQWABLJotY1n4+mpWY
 BHbrwWCuOVvySyTj+Czaa6isjeq9up9muEc4nnpGSTFuXVIzwCv9Fd8mD0hY9HULnV5cn4ALk
 nxsSmMTLwltOFPdh0FjvWC7On8OH2q90nKtdK1lkVacTquamzQBnWb4oTeMUmE2U5szCnVbky
 zW/rvKC/GRZVELUuX5OpDtIbIfXgSYJlf7emdIBEe42sWyvQ3R5yTmN4pjk7x+xags0iMDco+
 uyGyysFa12WtjMYdGrOdl1YiZ6UNHr57k3BjQkOAp1XOdm5+5O5S9K0McOzDrckpnExacsMo5
 nv8tLsUqTBrMLhJWsQM+KbFfA==



=E5=9C=A8 2025/2/3 21:34, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Feb 3, 2025 at 9:28=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BUG]
>> It is a long known bug that VM image on btrfs can lead to data csum
>> mismatch, if the qemu is using direct-io for the image (this is commonl=
y
>> known as cache mode none).
>>
>> [CAUSE]
>> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
>> fs is allowed to dirty/modify the folio even the folio is under
>> writeback (as long as the address space doesn't have AS_STABLE_WRITES
>> flag inherited from the block device).
>>
>> This is a valid optimization to improve the concurrency, and since thes=
e
>> filesystems have no extra checksum on data, the content change is not a
>> problem at all.
>>
>> But the final write into the image file is handled by btrfs, which need
>> the content not to be modified during writeback, or the checksum will
>> not match the data (checksum is calculated before submitting the bio).
>>
>> So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
>> but btrfs requires no modification, this leads to the false csum
>> mismatch.
>>
>> This is only a controlled example, there are even cases where
>> multi-thread programs can submit a direct IO write, then another thread
>> modifies the direct IO buffer for whatever reason.
>>
>> For such cases, btrfs has no sane way to detect such cases and leads to
>> false data csum mismatch.
>>
>> [FIX]
>> I have considered the following ideas to solve the problem:
>>
>> - Make direct IO to always skip data checksum
>>    This not only requires a new incompatible flag, as it breaks the
>>    current per-inode NODATASUM flag.
>>    But also requires extra handling for no csum found cases.
>>
>>    And this also reduces our checksum protection.
>>
>> - Let hardware to handle all the checksum
>>    AKA, just nodatasum mount option.
>>    That requires trust for hardware (which is not that trustful in a lo=
t
>>    of cases), and it's not generic at all.
>>
>> - Always fallback to buffered IO if the inode requires checksum
>>    This is suggested by Christoph, and is the solution utilized by this
>>    patch.
>>
>>    The cost is obvious, the extra buffer copying into page cache, thus =
it
>>    reduce the performance.
>>    But at least it's still user configurable, if the end user still wan=
ts
>>    the zero-copy performance, just set NODATASUM flag for the inode
>>    (which is a common practice for VM images on btrfs).
>>
>>    Since we can not trust user space programs to keep the buffer
>>    consistent during direct IO, we have no choice but always falling
>>    back to buffered IO.
>>    At least by this, we avoid the more deadly false data checksum
>>    mismatch error.
>>
>> Suggested-by: hch@infradead.org <hch@infradead.org>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/direct-io.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>> index c99ceabcd792..d64cda76cc92 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>> @@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode *ino=
de, loff_t start,
>>                          goto err;
>>          }
>>
>> +       /*
>> +        * For direct IO, we have no control on the folio passed in, th=
us the content
>
> folio -> folios
>
>> +        * can change halfway after we calculated the data checksum.
>> +        *
>> +        * To be extra safe and avoid false data checksum mismatch, if =
the inode still
>> +        * requires data checksum, we just fall back to buffered IO by =
returning
>> +        * -ENOTBLK, and iomap will do the fallback.
>> +        */
>> +       if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
>> +               ret =3D -ENOTBLK;
>> +               goto err;
>> +       }
>
> Why do it here?
>
> We can do it higher in the call stack at btrfs_direct_write() after
> locking the inode, right before or after calling check_direct_IO().
> It's far more straightforward.


Thanks a lot for this!

It's indeed way better, will go that direction in the next update.

Thanks,
Qu

>
> Thanks.
>
>> +
>>          /*
>>           * If this errors out it's because we couldn't invalidate page=
cache for
>>           * this range and we need to fallback to buffered IO, or we ar=
e doing a
>> --
>> 2.48.1
>>
>>
>


