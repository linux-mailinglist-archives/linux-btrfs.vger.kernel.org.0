Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBF6F813F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 13:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjEELHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjEELHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 07:07:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149418DFA
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 04:07:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADF8A1FDA1;
        Fri,  5 May 2023 11:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683284871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZ5hwuOJEqe+IA3UUpvIoF2vhGRW1C5UzlVOmTT2HjE=;
        b=XeXi8Uor0c4rJQQGOtz8IC2q3B+jYqkpWmjkcc0SkUIk6CmrCoKq8+um+3+bGc5vxH0GX9
        cigRLz8cu8KmRHgFBCfo1AHAq0IT1/UVqOouIouAQiPLcsvbavhN3jyqLyTsi5JCLOlqaw
        QjsXHFt5T/ANcQEdOHolV/r/9uv5hKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683284871;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oZ5hwuOJEqe+IA3UUpvIoF2vhGRW1C5UzlVOmTT2HjE=;
        b=ORGp/4kQcR55llVNhBDTmxO7F2NEvf9D/4YzThJI+ZBFYdTNYISUU1ZkE31PfSVy9oPhII
        7Yp66ug1oAjOTuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D43313488;
        Fri,  5 May 2023 11:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7Ze5IYfjVGSUDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 05 May 2023 11:07:51 +0000
Date:   Fri, 5 May 2023 13:01:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: don't offload CRCs generation to helpers if it is fast v2
Message-ID: <20230505110154.GK6373@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230503070615.1029820-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503070615.1029820-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 03, 2023 at 09:06:12AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> based on various observations from me and Chris, we really should never
> offload CRCs generation to helpers if it is hardware accelerated.
> 
> This series implements that and also tidies up various lose ends around
> that.
> 
> Changes since v1:
>  - drop already merged patches
>  - reordered two patches
>  - improve the commit log for one patch

Added to misc-next with some changelog updates, thanks.
