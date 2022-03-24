Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8E4E65E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 16:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbiCXPSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiCXPSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 11:18:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FBEABF53
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 08:16:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39F00210FD;
        Thu, 24 Mar 2022 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648134999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cg6I39UR+bl+hwkm8JHS0fUoeYxWDJjZvnrZ2/3QICI=;
        b=Cobn9DBCtS0plfSyeNUFyJ+3AX6uFbIAyTJMMEP//bHAI8+I37R59+VtwfXligOPf1SuXy
        YyK76axfgKjwcvPMnV/i5JOClXw2PhBkM0ru2rcaX+bHuB0brAJo/I7TIG3+Cn1suTxUgo
        yvwYAQf5kdDHS346CdRbtm9KG8MsRak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648134999;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cg6I39UR+bl+hwkm8JHS0fUoeYxWDJjZvnrZ2/3QICI=;
        b=D6tV+Mne2yU9XzvjOKuLyxkHvkyOFNR9Keti/ciJEhKbSXrU9VroZKctbVcBvjmG/cohOH
        HPj1dfA3NT+mVkDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 23FDBA3B8A;
        Thu, 24 Mar 2022 15:16:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 693F7DA7F3; Thu, 24 Mar 2022 16:12:44 +0100 (CET)
Date:   Thu, 24 Mar 2022 16:12:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: add check and repair ability for super
 num devices mismatch
Message-ID: <20220324151244.GI2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1646009185.git.wqu@suse.com>
 <20220323171759.GB2237@twin.jikos.cz>
 <15fcb764-d25a-6424-2560-25e4ce3baf7b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15fcb764-d25a-6424-2560-25e4ce3baf7b@gmx.com>
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

On Thu, Mar 24, 2022 at 07:30:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/24 01:17, David Sterba wrote:
> > On Mon, Feb 28, 2022 at 08:50:06AM +0800, Qu Wenruo wrote:
> >> The patchset can be fetched from github:
> >> https://github.com/adam900710/btrfs-progs/tree/super_num_devs
> >>
> >> The 2nd patch contains a compressed raw image, thus it may be a little
> >> too large for the mail list.
> >
> > The compressed size is 22K, that's fine. I've recompressed it with 'xz
> > --best -e' and it shaved a few hundred bytes but that was just out of
> > curiosity.
> 
> I'm also a little interested in why things like zstd/xz is not that
> efficient in compressing raw btrfs images.

I think it is efficient, unpacked image was 128M and getting that to 22K
is a good result.

> Especially when creating the image I have created the image with all
> zero (fallocated) file in the first place, thus most space should just
> be all zero, and any compression method should be super efficient on them.
> 
> My current guesses are:
> 
> - DUP metadata is not fully detected by the algo
>    Especially when they are mostly quite some ranges away
> 
> - Some older tree blocks from mkfs
> 
> So for further raw image size reduction, we may want to:
> 
> - Use SINGLE metadata/data
> 
> - Fstrim the image first

Yeah that could remove any stale blocks.
