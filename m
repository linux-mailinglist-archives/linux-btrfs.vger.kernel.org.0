Return-Path: <linux-btrfs+bounces-265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 561607F35A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833C11C218AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C262522091;
	Tue, 21 Nov 2023 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="YaO/PgXZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1827E8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 10:07:54 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id 5VA7rvLp2GKAA5VA7rmGfW; Tue, 21 Nov 2023 19:07:51 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1700590071; bh=2CfZiwKaybc50daKHj2H5auIOPlzj0DpmsExGgxqSgI=;
	h=From;
	b=YaO/PgXZWYajvriV5G/Ei3LjZHu432nzGNSRTanD6KrfWUJXQMbEtlJmEc5ySdp/l
	 dxejXsso/AXQIhQrTRooDYMJncdZKPnX1RaTnSMnZo39jZdiI6aAUuANZmGH+3qOul
	 rK59u26KaHLLSjYRff7ZdD0tSPVFmogImZMiVts0FCid6FnJlDphJkBFZ92WZl4xnm
	 qpJTIL1s/6M3b5wPqKiwBq4ki6FPwb83pKJBPTTVwnep6oZxI3Vyz+2IQillCLFDqO
	 xdTdPwUO7ckMYCjz5Dxb9IRB8zDVbx9afWb8GLP2sH/Vh3epRaTulau6GqMLcY9I64
	 tkYE70EYqxoVA==
X-CNFS-Analysis: v=2.4 cv=OoOJiQzt c=1 sm=1 tr=0 ts=655cf1f7 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=-9r30K9fzy0O6aBDl1sA:9 a=QEXdDO2ut3YA:10
Message-ID: <f67fb002-ce34-4f02-b441-3f41ea53a66e@inwind.it>
Date: Tue, 21 Nov 2023 19:07:51 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: checksum errors but files are readable and no disk errors
To: Phillip Susi <phill@thesusis.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Johannes Hirte <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <87ttpgz3qp.fsf@vps.thesusis.net>
 <a288c71f-9e42-4448-9089-fc0e3dfa8abb@libero.it>
 <87bkbn1678.fsf@vps.thesusis.net>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <87bkbn1678.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDp1d81vMkayUpJ7X7ord1iobbtDaUSHMIjLddnch159Bw0DX8g3I/R7vhGhj2Bz92IjcLB5JpmVsBNixh1s/Pvv+3PwWiFAz/qxlUAeGSjxF+AFV8+M
 YqfvHg6RjSKXiRp68NYzMIaDJRn2WhH1aTKCi+dj97bSq/tBkfdkSqo26MPa5b8P4d9fO5XOtB2OKyQDl/DGiIvfeEC3EMq1210pPDuQ1b58OcIjiqrG9P3D
 r4ubgnSZOPgdO0LPqaddQc/9uXb6jP26raN6hhkFEWUSKEMKI5OrGPdQ4fKxWuNt2PEbgmqkkwfNAgJpaPNFLg==

On 21/11/2023 16.23, Phillip Susi wrote:
> Goffredo Baroncelli <kreijack@libero.it> writes:
> 
>> Could you elaborate why is it "NOT ALLOWED" ?
>>
>> My understanding is that when the write are not sync (i.e. the program
>> doesn't wait until the data are on the platter and the metadata are
>> sync-ed), there is a race between the kernel that write the data
>> and the user program that may modify the data. And it is possible that the
>> data are a mix of the old and the new.
> 
> Right.  That's *one* problem.
> 
>> Now the problem here is *not* that the data are a mix between the old
>> and new (if you want O_DIRECT, this is a price to pay); this is an
>> un-avoidable cost of updating the data before checking that these
>> are on the disk without using a intermediate buffer.
>>
>> The problem is that the csum are not aligned with the data.
>> This is a specific issue of BTRFS [1], only because the other fs don't
>> have the data checksummed.
> 
> The *reason* the csum is not aligned with the data is because one or
> both copies of the data are an indeterminite mix of the old and new.
> You still end up with indeterminite/corrupt data either way, you just
> don't get told this is the case without csum.  In other words, the bug
> is in the application that is causing the corruption, not in btrfs for
> reporting it.

I am not sure that the application should be called "bugged". The semantic
of the iodirect is something like: the kernel does nothing more than passing
the data to the disk. If the application want to bypass the buffer/cache
page, has to be taken the responsibility to coordinate with the rest of the
subsystem.

And to be honest, if I use a write(2) syscall, I can imagine a sequence of
writes; but using mmap(2) it is difficult to see a sequence of writes
when the user write randomically the memory; so
having an intermix of data after or data before is not strange for me.

My feeling is that it is a BTRFS responsibility to guarantee the checksum
for whichever use of the kernel syscall. If BTRFS is not capable, it should
disallow the use of the CHECKSUM and the DIRECTIO at the same time.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


