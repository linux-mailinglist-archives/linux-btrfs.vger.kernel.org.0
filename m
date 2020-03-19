Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6481518B776
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCSNdi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 09:33:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54185 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgCSNdd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 09:33:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so2391557wmk.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Mar 2020 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tvBrXxXrCIqZ/kKzXu4RSDPHGxtfuwffdw7Uz5yeOvw=;
        b=MBlxfDZVPeiFd87KVhx9kV1/aXk6L5CQZMyKwQa8g8EJHUQn0sfm1OzRXjpmvkHDmT
         LDrwqdTqihGwoLmeok10/x0RrAWi35dZr/4aEIBj6jfUe23z59KAZKakhOSHHosCaHEv
         3BcT40djmoGoikT9RdFEw8AQ/HwZkjfC8JBLknhIu56XQVSmI8fIh0Fvc7LENDfZ7e7L
         lDu8IDXEiEMecT/sVH1LZOPQrE4lLgoy6Pj/WNkG48oU6GYTL0QeoRmOWU/VpKAsIwB6
         K8CUO3PFqbB4upVEjZOA6BShaB4jy/zI3vFqi8f0AYFXJy2l7spveqGLOQ/Aj0Woy1L/
         E6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tvBrXxXrCIqZ/kKzXu4RSDPHGxtfuwffdw7Uz5yeOvw=;
        b=bH5Ji91HTeVR5sWODbfjFM4aMqHULzmRmw8bxvoLAjObiqq1eImu354ffrdyCUdqKF
         yMG4a+6AkEqZnGFBQPwItjkAiPVzVQY93swbN7VzILVXZpL4dneee838JxXiG3wpa9zT
         J+UwDH7R7d5rL7lGLOmBdBJSGK5VsEgwkAq2fzPuT5MesWLXQEldkaynbrXIg8YabgcQ
         b9oboCPgvUFkXYi7CwQm/2+TKGwY6s0f2zDA4gkgs7+34S4i6tnSt4Rm3QIdpmckR+qw
         FyvUF7NVq3orhKev4c1E4i0TvLn6BKBowusP71SVY3VVf6CCsBLT7QeC7sftfEstyw19
         Ktnw==
X-Gm-Message-State: ANhLgQ3DFMhANpPCDnmkrhr/9rSuBhPVdwcshvB8gIEl+eSxobD/wapF
        +QrJkloxsUcrriHjg8NSsZ1iYEvs7qM=
X-Google-Smtp-Source: ADFU+vuJuOKctzyc1HgDnU+EzJ5ZGKZr+KtBje5t53vuqfGj0ibjmRlxhdCdvLE8MggwNcUC8Bj/zw==
X-Received: by 2002:a1c:7ec9:: with SMTP id z192mr3839121wmc.100.1584624810254;
        Thu, 19 Mar 2020 06:33:30 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id w1sm3028692wmc.11.2020.03.19.06.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 06:33:29 -0700 (PDT)
Subject: Re: [PATCH 2/2] uboot: fs/btrfs: Fix LZO false decompression error
 caused by pending zero
To:     Qu Wenruo <wqu@suse.com>, u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org
References: <20200319123006.37578-1-wqu@suse.com>
 <20200319123006.37578-3-wqu@suse.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <49c5af50-8c09-9b49-ab44-ebe5eb9a652c@gmail.com>
Date:   Thu, 19 Mar 2020 14:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319123006.37578-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

On 19/03/2020 13:30, Qu Wenruo wrote:
> [BUG]
> For certain btrfs files with compressed file extent, uboot will fail to
> load it:
> 
>   btrfs_read_extent_reg: disk_bytenr=14229504 disk_len=73728 offset=0 nr_bytes=131
>   072
>   decompress_lzo: tot_len=70770
>   decompress_lzo: in_len=1389
>   decompress_lzo: in_len=2400
>   decompress_lzo: in_len=3002
>   decompress_lzo: in_len=1379
>   decompress_lzo: in_len=88539136
>   decompress_lzo: header error, in_len=88539136 clen=65534 tot_len=62580
> 
> NOTE: except the last line, all other lines are debug output.
> 
> [CAUSE]
> Btrfs lzo compression uses its own format to record compressed size
> (segmant header, LE32).
> 
> However to make decompression easier, we never put such segment header
> across page boundary.
> 
> In above case, the xxd dump of the lzo compressed data looks like this:
> 
> 00001fe0: 4cdc 02fc 0bfd 02c0 dc02 0d13 0100 0001  L...............
> 00001ff0: 0000 0008 0300 0000 0000 0011 0000|0000  ................
> 00002000: 4705 0000 0001 cc02 0000 0000 0000 1e01  G...............
> 
> '|' is the "expected" segment header start position.
> 
> But in that page, there are only 2 bytes left, can't contain the 4 bytes
> segment header.
> 
> So btrfs compression will skip that 2 bytes, put the segment header in
> next page directly.
> 
> Uboot doesn't have such check, and read the header with 2 bytes offset,
> result 0x05470000 (88539136), other than the expected result
> 0x00000547 (1351), resulting above error.
> 
> [FIX]
> Follow the btrfs-progs restore implementation, by introducing tot_in to
> record total processed bytes (including headers), and do proper page
> boundary skip to fix it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4ef44ce11485..2a6ac8bb1029 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -9,6 +9,7 @@
>  #include <malloc.h>
>  #include <linux/lzo.h>
>  #include <linux/zstd.h>
> +#include <linux/compat.h>
>  #include <u-boot/zlib.h>
>  #include <asm/unaligned.h>
>  
> @@ -17,6 +18,7 @@
>  static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
>  {
>  	u32 tot_len, in_len, res;
> +	u32 tot_in = 0;
>  	size_t out_len;
>  	int ret;
>  
> @@ -27,6 +29,7 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
>  	cbuf += LZO_LEN;
>  	clen -= LZO_LEN;
>  	tot_len -= LZO_LEN;
> +	tot_in += LZO_LEN;
>  
>  	if (tot_len == 0 && dlen)
>  		return -1;
> @@ -36,6 +39,9 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
>  	res = 0;
>  
>  	while (tot_len > LZO_LEN) {
> +		size_t mod_page;
> +		size_t rem_page;
> +
>  		in_len = le32_to_cpu(get_unaligned((u32 *)cbuf));
>  		cbuf += LZO_LEN;
>  		clen -= LZO_LEN;
> @@ -44,6 +50,7 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
>  			return -1;
>  
>  		tot_len -= (LZO_LEN + in_len);
> +		tot_in += (LZO_LEN + in_len);
>  
>  		out_len = dlen;
>  		ret = lzo1x_decompress_safe(cbuf, in_len, dbuf, &out_len);
> @@ -56,6 +63,19 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
>  		dlen -= out_len;
>  
>  		res += out_len;
> +
> +		/*
> +		 * If the 4 bytes header does not fit to the rest of the page we
> +		 * have to move to next one, or we read some garbage.
> +		 */
> +		mod_page = tot_in % PAGE_SIZE;

in U-Boot we use 4K page sizes, but the OS could use another page size (16K or
64k). Would we need to adapt that code to reflect which page size is used on the
medium we want to access?

Regards,
Matthias

> +		rem_page = PAGE_SIZE - mod_page;
> +		if (rem_page < LZO_LEN) {
> +			cbuf += rem_page;
> +			tot_in += rem_page;
> +			clen -= rem_page;
> +			tot_len -= rem_page;
> +		}
>  	}
>  
>  	return res;
> 
