Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0773532F0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiEXQdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 12:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiEXQdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 12:33:24 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CB5909E;
        Tue, 24 May 2022 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kBwkYcVGVciAMZTFzVXCinH0qtP87CvQB3Nr4LU/+sE=;
  b=SC988mYHq1bRmsR9dn9EyZrMU7I1s7GtderDg4QPnDsh8Q/a3DQII0yg
   ncxMimEYFF05fvBW75iVWpU5V7D+K34kRchih2ClgZ43yRQp0w8PeqzrJ
   +9iwXBFBUxQM2EQ4WhA1ORhmU4sb8flLkIS6owDEo2ywiiQiC9vsYL5Db
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,248,1647298800"; 
   d="scan'208";a="14992997"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 18:33:19 +0200
Date:   Tue, 24 May 2022 18:33:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     David Sterba <dsterba@suse.cz>
cc:     Chris Mason <clm@fb.com>, kernel-janitors@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix typos in comments
In-Reply-To: <20220524162414.GU18596@twin.jikos.cz>
Message-ID: <alpine.DEB.2.22.394.2205241832180.2473@hadrien>
References: <20220521111145.81697-5-Julia.Lawall@inria.fr> <20220524162414.GU18596@twin.jikos.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, 24 May 2022, David Sterba wrote:

> On Sat, May 21, 2022 at 01:10:15PM +0200, Julia Lawall wrote:
> > Spelling mistakes (triple letters) in comments.
> > Detected with the help of Coccinelle.
>
> The tool to check typos is codespell, however it does not catch either
> of the words you're fixing. We do typo fixing in bigger batches so I'd
> rather fix all of them, I found about 10 more.

OK, no problem.  My rule only looks for the special case of three
occurrences of a letter, so it doesn't find many things per file.

julia
