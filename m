Return-Path: <linux-btrfs+bounces-111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03C7EA50D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 21:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3168EB20A59
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C424A14;
	Mon, 13 Nov 2023 20:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="q/ZZx5MQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2362374B
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 20:50:56 +0000 (UTC)
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BE189
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Nov 2023 12:50:53 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 2dtRruSlMqMnP2dtSrqYvJ; Mon, 13 Nov 2023 21:50:50 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1699908650; bh=wmjZdM3HkIb1n4MXEkEYOhAg/HXmh63UcOiwCLumSCc=;
	h=From;
	b=q/ZZx5MQmIfpXkQSpgaT3ByNNXMpLh6DGB+34U6Cshna4Slrm5f6Q3kBfoMKcx2Gz
	 yVM4IO3HcBaWivd2eT6UFMsAm/JvrIAK649A0HIueU7xskxkEpqOTZx6AHnLn3jsEt
	 DyYwBD11J6/qA+tpovq/51DJv2gH0h1q4/CJsq+Ij7Z0Ww/zLhJRsOE5YEEpoArAQp
	 bZ9d1kKffrfCj+u01q+Eaea2ZI9IROLGN6MWK+80CLZ7JNRfv3TRItWEgpSaDtJBI7
	 2mTvhpF4Tr2+CHUvEIYzbRF/ZVjzVM+TqqxBd3o6Zd0Q16hj0idhW+mmc6oL7g3dGg
	 eJgSm+ybmD+ow==
X-CNFS-Analysis: v=2.4 cv=Jat672GV c=1 sm=1 tr=0 ts=65528c2a cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=cZrqeui6gzw1lTgSrx4A:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
Message-ID: <c47b7010-2993-43cb-91b4-13bc0d447260@libero.it>
Date: Mon, 13 Nov 2023 21:50:49 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: checksum errors but files are readable and no disk errors
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Johannes Hirte <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH+EPe/c/N43xPSOPEgLkTZUqJ9Cqpze+EjjVYmrVu27JaM0UHFoTb1yvvUvLlerGg2n5ZinbLiFsIzTAsxmblqSVZC4roe5YuAYqiQ8daa6sNimVGRM
 dvUdJnGfzUWQLDg8M1dLZof1REeB4kw1xIb4jO+yFiT7Y8RELLwhQMIfBcTZF7H9wzGKiMdscWt3DU8CMxO87H4ZI2/5evWPN6EL1D3/oFJePy87dKOOsnMY
 WO4kYjW0C37JlF5F66jwgIkIbhpqfOrIRWa6dJze+5s=

Hi Qu,

On 12/11/2023 08.51, Qu Wenruo wrote:
> For the cause of the error, the most common one is page modification
> during writeback, which is super common doing DirectIO while modify the
> page half way.
> (Which I guess is common for some VM workload? As I have seen several
> reports like this)

because this is an already known "bug" of btrfs [1], what about taking some
(non invasive) countermeasure like:
- put a warning in a dmesg in case of directio and a file w/csum
- do a csum ^ directio
	- disable directio in case of a file w/csum
	- return an error in case of directio and a file w/csum

If we cannot guarantee the checksum when a directio writing is executed, we
should not leave the user under the illusion that the file is checksum
protected.

BR
GB

[1]
https://patchwork.kernel.org/project/linux-btrfs/patch/5d52220b-177d-72d4-7825-dbe6cbf8722f@inwind.it/
https://lore.kernel.org/linux-btrfs/1ad3962943592e9a60f88aecdb493f368c70bbe1.camel@infradead.org/#r

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


