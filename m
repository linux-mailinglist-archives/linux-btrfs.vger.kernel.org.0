Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1B3CBA94
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 18:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhGPQdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhGPQdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 12:33:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB075C06175F
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 09:30:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o201so9346387pfd.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jul 2021 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WaDT2WvOJ0583ARuEixrBzHyp+fHS4lJW+SWnbkZ9yo=;
        b=sTYx+Ft13PLPQxsDSoR5Cu8QUIX3nqiUfLizIcJHjr+BCFH2vFHnuM4cfXQi96Qb/n
         iQu/FpP+fPlFC8pHBPNvYkRMuz7YACLTVSF6nGb8TNutcZ8I8EJj5Pqw60mH9xnUIxGp
         RgCVxDAYzxSbDfuZtT4T4G5xhvevFBvKksUeCJ/Fo7ozalbs719WVNiQdAzq2g0HXPMZ
         2j/IDigDuubCXia6qJjGgZ6PB0Kb7DvO8JLCxj8AspeP9Tm42TRfC7lp5702ex+qKA04
         t7erc1mBxL+odh2tv3rXe1Ad5y/XadlIcLgtsB1nVBeLtoJikSi+CPEyQzOccXevEZ8M
         ISTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WaDT2WvOJ0583ARuEixrBzHyp+fHS4lJW+SWnbkZ9yo=;
        b=RCRsdKxgkX+oiuuYwthzmsk+3HrU62QZmJsVsKGtwphM61OVKSu06XoECFvimON69N
         1IYMXr9gRJQPw5eT/yH3AYT1mtpvusY0u3lYbO5D0PN+KS8NtUC9neuSyOddzlBcZ20s
         4XF1J/g8n3P4VCCweMTyIe8Y8XU5SGIjXV2ZZMlITx7j8Bsr2nEJ5bYblpMS0BRXMTUs
         7FnEorP6VUStEDKVtfXEH4N/FwK+x4dddyEhLJv7k1Hj1mcYb/pX+eQ8XxHGdulUbRsi
         XyqMh4fgzCFhyo7TUabYy9uk7rO+3lvttN54jBiHGwtYxCR2UsGSj9MfJHMAU9tdEVgN
         0Alg==
X-Gm-Message-State: AOAM533kFQHDASqB4NDBro8LFbV03c+rnbEJtvV9I6bd+/8DAhCkoi9/
        6y7mlYH3n5TgQF1tb4qLXZk=
X-Google-Smtp-Source: ABdhPJz4D6JInqe0dgYiLGToSfD7LCzVG4wH3j9OgTaFs9J0nltyyKkcl240YpHc1DVR8+ASfGGEdw==
X-Received: by 2002:a63:ce50:: with SMTP id r16mr10922698pgi.425.1626453028542;
        Fri, 16 Jul 2021 09:30:28 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id k10sm10321497pfc.169.2021.07.16.09.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:30:28 -0700 (PDT)
Date:   Fri, 16 Jul 2021 16:30:21 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/2] btrfs-progs: export util functions about file
 extent items
Message-ID: <20210716163021.GA1203@realwakka>
References: <20210714145437.75710-1-realwakka@gmail.com>
 <47ac7559-820a-6a32-3f2a-72f9cb633503@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47ac7559-820a-6a32-3f2a-72f9cb633503@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 15, 2021 at 06:46:08AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/14 下午10:54, Sidong Yang wrote:
> > This patch export two functions that convert enum about file extents to
> > string. It can be used in other code like inspect-internal command. And
> > this patch also make compress_type_to_str() function more safe by using
> > strncpy() than strcpy().
> > 
> > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > ---
> > v2:
> >   - Prints type and compression
> >   - Use the terms from file_extents_item like disk_bytenr not like
> >     "physical"
> > v3:
> >   - export util functions for removing duplication
> >   - change the way to loop with search ioctl
> > ---
> >   kernel-shared/print-tree.c | 18 ++++++++++--------
> >   kernel-shared/print-tree.h |  3 +++
> >   2 files changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> > index e5d4b453..bfef7d26 100644
> > --- a/kernel-shared/print-tree.c
> > +++ b/kernel-shared/print-tree.c
> > @@ -27,6 +27,8 @@
> >   #include "kernel-shared/print-tree.h"
> >   #include "common/utils.h"
> > +#define COMPRESS_STR_LEN 5
> 
> It's already too small to contain all the strings.
> 
> We have a default branch:
> 
>  	default:
>  		sprintf(ret, "UNKNOWN.%d", compress_type);
> 
> In that case, our minimal value should be strlen("UNKNOWN.255") + 1, which
> is 12 bytes.
> 
> Your old rounded up 16 bytes is in fact perfect in this case.
> 
> Despite that, this patch looks good to me.

Thanks for review.

I've been thought about this. should COMPRESS_STR_LEN be exported?
Developer that use this function needs to know max length of string.
Or we can choose the simple implementation that just return const char*
like btrfs_file_extent_type_to_str(). But it will be hard to print
unknown compress_type.

Thanks,
Sidong
> 
> Thanks,
> Qu
> > +
> >   static void print_dir_item_type(struct extent_buffer *eb,
> >                                   struct btrfs_dir_item *di)
> >   {
> > @@ -338,27 +340,27 @@ static void print_uuids(struct extent_buffer *eb)
> >   	printf("fs uuid %s\nchunk uuid %s\n", fs_uuid, chunk_uuid);
> >   }
> > -static void compress_type_to_str(u8 compress_type, char *ret)
> > +void btrfs_compress_type_to_str(u8 compress_type, char *ret)
> >   {
> >   	switch (compress_type) {
> >   	case BTRFS_COMPRESS_NONE:
> > -		strcpy(ret, "none");
> > +		strncpy(ret, "none", COMPRESS_STR_LEN);
> >   		break;
> >   	case BTRFS_COMPRESS_ZLIB:
> > -		strcpy(ret, "zlib");
> > +		strncpy(ret, "zlib", COMPRESS_STR_LEN);
> >   		break;
> >   	case BTRFS_COMPRESS_LZO:
> > -		strcpy(ret, "lzo");
> > +		strncpy(ret, "lzo", COMPRESS_STR_LEN);
> >   		break;
> >   	case BTRFS_COMPRESS_ZSTD:
> > -		strcpy(ret, "zstd");
> > +		strncpy(ret, "zstd", COMPRESS_STR_LEN);
> >   		break;
> >   	default:
> >   		sprintf(ret, "UNKNOWN.%d", compress_type);
> >   	}
> >   }
> > -static const char* file_extent_type_to_str(u8 type)
> > +const char* btrfs_file_extent_type_to_str(u8 type)
> >   {
> >   	switch (type) {
> >   	case BTRFS_FILE_EXTENT_INLINE: return "inline";
> > @@ -376,12 +378,12 @@ static void print_file_extent_item(struct extent_buffer *eb,
> >   	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
> >   	char compress_str[16];
> > -	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
> > +	btrfs_compress_type_to_str(btrfs_file_extent_compression(eb, fi),
> >   			     compress_str);
> >   	printf("\t\tgeneration %llu type %hhu (%s)\n",
> >   			btrfs_file_extent_generation(eb, fi),
> > -			extent_type, file_extent_type_to_str(extent_type));
> > +			extent_type, btrfs_file_extent_type_to_str(extent_type));
> >   	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
> >   		printf("\t\tinline extent data size %u ram_bytes %llu compression %hhu (%s)\n",
> > diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
> > index 80fb6ef7..dbb2f183 100644
> > --- a/kernel-shared/print-tree.h
> > +++ b/kernel-shared/print-tree.h
> > @@ -43,4 +43,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type);
> >   void print_key_type(FILE *stream, u64 objectid, u8 type);
> >   void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
> > +void btrfs_compress_type_to_str(u8 compress_type, char *ret);
> > +const char* btrfs_file_extent_type_to_str(u8 type);
> > +
> >   #endif
> > 
> 
