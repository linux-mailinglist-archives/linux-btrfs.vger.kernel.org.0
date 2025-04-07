Return-Path: <linux-btrfs+bounces-12859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7651A7F004
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 23:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B93AACDD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 21:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEAA2206A2;
	Mon,  7 Apr 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="R26GpfY8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D7F2153EE
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063147; cv=none; b=U8H38jkB3fpXEMiPmXeEMtQF8ThszWN9W09jmXY1aWaBBsY6TIWqZJxo2w4TdVRfnjs3MqHBEnVbyPVO0GQWmsQ13XvJFcGOlU3WsEXvRFOYGcCa56TlTSYnc7+TVRovzF54isezTBYrooBlqza6s+XeftxA4N8EQMPPNGuc4Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063147; c=relaxed/simple;
	bh=jmLm8AN7+9P+3FiKygI9iHVVcJcqP1v8dXuPmyOjFDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fduGwnadF9edZGt5sojL+aJjjWBQSKB/8EtM8x9BzRLFJ/ITCnnL2XnzhipHLIPQDs6o55Yq6XUz8uoy2RyRk7D1F9R/ueTdkr/bD+92YiPjSMB4SvgI1fnswl3+3OoX1/RhGUHxF0ykp802/MFeuGfz8j7yyy5ykYUYL2qvRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=R26GpfY8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744063142; x=1744667942; i=quwenruo.btrfs@gmx.com;
	bh=vwSHQXGBhbbzK0kiUzcgRe2cvUbVPJSa7xkkzN9txlE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R26GpfY8rEfcEFGU/mTGPG1CAfJOT+rwE5Tu5mrPqbtShLRXil0ZcOtvcwL6HopQ
	 5pxbP3+hwMMNqy71V3+ozgd9tFzlg9LAAN5ZAjV04qRicF4f2wsUBjvIDhA/B67gS
	 OmQTo46eCClmHsGxad7ziRon+RF4DsxhwmeemLYq70dFblg8vexRmjRuS3P4lhyXD
	 wjJ5wl5uEdLPLFwqT15G2OxPEcRnQPJn4cLlE3SCKY2MhHs7tf02UZNu/A9y9cW6n
	 LJl2kb6Gl1fEX0gdzkFtKz/LCWoUo94KUCZYK3lb/vI1hQc3Fpjm7196+P/7yvt0D
	 BACchPdp0N0FA+SrbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJmF-1tGWeM3C6d-00pYjf; Mon, 07
 Apr 2025 23:59:02 +0200
Message-ID: <313da654-15aa-437a-847d-e125e83df977@gmx.com>
Date: Tue, 8 Apr 2025 07:28:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: use folio_contains() for EOF detection
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1743731232.git.wqu@suse.com>
 <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
 <20250407183912.GB32661@twin.jikos.cz>
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
In-Reply-To: <20250407183912.GB32661@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qf0ABG0kCR7OTfbGYx99jxqQC79lbQY5YqXsYBK+lIWHuEeIauY
 begk3Xqc0bTWagnYKlA/kMIaPCg5vT2Blkbxa6TG5Pp/3RVvHsNeI44n2HlEF/0/L27kkGM
 /UnxTEWiHKtmWV3KvIF2pS6VWysH7j2nHlYj4nuzkAqqWgELZ/vnxd/tsXN7cPCzpeoc6jp
 hWufpU3bgRdjbkTqOwGpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yQR0ZHVEDwo=;LsPDLf1eAPB6WVEcFDsNLs/bALY
 K95/S3k0cee8MPpSbRKOj+4UNksUGrCZWHKuwwwuo7G7ClpXI2wMPeNZ8oTBSDlM6qFIb/qB7
 HJJtplz68kIiXue+zDB0x8rrLTwmUtP1p4wivtfHx2mc68/Wyq4mWkYvFfMS0wT7hkz+O7jg8
 tnL2WzjIb10iiN10AFYndUrlmxkoVLQS+1gBZqcxzzlwcG8eK+nicSuYSEutg9DYTSUFbujs/
 Qh3Ycv2gYB44S9dX5DakmMMvZz4bQUyu/OfxPbac+TqeNAKOEtyZzTSkhHqNrIQbuYGTTVUxY
 Hokf32zRsRudVzU0TntAkjIBQCDYRx3euFa/it7cHULP8zBB4PfI3Dbox7DMXjvd6ogV21SRW
 xXfCQ/obCX1EvNbdAsrrQ1igKDUyqOtAhyyrean92VGKghVaqA04jHokKFp0KryrJW7T+zIKd
 MZb1fmWcV37yEult2KZ/YGwTQG1gB2LY8UANQWhLgtcGYpg668Bk/8XDrsrolxhgXZeR8uCzi
 OLXGgf79CsJLjfBoZN/nt/4MuJngBg9sPWIBblpYvCifJku/7aAEjUfFniY/f7Qdq1Hkj2pFv
 u11rGsjMcSmYGhOJaBfvI/Z4dCyrelnTO+wjaHKXqtnWNEFVQhHhkrNrkMWjLc+Owvx7LdciY
 DhUpSzJN2SCtzf3C/tSb+XB1Q3LB/XowG9kWrHhI/NrGvfIByzXL5Z+uB9T1ThdFG/QTVmzNI
 /3/hw3rsf50sREVHYSpCnFST9iJpQr+CyzpX4Jj+YC4Cu1v+PrQKdfr+M6TZwHEe5bUOVLlsS
 dBQ5vwJnHun6pEw0eI+5N4r9fqDJq/Obkeqvcol1L5ALXhj+Ak5CgG8fdGylM4nn2UdeeplKB
 h+diC2Q22SzX5/JBhudDppNn0Q7fFIXEeUqh9yLmISYCAalS+yHeEVV7FOtYm2W/pbPwhTX3S
 lJoyhcGyKl2xbbrpJjX0C+HR4JGGuevp6jEq78I2mk7E4nahacJVWIGP53woQfqOOmtwOsAcy
 gPlqkeZdIFk8/qyrNxjyAvsVjDYMXWe0y85qY3quDKXp1ZJ9d2YlqN086aLJPb8/0gCBywV4p
 9vQXtInAYaLdaJcw5jizvGxSoFnLh1g2CdiVB28yYeQIr8U5XBTljInHp7WfiBA5rxlLNCIBw
 yMGus+tmrL+bCszAZ6xXp5qgmraYsNAJ2Ih9fsu4yajuABm3ai9AME2egZwG8T4vuzIR5+Y6n
 gGcN2N81RGVtXM2kubFMFtfeIe/VGwJPfqd8M35kAL3qCIU1RdMdIzcZRdviY2+3yEmSo2gpi
 Uj0+0juDrqKTR7WEF250goqQUZFtteejjWa3lyXBwmHx4yS1EEnQ8JlUNpJwI+EqscUUU6bGT
 oJKHUe3Dt4I6HpJCSPpM0C0U5kTP8voWE78Fm0jg2ECNsLV2625BTXMGsnYpYFugsx7FGBPec
 OQct+hA==



=E5=9C=A8 2025/4/8 04:09, David Sterba =E5=86=99=E9=81=93:
> On Fri, Apr 04, 2025 at 12:17:41PM +1030, Qu Wenruo wrote:
>> Currently we use the following pattern to detect if the folio contains
>> the end of a file:
>>
>> 	if (folio->index =3D=3D end_index)
>> 		folio_zero_range();
>>
>> But that only works if the folio is page sized.
>>
>> For the following case, it will not work and leave the range beyond EOF
>> uninitialized:
>>
>>    The page size is 4K, and the fs block size is also 4K.
>>
>> 	16K        20K       24K
>>          |          |     |   |
>> 	                 |
>>                           EOF at 22K
>>
>> And we have a large folio sized 8K at file offset 16K.
>>
>> In that case, the old "folio->index =3D=3D end_index" will not work, th=
us
>> we the range [22K, 24K) will not be zeroed out.
>>
>> Fix the following call sites which use the above pattern:
>>
>> - add_ra_bio_pages()
>>
>> - extent_writepage()
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c | 2 +-
>>   fs/btrfs/extent_io.c   | 6 +++---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index cb954f9bc332..7aa63681f92a 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -523,7 +523,7 @@ static noinline int add_ra_bio_pages(struct inode *=
inode,
>>   		free_extent_map(em);
>>   		unlock_extent(tree, cur, page_end, NULL);
>>
>> -		if (folio->index =3D=3D end_index) {
>> +		if (folio_contains(folio, end_index)) {
>>   			size_t zero_offset =3D offset_in_folio(folio, isize);
>>
>>   			if (zero_offset) {
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 013268f70621..f0d51f6ed951 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -221,7 +221,7 @@ static void __process_folios_contig(struct address_=
space *mapping,
>>   }
>>
>>   static noinline void unlock_delalloc_folio(const struct inode *inode,
>> -					   const struct folio *locked_folio,
>> +					   struct folio *locked_folio,
>
> I'm not happy to see removing const from the parameters as it's quite
> tedious to find them. Here it's not necessary as it's still not changing
> the folio, only required because folio API is not const-clean,
> folio_contains() in particular.
>

Yes, I'm not happy with that either, and I'm planning to constify the
parameters for those helpers in a dedicated series.

Thanks,
Qu

