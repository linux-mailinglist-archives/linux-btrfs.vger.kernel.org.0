Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A656569708
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 02:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiGGAul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 20:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGGAuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 20:50:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A92CDDF
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 17:50:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 687FA5C00FE;
        Wed,  6 Jul 2022 20:50:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 06 Jul 2022 20:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1657155035; x=1657241435; bh=84M44SSBAf
        W69MbFwkUisOLPBhZazgNlD6sLkanbgbI=; b=CKEdiEk2v4vmRluMTrqsl32X+R
        z1iSTVXuC/v5nCumkRKoIosDAvp109g4EE/AfFFb6ytbjHP/9pBEDkWY8xDbdlhl
        p+ahnQ/iRRp0EOlgd7J2Ql+n/6YeWKnKT7Irm3AT4JL+zIBZnpiLgU7IK0iUGhYi
        VopEiFrqiJvoVxw4yux2KIEiSiskWbUsUrzEpH2xHuJwKveiUjVW3milICvhV7Zl
        iDvjUEJyYZAO02rZVQjwe/ZrWEGSf2dxEa1fOOLec2EzKMrdMqn4E1gRbuUTcBom
        XjH5d2V9axQZuIcDUs5kPiCNGWfxrbNbSInuve85duY5JEgIBOt29nL/IVTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657155035; x=1657241435; bh=84M44SSBAfW69MbFwkUisOLPBhZa
        zgNlD6sLkanbgbI=; b=xto38vBkDwKHooA731tnxCiiUvvyTcT+wXFACogFo+vO
        lSvNrbrY167wQJLKH+G0B7WgfE2cYoUFp7wBVSP00uPXEwtL+g5i1kOFbfxYCdk/
        a1d9uXDBOf6LnPn+c9AV5k4yUthQoisGxUNM9MCAJ2NEWvJURzU9SmaeIzlbf+ds
        C6CATEqUQrFIhcHF+xQ/0gQXzsC/vbUQ1jCGk70BOsr7+a9LjkBlEL/UEoRtfFfw
        52GZCV0RKq8YzKf9GcRykcpLUPJ+1BEeZWKQe5qZmggrihzxcSUvCJS3NEX/6PVY
        Q65NEfuPBj8gjbdirPrB/gR1LS9wGA5W9+2/7MkwVg==
X-ME-Sender: <xms:2y3GYpeuuPXU8ZLUru--ARiaNW0sQEXNDLr-FUq-SIYEeRoObbPaqQ>
    <xme:2y3GYnMcqLnVQLIzOSKJTYjc5cTnNiehBKhfzgUVBUkgEEmORYbOEZWhyB86GQr1l
    0WZ3iO4vqB7aG8wDZU>
X-ME-Received: <xmr:2y3GYijHhwGXm4-xiTDk-R_I-4S-vNI56uTffyPD0kuJshM5Zi30ypMHJkREKq6bF82lj-D0fkWPsDeZZfQQxJ14z_8o0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:2y3GYi8ogTFVg91ZEnbGI3fi5mL7APGn9J-7VA23QFXy3IpiNMD2qQ>
    <xmx:2y3GYlsasCcVEO4WLQS_ecVSufkSDbsNlpk6zboaHCRkrvEMzM1hNg>
    <xmx:2y3GYhGXc9TwBc9kMJXLGQ4PQiIr7CX6Zxhr4AnLxhUsMrXxFfit1A>
    <xmx:2y3GYj2hR1CXL1HDTDcVnIWEH4LhmIDMLRNrWwO9yieW2PpN-XOFtg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Jul 2022 20:50:34 -0400 (EDT)
Date:   Wed, 6 Jul 2022 17:50:33 -0700
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the inode cache check at
 btrfs_is_free_space_inode()
Message-ID: <YsYtun4/16y2/1bT@zen>
References: <41a45a354624cbe3bc1ccfb100af7699e73090d3.1657102391.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a45a354624cbe3bc1ccfb100af7699e73090d3.1657102391.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 06, 2022 at 11:14:23AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The inode cache feature was removed in kernel 5.11, and we no longer have
> any code that reads from or writes to inode caches. We may still mount a
> filesystem that has inode caches, but they are ignored.
> 
> Remove the check for an inode cache from btrfs_is_free_space_inode(),
> since we no longer have code to trigger reads from an inode cache or
> writes to an inode cache. The check at send.c is still needed, because
> in case we find a filesystem with an inode cache, we must ignore it.
> Also leave the checks at tree-checker.c, as they are sanity checks.
> 
> This eliminates a dead branch and reduces the amount of code since it's
> in an inline function.
> 
> Before:
> 
> $ size fs/btrfs/btrfs.ko
>    text	   data	    bss	    dec	    hex	filename
> 1620662	 189240	  29032	1838934	 1c0f56	fs/btrfs/btrfs.ko
> 
> After:
> 
> $ size fs/btrfs/btrfs.ko
>    text	   data	    bss	    dec	    hex	filename
> 1620502	 189240	  29032	1838774	 1c0eb6	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/btrfs_inode.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 33811e896623..b467264bd1bb 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -305,8 +305,7 @@ static inline bool btrfs_is_free_space_inode(struct btrfs_inode *inode)
>  	if (root == root->fs_info->tree_root &&
>  	    btrfs_ino(inode) != BTRFS_BTREE_INODE_OBJECTID)
>  		return true;
> -	if (inode->location.objectid == BTRFS_FREE_INO_OBJECTID)
> -		return true;
> +
>  	return false;
>  }
>  
> -- 
> 2.35.1
> 
