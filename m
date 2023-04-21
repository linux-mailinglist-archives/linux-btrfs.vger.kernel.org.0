Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844EA6EADF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjDUPXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjDUPXh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 11:23:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5758FC155
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 08:23:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 942CB218D5;
        Fri, 21 Apr 2023 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682090614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maUAPJ5yQXFJInMrPkb4oz7uH91KdN2wCyCDFfKFniA=;
        b=pEwm+8JGj3qCa6z7D57tOYKqivUzJSDJL1MVlGmvvjQ9u0izrKXnzMMm5Zei5n08X65q4A
        uZNtO1SRTc6ZIwMJ5x7tmhLgUqxUFpqKD92+VuFskGCoLez7V43X/eSLA4ooLwhpWPWRKx
        drdZqJD+SIpHlgkM5gSMtpNBd5CxT1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682090614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=maUAPJ5yQXFJInMrPkb4oz7uH91KdN2wCyCDFfKFniA=;
        b=TFaUzjd3/YrEfjsajOrh7OMLwa32dIG5ti5oc/3+iZnLdGem2eEt8KWcORqT3qhsLu1fPm
        w3gF/87HtiqWP7Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B92D1390E;
        Fri, 21 Apr 2023 15:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vLJiGXaqQmQ5GwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 21 Apr 2023 15:23:34 +0000
Date:   Fri, 21 Apr 2023 17:23:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH] btrfs: don't commit transaction for every subvol create
Message-ID: <20230421152323.GA19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <61e8946ae040075ce2fe378e39b500c4ac97e8a3.1681151504.git.sweettea-kernel@dorminy.me>
 <20230417184635.GL19619@twin.jikos.cz>
 <9472eb7d-9daa-54c0-2d33-740edf509542@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9472eb7d-9daa-54c0-2d33-740edf509542@dorminy.me>
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

On Fri, Apr 21, 2023 at 08:58:54AM -0400, Sweet Tea Dorminy wrote:
> 
> > 
> > So I think it's safe and allows the use case of creating many subvolumes
> > without the full transaction commit overhead. And we don't need the
> > commandline options. Added to misc-next, thanks.
> 
> Just to check, have you pushed misc-next containing this to github? I 
> can't find it in git log.

Maybe I forgot to push the latest changes, now pushed.
