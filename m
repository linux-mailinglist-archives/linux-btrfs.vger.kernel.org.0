Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5856E4FC2EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348754AbiDKRM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348752AbiDKRMZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 13:12:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265112408C
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 10:10:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D241A1F7AD;
        Mon, 11 Apr 2022 17:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649697008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JaKyefBYcHwgpPBHesNjTpOYm2++QKpLsXe2ClmfYUM=;
        b=bAo4i5D3iqJyHYGLAeG3+naKiQnO51KaWkJS3LX/sH+SIc2KccqhZFh0/6ZnnUUc5dsGh/
        jwYODHG/jRBYjmuieS94RQq9vAf0J97O786IIG/Eh6U5buxug/mCz9MmrxL9N9p/atnMTh
        6GtkgimVzsPYrgsXQesT5u10uolG480=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649697008;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JaKyefBYcHwgpPBHesNjTpOYm2++QKpLsXe2ClmfYUM=;
        b=xeNw68ID71WDSOiVgmBVF5Ts6jVJQaaqLFf8JZki+Ta2wtMxx0ouHopLSWOrIJicOnHQaq
        7Em6ots93uZurnDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CA2B7A3B82;
        Mon, 11 Apr 2022 17:10:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5D285DA7F7; Mon, 11 Apr 2022 19:06:04 +0200 (CEST)
Date:   Mon, 11 Apr 2022 19:06:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: submit_read_repair() cleanup
Message-ID: <20220411170604.GS15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <9e29ec4e546249018679224518a465d0240912b0.1647841657.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e29ec4e546249018679224518a465d0240912b0.1647841657.git.wqu@suse.com>
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

On Mon, Mar 21, 2022 at 01:48:42PM +0800, Qu Wenruo wrote:
> Cleanup the function submit_read_repair() by:
> 
> - Remove the fixed argument submit_bio_hook()
>   The function is only called on buffered data read path, so the
>   @submit_bio_hook argument is always btrfs_submit_data_bio().
> 
>   Since it's fixed, then there is no need to pass that argument at all.
> 
> - Rename the function to submit_data_read_repair()
>   Just to be more explicit on all the 3 things, data, read and repair.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
