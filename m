Return-Path: <linux-btrfs+bounces-7777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 937E396952F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CB81F2314A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF71D6DBE;
	Tue,  3 Sep 2024 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoCeQP+W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB091D6C48
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348038; cv=none; b=Hwg4sYR23nlXqbBryivD+FfJgeBr7Yh7cRqcWIzKrTbkF0m1ZUWYGysNpXU+ViOdIt4Peu/DpLOiF5Fgc+K1wnstheRluIUJqRRAGpuTKSSV+ynFVjugzjJaBytSiMYw4Vl7Sq+Jbsv8DaF1WsTzvPErXq41IOlvNYqqjGw71Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348038; c=relaxed/simple;
	bh=Dh+Y5RnUC1acyrePKj1OiD8OQeoYFglx5Z2fviM5Oe4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GfatKrEM9efoELB1r4eqyptCkuA/uunCjbFwvEOzp4Ncb+ZQcyP7DpAROkRYcLqkayde/NKKSjZ8+H2+/1x7rRpUJjBk3F1Y/rQDy5dwzYHJp0q/wmv+qbGyf8TF3L/uNRm0tCbswNs92mY0Ktr5Yxpo0xbYswReLjk615l4y7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AoCeQP+W; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374bd0da617so1832821f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2024 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725348035; x=1725952835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tgydl411XV0GHNTNhIuJpRszm0V4/PpAX17857ckjtE=;
        b=AoCeQP+W1eWQEOyp2O5K5YoKEGmAdIwWPgDW0qYBOj/BM5Fal6+l//PJLPIsuy4QgB
         IMGFmd90cHql8TKqltsC/bvYBL/2QfikbNPCYPfI79OCfjSid9hB8+rI+l4GT81qeACx
         XmER5DztULuoSjsY8e3w+cNlUhfRJNjEkDOuoLW/61uveINNiT6Lb11weTLe3GjW6LV9
         RYHXUri4dNrqjEgLgEHjIrfKSZ63poFsKnuJpPcnCEqe0h6dsZJfzVTie13XbBioQv1B
         8AvoPC0MGoYNzwgPlIZDV5shEyD5D0hp+HqX0yVDzaiZu5XEhNGROYJvKrB6UQwsbTAa
         y/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348035; x=1725952835;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tgydl411XV0GHNTNhIuJpRszm0V4/PpAX17857ckjtE=;
        b=skbJGzyn5pDuxYVbfGKPUVzsA2OPeqo2A4AKa/aYnn/jXUhU0qSTbY4TWdClXCR686
         52X7htcKaB1xVqzFcTMLxOVO60fHVDhBiSIF6P+sZzJu5NUHXB9SBE27DVwKEH4Q56T8
         SLP9WMCXh5DJJxkZSgcMpZqrEkmX0QXAmjuqsojwKagnsK4MA1iymHXvjWOT7T9wMI2g
         T6aA8+Pcdhl1cGZkEs6tIGLzFaVu16jLomzBM8oJ2qEtlRsbalBpt10ZHToWzhiGCRDa
         i53C+CoxoFrbCFPEUkm4Kb275hJljIYUbAh0Nui3SJPJJkdE2eTaFqjXj9u1w4sIxXpB
         wmLg==
X-Gm-Message-State: AOJu0Yw8wwX4RzPsSuuEaXHUmWo0VZ5fQ1AzbFY4HXCPhaVPHDfPh2Wf
	PRO+w9vBtT3uqPORNUel6PSJNWnQI8vhdgpsFrKkjt06bXGPvvs1kAiQNmXS40CtiwnVtrFLeO+
	l
X-Google-Smtp-Source: AGHT+IFDrj7LvPZDgcO3uazbpPDVkp15Y/6Qure0A0sqdazAUkfkMpYP+WP7PcZUkJ5EoQ6bskA/Ug==
X-Received: by 2002:adf:e5cb:0:b0:368:526d:41d8 with SMTP id ffacd0b85a97d-374bceb003fmr6874781f8f.23.1725348034451;
        Tue, 03 Sep 2024 00:20:34 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d89b12f585sm5975143a91.41.2024.09.03.00.20.33
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 00:20:33 -0700 (PDT)
Message-ID: <8ee7ab1f-3555-4dc5-b08a-fc5e6d490d8d@suse.com>
Date: Tue, 3 Sep 2024 16:50:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: convert: fix inline extent size for symbol
 link
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <08ff5d66302e6b84481fda9d50d53bb50a519fd3.1725329062.git.wqu@suse.com>
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
In-Reply-To: <08ff5d66302e6b84481fda9d50d53bb50a519fd3.1725329062.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Please drop this one.

There is a bigger problem which can cause kernel rejecting to read a 
symbol link, exposed by random btrfs/125 failure.

So this will be updated to be included in a larger series instead, with 
better error description.

Thanks,
Qu

在 2024/9/3 11:34, Qu Wenruo 写道:
> [BUG]
> For btrfs converted from ext* or reiserfs, the inlined data extent is
> always one byte larger than the inode size:
> 
> 	item 10 key (267 INODE_ITEM 0) itemoff 15543 itemsize 160
> 		generation 1 transid 1 size 4 nbytes 5
> 		block group 0 mode 120777 links 1 uid 0 gid 0 rdev 0
> 		sequence 0 flags 0x0(none)
> 	item 11 key (267 INODE_REF 256) itemoff 15529 itemsize 14
> 		index 3 namelen 4 name: path
> 	item 12 key (267 EXTENT_DATA 0) itemoff 15503 itemsize 26
> 		generation 4 type 0 (inline)
> 		inline extent data size 5 ram_bytes 5 compression 0 (none)
> 
> [CAUSE]
> Inside the symbol link creation path for each fs, they all create the
> inline data extent with a tailing NUL ('\0').
> 
> This is different from what btrfs kernel module does:
> 
> 	item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
> 		generation 9 transid 9 size 4 nbytes 4
> 		block group 0 mode 120777 links 1 uid 0 gid 0 rdev 0
> 		sequence 0 flags 0x0(none)
> 	item 5 key (257 INODE_REF 256) itemoff 15869 itemsize 14
> 		index 2 namelen 4 name: path
> 	item 6 key (257 EXTENT_DATA 0) itemoff 15844 itemsize 25
> 		generation 9 type 0 (inline)
> 		inline extent data size 4 ram_bytes 4 compression 0 (none)
> 
> [FIX]
> Thankfully this is not a big deal, kernel properly reads the content and
> use inode size to determine the proper link target.
> 
> Just align the btrfs-progs convert behavior to the kernel one.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   convert/source-ext2.c     | 4 ++--
>   convert/source-reiserfs.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/convert/source-ext2.c b/convert/source-ext2.c
> index acba5db7ee81..d5d6b165a62d 100644
> --- a/convert/source-ext2.c
> +++ b/convert/source-ext2.c
> @@ -489,8 +489,8 @@ static int ext2_create_symlink(struct btrfs_trans_handle *trans,
>   	pathname = (char *)&(ext2_inode->i_block[0]);
>   	BUG_ON(pathname[inode_size] != 0);
>   	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
> -					 pathname, inode_size + 1);
> -	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size + 1);
> +					 pathname, inode_size);
> +	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size);
>   	return ret;
>   }
>   
> diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
> index 3edc72ed08a5..e2f07bfda188 100644
> --- a/convert/source-reiserfs.c
> +++ b/convert/source-reiserfs.c
> @@ -538,8 +538,8 @@ static int reiserfs_copy_symlink(struct btrfs_trans_handle *trans,
>   	len = get_ih_item_len(tp_item_head(&path));
>   
>   	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
> -					 symlink, len + 1);
> -	btrfs_set_stack_inode_nbytes(btrfs_inode, len + 1);
> +					 symlink, len);
> +	btrfs_set_stack_inode_nbytes(btrfs_inode, len);
>   fail:
>   	pathrelse(&path);
>   	return ret;

