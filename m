Return-Path: <linux-btrfs+bounces-2250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4084E6D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 18:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B79CB2AC6E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 17:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387E47EF19;
	Thu,  8 Feb 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="QBKZUbe8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E2581AC7
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413468; cv=none; b=ptscK23PZgEQ6K02f9HuF0s+sKjKDQb0n9Nzy5PFGj8jh5owvFdgengcR6uMG9dps6aenSbpXbz7b9KP02p32Ze4PUMinARDVpxXJR7y76lzclTMsynVV+l457gqGx4gMWe9EgFxrYs9iDsVs4iB5bMivbrrisehHoOPWulLwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413468; c=relaxed/simple;
	bh=14BxfZb8bcKLJcYEraZ+U80MZAvsrudc1tzjFgw6/ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfkmJNudkBd94vmbND3k6zOIESdnoJ5tnF8vFDkhreZTiir/sIdXf9Dt7e1W+mDzU6Z39Vri0POv8KlIQ2F43lUp0Ro1bnyjPs6hM8wRcoYtdfkTaV/QRLeWd6+yeOSGVU67/hod+lUGJZdCc+txGbI6ZG38a3PD3M4UvEtOwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=QBKZUbe8; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id Y8CCrrVwPXMxBY8CCr8yZA; Thu, 08 Feb 2024 18:28:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1707413300; bh=ik8T2NxIpw0G+PlIXFFlablPLPmBltJOwxBRUqXZ9s4=;
	h=From;
	b=QBKZUbe8OWxZof4lZmb37Dv85Dt/L1zIdDGnVgbegfezeCJwzOPO4HC6YsK+3OEi0
	 ZKxmd0RewEC0OUcGehDZnHDv7f4nh+RE0EVgEuuFnT3PmtLEnKibeqr6QcB1wahWcD
	 X9wo2bqNWWPsf/OdQQyTSV/AX3tuQa/f/e4tWUaUmB25DbuRXKhRy37inZWvIyvSY9
	 Z39XqVrA+cclog628zMn41Zm+pgU+QOCM39cokexce4JNcSk8W7GGLU9AbDZVGK9qX
	 lOJ9xhJqPaKXb6OIYSgT54V0DQgl0hLItmWlrB0+vdSG+SIBf8h0KSp/sxBcmgP5Uj
	 6wBiKZGvTb0VQ==
X-CNFS-Analysis: v=2.4 cv=Svkz6+O0 c=1 sm=1 tr=0 ts=65c50f34 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=ArY7wTmoaSDSKBo3LvEA:9 a=QEXdDO2ut3YA:10
 a=8LfgHNaa6p4A:10
Message-ID: <d03d4140-4795-4fc5-8a8f-9510f3aa841f@inwind.it>
Date: Thu, 8 Feb 2024 18:28:20 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1702148009.git.kreijack@inwind.it>
 <20231214161749.GA9795@twin.jikos.cz>
 <6e4b2c09-b820-4ba8-8117-d13f3556e426@libero.it>
 <20240207101640.GV355@twin.jikos.cz>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <20240207101640.GV355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJr2gjPfvituHMNIFpjk0XtiUm6/L1pOY4sbadtQ6MFKdq1JyJ2Dnmoo5vZSRlBiZtB4NKPb4dAyUoIyfHu07kPFP3bSpdIwz7fglVuqXHYyc/mj6989
 sLhp9RLdqaDEy4UWoA8K37hAVQaatgk4Y+Uupr/miqiF8mkyvakMcbnHQOTWsU9vZGh4h9riMRWWo6e9q94Pgn+uR7riDpwvLj4tfVyTIZJmKQLfMPOkX1Xo

On 07/02/2024 11.16, David Sterba wrote:
> On Sat, Dec 30, 2023 at 12:20:54PM +0100, Goffredo Baroncelli wrote:
>> On 14/12/2023 17.17, David Sterba wrote:
>>> On Sat, Dec 09, 2023 at 07:53:20PM +0100, Goffredo Baroncelli wrote:
>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>
>>>> For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
>>>> directory returning the 'fd' and a 'dirstream' variable returned by
>>>> opendir(3).
>>>>
>>>> If the path is a file, the 'fd' is computed from open(2) and
>>>> dirstream is set to NULL.
>>>> If the path is a directory, first the directory is opened by opendir(3), then
>>>> the 'fd' is computed using dirfd(3).
>>>> However the 'dirstream' returned by opendir(3) is left open until 'fd'
>>>> is not needed anymore.
>>>>
>>>> In near every case the 'dirstream' variable is not used. Only 'fd' is
>>>> used.
>>>
>>> As I'm reading dirfd manual page, dirfd returns the internal file
>>> descriptor of the dirstream and it gets closed after call to closedir().
>>> This means if we pass a directory and want a file descriptor then its
>>> lifetime matches the correspoinding DIR.
>>>
>>>> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
>>>>
>>>> Aim of this patch set is to getrid of this complexity; when the path of
>>>> a directory is passed, the fd is get directly using open(path, O_RDONLY):
>>>> so we don't need to use readdir(3) and to maintain the not used variable
>>>> 'dirstream'.
>>>
>>> Does this work the same way as with the dirstream?
>>>
>>
>> Hi David, are you interested in this patch ? I think that it is a
>> great simplification.
> 
> Sorry, I got distracted by other things.
> 
> The patchset does not apply cleanly on 6.7 so I've used 6.6.3 as the
> base for testing. There's one failure in the cli tests, result can be
> seen here https://github.com/kdave/btrfs-progs/actions/runs/7813042695/job/21311365019
> 
> ====== RUN MUSTFAIL /home/runner/work/btrfs-progs/btrfs-progs/btrfs filesystem resize 1:-128M /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
> ERROR: not a btrfs filesystem: /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
> failed (expected): /home/runner/work/btrfs-progs/btrfs-progs/btrfs filesystem resize 1:-128M /home/runner/work/btrfs-progs/btrfs-progs/tests/test.img
> no expected error message in the output 2
> test failed for case 003-fi-resize-args
> 
> I think it's related to the changes to dirstream, however I can't
> reproduce it locally, only on the github actions CI.
> 
> Unlike other commands in the test, this one is called on an image and it
> must fail to prevent accidentaly resizing underlying filesystem.


I will rebase on 6.7 and I will try to reproduce the problem. Could you share the full script, or point me where is it ?

BR
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


