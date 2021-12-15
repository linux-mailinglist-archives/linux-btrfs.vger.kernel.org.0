Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9848C4766C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 00:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhLOXw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 18:52:56 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:49674 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLOXw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 18:52:56 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 82EC3405A8
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 17:53:29 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 582348033E0B
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 17:52:55 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 432A38033E12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 17:52:55 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j_YLiljKSH2z for <linux-btrfs@vger.kernel.org>;
        Wed, 15 Dec 2021 17:52:55 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.16.192.142])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 0A78E8033E0B
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 17:52:54 -0600 (CST)
Message-ID: <0735c9e2d4d6fa246965663a4f0d4f5211a5b8dc.camel@ericlevy.name>
Subject: Re: receive failing for incremental streams
From:   Eric Levy <contact@ericlevy.name>
To:     linux-btrfs@vger.kernel.org
Date:   Wed, 15 Dec 2021 18:52:54 -0500
In-Reply-To: <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
         <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for the reply. Please see my questions, below.

On Wed, 2021-12-15 at 23:35 +0000, Graham Cobb wrote:

> There is no such thing as an incremental stream. Send sends all the
> information necessary to create a subvolume. Some of that includes
> instructions to share data in other subvolumes but it is not
> incremental.

Perhaps you would clarify the distinction, as to me an incremental
backup is a minimal set of data needed to recreate the original volume
when combined with the previous capture.

> You don't. Receive will create a new subvolume - which will include
> unchanged data from the initial stage and whatever changes have
> happened. If you want, you can then snapshot that (read-only or
> read-write as you wish) into any position you want in your
> destination
> filesystem.

How should I use the latter stream? From the stream length it is
obvious it does not contain most of the data from the earlier one.

