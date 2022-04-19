Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A60B506D21
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbiDSNKI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 09:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSNKE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 09:10:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E1E37A2F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 06:07:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EA941F38D;
        Tue, 19 Apr 2022 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650373637;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3qRM2bwOw+ibOzYwK1P8Pl/xHDBYBO/kvGf+OjXblDM=;
        b=i3PyZclZMOl9wiKOYU4eyhii3zPIBJYj2G+krhdPNtm5DdPTY/PLaK7J+HsspFFfmi3oCa
        RPHc6aXstmPD7bbeebmJpMOk2vcbajry+0XZxQmfly5sXtO5KkbQPGQqMYylAIo6tuHzj7
        3cXSMnmDLost9N5SksiwbkAzonB3qFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650373637;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3qRM2bwOw+ibOzYwK1P8Pl/xHDBYBO/kvGf+OjXblDM=;
        b=z1CmMY44hU6wZfkAX4t5/XXc+seaZOU4S1kQvoq3yMi9nHGhRki4MsPJCUa6bD2gZ3nR18
        16F4211nwXWZseAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A0E0139BE;
        Tue, 19 Apr 2022 13:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rzOiAQW0XmLofQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 19 Apr 2022 13:07:17 +0000
Date:   Tue, 19 Apr 2022 15:03:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: kernel-doc fixes to make btrfs W=1 clean
Message-ID: <20220419130313.GC2348@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220418123305.1418876-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418123305.1418876-1-nborisov@suse.com>
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

On Mon, Apr 18, 2022 at 03:33:05PM +0300, Nikolay Borisov wrote:
> With some minor adjustments to existing comments fs/btrfs/ is actually W=1 clean.
> This change involves mainly adding function names in the kernel-doc as well as
> making some comments not be a kernel-doc (i.e for static functions).
> 
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1512,8 +1512,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
>  }
> 
>  /**
> - * Check if an extent is shared or not
> - *
> + * btrfs_check_shared -  Check if an extent is shared or not

No thanks, we'd rather have something more human friendly and the
function name is redundant. I think you were also involved in this
discussion back then so I don't understand why you send the patch. A W=1
clean build is a nice thing to have but I disagree that we should fix
the code on our side because some script says so.

Also, kdoc format for checking the parameter list an completeness makes
sense for static functions, so "no thanks" in this case as well.
