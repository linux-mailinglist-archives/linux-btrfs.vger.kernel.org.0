Return-Path: <linux-btrfs+bounces-15979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F5B1FE76
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 07:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC6618983F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 05:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4634C269D06;
	Mon, 11 Aug 2025 05:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NzB1Uv9L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA161268C55
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889186; cv=none; b=ZitBCzuVtHhNN41TH8yMjhNXHWLTGDXNfWuUT7SHcHxmXVDg+UcbpNUg1ye9KIAhwUhJgph+M5cRsDnCU3fzuZmu+U8hdvqTzVHwo3JRwf2sljU4FZoLdRMxwvG1PAGXch/6quPrfoPkm1Epwx+YJ04MJrqd7UHu4UAVI2luAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889186; c=relaxed/simple;
	bh=PIwwitFtwncqFPfcdRZIKPpYKpLCCzKFD8DtmlOxBq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KODBe5vGJMd+MiSxezF9pCgaa+ZkqgHe/3i/bwftOfrsuldY7iKEw3UHZ4icp+cPpCv7zyIFhtrDjl6vRmGGbI0KNqisJHMmkhpYVI6UOPcGgYyrRXu0OaqGB6PLtDLUW8fDPAJJwnnXtZjc1AH5ZYkM/RoVBQIoHv3T3a2B/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NzB1Uv9L; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7825e2775so3501209f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Aug 2025 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754889182; x=1755493982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vb8TTR8hEV4g8/OZKd8Ib45/HtKzsxAgCrIb4ECPQpQ=;
        b=NzB1Uv9L5PFd1rtcSVRQGCP/Zlz74c+pwkC8wtRPqZE1YtWdlik3/q4RSY8Hsi+WOs
         n4FapK72H6NUwXG9Ju2woCOqgr2aVFUh3i0p0HleywAY2hJ7JTkauMeQYKJpIGfGWLww
         92fspJgl1KlEab89NKpn0eESY4XuSxHkPElSJOaAkslMc1IZKzgUkjEEHyKXWDFDTnFu
         WEksagMrTFmguDiZIH5MeL4/sZLjDVah/OJ0oko+9tZaRs5tmMZvoS2ygMPwlgf50tDt
         NdINdmGAhK7+MOmGfD/eK2V1UOfPEJbligaaWErshz9tr97zQ7MhVAboyHubrLzZvzXx
         enmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754889182; x=1755493982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb8TTR8hEV4g8/OZKd8Ib45/HtKzsxAgCrIb4ECPQpQ=;
        b=nbyu4zSmGd+3idgcvFT2L2EwvxE+GeZeJQq66oQXocII848kux89vNyQb1DxgGlYd2
         WNw53xkuBJ2APGM+W7JGJIg3zQ8nGeL7eKaUOu+JiFuU8L52ZQgBzINlZQ0LG4sJxuo6
         UWVOt3wefBcoA3CVMpmkg0F7opaOK4Ii2iRfj5crTAcEZ4AZFRGorUVK4UH5s2WTcE0R
         A5xJlu38hYMib7t8caZ6uW6rG6yzquXoj1WLqbj6Q/DflVCFvMHQHQ55Q5JA5qGwvTe/
         fQ8fW//ME9NT8J4wnrVFLHg6k62cff6W3vQrHASIK52lzwKzO8ItqjnYK2YdhtETUCXb
         US7w==
X-Forwarded-Encrypted: i=1; AJvYcCU7EweHs5eChIzgqulpGLTKMBF8nBOOmZ6UlihgQ3DQO8svmsaVueiGDVGlVpfJp6iXuFWYyYW4qHvxug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OJlYJirLUhX3zZ+wbx6nRWiP+5rg+vmwbsAybcdlu9HrhUn+
	huvpZZEwDz1I5qTpp3YWOyOMOyX3Y/TUIilCc8HgkVLf7j/ZHNFlqN4/H6eTRcqTgCc4TZYn7Br
	CZuVj
X-Gm-Gg: ASbGncv7U0ePtUV9/j4TmHWZ0KqV8Pu7/xPc2iLRQjniYkzIQlxME/Im1RTgJjdW1OP
	ItMM6L+bTR8jnN3phxtg+7S0VEwhWjLsi5FNoei2/ervdEd1b1FXyzkYNhTCSQAPfoGUM8PrXB4
	m52JLDUVGpKjyFyhT62qcpJyFZPvk1uB2cJauJO/PtJHnaKM4PZQu1C7rTYFcw3D4sT4C4pjHw3
	JwHF1rbR5jggr4X5M6lf43epXIYKY/EVsUxPydzjFZCFAnPekmmhvk0CaL15H1KutlvlAzCF9nW
	Zf2THLEsMjHrG/GvqAerLyVuhfplCB8M2vvPtrvY4gmUSCnGWHQjMKVK+qSDxOaFCQpGWxPt9BW
	H0JFVTC+H2Nk/CNGbpLYN4U7KV7oW4ryxfpYYLVGnU8FAv/zmjw==
X-Google-Smtp-Source: AGHT+IFKQD8ittXWrLC6YuswuaOnCmUXG2xzj+kqw3dWt9bjIcY4BtzEHfllyjeXwpMnr8JDTBP58w==
X-Received: by 2002:a05:6000:2484:b0:3b8:d337:cc12 with SMTP id ffacd0b85a97d-3b900b4d924mr8913434f8f.22.1754889181995;
        Sun, 10 Aug 2025 22:13:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm25810756b3a.47.2025.08.10.22.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:13:01 -0700 (PDT)
Message-ID: <c51f8f46-38e6-42e2-ad8c-7ee7538711d3@suse.com>
Date: Mon, 11 Aug 2025 14:42:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use blocksize to check if compression is making
 things larger
To: kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>
 <202508111239.5dVvTsGq-lkp@intel.com>
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
In-Reply-To: <202508111239.5dVvTsGq-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/11 14:30, kernel test robot 写道:
> Hi Qu,
> 
> kernel test robot noticed the following build errors:

That patch has an explicit dependency after the "---" line.

If there is a way to tell the bot for any dependency, I can definitely 
add such tag in the future.

Thanks,
Qu

> 
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on linus/master v6.17-rc1 next-20250808]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-use-blocksize-to-check-if-compression-is-making-things-larger/20250811-081450
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> patch link:    https://lore.kernel.org/r/14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu%40suse.com
> patch subject: [PATCH] btrfs: use blocksize to check if compression is making things larger
> config: riscv-randconfig-002-20250811 (https://download.01.org/0day-ci/archive/20250811/202508111239.5dVvTsGq-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 3769ce013be2879bf0b329c14a16f5cb766f26ce)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250811/202508111239.5dVvTsGq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508111239.5dVvTsGq-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> fs/btrfs/zstd.c:402:24: error: use of undeclared identifier 'inode'
>       402 |         const u32 blocksize = inode->root->fs_info->sectorsize;
>           |                               ^~~~~
>     1 error generated.
> --
>>> fs/btrfs/zlib.c:150:24: error: use of undeclared identifier 'inode'
>       150 |         const u32 blocksize = inode->root->fs_info->sectorsize;
>           |                               ^~~~~
>     1 error generated.
> 
> 
> vim +/inode +402 fs/btrfs/zstd.c
> 
>     386	
>     387	int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>     388				 u64 start, struct folio **folios, unsigned long *out_folios,
>     389				 unsigned long *total_in, unsigned long *total_out)
>     390	{
>     391		struct workspace *workspace = list_entry(ws, struct workspace, list);
>     392		zstd_cstream *stream;
>     393		int ret = 0;
>     394		int nr_folios = 0;
>     395		struct folio *in_folio = NULL;  /* The current folio to read. */
>     396		struct folio *out_folio = NULL; /* The current folio to write to. */
>     397		unsigned long tot_in = 0;
>     398		unsigned long tot_out = 0;
>     399		unsigned long len = *total_out;
>     400		const unsigned long nr_dest_folios = *out_folios;
>     401		const u64 orig_end = start + len;
>   > 402		const u32 blocksize = inode->root->fs_info->sectorsize;
>     403		unsigned long max_out = nr_dest_folios * PAGE_SIZE;
>     404		unsigned int cur_len;
>     405	
>     406		workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
>     407		*out_folios = 0;
>     408		*total_out = 0;
>     409		*total_in = 0;
>     410	
>     411		/* Initialize the stream */
>     412		stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
>     413				workspace->size);
>     414		if (unlikely(!stream)) {
>     415			struct btrfs_inode *inode = BTRFS_I(mapping->host);
>     416	
>     417			btrfs_err(inode->root->fs_info,
>     418		"zstd compression init level %d failed, root %llu inode %llu offset %llu",
>     419				  workspace->req_level, btrfs_root_id(inode->root),
>     420				  btrfs_ino(inode), start);
>     421			ret = -EIO;
>     422			goto out;
>     423		}
>     424	
>     425		/* map in the first page of input data */
>     426		ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
>     427		if (ret < 0)
>     428			goto out;
>     429		cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
>     430		workspace->in_buf.src = kmap_local_folio(in_folio, offset_in_folio(in_folio, start));
>     431		workspace->in_buf.pos = 0;
>     432		workspace->in_buf.size = cur_len;
>     433	
>     434		/* Allocate and map in the output buffer */
>     435		out_folio = btrfs_alloc_compr_folio();
>     436		if (out_folio == NULL) {
>     437			ret = -ENOMEM;
>     438			goto out;
>     439		}
>     440		folios[nr_folios++] = out_folio;
>     441		workspace->out_buf.dst = folio_address(out_folio);
>     442		workspace->out_buf.pos = 0;
>     443		workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
>     444	
>     445		while (1) {
>     446			size_t ret2;
>     447	
>     448			ret2 = zstd_compress_stream(stream, &workspace->out_buf,
>     449					&workspace->in_buf);
>     450			if (unlikely(zstd_is_error(ret2))) {
>     451				struct btrfs_inode *inode = BTRFS_I(mapping->host);
>     452	
>     453				btrfs_warn(inode->root->fs_info,
>     454	"zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
>     455					   workspace->req_level, zstd_get_error_code(ret2),
>     456					   btrfs_root_id(inode->root), btrfs_ino(inode),
>     457					   start);
>     458				ret = -EIO;
>     459				goto out;
>     460			}
>     461	
>     462			/* Check to see if we are making it bigger */
>     463			if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
>     464					tot_in + workspace->in_buf.pos <
>     465					tot_out + workspace->out_buf.pos) {
>     466				ret = -E2BIG;
>     467				goto out;
>     468			}
>     469	
>     470			/* We've reached the end of our output range */
>     471			if (workspace->out_buf.pos >= max_out) {
>     472				tot_out += workspace->out_buf.pos;
>     473				ret = -E2BIG;
>     474				goto out;
>     475			}
>     476	
>     477			/* Check if we need more output space */
>     478			if (workspace->out_buf.pos == workspace->out_buf.size) {
>     479				tot_out += PAGE_SIZE;
>     480				max_out -= PAGE_SIZE;
>     481				if (nr_folios == nr_dest_folios) {
>     482					ret = -E2BIG;
>     483					goto out;
>     484				}
>     485				out_folio = btrfs_alloc_compr_folio();
>     486				if (out_folio == NULL) {
>     487					ret = -ENOMEM;
>     488					goto out;
>     489				}
>     490				folios[nr_folios++] = out_folio;
>     491				workspace->out_buf.dst = folio_address(out_folio);
>     492				workspace->out_buf.pos = 0;
>     493				workspace->out_buf.size = min_t(size_t, max_out,
>     494								PAGE_SIZE);
>     495			}
>     496	
>     497			/* We've reached the end of the input */
>     498			if (workspace->in_buf.pos >= len) {
>     499				tot_in += workspace->in_buf.pos;
>     500				break;
>     501			}
>     502	
>     503			/* Check if we need more input */
>     504			if (workspace->in_buf.pos == workspace->in_buf.size) {
>     505				tot_in += workspace->in_buf.size;
>     506				kunmap_local(workspace->in_buf.src);
>     507				workspace->in_buf.src = NULL;
>     508				folio_put(in_folio);
>     509				start += cur_len;
>     510				len -= cur_len;
>     511				ret = btrfs_compress_filemap_get_folio(mapping, start, &in_folio);
>     512				if (ret < 0)
>     513					goto out;
>     514				cur_len = btrfs_calc_input_length(in_folio, orig_end, start);
>     515				workspace->in_buf.src = kmap_local_folio(in_folio,
>     516								 offset_in_folio(in_folio, start));
>     517				workspace->in_buf.pos = 0;
>     518				workspace->in_buf.size = cur_len;
>     519			}
>     520		}
>     521		while (1) {
>     522			size_t ret2;
>     523	
>     524			ret2 = zstd_end_stream(stream, &workspace->out_buf);
>     525			if (unlikely(zstd_is_error(ret2))) {
>     526				struct btrfs_inode *inode = BTRFS_I(mapping->host);
>     527	
>     528				btrfs_err(inode->root->fs_info,
>     529	"zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
>     530					  workspace->req_level, zstd_get_error_code(ret2),
>     531					  btrfs_root_id(inode->root), btrfs_ino(inode),
>     532					  start);
>     533				ret = -EIO;
>     534				goto out;
>     535			}
>     536			if (ret2 == 0) {
>     537				tot_out += workspace->out_buf.pos;
>     538				break;
>     539			}
>     540			if (workspace->out_buf.pos >= max_out) {
>     541				tot_out += workspace->out_buf.pos;
>     542				ret = -E2BIG;
>     543				goto out;
>     544			}
>     545	
>     546			tot_out += PAGE_SIZE;
>     547			max_out -= PAGE_SIZE;
>     548			if (nr_folios == nr_dest_folios) {
>     549				ret = -E2BIG;
>     550				goto out;
>     551			}
>     552			out_folio = btrfs_alloc_compr_folio();
>     553			if (out_folio == NULL) {
>     554				ret = -ENOMEM;
>     555				goto out;
>     556			}
>     557			folios[nr_folios++] = out_folio;
>     558			workspace->out_buf.dst = folio_address(out_folio);
>     559			workspace->out_buf.pos = 0;
>     560			workspace->out_buf.size = min_t(size_t, max_out, PAGE_SIZE);
>     561		}
>     562	
>     563		if (tot_out >= tot_in) {
>     564			ret = -E2BIG;
>     565			goto out;
>     566		}
>     567	
>     568		ret = 0;
>     569		*total_in = tot_in;
>     570		*total_out = tot_out;
>     571	out:
>     572		*out_folios = nr_folios;
>     573		if (workspace->in_buf.src) {
>     574			kunmap_local(workspace->in_buf.src);
>     575			folio_put(in_folio);
>     576		}
>     577		return ret;
>     578	}
>     579	
> 


