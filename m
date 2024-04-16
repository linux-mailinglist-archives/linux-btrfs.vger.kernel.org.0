Return-Path: <linux-btrfs+bounces-4312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7EF8A6F87
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD15D1C20DFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA8130E46;
	Tue, 16 Apr 2024 15:17:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE6012A15A
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280673; cv=none; b=AHzSWGFKoQUW+z0wHNVN17VaLrKt9Pe6vlCguuL/xhnrpl9g9Y3355TZXV/OiC4PEQGL6UMVEmDNXmXTTg0ABbEli4thRp10t00bjuRU9/IQzbAIR8wQeiv74hHZC4sUmQsybMQxqWYuk8X//ASqlVgKpuHX5QgBGdkMDVH/AJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280673; c=relaxed/simple;
	bh=/6QvmHCny+Pn1mYZiKvfMiaFQomBQMo2nNwxeBashBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VfBvbPqu3MffC6plCTb22Ep8AMAtI0oq/IOQkSblutxCVC3QIpkXL8BzuCbycBm6Wsff8PY9UAZyNyBx0b9Kh85FEeE3DiXNNLrU3LC3utjCCP21rLltiQC3fPWPnG/+ODfAcXhoZ29rewfYYOr5SACGdG/84r/tiT6ce/1bHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 04C7DC08140;
	Tue, 16 Apr 2024 17:17:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IiulF9CTimtP; Tue, 16 Apr 2024 17:17:44 +0200 (CEST)
Received: from [192.168.1.195] (unknown [81.56.116.160])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 69BA5C08007;
	Tue, 16 Apr 2024 17:17:44 +0200 (CEST)
Message-ID: <b2806d95-a50c-41a2-b321-cf62c4f28966@dubiel.pl>
Date: Tue, 16 Apr 2024 17:17:41 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_enospc_errors_during_balance_=E2=80=94_how_to_preve?=
 =?UTF-8?Q?nt_out_of_space?=
To: HAN Yuwei <hrx@bupt.moe>, linux-btrfs@vger.kernel.org
References: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl>
 <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe>
Content-Language: pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



>>
>>
>> I noticed 1Mb for Unallocated space, so
>> I have run multiple times balance (data usage filter):
>>
>>          btrfs balance start -dusage=XX,limit=1 /
>>
>>
>> and it didn't help.
> You can try add a small device (USB stick) and rebalance.
>> It even got error no space when balancing:


When it refused to balance i tried musage, dusage, few times and it helped.
Thanks for tip.




> If you have zabbix or other monitoring mechanism, you can try 
> monitoring "Unallocated" and reserve at least 2 block group (2GiB). Or 
> you can have a weekly timer to rebalance your btrfs volume.
> kdave/btrfsmaintenance should helps you.

I started to run this script from cron every 10 minutes:


#!/usr/bin/bash

mount | sed -nr 's%^/dev/sd[a-z][0-9] on (/[/_[:alnum:]]+) type btrfs 
.*$%\1%; T; p' |
while read mnt; do
     if
         btrfs dev usage "$mnt" -g |
         perl -ne '/Unallocated: +([0-9]+\.[0-9]{2})GiB/ and $1 < 64 and 
print $1' |
         grep -q .
     then
         echo "porządkować $mnt"

         for usa in $(seq 0 10 100); do
             # I don't know whether to start with "dusage" or "musage", 
so i shuffle it;
             # 15 april 2024 my serwer was locked, "dusage" returned 
"enospace", and it
             # got unlocked after "musage=0"
             {
                 echo d $usa
                 echo m $usa
             } | shuf
         done |
         while read typ usa; do

             echo; echo; date; echo "balance type=$typ, usage=$usa"

             out="$(btrfs balance start -${typ}usage=$usa,limit=3 "$mnt" 
2>&1)"
             echo "$out"

             # if nothing was done, then try higher usage
             echo "$out" | grep -q "had to relocate 0 out of" && continue

             # otherwise finish: on error or on successful relocate
             break
         done
     fi
done







> "Unallocated" and reserve at least If you have zabbix or other 
> monitoring mechanism, you can try monitoring 2 block group (2GiB). Or 
> you can have a weekly timer to rebalance your btrfs volume.
> kdave/btrfsmaintenance should helps you. 

Thanks for hints :) :)

This solves my questions:

1. i have to rebalance when Unallocated is low

2. i have to keep 2Gb at least.





