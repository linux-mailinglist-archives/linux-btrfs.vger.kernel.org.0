Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66681666501
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 21:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAKUts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 15:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjAKUto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 15:49:44 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37161057A
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 12:49:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 621A734639;
        Wed, 11 Jan 2023 20:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673470180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AKDGjPn9OuyiC7+agQVn74JT+d1Q6iT72HASwe1ey6U=;
        b=BoklU2dX4WTOYK3O2N/kU4hh9xTzV3I7s2VwnP8uD+UWHIctkqxL9RuGyGsNnD8d/QGkbj
        YEqHei2OtHo2X4F9e3VJy7Wvw6A552BTmAovSudG/deV+yg4CbpCjjcbHIyQVy10pWX2OQ
        bdhVyLctw/JzkDu2chXCtAAz7ooxxzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673470180;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AKDGjPn9OuyiC7+agQVn74JT+d1Q6iT72HASwe1ey6U=;
        b=d77faUzx0sYRsqmGuXVBVCSHxmoI38wsiBFvu+MciKyzieAINtv0ykHh5hsED0JbRjN0jk
        ihhzs8qzTcRDksCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36E5E1358A;
        Wed, 11 Jan 2023 20:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4+9mDOQgv2PyUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 11 Jan 2023 20:49:40 +0000
Date:   Wed, 11 Jan 2023 21:44:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/8] btrfs: do not check header generation in
 btrfs_clean_tree_block
Message-ID: <20230111204405.GK11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1670451918.git.josef@toxicpanda.com>
 <ef73c4c67028f9e7d770dca236367f1ea0b56b55.1670451918.git.josef@toxicpanda.com>
 <0507a942-2a82-f086-2be5-a9ac64e4c1d3@gmx.com>
 <6f22220e-f660-92d2-5241-fb9a353090ac@gmx.com>
 <20230110153343.GF11562@twin.jikos.cz>
 <583a78e0-8dd0-b6e1-ca50-4977940013b9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <583a78e0-8dd0-b6e1-ca50-4977940013b9@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 11, 2023 at 07:03:06AM +0800, Qu Wenruo wrote:
> > I've temporarily removed the patchset from for-next so we don't have
> > test failures over the holidays, now it's time to add it back, but based
> > on the above there are changes needed, right? If yes, I'll wait for the
> > update.
> 
> I believe we should drop this patch from the series.
> 
> But since it's at the very beginning of the series, and a lot of later 
> patches are depending on it, it needs some work to resolve it.

Ok, so it's for Josef, please have a look.
