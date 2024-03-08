Return-Path: <linux-btrfs+bounces-3087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AB875D2A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 05:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380B6283336
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 04:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04282D634;
	Fri,  8 Mar 2024 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZexE/kWd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23618E01
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Mar 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709872413; cv=none; b=ry/1inIwTyA1DM2H2s175aAKLjvTrPSVuFzlJByt2S/dtY7aupbJRHYiJjUD+AR2Mib6svQi0dDLXTDcMliJIN7EmHJ77oUtF5AjnCqSl8XdH1UrdXsleoQESn5IQGbAhOwt9eu1BjUK61qT7VHE/4zcU1C3WE27I3SVejB/uSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709872413; c=relaxed/simple;
	bh=029fh+3hAOYY2tIVmTfVGPdsZORHA6MMaY7PRNZSqKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fyi5cV6FGDsDyV2JDfmZmRQjnbj/aeJuQLZXxRGIF4NGNGElGD/1IETEmFzMIXyd3WpqFFG1gMOhUxIrKh1agPKXLHyjcK5102pPw0dwCsgVCBJmWmNT3IRAks94npJC6ykQ4HbT6I9WMlnBgnmciv3qQUMfy3JDBwuQjlSsMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZexE/kWd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ddd1624beso999883f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 20:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709872409; x=1710477209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ML1hSm7W3xpt/+xm5WMhnsIbuMRk206pmE0el+w1b1M=;
        b=ZexE/kWd0kImZf7pL8ZU1XhZeewTFYpAJxuR6zgn5rrYMpWVoFVQ2oAlJxalKlIhiz
         nJT2TCe3rh7WmNY3NkSVpoS6ZHh9NrSV8yzCUFxX2s1sfszV4HgkFPK99cGmzXgToiNw
         OYqvlSa7juOPe4JQL4P0G2TbUgArhBVVTczchRsTv7w+lPE8UQVW9w0Ow1sjSkv7hUYp
         2P3tZOxt7zOEy0XqAuP3J5C+qcl0oAelEt2SiUZpF/zmyqKuWQ5VoxqNUO7FxFhFoMHt
         6Vs4fapoL1fvWhk8es+TBj5iLAlR4lhZAo3CjBQS+qs1LjTL4FlHSIxkHlZ9vgMXZCuG
         563g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709872409; x=1710477209;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ML1hSm7W3xpt/+xm5WMhnsIbuMRk206pmE0el+w1b1M=;
        b=XmB9/ppR6MXyzBh+4ZuqdRretaBUI/GdbXKOQw7cEDPAiWBOS+prBvjZhlKEuXM5fC
         f3sw1GB1VPDxI++YE5fAlto10OkmBN2Xz7yGG8oXnBBIBUal0qhvs0nkzSxoSVxJVZN5
         gktGuD1IUWAmQ5QTbKu8pgk+rnzWowRuAkgJAhvVo7nkFj4O7mXfaHb3FLTo69xET12V
         ewBJyY/VPVpTYQcfNSCDS5GeeK+uOBG2yCqmJ0wKWWfk7tLVCVuIo/DIFGfvCiK80aoJ
         +p08kMmdgjsqFbJGx39UOYlIFFDCUeTb/ThFuwERu+1RstS3WXc6JxaZchIRZrEF9TeB
         BMCA==
X-Forwarded-Encrypted: i=1; AJvYcCVRPRhLZBV8HblKOwWnttA5QXsuFchdbfGVHO7jLvET2LKD6MDkEto2n3NQ1yEvD6h0e0q63PU6W42Rdj7I3CUlsI8GNv/TMuLLb8E=
X-Gm-Message-State: AOJu0YzTy9Z+hx5TyXNyZ6PFSM53BO9g3G1gbGaUPe81vUgPu8MO6vXF
	nFKrcYVRHbQw/THx2tp4258bNxpkN8YGzJXNslIC9jV2dv8I3yZMMxl44L++doc=
X-Google-Smtp-Source: AGHT+IHkhRTwleuh81xmEaKAaOpwE2OycqtekYGZdtvLr24mo5AmCjcoJKgNZ8BQ60W0Sv2o7CZ5iQ==
X-Received: by 2002:adf:a118:0:b0:33e:2409:8fb6 with SMTP id o24-20020adfa118000000b0033e24098fb6mr3283071wro.33.1709872409124;
        Thu, 07 Mar 2024 20:33:29 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902c71200b001d92a58330csm15456677plp.145.2024.03.07.20.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 20:33:28 -0800 (PST)
Message-ID: <daf46a99-708b-4784-a6d8-f8516afe1703@suse.com>
Date: Fri, 8 Mar 2024 15:03:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove pointless BUG_ON() when creating snapshot
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <0d0347a460b26e36966f95604ca8c69b956f1c62.1709814676.git.fdmanana@suse.com>
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
In-Reply-To: <0d0347a460b26e36966f95604ca8c69b956f1c62.1709814676.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/8 02:31, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When creating a snapshot we first check with btrfs_lookup_dir_item() if
> there is a name collision in the parent directory and then return an error
> if there's a collision. Then later on when trying to insert a dir item for
> the snapshot we BUG_ON() if the return value is -EEXIST or -EOVERFLOW:
> 
>    static noinline int create_pending_snapshot(...)
>    {
>       (...)
> 
>       /* check if there is a file/dir which has the same name. */
>       dir_item = btrfs_lookup_dir_item(...);
>       (...)
> 
>       ret = btrfs_insert_dir_item(...);
>       /* We have check then name at the beginning, so it is impossible. */
>       BUG_ON(ret == -EEXIST || ret == -EOVERFLOW);
>       if (ret) {
>          btrfs_abort_transaction(trans, ret);
>          goto fail;
>       }
> 
>       (...)
>    }
> 
> It's impossible to get the -EEXIST because we previously checked for a
> potential collision with btrfs_lookup_dir_item() and we know that after
> that no one could have added a colliding name because at this point the
> transaction is in its critical section, state TRANS_STATE_COMMIT_DOING,
> so no one can join this transaction to add a colliding name and neither
> can anyone start a new transaction to do that.
> 
> As for the -EOVERFLOW, that can't happen as long as we have the extended
> references feature enabled, which is a mkfs default for many years now.
> 
> In either case, the BUG_ON() is excessive as we can properly deal with
> any error and can abort the transaction and jump to the 'fail' label,
> in which case we'll also get the useful stack trace (just like a BUG_ON())
> from the abort if the error is either -EEXIST or -EOVERFLOW.
> 
> So remove the BUG_ON().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/transaction.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 46e8426adf4f..5b6536c1f6d1 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1864,8 +1864,6 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
>   	ret = btrfs_insert_dir_item(trans, &fname.disk_name,
>   				    BTRFS_I(parent_inode), &key, BTRFS_FT_DIR,
>   				    index);
> -	/* We have check then name at the beginning, so it is impossible. */
> -	BUG_ON(ret == -EEXIST || ret == -EOVERFLOW);
>   	if (ret) {
>   		btrfs_abort_transaction(trans, ret);
>   		goto fail;

