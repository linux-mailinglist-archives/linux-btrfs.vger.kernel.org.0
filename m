Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D37A1884
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjIOIWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjIOIWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 04:22:42 -0400
X-Greylist: delayed 787 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Sep 2023 01:19:24 PDT
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C73C25
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Sep 2023 01:19:23 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:06:12 +0200
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     Leonidas Spyropoulos <artafinde@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Mailing List missing messages
Message-ID: <1694764946@msgid.manchmal.in-ulm.de>
References: <cb777ab6-f1c5-4b8b-b3a9-2304e2ea9aec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb777ab6-f1c5-4b8b-b3a9-2304e2ea9aec@gmail.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Leonidas Spyropoulos wrote...

> I've noticed the Mailing List archives contain messages I never received
> in my email. Anyone else experienced this issue?

This may or may not be related to what's written in
https://social.afront.org/@warthog9/111050845570244562

| Well, vger (as of right now) no longer directly attempts to deliver to
| gmail/google/googlemail just to get the ridiculous backlog out of the primary
| mail paths. Vger (1 machine) is kicking all of that queue over to 8 other
| machines and letting them go try to get that delivered and queue up somewhere
| where it's not going to cause everyone else pain.
|
| This should, at least for now, settle out several things, but if you are
| seeing mail wonkiness give postmaster@ a ping and I'll take a look.
|
| Also if you are on Gmail and doing kernel dev, might be worth looking at other
| email providers.

And a follow-up:

| All of this would be workable if there was a means to reach out, but that's
| particularly hard and slow with them. So yeah there's thousands of gmail users
| I can absolutely confirm haven't been getting vger related traffic because of
| the push backs and there's little from the vger end we can do about it.

