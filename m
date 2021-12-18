Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE50479E5A
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Dec 2021 00:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhLRXyr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Dec 2021 18:54:47 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:32790 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhLRXye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Dec 2021 18:54:34 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 832D240555
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Dec 2021 17:55:09 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 61BA48034783
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Dec 2021 17:54:33 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 534B98034BE2
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Dec 2021 17:54:33 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iXXQNeUvXru4 for <linux-btrfs@vger.kernel.org>;
        Sat, 18 Dec 2021 17:54:33 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id BC2828034783
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Dec 2021 17:54:26 -0600 (CST)
Message-ID: <f33d052d30ba5a8fd592e584b86a8cdcb1a2fe22.camel@ericlevy.name>
Subject: Re: receive failing for incremental streams
From:   Eric Levy <contact@ericlevy.name>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 18 Dec 2021 18:53:40 -0500
In-Reply-To: <20211216113848.GA21083@savella.carfax.org.uk>
References: <03e34c5431b08996476408303a9881ba667083ed.camel@ericlevy.name>
         <55ddb05b-04ad-172e-bda7-757db37a37b2@cobb.uk.net>
         <0735c9e2d4d6fa246965663a4f0d4f5211a5b8dc.camel@ericlevy.name>
         <ea6260d5-c383-9079-8a53-2051972b11d3@cobb.uk.net>
         <70553d13e265a2c7bced888f1a3d3b3e65539ce1.camel@ericlevy.name>
         <e479561d-98be-5da2-4853-e697eb9690b3@cobb.uk.net>
         <20211216113848.GA21083@savella.carfax.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for the explanation about streams.

My first observation is that the details clarified in this conversation
are easily understood from the man page, nor from any official online
documentation I had found, nor even from any other discussion or
documentation I had found through web searches. Thus, even if it were
the only change to result from these considerations, I would suggest
that the man page should include a more robust explanation of the
design.

Next, the child stream being restored to a new subvolume, with the
result sharing references with the parent, may be practical from a
standpoint of underlying implementation, but may not be intuitive for a
user in a typical work flow. It might be helpful for users to have some
direct support for the use case of updating an existing stream in
place.

Finally, the constraint that a restore target must have the same file
name as the original subvolume is, at least to my thinking,
inconvenient, if not also in many cases challenging, as when the
original name is not known, perhaps having been chosen arbitrarily. A
useful feature would be an option in the administrative tool to choose
the name of the restored subvolume, not simply the parent directory.

Whether any such enhancements require changes to the file system
functionality is beyond my knowledge, but it is certainly worthwhile to
consider any that are possible through changing only tools in user
space.


