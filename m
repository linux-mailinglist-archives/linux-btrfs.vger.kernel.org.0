Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8476845829F
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Nov 2021 10:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhKUJEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 21 Nov 2021 04:04:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhKUJEI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 21 Nov 2021 04:04:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC43F218A9;
        Sun, 21 Nov 2021 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637485262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dBlcguoRN1MCDPeoL6l7piC0DoHht/KpsjvWOtO37OU=;
        b=b7leiFycs/chFaiH0qXUBHzRy4gc2Beul0ChIuIVMGuB9Bj/3JVkN2fNDOnrGXcqDUPmYk
        gYceNHAabWkb3siKqlm+f7+JSvt3M3sVQORzLVzbaORzlIQj/NC6IotSJO7Z+t5MP4OoQM
        1Z454mvIdQBsRCgJN2qxxlA27XW52hI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B35B71331A;
        Sun, 21 Nov 2021 09:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UJcxKc4KmmHiSgAAMHmgww
        (envelope-from <nborisov@suse.com>); Sun, 21 Nov 2021 09:01:02 +0000
Subject: Re: [RFC PATCH] btrfs-progs: filesystem: du: skip file that
 permission denied
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20211121074705.8615-1-realwakka@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <fb414950-fb0d-d24a-08f3-c0247f9bff9b@suse.com>
Date:   Sun, 21 Nov 2021 11:01:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211121074705.8615-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.11.21 г. 9:47, Sidong Yang wrote:
> This patch handles issue #421. Filesystem du command fails and exit
> when it access file that has permission denied. But it can continue the
> command except the files. This patch recovers ret value when permission
> denied.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  cmds/filesystem-du.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
> index 5865335d..64a1f7f5 100644
> --- a/cmds/filesystem-du.c
> +++ b/cmds/filesystem-du.c
> @@ -406,6 +406,9 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
>  				if (ret == -ENOTTY) {
>  					ret = 0;
>  					continue;
> +				} else if (ret == -EACCES) {

This can be added to the above condition with || ret == -EACCESS. Avoids
code duplication.

> +					ret = 0;
> +					continue;
>  				} else if (ret) {
>  					errno = -ret;
>  					fprintf(stderr,
> 
