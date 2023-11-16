Return-Path: <linux-btrfs+bounces-157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C77EE7B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 20:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD8AB20B85
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8384495F1;
	Thu, 16 Nov 2023 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="FMUPvLuU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30118D
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 11:50:22 -0800 (PST)
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 3iNXrlGaSEwsU3iNXr0POJ; Thu, 16 Nov 2023 20:50:19 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1700164219; bh=+7AnQ6dMF0Q3vxkmEBCIb01D2p/jnFl1w4W0bLjIypo=;
	h=From;
	b=FMUPvLuUBnLot71PAvZMVfXFFARiAci8jeHVLXZjKpPcbEsHxta3wi1HPKHVm5nvy
	 vPV9E3ixxVVjQ4AUjVaJqz3gYaE1t2HkdMSXtjyWlf2UDw8P1TbURXJiHfb4B2TLtn
	 26NFAADXIBj7upoNZCxNEgChs0FWJP/BDZ9hMNqQN9iuMet7mjzX9kJWXUvYib1edw
	 snmVszytBm/A6UvrBtZHw2RHAETdV+OZSNQpxDnY3OuAjuesr0dknekaVRAcdtSxOw
	 rYWR1iQoUBWaKCXkdYe0Pa2b93kczGOUZuFym/jExbYeHfa8T8V0cueFPXmjQ0Vk/h
	 TKaahBakjsw+g==
X-CNFS-Analysis: v=2.4 cv=N6vvVUxB c=1 sm=1 tr=0 ts=6556727b cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=IH2DhHoWs26R0i4y0UAA:9 a=QEXdDO2ut3YA:10
Message-ID: <5e33baee-80ef-421c-9e88-d1d541461469@libero.it>
Date: Thu, 16 Nov 2023 20:50:19 +0100
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
To: Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
References: <6b6aafe0-811e-4619-91c3-36700e387cec@datenkhaos.de>
 <6a87d788-5f4c-4cb0-8351-233ab924129c@gmx.com>
 <47f08d62-3fa2-4baf-9425-17d1f119ef8d@datenkhaos.de>
 <fa4814bc-6f59-46f8-bd1a-d79f4020a2fa@gmx.com>
 <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <5f6ff1cd-dd64-b88d-e814-39ba3b23395a@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDDadl4iWZeaqWeOVjkj1D4pSESWrQQtFqrrLH5sGzb9wPqzIEo//8NOpL8NxDf9RGVd42WxoWMRUxIlUMDvSSbNON50lwgXiko9SBopi3psOM9bGhAj
 Odje123n9AhPOgQTo3DVxIyHmaDPQVE2yr0HTMR/0jLXr+XZANCW5c79Zpcw4JyZdz3X7AXfUnmKWViV9n84tn3PV3tK/9EQCk8ecStYdu8gIKkDmYth/zen

On 16/11/2023 15.30, Remi Gauvin wrote:
> On 2023-11-14 3:18 p.m., Qu Wenruo wrote:
>>
>> Disabling COW is recommended for those VM files, as it implies to
>> disable csum, and reduce fragmentation.
> 
> 
> Doesn't disabling COW on BTRFS RAID1 Still result in inconsistent
> mirrors with unclean shutdowns?
> 

Unfortunately True,
nocow means nocsum, then the system cannot tell which is the good copy.


BR
  

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


