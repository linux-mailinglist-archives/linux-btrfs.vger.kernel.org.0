Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0B62A257
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKOUBp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 15:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiKOUBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 15:01:42 -0500
Received: from zmcc-3-mx.zmailcloud.com (zmcc-3-mx.zmailcloud.com [34.200.143.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB9E29377
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:01:40 -0800 (PST)
Received: from zmcc-3.zmailcloud.com (183.87.154.104.bc.googleusercontent.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 971AF4054C;
        Tue, 15 Nov 2022 14:05:32 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 639FA80366A2;
        Tue, 15 Nov 2022 14:01:39 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 52A1A80366A5;
        Tue, 15 Nov 2022 14:01:39 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zNmjD36PAJIc; Tue, 15 Nov 2022 14:01:39 -0600 (CST)
Received: from [10.4.2.11] (unknown [37.19.198.182])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id C216C80366A2;
        Tue, 15 Nov 2022 14:01:38 -0600 (CST)
Date:   Tue, 15 Nov 2022 15:01:29 -0500
From:   Eric Levy <contact@ericlevy.name>
Subject: Re: separate mailing list for patches?
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Message-Id: <HMNELR.D0MZMRGVI0JI2@ericlevy.name>
In-Reply-To: <4f3526771aa69fe275693aaa07e98e8e12452e99.camel@scientia.org>
References: <0YIELR.GA2T7GBWR97P2@ericlevy.name>
        <20221115194744.6a343639@gecko.fritz.box>
        <48NELR.GD3GOBQRO8OC3@ericlevy.name>
        <4f3526771aa69fe275693aaa07e98e8e12452e99.camel@scientia.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Tue, Nov 15 2022 at 08:56:53 PM +0100, Christoph Anton Mitterer 
<calestyo@scientia.org> wrote:
> This however has also it's downsides (in particular for the users):
> namely likely less attention by the developers ;-)

Yes, if the developers subscribe only to one, and use it for all 
communication among themselves. As was my intended suggestion, I 
thought it might be helpful broadly, though perhaps very slightly less 
convenient for some, to put the patches on a dedicated channel, 
separate from one for the regular messages, containing written text for 
any purpose.



