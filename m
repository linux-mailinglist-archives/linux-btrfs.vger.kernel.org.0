Return-Path: <linux-btrfs+bounces-7197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5639952318
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 22:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E75D1F224F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9F71BF32B;
	Wed, 14 Aug 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="HlUIaKCP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC320B0F
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666375; cv=none; b=H3edE1hgwaNT8VsXGbEAp9c5+/YdhoNfW2Teei5SiN1Qi8EnGLpfk422ApmMJ2f33+qy5SxCnrA+sVypVwmoJ6cr5SJjfvpQZu9SFzmYvY/k8ks4PwMOsxrhgwtJg7WeRFiu/6GSuIXwYatFVfSIN+Hs/9iaZQS4jkCeDAp/K4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666375; c=relaxed/simple;
	bh=9oWs7Kpr7BiJmILc2SL7UglF0y6yCBmyc7rapClD93w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u8iBdjUs9VxTOgNwRysMbhKCRyhtZz+hcmFYezMl7Wo0rIK5bMWHSHA9NkP0MKUIh97oxBcqI7N0cimd3ookh1OxAISc1+FiKClOoherz/KGxhI0Q1x8MpvwRHEuipacYHnY7zSwJSciwAgFPyGEksKPAW16OUDczTDe8ihH5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=HlUIaKCP; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8KkC/2BZ7RGUApBWkyjQAuiGk/q1i/ZG395N4Xc+qJk=; b=HlUIaKCP01+djQmKQZACTkoUC5
	2BIE2+ToLtlVcTSoTzL5yJy+HQe+UQqFvw4ZfUlO81wcVzwOU5rJPQjKk3KoW+J5YH3joz4OOU/f4
	ROd3Q/nXD+zVEabIAjHd7G62UH+gIw1CznZ31WzWyHvTfbcnFMMktwmHJqaio39Fo/bJAEgjcSLRn
	3KlqsHvmeRoNsICTM4SWgfONvQ/ueuazZRkInVp/pagDgDi0Ju3cWjh2TiIOpY6ABjqLw1m3ZStip
	uPUk+I3/qsDX9K6Vgl7mRstm4NugkMjhYzODYNeXMQ0PZzpowhuyFyjSRVEUVWvJMiN7TWAU4US6t
	CYi2gfKg==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1seKMV-0003dz-FW
	for linux-btrfs@vger.kernel.org; Wed, 14 Aug 2024 20:12:52 +0000
Message-ID: <42fbd952-8d6a-4b24-a92d-1d1832d0c891@zetafleet.com>
Date: Wed, 14 Aug 2024 15:12:50 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recovering data after kernel panic: bad tree block start
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PR1P264MB22322AEB8C4FD991C5C077A3A7B92@PR1P264MB2232.FRAP264.PROD.OUTLOOK.COM>
 <d76a88d8-4262-4db4-88fd-d230139a98e0@gmx.com>
 <d4776023-178b-4e30-bba8-9a5930fdd48d@ensta-paris.fr>
 <966421a1-9b6a-4a35-9e96-b0e1a4e0cce9@suse.com>
 <d5152a0e-b430-4dc8-b7e7-e131265000b3@ensta-paris.fr>
 <16141995-25ee-4ba7-a731-5e1a16b4655c@gmx.com>
 <e42a03e0-df4f-45f8-a61e-3b44fcd387e3@zetafleet.com>
 <3161f529-c9c1-4f98-8ee1-9e97cdff473d@gmx.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <3161f529-c9c1-4f98-8ee1-9e97cdff473d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001,T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no version=3.4.2

On 10/08/2024 18:36, Qu Wenruo wrote:
>
>
> 在 2024/8/10 02:44, Colin S 写道:
>> On 09/08/2024 00:17, Qu Wenruo wrote:
>>
>>> Another possibility is, some NVME firmware has automatic dedup, thus 
>>> the
>>> DUP profile makes no different than single.
>>
>> If this is a known behaviour of some firmware, is it possible/do
>> benefits outweigh risks to store DUP copies with a simple transformation
>> like fixed XOR to stop them from ever doing this?
>
> As long as the firmware is a blackbox, doing those workaround makes no
> sense.

OK, luckily(?? :-)) it is possible to substitute opaque SSD firmware for 
a different storage layer that is not a black box, like dm-vdo 
<https://docs.kernel.org/admin-guide/device-mapper/vdo-design.html>. Its 
design doc says that it creates deduplication window in block write 
order with default size 256GB, and that deduplication happens using 
block hash then byte-for-byte comparison. IIUC, btrfs metadata appears 
to fulfil conditions to be deduplicated by dm-vdo, as both copies are 
written within temporal window and would be byte-for-byte identical.

It seems to me like a reasonable inference that SSDs would use a similar 
enough strategy that defeating dm-vdo dedup would also defeat SSD dedup, 
and if there is a non-zero probability that filesystem loss could be due 
to storage layer dedup of “duplicate” metadata, maybe it does make sense 
after all to do something about it? Some xor approach seems nice mainly 
because it is fast and requires no knowledge of firmware dedup block 
size nor change to metadata structure, vs something like a copy counter 
field/bit that must be repeated frequently enough to stop byte-for-byte 
equality of blocks without actually knowing the internal dedup block size.

Anyway, this is no hill I am going to die on, just something to think 
about I guess, if you really do find it plausible that firmware is doing 
internal block dedup that undermines metadata dup. (QLC in particular 
has enough of a write endurance problem that I would absolutely believe 
it to be true, though I did not find manufacturer saying they do this 
explicitly, only research papers.)


>>
>>
>> On 09/08/2024 02:31, Qu Wenruo wrote:
>>
>>>> Is there any sort of worst-case scenario data recovery tools (maybe 
>>>> 3rd
>>>> party?) that does pattern-matching of the raw data or something? It's
>>>> not like I need to recover videos or something, it's only a few text
>>>> files with known names, locations and partially known content.
>>> Unfortunately no.
>>
>> testdisk/photorec/scalpel do pattern matching recovery. Is there some
>> special thing about the way btrfs stores data with single profile that
>> would make them worse for btrfs than other filesystem? I guess if
>> transparent compression is used then they will not see anything, but
>> anything else?
>
> AFAIK those repair tool needs at least some hint on the metadata, like
> where the file starts and ends, and filenames etc.
>
> Or it will just throw out tons of garbage and call it a day.

Yes, these are *really* worst-case tools but they work exactly how the 
OP requested, so it seems to me best not to deny they exist at all. The 
output is bad—just like file_NNN.ext—but possibly still less bad than 
having to rewrite an entire PhD thesis.

Cheers,

