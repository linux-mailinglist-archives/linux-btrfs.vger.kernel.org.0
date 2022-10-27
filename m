Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B15260FABE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 16:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiJ0Oq3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Oct 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiJ0Oq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Oct 2022 10:46:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5AA4F1B7
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Oct 2022 07:46:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D30171F8D4;
        Thu, 27 Oct 2022 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666881985;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPSMtzL7DHiCjyXrWwsidlU219DuD1o/vinWX9rH9HU=;
        b=SzCRFdLApXSTRXCHmzV5TX/RFtnORELzrdiDL4QH/Xr+IfPHUNiYd5qFogt+OANMe/FyEI
        BB84EOdLM+WtisBWF3PdXIU6UGBehPcQCAUffWXXCUB6pxgRL1u1Xfs/s2KYZPgDAZ406m
        E7C2OhviMtkAVh6pXDARH8IBwO4mG2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666881985;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YPSMtzL7DHiCjyXrWwsidlU219DuD1o/vinWX9rH9HU=;
        b=6XRNbyEBwmYlqKpPJgcky8GTo/HZB8AXTIJx3uCiMZmmBBT20rFw7wzl2APdC/enCsHjMy
        dTR9xxsl7bnwP8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9786134CA;
        Thu, 27 Oct 2022 14:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VK1zKMGZWmOMGwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Oct 2022 14:46:25 +0000
Date:   Thu, 27 Oct 2022 16:46:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: btrfs_get_extent() cleanup for inline
 extents
Message-ID: <20221027144610.GW5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1663312786.git.wqu@suse.com>
 <20221025140851.GL5824@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025140851.GL5824@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 25, 2022 at 04:08:51PM +0200, David Sterba wrote:
> > v2:
> > - Do better patch split for bisection with better reason
> > 
> > - Put the selftest to the first to help bisection
> >   Or we may hit ASSERT() during selftest.
> > 
> > Qu Wenruo (5):
> >   btrfs: selftests: remove impossible inline extent at non-zero file
> >     offset
> >   btrfs: make inline extent read calculation much simpler
> >   btrfs: do not reset extent map members for inline extents read
> >   btrfs: remove the @new_inline argument from
> >     btrfs_extent_item_to_extent_map()
> >   btrfs: extract the inline extent read code into its own function
> 
> I did a quick review, code looks ok for inclusion to for-next.

Moved to misc-next, thanks.
