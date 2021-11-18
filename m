Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40B1455DDD
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 15:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhKROXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 09:23:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42430 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhKROXf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 09:23:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 395432114D;
        Thu, 18 Nov 2021 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637245234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmzN7evUn1zxQQhqEwJKbCnXXj8KKetY8KFJHbesIM8=;
        b=NQe3Cgm5mqqZMGEPvBdLIyO7iAlhOVtd6nkhcHLlhRkB4FaRt9c0y+7dEeovDegHt/Q3xp
        0dlBF9eEZmOrfURqK927KVT5Qf2tYeuo9XB+X+sqXE4vsW0hUUR1RAG7uhwYLS/ukyn91Z
        mrfgnRSLbpRbrUdXBoGkXDFXU+inBPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637245234;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmzN7evUn1zxQQhqEwJKbCnXXj8KKetY8KFJHbesIM8=;
        b=131CTzPnPk1Lpbb1Heya9NPkgLvbcueTH/AtHqEqh9cyEyFYJXmh2d8B+g29toCGWy09++
        +QmdrKSk2VkJoEDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 311C6A3B81;
        Thu, 18 Nov 2021 14:20:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C6002DA735; Thu, 18 Nov 2021 15:20:29 +0100 (CET)
Date:   Thu, 18 Nov 2021 15:20:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v12 13/17] btrfs: add send stream v2 definitions
Message-ID: <20211118142029.GD28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1637179348.git.osandov@fb.com>
 <09f343aa74b5cb2ce0a715f90c71ae64ae74ce94.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f343aa74b5cb2ce0a715f90c71ae64ae74ce94.1637179348.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 17, 2021 at 12:19:23PM -0800, Omar Sandoval wrote:
> --- a/fs/btrfs/send.h
> +++ b/fs/btrfs/send.h
> @@ -12,7 +12,11 @@
>  #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
>  #define BTRFS_SEND_STREAM_VERSION 1
>  
> -#define BTRFS_SEND_BUF_SIZE SZ_64K
> +/*
> + * In send stream v1, no command is larger than 64k. In send stream v2, no limit
> + * should be assumed.
> + */
> +#define BTRFS_SEND_BUF_SIZE_V1 SZ_64K
>  
>  enum btrfs_tlv_type {
>  	BTRFS_TLV_U8,
> @@ -80,7 +84,10 @@ enum btrfs_send_cmd {
>  	BTRFS_SEND_C_MAX_V1 = BTRFS_SEND_C_UPDATE_EXTENT,
>  
>  	/* Version 2 */
> -	BTRFS_SEND_C_MAX_V2 = BTRFS_SEND_C_MAX_V1,
> +	BTRFS_SEND_C_FALLOCATE,
> +	BTRFS_SEND_C_SETFLAGS,
> +	BTRFS_SEND_C_ENCODED_WRITE,
> +	BTRFS_SEND_C_MAX_V2 = BTRFS_SEND_C_ENCODED_WRITE,

The previous patch changes the MAX_V command to be equal to the previous
command but that's exactly what I wanted to avoid in the protocol
definition list and keep it linear.
