Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503E2477135
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 12:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhLPL6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 06:58:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhLPL6X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 06:58:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DBC421F3A7
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639655902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BvRar7pHWCbscGfc05oYhQUvTfUA6lrwpVbSNwl7L4=;
        b=pA9guohIDCTT/ByzEUSIaDVakLVHgYug5tfxbgU0C7drz2n24germpUT8aWJrsky+bbb/H
        sWF1LU+Eq+/sMdfWFBgaLUpnyDbQPn+D8WNEIHZHJcFtZ2FgjNVotMxIGVx571EmnWrZOQ
        iEPBvV3c2rz1luvCTiy8RRlXs+ZCmRM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B650A13B4B
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8qOoKN4pu2FCSAAAMHmgww
        (envelope-from <nborisov@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:58:22 +0000
Subject: Re: [PATCH] btrfs-progs: remove redundant fs uuid validation from
 make_btrf
To:     linux-btrfs@vger.kernel.org
References: <20211216100012.911835-1-nborisov@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <06d494c0-a125-b28e-a353-6638e427de11@suse.com>
Date:   Thu, 16 Dec 2021 13:58:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211216100012.911835-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.12.21 г. 12:00, Nikolay Borisov wrote:
> cfg->fs_uuid is either 0 or set to the value of the -U parameter
> passed to mkfs.btrfs. However the value of the latter is already being
> validated in the main mkfs function. Just remove the duplicated checks
> in make_btrfs as they effectively can never be executed.

Actually the checks are executed but can never fail because they've
already succeeded before calling them for the 2nd time here :). David
you might want to amend this when committing.

> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  mkfs/common.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/mkfs/common.c b/mkfs/common.c
> index fec23e64b2b2..72e84bc01712 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -260,18 +260,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	memset(&super, 0, sizeof(super));
> 
>  	num_bytes = (cfg->num_bytes / cfg->sectorsize) * cfg->sectorsize;
> -	if (*cfg->fs_uuid) {
> -		if (uuid_parse(cfg->fs_uuid, super.fsid) != 0) {
> -			error("cannot not parse UUID: %s", cfg->fs_uuid);
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		if (!test_uuid_unique(cfg->fs_uuid)) {
> -			error("non-unique UUID: %s", cfg->fs_uuid);
> -			ret = -EBUSY;
> -			goto out;
> -		}
> -	} else {
> +	if (!*cfg->fs_uuid) {
>  		uuid_generate(super.fsid);
>  		uuid_unparse(super.fsid, cfg->fs_uuid);
>  	}
> --
> 2.17.1
> 
