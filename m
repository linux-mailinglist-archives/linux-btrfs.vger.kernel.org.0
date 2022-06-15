Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8ED54D575
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiFOXnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 19:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354680AbiFOXno (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 19:43:44 -0400
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 16:43:42 PDT
Received: from npcomp.net (unknown [209.195.0.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1D377CE
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 16:43:42 -0700 (PDT)
Received: by npcomp.net (Postfix, from userid 1000)
        id E2096E2B75; Wed, 15 Jun 2022 23:26:00 +0000 ()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eldondev.com;
        s=eldondev; t=1655335560;
        bh=65+u0VFjb5yFDFDGuAeYoucW6tTnKNkojkvt0GvdMxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aFrGArFHn2kyDmrd3AO5JjNA+HSVyzrXpbSWJQXL5n0i+Tbe+QqUuZysKCfDnjCnR
         yJgfmv8CBlHXfp1o2EHPgo8CnE2OHZe+cHu+LazBuVQwjxTKfZUO6UAXj5KC6pUA09
         PYiqmqySNRKxTqixUBAIQhGkgwPVYenYXgGNXImc=
Date:   Wed, 15 Jun 2022 23:26:00 +0000
From:   Eldon <btrfs@eldondev.com>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <YqpqVSvxP8Dcz53V@invalid>
References: <20220610191156.GB1664812@merlins.org>
 <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org>
 <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org>
 <20220615145547.GQ22722@merlins.org>
 <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com>
 <20220615215314.GW1664812@merlins.org>
 <CAEzrpqfZMA=NjqAaS1XKZgguD5L73kc7zKFL+cVHnMGxdK6rXw@mail.gmail.com>
 <20220615232141.GX1664812@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615232141.GX1664812@merlins.org>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 15, 2022 at 04:21:41PM -0700, Marc MERLIN wrote:
> Sorry to everyone else following along, hopefully it was somewhat
> entertaining :)

You have no idea. Most entertaining thing this year. Popcorn, suspense,
joy, tragedy, redemption.

You really need to put out a tip jar or something.  ;D

Eldon
