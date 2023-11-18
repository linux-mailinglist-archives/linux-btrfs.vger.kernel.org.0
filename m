Return-Path: <linux-btrfs+bounces-182-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E03037F0154
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8923B1F22CAF
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8519BB4;
	Sat, 18 Nov 2023 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="BDizo5ip"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7512B
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Nov 2023 09:37:45 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id 4PGIrW0VKGKAA4PGJrYQQ1; Sat, 18 Nov 2023 18:37:43 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1700329063; bh=7cNHLX2ctIC1eGxo5wFlFE6XPAWSg6xJHx1guGloBJo=;
	h=From;
	b=BDizo5ipOvCGWRNqY4W+rCioCQH1JGNyxH6IW/9Sxn+OO1rLSfsmugD0JkLmV6I/S
	 LY1RvyTMjA5YvYjwE06+Ko+INpWrr0JG/Kmt+ZKggLzXBe0Dp2pwlhFkioIf4IrnTw
	 4oFPtfJgDLEo8LOlRZ/vk9tPv7mxq1xYm7o63E4LDJe42R2Om+2Fyhk6PBazhaHT7n
	 lLttpNMbPsnnzqEtjiT+O2KUwuvSBtJp1HkoDUagsnyQfSUn0r2VklVKMJ0uZ+jDfX
	 HrGx26Mpm2wcsHKz2AJdkyaHoKZfQbprORvYkUXv7ULAAVxgs9ZO+XgiEQenK97I0E
	 axhtKl7sGVpDA==
X-CNFS-Analysis: v=2.4 cv=OoOJiQzt c=1 sm=1 tr=0 ts=6558f667 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=4jqkTvAoAAAA:8 a=_QNhIW5Djb-r_eV3oGYA:9 a=QEXdDO2ut3YA:10
 a=Hh_HAVYRK2TLt7S9I1XE:22
Message-ID: <4820ef14-f09c-47b5-8d91-7489a93bb041@inwind.it>
Date: Sat, 18 Nov 2023 18:37:42 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: checksum errors but files are readable and no disk errors
To: remi@georgianit.com, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
 <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
 <59b6ad3e-c16e-4a29-abd4-4d6f57047155@libero.it>
 <65b3acc5-0aff-a7e8-142b-4ad40c60f3dd@georgianit.com>
 <4bf1d0d4-6fc3-434f-8166-7a628d48d52f@libero.it>
 <9f955c4a-82be-98cc-6f61-ee5469c32ba2@georgianit.com>
 <cecd43db-da2c-4558-b343-4faabacdf0d8@inwind.it>
 <CA+H1V9xqZT7L0tj3JTyJscXLKw-tpSE0qNULbg4hn0wYq4fhxw@mail.gmail.com>
 <CA+H1V9xA8_3-BYkhR2ip0v1_-bKxWY1hHW1kRwoxhaCNu88PYQ@mail.gmail.com>
 <95096727-a472-4c0b-a16d-de53b0f66ff6@libero.it>
 <60fb34fb-ebfe-408b-b787-c62c6a1b5cd9@app.fastmail.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <60fb34fb-ebfe-408b-b787-c62c6a1b5cd9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfPjnplpyINfj3bZB0fquSqK14oWKSVuS0V8DTnSTZBrF6cDGdaEaGoqxFcxJsDTSgXGPyALQAv9dWifVVEdQulZrULPlFDUunC61xhUhTFANKXxzEyqg
 Q+slBot9cR4EF0GdKYvh1JDUJjBHAZ+IjUBHzv+tq42nXzn9CwPQPuD+zwbHXQ5+ZGc66vhyahipovsFhS2tJXszHqJVKbA8WJ84eE5rR3NbtAUnOM4r+PCP

On 18/11/2023 17.33, remi@georgianit.com wrote:
> 
> 
> On Sat, Nov 18, 2023, at 3:22 AM, Goffredo Baroncelli wrote:
> 
>>
>> dm-integrity+dm-raid is not different from the default BTRFS config
>> (COW+CSUM). The point is how bad it performs.
>>
>> It is not a binary evaluation, it is a trade off between reliability
>> and performance.
> 
> But this thread wasn't about performance.  It was about BTRFS CSUM being in such bad state, turning it off (at least for some files) is the only suggestion for preventing spurious errors.

There are several topics touched in this thread.
Regarding the unclean shutdown it is valid the table above.

Regarding the directio and btrfs, from a pure technical point it
is near impossible to have a reliable checksum without
buffering of the data, thus invalidating the directio concept.

The problem of the directio and checksum is that the program
is in the position to change the data during the checksum
computing. This invalidating the checksum.

ZFS, until the last version, lied about the directio: he
allowed an open(O_DIRECT), but in fact it buffered the
data.

dm-integrity has a journal, so my assumption is that it
journals the data before writing on the platter.

BTRFS instead *tries* to satisfy the O_DIRECT requirements but
it is not able to guarantee the checksum reliability.

IMHO O_DIRECT should be allowed only for NOCSUM files. I
wrote a POC few years ago about that.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


