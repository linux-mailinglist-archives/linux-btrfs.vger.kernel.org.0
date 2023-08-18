Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B687812F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Aug 2023 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379458AbjHRSka (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Aug 2023 14:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379454AbjHRSkK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Aug 2023 14:40:10 -0400
Received: from mail-108-mta17.mxroute.com (mail-108-mta17.mxroute.com [136.175.108.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B69E3A80
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Aug 2023 11:40:08 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta17.mxroute.com (ZoneMTA) with ESMTPSA id 18a09f2817e000d7b6.002
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 18 Aug 2023 18:40:02 +0000
X-Zone-Loop: 7e1a20bf756902fe6ff6e632fc427f931e0906179898
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc
        :To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FsiEYjbLjWGcwUKLLTwUZCzoWAZwWMhiWENpkWiOMig=; b=YF5TtNuq/fSy5z7xP50E0wnuZX
        RvzFjoxzDKgN4eDxhnO17B0qIAIDINE/kPNM3XjurzwcZ1UzSs3uHwr4nlycXewOJOi2yy2qNhh3o
        Daetu0OSIGOM8YlE8tvOH/6NAyOpwFh5IHET/Pa8rJpbUwSWIwZImUTaa9B1IyIjcAGaFOjPYuTHs
        Fffiy5cLNDYderRHzl1lScHDB753x0ol6wfriUGCNXrruMrwsZ/ey6Ql5JmgpucAgnlRwOIQJni9/
        N9zHyYAlr4gRDVKBu19J/BpEtI0kmsZZwwfBhFKkP7OVUP6C6J84y8yDzdFP+wcqUqOTprzFrIxAB
        5QIojRYA==;
Date:   Fri, 18 Aug 2023 20:39:58 +0200
From:   Christoph Heiss <christoph@c8h4.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: implement json output for subvolume
 subcommands
Message-ID: <yp65dkmsmuw77rhsvokj73jc6h4vhbrnqch73qk5epw2eaqs5v@y5uozai7motj>
References: <20230813094555.106052-1-christoph@c8h4.io>
 <20230817193437.GU2420@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817193437.GU2420@twin.jikos.cz>
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


First of, thanks for the review & merging right away!

On Thu, Aug 17, 2023 at 09:34:37PM +0200, David Sterba wrote:
>
> On Sun, Aug 13, 2023 at 11:44:55AM +0200, Christoph Heiss wrote:
> > [..]
>
> Thanks. There are a few things regarding the json output that are still
> to be figured out and to set examples to follow. The plain and json
> output does not match 1:1 in the printed information, here the
> 'top level' does not need to be in the json output or there could be
> more subvolume related info in the map.

> The textual output is unfortunatelly parsed by many tools nowadays so
> we can't change the format. With json it's easier to filter out the
> interesting data so "more is better" in this case.
Right, makes sense. I skimmed through your additional commits on top,
e.g. the null uuid thing. So all "optional" fields should rather be
`null` than missing.

>
> The formatter is designed in a way to allow plain text and json to be
> printed by the same lines of code but this is namely for line oriented
> output, like 'subvolume show'.
Yeah, I figured that after looking at it a bit more - that's why I
decided to leave most of the stuff as-is for now.

> [..]
>
> I'll put some guidelines to the documentation, the key naming must be
> unified, e.g. 'gen' or 'generation' but there's also 'transid' used in
> some cases etc.
>
> As the json format is also an ABI we need to get it finalized first
Does it make sense to explicitly document all the possible json outputs
with all their fields, i.e provide example outputs?

> so I'll merge the series but put the actual support for --json option
> under experimental build.
Thanks! Makes it easier to improve on it gradually in any case. I will
send some more patches your way rectifying these things as soon as I get
to it.
