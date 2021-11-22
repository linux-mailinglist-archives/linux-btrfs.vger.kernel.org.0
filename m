Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8846E4589BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Nov 2021 08:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbhKVHXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 02:23:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55898 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhKVHXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 02:23:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDBE21FD49;
        Mon, 22 Nov 2021 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637565601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNcCX14qCSrHr3BToZlyS7Q5CKppj+Ol21HZt+kb274=;
        b=dqebz/q9JqHgMstXONX7iArOHWrGPJe2AqKAN3Wytm9JXox+EH4wYvqhiZjenaVaJG22cP
        OqBmwj3Ah+695DwZKF0vDHmKjxG14uJdJzYwlJ1wo8eGUTDopySqIsJ2Jcq+s94Ich/ygG
        jlm5u1KDjsvTIkgVpiMsB4oL1sdClnU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8146813A96;
        Mon, 22 Nov 2021 07:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xFnNHKFEm2HBGgAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 22 Nov 2021 07:20:01 +0000
Subject: Re: [PATCH v2] btrfs-progs: filesystem: du: skip file that permission
 denied
To:     Sidong Yang <realwakka@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20211121151556.8874-1-realwakka@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <09d229c6-ae30-4453-c9d4-39109f032b99@suse.com>
Date:   Mon, 22 Nov 2021 09:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211121151556.8874-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 21.11.21 г. 17:15, Sidong Yang wrote:
> This patch handles issue #421. Filesystem du command fails and exit
> when it access file that has permission denied. But it can continue the
> command except the files. This patch recovers ret value when permission
> denied.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>


The code itself is fine so :


Reviewed-by: Nikolay Borisov <nborisov@suse.com>


OTOH when I looked at the code rather than just the patch I can't help
but wonder shouldn't we actually structure this the way you initially
proposed but also add a debug output along the lines of "skipping
file/dir XXXX due to permission denied", otherwise users might not be
able to account for some space and they can possibly wonder that
something is wrong with btrfs fi du command.


> ---
>  cmds/filesystem-du.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
> index 5865335d..fb7753ca 100644
> --- a/cmds/filesystem-du.c
> +++ b/cmds/filesystem-du.c
> @@ -403,7 +403,7 @@ static int du_walk_dir(struct du_dir_ctxt *ctxt, struct rb_root *shared_extents)
>  						  dirfd(dirstream),
>  						  shared_extents, &tot, &shr,
>  						  0);
> -				if (ret == -ENOTTY) {
> +				if (ret == -ENOTTY || ret == -EACCES) {
>  					ret = 0;
>  					continue;
>  				} else if (ret) {
> 
