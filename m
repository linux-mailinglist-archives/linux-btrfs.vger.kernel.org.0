Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B127D58A73C
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiHEHii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiHEHif (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 03:38:35 -0400
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A6821BEAA
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 00:38:34 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 1C70320D2A
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 16:38:34 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id c5-20020a17090a8d0500b001f559e228f4so2922549pjo.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 00:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc;
        bh=xWe27uqIT0fljSItrEI4Fqap+zCESH7NOXCw4w5ugfw=;
        b=BFLHczyzM8gqBMSI2Ma7lZuqds0DExyFTNm/qpsqKw2HFs6WgOSa24TLlNvyUTzugU
         dEkMtbRKy1jUw/wAycETIDJpPodoKCMz8/tAD964h0B37i7TY+/mdPmuSPudIuDKh+dw
         SNyjkqbU8fM7SjnccIXdrYb4BujxvX03upGAjZlxA5HDGkz6qDBTPPAt+yJPQE8xTTAo
         FP3lfBHZmDOiLFi7tgxi58wSaXvjp1PPQmRYZ52IYQ6bcVLwsivpt/kolj4l2PViySZ6
         SaV/44XzdQlNhawaWAZFkwjWPACTSB0a4uZROCl9ZK17V0wArkob1MwOwPXN5AJjAV/o
         872A==
X-Gm-Message-State: ACgBeo3iYRwnP9x5sg/W6ZPmJuVZukoxntGi/9dkfvGuld0cHwPyR/OM
        lWugT9oy0ms2WyEOWtr1wXya5cYQJVVdVZaJ3HzbcQmbmsQG438PLtVyT1Xc3eq0oBKfg8GsMFO
        CGJLQ7/khsLVa2bzqEhtqeen7
X-Received: by 2002:a17:90b:33c6:b0:1f4:f595:b0f1 with SMTP id lk6-20020a17090b33c600b001f4f595b0f1mr6431604pjb.230.1659685113105;
        Fri, 05 Aug 2022 00:38:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5k2z2lvH2E1PoDa0BMfWf9GdXqGSAAg0R0frfrYqS2Zz54wkAooasYp4JJ0aszQhL4HbD+SQ==
X-Received: by 2002:a17:90b:33c6:b0:1f4:f595:b0f1 with SMTP id lk6-20020a17090b33c600b001f4f595b0f1mr6431579pjb.230.1659685112798;
        Fri, 05 Aug 2022 00:38:32 -0700 (PDT)
Received: from pc-zest.atmarktech (145.82.198.104.bc.googleusercontent.com. [104.198.82.145])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b0016dcfedfe30sm2306749plx.90.2022.08.05.00.38.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Aug 2022 00:38:32 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1oJruh-007Pjr-1W;
        Fri, 05 Aug 2022 16:38:31 +0900
Date:   Fri, 5 Aug 2022 16:38:21 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Chen Liang-Chun <featherclc@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        kernel@openvz.org, Yu Kuai <yukuai3@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: fiemap is slow on btrfs on files with multiple extents
Message-ID: <YuzI7Tqi3n+d+V+P@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuwUw2JLKtIa9X+S@localhost.localdomain>
 <21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pavel Tikhomirov wrote on Thu, Aug 04, 2022 at 07:30:52PM +0300:
> I see a similar problem here
> https://lore.kernel.org/linux-btrfs/Yr4nEoNLkXPKcOBi@atmark-techno.com/#r ,
> but in my case I have "5.18.6-200.fc36.x86_64" fedora kernel which does not
> have 5ccc944dce3d ("filemap: Correct the conditions for marking a folio as
> accessed") commit, so it should be something else.

The root cause might be different but I guess they're related enough: if
fiemap gets faster enough even when the whole file is in cache I guess
that works for me :)

Josef Bacik wrote on Thu, Aug 04, 2022 at 02:49:39PM -0400:
> On Thu, Aug 04, 2022 at 07:30:52PM +0300, Pavel Tikhomirov wrote:
> > I ran the below test on Fedora 36 (the test basically creates "very" sparse
> > file, with 4k data followed by 4k hole again and again for the specified
> > length and uses fiemap to count extents in this file) and face the problem
> > that fiemap hangs for too long (for instance comparing to ext4 version).
> > Fiemap with 32768 extents takes ~37264 us and with 65536 extents it takes
> > ~34123954 us, which is x1000 times more when file only increased twice the
> > size:
> >
> 
> Ah that was helpful, thank you.  I think I've spotted the problem, please give
> this a whirl to make sure we're seeing the same thing.  Thanks,

FWIW this patch does help a tiny bit, but I'm still seeing a huge
slowdown: with patch cp goes from ~600MB/s (55s) to 136MB/s (3m55s) on
the second run; and without the patch I'm getting 47s and 5m35
respectively so this has gotten a bit better but these must still be
cases running through the whole list (e.g. when not hitting a hole?)


My reproducer is just running 'cp file /dev/null' twice on a file with
194955 extents (same file with mixed compressed & non-compressed extents
as last time), so should be close enough to what Pavel was describing in
just much worse.

-- 
Dominique
