Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A2360DCD8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiJZIOq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiJZIOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 04:14:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACF118399;
        Wed, 26 Oct 2022 01:14:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FDB722029;
        Wed, 26 Oct 2022 08:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666772081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SD3QMwyS+ZUTaFP2Tk/T8hZPNAT2QJ5hUJJf1eQUrwk=;
        b=VyxfC/qwjmoVh8np5Xb8Oz+4eaUp2SYzuUGT9tt2ZNLZ2CaeXsx9Dc4bQcGpDdeLzvwiHt
        t4D8f6UELZChjDvITZnqppa8d/MEDDS7ieH9Pz/FQMLQMwMnw9iJWsbddViyN/5iHPT84R
        IGVihk7YMEiSqL6Cmtnw+0A0gBrf3l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666772081;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SD3QMwyS+ZUTaFP2Tk/T8hZPNAT2QJ5hUJJf1eQUrwk=;
        b=msOw3yfYoDm/GRmwl7t6vUgfiFdGxrVETGJmQiQQ6b5v4GbxYNTBlCwNcm+PQf5NCRAkhr
        ugVQ45cUThwY7PAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2373E13A77;
        Wed, 26 Oct 2022 08:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id omXKB3HsWGM2OAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 26 Oct 2022 08:14:41 +0000
Date:   Wed, 26 Oct 2022 10:14:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     syzbot <syzbot+858534c396b0cdd291d2@syzkaller.appspotmail.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "sweettea-kernel@dorminy.me" <sweettea-kernel@dorminy.me>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in cow_file_range_inline
Message-ID: <20221026081426.GP5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000080bb5c05ebe34a4d@google.com>
 <b9fb66a0-5516-d1d4-34d6-da91c60c56cf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9fb66a0-5516-d1d4-34d6-da91c60c56cf@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 26, 2022 at 07:30:02AM +0000, Johannes Thumshirn wrote:
> On 26.10.22 00:19, syzbot wrote:

> Not sure how applicable this is. The reproducer configures failslab to
> fail every 16th call and then complains about -ENOMEM ¯\_(ツ)_/¯

This still has some value I think, though we can't do much when an
ENOMEM is hit, at least from this report I see the way it's reported
back to user can be improved.

For EIO and EUCLEAN we don't dump the full stack trace because such
errors can happen during testing a lot, we may add ENOMEM as well. The
stack is supposed to be noisy for errors we want to know about, eg.
ENOSPC during transaction commit that would point to a bug in the
reservations.
