Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99A36D689F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbjDDQUd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDDQUc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 12:20:32 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650BD40F1
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 09:20:31 -0700 (PDT)
Received: from nvm (nvm.home.romanrm.net [IPv6:fd39::101])
        by len.romanrm.net (Postfix) with SMTP id 33FCF40220;
        Tue,  4 Apr 2023 16:20:28 +0000 (UTC)
Date:   Tue, 4 Apr 2023 21:20:27 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <20230404212027.3730905d@nvm>
In-Reply-To: <ZCxKc5ZzP3Np71IC@infradead.org>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
        <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
        <ZBq+ktWm2gZR/sgq@infradead.org>
        <20230323222606.20d10de2@nz>
        <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
        <ZCxKc5ZzP3Np71IC@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 4 Apr 2023 09:04:03 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> > I also heard people saying these discard storms might reduce the life
> > time of some devices - is that true?
> 
> Also very much possible.  There are various SSDs that treat a discard
> as a write zeroes and always return zeroes from all discarded blocks.
> If the discards are smaller than or not aligned to the internal erase
> (super)blocks, this will actually cause additional writes.

SSDs do not physically erase blocks on discard, that would be very slow.

Instead they nuke corresponding records in the Flash translation layer (FTL)
tables, so that the discarded areas point "nowhere" instead of the actual
stored blocks. And when facing such pointers on trying to resolve read
requests, the controller knows to just return zeroes.

Of course there can be varying behaviors per SSD, e.g. I know of some that
return random garbage instead of zeroes, and some which for a puzzling reason
prefer to return the byte FF instead. But I think the 1st point above should
be universal, pretty certain there are none where a discard/TRIM would take
comparable time to "dd if=/dev/zero of=/dev/ssd" (making it unusable in
practice).

-- 
With respect,
Roman
