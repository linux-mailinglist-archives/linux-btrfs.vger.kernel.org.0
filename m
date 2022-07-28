Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED1584336
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiG1PjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 11:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiG1PjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 11:39:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EBF5D0F8
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 08:39:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D0C61FAA5;
        Thu, 28 Jul 2022 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659022762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8fZjD/GxW5q2yVPL6fXUqtA1MX6mdDOp8bfEUM439Q=;
        b=QD/ulvT2wweC6bNvnm9QZBbKAhEDW08/jjTp8V51zIgm9rFDJGqaXmmQ5UR9sKNcmIXlbQ
        bFctdsmLAUHd369ZLbSSc1HUs6O9fd+CoYRAzgYRJi4Cg39nsJL0tJxVpR3RDYGV66vFu4
        UiR5SWqA0lZpiNQHbigV6LA2iFN5y0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659022762;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8fZjD/GxW5q2yVPL6fXUqtA1MX6mdDOp8bfEUM439Q=;
        b=8uIhdyJNWD/6Nl9XZqDZ4rqGm4scvwaOe0Gr2Hn4/5ZIfVmfMnd8ZyDNI+IejdZ4gE0Tot
        0u9EpIWekPbEvCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E8A713427;
        Thu, 28 Jul 2022 15:39:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IxaLBqqt4mIBfwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 28 Jul 2022 15:39:22 +0000
Date:   Thu, 28 Jul 2022 17:34:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     li zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH V4] btrfs-progs: fix btrfs resize failed.
Message-ID: <20220728153423.GG13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        li zhang <zhanglikernel@gmail.com>, linux-btrfs@vger.kernel.org
References: <1658767574-16160-1-git-send-email-zhanglikernel@gmail.com>
 <d8fea112-ca92-ca08-0d26-405ca8f75ccc@gmx.com>
 <CAAa-AGkTjLmy2VssSfEdbjCExKPkrdMe7nn4bXe37FSZZ9fv=A@mail.gmail.com>
 <c806c638-a02b-3bd6-f9cc-d3acb147cd63@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c806c638-a02b-3bd6-f9cc-d3acb147cd63@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 01:04:39PM +0800, Qu Wenruo wrote:
> On 2022/7/26 12:56, li zhang wrote:
> > Hi, I have another question, issue 471, extending resizing to support
> > the parameter all to represent all devices, I agree this should
> > iterate over all devices in userspace as it works on older kernel
> > versions. But what happens if the command fails?
> 
> Just error out at the failed device, and print a proper error message.

Agreed, what device (id, maybe path), original size and target size so
the operation can be repeated or the other devices resized back.

If it's a one message per line like we have now then the error could
repeat some key information and that should be sufficient.

> 
> > For example, if the
> > filesystem contains 3 devices, 2 of them resize successfully and the
> > last one fails, in this case I mean the whole command should fail,
> 
> Yes, the command should fail, even if some devices have been resized
> successfully.
> 
> > which means it's better to put these 3 resize subcommands in a
> > transaction. So I'm stuck in a dilemma whether to implement all device
> > resizing in user space or kernel space.
> 
> I still prefer to do it inside user space.
> 
> I don't think there is anything wrong if we resized some devices but not
> all, we still return an error.
> 
> Sure, it's better to output some messages to indicate that some devices
> have been resized, other than that, I see no problem at all.

Agreed.
