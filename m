Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A797DBAAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 14:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjJ3NZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjJ3NZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 09:25:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CDEA2;
        Mon, 30 Oct 2023 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ilwoHemrW2teVoRctqXKwG4ZrUjujKvoTKzlqZcWFII=; b=Cna6mS3WD/044dWY1ZcTPlePc2
        ayl50jQ93qL4q/McVYm7dN0DIWAkNhx63rJXmaej1Ypj1/l24BMqLmetBEraWrn/Rf2kxrAwkFyIU
        oomWuv4lEWgEbQ0EooW8kdychF/VJlyVVVFH20IFDf4Ary4TWuoIzUmlMBkRMk9q5vwhUPf3Uf8RE
        NqTzLXzgs94WH4RpCSzSa5eE3mMJlvilaGaS//GEX4NxxZjqnB7TCdAZ59Zj7wHhX6rBFW1/vWjHw
        JxYOTIh75zlVe1R5N2YrFjdhid2XGMkyGoMtRfadzIhmKA+uF1zESBQSqNIDXgddiLkVZ8Z9/Jyna
        J5gFnFVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qxSGj-003Ogt-24;
        Mon, 30 Oct 2023 13:25:25 +0000
Date:   Mon, 30 Oct 2023 06:25:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZT+uxSEh+nTZ2DEY@infradead.org>
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org>
 <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org>
 <20231027131726.GA2915471@perftesting>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027131726.GA2915471@perftesting>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 27, 2023 at 09:17:26AM -0400, Josef Bacik wrote:
> We have this same discussion every time, and every time you stop responding
> after I point out the problems with it.

I'm not sure why you think I stop responding when the action item is not
for me.

> A per-subvolume vfsmount means that /proc/mounts /proc/$PID/mountinfo becomes
> insanely dumb.  I've got millions of machines in this fleet with thousands of
> subvolumes.  One of our workloads fires up several containers per task and runs
> multiple tasks per machine, so on the order of 10-20k subvolumes.

If you do not expose them in /proc/mounts and friends you don't have
any way to show where the mount point or whatever barrier you want
between different st_dev/fsid/etc is.  And you need that.

I've not seen any good alternative that keeps the invariant and doesn't
break things.  If you think there is one please explain it, but no,
adding new fields so that new software can see how we've broken all
the old software is not the answer.

A (not really) great partial answer would be to stop parsing the
text mount information so much, at least for your workloads that
definitively are little on the extreme side.  I think Miklos has been
working on interface that could be useful for that.
