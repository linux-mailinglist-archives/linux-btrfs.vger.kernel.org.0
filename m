Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62956AAEE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiGGSkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiGGSkR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 14:40:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FC2A43E
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 11:40:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A299621A6A;
        Thu,  7 Jul 2022 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657219215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QubepMQUV0BHTXufHSvyGYmnmydbR0kbUc8N6fpAnbk=;
        b=ggcZAsds9Nsk3sbF6jp5Objslw/A/En3PNqPlNZWuIkbU1fnPVS5bGfgOJtGWw3HwFM29A
        A7xhvwLm0wIgzYMl91IRcEc9h6aOcWYlWpoXg15fbj5x/k4ZXCL4fPCvHehuGIdbCMab0/
        uJepbYx+DjuZWfiHsLlHvzNTcVOWxIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657219215;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QubepMQUV0BHTXufHSvyGYmnmydbR0kbUc8N6fpAnbk=;
        b=aztydJxPJTN5RWUTrtQU8jCLi/w7ubC3EtPT0m0BvbhkNqbu5cb6h0qPPo7Hae2ABcGMwm
        d/3zvLtg1N3gnRDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7794213A33;
        Thu,  7 Jul 2022 18:40:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l1xHHI8ox2IXFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 07 Jul 2022 18:40:15 +0000
Date:   Thu, 7 Jul 2022 20:35:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: cleanup btrfs bio submission v2
Message-ID: <20220707183528.GM15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220617100414.1159680-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
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

On Fri, Jun 17, 2022 at 12:04:04PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series removes a bunch of pointlessly passed arguments in the
> raid56 code and then cleans up the btrfs_bio submission to always
> return errors through the end I/O handler.
> 
> Changes since v1:
>  - split the raid submission patches up a little better
>  - fix a whitespace issue
>  - add a new patch to properly deal with memory allocation failures in
>    btrfs_wq_submit_bio
>  - add more clean to prepare for and go along with the above new change

Patches 1-9 moved from topic branch to misc-next, thanks.
