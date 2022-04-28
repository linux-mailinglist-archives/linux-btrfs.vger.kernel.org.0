Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB8513CA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 22:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351808AbiD1UcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 16:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbiD1UcU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 16:32:20 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9296EC0D2C
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:29:05 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z18so7336304iob.5
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtcQtseXfIOdvkEOI6Y+I4CzIf+Y7cOp1ZtMT94xbKw=;
        b=t6RYMjaN1y9+SO2B+Eu9eKeqsqoRyo6CvkUOgcne/YvXYx3Bxz7BrnSMPFqNGRehfB
         Mfrau4wwo9NqBx3P+3uQp4wucFTyaq5tN6ZKGI32XvMy4r/G/Mh112MQ/rLQlTDl6Y6p
         kMSqGFl8gx6uxUPIA3QyBVdbU3thqilrqcHbWIZcB2FToFX/2VGCwcZV1ynSccNGCnQC
         tT7TpWYu+YspFEP2RvCta5WF8+E+Z/ESIZhGSmXYJOIubx46YmRxiW5vZMNPy/fudTvK
         lFWWYXi/CFld4IJDPbwpS0rrfoJuWODN4O5tJpRsOdE02lcrPZNOPQc8TlQeVZg7fpE0
         mqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtcQtseXfIOdvkEOI6Y+I4CzIf+Y7cOp1ZtMT94xbKw=;
        b=euUeVru7p1RvD+gOhZ1DWr52Q7+43TmA0wfhCAMqA1zh5fAblDmJZdCTeFTJ8aRIpC
         CzGSkqjP2dPfrUD4YLTt1qpF5NUnVUX+a5BJbIg/x9bSK+RQMdLHvE3Eo4mj7CzPkF+A
         wX/0Y8wTHqKKtjZefoTvWiiFfTeIxaSFKaE64miI+UeLnootnVJxJXnELBv+sTh9QH1H
         SuibSpxMLXVP8gp/GX7STOlqvHPhwG/levmgH3xpiXqib+zWNS4FFeSd/sUUmxf/h+Zh
         Pa+Fp6ovby6zrrCx+1aofLUHrJle2P1PxemUbVvxMUstfFjJjN0g2SQStAQOw01Tajut
         KAZA==
X-Gm-Message-State: AOAM533bjxycPjhkTlQcfZzeDFk/FDWgOIbudcSvDS+6QitU+xLNOX48
        mBJFKkAFFuHE7KjAT5NXcdwLfNQWRVzzrYzTtQ9PyF1gZ5w=
X-Google-Smtp-Source: ABdhPJye1EAHxwFtJ4kLS9by/BWzXrm+hQgbshlzR4elN6XVQpBKr3U96Qcr8Z3yR/oF9rIB5YAlRqPY0kjADiB4MxU=
X-Received: by 2002:a05:6638:2501:b0:32b:b8e:634d with SMTP id
 v1-20020a056638250100b0032b0b8e634dmr6305795jat.281.1651177744681; Thu, 28
 Apr 2022 13:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220428001822.GZ12542@merlins.org> <CAEzrpqcreWYV0VFD-F7_OeASuj=kbs-nN_L6L_Wt-eFVPKo2gw@mail.gmail.com>
 <20220428030002.GB12542@merlins.org> <CAEzrpqcXyHDnezAHtyFEk8smaCFG-320dLso6ynY=+cRz2fxqA@mail.gmail.com>
 <20220428031131.GO29107@merlins.org> <CAEzrpqeg+kk91jEzKTdsVXHJBvWhVJeCJ4voOAJnx-oPSqi-1w@mail.gmail.com>
 <20220428041245.GP29107@merlins.org> <CAEzrpqcJLgPqarv_ejmV2aqVkJvythz9sgEeqD+d_TEDeFMwUA@mail.gmail.com>
 <20220428162746.GR29107@merlins.org> <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org>
In-Reply-To: <20220428202205.GT29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 16:28:53 -0400
Message-ID: <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 4:22 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 04:13:31PM -0400, Josef Bacik wrote:
> > On Thu, Apr 28, 2022 at 12:27 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Thu, Apr 28, 2022 at 11:30:35AM -0400, Josef Bacik wrote:
> > > > Hell yes we're in the fs tree's now, in the home stretch hopefully.
> > > > I've pushed new debugging, you may have another overlapping extent.
> > > > I'm going to have to wire up a tool for that, but hopefully we can
> > > > just target delete a few things and get you up and running.  Thanks,
> > >
> > > Delete Xilinx_Unified_2020.1_0602_1208/tps/lnx64/jre9.0.4/lib/modules ?
> >
> > Cool, do
> >
> > ./btrfs-corrupt-block -d "3700677820416,168,53248" -r 11223 <device>
> >
> > Then you should be able to run the init-extent-tree and get past that
> > part.  Thanks,
>
> Sorry, I must be triggering every single unhandled path in the code :)
>

"Make recovery tools more resilient" is definitely muuuuuch higher on
the team priority list that's for fucking sure.  Try again please,
hopefully it works this time.  Thanks,

Josef
