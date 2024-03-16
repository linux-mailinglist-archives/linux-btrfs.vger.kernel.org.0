Return-Path: <linux-btrfs+bounces-3334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E1487D7F8
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 03:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA19B21C62
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Mar 2024 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F046BA;
	Sat, 16 Mar 2024 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZxjyeEMG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E261859
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Mar 2024 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710555704; cv=none; b=MOGZ6JrlT96+fOmzW3bpuZt9f6DrPnUzKXbbYQjHOD4x9MspJZlUZfJ0rh9gmt97FwzqSgsKkPdfkjHN21kdLlO0iks5ZSeKJNnTzr8kQM5umgTKL2IF5w36ry7r4C3Jy62lzzXcS129rPEs9q08KuNVqV2BGucKuIVwfkCPFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710555704; c=relaxed/simple;
	bh=f5AsLN5dJJnjEpufB2wO5bFR3D2nwJumh7e1n6boCCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1KgJDjeFBXzOMWTOGBih9G4ekZOV53j/4SFgGCrQ5i8Cy4it+H4a1603Dq8EOR4drvjgCKd0bzZaU/xGO4KevJb+LnbWAaynvH98NwO5TJSwiyrOHjdFhk5P4MnPRqogpCkuw1eO9oiRYOvvA2PQ6xWukaioQbE4tgjOMVDpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZxjyeEMG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d46c2e8dd7so34401461fa.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 19:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710555700; x=1711160500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJPbyhhd4spfaEVEn7atbFHsNQ7PWuy+P7v5H5IJWOw=;
        b=ZxjyeEMGpMbRATrcaTLNEdO5+BXuqn37LUy+1znd7X0e+8Tn4jqlRJq4xnKr/mNUK2
         cqUsY7Tiys3TNzc1JZPSFBlUAq7NHoVXqXnePyiS4onis5HOTjzo5TuvOR/wTW60cve2
         jkB1nphkn5uXok3Qb07aXKU+AZ0qgAaWv3yapcsh5apDgKlEIXdbm44dRuEf+E/9tNb2
         zPefA6v//ZliPxZ08bbLSkxrh9evKWZ2n48Xrfs3JcEzL1pMyYZQJ9q0kFnj0Dm2O7eV
         GadKRBxVaC6Pk0u3PLENYsJiVdLZx4F0gRcRYbV2HPS+EzI/Y/C26EwEDYVTGyeSo9mw
         3uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710555700; x=1711160500;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJPbyhhd4spfaEVEn7atbFHsNQ7PWuy+P7v5H5IJWOw=;
        b=SgCZa3NNhdRjU3OEPhUMF0DoiejY6z/6SChaO5Du/ZnlNgNLiBorvZa1opiytkmLv6
         ol4ZqtE0NbmpbMImVxzrTMzl0rSWTFFfxLORozvd1Pr2qOqlqY7cXc48kzx1LWsyp/CS
         4bOG7YdUbcZmiR39f7NhmSlc/FtVx7BmKa9OihuCfA97e6mOKZRlUjM9xeISJNxl0E9+
         ChNNEgy6L4PVR60A3ejjHS6RzFTeMdYMYbbjKmxRBeUyJXWoFxbd4uucB9nmsZChbev1
         1CYXoJG2Y1dNyXmPXwf0xUELiKAm0YhdLlt6o7RfOf9Cr4qBMGy3aao67qFrv5VNKqzH
         XAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVs+wIak1Ssjl+9CcrOqYy2uNoY0NIFNNajRJmT+DVVCL6qLf8UIWkMUTkSPruaQUhZ4q+1Oc5WMlltHQQgRNNZjALfVBrV1DkONAM=
X-Gm-Message-State: AOJu0YypY3ZeSSMaMMJKS1lizw1ml2XVobw52KwLNhbKDFWBJ1i6K24Z
	ED8+8mCO4w7UV68HUYbfpIaOuosXiFEFAcaRCIwznBEokWUFgfVYLZqwDkUaPyU=
X-Google-Smtp-Source: AGHT+IHHbkkeyZAOXwXLmDRKqVXt5cjt2jxWgX03Mg4kFWBOq93PSBVllMLcsvKbbMJFvLiuFpE9dg==
X-Received: by 2002:a2e:7217:0:b0:2d4:4b13:3413 with SMTP id n23-20020a2e7217000000b002d44b133413mr2820808ljc.22.1710555700178;
        Fri, 15 Mar 2024 19:21:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id s68-20020a637747000000b005b458aa0541sm3088443pgc.15.2024.03.15.19.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 19:21:39 -0700 (PDT)
Message-ID: <1eaab597-5cd5-418e-b4b7-304a85dfa935@suse.com>
Date: Sat, 16 Mar 2024 12:51:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix race in read_extent_buffer_pages()
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>, linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-kernel@vger.kernel.org
References: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
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
In-Reply-To: <1ca6e688950ee82b1526bb3098852af99b75e6ba.1710551459.git.tavianator@tavianator.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/16 11:44, Tavian Barnes 写道:
> To prevent concurrent reads for the same extent buffer,
> read_extent_buffer_pages() performs these checks:
> 
>      /* (1) */
>      if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
>          return 0;
> 
>      /* (2) */
>      if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
>          goto done;
> 
> At this point, it seems safe to start the actual read operation. Once
> that completes, end_bbio_meta_read() does
> 
>      /* (3) */
>      set_extent_buffer_uptodate(eb);
> 
>      /* (4) */
>      clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> 
> Normally, this is enough to ensure only one read happens, and all other
> callers wait for it to finish before returning.  Unfortunately, there is
> a racey interleaving:
> 
>      Thread A | Thread B | Thread C
>      ---------+----------+---------
>         (1)   |          |
>               |    (1)   |
>         (2)   |          |
>         (3)   |          |
>         (4)   |          |
>               |    (2)   |
>               |          |    (1)
> 
> When this happens, thread B kicks of an unnecessary read. Worse, thread
> C will see UPTODATE set and return immediately, while the read from
> thread B is still in progress.  This race could result in tree-checker
> errors like this as the extent buffer is concurrently modified:
> 
>      BTRFS critical (device dm-0): corrupted node, root=256
>      block=8550954455682405139 owner mismatch, have 11858205567642294356
>      expect [256, 18446744073709551360]
> 
> Fix it by testing UPTODATE again after setting the READING bit, and if
> it's been set, skip the unnecessary read.
> 
> Fixes: d7172f52e993 ("btrfs: use per-buffer locking for extent_buffer reading")
> Link: https://lore.kernel.org/linux-btrfs/CAHk-=whNdMaN9ntZ47XRKP6DBes2E5w7fi-0U3H2+PS18p+Pzw@mail.gmail.com/
> Link: https://lore.kernel.org/linux-btrfs/f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com/
> Link: https://lore.kernel.org/linux-btrfs/c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com/
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7441245b1ceb..61594eaf1f89 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4333,6 +4333,19 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
>   		goto done;
>   
> +	/*
> +	 * Between the initial test_bit(EXTENT_BUFFER_UPTODATE) and the above
> +	 * test_and_set_bit(EXTENT_BUFFER_READING), someone else could have
> +	 * started and finished reading the same eb.  In this case, UPTODATE
> +	 * will now be set, and we shouldn't read it in again.
> +	 */
> +	if (unlikely(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))) {
> +		clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> +		smp_mb__after_atomic();
> +		wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
> +		return 0;
> +	}
> +
>   	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
>   	eb->read_mirror = 0;
>   	check_buffer_tree_ref(eb);

