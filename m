Return-Path: <linux-btrfs+bounces-3636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6114688D085
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE134B218DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C681613D8AF;
	Tue, 26 Mar 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KBnhU6Kt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82A23CB
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490943; cv=none; b=FgQj08fHB8UCEUQ8nQjLk6Qk5pYEG7TA/IdEvOwzoVGwfk7xU3zwFnRZsx1G67bPEHBQ4fwrIeRKf0TU4CVeW6MFS306nOZc+bLNR7FdvdnX8BKcF92jMa+wdDxPhplr1P+qSucghGELL33amaMeu/YjBgVG1ToHKn2mVSdMYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490943; c=relaxed/simple;
	bh=DvF6pk9hDwTS27iL1PVDK3/kmbwn2POg0+gI6G8qKxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KqPaRGclY8IRefGj08xoAAz3yMYcJ/isLMBHKmv2QnFGvVLQILRhaQrfGzojEEE4gay2J/Itb9KdKxu8yY3NpPe28erTOlUygV3amSE5FL9NpFP39RnfBhH+dlN2qVgjkQS5ISZW6qLa9+Jx/LkWKsm7lVHifbnNV6Z7Y9l05lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KBnhU6Kt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so79824381fa.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711490938; x=1712095738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cUcUuY9rXqX6rNM38wPnKpLe4DL/k79KtRlPjBRYRtU=;
        b=KBnhU6KtB8Fm5VOyjRyMXMV2CTxZc/U7P0ngVjESEofwynjMRRWCjVTxn3hICGrm4Y
         /owjXZeahOFm2z+aFjdXrgztQTA0Pt1fwiT3r+RrsEHmPnYi2KOq+x6ZlKpbsmdOpbSL
         Vgjrz8sLBbFRK+InyvQtIS0hslfkfonUgkAs/n9nLgZveRNgjeJkeDrKFXbFE8kWhOym
         pKs1CcpX11QI9KuqRZEHLT0F5rq0BY/+C3sTqeP1y8T5ShuysIDp+Ue4+c+BWC8p0+ZM
         QIrOqhvsFwBztmN7jyMqQgEguLePC/PiT2VklnakxFWp2taGQthpd//weBnRaTi/S++R
         O7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711490938; x=1712095738;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUcUuY9rXqX6rNM38wPnKpLe4DL/k79KtRlPjBRYRtU=;
        b=lBTVRKw2rTemtGob8V78TMlnWM6FO53JYYwcibaGSddzR1w3ozRojx7ZV12fRwMhaz
         WDP//Bk+AITS6+oo7UAb//PGYPNAoWPKO08XiwvH+zhaTyMH5OBQ6nGtx+A8eUM/2Y6R
         i5YaZ+A+QanJYsDSID76pB0w75/BNEXnijN+WTasxwYrEtJK1tk2U2uTMa82oD4zxiK1
         kNU+NW4bFwzBl33xQNzd7fYb6xW3xUq0mPOuG4rhJA336qcrNRIHzHyrxwRitbgytUz1
         bhvRkj+Aya0S2arTQdxOUwpVUkef6Jm8CFeRIfC5xdyn97j90ABch5DumRc4GigyFjTN
         xflQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIbdyDPWh/gMrUZmTytBgYwYY9Nm23OBzAxb9lQcAsBr+lRwpcu7ly5jmUpMRttGQtolOOS5kwmz75Cwatsr5PA59EltvzJ4W7GS4=
X-Gm-Message-State: AOJu0YzISzteKlStf86TaiPHx9j6qY9D2doo54v+ii85PUuNE0xoVG/L
	1HjRMMU4A71vorn8XupHeALfTc9jb9Q4Pyoq5LuiNSBPZcZYwRurOtOaqEnghI0=
X-Google-Smtp-Source: AGHT+IGaclBWo8ynDn7GrJEwuze7XeSIMoCM1SToL8GaykUdjzXsV5QIoKPiiybCjTQMlxHMZ5yPpg==
X-Received: by 2002:a2e:3809:0:b0:2d4:71b9:4e3 with SMTP id f9-20020a2e3809000000b002d471b904e3mr6790235lja.51.1711490938276;
        Tue, 26 Mar 2024 15:08:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001e0b76bcfa5sm5225490plg.54.2024.03.26.15.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:08:57 -0700 (PDT)
Message-ID: <b88f00db-117e-43b6-ada6-4790c5030417@suse.com>
Date: Wed, 27 Mar 2024 08:38:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] btrfs: record delayed inode root in transaction
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1711488980.git.boris@bur.io>
 <cadc31b0278e4e362f71f7c57ebccb0c94af693b.1711488980.git.boris@bur.io>
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
In-Reply-To: <cadc31b0278e4e362f71f7c57ebccb0c94af693b.1711488980.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 08:09, Boris Burkov 写道:
> When running delayed inode updates, we do not record the inode's root in
> the transaction, but we do allocate PREALLOC and thus converted PERTRANS
> space for it. To be sure we free that PERTRANS meta rsv, we must ensure
> that we record the root in the transaction.
> 
> Fixes: 4f5427ccce5d ("btrfs: delayed-inode: Use new qgroup meta rsv for delayed inode and item")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just curious, do you have a case that hits this particular bug only?

Thanks,
Qu
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/delayed-inode.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index dd6f566a383f..121ab890bd05 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1133,6 +1133,9 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
>   	if (ret)
>   		return ret;
>   
> +	ret = btrfs_record_root_in_trans(trans, node->root);
> +	if (ret)
> +		return ret;
>   	ret = btrfs_update_delayed_inode(trans, node->root, path, node);
>   	return ret;
>   }

