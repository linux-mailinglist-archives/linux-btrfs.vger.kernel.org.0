Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4D51A3EF
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 17:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351491AbiEDP2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiEDP17 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 11:27:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4641318
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 08:24:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC021F745;
        Wed,  4 May 2022 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651677862;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LFtdU5sZa2A2xB4m690UeZa0E7n83KO9oZPFcN6P5KI=;
        b=ha8VlccG9FyVH02aUgenoLGRQ2LCozU296Uf4VvoXcaFlNjoYpG0DLKFd72hbB9K4svlyT
        8C6F0HwZDYHk3pEShcACWHAwWav8yJQQR9RBhQcaK3crziQfYawtmV6Qxy0ZHAGNDoVOQV
        rmnBv1jnq/DFzbX9WUNSkpAoxKEbOAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651677862;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LFtdU5sZa2A2xB4m690UeZa0E7n83KO9oZPFcN6P5KI=;
        b=PODueHZZt8Z8EMVDAZe0adQTMg5JU53Icu73kv8XJ5/f6yBj0sfoGDdRtEGoAZOFmBDIEa
        QKden8bbU8Q2zmAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36FF1132C4;
        Wed,  4 May 2022 15:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i52VDKaacmLWLgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 04 May 2022 15:24:22 +0000
Date:   Wed, 4 May 2022 17:20:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: zoned: fixes for zone finishing
Message-ID: <20220504152010.GO18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1651624820.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651624820.git.naohiro.aota@wdc.com>
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

On Tue, May 03, 2022 at 05:48:49PM -0700, Naohiro Aota wrote:
> - Changes
>  - v2
>    - Rename some functions/variables.
>    - Intoduce btrfs_zoned_bg_is_full() to check if a block group is fully
>      allocated or not.
>    - Add some more comments.
> 
> * Note: this series depends on "btrfs: zoned: fix zone activation logic"
>   series (patch 1). I found the bug addressed in the series while I'm
>   introducing the helper. 
> 
> Commit be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
> introduced zone finishing a block group when the IO reaches at the end of
> the block group. However, since the zone capacity may not aligned to 16KB
> (node size), we can leave an un-allocatable space at the end of a block
> group. Also, it turned out that metadata zone finishing never works
> actually.
> 
> This series addresses these issues by rewriting metadata zone finishing
> code to use a workqueue to process the finishing work.
> 
> Patch 1 introduces a helper to check if a block group is fully allocated.
> The helper is used in patch 2.
> 
> Patch 2 is a clean-up patch to consolidate zone finishing function for
> better maintainability.
> 
> Patch 3 changes the left region calculation so that it finishes a block
> group when there is no more space left for allocation.
> 
> Patch 4 fixes metadata block group finishing which is not actually working.
> 
> Patch 5 implements zone finishing of an unused block group and fixes active
> block group accounting. This patch is a bit unrelated to other ones. But,
> the patch is tested with the previous patches applied, so let me go with
> the same series.
> 
> Naohiro Aota (5):
>   btrfs: zoned: introduce btrfs_zoned_bg_is_full
>   btrfs: zoned: consolidate zone finish function
>   btrfs: zoned: finish BG when there are no more allocatable bytes left
>   btrfs: zoned: properly finish block group on metadata write
>   btrfs: zoned: zone finish unused block group

Added to misc-next, thanks. I'll update patches with any followup
reviews.
