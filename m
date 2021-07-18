Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AEF3CC7F3
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jul 2021 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhGRG11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Jul 2021 02:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGRG10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Jul 2021 02:27:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D5C061762
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:24:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q10so13218920pfj.12
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jul 2021 23:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jDciRlICU//QmQzhCLh6AHCfBvCgwsADLihSm3rMuv4=;
        b=sPXYhSd+PtpyXJd0CLwBj/dxMBIOmvqc4OMoBRD9hwnf4az0ya6FgZd7Q9gf2AXAbp
         RXtPk4RGk40D9wTGrusWA31boroq+8ylcYoV4i8kV3VQjgcCKW1NT0Ir++j9fBmgXj/M
         YEnLK8K89My16keJJfKmmE+qqmlXd7BxvcCgYcCN9kKFinzIfGLa/Iy9j8/e91lHN9GD
         rfigkufompgmyXFfQSZlzUsjfCuCw/claMwbpnI0InsfKPF3hHEKJMcVCUCeb3HQ+jb3
         XeLtWlhRkdFI3f8yfDyGf4kE7AOf+p5LvezX7lVgjf3rkscN3N7wyJPXDxpqPk2xEA9k
         QEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jDciRlICU//QmQzhCLh6AHCfBvCgwsADLihSm3rMuv4=;
        b=Qt7ky11o84gyY+myI3DoRXOT0/VSY/uW54XruziE1TtDIksy3qlmkDT4FbbzEPxQBw
         DPl0YgyW/O5N7sdQcCC5phPmk3Q2AzEINSjEHzsIo1ozzuLNSQJGWy1Eiy3+Jxk51MRZ
         F0DY3HJ5/x+mDgKiwYuAiyfMAS9nKVeDtD0sQGdXSyROExtGcnmYYCOsZeqkieNNE6LC
         p1hy71sPa1//zGhBC0F0fZWW2ttTL9FqcbU7Q2Xclt3dCaZa8gty/GMSH0Jafz10ohxO
         MIu64qhzUbzZg2yzfsb/meBwIqhMjFPiRBEEDzCrbGgRPgtPGNiLZkkUH87kuc6kGgZY
         uKkQ==
X-Gm-Message-State: AOAM531PB3RbdCxekGx61QIvgqq+fPh2elZoRUf8ZU1WB3yVSplOmKLM
        S3t2+17HtFT/BBFKY49jF1U=
X-Google-Smtp-Source: ABdhPJxiql6/a6ekKcuXbUP+/er7AYKKquMPJmn9MgsgN5mTrkhMKJRt1v2E+sWI4GKOAu5h2Eqo8w==
X-Received: by 2002:a63:4002:: with SMTP id n2mr18587714pga.124.1626589467788;
        Sat, 17 Jul 2021 23:24:27 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id r15sm17430963pgk.72.2021.07.17.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 23:24:27 -0700 (PDT)
Date:   Sun, 18 Jul 2021 06:24:12 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/2] btrfs-progs: export util functions about file
 extent items
Message-ID: <20210718062412.GA2055@realwakka>
References: <20210714145437.75710-1-realwakka@gmail.com>
 <47ac7559-820a-6a32-3f2a-72f9cb633503@suse.com>
 <20210716163021.GA1203@realwakka>
 <8392b5df-31b3-0ff7-7ee6-1308a368b6e7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8392b5df-31b3-0ff7-7ee6-1308a368b6e7@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 17, 2021 at 06:56:37AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/17 上午12:30, Sidong Yang wrote:
> > On Thu, Jul 15, 2021 at 06:46:08AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2021/7/14 下午10:54, Sidong Yang wrote:
> > > > This patch export two functions that convert enum about file extents to
> > > > string. It can be used in other code like inspect-internal command. And
> > > > this patch also make compress_type_to_str() function more safe by using
> > > > strncpy() than strcpy().
> > > > 
> > > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > > ---
> > > > v2:
> > > >    - Prints type and compression
> > > >    - Use the terms from file_extents_item like disk_bytenr not like
> > > >      "physical"
> > > > v3:
> > > >    - export util functions for removing duplication
> > > >    - change the way to loop with search ioctl
> > > > ---
> > > >    kernel-shared/print-tree.c | 18 ++++++++++--------
> > > >    kernel-shared/print-tree.h |  3 +++
> > > >    2 files changed, 13 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> > > > index e5d4b453..bfef7d26 100644
> > > > --- a/kernel-shared/print-tree.c
> > > > +++ b/kernel-shared/print-tree.c
> > > > @@ -27,6 +27,8 @@
> > > >    #include "kernel-shared/print-tree.h"
> > > >    #include "common/utils.h"
> > > > +#define COMPRESS_STR_LEN 5
> > > 
> > > It's already too small to contain all the strings.
> > > 
> > > We have a default branch:
> > > 
> > >   	default:
> > >   		sprintf(ret, "UNKNOWN.%d", compress_type);
> > > 
> > > In that case, our minimal value should be strlen("UNKNOWN.255") + 1, which
> > > is 12 bytes.
> > > 
> > > Your old rounded up 16 bytes is in fact perfect in this case.
> > > 
> > > Despite that, this patch looks good to me.
> > 
> > Thanks for review.
> > 
> > I've been thought about this. should COMPRESS_STR_LEN be exported?
> 
> I guess yes.

Thanks, I'll apply this.

Thanks,
Sidong
> 
> Thanks,
> Qu
> 
> > Developer that use this function needs to know max length of string.
> > Or we can choose the simple implementation that just return const char*
> > like btrfs_file_extent_type_to_str(). But it will be hard to print
> > unknown compress_type.
> > 
> > Thanks,
> > Sidong
> > > 
> > > Thanks,
> > > Qu
> > > > +
> > > >    static void print_dir_item_type(struct extent_buffer *eb,
> > > >                                    struct btrfs_dir_item *di)
> > > >    {
> > > > @@ -338,27 +340,27 @@ static void print_uuids(struct extent_buffer *eb)
> > > >    	printf("fs uuid %s\nchunk uuid %s\n", fs_uuid, chunk_uuid);
> > > >    }
> > > > -static void compress_type_to_str(u8 compress_type, char *ret)
> > > > +void btrfs_compress_type_to_str(u8 compress_type, char *ret)
> > > >    {
> > > >    	switch (compress_type) {
> > > >    	case BTRFS_COMPRESS_NONE:
> > > > -		strcpy(ret, "none");
> > > > +		strncpy(ret, "none", COMPRESS_STR_LEN);
> > > >    		break;
> > > >    	case BTRFS_COMPRESS_ZLIB:
> > > > -		strcpy(ret, "zlib");
> > > > +		strncpy(ret, "zlib", COMPRESS_STR_LEN);
> > > >    		break;
> > > >    	case BTRFS_COMPRESS_LZO:
> > > > -		strcpy(ret, "lzo");
> > > > +		strncpy(ret, "lzo", COMPRESS_STR_LEN);
> > > >    		break;
> > > >    	case BTRFS_COMPRESS_ZSTD:
> > > > -		strcpy(ret, "zstd");
> > > > +		strncpy(ret, "zstd", COMPRESS_STR_LEN);
> > > >    		break;
> > > >    	default:
> > > >    		sprintf(ret, "UNKNOWN.%d", compress_type);
> > > >    	}
> > > >    }
> > > > -static const char* file_extent_type_to_str(u8 type)
> > > > +const char* btrfs_file_extent_type_to_str(u8 type)
> > > >    {
> > > >    	switch (type) {
> > > >    	case BTRFS_FILE_EXTENT_INLINE: return "inline";
> > > > @@ -376,12 +378,12 @@ static void print_file_extent_item(struct extent_buffer *eb,
> > > >    	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
> > > >    	char compress_str[16];
> > > > -	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
> > > > +	btrfs_compress_type_to_str(btrfs_file_extent_compression(eb, fi),
> > > >    			     compress_str);
> > > >    	printf("\t\tgeneration %llu type %hhu (%s)\n",
> > > >    			btrfs_file_extent_generation(eb, fi),
> > > > -			extent_type, file_extent_type_to_str(extent_type));
> > > > +			extent_type, btrfs_file_extent_type_to_str(extent_type));
> > > >    	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
> > > >    		printf("\t\tinline extent data size %u ram_bytes %llu compression %hhu (%s)\n",
> > > > diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
> > > > index 80fb6ef7..dbb2f183 100644
> > > > --- a/kernel-shared/print-tree.h
> > > > +++ b/kernel-shared/print-tree.h
> > > > @@ -43,4 +43,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type);
> > > >    void print_key_type(FILE *stream, u64 objectid, u8 type);
> > > >    void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
> > > > +void btrfs_compress_type_to_str(u8 compress_type, char *ret);
> > > > +const char* btrfs_file_extent_type_to_str(u8 type);
> > > > +
> > > >    #endif
> > > > 
> > > 
