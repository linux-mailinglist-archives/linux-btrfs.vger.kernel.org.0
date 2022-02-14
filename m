Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843CF4B55EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 17:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356257AbiBNQTA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 11:19:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356237AbiBNQS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 11:18:59 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A0442EE7
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 08:18:51 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 487BA1F38A;
        Mon, 14 Feb 2022 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644855530;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jkh1YaI5yX4EUXnNQH56VrFi8sJvU7gH1ZL3DXHMAUw=;
        b=YrLcd/7h7AL5i4rOE0m1Tpj+AV9kGMI5EXxYsT+dF8Qe4HVXQDNdHi2/S7XYdfFOOT671V
        BCit0RISkyP2hQAGdg0Yl7mIA6MlM3/mP+h/kQdMnkMPSYHcFdYKEZBmYkdvfEE1kmcnNk
        WgPtxGs+naX3+3SIECCX51ZNJrOjRlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644855530;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jkh1YaI5yX4EUXnNQH56VrFi8sJvU7gH1ZL3DXHMAUw=;
        b=QbKmankE8mhVBEOL1GxAr1g498cHQ0z/jWc9q2BN1WwiywMG4EztvijzEpzwxnR7ZD2jV0
        UAXC8BuRkCJiUbAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 40D31A3B87;
        Mon, 14 Feb 2022 16:18:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B72BADA832; Mon, 14 Feb 2022 17:15:06 +0100 (CET)
Date:   Mon, 14 Feb 2022 17:15:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3 1/2] btrfs: defrag: bring back the old file extent
 search behavior
Message-ID: <20220214161506.GD12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1644561774.git.wqu@suse.com>
 <0dd2be27e93e7db12a3b83bdce48448a1f2f692f.1644561774.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd2be27e93e7db12a3b83bdce48448a1f2f692f.1644561774.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 02:46:12PM +0800, Qu Wenruo wrote:
> @@ -1216,7 +1367,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  		u64 range_len;
>  
>  		last_is_target = false;
> -		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
> +		em = defrag_lookup_extent(&inode->vfs_inode, cur,
> +					  ctrl->newer_than, locked);

This uses the ctrl structure, if this is also supposed to go to 5.16
please provide a version that applies, thanks.
