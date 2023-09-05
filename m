Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D8E7925A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbjIEQCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354635AbjIENJU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 09:09:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E287912E
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 06:09:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A66CA21A41;
        Tue,  5 Sep 2023 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693919355;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8etBUPQetD60UC6hSCH3CHQZnjFjyoOaVvTagMXOXdw=;
        b=c6BwPFY5anSO7xHqWCidvANWEPPa8lSpomDXdCSvkZSydrlu83hlHp26zX/5siTPr1fU3h
        2MntQCxcmw48c9R2iDHdfS8j6vrHC10yXyuAuQkVsDOtszoH+n5ezhe91HIWZMQjE/mkTs
        cy5ubAw9l1zO47BZyoExHKnB1oCztFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693919355;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8etBUPQetD60UC6hSCH3CHQZnjFjyoOaVvTagMXOXdw=;
        b=vKaZ/x0an5C54EMtPd2Y2Etc8cacX8Zgsd4+aWLChOsuU7O9ldaRwcc+eN0mHev0Kl+kjS
        hzt3zbyU6/CDzDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 763E813499;
        Tue,  5 Sep 2023 13:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NEcvHHso92QALAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 13:09:15 +0000
Date:   Tue, 5 Sep 2023 15:02:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2 5/6] btrfs: qgroup: use qgroup_iterator facility to
 replace @tmp ulist of qgroup_update_refcnt()
Message-ID: <20230905130235.GX14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693441298.git.wqu@suse.com>
 <ce02f493bf56e540679db37393a9ca243b20c012.1693441298.git.wqu@suse.com>
 <20230901131650.GL14420@twin.jikos.cz>
 <384937d2-78ce-48d0-a6d1-751fee0d953b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384937d2-78ce-48d0-a6d1-751fee0d953b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Sep 02, 2023 at 08:16:52AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/9/1 21:16, David Sterba wrote:
> > Please don't put the @ in the variable references in the subjects.
> 
> Now removed, but I'm wondering what's the guideline for referring the
> variable names in the commit message/subject line?

In subject it should be plain reference, unquoted and untagged.

> I didn't remember when but I have seen such "@" prefix for variable
> names in the mailing list, thus I followed the scheme.
>
> If there is a guideline it can help me from causing more damage in the
> future.

The guideline has been there for a few years at
https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Development_notes.html#Patches
after I reminded people to not do it, but this never sticks for long.
