Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F84DBCE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 03:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbiCQCNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 22:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCQCNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 22:13:10 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D44961EACC
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 19:11:53 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id C1B46261900; Wed, 16 Mar 2022 22:11:32 -0400 (EDT)
Date:   Wed, 16 Mar 2022 22:11:32 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Message-ID: <YjKY1Fa/qmtGgz/s@hungrycats.org>
References: <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com>
 <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
 <87a6dscn20.fsf@vps.thesusis.net>
 <Yi/I54pemZzSrNGg@hungrycats.org>
 <87fsnjnjxr.fsf@vps.thesusis.net>
 <YjD/7zhERFjcY5ZP@hungrycats.org>
 <CAODFU0pwch49XB4oGX0GKvuRyrp+JEYBbrHvHcXTnWapPBQ8Aw@mail.gmail.com>
 <YjIYNjq8b7Ar/+Gt@hungrycats.org>
 <CAODFU0obuBSFtwgfxr9PdsGSfpADogw1bEhu7DGsExRXfau1Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0obuBSFtwgfxr9PdsGSfpADogw1bEhu7DGsExRXfau1Dg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 16, 2022 at 06:48:04PM +0100, Jan Ziak wrote:
> On Wed, Mar 16, 2022 at 6:02 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> > On Tue, Mar 15, 2022 at 11:20:09PM +0100, Jan Ziak wrote:
> > > - Linear nodatacow search: Does the search happen only with uncached
> > > metadata, or also with metadata cached in RAM?
> >
> > All metadata is cached in RAM prior to searching.  I think I missed
> > where you were going with this question.
> 
> The idea behind the question was whether the on-disk format of
> metadata differs from the in-memory format of metadata; whether
> metadata is being transformed when loading/saving it from/to the
> storage device.

Both things happen.  Metadata reference updates are handled by delayed
refs, which track pending reference updates (mostly with the hope of
eliminating them entirely, as increment/decrement pairs are common).
If these don't cancel out by the end of a transaction, they are turned
into metadata page updates.

Metadata searches use tree mod log, which is an in-memory version of
the history of metadata updates so far in the transaction, since the
metadata page buffers themselves will be out of date.

Anything not in those caches (including everything committed to disk)
is in metadata buffers which are memory buffers in on-disk format.

There is a backref cache which is used for relocation, but not the
nodatacow/prealloc cases (or normal deletes).  Caching doesn't really
work for the writing cases since the metadata is changing under the
cache.
