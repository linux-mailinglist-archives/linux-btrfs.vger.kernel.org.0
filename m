Return-Path: <linux-btrfs+bounces-19234-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE803C77243
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 04:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 4FAFD29082
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 03:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF252D595F;
	Fri, 21 Nov 2025 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJHf0Mt8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3282BF3CC
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695032; cv=none; b=R1HwQAza1kACuHWePciOyws88I6o4439AL4icSeqKuI6+ak0NpfN94wLs0UTgYJNwtdWIC3EgRZ0BOcgDu9FxDhtYGJj/Ui7AippCSBxbDKHqAVX/mJn6sneA4XtJZTmNsBf/MI+C4A2bI1CprgptnoUcilDytFSIQXFjiV6Imo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695032; c=relaxed/simple;
	bh=NfZehcD1Qs7wk2Ohm91A0peV/+sEretojEBGCFbXVGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrLbEI4dU34LFJJGFDYBB1bnDiWSKTMe66EHgCmgH0sxvC5pbtVey/lhSgSdnEbvuzCzhsajFAPAGuqNe9lvBlXH21gbWoF2FsvprboarV7WRoAAv2v1/9ydU7dEGuxp97NYVNFfoP/YkdcmSYg78TKgQyUK+QoERzWdb4I8qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJHf0Mt8; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-343e2e1a580so276961a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 19:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763695028; x=1764299828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xou2Sxu4LTzhMpd4VkCC/4Pp+h878hgJeiBbFjpWt54=;
        b=TJHf0Mt8V08dH9dSPjNLvc+lTJIoWiJx4uM0iN8TG03gFNY+66MaeOrzmY7maVMyit
         f2w75YXiLV4vz2a7+6s3wHNNg7gjMMVjNFZH2wPREMlO6PWZYyuCmxYTxv1/H6cpPR07
         MGkUFfgNnWiKSC2+GzNvx1IUV7T6n+R+bKeGTctR3JhniPJiqWdKAiAmdJiIqmhXQ97G
         648KaJQZwG5YorOrKVaXl9SOeWXbMlF0/cgTGFleurSM3Lgf+GqwJ9NJ30OBol8ss331
         1Z5hfRjS7PWXzwQuUaETTwtLltxuIRLbL3Uv9dinfpFPceYjROv+nbOG9ot2JI9EXYh0
         bMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763695028; x=1764299828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xou2Sxu4LTzhMpd4VkCC/4Pp+h878hgJeiBbFjpWt54=;
        b=fn/b488tx+8mEfcEPwtqASVPgxc50/nqCjVevETKXlGcMJCSoh1K2vrlbZRUHT1/lh
         TUMdceRUiUV6/F3d6xbQcedUmUYz9xfoKAMqm1HLD85Pe1IJLAAbhi79UILeB47jEbZk
         rlORg32vcyTQouqU6gTk1crRZ1WJmqWWD0gUkG3/0LyhcdH+teZ56CghtjEUo1GwdGrI
         gG5xkHZoN8g9IG/TFKfjXjDaly/Jq03bLQx6O5zymkXHLet6rT0Ef4s+D0zCoBKOIQDh
         kJeYb41s1Ypcz1yWf0Mp5UNQW6D3sNgvr78AA3sqHMK4P6Fqm2cmJ6mywclfRFAleBbA
         ixUA==
X-Gm-Message-State: AOJu0Ywt0LzyiVO28zwvJbbs6ZsT1hpH3Z/Gz1NwQNkq2Ly3+QmXDiWl
	nHPT4fn8k/m88/5VLOnZV/8nZusuyLOQWLeq3GbT/VBN/tvQQtJITqkX
X-Gm-Gg: ASbGnctdyh+hj1k0UjAJShlkVDkljzc3lBiJv5JJ6r84xkUmYY8o+Tm4kSSHLJ4nXjM
	7b3yPlDdal3FUXWmYg+Kvb+32reRacjnXJSetVHF9vDzOIB852T+jT38iwyquqZFULsT9PcL+hW
	JUAevLACiowjswZmMy7yDfhT9GErimuVNf27y35wnH5/G+twEQhEIAfVN2Cfk+yvCJZHTe5y1LU
	I87KN8PeqTGCG7ojlLUP+wpxmW7NdULsxHoHLCwAM6VHKDjzsp/RzIyyDw3vTSen34K7FR6Z2Le
	U5Olf+6FkNtIXU+XZZutd0ANdvKgTrmqoKncojma4XpwEIrZrwDbV4kqPrIlwyNxoMhGtpnRD8D
	QdMlHZb9IspyONRtpvQNBk7/8levjAs7Ch6BOPMO8imll9gucVLpCXfXH8JlFPIWg13B05qyO/X
	w3/feWAz5aJOS6m/8Nmqnm0xVP
X-Google-Smtp-Source: AGHT+IHOFX/GStpBYuZU84q3VLt+np0F56omLOImL8BI9D441QT1Yfi9duCdeXDiEUFsxOpLL2JaGQ==
X-Received: by 2002:a17:903:1b05:b0:295:70b1:edd6 with SMTP id d9443c01a7336-29b6beae519mr6390585ad.3.1763695027665;
        Thu, 20 Nov 2025 19:17:07 -0800 (PST)
Received: from [192.168.1.13] ([104.28.237.195])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm3956018a12.0.2025.11.20.19.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 19:17:07 -0800 (PST)
Message-ID: <6e3d587b-89ed-4b44-ab62-c485b8fdf814@gmail.com>
Date: Fri, 21 Nov 2025 11:17:02 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: simplify boolean argument for
 btrfs_{inc,dec}_ref
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, boris@bur.io
References: <20251120141948.5323-1-sunk67188@gmail.com>
 <20251120141948.5323-3-sunk67188@gmail.com>
 <20251120190206.GM13846@twin.jikos.cz>
Content-Language: en-US
From: Sun Yangkai <sunk67188@gmail.com>
In-Reply-To: <20251120190206.GM13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> I find this worse than the original because the key piece of code is the
> condition and putting it to the argument obscures it. I think we have
> the condition in paramter in some places but it's where it does not
> matter that much.

Yes, I totally understand. The condition in function parameter is annoying. We can

1. Leave the `if (cond) foo(true); else foo(false);` untouched. This seems a
little stupid and we have to repeat the same thing in different branches.
But it is more clear and the if-branch condition fits better with the common
style. If you prefer it, just feel free to drop the second patch.

2. Do something like this patch. But the foo(cond) style is rare and alien for
people not get used to it.

3. We can optionally add a local variable like Boris mentioned.

> Nice improvement on patch 2. It's much better already, but I am also
> sort of curious how you feel about giving the bool a name to make it
> more self-documenting.
> 
> e.g.,
> bool full_backref = btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID;
> btrfs_inc_ref(trans, root, cow, full_backref);

It looks better than 2, but still seems uncommon. And
  - The local variable may be declared far away from where we need to use it.
  - The same condition might be used elsewhere in the scope, so we also want to
replace those usages with the new local variable and the name full_backref is no
longer proper.

So I didn't do this in the patch.

Thanks,
Sun YangKai


