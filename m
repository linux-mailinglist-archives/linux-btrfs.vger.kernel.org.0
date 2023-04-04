Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3EB6D68CD
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjDDQ2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbjDDQ2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 12:28:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A75524E
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U0tD5J9TA2TwcEAaIhY+91JkNTDX++WXe4LoxnxuivY=; b=PqTxwEBpy3YsvFFpwlnWV7mJhH
        2I71ijb5J/2jAzpuTgjTbpSTaAm4vMHdzSqygmSnmXD3WKABSQXCOc8Wk19jzOuTMkVK4mgAJHKFO
        ArlmXKYHfFF8ejAtgmXM5pJwspILoqep4Q5+PE5RWwOgElZhYXVYtPeFysNY5bRkGMlnrax61pfQB
        prhU6WdKBClGpA3eEHhLErqijvR0TIZK+P2Y1qhDMTuzkCqF5Z1XAMlDW8uS8YqFM2vvmcRWfPDak
        BLsRWzLEsAp479DwV+hEq8VJgq+WWfVaa9W88jxQqsHFspZsio9kuRSk7LWz9uSNmpIoB00ua33Os
        cWFPZjOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjjVW-002CSW-2E;
        Tue, 04 Apr 2023 16:27:42 +0000
Date:   Tue, 4 Apr 2023 09:27:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <ZCxP/ll7YjPdb9Ou@infradead.org>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org>
 <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <20230404212027.3730905d@nvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404212027.3730905d@nvm>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 09:20:27PM +0500, Roman Mamedov wrote:
> SSDs do not physically erase blocks on discard, that would be very slow.
> 
> Instead they nuke corresponding records in the Flash translation layer (FTL)
> tables, so that the discarded areas point "nowhere" instead of the actual
> stored blocks. And when facing such pointers on trying to resolve read
> requests, the controller knows to just return zeroes.

Of course they don't erase blocks on every discard (although if you look
long enough you'll probably find a worst case implementation that does
this anyway).  But you still need to persist your FTL changes, and the
zeroing if any was done by the time your get a FLUSH command, because
without that you'd return different data when reading a block after a
powerfail (i.e. the old data) than before (zeros or a pattern), which is
a no-go.

> Of course there can be varying behaviors per SSD, e.g. I know of some that
> return random garbage instead of zeroes, and some which for a puzzling reason
> prefer to return the byte FF instead.

All of that is valid behavior per the relevant standards.  

> But I think the 1st point above should
> be universal, pretty certain there are none where a discard/TRIM would take
> comparable time to "dd if=/dev/zero of=/dev/ssd" (making it unusable in
> practice).

This is wishful thinking :)  SSDs generall optimize the fast path very
heavily, so slow path command even when they should in theory be faster
due to the underlying optimizations might not be, as they are processed
in software instead of hardware offloads, moved to slower cores, etc.

For discard things have gotten a lot better in the last years, but for
many older devices performance can be outright horrible.

For SATA SSDs the fact that classic TRIM isn't a queued command adds
insult to injury as it always means draining the queue first and not
issuing any I/O until the TRIM command is done.  There is a FPDMA
version not, but I don't think it ws all that widely implemented before
SATA SSDs fell out of favour.
