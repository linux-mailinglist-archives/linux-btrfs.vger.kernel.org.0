Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7B730AF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jun 2023 00:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjFNWsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 18:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjFNWsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 18:48:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F92C1BF9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jun 2023 15:48:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08513223CE;
        Wed, 14 Jun 2023 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686782884;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8Udh0GknD+xnoUFDQhvrufl+oRC89qMWZ0wzEfv+fQ=;
        b=29uw6f1TnOtIzFysKSXCKD/+P4BUW5eff2N8uk1U1fcfvdLk6Qja3z2ukHcZOFhTYqRzdT
        X8OXFLzVnI6lqZAyJw7SIIYCkU6iYm3LvfcyvGbpULfrRfI827LMfpYroHj2n9WtTTR5dl
        poikLserT7AMbd/I1bgnX2uFWbTogO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686782884;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w8Udh0GknD+xnoUFDQhvrufl+oRC89qMWZ0wzEfv+fQ=;
        b=GskHQ8QIiasXxN1CNKVTsl8mmGCElO0RENWUt/VgvxMuCvwHezEv5CWsxdGtkuO2GGuSsT
        TVAZd+lDHrFtYSDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E09831357F;
        Wed, 14 Jun 2023 22:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J16oNaNDimSJTQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 14 Jun 2023 22:48:03 +0000
Date:   Thu, 15 Jun 2023 00:41:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: scrub: unify the output numbers for "Total
 to scrub"
Message-ID: <20230614224144.GS13486@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2e1ee8fb0a05dbb2f6a4327d5b1383c3f7635dea.1685924954.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1ee8fb0a05dbb2f6a4327d5b1383c3f7635dea.1685924954.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 05, 2023 at 08:29:21AM +0800, Qu Wenruo wrote:
> [BUG]
> Command `btrfs scrub start -B` and `btrfs scrub status` are reporting
> very different results for "Total to scrub":
> 
>   $ sudo btrfs scrub start -B /mnt/btrfs/
>   scrub done for c107ef62-0a5d-4fd7-a119-b88f38b8e084
>   Scrub started:    Mon Jun  5 07:54:07 2023
>   Status:           finished
>   Duration:         0:00:00
>   Total to scrub:   1.52GiB
>   Rate:             0.00B/s
>   Error summary:    no errors found
> 
>   $ sudo btrfs scrub status /mnt/btrfs/
>   UUID:             c107ef62-0a5d-4fd7-a119-b88f38b8e084
>   Scrub started:    Mon Jun  5 07:54:07 2023
>   Status:           finished
>   Duration:         0:00:00
>   Total to scrub:   12.00MiB
>   Rate:             0.00B/s
>   Error summary:    no errors found
> 
> This can be very confusing for end users.
> 
> [CAUSE]
> It's the function print_fs_stat() handling the "Total to scrub" output.
> 
> For `btrfs scrub start` command, we use the used bytes (aka, the total
> used dev exntents of a device) for output.
> 
> This is not really accurate, as the chunks may be mostly empty just like
> the following:
> 
>   $ sudo btrfs fi df /mnt/btrfs/
>   Data, single: total=1.01GiB, used=9.06MiB
>   System, DUP: total=40.00MiB, used=64.00KiB
>   Metadata, DUP: total=256.00MiB, used=1.38MiB
>   GlobalReserve, single: total=22.00MiB, used=0.00B
> 
> Thus we're reporting 1.5GiB to scrub (1.01GiB + 40MiB * 2 + 256MiB * 2).
> But in reality, we only scrubbed 12MiB
> (9.06MiB + 64KiB * 2 + 1.38MiB * 2).
> 
> [FIX]
> Instead of using the used dev-extent bytes of a device, go with proper
> scrubbed bytes for each device.
> 
> This involves print_fs_stat() and print_scrub_dev() called inside
> scrub_start().
> 
> Now the output should match each other.
> 
> Issue: #636
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
