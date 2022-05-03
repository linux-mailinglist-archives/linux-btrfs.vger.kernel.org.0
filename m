Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A24517F42
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiECIAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiECIAx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:00:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E51F638
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 00:57:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 41B0F1F74A;
        Tue,  3 May 2022 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651564640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWdlJtqTDpD5tTvRa5VYrC8RZra1BvwMChh48BnfIy8=;
        b=RwERDSUWWI46qUequ9AYteidkpR3o5HkSJ4YmgI/SSlzgTHttChdsC3lhKAXOYVLWMG3D8
        9D/wxwbOKp7UheYvKoVomPVfhW5f1Fme+ORqHehYrmFi7L58GVhYzNsZ5ipzWt6BtKa2rE
        hPhAu1BQIWKQB+JrW5Z1dkOzv65f4Pg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19CDC13ABE;
        Tue,  3 May 2022 07:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qLSKA2DgcGJ6KgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 03 May 2022 07:57:20 +0000
Message-ID: <88811bd1-9a08-ae1b-8140-3e354c118792@suse.com>
Date:   Tue, 3 May 2022 10:57:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/9] Structre and parameter cleanups
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1651255990.git.dsterba@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <cover.1651255990.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 29.04.22 г. 21:27 ч., David Sterba wrote:
> Simplify some argument passing, remove too-trivial helpers or unused
> structure members.
> 
> David Sterba (9):
>    btrfs: sink parameter is_data to btrfs_set_disk_extent_flags
>    btrfs: remove btrfs_delayed_extent_op::is_data
>    btrfs: remove unused parameter bio_flags from btrfs_wq_submit_bio
>    btrfs: remove trivial helper update_nr_written
>    btrfs: simplify handling of bio_ctrl::bio_flags
>    btrfs: open code extent_set_compress_type helpers
>    btrfs: rename io_failure_record::bio_flags to compress_type
>    btrfs: rename bio_flags in parameters and switch type
>    btrfs: rename bio_ctrl::bio_flags to compress_type
> 
>   fs/btrfs/ctree.c       |  2 +-
>   fs/btrfs/ctree.h       |  5 ++-
>   fs/btrfs/delayed-ref.c |  4 +--
>   fs/btrfs/delayed-ref.h |  1 -
>   fs/btrfs/disk-io.c     |  5 ++-
>   fs/btrfs/disk-io.h     |  3 +-
>   fs/btrfs/extent-tree.c | 10 +++---
>   fs/btrfs/extent_io.c   | 73 ++++++++++++++++++------------------------
>   fs/btrfs/extent_io.h   | 22 ++-----------
>   fs/btrfs/inode.c       | 10 +++---
>   10 files changed, 50 insertions(+), 85 deletions(-)
> 


FWIW:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

(I did look at the patches that have been merged into misc-next with the 
compression type fixed up) .
