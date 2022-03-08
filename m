Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04F4D1D18
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiCHQYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbiCHQYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 11:24:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C366488A8
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 08:23:49 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 53D00210ED;
        Tue,  8 Mar 2022 16:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646756628;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iq/JIBpjt5kZOFzjpatMfhPvXH5rQiA1fR11etO4djg=;
        b=2+3+rPfcLtKyJmtvoa4dcUgdfSMVSUFFXeIFfWO4sSuHo6py3KpkKA8R5oA48Md/GcEGP6
        JvVEtVZ1POIeYnWVRMof24AAakAmvEG10TF3fmLcjd5FHVhtbL168PYukMrznuXjd2dq0/
        M7ZK592yKLSd7pfxdPk3vbnF44M2icU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646756628;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iq/JIBpjt5kZOFzjpatMfhPvXH5rQiA1fR11etO4djg=;
        b=U8VgfFuRByXixh8/DDwQcVz6qF1MnLKhuuwd1qnCMKOa/Gv7uu4yHHsLwdxZkxmow3AnS9
        4Ov1fsfw4cqABlDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4B94AA3B8A;
        Tue,  8 Mar 2022 16:23:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C2CFCDA823; Tue,  8 Mar 2022 17:19:51 +0100 (CET)
Date:   Tue, 8 Mar 2022 17:19:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 12/19] btrfs-progs: set the number of global roots in
 the super block
Message-ID: <20220308161951.GN12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1646690972.git.josef@toxicpanda.com>
 <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c28a05081455379be5d91ee760f9a03e4255e6a.1646690972.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 07, 2022 at 05:10:57PM -0500, Josef Bacik wrote:
> In order to make sure the file system is consistent we need to record
> the number of global roots we should have in the super block.  We could
> infer this from the number of global roots we find, however this could
> lead to interesting fuzzing problems, so add a source of truth to the
> super block in order to make it easier to verify the file system is
> consistent.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  kernel-shared/ctree.h   | 6 +++++-
>  kernel-shared/disk-io.c | 4 ++++
>  mkfs/common.c           | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index b12dbff1..90de7a65 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -463,13 +463,15 @@ struct btrfs_super_block {
>  
>  	u8 metadata_uuid[BTRFS_FSID_SIZE];
>  
> +	__le64 nr_global_roots;
> +

Shouldn't this be added after the last item?

>  	__le64 block_group_root;
>  	__le64 block_group_root_generation;
>  	u8 block_group_root_level;
>  
>  	/* future expansion */
>  	u8 reserved8[7];
> -	__le64 reserved[25];
> +	__le64 reserved[24];
>  	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
>  	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
>  	/* Padded to 4096 bytes */
