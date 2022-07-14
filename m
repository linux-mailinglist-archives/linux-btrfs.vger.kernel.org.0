Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B13574F1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 15:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiGNNZX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 09:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239597AbiGNNZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 09:25:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382295E319
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 06:25:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC30F1FB51;
        Thu, 14 Jul 2022 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657805099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fC2MjHK9n7KUf/BsOvT2du/0xxET+2IitLzYKsyJj2I=;
        b=QLoiBVVlSB3FYEKCaLmZ+1DCrsLKDKmf8gUYFfIlHgLmP8T0bNdu/m1FZ66Tomv67FNvLu
        1L9RhAeDjk7+TatLBhFJiD6L9nKIkEUz/oDlA+3HcEF4OByia8SJfHQmjp5kQyhrgvjO53
        Xyu/Nhfiv1Yz0DBRxqIodbqFQXKOjOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657805099;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fC2MjHK9n7KUf/BsOvT2du/0xxET+2IitLzYKsyJj2I=;
        b=952qsqflxYywRRkPX2ngnxksKfNeYlwk4elFnG5+JvOgx2jHQpijw7qlGtyTfx0doYV1GE
        BkM5qrmzcaPSHYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C74E613A61;
        Thu, 14 Jul 2022 13:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N/BKLysZ0GIuGAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Jul 2022 13:24:59 +0000
Date:   Thu, 14 Jul 2022 15:20:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Ioannis Angelakopoulos <iangelak@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 1/2] btrfs: Add a lockdep model for the num_writers wait
 event
Message-ID: <20220714132009.GM15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Ioannis Angelakopoulos <iangelak@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <20220708200829.3682503-1-iangelak@fb.com>
 <20220708200829.3682503-2-iangelak@fb.com>
 <PH0PR04MB7416DCB82032542A95F5A7599B899@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416DCB82032542A95F5A7599B899@PH0PR04MB7416.namprd04.prod.outlook.com>
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

On Wed, Jul 13, 2022 at 03:43:14PM +0000, Johannes Thumshirn wrote:
> On 08.07.22 22:10, Ioannis Angelakopoulos wrote:
> > +#define btrfs_might_wait_for_event(b, lock) \
> > +	do { \
> > +		rwsem_acquire(&b->lock##_map, 0, 0, _THIS_IP_); \
> > +		rwsem_release(&b->lock##_map, _THIS_IP_); \
> > +	} while (0)
> > +
> > +#define btrfs_lockdep_acquire(b, lock) \
> > +	rwsem_acquire_read(&b->lock##_map, 0, 0, _THIS_IP_)
> > +
> > +#define btrfs_lockdep_release(b, lock) \
> > +	rwsem_release(&b->lock##_map, _THIS_IP_)
> 
> Shouldn't this be only defined for CONFIG_LOCKDEP=y and be
> stubbed out for CONFIG_LOCKDEP=n?

Yes, all related code should be under the lockdep ifdef, struct
lockdep_map btrfs_trans_num_writers_map too.
