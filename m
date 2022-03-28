Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A624F4E9F63
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245436AbiC1TGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 15:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiC1TGw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 15:06:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470E2655F
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 12:05:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 895C7210EB;
        Mon, 28 Mar 2022 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648494310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2S+u+HfGnVJypaxHseosXnayDzHZm7RDm4eU2rbL3I=;
        b=dyauWtToS439+OQu5M5aLqXLET5IVx0Au5QsyCUdF9+86fRcRLM9DRi/XCuQTyTb3ODEuw
        ezgGyOUeGX0vtOA+j+9mzmO1MxicwGGx2F1pHiFtcJCxjRzRH2GWqSBanBMY4Czhk5DMoW
        wcIVyNpvd8XlvWbzM9hLNa97rPsxvbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648494310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2S+u+HfGnVJypaxHseosXnayDzHZm7RDm4eU2rbL3I=;
        b=VdjoZ1DfBeZgBDVrOLCTqWAh8oSoavUYSj4GLPsqU2yU77o6XUCflCW5CTe1IEik7UlwcW
        Prp7uG534QymczDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5787CA3B92;
        Mon, 28 Mar 2022 19:05:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 58A67DA7F3; Mon, 28 Mar 2022 21:01:13 +0200 (CEST)
Date:   Mon, 28 Mar 2022 21:01:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: remove the zoned/zone_size union in struct
 btrfs_fs_info
Message-ID: <20220328190113.GS2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324165210.1586851-2-hch@lst.de>
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

On Thu, Mar 24, 2022 at 05:52:09PM +0100, Christoph Hellwig wrote:
> Reading a value from a different member of a union is not just a great
> way to obsfucate code, but also creates an aliasing violation.

Is it a violation in this case? Both are of the same type, violation
could be int/u64 and others but even in this case this is transparent to
the compiler and union cast is the cleanest way to access same bytes in
a structure. Anaywy now the helper btrfs_is_zoned is used everywhere
which abstracts the condition, which was the original idea for the
union.
