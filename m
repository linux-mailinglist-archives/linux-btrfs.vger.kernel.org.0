Return-Path: <linux-btrfs+bounces-1108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4093C81BDE2
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7208F1C24760
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Dec 2023 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E264AA0;
	Thu, 21 Dec 2023 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="dSFhLApp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1C634F7
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Dec 2023 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id GNOGrS6TGOtSyGNOHrgcZp; Thu, 21 Dec 2023 19:03:25 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1703181805; bh=YdcopiTXZIOdlAe+OqmeFpwafkSn+pY5RilJNxQy7SY=;
	h=From;
	b=dSFhLAppgFPYRuQFkh2PRj1QZtIBcnYOWN2nN0YY9NShIuzMHvFHDzK6V6A47cSoZ
	 YFI70BpQ4im0iHzAsW6dzthfcm5TC0YLycz9zf/pq1EUXAImz6QRE/mTKK1yPZr/NQ
	 X9fREvNNGO9pdn16CUclHghrkGqMNIzWw9gziTwS03mS5/KatN3Ub9q76NvGkWR9ve
	 oR9KsgKu5yEak1HRv3nsoyQ6LqvZ3Ibu4BJEQ59ej/6crEjgIStRJ8FJgRaD3uUdtA
	 g1zjAxJOGsCOv9/OT2B1m0cqI4rpQ7CAsOXdmA3DHHQwhEPgn29rYk03zAjuu5+UJK
	 +31qywbwt3VBQ==
X-CNFS-Analysis: v=2.4 cv=Qf+g/OXv c=1 sm=1 tr=0 ts=65847ded cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=DZp_LHW8HzMn4gUu:21 a=IkcTkHD0fZMA:10 a=bAXG_n7RjdVqAOLFhd0A:9
 a=QEXdDO2ut3YA:10
Message-ID: <cb2d0cf1-8612-4c7b-8d29-d9efcb7888c4@inwind.it>
Date: Thu, 21 Dec 2023 19:03:24 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
To: Christoph Anton Mitterer <calestyo@scientia.org>,
 Andrei Borzenkov <arvidjaar@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
 <9bb4ead3-2e98-4d0f-a980-1d53847c8b99@inwind.it>
 <21d14fb83e170441f9640f98bae3ba8f0e48eaad.camel@scientia.org>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <21d14fb83e170441f9640f98bae3ba8f0e48eaad.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEeF/DXnedYEs6EVKjpCxDhwvLQcbXFl40oEVVIxmr+zr/sMglOGQazJBkYTPivsXwVYfS1g7nEc0tpmcB7rSg5lPfnF3ZxoiXmj/rZQeMt3wGShePaZ
 gDgpLS0pInfUWL3R2tCjk8rYsGvElfMFTNng3cX7jYINrZmsFG0HamTxzWUM3fsnHcpVt0fo791HWv2NF5FcAqZZ0HjBblz9M+09zZS6ttCshVofLR0TOPEU
 gT8owCT8NHhfQEc12liKuIDsvb54c38sBZPWtpJDNPXNIGe1PHBIxZjAp9h3YBj3

On 21/12/2023 14.53, Christoph Anton Mitterer wrote:
> Hey Goffredo.
> 
> On Tue, 2023-12-19 at 20:09 +0100, Goffredo Baroncelli wrote:
>> Ok, now we have the case study.
>> To be sure, could you try a defrag (+ sync) of this single file ?
> 
> # btrfs filesystem defragment /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
> # btrfs filesystem defragment -t 1000M /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
> # sync
> # btrfs filesystem sync /data/main/
> # compsize /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
> Processed 1 file, 1 regular extents (1 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%      256M         256M          15M
> none       100%      256M         256M          15M
> #
> 
> 
> 
>> The what is the lsof output ?
> 
> # lsof -- /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
> COMMAND       PID       USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
> prometheu 2327412 prometheus   12r   REG   0,43 15781418  642 /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
> #
> 
> I also stopped prometheus synced and checked then:
> # systemctl stop prometheus.service
> # lsof -- /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001

Here you should do a defrag, after the stop of prometheus.

> # btrfs filesystem sync /data/main/
> # compsize /data/main/prometheus/metrics2/01HHFEZPJ8TPFVYTXV11R7ZH4X/chunks/000001
> Processed 1 file, 1 regular extents (1 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%      256M         256M          15M
> none       100%      256M         256M          15M
> 
> 
>> Does anyone know a way to extract the "owners" of an extent ? I think
>> that
>> we should go through the backref, but I never did. I don't want to
>> re-invent the wheel, so I am asking if someone knows a tool that can
>> help to find the owners of a extent.
> 
> Not me ;-) ... Does it help if I'd provide something like dump-tree
> data?
> 
I am trying to write a tool that walks the backref to find the owners.
I hope for tomorrow to have a prototype to test.

> 
> The fs is soon to be full again, so I'll likely have to delete some of
> the (test) data...
> 
> 
> Thanks,
> Chris.

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


