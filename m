Return-Path: <linux-btrfs+bounces-7084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8A294DC24
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115AA1F21F4A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756F15534B;
	Sat, 10 Aug 2024 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="0F8bV462"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA51798C
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283749; cv=none; b=KtcdYJ9RH67G5KaD5cCJ/mnWdnrm3QaSqvFgFk6S0xKDyDb3J47pY4oB2SElu1BZ+1cONSiCXEQ+ix101P7CYn0Z3UPbj+6jt59sdkW+zCm7vaIP8VCmVigCeGTufHemmXurf+8M06jrdAfdAQyDsYiGH8a0sfi9QD9x5xMSggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283749; c=relaxed/simple;
	bh=oGB7VfZ3LjqBGC52AVC6Zx6oPKwfVX3zdzi8w3kco4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNQSAZv9eeO9W7nM1lRXboIBF+tnZYBL7+Ac+tGqLh+2U2SGJyLrw6rxTt35GB1RwZcVYjZQuNMy/tv0OKzc3XbO8nbGvpiWUiT26o+ZB2rbFNjpI+EROcujg64raqPZXQdaLOU3NAlfIuzzKqj6r0w7y5tBpL9/yN+hAaI60yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=0F8bV462; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id cimas21UYUZkEcimasqkzf; Sat, 10 Aug 2024 11:53:08 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1723283588; bh=P+fcgY3EN5XT3MO/vgj9HcANQyjy+8yDurcS09yIE00=;
	h=From;
	b=0F8bV462tDNW4kHKzNFxi1tiT1KtBHD1B5zCsu2i5ozSpzbmdsgnTaD6EZuOagyJL
	 ptmSu6Dbp888+c7e+GxhEkG520i4x+mKTBwYEm6MVhyN3WLvhULtju0o9yRFfFOTr7
	 aSNCJ/gB7+MmlEP1ts/j722lUTSZd1GOIBmcCOULwdrRDiPNSNQj6/1eHHQJC+LyFN
	 Dtu28N0fzQk/3FHGTvQBOvkc8dfuXrDe+LpIyafZASP7I8i34jSTCPRnX5nXjI9wyq
	 s2IOYor+a3ukt5xhPR/hV0npHyvBT46M3Af1j8CzydSKv4agktyW2bG7rb9JKzY1tR
	 iJK0nfTPPs4nw==
X-CNFS-Analysis: v=2.4 cv=P43xhTAu c=1 sm=1 tr=0 ts=66b73884 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=gxWoPy_epkRx0F_XwxgA:9 a=QEXdDO2ut3YA:10
Message-ID: <f9492406-1fc4-4801-a74d-890353a34e3e@libero.it>
Date: Sat, 10 Aug 2024 11:53:08 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH v5] btrfs-progs: add --subvol option to mkfs.btrfs
To: dsterba@suse.cz, Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
References: <20240808171721.370556-1-maharmstone@fb.com>
 <20240809193112.GD25962@twin.jikos.cz>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <20240809193112.GD25962@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO5N96gq7UglbB8bbK5poMqhw3gYNP10yHokR+2Upb6LXbzFBx/0MKBvlB1qb83Haj4MKcnRi5BQlTT2tO00dnf5s0o2lf2+ArOKULOz+LKPcbrUtOAp
 0l5HeD6MGy2qxrKwkPohipvjjxUaL1DxpbDYQT0Ghc5Z2qTZaDaD1s2ywQtPDt8ujnRCcfZaBbN50+vvXUSNe1GzxRw9al1F9xwK1RKlCRkRzCjSI8A3HeBI
 P4Ls0p98lZBK2iQRFadmRA==

On 09/08/2024 21.31, David Sterba wrote:
> On Thu, Aug 08, 2024 at 06:17:16PM +0100, Mark Harmstone wrote:
>> This patch adds a --subvol option, which tells mkfs.btrfs to create the
>> specified directories as subvolumes.
>>
>> Given a populated directory img, the command
>>
>> $ mkfs.btrfs --rootdir img --subvol img/usr --subvol img/home --subvol img/home/username /dev/loop0
>>
>> will create subvolumes usr and home within the FS root, and subvolume
>> username within the home subvolume. It will fail if any of the
>> directories do not yet exist.
> 
> Can this be fixed so the intermediate directories are created if they
> don't exist? So for example
> 
> mkfs.btrfs --rootdir dir --subvolume /var/lib/images
> 
> where dir contains only /var. I don't think it's that common but we
> should not make users type something can be done programmaticaly.

Can we go a bit further ? I mean get rid of --rootdir completely, so
a filesystem with "a default" subvolume can be created without
passing --rootdir.

However, this would lead to the queston: which user and permission has to be set to those subvolumes ?
So I think that we need a further parameter like "--subvol-perm" and "--subvol-owner"...

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5


