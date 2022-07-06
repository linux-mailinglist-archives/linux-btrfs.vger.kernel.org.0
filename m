Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174C1568955
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiGFNYn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiGFNYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 09:24:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A3C1903B
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 06:24:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so27106744ejb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Jul 2022 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVzTHz8YirjKdnQLSCqf4aVhbsXtTkiCRpOeICGxpek=;
        b=Mh7Xwjh4stc2rrriL9rbTWPPbzoPq7TKkHltRI//xPwKrD49RoJAnqDAw8fUzp7IYC
         XBw3Jmw9nyb6tKQEpCEUk/Iv/j/xegEBVC+gWkxVW0GC2lQGd8wkA6eED65AZd0dKEjB
         FmchT0nDFAwdhPWUUIC5L9rHVoDNkmB22TXEDEIfU0/OvTu1xJL11jyKJaa6m47HabSg
         6r4hMkSug3yHakCpYDZE+X/SlJGCHu+mxwYNht09HFt4yGeWVdlceI7iSB+3dXf+/kkU
         Y1sjuvqZRrUcG99En+SnkKp6ENoXSQps2OTsHuhNe4tKwCG7WXr11QOZrsmBilgAr3Tn
         wgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVzTHz8YirjKdnQLSCqf4aVhbsXtTkiCRpOeICGxpek=;
        b=oUMiuOURjhjc09IYwE6+KE8FFLZn/eZ5GEEz2m44Z8FlOisoFMb3lrKw4diYzDYza+
         H31c2FOULcdb1FW0311gpHH+9ar7xKmIpzZuJcEBnSdmpnVVQbFsSu4LqabjMdRH/F9f
         EE0C794TsOACKGkjCbq1MHHVmrM7jHvw1ivM8cv6B6/euMo5a1TD8iIRiOpbOFQDuZ9B
         q7FLM/X/eZo7hMptbgIn5UIEHnOaYt6L14lOJbNPHEZo/OlNBfjEUQ/+qE69g2veg3it
         Xr6n8DoDKpubbWScjs/M6ryKQuJ428pclWZsvZjK4rQFjcxt53TRCnO41yC5VerFxUmR
         x05Q==
X-Gm-Message-State: AJIora8eq8sEyBGgjQcOO5PRuMPWRYMpO6MFSh441M0dkd1Yttgnp7Hl
        fozJulvjyYvKB0LTIcmb4LDeYYR9K1HrOuhgakx1NkUxbzKP3WvP
X-Google-Smtp-Source: AGRyM1sqvJEBiPwDWGX3P7lN3Hj3ikMxMz52+eTDKHycjrKAKQUwSZA/se+wlvE7/53lwv14b2ibW8KZhaIMMljc7hM=
X-Received: by 2002:a17:907:2d8b:b0:6da:b834:2f3e with SMTP id
 gt11-20020a1709072d8b00b006dab8342f3emr955656ejc.353.1657113879229; Wed, 06
 Jul 2022 06:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <36ad3a51-3629-06b0-2a04-a106bf571a91@xsec.at> <add2b9ba-831b-9cc6-7858-3938c33de78b@suse.com>
In-Reply-To: <add2b9ba-831b-9cc6-7858-3938c33de78b@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 6 Jul 2022 09:24:22 -0400
Message-ID: <CAJCQCtTN8RCyb_UyfwWYCKWLo81dirOWtgD8QZnYXmF=iOX=Zw@mail.gmail.com>
Subject: Re: lost page write due to IO error on [...]
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Nicolas Averesch <naveresch@xsec.at>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 6, 2022 at 8:18 AM Nikolay Borisov <nborisov@suse.com> wrote:

> > The error:
> >
> > [ 4027.385538] blk_update_request: I/O error, dev sdc, sector 36992 op
> > 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0

snip

> [ 4234.250280] blk_update_request: I/O error, dev sdd, sector 36992 op
> 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0

It's definitely happening in the block layer.  It's suspicious to get
the same write error on two drives just 200+ seconds apart at the same
LBA.
https://www.systutorials.com/docs/linux/man/9-blk_update_request/

It could be a firmware bug (in common) with the drives. It might be
there's a work around (or quirk) in a newer version of the kernel.

>Linux hostname 5.15.39-1-pve #1 SMP PVE 5.15.39-1 (Wed, 22 Jun 2022
17:22:00 +0200) x86_64 GNU/Linux

5.15.52 is current for that series, probably easiest to try it. If
not, try 5.18.9. If that still doesn't work, report it to the
linux-block@ list with make/model of the drive.



--
Chris Murphy
