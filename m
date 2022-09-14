Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2265B7F29
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 05:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiINDCM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 23:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINDCK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 23:02:10 -0400
Received: from kyoto-arc.or.jp (ns.kyoto-arc.or.jp [202.252.247.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2C6BD43
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 20:02:07 -0700 (PDT)
Received: from [192.168.2.41] ([202.252.247.10]:28200)
        by kyoto-arc.or.jp with [XMail ESMTP Server]
        id <S168714> for <linux-btrfs@vger.kernel.org> from <kengo@kyoto-arc.or.jp>;
        Wed, 14 Sep 2022 12:02:03 +0900
Mime-Version: 1.0
X-Sender: kengo@ms.kyoto-arc.or.jp
X-Mailer: QUALCOMM MacOS Classic Eudora Version 6J Jr6
Message-Id: <p06001037df46f415a7b6@kyoto-arc.or.jp>
In-Reply-To: <87o7vjyse8.fsf@vps.thesusis.net>
References: <p06001014df4577e8554b@kyoto-arc.or.jp><b2f26520f1d000e074d79b5523c5416dc7
 dc51fe.camel@scientia.org><p06001015df458237c0f7@kyoto-arc.or.jp>
 <20220913223009.11e1e549@nvm> <87o7vjyse8.fsf@vps.thesusis.net>
Date:   Wed, 14 Sep 2022 12:00:23 +0900
To:     linux-btrfs@vger.kernel.org
From:   "Kengo.M" <kengo@kyoto-arc.or.jp>
Subject: Re: scrub results by email
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Roman,Phillip

Thank your information.

btrfs scrub start -B /mnt/test.btrfs | mail -s "scrub result" foo@baa.com

The above script was succeeded

And I would like to use that your suggestion.
Also,I use debian(bullseye) with msmtp.

Thanks

kengo
