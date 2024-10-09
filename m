Return-Path: <linux-btrfs+bounces-8675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C74995DF5
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 04:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD2B2173A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77413D8A4;
	Wed,  9 Oct 2024 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JjWtVs9M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E2A29429
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442663; cv=none; b=CaxbN/goI47FLYkSr0KvUbHQu7TdY8jCSV29cIRLEJayfGhic/ZxZV5RB9E0MbhSrAmz3IrdkT1fsrvDtYmZgHfEac3xcqq/kV14ziZg6hu3RXk3luYZmNWvD9G4K4rt5hPrI3NWVt9rSpyGTnGahwxoNokSFtrKuCj5Anh7wQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442663; c=relaxed/simple;
	bh=wm5DKPiM8dvv7oT1qXmnSrH/Q1AzlRXxX/i2nu8fn64=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=k2LwSTKJmgk8iQDNcJT8G2PL+7VQOim2ffe1opcj2DRD0ejWuw0rGM3+j4RJn299sa03rwCazKIO1sUmhb/V5Ypw48nNFfJ6rfU+bpSOkkryL9DTmMD7wdTBMu9JZlMDb082Jyb590Wx7w6YRswf+NTM7GoB8nUOCChB30Zq5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JjWtVs9M; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cd3419937so3777230f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Oct 2024 19:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728442657; x=1729047457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvUCaVFdYLTP95TQkYg4h2RDD4r/Ynex/DaRiJ9ylVg=;
        b=JjWtVs9MyWPbwAGii5J/bjFp8jliERS/ibkHBnyROh7nESQj276cL/9pkD7mmzJGO5
         q/PRIuCiTsjFIw6KJAFk/TigNZ4CXlJVrEZ/y6sulJZ977zJE9LQwTQzogZcblyo7CSk
         1Pf1MEQBX+KjQdFZYMJj/+vtMQkcojnY9kPb/OyTDwh18LzECqBYW8mblwrTjEQQUpn0
         WRR3UyD1Fr9oYVnGFah9Q/h5JJl2cz9B276jhEWB9j9b6EsfUmbJAdM9uArZ/FV9m9os
         lSEzcm/XH5zoUfDHdBrpyYU6WtfLMV5ZcbcWwwiIde8bbKPO9DdQn9vyfseHxcIFVblF
         0KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728442657; x=1729047457;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvUCaVFdYLTP95TQkYg4h2RDD4r/Ynex/DaRiJ9ylVg=;
        b=A4E4dKyQQJONR5gsgWJdHwf4YciWitJ7mP5bRGrqqyLGvTIQPbVWrkPVfA5WSuIo5Y
         t5+Lfd2Rp1nnp2pmMhauHq/YAJwslJsB0C75NTJyrv0mNkGQI1Bg8IMIYOEBViAbM/LD
         wwYmRF1WbSxHO83Qr5MCnji7WQpXjRyQXUuFv+aYDz9rtJdfq9yNrL706mjx6DqRGtrd
         lxfBDJdVHkh3FC7s1pn1Hufu2Bo/FNR8uRdtRygxoHCkqHdJLrCOek4HLLRI1btYW1b1
         XB5yEUt18Lkh2sEmpXzG4k4HPwL5O8zsFl71hEVk4Xuusji+MvOdbCFJNiVoIy92bi+F
         zqyA==
X-Gm-Message-State: AOJu0Yy8wGyXTSD4dASgDj4B78frcESDdS44jNgwYlsrsgeGN5EXLC3k
	K7jcaouJLlfPf24jP0cymM+yk3+XCqgSk6I7zN9yvHlme6tKKJKOjinKnRpIKfffcuM+Jj0V96Q
	3
X-Google-Smtp-Source: AGHT+IHvPpPzcrb0lUBDSax49vJfiwmpg4bcdXFGbq9VBjNV+v6pTcxzcDKaYj+n1cWbedmcLQulnA==
X-Received: by 2002:a5d:6dac:0:b0:374:c847:85c with SMTP id ffacd0b85a97d-37d3aa54328mr457325f8f.24.1728442657082;
        Tue, 08 Oct 2024 19:57:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55f98b4sm368843a91.1.2024.10.08.19.57.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 19:57:36 -0700 (PDT)
Message-ID: <2d57fa56-6e92-42a0-bab2-9d10df75c002@suse.com>
Date: Wed, 9 Oct 2024 13:27:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: allow buffered write to skip full page if it's
 sector aligned
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1727833878.git.wqu@suse.com>
 <ac2639ec4e9ac176d33e95ef7ecf008fa6be5461.1727833878.git.wqu@suse.com>
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
In-Reply-To: <ac2639ec4e9ac176d33e95ef7ecf008fa6be5461.1727833878.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/2 11:22, Qu Wenruo 写道:
> [BUG]
> Since the support of sector size < page size for btrfs, test case
> generic/563 fails with 4K sector size and 64K page size:
> 
>      --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
>      +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
>      @@ -3,7 +3,8 @@
>       read is in range
>       write is in range
>       write -> read/write
>      -read is in range
>      +read has value of 8388608
>      +read is NOT in range -33792 .. 33792
>       write is in range
>      ...
> 
> [CAUSE]
> The test case creates a 8MiB file, then buffered write into the 8MiB
> using 4K block size, to overwrite the whole file.
> 
> On 4K page sized systems, since the write range covers the full sector and
> page, btrfs will no bother reading the page, just like what XFS and EXT4
> do.
> 
> But 64K page sized systems, although the write is sector aligned, it's
> not page aligned, thus btrfs still goes the full page alignment check,
> and read the full page out.
> 
> This causes extra data read, and fail the test case.
> 
> [FIX]
> To skip the full page read, we need to do the following modification:
> 
> - Do not trigger full page read as long as the buffered write is sector
>    aligned
>    This is pretty simple by modifying the check inside
>    prepare_uptodate_page().
> 
> - Skip already uptodate sectors during full page read
>    Or we can lead to the following data corruption:
> 
>    0       32K        64K
>    |///////|          |
> 
>    Where the file range [0, 32K) is dirtied by buffered write, the
>    remaining range [32K, 64K) is not.
> 
>    When reading the full page, since [0,32K) is only dirtied but not
>    written back, there is no data extent map for it, but a hole covering
>    [0, 64k).
> 
>    If we continue reading the full page range [0, 64K), the dirtied range
>    will be filled with 0 (since there is only a hole covering the whole
>    range).
>    This causes the dirtied range to get lost.

After more testing, this patch seems to cause generic/095 to hang, 
caused by some folio not being proper unlocked.

I'll dig deeper to find out why this is happening.

Thanks,
Qu
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 6 ++++++
>   fs/btrfs/file.c      | 5 +++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 09eb8a204375..ea118c89e365 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -981,6 +981,12 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>   			end_folio_read(folio, true, cur, end - cur + 1);
>   			break;
>   		}
> +
> +		if (btrfs_folio_test_uptodate(fs_info, folio, cur, blocksize)) {
> +			end_folio_read(folio, true, cur, blocksize);
> +			continue;
> +		}
> +
>   		em = __get_extent_map(inode, folio, cur, end - cur + 1,
>   				      em_cached);
>   		if (IS_ERR(em)) {
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index fe4c3b31447a..64e28ebd2d0b 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -860,6 +860,7 @@ static int prepare_uptodate_page(struct inode *inode,
>   				 struct page *page, u64 pos,
>   				 u64 len, bool force_uptodate)
>   {
> +	const u32 sectorsize = inode_to_fs_info(inode)->sectorsize;
>   	struct folio *folio = page_folio(page);
>   	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
>   	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
> @@ -869,8 +870,8 @@ static int prepare_uptodate_page(struct inode *inode,
>   		return 0;
>   
>   	if (!force_uptodate &&
> -	    IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> -	    IS_ALIGNED(clamp_end, PAGE_SIZE))
> +	    IS_ALIGNED(clamp_start, sectorsize) &&
> +	    IS_ALIGNED(clamp_end, sectorsize))
>   		return 0;
>   
>   	ret = btrfs_read_folio(NULL, folio);


