Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56FA60613F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 15:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiJTNO3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJTNOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 09:14:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA302B1BA6;
        Thu, 20 Oct 2022 06:13:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB40C200A6;
        Thu, 20 Oct 2022 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666271475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QeX08wDx4M8njk38nX6j0ccIHUKQ5jTw8jMRqQvxCE8=;
        b=AlAD+9VUKKIr5ZvpKnA7Jc5T9Kod31Vk5cTyU6rWaIYhF/j+HwRaDLdmgS2AjRj9apfdjC
        gx6/mbxf9ukwSrvMi+jM6AVnrFvBTEOMKiwsHQA4zRAxxdtqObd3W5V32tWvmMjz+OdNfs
        3jPiVrM6oPA52iLEu/HHK1aRxctJLoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666271475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QeX08wDx4M8njk38nX6j0ccIHUKQ5jTw8jMRqQvxCE8=;
        b=uShp+i/LcjZ8KO/Xtf38nz/OAx1zzPkhFRnRGBAUIZX120qco9bml0UXdQHkdouYTKqyWn
        wiZpBcIe/Q9tgADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7285113AF5;
        Thu, 20 Oct 2022 13:11:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xQjpGvNIUWMZPAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Oct 2022 13:11:15 +0000
Date:   Thu, 20 Oct 2022 15:11:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Viktor Kuzmin <kvaster@gmail.com>
Subject: Re: Bug 216559 - btrfs crash root mount RAID0 caused by ac0677348f3c2
Message-ID: <20221020131104.GF13389@suse.cz>
Reply-To: dsterba@suse.cz
References: <8be1e839-2eb8-43d0-9ecb-6ff8c3aa3f2d@leemhuis.info>
 <20221014110708.GE13389@suse.cz>
 <13418d37-ebba-82d2-4e1b-4e48201342c7@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13418d37-ebba-82d2-4e1b-4e48201342c7@leemhuis.info>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 02:00:30PM +0200, Thorsten Leemhuis wrote:
> On 14.10.22 13:07, David Sterba wrote:
> > On Tue, Oct 11, 2022 at 02:09:50PM +0200, Thorsten Leemhuis wrote:
> >> Hi, this is your Linux kernel regression tracker speaking.
> >>
> >> David, I noticed a regression report in bugzilla.kernel.org apparently
> >> caused by a changed of yours. As many (most?) kernel developer don't
> >> keep an eye on the bug-tracker, I decided to forward the report by mail.
> >> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216559 :
> > 
> > Thanks, you don't need to forward the mails as I'm on CC of all bugzilla
> > updates where the btrfs virtual assignee is also present.
> 
> Hmmm. Do you want to make my life easier or want to get less mail? I
> thought about this for a while. Unless you strongly object, I would like
> to continue forwarding them for the following reasons:
> 
> * you might be on vacation or AFK for other reasons; your Comaintainers
> that were CCed would know and likely then help out
> * CCing the list makes other people notice the issue and gives them a
> chance to help (Qu Wenruo replied in bugzilla shortly after I sent the
> mail you quoted, which might or might not be due to my mail).
> * regression tracking is hard already; it would make it a lot harder if
> I'm forced to make and maintain notes how each and every maintainer
> would like me to handle situations like this
> * right now I need to send one mail anyway to add a regression to the
> tracking

No problem with continuing the way it is, the reasons above make sense.
