Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276467D8E73
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 08:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjJ0GIX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 02:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjJ0GIR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 02:08:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24381B2;
        Thu, 26 Oct 2023 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TfMZT5btLnP/blSIX4mPCJ5hujeRMgTDsbWBStTgLz0=; b=uq0nSJFYJ74IVlufASmj0nj/Ib
        GhKIBoqSEamgDuM89JX6ikt5ORGXoBHqTVd0qlh9yXO9GJ2wk1q1CcY90leT7DdJEPK3JJUycWdNT
        AbkL7dJVrXTabcEgVt6iU2S86gGeE4Gg/C3y8V+6lJyFQYxFBcMwMETCj3vx0ULxg+2bcjbJ3aN+s
        zCIabHP4VixyzPsQdROvBNgj1ljRaNhQDxiCa1iypSx4JEUcQEsnIMOEFN7CsrsbXbevAIqlJH3Z1
        qOupSoLgeIDoO9IA1cZl/QLjrn2cHoEsyN0yKut8EQHcAhLPSH8JY08k8HSJCtag549gu1GW3mFlw
        80e2bjIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwG0x-00FeWx-1y;
        Fri, 27 Oct 2023 06:08:11 +0000
Date:   Thu, 26 Oct 2023 23:08:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTtTy0wITtw2W2vU@infradead.org>
References: <20231026155224.129326-1-amir73il@gmail.com>
 <ZTtOz8mr1ENl0i9q@infradead.org>
 <CAOQ4uxjbXhXZmCLTJcXopQikYZg+XxSDa0Of90MBRgRbW5Bhxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjbXhXZmCLTJcXopQikYZg+XxSDa0Of90MBRgRbW5Bhxg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 27, 2023 at 09:03:43AM +0300, Amir Goldstein wrote:
> With all due respect, your NACK is uncalled for.

It abosolute is not.  We must not spread the broken btrfs behavior.

> The "details" that fanotify reports and has reported since circa v5.1
> are the same details available to any unprivileged user via calls
> to statfs(2) and name_to_handle_at(2).

Yes, and that's very broken.  btrfs sneaked this in and we need to
fix it.

Again:

Extra-hard-Nacked-by: Christoph Hellwig <hch@lst.de>

and I'm a little sad that you're even arguing for sneaking such broken
thing in.
