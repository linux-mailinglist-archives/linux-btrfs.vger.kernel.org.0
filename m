Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBAA727F7C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 13:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjFHLym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjFHLyl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 07:54:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFC11FEB
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 04:54:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5D31FDCA;
        Thu,  8 Jun 2023 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686225278;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+KP1u9aOzuVec+xDENikBr3uf5dy9EPyk6XWGm0AIs=;
        b=RXXgqHv91CAx9IIh+4ciqiaa3f//V8x0N9qVEdnUDpk2WQmAWnVej5k9mswbHj2NzG+jzF
        JVuBNkDgZUzBp3b71EATY1thL8nvWBqBGNgRfSzWyxvMkaDKTnzLL/iH4FxyRz4c+t5wxG
        PCxs0W+HXkuArAZya/M+VbTtIR8xTCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686225278;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+KP1u9aOzuVec+xDENikBr3uf5dy9EPyk6XWGm0AIs=;
        b=MkiTSkolbjgaESZYN53AEudmYNLbVAHGSBvPAgYDifze8ibTuxmJE+TULVNM+w93NE2o01
        ADnnt5BZel0FCWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13CC4138E6;
        Thu,  8 Jun 2023 11:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QTD5A37BgWSMMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 08 Jun 2023 11:54:38 +0000
Date:   Thu, 8 Jun 2023 13:48:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Filipe Manana <fdmanana@kernel.org>,
        Naohiro Aota <naota@elisp.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: reinsert BGs failed to reclaim
Message-ID: <20230608114821.GA28933@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1686028197.git.naohiro.aota@wdc.com>
 <e8acfcfefeb3156e11e60ea97dcd2c6ecf984101.1686028197.git.naohiro.aota@wdc.com>
 <CAL3q7H5=dxzeGELzge_wJQJuRF8gzd_1SAm3O6QxcMB7HpSJkw@mail.gmail.com>
 <20230606162323.GJ25292@twin.jikos.cz>
 <j3bvyy4t3shzvfgylu6hc4affajij7orrh6fhqhstny3kushnx@nek7y5p7odqg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <j3bvyy4t3shzvfgylu6hc4affajij7orrh6fhqhstny3kushnx@nek7y5p7odqg>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 06, 2023 at 11:55:48PM +0000, Naohiro Aota wrote:
> On Tue, Jun 06, 2023 at 06:23:23PM +0200, David Sterba wrote:
> > On Tue, Jun 06, 2023 at 11:25:23AM +0100, Filipe Manana wrote:
> > > On Tue, Jun 6, 2023 at 7:04 AM Naohiro Aota <naota@elisp.net> wrote:
> > > > +                       spin_lock(&fs_info->unused_bgs_lock);
> > > > +                       if (list_empty(&bg->bg_list))
> > > > +                               list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
> > > > +                       else
> > > > +                               btrfs_put_block_group(bg);
> > > > +                       spin_unlock(&fs_info->unused_bgs_lock);
> > > > +                       spin_unlock(&bg->lock);
> > > > +               }
> > > 
> > > Also, this is very similar to btrfs_mark_bg_to_reclaim(), so we should
> > > use that, and simply have:
> > > 
> > > btrfs_mark_bg_to_reclaim();
> > > btrfs_put_block_group(bg);
> 
> Yeah, this looks nice. Thank you.
> 
> > 
> > I can fold the diff below if you agree
> > 
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1833,18 +1833,9 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >                 }
> >  
> >  next:
> > -               if (!ret) {
> > -                       btrfs_put_block_group(bg);
> > -               } else {
> > -                       spin_lock(&bg->lock);
> > -                       spin_lock(&fs_info->unused_bgs_lock);
> > -                       if (list_empty(&bg->bg_list))
> > -                               list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
> > -                       else
> > -                               btrfs_put_block_group(bg);
> > -                       spin_unlock(&fs_info->unused_bgs_lock);
> > -                       spin_unlock(&bg->lock);
> > -               }
> > +               if (!ret)
> > +                       btrfs_mark_bg_to_reclaim(bg);
> 
> Thank you for folding this, but the condition is flipped.  We should add it
> back to the list in a failure case.

Ah right, fixed and pushed. The whole diff becomes:

               if (ret)
                       btrfs_mark_bg_to_reclaim(bg);
