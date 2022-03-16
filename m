Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A624DB8FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 20:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbiCPTrc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 15:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbiCPTrc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 15:47:32 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A752140A7
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 12:46:17 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v14so2742499qta.2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E10/RHxqxdnO02yRvPfaNr/v1jdUvJvGTwpcCM2UuCE=;
        b=fB361frlMZcmPFNRJnWIY0N33kIHBkuzrYHZNokfoqCoIzuZEL0MDnT3DmDnAo37Jw
         fPQu/v32EjcIBE/hNQPZr9Shi2+Jtq4zrV/0lCwUNcHOXPWX6IHLl9BTBQZSmJ3H1Mgq
         CecWI2kv9rrCpqL+b+spCjWoBlrunZlxpEvQAoSThY/Oj0WOshxw3phyvhfNkFPRiong
         l8CcCWsIwg02zaY9Fjb+60SVFPzp8U17cxiG4fb2JMEMx/FnQvbtXMsuIRuhHx+k5+wR
         yyLIKC8meKzEVsJK9OJL1fGNJGstG4eX7Zvo6by02gx6PkRMmQxxsnYadDeyre6672oh
         LY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E10/RHxqxdnO02yRvPfaNr/v1jdUvJvGTwpcCM2UuCE=;
        b=jz2iWEP6ueT0ndLDOiuFZmnNJwoJQadZD1hahmb2MuxVr+kRSX5cWfplg1QZuvrk4s
         S7uOSLnj3DIEhZgbn5RS3XwomBz2+B88kMQdD9g3S1o4Ekesog+MVozeN8prxelrrR25
         V0FUlETqn5INkEckcAjbJkTymOzexuf1f7fcvX0jOb9HSHGqGnF2kdANg48BOuRCcCH/
         gaeDITO5LAj0s6F4y/90cbp0AljrTrqaS8IwTvJzme/nj2UrVH5PY7qL/l97CDRTy+CE
         nita2c+ROxVLRIlh8JfuVUKpumPSzJX+iBIm6nAt+to/aGn5b/23qAej4ey/mMBw0IkU
         qIPA==
X-Gm-Message-State: AOAM532BNgh94fm2WQ4XAx7bq5/4ntlJTITCNgIUocHRCRzc8KnCrtxM
        BpFxL2domWqruk1O7otrEzpHPg==
X-Google-Smtp-Source: ABdhPJzdid00/41lxSbckANfhz3hmgkLiL0sjFGBBL7VjSFouD738FwEvMgn4bxoZSVrvIQ/cKsiQg==
X-Received: by 2002:a05:622a:490:b0:2e1:cd32:f3da with SMTP id p16-20020a05622a049000b002e1cd32f3damr1206863qtx.339.1647459976253;
        Wed, 16 Mar 2022 12:46:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a14-20020a05620a066e00b0067d36cc5b12sm1253247qkh.87.2022.03.16.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 12:46:15 -0700 (PDT)
Date:   Wed, 16 Mar 2022 15:46:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH 11/17] btrfs: make dec_and_test_compressed_bio() to be
 split bio compatible
Message-ID: <YjI+hkhhTTWMmPkz@localhost.localdomain>
References: <20211201051756.53742-1-wqu@suse.com>
 <20211201051756.53742-12-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201051756.53742-12-wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 01, 2021 at 01:17:50PM +0800, Qu Wenruo wrote:
> For compression read write endio functions, they all rely on
> dec_and_test_compressed_bio() to determine if they are the last bio.
> 
> So here we only need to convert the bio_for_each_segment_all() call into
> __bio_for_each_segment() so that compression read/write endio functions
> will handle both split and unsplit bios well.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 8668c5190805..8b4b84b59b0c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -205,18 +205,14 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
>  static bool dec_and_test_compressed_bio(struct compressed_bio *cb, struct bio *bio)
>  {
>  	struct btrfs_fs_info *fs_info = btrfs_sb(cb->inode->i_sb);
> +	struct bio_vec bvec;
> +	struct bvec_iter iter;
>  	unsigned int bi_size = 0;
>  	bool last_io = false;
> -	struct bio_vec *bvec;
> -	struct bvec_iter_all iter_all;
>  
> -	/*
> -	 * At endio time, bi_iter.bi_size doesn't represent the real bio size.
> -	 * Thus here we have to iterate through all segments to grab correct
> -	 * bio size.
> -	 */
> -	bio_for_each_segment_all(bvec, bio, iter_all)
> -		bi_size += bvec->bv_len;
> +	ASSERT(btrfs_bio(bio)->iter.bi_size);

We're tripping this assert with generic/476 with -o compress, so I assume
there's some error condition that isn't being handled properly.  Thanks,

Josef
