Return-Path: <linux-btrfs+bounces-5767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5290BD71
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 00:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73361F22316
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744CF1991B4;
	Mon, 17 Jun 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VNc0iDAN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4071225AE
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718662990; cv=none; b=VjV/kHV6eq7HfJ9rfK3OAKQ3LT8Bmri1alfkrn4co1oOWvDvmU1+0xr28pZqGDSlSzNnn1+HWHINxLnwVh4JM8bKDj2ilK+JrPWKKYNw59BPwHAA/+C3Ymeoy00Swgu5AqIemDVfBVX9vWucJAXGlZKrbXmmaEmcOwFTcRXtBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718662990; c=relaxed/simple;
	bh=InBp6nyB+kGqTEpnRhHDuT1Ns1jcV3l3Wv33qCU3eXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbUrfy9R4ObVTOFxJ1Y4PtK/zYwkv6u9kkRnPTfDb+GGcZcVIGwjA2OObB8mtm4S1GAZkrdhZ9s/1QIssEhfQ/MBxbiZPvuHFlyL8zRnKFgn3l1ekI/2qyzX7Tab8OPsTcYk2v0LzkJBLQqssbNo6YtvIa9ljkF4ssQMrUwquNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VNc0iDAN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so54321081fa.2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718662986; x=1719267786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LRHNSzfkySw8bdD6HMA6VwKW5sxTvCWdBzYMXFVS4Ag=;
        b=VNc0iDANr5g49JuxBsYKIDNbhr/6D1uyOZg5UTWOdmkTk7fIRfs9xwq/XCBsfQ4QiP
         jY+SM4qin8r34GTeNagNzBG/XNC6/Cv5mtkaoHqLvGI1XmQ9kePE1lNEjsipZbDHe+io
         t+yPuJ5E1BkhaVYgdM4eGIKYVFhYY91q36vef97zYojtRlrKejkW8tD/H+Gx5BHd5Pk3
         eq2T/csOPDp40hDtpT1d0ei4dM9t7SHhPFIxy9ZGLH2SqxPogEY1aSZmtSTDIfXFjEj4
         IfoIytqIFYIQlOpL/sFn4sZUFEgqmpQ0xmUdMnZ3TA4AOznkUekogr3gdRNzsK82EB9y
         hdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718662986; x=1719267786;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRHNSzfkySw8bdD6HMA6VwKW5sxTvCWdBzYMXFVS4Ag=;
        b=hzsH+OXDEo24CKF+TMIr9TA84RCSFMEqXtRfOxkagmi9Gp22oPdhw9lwzBf4uOFR+Q
         KgZ4YmIJ6tKmZQSVCFDBVKf7Q7IciZNKKRkx7f4Egr6GIRNO/F391CHAkR3apBCHkOOc
         f6qFdRvLoqAA6Avxxwhbg/6FmIQw30CUMlG0zc/4cnUtEcuAqtmvAPZ2gQU4VPr4by/8
         xU01R4NUefWr7pfWFlWkqS5JMidhEl8NApUTHZcpKjtz/BBiUr0detDuKVPvheZkWEBb
         Tt+XMfHmRUGL49mFJLhTJ6HbXT+qTpcWZZ6vvqdUO7padwQHenqTy/8VGMQffQXihsw4
         bGjA==
X-Forwarded-Encrypted: i=1; AJvYcCV4br+PV+APXnlZ8v12vJRVTN4Pg7CnHb9qcB1QBH5UbQAz70NELhaQRSEWJi58zuxzPuUpiLJMdYv6gsMDpptYfyt3bBxbOCfOgyU=
X-Gm-Message-State: AOJu0YypyZ4a/gMjW/uflzk8w+RJO4vwWnfkHMyd7U5/wjw0ADTDtM2/
	VdVJ6tsTGKaKwE92gmlRtdiYgj6BO7UQiTSWVwmmfVU/4+1IeCa95g7MOl/h5v8=
X-Google-Smtp-Source: AGHT+IF8VNtBjxICmjpXxFoPDOl8Te3nEdwgAXg4I4e8LrCs9ZDE+Z9fWKtm9TCXHYFb95NQApkVPA==
X-Received: by 2002:a2e:3805:0:b0:2eb:ef0e:3f5 with SMTP id 38308e7fff4ca-2ec0e46dee9mr66382631fa.18.1718662985922;
        Mon, 17 Jun 2024 15:23:05 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f185a8sm84312475ad.235.2024.06.17.15.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 15:23:05 -0700 (PDT)
Message-ID: <ffa17a61-7f00-4f10-a80c-3d94457be23f@suse.com>
Date: Tue, 18 Jun 2024 07:52:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: btrfs: fix out of bounds write
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
References: <20240617194947.1928008-1-alexthreed@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <20240617194947.1928008-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/18 05:19, Alex Shumsky 写道:
> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> 
>   fs/btrfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4691612eda..b51f578b49 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -640,7 +640,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
>   	extent_type = btrfs_file_extent_type(leaf, fi);
>   	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>   		ret = btrfs_read_extent_inline(path, fi, buf);
> -		memcpy(dest, buf + page_off, min(page_len, ret));
> +		memcpy(dest, buf + page_off, min(min(page_len, ret), len));
>   		free(buf);
>   		return len;
>   	}
> @@ -652,7 +652,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
>   		free(buf);
>   		return ret;
>   	}
> -	memcpy(dest, buf + page_off, page_len);
> +	memcpy(dest, buf + page_off, min(page_len, len));
>   	free(buf);
>   	return len;
>   }

