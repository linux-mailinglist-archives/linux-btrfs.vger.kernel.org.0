Return-Path: <linux-btrfs+bounces-3834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4773A895F52
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A9B2853F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Apr 2024 22:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B015E805;
	Tue,  2 Apr 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VKSrTxVs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6314C15AAA7
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Apr 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095517; cv=none; b=aoLlo+HMAH68TOQZ76fAgBdtCq7HzJACAu4nWXQzbqBSjt7B80P1h0XYa8uvBE79yjgg+Tz6gZT4KHDyXdTngnfJgLEBIqKtwI9WT9Nf2D5iwNFC4Z1XyQAtHxbJ29gTWAJ6CjNbw8+1BJ6qxG/mym2V+zuRctZSDFMRRBpcx9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095517; c=relaxed/simple;
	bh=Tzbf8q9i7oiwKHk5gu8BgGy8WQkYsFlN914VQG7ORLY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=J5oT9wuXAeLj0NGUJGVyxXW3MFspcGFkwRehpIZUaN6HjY1wF8jP4rMcSWvdIjX6eXT5ao7H32ZBWu8pOd72trjtmuZ/of8Ef4RTX8dLM7hZqlWD55t7gsybAcz/PBz2lmDpXx6m1ZufYsCGvtWsJuGpiJ77EP6gexCkDOzP9TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VKSrTxVs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513e25afabaso6239217e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Apr 2024 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712095512; x=1712700312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TiHp9Dw/yRw0OaOkNKysRlr82pZ0BZaAApeoZZAScaE=;
        b=VKSrTxVsG2bfDR+CdqozBDg7zNM1Wd/IHOvjVtsx9RD4/Ga0NvxY8+vjAukPeAn6a8
         UlJmBZOplSWLVadtpYAVpKQaoH6pn7txsU6Hu2pXZU9EMfFdA60QVp97im2MZeUx9uoj
         1iGErABxZZaYTpSfIhMUWT6nB82zpB/7v1s1bnsylpLwovr4QdLc+07EzoQ973dHnaJH
         8vrLunn1KJ38dy2NEJyvCxk6iCAhrRHANZ6IN9bF5H0AJENM7wxkpyWGndFX/OVFvOzH
         zA5/JfgkoQbfPTMlEqT6c12VC/eBh/1f7kbo8IryHhvE8oH8F8YiYpWOyFmqWY4hlv9e
         C9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712095512; x=1712700312;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiHp9Dw/yRw0OaOkNKysRlr82pZ0BZaAApeoZZAScaE=;
        b=rkOkw8CeEAnvgnCe1kxtJX30+ClpHuGVfPuq42hhRDEbPmsZL99coNdtn7Op+1GBu+
         njbE0lEFo5VFjOW+jaYBslDoBIJ8bKgAobOg979DZQgR4qoc9bRnVbVnOFDCT2FFQzAQ
         dOP8T8Ht0kxBGwuNLFTbqrUQ25rN4BB7s9Kyap22/SKzTPJ7qe6WsXzjlbHQA2BgET9w
         C1YOmDw0Qic7Va+9tXXMLqG2yT0XVANhOjisp6uVGXA5A1iWZtnMYtrf1mT86Z3CMkjb
         BVUq+muH3xfjK/r9GThdfJzjhorA1b/kuuNRG8YfiE1ZkCo9oC4g8vNlnR8JafwtG5Sg
         fj/w==
X-Gm-Message-State: AOJu0YwwTQL2tpM4ipocW0tD8EZormvXMmN5tF00d+4GaM9jjITfaEh/
	HsxA5PdrqRxYsvwKlKsS6wE9uhGTT2zdDtLgX0FT86Iz71W7tVlevarE8osyKYIUq6QwjC0/XxK
	m
X-Google-Smtp-Source: AGHT+IFhXzMwE4rgvuVvmTs0xspMU91ZjkyHs+i78R/Z7tPrcngsiT+Qv/3tIctYRMRuJvPL9K0KTg==
X-Received: by 2002:a2e:94d6:0:b0:2d4:6bcd:7e19 with SMTP id r22-20020a2e94d6000000b002d46bcd7e19mr8276920ljh.42.1712095512481;
        Tue, 02 Apr 2024 15:05:12 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902654e00b001e261916778sm361593pln.188.2024.04.02.15.05.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 15:05:12 -0700 (PDT)
Message-ID: <7bb61bcc-b68d-45d6-8217-4b11c23698f1@suse.com>
Date: Wed, 3 Apr 2024 08:35:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs-progs: header cleanups
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1711837050.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <cover.1711837050.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please drop the series.

As David mentioned in the github pull request, the LSP server is pretty 
aggressive as it can fully understand the different configurations.

We need a more comprehensive tests on all possible configuration/build 
targets/linked library etc.

Thanks,
Qu

在 2024/3/31 08:54, Qu Wenruo 写道:
> [REPO]
> https://github.com/adam900710/btrfs-progs/tree/headers_cleanup
> 
> This series is focusing on cleanup the unused headers.
> 
> This is mostly done by clangd, although it has some false alerts related
> to macro usages of a header.
> 
> But still it's pretty awesome to cleanup a lot of unnecessary headers.
> Only one special touch on pretty_size() macro, to change it to a static
> inline function to workaround the clangd bug.
> 
> The first patch would do the main heavy lifting, meanwhile the second
> patch is doing the BTRFS_FLAT_INCLUDES related cleanups for library-test
> code.
> 
> Unfortunately I didn't touch anything inside crypto/*, the main reason
> is I'm not confident enough to verify all the optimization for different
> instructions.
> 
> (And even less motivation after the infamous recent XZ backdoor attempt,
>   by a possibly state-sponsored sleeping agent, ruining the trust among
>   open source community.)
> 
> Qu Wenruo (2):
>    btrfs-progs: headers cleanup
>    btrfs-progs: library-test: header and BTRFS_FLAT_INCLUDES cleanups
> 
>   btrfs-corrupt-block.c        |  1 -
>   btrfs-sb-mod.c               |  2 --
>   btrfs.c                      |  1 -
>   cmds/device.c                |  1 -
>   cmds/filesystem-du.c         |  1 -
>   cmds/filesystem-usage.c      |  1 -
>   cmds/inspect.c               |  3 ---
>   cmds/quota.c                 |  1 -
>   cmds/receive-dump.c          |  1 -
>   cmds/receive.c               |  1 -
>   cmds/reflink.c               |  2 --
>   cmds/restore.c               |  1 -
>   cmds/scrub.c                 |  3 ---
>   common/device-scan.c         |  1 -
>   common/open-utils.c          |  1 -
>   common/path-utils.c          |  1 -
>   common/send-stream.c         |  1 -
>   common/send-utils.c          |  1 -
>   common/string-utils.c        |  2 --
>   common/units.h               |  7 ++++++-
>   common/utils.c               |  1 -
>   convert/main.c               |  1 -
>   convert/source-ext2.c        |  1 -
>   kernel-lib/mktables.c        |  5 +----
>   kernel-shared/dir-item.c     |  1 -
>   kernel-shared/extent-tree.c  |  1 -
>   kernel-shared/file-item.c    |  1 -
>   kernel-shared/file.c         |  2 --
>   kernel-shared/inode-item.c   |  2 --
>   kernel-shared/messages.c     |  1 -
>   kernel-shared/root-tree.c    |  1 -
>   kernel-shared/tree-checker.c |  1 -
>   kernel-shared/uuid-tree.c    |  3 ---
>   kernel-shared/zoned.c        |  1 -
>   libbtrfs/crc32c.c            |  5 ++---
>   mkfs/common.c                |  1 -
>   mkfs/rootdir.c               |  1 -
>   tests/fsstress.c             | 25 ++++++++++++-------------
>   tests/ioctl-test.c           |  1 -
>   tests/library-test.c         | 22 +++-------------------
>   40 files changed, 24 insertions(+), 86 deletions(-)
> 
> --
> 2.44.0
> 
> 

