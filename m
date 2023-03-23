Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32856C70C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 20:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjCWTJ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 15:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCWTJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 15:09:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C39720A3C
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 12:09:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B74933836;
        Thu, 23 Mar 2023 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679598565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHQbBoHJ49KLxaQeAVSSn+Q8UA9fJQHthuTmpOKUky4=;
        b=VLH+1FBSOOGDOIj2+qUtHMlKdAwcxQPpEpBV0ZZkjL3AdFpBv4iQ1rAxKp5Mi6CT5SKc2S
        IQYsWBNIHH7cMZkXcWRM8FUaUM/lzy0y48du0R2U3Ec1EEnGJqEgiJ+6F1a9nIOfTraS9a
        yNuRczpAU63XO1VvIOVonnz9SeGljtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679598565;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHQbBoHJ49KLxaQeAVSSn+Q8UA9fJQHthuTmpOKUky4=;
        b=8bt+gJu+WuGprwm5oaqfti2cfi6o9oS+3braS8YJeah9YyDBpnw7bHViI2/YiKhXoSX0ap
        XR/8HGwAwiqvJoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 302D6132C2;
        Thu, 23 Mar 2023 19:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gA6lCuWjHGTiIQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Mar 2023 19:09:25 +0000
Date:   Thu, 23 Mar 2023 20:03:13 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: make check/clear-cache.c to be separate
 from check/main.c
Message-ID: <20230323190313.GA10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1679480445.git.wqu@suse.com>
 <0230b3efffd148db3e1850ad085dc9ae65dbbea8.1679480445.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0230b3efffd148db3e1850ad085dc9ae65dbbea8.1679480445.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 22, 2023 at 06:27:04PM +0800, Qu Wenruo wrote:
> Currently check/clear-cache.c still uses a lot of global variables like
> gfs_info and g_task_ctx, which are only implemented in check/main.c.
> 
> Since we have separated clear-cache code into its own c and header files,
> we should not utilize those global variables.

Why? The global fs_info for the whole check is declared in
check/common.h and is supposed to be used for all internal check
functions. This is intentional.
