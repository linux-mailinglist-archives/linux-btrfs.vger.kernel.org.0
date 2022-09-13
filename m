Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1935B7946
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiIMSTd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiIMSTQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 14:19:16 -0400
Received: from rin.romanrm.net (rin.romanrm.net [51.158.148.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE080E8C
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 10:30:13 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 1142250A;
        Tue, 13 Sep 2022 17:30:10 +0000 (UTC)
Date:   Tue, 13 Sep 2022 22:30:09 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     "Kengo.M" <kengo@kyoto-arc.or.jp>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: scrub results by email
Message-ID: <20220913223009.11e1e549@nvm>
In-Reply-To: <p06001015df458237c0f7@kyoto-arc.or.jp>
References: <p06001014df4577e8554b@kyoto-arc.or.jp>
        <b2f26520f1d000e074d79b5523c5416dc7dc51fe.camel@scientia.org>
        <p06001015df458237c0f7@kyoto-arc.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 13 Sep 2022 09:43:58 +0900
"Kengo.M" <kengo@kyoto-arc.or.jp> wrote:

> btrfs scrub start -B option
> do not background and print scrub statistics when finished
> 
> btrfs scrub start -B /mnt/test.btrfs | mail -s "scrub result" foo@baa.com

If you want to run a scheduled scrub from crontab, cron can be made to mail
all output of all cron-issued commands to a designated E-Mail address. Add:

  MAILTO=admin@example.com

on top of the crontab file. Once all crontab output is mailed instead of being
discarded, it may require fine-tuning other scripts and commands you have
scheduled there, by redirecting stdout to "> /dev/null" where reasonable (to
only get notifications of errors). And perhaps set up filters in your mailing
service or web interface, so that all scheduled logs from your machines group
nicely into a designated folder.

-- 
With respect,
Roman
