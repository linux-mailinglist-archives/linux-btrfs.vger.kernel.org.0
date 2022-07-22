Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2E57DF76
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jul 2022 12:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiGVKOu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jul 2022 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiGVKOs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jul 2022 06:14:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1E78597
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 03:14:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CFDC320085;
        Fri, 22 Jul 2022 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658484885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHT1ddvwte2AfAAzlcbtyCztnWpQRAYF0kQLbKquQHk=;
        b=coRR+rQ3tQjOuqW/WfLiTq3Ox941ov1wrMPMA6mkDB49obkzIIejBeNEO9IU3qDfLt7L8k
        nKwF9f8DbnIjOda39nZTUJmXnZqTgpwy1pIjc+q6IdxJ1n7CakiO0Qpxj4J5Sa8gk3TIW3
        ++7HIGdH9B4qLd5UKLca2Tj76K2AXKQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C7C913AB3;
        Fri, 22 Jul 2022 10:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6GZ9I5V42mLzegAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Jul 2022 10:14:45 +0000
Message-ID: <a747c87b-3d38-7819-472c-db9480599ad6@suse.com>
Date:   Fri, 22 Jul 2022 13:14:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] btrfs-progs: expand corrupt_file_extent in
 btrfs-corrupt-block
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1657919808.git.boris@bur.io>
 <d3e7d721bb98a6643ba243c21013ddfc929ccd12.1657919808.git.boris@bur.io>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <d3e7d721bb98a6643ba243c21013ddfc929ccd12.1657919808.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.07.22 г. 0:22 ч., Boris Burkov wrote:
> To corrupt holes/prealloc/inline extents, we need to mess with
> extent data items. This patch makes it possible to modify
> disk_bytenr with a specific value (useful for hole corruptions)
> and to modify the type field (useful for prealloc corruptions)
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   btrfs-corrupt-block.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 5c39459db..27844b184 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -307,6 +307,7 @@ enum btrfs_inode_field {
>   
>   enum btrfs_file_extent_field {
>   	BTRFS_FILE_EXTENT_DISK_BYTENR,
> +	BTRFS_FILE_EXTENT_TYPE,
>   	BTRFS_FILE_EXTENT_BAD,
>   };
>   
> @@ -379,6 +380,8 @@ static enum btrfs_file_extent_field convert_file_extent_field(char *field)
>   {
>   	if (!strncmp(field, "disk_bytenr", FIELD_BUF_LEN))
>   		return BTRFS_FILE_EXTENT_DISK_BYTENR;
> +	if (!strncmp(field, "type", FIELD_BUF_LEN))
> +		return BTRFS_FILE_EXTENT_TYPE;
>   	return BTRFS_FILE_EXTENT_BAD;
>   }
>   
> @@ -752,14 +755,14 @@ out:
>   
>   static int corrupt_file_extent(struct btrfs_trans_handle *trans,
>   			       struct btrfs_root *root, u64 inode, u64 extent,
> -			       char *field)
> +			       char *field, u64 bogus)
>   {
>   	struct btrfs_file_extent_item *fi;
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
>   	enum btrfs_file_extent_field corrupt_field;
> -	u64 bogus;
>   	u64 orig;
> +	u8 bogus_type = bogus;

nit: Why do the truncation here, when you can simply pass bogus to 
btrfs_set_file_extent_type and the truncation would be done when the 
value is passed? Or simply cast it when passing bogus to 
btrfs_set_file_extent_type, it makes the code somewhat simpler since we 
now don't have this bogus_type which is really field-specific.

