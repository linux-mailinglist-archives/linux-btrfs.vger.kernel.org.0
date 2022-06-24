Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A132B559848
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 13:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiFXLBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 07:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFXLBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 07:01:41 -0400
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Jun 2022 04:01:40 PDT
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C91377077
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 04:01:40 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 26CC54688F9;
        Fri, 24 Jun 2022 12:52:20 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Criteria for mount messages. (was "Re: [PATCH] btrfs: remove skinny extent verbose message")
Date:   Fri, 24 Jun 2022 12:52:19 +0200
Message-ID: <1852203.CQOukoFCf9@ananda>
In-Reply-To: <7a42092f-9534-e54c-174e-8aaf17509d4b@gmx.com>
References: <20220623080858.1433010-1-nborisov@suse.com> <20220623141954.GP20633@twin.jikos.cz> <7a42092f-9534-e54c-174e-8aaf17509d4b@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 24.06.22, 00:46:02 CEST:
> Thus my idea criteria would be:
> 
> - Would this feature bring bad impact to end users?
>    If the feature is only bringing good impact, it should not be
> output.
> 
>    Thus in this way, v2 cache nowadays should also be skipped, as it's
> already well tested, and no real disadvantage at all.

There is one aspect where I find those messages helpful:

To confirm that I successfully enabled a feature (like space cache v2).

However, for that there does not really need to be a kernel message on 
each mounting, as long as I have a way to confirm the currently used 
features of BTRFS like:

- which checksum algorithm?
- space cache v2
- big metadata
- which compression method configured as standard (I am aware that does 
not say anything about which files are compressed by which method)

and all other things like that.

Preferably in the output of just one command instead of being scattered 
around several different outputs or not even available at all. For 
example I am not aware of a command that confirms whether or not a 
filesystem uses "xxhash" instead of "crc32c" as checksum algorithm.

Something a bit similar to "tune2fs -l" or "xfs_info".

Is there such a something? I believe there is some way to dump a 
superblock however is there something that gives a structured output on 
what features are in use on a given filesystem?

Best,
-- 
Martin


