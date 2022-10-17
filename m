Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA586013E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJQQu4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJQQuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 12:50:54 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699295C943
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 09:50:52 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 40B564003F;
        Mon, 17 Oct 2022 16:50:47 +0000 (UTC)
Date:   Mon, 17 Oct 2022 21:50:46 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Lionel Bouton <lionel-subscription@bouton.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs-progs] btrfs filesystem defragment now outputs processed
 filenames ?
Message-ID: <20221017215046.6e29e7bb@nvm>
In-Reply-To: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
References: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 17 Oct 2022 13:32:03 +0200
Lionel Bouton <lionel-subscription@bouton.name> wrote:

> This isn't a big problem and it is easily fixable in my scheduler but I 
> was wondering if there is any plan to allow silencing it or should I 
> just cleanup the ouput before forwarding it (I prefer to write any 
> unexpected output in logs instead of ignoring everything) ?

If there wasn't a "--quiet", the usual approach would be to discard stdout and
log stderr; or log stdout, but log and mail stderr. So you only get notified
of any errors, and not the normal operation output. That's assuming btrfs
progs follow the good practice and designate printed messages accordingly
between these two (I did not check).

-- 
With respect,
Roman
