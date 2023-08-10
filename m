Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D299777E60
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Aug 2023 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjHJQgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Aug 2023 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHJQgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Aug 2023 12:36:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA37A8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Aug 2023 09:36:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BA98A21872;
        Thu, 10 Aug 2023 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691685381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ID9cyyso1QEZXQZa/BYEYu4kJ8Yydm5ODYwadoQ/zWo=;
        b=NRxEIvquCibsy+HSludEH3WN622kTnHf8V4PBVAT6PzHZRmaDfrrZOxXO2EFOhmvZoLHMQ
        xWihM/DP9XpRplbGolpg4KBkG9g7XuKuxYCqmFKjlgYxk4qS17nstLqXR7w8m8mgkBCKdX
        rTjES4rriXbHLtfsMBlBTTH+429iP0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691685381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ID9cyyso1QEZXQZa/BYEYu4kJ8Yydm5ODYwadoQ/zWo=;
        b=jGLL6nvWv/PzoaKszMBxGkHVO2CiV2Aqt5sfun45HF/o/i7uSs8sCByynU0jFPTfEbMAH1
        1+TFOOLQGSuDLeCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9174E138E0;
        Thu, 10 Aug 2023 16:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vWrFIgUS1WRzPQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 10 Aug 2023 16:36:21 +0000
Date:   Thu, 10 Aug 2023 18:29:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v2] btrfs: zoned: do not zone finish data relocation
 block group
Message-ID: <20230810162956.GG2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a57f943e28a5bd86cddcf9d0839b124880f2f6c7.1689924624.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57f943e28a5bd86cddcf9d0839b124880f2f6c7.1689924624.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 04:42:14PM +0900, Naohiro Aota wrote:
> When multiple writes happen at once, we may need to sacrifice a currently
> active block group to be zone finished for a new allocation. We choose a
> block group with the least free space left, and zone finish it.
> 
> To do the finishing, we need to send IOs for already allocated region
> and wait for them and on-going IOs. Otherwise, these IOs fail because the
> zone is already finished at the time the IO reach a device.
> 
> However, if a block group dedicated to the data relocation is zone
> finished, there is a chance that finishing it before an ongoing write IO
> reaches the device. That is because there is timing gap between an
> allocation is done (block_group->reservations == 0, as pre-allocation is
> done) and an ordered extent is created when the relocation IO starts.
> Thus, if we finish the zone between them, we can fail the IOs.
> 
> We cannot simply use "fs_info->data_reloc_bg == block_group->start" to
> avoid the zone finishing. Because, the data_reloc_bg may already switch to
> a new block group, while there are still ongoing write IOs to the old
> data_reloc_bg.
> 
> So, this patch reworks the BLOCK_GROUP_FLAG_ZONED_DATA_RELOC bit to
> indicate there is a data relocation allocation and/or ongoing write to the
> block group. The bit is set on allocation and cleared in end_io function of
> the last IO for the currently allocated region.
> 
> To change the timing of the bit setting also solves the issue that the bit
> being left even after there is no IO going on. With the current code, if
> the data_reloc_bg switches after the last IO to the current data_reloc_bg,
> the bit is set at this timing and there is no one clearing that bit. As a
> result, that block group is kept unallocatable for anything.
> 
> Fixes: 343d8a30851c ("btrfs: zoned: prevent allocation from previous data relocation BG")
> Fixes: 74e91b12b115 ("btrfs: zoned: zone finish unused block group")
> CC: stable@vger.kernel.org # 6.1+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.
