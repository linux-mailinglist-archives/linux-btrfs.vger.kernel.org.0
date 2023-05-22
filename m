Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED770C2E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjEVQAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEVQAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 12:00:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46646B5;
        Mon, 22 May 2023 09:00:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso6914340e87.0;
        Mon, 22 May 2023 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684771245; x=1687363245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdQP7e6XI8muUkGCL2LzZvt7rBDHBRBcReLGBADbeO8=;
        b=jGM6H/jDYG1TfV4quO5mzoyolkUbR7QMpAIYT2ekDT3FeYIX8cHDzIXw18w15AJes/
         tnFC1egjdXR41zOzdY1to1izuSI2mDSZc/72L6cYiKvOuZIE32kpXW4BqEGSw7CqIIZG
         OhM6ZXV4BZ0nAwT68X8jHzCyMVyLl82aMDoDlssc+bBlHzQ0Umd3PpT9oWCJ5R5z2Hwt
         cLQzCvO7XVVBzg7hDrkYXCmSSMJCMAToF2owjpBbcWzeDSCvejbgq7pqzD9SS7Ov0TyL
         S747uJUiiKagW2sCvV8dwuLQIOjtwk3tWGi31qb7gWnmOsiz56Chi6kcSFj7NRJipWFU
         pqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684771245; x=1687363245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdQP7e6XI8muUkGCL2LzZvt7rBDHBRBcReLGBADbeO8=;
        b=bgs7yCdxHEhOaEf4hIcHoNATJ3KKek0Tt08/TqgMOQAZQDQustiZ1f+J34NHxg12Ro
         zls0Bsos0BSqRUzByN5LU+8b4AvKVJUVPEEO/jNmSJvNalzSXsGzXFGEJ0utdTxi5DSY
         D8WyawMppN357CJ2WfSvlzFl/OvmjPWnHZrZtLSMeVGPLzp56APLv4TGnt6QTUIWTMO6
         DZuaXpfXodXk+DRySOHKnJO4DtMs+uNe6GVtCaiPllsT2XhfDGSZOf3sxnJ/Nw/UL965
         0Ovfxx3/BoD72/c+2T4+CnFEcuerVgbaO4Hh3svu6Y08x0uiGQu5qCNHYqATI9olG06d
         R9lQ==
X-Gm-Message-State: AC+VfDwWN8yz5C1a+XY0UakPN0sR7rN2mZgqGnf+F/qpQIgz5MagB9Qh
        JxacF3+FZ4WCRzUdnlFqwUg=
X-Google-Smtp-Source: ACHHUZ7jZsWvnjAbwJpGb2QaXoef2dmzCHTIKokNvxU4Rgo8RYSD/pek1rzLKAR4HGgziXUQw3NIZA==
X-Received: by 2002:ac2:5f10:0:b0:4f3:aa73:562 with SMTP id 16-20020ac25f10000000b004f3aa730562mr3106198lfq.2.1684771245200;
        Mon, 22 May 2023 09:00:45 -0700 (PDT)
Received: from pc636 (host-90-235-19-70.mobileonline.telia.com. [90.235.19.70])
        by smtp.gmail.com with ESMTPSA id h26-20020a19701a000000b004ece331c830sm1022897lfc.206.2023.05.22.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:00:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 22 May 2023 18:00:42 +0200
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz
Subject: Re: Fwd: vmalloc error: btrfs-delalloc btrfs_work_helper [btrfs] in
 kernel 6.3.x
Message-ID: <ZGuRqtPkmeP07M6x@pc636>
References: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Hi,
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> > after updating from 6.2.x to 6.3.x, vmalloc error messages started to appear in the dmesg
> > 
> > 
> > 
> > # free 
> >                total        used        free      shared  buff/cache   available
> > Mem:        16183724     1473068      205664       33472    14504992    14335700
> > Swap:       16777212      703596    16073616
> > 
> > 
> > (zswap enabled)
> 
> See bugzilla for the full thread and attached dmesg.
> 
> On the report, the reporter can't perform the required bisection,
> unfortunately.
> 
> Anyway, I'm adding it to regzbot:
> 
> #regzbot introduced: v6.2..v6.3 https://bugzilla.kernel.org/show_bug.cgi?id=217466
> #regzbot title: btrfs_work_helper dealloc error in v6.3.x
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217466
> 
According to dmesg output from the bugzilla, the vmalloc tries to
allocate high order pages: 1 << 9. Since it fails to get a order-9 page
you get the warning:

<snip>
	if (area->nr_pages != nr_small_pages) {
		/* vm_area_alloc_pages() can also fail due to a fatal signal */
		if (!fatal_signal_pending(current))
			warn_alloc(gfp_mask, NULL,
				"vmalloc error: size %lu, page order %u, failed to allocate pages",
				area->nr_pages * PAGE_SIZE, page_order);
		goto fail;
	}
<snip>

and it fails.

If the __GFP_NOFAIL is passed, the vm_area_alloc_pages() function switches
to allocate 0-order pages instead. I think the fix is to call the
kvmalloc_node() with __GFP_NOFAIL flag.

--
Uladzislau Rezki
