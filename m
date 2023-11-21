Return-Path: <linux-btrfs+bounces-226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475BE7F2D0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020842822F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB6C4A99C;
	Tue, 21 Nov 2023 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="DEnwR57+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A883D51
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 04:24:17 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 5PnargdPxEwsU5PnarggDK; Tue, 21 Nov 2023 13:24:14 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1700569454; bh=3ZeFfJs+WQ7GJOBZvCkxXW1xJJfOtvnE8ONwTrCCtDQ=;
	h=From;
	b=DEnwR57+wE/H95TIpEJSiimduQpRlwBw1AOw8ReNRvm314q0iShdiMfXN6udf9IKy
	 sk5OajXYcB+UXXzNK0xne+q+c76YJEOQBv/Kmwz7XSmi6sHmzsAPloLT9p4pzndNan
	 kcI85DhsQlrhaWKBMn05X1QRfBt6/lMK7AIq9KdY17ycD4yWURvqxgDW+I/unpJA63
	 o3PdEvVO+HPySNAw50ktce50IGQPHfUY/aoPH3N/nqv95PO0+SMWE71IzN5l5MvHWG
	 UErf/q36uH0NMhHjyrWjPycuzobAjP1PAVma3PUrzKLV71tfI+d2PGvxaIvRdhOFM9
	 jeJ/tr5ggI+zA==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=655ca16e cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=7YfXLusrAAAA:8 a=zn5tiQnlljqv61cbthEA:9 a=QEXdDO2ut3YA:10
 a=SLz71HocmBbuEhFRYD3r:22
Message-ID: <a288c71f-9e42-4448-9089-fc0e3dfa8abb@libero.it>
Date: Tue, 21 Nov 2023 13:24:14 +0100
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
To: Phillip Susi <phill@thesusis.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Johannes Hirte <johannes.hirte@datenkhaos.de>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <87ttpgz3qp.fsf@vps.thesusis.net>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <87ttpgz3qp.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDj/UZgOFvUAW9qUirbf+aEbB2YKgLUnmrWhPl2VvXYR7VoVJVxhU7mjbhRk9lVNXY8FG0TWyVWIvmLrGstU7zjN3Kh0QGZ/i0x4G+DesbctTGIUVf3e
 DO4LS3q89WJ4bj97FgiurUYnQTaS/zbD3hp0JE5Z2N5/hOZ/gUX09dkZQVDjv+EV/ySxDlBMuKPGAHuQQm54gJo1VQmg6qhDsUc9PT/U4/nudw6GfkluLKku
 xh9lYL7oU4GLWCG3FicJRgSfNktqxGQrOXl+6TFm/QmX8rowTr0UfNX65MjOZGhhxP7Azrll0ViXDNuGYS3WyA==

On 20/11/2023 19.19, Phillip Susi wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> writes:
> 
>> For the cause of the error, the most common one is page modification
>> during writeback, which is super common doing DirectIO while modify the
>> page half way.
>> (Which I guess is common for some VM workload? As I have seen several
>> reports like this)
> 
> How is it common for applications to modify the page during directIO,
> which is explicitly NOT ALLOWED and will result in bad things happening
> no matter what FS you are using or if you are using md.  

Could you elaborate why is it "NOT ALLOWED" ?

My understanding is that when the write are not sync (i.e. the program
doesn't wait until the data are on the platter and the metadata are
sync-ed), there is a race between the kernel that write the data
and the user program that may modify the data. And it is possible that the
data are a mix of the old and the new.

Now the problem here is *not* that the data are a mix between the old
and new (if you want O_DIRECT, this is a price to pay); this is an
un-avoidable cost of updating the data before checking that these
are on the disk without using a intermediate buffer.

The problem is that the csum are not aligned with the data.
This is a specific issue of BTRFS [1], only because the other fs don't
have the data checksummed.



[1] ZFS until the last revision didn't support the directio.
bcachefs is new, but I expected suffer of the same problem if
it doesn't use a buffer, defeating the purpose of directio.

BR
GB
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


