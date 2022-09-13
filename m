Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655785B7B82
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 21:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIMTku (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 15:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIMTkt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 15:40:49 -0400
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4128276771
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 12:40:48 -0700 (PDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 66ED0E63A6; Tue, 13 Sep 2022 15:40:47 -0400 (EDT)
References: <p06001014df4577e8554b@kyoto-arc.or.jp>
 <b2f26520f1d000e074d79b5523c5416dc7dc51fe.camel@scientia.org>
 <p06001015df458237c0f7@kyoto-arc.or.jp> <20220913223009.11e1e549@nvm>
User-agent: mu4e 1.7.12; emacs 27.1
From:   Phillip Susi <phill@thesusis.net>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     "Kengo.M" <kengo@kyoto-arc.or.jp>, linux-btrfs@vger.kernel.org
Subject: Re: scrub results by email
Date:   Tue, 13 Sep 2022 15:39:06 -0400
In-reply-to: <20220913223009.11e1e549@nvm>
Message-ID: <87o7vjyse8.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Roman Mamedov <rm@romanrm.net> writes:

> If you want to run a scheduled scrub from crontab, cron can be made to mail
> all output of all cron-issued commands to a designated E-Mail address. Add:
>
>   MAILTO=admin@example.com

And it defaults to sending it to $USER@localhost, so you only need to
bother with MAILTO= if you want it to go to a different mailbox.

