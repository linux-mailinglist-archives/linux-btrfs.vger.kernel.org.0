Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2A63A42FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhFKN0G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:26:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38436 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFKN0G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:26:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8CB8721994;
        Fri, 11 Jun 2021 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623417847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoZe2Do+YjFfznb3FBAGTMrmvEaWFCHdUpFU1G49nbI=;
        b=DsPjPdR/cfZoznWMhaKw2jCReQocGLnq0vEnJz7X8/bGQYVgpxy7wp95U5fUoz1M7KM78/
        lO2UK4i5tLunQSK1zEYRN1rTnR+kGQ05PFOwnRnWD6Fd6xeLJGkm/Jf2XaAB9oJSQApAgB
        F2wxrLlTZqOTDKnNZkF7+OqUsTJI2GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623417847;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoZe2Do+YjFfznb3FBAGTMrmvEaWFCHdUpFU1G49nbI=;
        b=3WXO5EAErIRttTmkRzoLqskq1oqP9k1xWfNAPTGWce7kDcJB+FkFYeIsKAoU0vg9toUpFm
        f+ez2JLbfaxrODBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 661FAA3BBB;
        Fri, 11 Jun 2021 13:24:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 43475DA7A2; Fri, 11 Jun 2021 15:21:22 +0200 (CEST)
Date:   Fri, 11 Jun 2021 15:21:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Chris Mason <clm@fb.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Disable BTRFS on platforms having 256K pages
Message-ID: <20210611132121.GF28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <185278AF-1D87-432D-87E9-C86B3223113E@fb.com>
 <cdadf66e-0a6e-4efe-0326-7236c43b2735@csgroup.eu>
 <20210610162046.GB28158@suse.cz>
 <6769ED4C-15A8-4CFF-BF2B-26A5328257A0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6769ED4C-15A8-4CFF-BF2B-26A5328257A0@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 11, 2021 at 12:58:58PM +0000, Chris Mason wrote:
> > On Jun 10, 2021, at 12:20 PM, David Sterba <dsterba@suse.cz> wrote:
> > On Thu, Jun 10, 2021 at 04:50:09PM +0200, Christophe Leroy wrote:
> >> Le 10/06/2021 à 15:54, Chris Mason a écrit :
> >>>> On Jun 10, 2021, at 1:23 AM, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > And there's no such thing like "just bump BTRFS_MAX_COMPRESSED to 256K".
> > The constant is part of on-disk format for lzo and otherwise changing it
> > would impact performance so this would need proper evaluation.
> 
> Sorry, how is it baked into LZO?  It definitely will have performance implications, I agree there.

lzo_decompress_bio:

309         /*
310          * Compressed data header check.
311          *
312          * The real compressed size can't exceed the maximum extent length, and
313          * all pages should be used (whole unused page with just the segment
314          * header is not possible).  If this happens it means the compressed
315          * extent is corrupted.
316          */
317         if (tot_len > min_t(size_t, BTRFS_MAX_COMPRESSED, srclen) ||
318             tot_len < srclen - PAGE_SIZE) {
319                 ret = -EUCLEAN;
320                 goto done;
321         }
