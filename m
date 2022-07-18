Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196F57876F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiGRQbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiGRQbX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 12:31:23 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFE322B1F
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 09:31:22 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 669448132B;
        Mon, 18 Jul 2022 12:31:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658161882; bh=gCRv/op1CL6LRxitc+kIoMmmh5F7aHjdWksJ9vTkzMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gS0QANfrVNTuhDA7GG3KeiGkk+uWllbbTkuS08I09zqOE9viLd5vODTLkEFjxt9St
         pYV7b30HscCosX94cNSn1yFRO/XXnr9/qs9IsZZyN8pVUpG2P0A2PhobCe3Zw5iWAo
         muJ5OyTrviHWM8aFLflBCJVYkmnZadPXS3TAOxthQRVFyhTO+sAb8iJtrczyR/ckk5
         bMCVWNev1A2w/kZ5B1bH3BVTLPhHhnhoUT6RoRwGWJPTe5Le/JDZVi5VpCxKe1+V47
         IgSOoBQtOHi6jjiCNHJIxAg7XyvscYcSj3dn67KUOgWCmp1WSN+1esLdGBzQLNX3IL
         z/Lzm/Zi/6EgQ==
MIME-Version: 1.0
Date:   Mon, 18 Jul 2022 12:31:22 -0400
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs-progs: expand corrupt_file_extent in
 btrfs-corrupt-block
In-Reply-To: <d3e7d721bb98a6643ba243c21013ddfc929ccd12.1657919808.git.boris@bur.io>
References: <cover.1657919808.git.boris@bur.io>
 <d3e7d721bb98a6643ba243c21013ddfc929ccd12.1657919808.git.boris@bur.io>
Message-ID: <141d6d932daa425e97e477f900d7ccb3@dorminy.me>
X-Sender: sweettea-kernel@dorminy.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-07-15 17:22, Boris Burkov wrote:
> To corrupt holes/prealloc/inline extents, we need to mess with
> extent data items. This patch makes it possible to modify
> disk_bytenr with a specific value (useful for hole corruptions)
> and to modify the type field (useful for prealloc corruptions)
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  btrfs-corrupt-block.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index 5c39459db..27844b184 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -307,6 +307,7 @@ enum btrfs_inode_field {
> 
>  enum btrfs_file_extent_field {
>  	BTRFS_FILE_EXTENT_DISK_BYTENR,
> +	BTRFS_FILE_EXTENT_TYPE,
>  	BTRFS_FILE_EXTENT_BAD,
>  };
> 
> @@ -379,6 +380,8 @@ static enum btrfs_file_extent_field
> convert_file_extent_field(char *field)
>  {
>  	if (!strncmp(field, "disk_bytenr", FIELD_BUF_LEN))
>  		return BTRFS_FILE_EXTENT_DISK_BYTENR;
> +	if (!strncmp(field, "type", FIELD_BUF_LEN))
> +		return BTRFS_FILE_EXTENT_TYPE;
>  	return BTRFS_FILE_EXTENT_BAD;
>  }
> 
> @@ -752,14 +755,14 @@ out:
> 
>  static int corrupt_file_extent(struct btrfs_trans_handle *trans,
>  			       struct btrfs_root *root, u64 inode, u64 extent,
> -			       char *field)
> +			       char *field, u64 bogus)
>  {
>  	struct btrfs_file_extent_item *fi;
>  	struct btrfs_path *path;
>  	struct btrfs_key key;
>  	enum btrfs_file_extent_field corrupt_field;
> -	u64 bogus;
>  	u64 orig;
> +	u8 bogus_type = bogus;
>  	int ret = 0;
> 
>  	corrupt_field = convert_file_extent_field(field);
> @@ -791,9 +794,18 @@ static int corrupt_file_extent(struct
> btrfs_trans_handle *trans,
>  	switch (corrupt_field) {
>  	case BTRFS_FILE_EXTENT_DISK_BYTENR:
>  		orig = btrfs_file_extent_disk_bytenr(path->nodes[0], fi);
> -		bogus = generate_u64(orig);
> +		if (bogus == (u64)-1)
> +			bogus = generate_u64(orig);
Personally I like ternaries a little more but whatever.
>  		btrfs_set_file_extent_disk_bytenr(path->nodes[0], fi, bogus);
>  		break;
> +	case BTRFS_FILE_EXTENT_TYPE:
> +		if (bogus == (u64)-1) {
> +			fprintf(stderr, "Specify a new extent type value (-v)\n");
> +			ret = -EINVAL;
> +			goto out;
> +		}
Again calling out (u64)-1 as a defined name would be nice.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
