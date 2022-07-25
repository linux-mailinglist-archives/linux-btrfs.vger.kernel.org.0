Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96D4580018
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiGYNqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiGYNqt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 09:46:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72744101C3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 06:46:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1DE6A2023D;
        Mon, 25 Jul 2022 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658756806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kl9yPPIxNjn5eoOxDWa/W4ls+ogSF1T8hboVxg4V4rw=;
        b=nV+aFJST74oRCq81Lcsx9Ta+c5V+QeSjxGPuBt/gD5ZFkREfd3JOBSJSVoEhjoOJiT0UaD
        /vNSXHqLJq9DrQeGfJ19DRWGW2gxJiKZfKOhDr3AM0rN0k/pL9ZK13b08tVkJpjVqTt8fr
        1/unezGHf3CrVXALAQFNecxkd1BsZUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658756806;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kl9yPPIxNjn5eoOxDWa/W4ls+ogSF1T8hboVxg4V4rw=;
        b=cfQT+siRrnH/XkNaGvfqa57i7+kFi22Nb0oJmg6fqQM9mhgzyoDUsOscTdqny3oiT13wcH
        kBxDnLv0icp8kSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E474C13ABB;
        Mon, 25 Jul 2022 13:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TeW/NsWe3mJaBQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 25 Jul 2022 13:46:45 +0000
Date:   Mon, 25 Jul 2022 15:41:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v6 1/4] btrfs: store chunk size in space-info struct.
Message-ID: <20220725134149.GY13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Stefan Roesch <shr@fb.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20211203220445.2312182-1-shr@fb.com>
 <20211203220445.2312182-2-shr@fb.com>
 <20220723074936.30FD.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723074936.30FD.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 23, 2022 at 07:49:37AM +0800, Wang Yugui wrote:
> Hi,
> 
> In this patch, the max chunk size is changed from 
> BTRFS_MAX_DATA_CHUNK_SIZE(10G) to SZ_1G without any comment ?

The patch hasn't been merged, the change from 1G to 10G without proper
evaluation won't happen. The sysfs knob is available for users who want
to test it or know that the non-default value works in their
environment.
