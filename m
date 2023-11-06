Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65D7E2AB3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 18:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjKFRKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 12:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjKFRKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 12:10:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D01BC;
        Mon,  6 Nov 2023 09:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2QgiGpxHYkLHxfAiCc/bL2CX3SUtRZj7hPmY4pr3NfU=; b=F7DXaqgWSc5V4Rc5RE1Sj6vPsz
        9PrOOcXUwfxEShyi0lQ+5yTPHgWnTRAsq/crfqs7w1uwLd1CuEwOhqFoQaFBpKOB/dn5eXA2svEiA
        yFjVR/dew3gYomgNSZ+AIGx2iT3i0hmxcmVp08Emlv5sOf3QPnS/ildCVXCSLwDXScqgGLV4NlWCQ
        xWh9LMA5a0qcynnKi/1ual93n34+HltL21sFtJ685VGb885Y5MXnjW4Z1rUGcfWwuxEfkNTwBsMRb
        j9n8Hr6jNasr6Nw75WthfqPXrIQxfxtp+PhynA1TB03hjPWkWM3NjkUT9X5tqA8ll7O9l1BcJBhxQ
        ROPxgHig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r037M-00HCCv-1X;
        Mon, 06 Nov 2023 17:10:28 +0000
Date:   Mon, 6 Nov 2023 09:10:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZUkeBM1sik1daE1N@infradead.org>
References: <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
 <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
 <20231106-postfach-erhoffen-9a247559e10d@brauner>
 <ZUjcgU9ItPg/foNB@infradead.org>
 <20231106-datei-filzstift-c62abf899f8f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-datei-filzstift-c62abf899f8f@brauner>
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

On Mon, Nov 06, 2023 at 02:05:45PM +0100, Christian Brauner wrote:
> > > I think spending time engaging this claim isn't worth it. This is just
> > > easily falsifiable via a simple grep for btrfs in systemd, lxc, runc,
> > > util-linux.
> > 
> > Myabe you need to get our of your little bubble.  There is plenty of
> 
> Unnecessary personal comment, let alone that I'm not in any specific
> bubble just because I'm trying to be aware of what is currently going on
> in userspace.

Maybe you're just taking it to personal?  A place where systemd, lxc,
runc, and util-linux are "all software" is a very much a bubble as you
won't find much userspace that stays more uptodate with particular
quirks of modern Linux features.

> Whatever you do here: vfsmounts or any other solution will force changes
> in userspace on a larger scale and changes to the filesystem itself. If
> you accommodate tar then you are fscking over other parts of userspace
> which are equally important. There is no free lunch.

It works for everything that knows that Linux mountpoint as exposed
in /proc/mounts and proc/self/mountinfo corresponds to the posix
definition of a mount point, and that one used on basically every
other unix system.  It might not work as-is for software that actually
particularly knows how to manage btrfs subvolumes, but those are, by
defintion, not the problem anyway.

It's thinkgs like backup tools that run into random ino_t duplicates.
That's an example we had in the past, and I would be absolutely not be
surprised if there is more than more of those hiding right now.
