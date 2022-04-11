Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9673B4FBEF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 16:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiDKOYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 10:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiDKOYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 10:24:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96130369EF
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 07:21:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 53B751F38D;
        Mon, 11 Apr 2022 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649686910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMPG3o/sMtCnmzfsLqWavVXTd2v1hE4z9j93GYbi4Cw=;
        b=wyLW5d2+LIIea0DvKPSUBClvEr/7Ton0LLrBwjU7tevBoVxvEMce7w2F2LdRmZpPeeqrAe
        VGqtZYhgZ1QcXG6YYKqkuoRTaM4fGyT9AHJts53hTkpRPRrzngO5byqVeu64NS0KmU+4Ub
        U+jRJdmNfFoaw/iDBcit01iclVBXtYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649686910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wMPG3o/sMtCnmzfsLqWavVXTd2v1hE4z9j93GYbi4Cw=;
        b=a0moW/Al9J/nFNbI+clvfVXPjYADq3NYruLqTLkPExnBwAG6k/JPdbMrjK7nFZWq4wNBBn
        vZdarJtU2sifeUCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 45F87A3B94;
        Mon, 11 Apr 2022 14:21:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D6C9DDA7DA; Mon, 11 Apr 2022 16:17:45 +0200 (CEST)
Date:   Mon, 11 Apr 2022 16:17:45 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Gabriel Niebler <gniebler@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Turn delayed_nodes_tree into XArray and adjust usages
Message-ID: <20220411141745.GK15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220407153855.21089-1-gniebler@suse.com>
 <20220407164414.GO15609@twin.jikos.cz>
 <cff2bcc4-536f-3ea4-e835-109d3ad45da2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff2bcc4-536f-3ea4-e835-109d3ad45da2@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 11, 2022 at 09:41:54AM +0200, Gabriel Niebler wrote:
> Am 07.04.22 um 18:44 schrieb David Sterba:
> > On Thu, Apr 07, 2022 at 05:38:48PM +0200, Gabriel Niebler wrote:
> >> [...]
> >> This patchset converts `delayed_nodes_radix` into an XArray, renames it
> >> accordingly and adjusts all usages of this object to the XArray API.
> >> It survived a complete fstests run.
> > 
> > So it converts just one structure, it would be better do it in one
> > patch otherwise it leaves the conversion half way and it's confusing to
> > see xarray structure in the radix-tree API.
> 
> Yes, I figured that converting each structure separately is easier to 
> achieve for me, since the changes in this patch set are done, but 
> changes to other structures are not (yet).
> 
> As for splitting the changes, as I did: My thought was that it's easier 
> to review this way, patch-by-patch and that the important thing is that 
> the conversion be done by the end of the patch set.

The change splitting should be on the logical level and with focus on
a selected context, but there's no universal advice. In this case the
scope is one structure per patch, all actions with the structure are the
context that often remains same for all the API calls, splitting that
per patch does not help the review. Switching all structures in one
patch would mean that each call site is using a different structure so
the context is changing too often and that's adding to the congnitive
load.  Which leads to oversights and review quality goes down.
