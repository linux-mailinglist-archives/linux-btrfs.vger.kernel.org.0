Return-Path: <linux-btrfs+bounces-12516-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3498A6E23A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 19:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC2C16B9DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 18:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50972641C8;
	Mon, 24 Mar 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="K1s7nFSA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470E2641F6
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840646; cv=none; b=NXVSaniMBaPkK1l1Xd3uekqedCiekYeNeQoqo33hWMLKG0EkwN4XqcE47OUAuu1wtTfifZyCoUMJ01WjBzYKedFNTv4+mHIucklWpPWDbaJGfIsqGJ0bgWujBC5mhkjiPGA7XT1mQ6aRYN7754jVN4xElt2ESvTH5nxobnCGB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840646; c=relaxed/simple;
	bh=4U0WQcrZi6HYfJ1j4+6EycXdAaOcov7zh2HYlp3xSxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SeKHH0ABmrZgLDFTBPFIC/DVxVe0cdzkguCqkseboaJYHm3aIaezViBLxMgDEzmevpCWkQSVweyICjj6LV0K1x41F4qLWp4GIS1lNayIC8faXCXgWh58+Cg/Tvog4igFFtz8jo2qwm4121oCjux9ZH8svwRxo0oIOreDefw2eaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=K1s7nFSA; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 8D1239F285;
	Mon, 24 Mar 2025 19:18:34 +0100 (CET)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 52OIITwk604678
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 24 Mar 2025 19:18:33 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 52OIITwk604678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1742840313;
	bh=8/OlFc+BYZIAJfGurJhaQFAzh3jO1tJm7x6HybTPiNM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=K1s7nFSArvokqfpRpuXbIyPxpemPt8D5AyrO5IcMIRnFrXW8/M5IsUPxnoAPoLKY9
	 TQqQlzBnMhew93v1fuaA5587BGNxA5s7l4vYuSxNo/y3wrd24MqZ+b3sx+hwZRTDAI
	 qNXEtstIPeJGo50icjYA/az0yM4cSVuhJbudtzkywOrtOj5ZLedUlK0fBUqL1Yr32F
	 MsGhKDuinK6Dlt8+mvmkT/iPdcx0bk1FicWUHNYcIAm1H3YdhdHeTU1ibKHdQyLrQc
	 FzPv4Pjv07X/jmVKBNWcQXJgHjCMYwp05gzCCudM5WdrSEbM+MQfsqL1Ec+tUwoCPl
	 D/JVQFVJS22FpBUCcML5C6uzNlPKzGGowRTg2nAorINej+KZyhsy97CZ1rnO1xQv06
	 Jig3qfR+UVe1VDgJPT0SRmuinaf9Odo2JC7jqkhrzFermxAAW3nwcQ3F8KfDD6gHDb
	 cXz7cnSwV9WZ6ve6RVu5oPW2Ke2oqakZKe0efITL01Rrsml8GvPuBZgoYODv0GdmEl
	 yWoEVmht6RRYxSk47k8d61bncdv0ioTBrAbUxgTtON6m4X75XnnhJFYpPS5tColGaY
	 Zley0TuB29lbVuE/oAyshENNm2zwiXGa634wH4FxtkYfFOllsRq1bMB0IIcE9zWWaQ
	 A1rTP9fs/rLywUPscvjaVSmI=
Message-ID: <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
Date: Mon, 24 Mar 2025 19:18:29 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
Content-Language: en-US
To: Dimitrios Apostolou <jimis@gmx.net>, linux-btrfs@vger.kernel.org
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
 <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Dimitris,

It's a known bug I also ran into, see the disucssion here:
https://lore.kernel.org/all/b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com/T/
(It can't be easily fixed)

There is also another issue with BTRFS:
https://lore.kernel.org/linux-bcachefs/kgdutihyy6durmrtqi5dfk7lhl2duzm4wnf6mlyneiuphf3cck@fxulfyg2ugjf/T/

I guess you always had the issue but you didn't notice it.

Therefore I moved to ZFS as a BTRFS replacement. PostgreSQL works also 
fine there.

Ciao,
Gerhard

On 24.03.2025 15:14, Dimitrios Apostolou wrote:
> I keep seeing the same odd behaviour. The database files are not being
> compressed despite having compress=zstd:3 in the mount options. When I
> issue a defragment -czstd command, everything gets compacted very well.
> And then as files are being modified by the database, uncompressed 
> extents
> start appearing again.
>
> This did not happen before. So has something changed between kernels 5.15
> and 6.11 regarding how btrfs detects if a file is compressible?
>
> How can I debug this further?
>
> Thanks,
> Dimitris
>
>
>
>
> On Wed, 19 Mar 2025, Dimitrios Apostolou wrote:
>
>> Hello list,
>>
>> has something changed lately in how btrfs discovers if a file is
>> compressible?
>>
>> I am moving a database (pgdump|pgrestore) from and to a compressed
>> (compress=zstd:3) filesystem.  And while on the old host (kernel 
>> 5.15) all
>> the database files were highly compressed with almost 8:1 ratio, 
>> while doing
>> pg_restore on the new host (kernel 6.11 with newly created btrfs 
>> filesystem)
>> I notice (using compsize) that most files are being written 
>> uncompressed.
>>
>> I have to issue a defragment -czstd command to fix the situation, and 
>> I'm
>> contemplating whether I should change the mount option to 
>> compress-force.
>>
>> Thanks in advance,
>> Dimitris
>>
>
>


