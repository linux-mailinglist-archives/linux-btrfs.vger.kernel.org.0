Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3FF5787FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiGRRA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbiGRRAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 13:00:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868CD23174
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jul 2022 10:00:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECFDD203D6;
        Mon, 18 Jul 2022 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658163622;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSjQVhXYdsvplNTNOLu5/nJNphE42xIGt8c45rbiQZM=;
        b=uivVqsIkW1uJvLm4/59VGoTWSu9K0FhSLEeNMLhYNLLxiRRn4oPIpq2WO0kntzEsrNGV2u
        8IwuEGOA5EiBwDbVN9L6MehLbo0/vn37RLrAFXot6R1/DCukPF60WfHJP8xHTsat8uxTtm
        REdGBveThKL3AyS6LGpTeM9XXjVDH7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658163622;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSjQVhXYdsvplNTNOLu5/nJNphE42xIGt8c45rbiQZM=;
        b=d3EKCkzec9p2d6W0JUfnQhe/areLxnCHScMJbbDTamLE54lnfV4B3aZ3Fw6GRXAdnaBfWW
        ftGtjQ97tlbVloAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCDF813A37;
        Mon, 18 Jul 2022 17:00:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PoPeMKaR1WJTBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Jul 2022 17:00:22 +0000
Date:   Mon, 18 Jul 2022 18:55:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: add support for tabular format for
 device stats
Message-ID: <20220718165529.GK13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220718113439.2997247-1-nborisov@suse.com>
 <20220718113439.2997247-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718113439.2997247-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 18, 2022 at 02:34:39PM +0300, Nikolay Borisov wrote:
> Add support for the -T switch to 'device stats" command such that
> executing 'btrfs device stats -T' produces:
> 
> Id Path     Write errors Read errors Flush errors Corruption errors Generation errors
> -- -------- ------------ ----------- ------------ ----------------- -----------------
>  1 /dev/vdc            0           0            0                 0                 0
>  2 /dev/vdd            0           0            0                 0                 0
> 
> Link: https://lore.kernel.org/linux-btrfs/d7bd334d-13ad-8c5c-2122-1afc722fcc9c@dirtcellar.net
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  cmds/device.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 103 insertions(+), 6 deletions(-)
> 
> diff --git a/cmds/device.c b/cmds/device.c
> index feffe9184726..926fbbd64615 100644
> --- a/cmds/device.c
> +++ b/cmds/device.c
> @@ -27,6 +27,7 @@
>  #include "kerncompat.h"
>  #include "kernel-shared/ctree.h"
>  #include "ioctl.h"
> +#include "common/string-table.h"
>  #include "common/utils.h"
>  #include "kernel-shared/volumes.h"
>  #include "kernel-shared/zoned.h"
> @@ -572,6 +573,7 @@ static const char * const cmd_device_stats_usage[] = {
>  	"",
>  	"-c|--check             return non-zero if any stat counter is not zero",
>  	"-z|--reset             show current stats and reset values to zero",
> +	"-T                     show current stats in tabular format",

We'll need the long option too, but I see it's not in the 'filesystem
usage' either, yet.

>  	HELPINFO_INSERT_GLOBALS,
>  	HELPINFO_INSERT_FORMAT,
>  	NULL
> @@ -642,17 +644,75 @@ static int _print_device_stat_string(struct format_ctx *fctx,
>  	return err;
>  }
> 
> +
> +static int _print_device_stat_tabular(struct string_table *table, int row,

Please don't use the underscored version, that's maybe in some old in
btrfs-progs code but should not be in new.
