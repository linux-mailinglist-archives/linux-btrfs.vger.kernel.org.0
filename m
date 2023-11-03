Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DD7E0496
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377774AbjKCOVq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjKCOVn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 10:21:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3844D43;
        Fri,  3 Nov 2023 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dAzjT3TYWrQtfQePCJduov/rj/hQ+W1VM4VA8kn82cY=; b=qxZWsjHNOR0PE8qCrGmYodo06a
        HFLdifrg9MZ2DjQmyFevuA4sVBDwQjo2TWGpupgDAbz6T49umUOFNlV2iaiZhDIt5+dVEepU0dYo1
        Yd0KKYf4M2f+gcJIWwDRZna18qT9d2dFYkDkCLeDmazGikWs66YSaaNflqVoUpH7lzAKIWwHzxvtQ
        3PEpAAPlCYZGHIm3GOfRVMQLgSpEQN6OOSm0xN5u0rOD+lCCGciTkDoJXeuzgEQtEfqTwKxDPLQ+7
        AMPwsWrfPTnmN3CUFj63oAH2G7tCaayJ5f0jrfZwW5rgVW6+XN9UCTYy2hb2YbVlxPspt9LBzTcwE
        9SMrR3vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qyv37-00BZE0-0r;
        Fri, 03 Nov 2023 14:21:25 +0000
Date:   Fri, 3 Nov 2023 07:21:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUUB5Z9F9Pk8+iWs@infradead.org>
References: <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <413e2e17-868a-4ce7-bafd-6c0018486465@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413e2e17-868a-4ce7-bafd-6c0018486465@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 01, 2023 at 10:33:41AM +1030, Qu Wenruo wrote:
> Can we make this more dynamic? Like only initializing the vfsmount if
> the subvolume tree got its first read?

Yes, I would treat it like an automount.
