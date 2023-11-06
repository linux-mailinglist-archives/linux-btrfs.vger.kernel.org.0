Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777E47E2AC1
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 18:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjKFRN1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 12:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKFRN1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 12:13:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57D125;
        Mon,  6 Nov 2023 09:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fEpMu/27fXqk6Kwb9eu4UrW+Ne4wf1AMuIbJLkNMGwQ=; b=NN3nXumjI6cdj++TTdbqXMoxR7
        YdxWLQncXqEotfldvoy+T0c7CS1mqEiwZaSpKXhQhXXaUiHrHBPQm3/6Plu9/U7jQb5U4nrL8D9TG
        BlJLWoCsXCNG7Ype2eLiLUdy4aQXao7xS2pWpW32hC7oNJgRG9E7OxqkxtTfMa/2aAno4eAanWAqw
        WlaXB6UghA15RdRP7t3ypXKudB8Nal7vv1jXV3UDWfJmFvJ9gtJTb+QcCTkwbbBgPZjc5DBnukCeh
        QLaymggk3ueSsryNocbIwTzoabjpViQt3r74Z/7NwrFqQ9jHyvilHvUcjhEM0WmKQWQT43OkPbsxY
        SJ0slh3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r03A7-00HCWQ-2T;
        Mon, 06 Nov 2023 17:13:19 +0000
Date:   Mon, 6 Nov 2023 09:13:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUker5S8sZXnsvOl@infradead.org>
References: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <ZUjcI1SE+a2t8n1v@infradead.org>
 <20231106-unser-fiskus-9d1eba9fc64c@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-unser-fiskus-9d1eba9fc64c@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 06, 2023 at 02:47:16PM +0100, Christian Brauner wrote:
> Granted, an over-generalization but non in any way different from
> claiming that currently on one needs to know about btrfs subvolumes or
> that the proposed vfsmount solution will make it magically so that no
> one needs to care anymore.

I don't think any one has claimed "no one" needs to care any more.  What
the vfsmounts buy us that is that software that doesn't know and
should't know about btrfs subvolumes isn't silently broken.  Software
that actually wants to do something fancy with them always need special
casing.

> Tools will have to change either way is my point. And a lot of tools do
> already handle subvolumes specially exactly because of the non-unique
> inode situation. And if they don't they still can get confused by seing
> st_dev numbers they can't associate with a filesystem.

Again, tools that actually are related to subvolume features are
not even the problem.
