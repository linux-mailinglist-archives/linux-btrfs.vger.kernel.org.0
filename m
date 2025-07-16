Return-Path: <linux-btrfs+bounces-15512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA78FB06AF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 02:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D944E7B414F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 00:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982E721ABB7;
	Wed, 16 Jul 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KJPKw71X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E31428E7
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627440; cv=none; b=Iu9YbcG06Vrh+q+XgAcWYOyqyfHt6A0JcFGNeCMEd3hRM7LKMOz0U6qkpKmwZ+ZaUzJ10IGiimsNZpNLvov0NGOfb9g9vbchemk3hTFYtyWrO0ub0OBeXCt29FJnUbrWHk1zfaQfZmyPP8ulV6JCswETzJrOdII2TqjjN45nriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627440; c=relaxed/simple;
	bh=DnkgAXwceu4ogzX9h4y+PJ+cCWlhlR7NXhfTMcsrSIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fS/5V2qZWc+90cY2wnZ1AJKGSV2oJpQfFXhTtUZ1rqTyGdgWvIsJDxrNcwemt21h0CsM2BTmfwvCwtsdsrK8paNaPhv8jdEHVUVeIgslMu0oGyodQZwp1vwu5O2nw5pEY1pHHVEv+oK4M3qp/q6VqKXj2k7l4awucxvh4uWhBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KJPKw71X; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso4731420f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752627436; x=1753232236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KacZvyW/+D5c+CkKTBWmhK+loj5fkAU60jNANOTBA8M=;
        b=KJPKw71XX4J5Y/umUZ51FKNB0noehXPX30hHj6yhZn8nl3DB2MsUI/JVdkahVsYGqK
         u/SBo3kEiv7dGJXC3xYtZpQ3hsCF0kAG4kXb+tG6057PDDnkGE8cVUukUJnLpkjpfVAk
         2rxXKSHAfT3jO+7di160ASV04HNDKMYLCO2ZTUtVZwgkl2hAIbXHuC2zT684p4tVQZ9f
         A7uGpWOVyfqc/uJZENza7++ezYU7mZylTjXAQO8jhjXZRZUPMyIdfagi29e1OBn5SikR
         4gZf7SnyBWvzWBdZ8vZoDn8pJimoPPqtc4GVatn+qbp/8v97OzVOO+2dRpZ53FsdFfTa
         CMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627436; x=1753232236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KacZvyW/+D5c+CkKTBWmhK+loj5fkAU60jNANOTBA8M=;
        b=cQfK63yHND1jlTN3dwWFYDuZ+tYcoudmMIkJ5BSaDP6R3/6GI+CHOMK6EfPdinSWrA
         sYUr6MlteUBroWckhofdzBGtwO+tae7j2NsATBQqodjvHOQ+otnUCHGn3/5TH8wzGCKr
         y2Kia1O8SIFM2Rj8IWtfA+0feXJO2e5nZjW54EE6OE149M97yaAJy7H5WJ4VPHJv+nFa
         k6Id3+V+Tbnwgxe7N8W6ubMQpQqoAKLpD9aiqWSuNj/9Va16kjDw3B1VJCx1uVGcUfR7
         AF6kDSqYCccfNT3rUJ1X3YcVZDDBFYgNszFrQe36QS8rFnzxxg9G1eemq7HTivGWgPWM
         Um5g==
X-Forwarded-Encrypted: i=1; AJvYcCXOb7LoJpezxc//Me014CoXkVX0QJiMbw0JlgQBbwxXtu8RgA1dcWqGlk+MFZzPIOrYHjAteo9gHRJClw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWc3GBA+jXPqTueDt7Xq/9ma/VU1f4fe0bX8BfJYmP08YD0JN3
	0XUmkEgPKurmUyDGTvl3ludNYXRRScWIgOH368C2J8UbvQRT3X032kKoTFBSzoAOJliSrjsqsDW
	afcqmfVQ=
X-Gm-Gg: ASbGncst4zPZVCt++dwxBTiiqIt/5lFPJeBJBRhsE4qFqOVNNYTNuLtgljQltt+cubM
	scBhsoPZQDnXXimnUR4CWOOZd9K+6tc+aDfnB2ZwfAIkzAPhepizeoI1o5Iy2MEe+G0AObGykoG
	CaYDQwojXyV0VljzEnbJGjA6y1mk3yaPZ1q62Q41OmXFnWP990TrYpdQwt3iOf76NkA/cUuYxqh
	OjlPl/nl48eZaPGZ5+jDgxLYtHk/n7Wxs5lIO6/K8eyLtb/l99BoFSTqIYyAimZDFbV701BWCo2
	Xfsa5Wbvk06zSVmtxU3QPz100fZLPMTcD/g/7ab85jwmf6YxB703+E34MN4sg1kNtmrL5AZBp+Z
	w8xOK5bLUStei648UTFRjde+NQmbjbNM0MUaW1Zm5/LAOTgopWQ==
X-Google-Smtp-Source: AGHT+IGmM0n20dxhtQ6vMPJL8jS+hYaNOO5Rpe4CXLe7RvspyCFw9ZMsMSHoEA6/McxI5CdSoNbUKg==
X-Received: by 2002:a05:6000:3ce:b0:3b6:d6d:dd2 with SMTP id ffacd0b85a97d-3b60e4cb532mr348001f8f.25.1752627436011;
        Tue, 15 Jul 2025 17:57:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332cdcsm114942995ad.145.2025.07.15.17.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 17:57:15 -0700 (PDT)
Message-ID: <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
Date: Wed, 16 Jul 2025 10:27:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/16 06:10, Matthew Wilcox 写道:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

I don't think it's the case for btrfs, unless your "fixed-size" means 
block size, and in that case, a single block won't be compressed at all...

In btrfs, we support compressing the plaintext from 2 blocks to 128KiB 
(the 128KiB limit is an artificial one).

> 
>  From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.

We don't. We just grab dirty pages up to 128KiB, and we can handle 
smaller ranges, as small as two blocks.

> 
> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.

Btrfs goes the scratch pages way. Decompression in-place looks a little 
tricky to me. E.g. what if there is only one compressed page, and it 
decompressed to 4 pages.

Won't the plaintext over-write the compressed data halfway?

> 
> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.

Btrfs is the later case.

All the decompression/compression routines all support swapping 
input/output buffer when one of them is full.
So kmap_local() is completely feasible.

Thanks,
Qu

> 
> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.
> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).
> 
> 


