Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F72785E7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbjHWRYd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjHWRYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 13:24:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C78EE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 10:24:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55B472212F;
        Wed, 23 Aug 2023 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692811469;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWcauyRu7j9XFxlDelkf4MhCHyOcLjuOZi4w4pQKNis=;
        b=W9m+mepoA1sEsCIMNvHVxaUgjRWGllnQ3ULUbP1dZvdmiHaTLBK/2IbXZ+mrAf6N0wC/ie
        AeSksnF6xkC6FyXMMRYj8t2shS0mSUs/D42Nhmk+iy4AhuhlBlBXCYRvAMqp4U8v0TeDec
        ulsJc1p/KSnAHu9ylpyGRK/Qm0PvcEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692811469;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWcauyRu7j9XFxlDelkf4MhCHyOcLjuOZi4w4pQKNis=;
        b=81i112P3xTblNQR3uy91JonuPi7LNHivl+2tKYi+0mbqCI9NPYU5S7S9B7RspFbMFOSf8u
        0EgVlzTfztwB4VAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DCF61351F;
        Wed, 23 Aug 2023 17:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ziGBCs1A5mQzXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 23 Aug 2023 17:24:29 +0000
Date:   Wed, 23 Aug 2023 19:17:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs-progs: clear root dirty when we update the root
Message-ID: <20230823171756.GG2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1692800798.git.josef@toxicpanda.com>
 <5867c49c060d81c16fff55e20f62c0702ceae91f.1692800798.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5867c49c060d81c16fff55e20f62c0702ceae91f.1692800798.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 23, 2023 at 10:27:49AM -0400, Josef Bacik wrote:
> We don't currently use the bit to track whether or not the root is
> dirty, but when we sync ctree.c it uses this bit to determine if we
> should add the root to the dirty list.  Clear this bit when we update
> the root so that the dirty tracking works properly when we sync ctree.c.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  kernel-shared/transaction.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
> index d30be5b5..49b435f6 100644
> --- a/kernel-shared/transaction.c
> +++ b/kernel-shared/transaction.c
> @@ -14,6 +14,7 @@
>   * Boston, MA 021110-1307, USA.
>   */
>  
> +#include "kernel-lib/bitops.h"
>  #include "kerncompat.h"
>  #include "kernel-shared/disk-io.h"
>  #include "kernel-shared/transaction.h"

The includes in all files have been reorganized so that they're grouped,
the kerncompat.h is first, then system includes and libraries, then
kernel-lib, kernel-shared, common/, cmds/, the rest.
