Return-Path: <linux-btrfs+bounces-1169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B68B820486
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Dec 2023 12:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D7C282153
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Dec 2023 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5179E0;
	Sat, 30 Dec 2023 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="XuxG69Kr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07E79CC
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Dec 2023 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id JXOgrgJQQtNr4JXOgrxZ8e; Sat, 30 Dec 2023 12:20:54 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1703935254; bh=lJ6HQVOhEweyvyjQW0oNnZL3vQgSh4P3cc9JUgEyGus=;
	h=From;
	b=XuxG69Krpo2RpXjAmNpxZaLLdYsMiK48SJP6dFlF0rEi1Ec0hppoEHff1FHhqqqHu
	 fvcIwJeCy4T0PD1OkIvR9fCOQjwIcG91c8Bfp9MxiCeSZyh+a4usaZn51ChpI0IUjY
	 ZsJe9BKptrdAWfVV8BqkGruqU2y5Ii5mJi4zbCKEHZJajnmz+rerQuYWUcukF3an6J
	 Mp+NVzaCH1PV+hPJCZog6QsMpL8v1N6pXg8Jyy3x+KSDrKik7X/h0muD8//r2UBQqh
	 alrhHcd1Gy6FTBeOYOU56xQFG1BVLh1Y+jpIZffglCcVDgYBek9D5WkwsSJOESvDMU
	 XhcbQFhZFfinQ==
X-CNFS-Analysis: v=2.4 cv=Y44+8DSN c=1 sm=1 tr=0 ts=658ffd16 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=afuZVMEZdzaUdAc_kMwA:9 a=QEXdDO2ut3YA:10
Message-ID: <6e4b2c09-b820-4ba8-8117-d13f3556e426@libero.it>
Date: Sat, 30 Dec 2023 12:20:54 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/9][btrfs-progs] Remove unused dirstream variable
Content-Language: en-US
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1702148009.git.kreijack@inwind.it>
 <20231214161749.GA9795@twin.jikos.cz>
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20231214161749.GA9795@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAqg55Y/HdMWH04+fqi/ED+RFpP7Icg8xvVpD5CBo0RSyoRcJw74zBIRW1dAcbkdXfRVxv2xmalh4REzif5noEhtjpHbPtQDXNuucF5XqbDuN+qe9RVH
 dzgb48VjmDB87u+FV1L2Nx90H2cw200cif4rpyU3m5VhhtXferHUi6Ch0B0tGhcbYH0gW0escVou/YjWAfeOm/E6URo4OPNt0zgHPfvg9MwbM7BgIiBeMzI0

On 14/12/2023 17.17, David Sterba wrote:
> On Sat, Dec 09, 2023 at 07:53:20PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> For historical reason, the helpers [btrfs_]open_[file_or_]dir() work with
>> directory returning the 'fd' and a 'dirstream' variable returned by
>> opendir(3).
>>
>> If the path is a file, the 'fd' is computed from open(2) and
>> dirstream is set to NULL.
>> If the path is a directory, first the directory is opened by opendir(3), then
>> the 'fd' is computed using dirfd(3).
>> However the 'dirstream' returned by opendir(3) is left open until 'fd'
>> is not needed anymore.
>>
>> In near every case the 'dirstream' variable is not used. Only 'fd' is
>> used.
> 
> As I'm reading dirfd manual page, dirfd returns the internal file
> descriptor of the dirstream and it gets closed after call to closedir().
> This means if we pass a directory and want a file descriptor then its
> lifetime matches the correspoinding DIR.
> 
>> A call to close_file_or_dir() freed both 'fd' and 'dirstream'.
>>
>> Aim of this patch set is to getrid of this complexity; when the path of
>> a directory is passed, the fd is get directly using open(path, O_RDONLY):
>> so we don't need to use readdir(3) and to maintain the not used variable
>> 'dirstream'.
> 
> Does this work the same way as with the dirstream?
> 

Hi David, are you interested in this patch ? I think that it is a
great simplification.

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


