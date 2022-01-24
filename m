Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9649847E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbiAXQS1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 11:18:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42060 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiAXQS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 11:18:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A285B21996;
        Mon, 24 Jan 2022 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643041105;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYv9lvQn4iUjNYbHovg+BHZ+jwjQt5WjtF1MYHiMyLI=;
        b=anSI3Mv50G2F6jaoihGnRz4w1v51yLHU6BoMfwP8jBNgtmDxqYWcezobn9GoqBnm0R9N9K
        nxeWDjvK5GAcE6JnmzkaE/wlgbPIMgDsOk2ByqTMxrpdZWGwAc11CC/95xjhRlkj6XC0Ft
        0oW0NrkyINGtdcxtot6hM+RX2wiyWYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643041105;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYv9lvQn4iUjNYbHovg+BHZ+jwjQt5WjtF1MYHiMyLI=;
        b=J9caiqenMOOCmtKPECbsj6TkJGQaaFzVF1/vYCT6hh4esgSJtWZ+LN+G3wzUXOmf/xECE6
        qNycF3+SgClPBLAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 889A3A3B83;
        Mon, 24 Jan 2022 16:18:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BAEC0DA7A3; Mon, 24 Jan 2022 17:17:45 +0100 (CET)
Date:   Mon, 24 Jan 2022 17:17:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Diego Calleja <diegocg@gmail.com>,
        linux-btrfs@vger.kernel.org, Andrei Bacs <andrei.bacs@gmail.com>,
        cpu808694@gmail.com, Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Kaveh Razavi <kaveh@ethz.ch>,
        "Bacs, A." <a.bacs@vu.nl>
Subject: Re: inline deduplication security issues
Message-ID: <20220124161745.GZ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Su Yue <l@damenly.su>, Diego Calleja <diegocg@gmail.com>,
        linux-btrfs@vger.kernel.org, Andrei Bacs <andrei.bacs@gmail.com>,
        cpu808694@gmail.com, Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Kaveh Razavi <kaveh@ethz.ch>,
        "Bacs, A." <a.bacs@vu.nl>
References: <CAKDzk=-HZardsLFH5c9HYre73NYNszUJqpfsh0YJnnaQToB3BA@mail.gmail.com>
 <1828959.tdWV9SEqCh@arch>
 <1r0xx5tj.fsf@damenly.su>
 <d30f1475-d06e-065e-63e1-6253c5ee86a3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d30f1475-d06e-065e-63e1-6253c5ee86a3@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 24, 2022 at 07:45:20PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/1/24 09:38, Su Yue wrote:
> >
> > On Sun 23 Jan 2022 at 20:18, Diego Calleja <diegocg@gmail.com> wrote:
> >
> >> El sábado, 22 de enero de 2022 19:42:47 (CET) Andrei Bacs escribió:
> >>> We have found security issues with inline deduplication in storage
> >>> systems, using ZFS and Btrfs and running examples. See the attached
> >>> paper for details.
> >>
> >> (Not actually a btrfs developer here)
> >>
> >> I am confused, Btrfs does not support inline deduplication. The inline
> >> deduplication implementation used in that paper is pretty old and as
> >> far as I
> >> know it's not maintained (people seem to be happy with out of band
> >> deduplication).
> >>
> >> You might want to contact the developer on the inline implementation:
> >> https://
> >> lore.kernel.org/linux-btrfs/20181106064122.6154-1-lufq.fnst@cn.fujitsu.com/
> >>
> > AFAK, Fujitsu has no more plans about btrfs.
> > So there is no follow-up version of the inline deduplication feature.
> 
> To add more, as one of the original authors, I and my employer have no
> interest to push write-time dedupe any more.
> 
> Furthermore, the original implementation has one limit, one extent must
> be written to disk, before it can be utilized by write-time dedupe.

The inline deduplication feature has been abandoned, the patches were
incomplete and overall the feature is very complex to be implemented in
kernel. The replacement should be a user space tool like BEES and the
kernel module provides ioctls to do the actual deduplication (or help in
another way). Many things are much easier in userspace, also with the
clear separation of kernel/userspace when in it comes to the complexity.
