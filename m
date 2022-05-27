Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0F753648A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbiE0PP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 11:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiE0PPy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 11:15:54 -0400
Received: from mail.cock.li (unknown [37.120.193.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FD24D9C2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 08:15:54 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1653664552; bh=pKrmyVSFxcuGWBmr85l76XxKqT3cDXe9KolpsIC7JU0=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=MRkq7818/wGjBGF+YxpGhZ4NY09Y9F4bPYY1W3MUjI2MUvG9BUA9CZrNjJGQdv5iT
         dv0gVMc6Pgy3l6g27CmWKNyYsiS/X0LTh4QtuR0cYCz7XzHGILJmuSJx3L6SB4mjVZ
         EvRF8c+6et8b4NJD3spqtwjrMmTnc11nHv/ZyO1DvjXy4N1PhBjznYFtMhjCJWSG79
         Sh0AFvqFmrSTnHgkUdHz9LuJsrRpXtx1gAu6cAkNKy8q+iYnrFtmD/05+bK+b/7/5T
         FWLfqNOjZtQG6Yb5TspMUeWFy5isK9zo+XeNKgPyh3OO+qPZ7D0TgWC1biodDvJjqL
         wMF67UVriGxZQ==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 May 2022 16:15:52 +0100
From:   efkf@firemail.cc
To:     Chris Murphy <lists@colorremedies.com>, linux-btrfs@vger.kernel.org
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
In-Reply-To: <4e7fdc9608777774595bf060a028b600@firemail.cc>
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
 <4e7fdc9608777774595bf060a028b600@firemail.cc>
Message-ID: <fb41a636e57f3f7739c22bf12d106102@firemail.cc>
X-Sender: efkf@firemail.cc
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seems like attachments still didn't get attached, sorry
