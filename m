Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA37B80B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbjJDNVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjJDNVl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 09:21:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E398;
        Wed,  4 Oct 2023 06:21:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6E3E821846;
        Wed,  4 Oct 2023 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696425695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OBJu+ETd2bFjVwMNV+zYRB1sMfWxTCGkPOYmVmQVCBo=;
        b=BLW+0cu4HEIJ2r3ew6/vcqy8u3uTRU4RbgvJ/RZfoJxrcO185MsWZYCsX8ZHH9/nXY0vWG
        bNbov8bQMcv1+aWEE/6rTwgzpqzjf2H48VYo2HLzTrqCl5Z1fUBMfRYy+cYxPtaDRrJ5WA
        jJFaYdrBKI0q/fRgcbdOOOJDEY3zmBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696425695;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OBJu+ETd2bFjVwMNV+zYRB1sMfWxTCGkPOYmVmQVCBo=;
        b=1Sv5NLycpOzo02frL78ayWZJ9KGt9ZGqAPBfW4v30dlbaA2OOh+S6KPX3K2H57jvODbBks
        W2hPWrq1sxB8U8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36A8C13A2E;
        Wed,  4 Oct 2023 13:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4pSmDN9mHWXgUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 Oct 2023 13:21:35 +0000
Date:   Wed, 4 Oct 2023 15:14:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenru <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] btrfs: RAID stripe tree updates
Message-ID: <20231004131452.GB28758@suse.cz>
Reply-To: dsterba@suse.cz
References: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004-rst-updates-v3-0-7729c4474ade@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 04, 2023 at 12:56:15AM -0700, Johannes Thumshirn wrote:
> This batch of RST updates contains the on-disk format changes Qu
> suggested. It drastically simplifies the write and path, especially for
> RAID10.
> 
> Instead of recording all strides of a striped RAID into one stripe tree
> entry, we create multiple entries per stride. This allows us to remove the
> length in the stride as we can use the length from the key. Using this
> method RAID10 becomes RAID1 and RAID0 becomes single from the point of
> view of the stripe tree.
> 
> ---
> - Link to first batch: https://lore.kernel.org/r/20230918-rst-updates-v1-0-17686dc06859@wdc.com
> - Link to second batch: https://lore.kernel.org/r/20230920-rst-updates-v2-0-b4dc154a648f@wdc.com
> 
> ---
> Johannes Thumshirn (4):
>       btrfs: change RST write
>       btrfs: remove stride length check on read
>       btrfs: remove raid stride length in tree printer
>       btrfs: remove stride length from on-disk format

Folded to the commits, thanks.
