Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8C5B64A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 02:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIMApp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 20:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIMApn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 20:45:43 -0400
Received: from kyoto-arc.or.jp (ns.kyoto-arc.or.jp [202.252.247.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874FB50734
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 17:45:42 -0700 (PDT)
Received: from [192.168.2.41] ([202.252.247.10]:8725)
        by kyoto-arc.or.jp with [XMail ESMTP Server]
        id <S1685B7> for <linux-btrfs@vger.kernel.org> from <kengo@kyoto-arc.or.jp>;
        Tue, 13 Sep 2022 09:45:39 +0900
Mime-Version: 1.0
X-Sender: kengo@ms.kyoto-arc.or.jp
X-Mailer: QUALCOMM MacOS Classic Eudora Version 6J Jr6
Message-Id: <p06001015df458237c0f7@kyoto-arc.or.jp>
In-Reply-To: <b2f26520f1d000e074d79b5523c5416dc7dc51fe.camel@scientia.org>
References: <p06001014df4577e8554b@kyoto-arc.or.jp>
 <b2f26520f1d000e074d79b5523c5416dc7dc51fe.camel@scientia.org>
Date:   Tue, 13 Sep 2022 09:43:58 +0900
To:     linux-btrfs@vger.kernel.org
From:   "Kengo.M" <kengo@kyoto-arc.or.jp>
Subject: Re: scrub results by email
Content-Type: text/plain; charset="iso-2022-jp" ; format="flowed"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Chris

Thanks

btrfs scrub start -B option
do not background and print scrub statistics when finished

btrfs scrub start -B /mnt/test.btrfs | mail -s "scrub result" foo@baa.com

kengo
At 02:10 +0200 2022.09.13, Christoph Anton Mitterer wrote:
>On Tue, 2022-09-13 at 09:00 +0900, Kengo.M wrote:
>  > I would like to send results of btrfs scrub by email.
>>  How are you all doing?
>
>That's not really a btrfs specific question... but try using btrfs-
>scrub’s -B option.
>
>
>Cheers,
>Chris.

