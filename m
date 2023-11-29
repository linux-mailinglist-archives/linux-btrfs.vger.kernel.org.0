Return-Path: <linux-btrfs+bounces-436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2647FD746
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 13:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DAF28319C
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1941DFE1;
	Wed, 29 Nov 2023 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="Bv9W7brZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626FBA
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Nov 2023 04:58:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 3E97D46CC5;
	Wed, 29 Nov 2023 12:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1701262722; bh=dvn/AHV4uV8LPPwOHZFferkVUsOTGQDImvgHa8sr44U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bv9W7brZR73xkZYE4DRHPPgyh5FxeTnhqnjT79A/q6vCY86PdZVwRa/Cofs72HEIw
	 UMcrJyT3VPVJtTUFjJGUtMo1jMGqU6b9Aq6fwa0NzAaznqxCzybW4yCv0+BpXJ0hal
	 0woYoCWApzvo5uMfy6rVfq7wyTEOifxxCRyyuD2woV5L4C7siYRvqDysxYkKbSPKKM
	 J0EXjuGvUjCVEeEQsucTDt7JS/SM6miw11zdg4Ntjm9uAcOFsqqajjvGoSJ/2aTYsi
	 XizWw+HNjANV8AjWTor3iFID1Ohiul+DDU5AvPcszk042hLI5nudWE+UBt+rkpIn1j
	 QUsCaW9Q+ZqQA==
Message-ID: <aaee6d4f-4e89-4bc7-8a7e-03ffc8b81a34@marcan.st>
Date: Wed, 29 Nov 2023 21:58:35 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
Content-Language: en-US
To: Neal Gompa <neal@gompa.dev>, Qu Wenruo <wqu@suse.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
 Linux BTRFS Development <linux-btrfs@vger.kernel.org>,
 Anand Jain <anand.jain@oracle.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 David Sterba <dsterba@suse.cz>, Sven Peter <sven@svenpeter.dev>,
 Davide Cavalca <davide@cavalca.name>, Jens Axboe <axboe@fb.com>,
 Asahi Lina <lina@asahilina.net>, Asahi Linux <asahi@lists.linux.dev>
References: <20231116160235.2708131-1-neal@gompa.dev>
 <20231127160705.GC2366036@perftesting>
 <fb78d997-cb99-4b98-8042-bdcdbff22b88@marcan.st>
 <f229058e-4f5d-4bd0-9016-41b133688443@suse.com>
 <CAEg-Je8r0K0k8UMcAafxXyrNuxJrxJbGhkwvo10pUw+rxhCa8g@mail.gmail.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <CAEg-Je8r0K0k8UMcAafxXyrNuxJrxJbGhkwvo10pUw+rxhCa8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/11/29 6:24, Neal Gompa wrote:
> On Tue, Nov 28, 2023 at 2:57 PM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2023/11/29 01:31, Hector Martin wrote:
>>>
>>>
>>> On 2023/11/28 1:07, Josef Bacik wrote:
>>>> On Thu, Nov 16, 2023 at 11:02:23AM -0500, Neal Gompa wrote:
>>>>> The Fedora Asahi SIG[0] is working on bringing up support for
>>>>> Apple Silicon Macintosh computers through the Fedora Asahi Remix[1].
>>>>>
>>>>> Apple Silicon Macs are unusual in that they currently require 16k
>>>>> page sizes, which means that the current default for mkfs.btrfs(8)
>>>>> makes a filesystem that is unreadable on x86 PCs and most other ARM
>>>>> PCs.
>>>>>
>>>>> This is now even more of a problem within Apple Silicon Macs as it is now
>>>>> possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix machines to
>>>>> enable performant x86 emulation[2] and the host storage needs to be compatible
>>>>> for both environments.
>>>>>
>>>>> Thus, I'd like to see us finally make the switchover to 4k sectorsize
>>>>> for new filesystems by default, regardless of page size.
>>>>>
>>>>> The initial test run by Hector Martin[3] at request of Qu Wenruo
>>>>> looked promising[4], and we've been running with this behavior on
>>>>> Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.
>>>>>
>>>>
>>>> This is a good change and well documented.  This isn't being ignored, it's just
>>>> a policy change that we have to be conservative about considering.  We only in
>>>> the last 3 months have added a Apple Silicon machine to our testing
>>>> infrastructure (running Fedora Asahi fwiw) to make sure we're getting consistent
>>>> subpage-blocksize testing.  Generally speaking it's been fine, we've fixed a few
>>>> things and haven't broken anything, but it's still comes with some risks when
>>>> compared to the default of using the pagesize.
>>>>
>>>> We will continue to discuss this amongst ourselves and figure out what we think
>>>> would be a reasonable timeframe to make this switch and let you know what we're
>>>> thinking ASAP.  Thanks,
>>>
>>> Reminder that the Raspberry Pi 5 is also shipping with 16K pages by
>>> default now. The clock is ticking for an ever-growing stream of people
>>> upset that they can't mount/data-rescue/etc their rPi5 NAS disks from an
>>> x86 machine ;)
>>
>> As long as they are using 5.15+ kernel, they should be able to mount and
>> use their RPI NAS with disks from x86 machines.
>>
>> The change is only for the default mkfs options.
>>
> 
> Right, and the thing is, it's fairly common for the disks to be
> formatted from a Raspberry Pi. So until some kind of support for using
> any sector size on any architecture regardless of page size lands,
> this is going to be a big problem.
> 

Yup, I meant what I said.

Someone sets up a rPi5 as a NAS, formats the disk from it, as you would
normally when setting up such a thing from scratch. Later, the rPi stops
working, as rPis often do. This person's data is now *completely
inaccessible* until they find another Raspberry Pi 5 or an Apple Silicon
laptop.

This is going to be *common*. And since the 16K decision is made at
format time, these people are going to be oblivious until they find
themselves with an urgent need to acquire a Raspberry Pi 5 to access
their data at all, and then they're going to be mad. So the longer you
wait to flip the switch, the more people unaware of their own data's
fragile accessibility condition you will build up, and the more upset
people you're going to have even long after the change was finally made.

- Hector

