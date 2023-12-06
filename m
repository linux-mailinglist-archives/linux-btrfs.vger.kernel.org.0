Return-Path: <linux-btrfs+bounces-726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510598078FF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 20:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0692F1C20F20
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD743EA8C;
	Wed,  6 Dec 2023 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="dj514mSl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE94D3
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 11:53:03 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPA
	id Axx5rLRF1cu4tAxx6rpJpH; Wed, 06 Dec 2023 20:53:00 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1701892380; bh=mEJkVm7ev+DvD2HkhMHa+JzB8jmcPs/8qwMiFpGr2tc=;
	h=From;
	b=dj514mSlsm8IvBdjGxMZlnNzsxq72vKQHnz1ezENdvumgNnturQz3Mz16kwVjLT9x
	 Yh4nVxRdHmeWJzfEkB07w1+WhZHrGsQK9W+QmKeAZPcPcuhsKd61FSjX2RMJK8nF6M
	 1NqvANCghLpmwgELXsZZVWTzcuw1eWprcD+Uvuj4gHhT+JDXSujRaiRzzarxQLSL63
	 klsi6u/aDaEtSXcSf3mE507twr9TV1zNoVOeHwvhU42gd+ywDCO6c1dD32AUdVvIRa
	 EduQvgUfQuKL302tFuNFH2qx/vAR8dma4bC6Ctd0yF5Z9UEQdi2U9yCTUEP/LMb3wS
	 Iyg06t8aZgaYw==
X-CNFS-Analysis: v=2.4 cv=QouYn3+d c=1 sm=1 tr=0 ts=6570d11c cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=6KbN6L3f2dnEQenaixcA:9 a=QEXdDO2ut3YA:10
Message-ID: <dc5b4031-588e-44ea-9bc6-e429a8195e47@inwind.it>
Date: Wed, 6 Dec 2023 20:52:59 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Content-Language: en-US
To: dsterba@suse.cz
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231124161906.GE18929@twin.jikos.cz>
 <36171811-ed49-4427-a647-e052ec70faa0@oracle.com>
 <589d8650-26e8-4c0e-a602-bdb5ce427ed5@oracle.com>
 <2248a4d7-bbd0-4bf3-992a-c1e13c8f2c20@libero.it>
 <336d54f8-3a27-a7e9-3482-781559fab709@oracle.com>
 <183599a4-392d-443d-b914-7ac830b3c2d7@inwind.it>
 <20231205174443.GP2751@twin.jikos.cz>
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <20231205174443.GP2751@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKUtLT3q3088cmlmPaIBmkthfCX5+aynhP0bhWS+QmBuNIFmZI9quRdV9g6g5DVqqUEt65MWu922ugJ9mYtUxDtuejEtbQr/Se1HPeonU+7Ho0Ut83SR
 QAml6PspHg1Q/ZOtFu08RPOitHZjTFT2mvLnUtLhviMV17iWbLDEsisNPbtB0qjzOObb41X42Xvoqk5uvNqQ1iHkLJey3ktYncqELdDpbIAky+MvzjR7PNye
 PPxOOqdOgEysAqAFWs/zGg==

On 05/12/2023 18.44, David Sterba wrote:
> On Wed, Nov 29, 2023 at 09:54:02PM +0100, Goffredo Baroncelli wrote:
[...]
>> I developed a little utility to build for each btrfs filesystem:
>> - all the devices involved
>> - all the mountpoint (if any) where the filesystem is mounted and the subvolume used as root.
>>
>> It was nice because it got all these information only using:
>> - libblkid
>> - parsing /proc/self/mountinfo
> 
> I think if there's one consistent approach based on libblkid then all
> the related tools and projects can use that.
> 
Just now I send some patches to evaluate. See

[PATCH 0/4] RFC: add the btrfs_info helper

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


