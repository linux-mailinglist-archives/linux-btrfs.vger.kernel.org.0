Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E422C4EDF15
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Mar 2022 18:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240232AbiCaQth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiCaQth (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 12:49:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D0209A46;
        Thu, 31 Mar 2022 09:47:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EE8F01F7AC;
        Thu, 31 Mar 2022 16:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648745267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSbtcaTG9qrfonhYRVCF3uDE8HndJaKQfH9efOo3Yco=;
        b=TO/kYKTtowcBXNd2xBWc5Z+KBwXS78oK9BPBbkFByaDZtPUWnOffTdDJ8Jst+ADMjhZWoM
        66vvIVUgm+AxGiE7neGTnTsengOZDiIALyp9i1GcwGrRbeRwtSjAfqwpNdhHGINWYiALRc
        AwfBy8gR7+H1mxhrdplU6KAO/F1oXOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648745267;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lSbtcaTG9qrfonhYRVCF3uDE8HndJaKQfH9efOo3Yco=;
        b=5xxHU4X4nIjFDuGYV2WJGPKwOSdVlz4G0xSGHc+hcHRxO4BB/YlwmxpGR95J5J7vW6yyGa
        9ciwwiAIspnDo1Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DCDFBA3B82;
        Thu, 31 Mar 2022 16:47:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45870DA7F3; Thu, 31 Mar 2022 18:43:49 +0200 (CEST)
Date:   Thu, 31 Mar 2022 18:43:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs: allocate page arrays more efficiently
Message-ID: <20220331164349.GC15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1648658235.git.sweettea-kernel@dorminy.me>
 <20220330165837.GH2237@twin.jikos.cz>
 <b9a6ee3d-0744-1a28-65f1-22c1402e2d48@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a6ee3d-0744-1a28-65f1-22c1402e2d48@dorminy.me>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 30, 2022 at 02:08:11PM -0400, Sweet Tea Dorminy wrote:
> 
> 
> On 3/30/22 12:58, David Sterba wrote:
> > On Wed, Mar 30, 2022 at 12:44:05PM -0400, Sweet Tea Dorminy wrote:
> >> In several places, btrfs allocates an array of pages, one at a time.  In
> >> addition to duplicating code, the mm subsystem provides a helper to
> >> allocate multiple pages at once into an array which is suited for our
> >> usecase. In the fast path, the batching can result in better allocation
> >> decisions and less locking. This changeset first adjusts the users to
> >> call a common array-of-pages allocation function, then adjusts that
> >> common function to use the batch page allocator.
> >>
> >> v2: moved new helper to extent_io.[ch]. Fixed title format.
> > 
> > It does not address comments from
> > https://lore.kernel.org/linux-btrfs/20220328230909.GW2237@twin.jikos.cz
> I apologize, I completely missed the inline comments even though I 
> thought something was missing and reread it a couple times... v3 soon.

Yeah it's common to not trim a patch and write comments right next to
the code, trimming to just a piece of code is also done if it's just the
one thing to comment, but for example I go through the patch several
times so trimming would not work very well.

If you're using mutt, there's a command (bound to T by default) that
hides any quoted text.
