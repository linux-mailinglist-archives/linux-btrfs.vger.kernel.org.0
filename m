Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B65617724
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 08:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKCHIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 03:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKCHIO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 03:08:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515664E3
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 00:08:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p21so1082208plr.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Nov 2022 00:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCGx+I//h802HOEchXeQ4l9Uif7TwqahE8c/QVCmorA=;
        b=Qo0pCYgx3Qq1H7gtsjTo9ahtaWGAPbAqpUUP7w83R+hioFcvnb/Vum4t6njrIqmCbQ
         9oglIFHFznb8HWDOhJ8VqGBZno5DvMa/i9rWqzvIS3F1Qe6lSOVMpDruWh58G2ZJDVRR
         +irGuRxsC3szEMLHnbBdSVWy+8gAtIi3/dsdlKShS4dWGsFcwevGYm9bbQNs76cqEy+l
         a7aTzEEQgFxLLhP1XqsxI1o93xRoLeyOkLszg3jyihUg4tqsI4qRKCp463KDJruVxcER
         uahSco4O56I/ia+N+pdnGxKbS5y4Jn6JIOipSvnU+FLMXl5F+IFO/pgiKOzrTt8rdoYE
         jcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCGx+I//h802HOEchXeQ4l9Uif7TwqahE8c/QVCmorA=;
        b=UZfc/i2aLq3J/uLA8spOdM0EuukDBdVImFD0W11MsDvjAiH6boMuAuAr4wHTk4id3v
         0IEQPRLgZWh/34VlkEFbnSdNwTuc7ZpNIrsuTvCsTFXMETgrDglpJUXZjGL/DxOALkMe
         tbiP5S+JQXYJVgzfkJXkQ/ipw4OduqH2kl78nxv639pFz/xNKk3i/+I4kECrliKFzeG7
         nKWHFW1aO1+2GZV+h2NYErNz12QB3oOnnGNnPNHlGLY+CASrFT2hxBL5oLindsfV7T9h
         XBmjCg+4mMaKxc/zC/GXm9zrlWpxPmnf8J1gkQsWp1WJWftE+r/TwywdV7UqksUarkCo
         ZSLQ==
X-Gm-Message-State: ACrzQf1DhuwWh5k6H6X+w4NBEY02E7XNYrGMZRP4avYOq0miwWgqBFpP
        bTFB28eQlK/GHph56nToib6Ifg==
X-Google-Smtp-Source: AMsMyM7EbTGuTativfwuYw+G5QrvaMpsSoYHAtMTN9boWfI/C7HSKjfDJIybcNCOqaRH/jY3hHhBSg==
X-Received: by 2002:a17:902:ed8e:b0:187:1c78:80c2 with SMTP id e14-20020a170902ed8e00b001871c7880c2mr21606400plj.38.1667459292279;
        Thu, 03 Nov 2022 00:08:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b00179e1f08634sm9438901plp.222.2022.11.03.00.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 00:08:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqUKd-009gYz-VX; Thu, 03 Nov 2022 18:08:08 +1100
Date:   Thu, 3 Nov 2022 18:08:07 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 00/23] Convert to filemap_get_folios_tag()
Message-ID: <20221103070807.GX2703033@dread.disaster.area>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 02, 2022 at 09:10:08AM -0700, Vishal Moola (Oracle) wrote:
> This patch series replaces find_get_pages_range_tag() with
> filemap_get_folios_tag(). This also allows the removal of multiple
> calls to compound_head() throughout.
> It also makes a good chunk of the straightforward conversions to folios,
> and takes the opportunity to introduce a function that grabs a folio
> from the pagecache.
> 
> F2fs and Ceph have quite a lot of work to be done regarding folios, so
> for now those patches only have the changes necessary for the removal of
> find_get_pages_range_tag(), and only support folios of size 1 (which is
> all they use right now anyways).
> 
> I've run xfstests on btrfs, ext4, f2fs, and nilfs2, but more testing may be
> beneficial. The page-writeback and filemap changes implicitly work. Testing
> and review of the other changes (afs, ceph, cifs, gfs2) would be appreciated.

Same question as last time: have you tested this with multipage
folios enabled? If you haven't tested XFS, then I'm guessing the
answer is no, and you haven't fixed the bug I pointed out in
the write_cache_pages() implementation....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
