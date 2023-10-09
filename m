Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B7F7BEF74
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 02:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379099AbjJJAGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 20:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377918AbjJJAGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 20:06:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC5DB
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 17:06:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 145B91F7AB;
        Tue, 10 Oct 2023 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696896356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zgiXVkilqGKGKOGwoAfS7SrDcsMj35pSfIfSHXQfFI=;
        b=V7+T8jpYWvcB6fFdWbFaVdJhmrLp92OieJN1jN0mbtbRRf4eZXNImtWYeFhQQwG4IQThOv
        bnW0G6400SXfBRh84uZtRJInLOMABtb1vO0ffLTxOYjEea7G5yQC0FshZc0JcmuraCnAN7
        DF3sJH6YknNzta86B6c2jeO+yW18GCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696896356;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zgiXVkilqGKGKOGwoAfS7SrDcsMj35pSfIfSHXQfFI=;
        b=dIQsEws1bjMhVc1qYyYYEroMXXBkJY0A+HVQB2ndyrNC80YgwZ+A/cXfCUW1t7KOmOx4Zy
        zdIhDAuNnDoZBxBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D61CE1358F;
        Tue, 10 Oct 2023 00:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7aDvMmOVJGW7EwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 10 Oct 2023 00:05:55 +0000
Date:   Tue, 10 Oct 2023 01:59:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH 0/4] btrfs: sysfs and unsupported temp-fsid features for
 clones
Message-ID: <20231009235910.GY28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1696431315.git.anand.jain@oracle.com>
 <20231006150755.GH28758@twin.jikos.cz>
 <9cfb8122-4956-4032-b9ab-2eea8bb19415@oracle.com>
 <dfb5e1fd-6eb3-b0bd-d5c6-0f5f9179eec4@igalia.com>
 <a17167c2-fea3-4f48-b381-d72585b35845@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17167c2-fea3-4f48-b381-d72585b35845@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 01:37:22PM +0530, Anand Jain wrote:
> >> Can Guilherme send an RFC patch for feedback from others and
> >> copy suggested-by. Because, I haven't found a compelling reason
> >> for the restriction, except to improve the user experience.
> 
> My comments about the superblock flag are above.
> 
> User experiences are subjective, so we need others to comment;
> an RFC will help.

A few things changed, the incompat bit was supposed to prevent
accidentally duplicated fsids but with your recent changes this is safe.
This would need to let Guilherme check if the A/B use case still works
but this seems to be so as I'm reading the changelog.

In a controlled environment the incompat bit will not bring much value
other than yet another sanity check preventing some user error, but
related only to the multiple devices.
