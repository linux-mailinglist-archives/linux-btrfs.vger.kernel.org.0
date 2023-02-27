Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9728C6A4D28
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 22:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjB0V1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 16:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB0V1t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 16:27:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C288312071
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 13:27:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D6C51FD8C;
        Mon, 27 Feb 2023 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677533266;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkiaRCGdE37bBb56soMYpzggKfsV8W4fS9DOlEhL6xQ=;
        b=q0Ng5PziFtkwo2CAplC8y4pdE5dY5v6Kyl8OkOZXOJ3kE9QjCwsFQped8UvM5jmV4iRHgj
        mYrRqmc1Z8ftXjn+CKzFs7snJPqQ9MZWksWoysfXIOKYjcDfncZ7QkC8L3mQfan2MSvwn0
        clDfOm8a7cLmoThq+xyjCqaC1ryp0Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677533266;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mkiaRCGdE37bBb56soMYpzggKfsV8W4fS9DOlEhL6xQ=;
        b=4QnRQwFGcXXW5eU/IS8b69j+b/Gbs2ACBI7VCQWJ00RzwAHvMVhkSUuoUw+MQi1pfL+xaJ
        gAB+UdeUpA5279BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B1AA13A43;
        Mon, 27 Feb 2023 21:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bIpqEFIg/WPuPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 27 Feb 2023 21:27:46 +0000
Date:   Mon, 27 Feb 2023 22:21:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: cleanup submit_extent_page and friends v2
Message-ID: <20230227212147.GJ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230227151704.1224688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227151704.1224688-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 27, 2023 at 08:16:52AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up submit_extent_page and it's callers and callees.
> 
> Changes since v1:
> 
>  - remove a trailing whitespace (tab) added in an earlier patch that
>    gets removed until the end
>  - make a commit message more detailed
>  - minor tweak to a comment
>  - reorder the first two patches

The submit_extent_page certainly needed a cleanup, the patch granularity
is good.  Added to misc-next, thanks.
