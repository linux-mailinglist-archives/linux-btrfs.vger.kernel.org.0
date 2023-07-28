Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC1E7675C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjG1Spd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjG1Spc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 14:45:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0212CE
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:45:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 718FB1F855;
        Fri, 28 Jul 2023 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690569930;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Xq9P16lLWP4XRNhEeuNPSUT2hp902a0kEUO9gUh65A=;
        b=Qb8lXBcychmsQHzTXXej5mLBfm4BVQXa/9x/udLzGNUfBoueWUmYDhLpsBUEUYqDwKV/ZQ
        s0jrQ9ejixADsQupF76SUIFx30DvDlrW8JMntBGiUwLV34+qBe74mURgMkCFwVK/03sfns
        Jk9/0m0wxB3ZO78zy7v2wmdqp9cvcws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690569930;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Xq9P16lLWP4XRNhEeuNPSUT2hp902a0kEUO9gUh65A=;
        b=gAAnFQEzgV2Hs9bCiMpIpHZRDJctwkTzRfOEChYrWWQjdzqboO7qdtFuT6zjT2ZX1XroUE
        9wDs7g9wonNloOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48C0B13276;
        Fri, 28 Jul 2023 18:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GEXYEMoMxGQxEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 28 Jul 2023 18:45:30 +0000
Date:   Fri, 28 Jul 2023 20:39:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: simplify memcpy for either metadata_uuid or
 fsid.
Message-ID: <20230728183907.GK17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690541079.git.anand.jain@oracle.com>
 <ae10e7c26537465368445d379c660fc8be62ad8b.1690541079.git.anand.jain@oracle.com>
 <CAL3q7H6nGQWdvpNr6GUC_4eGpveH5ttdqn78XXFw0Ux-A+7MLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6nGQWdvpNr6GUC_4eGpveH5ttdqn78XXFw0Ux-A+7MLg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 28, 2023 at 06:40:39PM +0100, Filipe Manana wrote:
> On Fri, Jul 28, 2023 at 5:43 PM Anand Jain <anand.jain@oracle.com> wrote:
> >
> > This change makes the code more readable.
> >
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
> > ---
> >  fs/btrfs/volumes.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 5678ca9b6281..4ce6c63ab868 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -833,14 +833,10 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >                     found_transid > fs_devices->latest_generation) {
> >                         memcpy(fs_devices->fsid, disk_super->fsid,
> >                                         BTRFS_FSID_SIZE);
> > -
> > -                       if (has_metadata_uuid)
> > -                               memcpy(fs_devices->metadata_uuid,
> > -                                      disk_super->metadata_uuid,
> > -                                      BTRFS_FSID_SIZE);
> > -                       else
> > -                               memcpy(fs_devices->metadata_uuid,
> > -                                      disk_super->fsid, BTRFS_FSID_SIZE);
> > +                       memcpy(fs_devices->metadata_uuid,
> > +                              has_metadata_uuid ?
> > +                               disk_super->metadata_uuid : disk_super->fsid,
> > +                              BTRFS_FSID_SIZE);
> 
> While there's less lines of code, I don't find having a long ternary
> operation in the middle of a function call, split in two lines, more
> readable than the existing if-else statement, quite the contrary.

Agreed, one line of code doing one thing is readable.
